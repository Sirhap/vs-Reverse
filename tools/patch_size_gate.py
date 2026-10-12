#!/usr/bin/env python3
"""BVN size-gate patcher (Phase A1).

After any rebuild that changes main.swf length, three places must agree:
  1) SWF header FileLength  — UI32 little-endian at offset 4
  2) ASCII marker #XXXXXXXX — 8 hex digits (DoABC, typically @118927 on keep-shell builds)
  3) ASCII marker #XXXXXXX  — 7 hex digits ([Background], typically @2596)

Optionally sync play main.js embedded metas (base64) app.size["main.swf"].

Does NOT touch the original sample /workspace/bvn-3.3/main.swf unless you
pass that path explicitly (avoid that).

Usage
-----
  # Dry-run on a built SWF (report only):
  python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf --dry-run

  # Patch SWF in place + sync that game's main.js:
  python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf \\
      --main-js play/games/bvn-rev2/main.js

  # Verify three-way length agreement (exit 1 on mismatch):
  python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf \\
      --main-js play/games/bvn-rev2/main.js --verify

  # Write patched bytes to another path (leave input untouched):
  python3 tools/patch_size_gate.py build/_clean.swf -o play/games/bvn-x/main.swf \\
      --main-js play/games/bvn-x/main.js

Marker discovery
----------------
Finds ASCII gates by scanning for # + 7/8 hex whose parseInt equals the
current header FileLength and/or any other size-like gate already in the
file (50–150 MiB). Equal-length replacement preserves ABC string lengths
(Background length prefix and DoABC string pool).

See work/remake/SIZE-GATE.md and PERFECT-REMAKE-PLAN appendix A.
"""

from __future__ import annotations

import argparse
import base64
import json
import re
import struct
import sys
from pathlib import Path

# Plausible BVN main.swf size window for gate marker detection
SIZE_MIN = 50_000_000
SIZE_MAX = 150_000_000

# Fixed offsets observed on keep-shell rebuilds (import-rev2 / full-clean).
# Used as hints / fallback when scan finds them there; not required if scan hits.
HINT_OFF_7 = 2596
HINT_OFF_8 = 118927

RE_HEX8 = re.compile(rb"#[0-9a-fA-F]{8}(?![0-9a-fA-F])")
RE_HEX7 = re.compile(rb"#[0-9a-fA-F]{7}(?![0-9a-fA-F])")
RE_METAS = re.compile(
    r'Po\("\{\{metas\}\}",u\("([A-Za-z0-9+/=]+)"\)\)'
)


def read_file_length(data: bytes) -> int:
    if len(data) < 8 or data[:3] not in (b"FWS", b"CWS", b"ZWS"):
        raise ValueError("not an SWF (missing FWS/CWS/ZWS header)")
    return struct.unpack_from("<I", data, 4)[0]


def fmt_marker8(n: int) -> bytes:
    """'#%08x' — 9 bytes total (leading 0 when value fits in 7 hex digits)."""
    if n < 0 or n > 0xFFFFFFFF:
        raise ValueError(f"size out of UI32 range: {n}")
    return f"#{n:08x}".encode("ascii")


def fmt_marker7(n: int) -> bytes:
    """'#%07x' — 8 bytes total. Value must fit in 7 hex digits."""
    if n < 0 or n > 0xFFFFFFF:
        raise ValueError(
            f"size {n} needs >7 hex digits; cannot keep equal-length #XXXXXXX marker"
        )
    return f"#{n:07x}".encode("ascii")


def _parse_hash_hex(raw: bytes) -> int | None:
    if not raw.startswith(b"#"):
        return None
    try:
        return int(raw[1:].decode("ascii"), 16)
    except ValueError:
        return None


def find_gate_markers(data: bytes, ref_sizes: set[int]) -> tuple[list[tuple[int, bytes]], list[tuple[int, bytes]]]:
    """Return (markers8, markers7) as (offset, raw_bytes) lists."""
    m8: list[tuple[int, bytes]] = []
    for m in RE_HEX8.finditer(data):
        v = _parse_hash_hex(m.group())
        if v is not None and v in ref_sizes:
            m8.append((m.start(), m.group()))

    m7: list[tuple[int, bytes]] = []
    for m in RE_HEX7.finditer(data):
        v = _parse_hash_hex(m.group())
        if v is None or v not in ref_sizes:
            continue
        # Skip if this hit is the trailing 7 hex of an 8-hex marker (#0XXXXXXX)
        if m.start() > 0 and data[m.start() - 1 : m.start()] == b"#":
            # pattern always starts at '#'; not this case
            pass
        # If an 8-hex marker starts at same '#', the 7-hex regex won't match
        # (8th hex fails negative lookahead). Collect.
        m7.append((m.start(), m.group()))

    return m8, m7


