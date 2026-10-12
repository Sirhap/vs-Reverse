#!/usr/bin/env python3
"""replace_ui_bin.py — replace one UI DefineBinaryData nested SWF in a *copy* of main.swf.

Phase D3 (G3): externalize demo path for UI BinaryData ids:
  225 common_ui, 226 fight, 227 gameover, 228 howtoplay, 229 loading,
  2210 select, 2211 setting, 2215 title

Never writes /workspace/bvn-3.3/main.swf unless --allow-original (discouraged).
After a size-changing replace, run tools/patch_size_gate.py on the output.

Examples:
  # Round-trip title (2215) into a demo copy (byte-identical payload → same FileLength)
  python3 tools/replace_ui_bin.py --id 2215 \\
    --swf play/games/bvn-rev2/main.swf \\
    --ui-swf extracted/full/swf/bin_2215.swf \\
    -o play/games/bvn-perfect-ui-demo/main.swf

  # Same for loading (229)
  python3 tools/replace_ui_bin.py --id 229 --name loading ...
"""
from __future__ import annotations

import argparse
import hashlib
import json
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAMPLE = ROOT / "main.swf"
TAG_DEFINE_BINARY_DATA = 87

UI_IDS = {
    "common_ui": 225,
    "fight": 226,
    "gameover": 227,
    "howtoplay": 228,
    "loading": 229,
    "select": 2210,
    "setting": 2211,
    "title": 2215,
}
ID_TO_NAME = {v: k for k, v in UI_IDS.items()}


def find_binary_data(swf: bytes, character_id: int) -> dict:
    if swf[:3] not in (b"FWS", b"CWS", b"ZWS"):
        raise ValueError("not an SWF")
    pos = 8
    nbits = swf[pos] >> 3
    rect_bits = 5 + nbits * 4
    pos += (rect_bits + 7) // 8
    pos += 4  # frameRate + frameCount
    while pos + 2 <= len(swf):
        code_len = struct.unpack_from("<H", swf, pos)[0]
        tag_type = code_len >> 6
        length = code_len & 0x3F
        hdr = 2
        if length == 0x3F:
            if pos + 6 > len(swf):
                break
            length = struct.unpack_from("<I", swf, pos + 2)[0]
            hdr = 6
        body = pos + hdr
        if tag_type == 0:
            break
        if tag_type == TAG_DEFINE_BINARY_DATA and length >= 6:
            cid = struct.unpack_from("<H", swf, body)[0]
            if cid == character_id:
                reserved = struct.unpack_from("<I", swf, body + 2)[0]
                return {
                    "tag_off": pos,
                    "hdr": hdr,
                    "length": length,
                    "cid": cid,
                    "reserved": reserved,
                    "payload_off": body + 6,
                    "payload_len": length - 6,
                    "next_off": body + length,
                }
        pos = body + length
    raise LookupError(f"DefineBinaryData id={character_id} not found")


def replace_ui_bin(
    swf_path: Path,
    ui_swf_path: Path,
    out_path: Path,
    character_id: int,
) -> dict:
    swf = swf_path.read_bytes()
    payload = ui_swf_path.read_bytes()
    if payload[:3] not in (b"FWS", b"CWS", b"ZWS"):
        raise ValueError(f"{ui_swf_path} does not look like a SWF")
    info = find_binary_data(swf, character_id)
    if info["hdr"] != 6:
        raise RuntimeError(f"expected extended tag header for id={character_id}")

    old_len = info["payload_len"]
    new_len = len(payload)
    new_tag_len = 6 + new_len  # UI16 id + UI32 reserved + payload

    prefix = swf[: info["tag_off"]]
    tag_hdr = struct.pack("<HI", (TAG_DEFINE_BINARY_DATA << 6) | 0x3F, new_tag_len)
    id_reserved = struct.pack("<HI", character_id, info["reserved"])
    suffix = swf[info["next_off"] :]
    out = bytearray(prefix + tag_hdr + id_reserved + payload + suffix)
    struct.pack_into("<I", out, 4, len(out))

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_bytes(out)

    old_sha = hashlib.sha256(swf[info["payload_off"] : info["payload_off"] + old_len]).hexdigest()
    new_sha = hashlib.sha256(payload).hexdigest()
    return {
        "src_swf": str(swf_path),
        "ui_swf": str(ui_swf_path),
        "out": str(out_path),
        "character_id": character_id,
        "ui_name": ID_TO_NAME.get(character_id, "?"),
        "old_payload_bytes": old_len,
        "new_payload_bytes": new_len,
        "old_payload_sha256": old_sha,
        "new_payload_sha256": new_sha,
        "payload_unchanged": old_sha == new_sha and old_len == new_len,
        "old_swf_bytes": len(swf),
        "new_swf_bytes": len(out),
        "delta": len(out) - len(swf),
        "size_gate_needed": len(out) != len(swf),
        "out_sha256": hashlib.sha256(out).hexdigest(),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--swf", type=Path, default=SAMPLE, help="source SWF (read; default sample)")
    ap.add_argument("--ui-swf", type=Path, required=True, help="replacement nested UI .swf bytes")
    ap.add_argument("-o", "--out", type=Path, required=True, help="output SWF path (copy)")
    g = ap.add_mutually_exclusive_group(required=True)
    g.add_argument("--id", type=int, choices=sorted(UI_IDS.values()), help="DefineBinaryData character id")
    g.add_argument("--name", choices=sorted(UI_IDS.keys()), help="UI logical name")
    ap.add_argument("--json", type=Path, help="optional result JSON path")
    ap.add_argument(
        "--allow-original",
        action="store_true",
        help="permit writing over the sample main.swf (NOT recommended)",
    )
    args = ap.parse_args()
    character_id = args.id if args.id is not None else UI_IDS[args.name]

    out = args.out.resolve()
    sample = SAMPLE.resolve()
    if out == sample and not args.allow_original:
        print("Refusing to overwrite sample main.swf; pass --allow-original or use -o elsewhere", file=sys.stderr)
        return 2

    result = replace_ui_bin(args.swf, args.ui_swf, out, character_id)
    print(json.dumps(result, indent=2))
    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    if result["size_gate_needed"]:
        print(
            "NOTE: size changed — run: python3 tools/patch_size_gate.py "
            f"{out} --main-js <build>/main.js",
            file=sys.stderr,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