def discover_ref_sizes(data: bytes) -> set[int]:
    """Header FileLength + any size-like #hex gates already present."""
    refs: set[int] = set()
    try:
        refs.add(read_file_length(data))
    except ValueError:
        pass
    refs.add(len(data))
    for rx, width in ((RE_HEX8, 8), (RE_HEX7, 7)):
        for m in rx.finditer(data):
            v = _parse_hash_hex(m.group())
            if v is not None and SIZE_MIN <= v <= SIZE_MAX:
                refs.add(v)
    return refs


def patch_swf(data: bytes, new_size: int | None = None) -> tuple[bytes, dict]:
    """Patch FileLength + both ASCII markers. Returns (new_bytes, report)."""
    if new_size is None:
        new_size = len(data)
    if new_size != len(data):
        raise ValueError(
            f"new_size {new_size} != buffer length {len(data)}; "
            "FileLength must equal disk bytes"
        )

    old_fl = read_file_length(data)
    refs = discover_ref_sizes(data)
    m8, m7 = find_gate_markers(data, refs)

    report: dict = {
        "disk_len": len(data),
        "old_file_length": old_fl,
        "new_file_length": new_size,
        "ref_sizes": sorted(refs),
        "markers8": [{"offset": o, "old": raw.decode("ascii")} for o, raw in m8],
        "markers7": [{"offset": o, "old": raw.decode("ascii")} for o, raw in m7],
        "hint_off_8": HINT_OFF_8,
        "hint_off_7": HINT_OFF_7,
    }

    if len(m8) != 1:
        raise ValueError(
            f"expected exactly one 8-hex size marker (#XXXXXXXX), found {len(m8)}: "
            f"{report['markers8']}"
        )
    if len(m7) != 1:
        raise ValueError(
            f"expected exactly one 7-hex size marker (#XXXXXXX), found {len(m7)}: "
            f"{report['markers7']}"
        )

    new8 = fmt_marker8(new_size)
    new7 = fmt_marker7(new_size)
    if len(new8) != len(m8[0][1]) or len(new7) != len(m7[0][1]):
        raise ValueError("internal: marker length mismatch")

    out = bytearray(data)
    struct.pack_into("<I", out, 4, new_size)
    off8, old8 = m8[0]
    off7, old7 = m7[0]
    out[off8 : off8 + len(new8)] = new8
    out[off7 : off7 + len(new7)] = new7

    report["markers8"][0]["new"] = new8.decode("ascii")
    report["markers7"][0]["new"] = new7.decode("ascii")
    report["file_length_patched"] = old_fl != new_size
    report["marker8_patched"] = old8 != new8
    report["marker7_patched"] = old7 != new7
    return bytes(out), report


def _b64decode_loose(s: str) -> bytes:
    pad = "=" * ((4 - len(s) % 4) % 4)
    return base64.b64decode(s + pad)


def _b64encode_nopad(raw: bytes) -> str:
    return base64.b64encode(raw).decode("ascii").rstrip("=")


def patch_main_js(js_text: str, swf_size: int, swf_name: str = "main.swf") -> tuple[str, dict]:
    """Update app.size[swf_name] inside Po(\"{{metas}}\",u(\"…\")) blob."""
    m = RE_METAS.search(js_text)
    if not m:
        raise ValueError('main.js: no Po("{{metas}}",u("…")) blob found')
    old_b64 = m.group(1)
    meta = json.loads(_b64decode_loose(old_b64).decode("utf-8"))
    old_size = None
    app_size = meta.get("app.size")
    if isinstance(app_size, dict):
        old_size = app_size.get(swf_name)
        app_size[swf_name] = swf_size
    else:
        meta["app.size"] = {swf_name: swf_size}
    flashframe = meta.get("app.flashframe")
    new_b64 = _b64encode_nopad(
        json.dumps(meta, ensure_ascii=False, separators=(",", ":")).encode("utf-8")
    )
    new_text = js_text[: m.start(1)] + new_b64 + js_text[m.end(1) :]
    return new_text, {
        "old_app_size": old_size,
        "new_app_size": swf_size,
        "app.flashframe": flashframe,
        "metas": meta,
        "b64_len_old": len(old_b64),
        "b64_len_new": len(new_b64),
    }


def read_main_js_metas(js_text: str) -> dict:
    m = RE_METAS.search(js_text)
    if not m:
        raise ValueError('main.js: no Po("{{metas}}",u("…")) blob found')
    return json.loads(_b64decode_loose(m.group(1)).decode("utf-8"))


def verify_agreement(swf_path: Path, main_js: Path | None) -> dict:
    data = swf_path.read_bytes()
    disk = len(data)
    fl = read_file_length(data)
    refs = discover_ref_sizes(data)
    m8, m7 = find_gate_markers(data, refs)
    info: dict = {
        "swf": str(swf_path),
        "disk": disk,
        "file_length": fl,
        "markers8": [(o, raw.decode()) for o, raw in m8],
        "markers7": [(o, raw.decode()) for o, raw in m7],
        "ok": True,
        "errors": [],
    }
    if fl != disk:
        info["ok"] = False
        info["errors"].append(f"FileLength {fl} != disk {disk}")
    if len(m8) != 1 or _parse_hash_hex(m8[0][1]) != disk:
        info["ok"] = False
        info["errors"].append(f"8-hex marker mismatch: {info['markers8']}")
    if len(m7) != 1 or _parse_hash_hex(m7[0][1]) != disk:
        info["ok"] = False
        info["errors"].append(f"7-hex marker mismatch: {info['markers7']}")
    if main_js is not None:
        meta = read_main_js_metas(main_js.read_text("utf-8"))
        app_size = (meta.get("app.size") or {}).get("main.swf")
        info["app.size"] = app_size
        info["app.flashframe"] = meta.get("app.flashframe")
        if app_size != disk:
            info["ok"] = False
            info["errors"].append(f'app.size["main.swf"] {app_size} != disk {disk}')
    return info


def print_report(report: dict, js_report: dict | None = None) -> None:
    print(f"disk_len          : {report['disk_len']}")
    print(f"FileLength old→new: {report['old_file_length']} → {report['new_file_length']}")
    for m in report["markers8"]:
        print(
            f"ASCII 8-hex       : @ {m['offset']} {m['old']} → {m.get('new', m['old'])}"
        )
    for m in report["markers7"]:
        print(
            f"ASCII 7-hex       : @ {m['offset']} {m['old']} → {m.get('new', m['old'])}"
        )
    if js_report is not None:
        print(
            f"main.js app.size  : {js_report.get('old_app_size')} → {js_report.get('new_app_size')}"
        )
        print(f"main.js flashframe: {js_report.get('app.flashframe')}")


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="Patch BVN SWF size gate (FileLength + #04236f9c/#4236f9c style) "
        "and optional main.js app.size."
    )
    ap.add_argument("swf", type=Path, help="Built SWF path (not the original sample)")
    ap.add_argument(
        "-o",
        "--output",
        type=Path,
        help="Write patched SWF here (default: in-place unless --dry-run)",
    )
    ap.add_argument(
        "--main-js",
        type=Path,
        help="Optional play main.js to sync app.size['main.swf'] metas",
    )
    ap.add_argument(
        "--dry-run",
        action="store_true",
        help="Report patches only; do not write files",
    )
    ap.add_argument(
        "--verify",
        action="store_true",
        help="Only verify FileLength/markers/app.size agree; exit 1 on mismatch",
    )
    args = ap.parse_args(argv)

    swf_path: Path = args.swf
    if not swf_path.is_file():
        print(f"error: SWF not found: {swf_path}", file=sys.stderr)
        return 2

    if args.verify:
        info = verify_agreement(swf_path, args.main_js)
        print(json.dumps(info, indent=2, ensure_ascii=False))
        return 0 if info["ok"] else 1

    data = swf_path.read_bytes()
    try:
        patched, report = patch_swf(data)
    except ValueError as e:
        print(f"error: {e}", file=sys.stderr)
        return 2

    js_report = None
    new_js = None
    if args.main_js is not None:
        if not args.main_js.is_file():
            print(f"error: main.js not found: {args.main_js}", file=sys.stderr)
            return 2
        try:
            new_js, js_report = patch_main_js(
                args.main_js.read_text("utf-8"), report["new_file_length"]
            )
        except ValueError as e:
            print(f"error: {e}", file=sys.stderr)
            return 2

    print_report(report, js_report)

    if args.dry_run:
        print("dry-run: no files written")
        return 0

    out_swf = args.output if args.output is not None else swf_path
    out_swf.parent.mkdir(parents=True, exist_ok=True)
    out_swf.write_bytes(patched)
    print(f"wrote SWF: {out_swf} ({len(patched)} bytes)")
    if new_js is not None and args.main_js is not None:
        args.main_js.write_text(new_js, encoding="utf-8")
        print(f"wrote main.js: {args.main_js}")

    # Post-write verify
    info = verify_agreement(out_swf, args.main_js if new_js is not None else None)
    if not info["ok"]:
        print("error: post-write verify failed:", info["errors"], file=sys.stderr)
        return 1
    print("verify: OK (FileLength == markers == disk"
          + (" == app.size" if args.main_js else "")
          + ")")
    return 0


if __name__ == "__main__":
    sys.exit(main())
