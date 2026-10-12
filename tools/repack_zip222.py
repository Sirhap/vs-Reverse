#!/usr/bin/env python3
"""repack_zip222.py — rebuild DefineBinaryData id=222 assets ZIP for BVN 3.3.

Writes correct CRC32 in both local-file and central-directory headers so deng.fzip
can load the archive. Compression strategy defaults to the original archive:
  - STORE (0) for most SWF/PNG
  - DEFLATE (8) for the 55 original deflated members (mp3/xml/some png/swf/jpg)

Modes:
  rebuild   Walk an assets tree and write a new ZIP (strategy from --template).
  roundtrip Unpack template → rebuild from extract → compare members / optional bytes.
  patch     Copy template compressed blobs; replace named files from an overlay tree.

Outputs default under work/remake/repack/. Does NOT modify main.swf.
"""
from __future__ import annotations

import argparse
import io
import json
import shutil
import struct
import sys
import time
import zlib
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Tuple

# ZIP signatures / constants
SIG_LH = 0x04034B50
SIG_CD = 0x02014B50
SIG_EOCD = 0x06054B50
METHOD_STORE = 0
METHOD_DEFLATE = 8

ROOT = Path(__file__).resolve().parents[1]  # /workspace/bvn-3.3
DEFAULT_TEMPLATE = ROOT / "work/remake/repack/original_bin222.zip"
DEFAULT_ASSETS = ROOT / "extracted/full/zips/bin_222"
DEFAULT_EXPORT = ROOT / "work/remake/export/assets"
DEFAULT_OUT_DIR = ROOT / "work/remake/repack"


@dataclass
class EntryMeta:
    filename: str  # ZIP path, dirs end with /
    method: int
    crc: int
    usize: int
    csize: int
    date_time: Tuple[int, int, int, int, int, int]  # Y,M,D,h,m,s
    external_attr: int
    create_system: int
    create_version: int
    extract_version: int
    flag_bits: int
    comment: bytes
    extra: bytes  # local-file header extra
    cd_extra: bytes = b""  # central-directory extra (may differ from local)
    # Compressed payload as stored in original (raw deflate or store bytes)
    compressed: bytes = b""
    # Uncompressed content when available
    content: bytes = b""

    @property
    def is_dir(self) -> bool:
        return self.filename.endswith("/")


def _dos_time(dt: Tuple[int, int, int, int, int, int]) -> Tuple[int, int]:
    y, mo, d, h, mi, s = dt
    if y < 1980:
        y = 1980
    dost = ((h & 0x1F) << 11) | ((mi & 0x3F) << 5) | ((s // 2) & 0x1F)
    dosd = (((y - 1980) & 0x7F) << 9) | ((mo & 0x0F) << 5) | (d & 0x1F)
    return dost, dosd


def crc32(data: bytes) -> int:
    return zlib.crc32(data) & 0xFFFFFFFF


def deflate_raw(data: bytes, level: int = 9) -> bytes:
    """Raw DEFLATE (no zlib wrapper) — ZIP method 8 payload."""
    c = zlib.compressobj(level, zlib.DEFLATED, -15)
    return c.compress(data) + c.flush()


def inflate_raw(data: bytes, expected: Optional[int] = None) -> bytes:
    d = zlib.decompressobj(-15)
    out = d.decompress(data)
    if expected is not None and len(out) != expected:
        # try zlib-wrapped fallback
        try:
            out2 = zlib.decompress(data)
            if expected is None or len(out2) == expected:
                return out2
        except zlib.error:
            pass
        raise ValueError(f"inflate size {len(out)} != expected {expected}")
    return out


def parse_zip(path: Path) -> List[EntryMeta]:
    """Parse local headers in order (authoritative member order for fzip)."""
    data = path.read_bytes()
    entries: List[EntryMeta] = []
    off = 0
    while off + 30 <= len(data):
        sig = struct.unpack_from("<I", data, off)[0]
        if sig == SIG_CD or sig == SIG_EOCD:
            break
        if sig != SIG_LH:
            raise ValueError(f"bad local sig 0x{sig:08x} at {off}")
        (
            ver,
            flags,
            method,
            mt,
            md,
            crc,
            csize,
            usize,
            nlen,
            elen,
        ) = struct.unpack_from("<HHHHHIIIHH", data, off + 4)
        name = data[off + 30 : off + 30 + nlen]
        extra = data[off + 30 + nlen : off + 30 + nlen + elen]
        payload_off = off + 30 + nlen + elen
        # data descriptor / unknown sizes not used in BVN ZIP
        if flags & 0x08:
            raise ValueError(f"data descriptor not supported: {name!r}")
        compressed = data[payload_off : payload_off + csize]
        filename = name.decode("cp437", errors="replace")
        # DOS date/time → tuple
        sec = (mt & 0x1F) * 2
        mi = (mt >> 5) & 0x3F
        h = (mt >> 11) & 0x1F
        d = md & 0x1F
        mo = (md >> 5) & 0x0F
        y = ((md >> 9) & 0x7F) + 1980
        date_time = (y, mo, d, h, mi, sec)

        content = b""
        if not filename.endswith("/"):
            if method == METHOD_STORE:
                content = compressed
            elif method == METHOD_DEFLATE:
                content = inflate_raw(compressed, usize)
            else:
                raise ValueError(f"unsupported method {method} for {filename}")
            if usize and len(content) != usize:
                raise ValueError(f"usize mismatch {filename}: {len(content)}!={usize}")
            got = crc32(content) if content or usize == 0 else 0
            if usize == 0:
                got = 0
            elif got != crc:
                raise ValueError(
                    f"CRC mismatch in template {filename}: header={crc:08x} data={got:08x}"
                )

        entries.append(
            EntryMeta(
                filename=filename,
                method=method,
                crc=crc,
                usize=usize,
                csize=csize,
                date_time=date_time,
                external_attr=0,  # filled from CD below
                create_system=0,
                create_version=ver,  # local uses extract ver; CD may differ
                extract_version=ver,
                flag_bits=flags,
                comment=b"",
                extra=extra,
                compressed=compressed,
                content=content,
            )
        )
        off = payload_off + csize

    # Enrich from central directory
    eocd = data.rfind(b"PK\x05\x06")
    if eocd < 0:
        raise ValueError("EOCD not found")
    cd_off = struct.unpack_from("<I", data, eocd + 16)[0]
    cd_size = struct.unpack_from("<I", data, eocd + 12)[0]
    by_name = {e.filename: e for e in entries}
    pos = cd_off
    while pos < cd_off + cd_size:
        sig = struct.unpack_from("<I", data, pos)[0]
        if sig != SIG_CD:
            break
        (
            ver_made,
            ver_need,
            flags,
            method,
            mt,
            md,
            crc,
            csize,
            usize,
            nlen,
            elen,
            clen,
            _disk,
            _iattr,
            eattr,
            _loff,
        ) = struct.unpack_from("<HHHHHHIIIHHHHHII", data, pos + 4)
        name = data[pos + 46 : pos + 46 + nlen].decode("cp437", errors="replace")
        comment = data[pos + 46 + nlen + elen : pos + 46 + nlen + elen + clen]
        extra = data[pos + 46 + nlen : pos + 46 + nlen + elen]
        if name in by_name:
            e = by_name[name]
            e.external_attr = eattr
            e.create_system = (ver_made >> 8) & 0xFF
            e.create_version = ver_made & 0xFF
            e.extract_version = ver_need
            e.comment = comment
            e.cd_extra = extra
            # verify CRC consistency local↔central
            if e.crc != crc:
                raise ValueError(f"LH/CD CRC diverge for {name}: {e.crc:08x} vs {crc:08x}")
        pos += 46 + nlen + elen + clen

    return entries


def resolve_assets_root(assets: Optional[Path]) -> Path:
    if assets is not None:
        return assets
    # Prefer export symlink if it points at a real face tree
    exp = DEFAULT_EXPORT
    if exp.exists() and (exp / "face").exists():
        return exp.parent if (exp.name != "assets") else exp.parent
    # DEFAULT_ASSETS is bin_222 which already contains assets/
    return DEFAULT_ASSETS


def file_for_entry(assets_root: Path, filename: str) -> Path:
    """Map ZIP member name to filesystem path under assets_root.

    assets_root may be:
      - .../bin_222          (contains assets/)
      - .../export           (contains assets/ symlink)
      - .../export/assets    (the assets folder itself)
      - .../bin_222/assets   (assets folder itself)
    """
    name = filename
    if name.endswith("/"):
        name = name[:-1]
    candidates = [
        assets_root / name,
        assets_root / Path(name).name if "/" not in name.rstrip("/") else assets_root / name,
    ]
    # If root is already the assets/ directory, strip assets/ prefix
    if name.startswith("assets/"):
        candidates.append(assets_root / name[len("assets/") :])
        if assets_root.name == "assets":
            candidates.insert(0, assets_root / name[len("assets/") :])
    # Also try parent
    if assets_root.name == "assets":
        candidates.append(assets_root.parent / name)

    for c in candidates:
        if c.exists():
            return c
    # Return preferred path for error messages
    if assets_root.name == "assets" and name.startswith("assets/"):
        return assets_root / name[len("assets/") :]
    return assets_root / name


def build_entries_from_tree(
    template: List[EntryMeta],
    assets_root: Path,
    *,
    reuse_unchanged: bool = True,
    deflate_level: int = 9,
    overlay: Optional[Dict[str, Path]] = None,
) -> List[EntryMeta]:
    """Rebuild entry list: keep template order/method; refresh content from tree."""
    overlay = overlay or {}
    out: List[EntryMeta] = []
    for src in template:
        e = EntryMeta(
            filename=src.filename,
            method=src.method,
            crc=src.crc,
            usize=src.usize,
            csize=src.csize,
            date_time=src.date_time,
            external_attr=src.external_attr,
            create_system=src.create_system,
            create_version=src.create_version,
            extract_version=src.extract_version,
            flag_bits=src.flag_bits,
            comment=src.comment,
            extra=src.extra,
            cd_extra=src.cd_extra,
        )
        if e.is_dir:
            e.crc = 0
            e.usize = 0
            e.csize = 0
            e.compressed = b""
            e.content = b""
            out.append(e)
            continue

        # Resolve content
        if e.filename in overlay:
            content = overlay[e.filename].read_bytes()
        else:
            path = file_for_entry(assets_root, e.filename)
            if not path.is_file():
                raise FileNotFoundError(f"missing asset for {e.filename}: tried {path}")
            content = path.read_bytes()

        new_crc = crc32(content) if content else 0
        unchanged = (
            reuse_unchanged
            and content == src.content
            and new_crc == src.crc
            and len(content) == src.usize
        )
        if unchanged:
            e.content = src.content
            e.compressed = src.compressed
            e.crc = src.crc
            e.usize = src.usize
            e.csize = src.csize
            e.method = src.method
        else:
            e.content = content
            e.crc = new_crc
            e.usize = len(content)
            if e.method == METHOD_STORE:
                e.compressed = content
                e.csize = len(content)
            elif e.method == METHOD_DEFLATE:
                e.compressed = deflate_raw(content, deflate_level)
                e.csize = len(e.compressed)
            else:
                raise ValueError(f"unsupported method {e.method}")
            # extract_version: 20 for deflate, 10 for store (match original convention)
            if e.method == METHOD_DEFLATE:
                e.extract_version = max(e.extract_version, 20)
            else:
                e.extract_version = 10 if e.extract_version < 20 else e.extract_version
        out.append(e)
    return out


def write_zip(entries: List[EntryMeta], out_path: Path) -> dict:
    """Write ZIP with matching local + central CRC32."""
    out_path.parent.mkdir(parents=True, exist_ok=True)
    buf = io.BytesIO()
    offsets: List[int] = []

    for e in entries:
        offsets.append(buf.tell())
        name_b = e.filename.encode("cp437", errors="replace")
        extra = e.extra or b""
        dost, dosd = _dos_time(e.date_time)
        # Local header version = extract_version (as in original)
        ver = e.extract_version if e.extract_version else (20 if e.method == METHOD_DEFLATE else 10)
        buf.write(struct.pack("<I", SIG_LH))
        buf.write(
            struct.pack(
                "<HHHHHIIIHH",
                ver,
                e.flag_bits & 0xFFFF,
                e.method,
                dost,
                dosd,
                e.crc,
                e.csize,
                e.usize,
                len(name_b),
                len(extra),
            )
        )
        buf.write(name_b)
        buf.write(extra)
        buf.write(e.compressed)

    cd_start = buf.tell()
    for e, loff in zip(entries, offsets):
        name_b = e.filename.encode("cp437", errors="replace")
        extra = e.cd_extra if isinstance(e.cd_extra, (bytes, bytearray)) else (e.extra or b"")
        comment = e.comment or b""
        dost, dosd = _dos_time(e.date_time)
        ver_need = e.extract_version if e.extract_version else (20 if e.method == METHOD_DEFLATE else 10)
        # create_version in original is 63 (odd); preserve when present
        ver_made = ((e.create_system & 0xFF) << 8) | (e.create_version & 0xFF)
        if ver_made == 0:
            ver_made = (0 << 8) | 63
        buf.write(struct.pack("<I", SIG_CD))
        buf.write(
            struct.pack(
                "<HHHHHHIIIHHHHHII",
                ver_made,
                ver_need,
                e.flag_bits & 0xFFFF,
                e.method,
                dost,
                dosd,
                e.crc,  # MUST match local
                e.csize,
                e.usize,
                len(name_b),
                len(extra),
                len(comment),
                0,  # disk start
                0,  # internal attr
                e.external_attr,
                loff,
            )
        )
        buf.write(name_b)
        buf.write(extra)
        buf.write(comment)

    cd_size = buf.tell() - cd_start
    n = len(entries)
    buf.write(struct.pack("<I", SIG_EOCD))
    buf.write(struct.pack("<HHHHIIH", 0, 0, n, n, cd_size, cd_start, 0))

    raw = buf.getvalue()
    out_path.write_bytes(raw)

    store_n = sum(1 for e in entries if e.method == METHOD_STORE)
    defl_n = sum(1 for e in entries if e.method == METHOD_DEFLATE)
    return {
        "path": str(out_path),
        "bytes": len(raw),
        "members": n,
        "store": store_n,
        "deflate": defl_n,
        "sha256": _sha256(raw),
    }


def _sha256(data: bytes) -> str:
    import hashlib

    return hashlib.sha256(data).hexdigest()


def validate_zip(path: Path) -> dict:
    """Verify every local+central CRC matches inflated/store content."""
    entries = parse_zip(path)
    bad = []
    for e in entries:
        if e.is_dir:
            if e.crc != 0 or e.usize != 0:
                bad.append({"file": e.filename, "err": "dir non-zero size/crc"})
            continue
        if e.method == METHOD_STORE:
            content = e.compressed
        else:
            content = inflate_raw(e.compressed, e.usize)
        got = crc32(content) if content else 0
        if got != e.crc or len(content) != e.usize:
            bad.append(
                {
                    "file": e.filename,
                    "err": "crc/size",
                    "hdr_crc": f"{e.crc:08x}",
                    "data_crc": f"{got:08x}",
                    "usize": e.usize,
                    "got_len": len(content),
                }
            )
    return {
        "path": str(path),
        "members": len(entries),
        "ok": len(bad) == 0,
        "bad": bad,
    }


def compare_zips(a: Path, b: Path) -> dict:
    """Compare two ZIPs: byte identity, then per-member content/CRC/method."""
    ba = a.read_bytes()
    bb = b.read_bytes()
    byte_equal = ba == bb
    ea = {e.filename: e for e in parse_zip(a)}
    eb = {e.filename: e for e in parse_zip(b)}
    only_a = sorted(set(ea) - set(eb))
    only_b = sorted(set(eb) - set(ea))
    content_mismatch = []
    crc_mismatch = []
    method_mismatch = []
    for name in sorted(set(ea) & set(eb)):
        xa, xb = ea[name], eb[name]
        if xa.method != xb.method:
            method_mismatch.append(name)
        if xa.crc != xb.crc:
            crc_mismatch.append(name)
        if xa.content != xb.content:
            content_mismatch.append(name)
    content_equal = not only_a and not only_b and not content_mismatch and not method_mismatch
    order_a = [e.filename for e in parse_zip(a)]
    order_b = [e.filename for e in parse_zip(b)]
    return {
        "byte_equal": byte_equal,
        "bytes_a": len(ba),
        "bytes_b": len(bb),
        "content_equal": content_equal and not crc_mismatch,
        "order_equal": order_a == order_b,
        "only_a": only_a[:20],
        "only_b": only_b[:20],
        "content_mismatch": content_mismatch[:20],
        "crc_mismatch": crc_mismatch[:20],
        "method_mismatch": method_mismatch[:20],
        "members_a": len(ea),
        "members_b": len(eb),
    }


def ensure_original_template(template: Path) -> Path:
    """If template missing, carve DefineBinaryData id=222 ZIP from main.swf."""
    if template.exists() and template.stat().st_size > 1_000_000:
        return template
    swf = ROOT / "main.swf"
    # Known EOCD span from extract_full
    start, size = 526923, 65699574
    template.parent.mkdir(parents=True, exist_ok=True)
    with swf.open("rb") as f:
        f.seek(start)
        blob = f.read(size)
    if blob[:4] != b"PK\x03\x04":
        raise RuntimeError(f"SWF carve at {start} is not a ZIP")
    if len(blob) != size:
        raise RuntimeError(f"short read: {len(blob)} != {size}")
    template.write_bytes(blob)
    return template


def mark_png(src: Path, dst: Path, label: str = "B2") -> None:
    """Copy PNG and draw a visible mark (Pillow if present, else chunk inject / raw)."""
    dst.parent.mkdir(parents=True, exist_ok=True)
    try:
        from PIL import Image, ImageDraw, ImageFont

        im = Image.open(src).convert("RGBA")
        draw = ImageDraw.Draw(im)
        w, h = im.size
        # bright red corner band + text
        band = max(4, min(w, h) // 8)
        draw.rectangle([0, 0, w - 1, band], fill=(255, 0, 0, 220))
        draw.rectangle([0, 0, band, h - 1], fill=(255, 0, 0, 220))
        draw.rectangle([0, 0, w - 1, h - 1], outline=(255, 255, 0, 255), width=2)
        draw.text((band + 2, 2), label, fill=(255, 255, 0, 255))
        im.save(dst, format="PNG")
        return
    except Exception:
        pass
    # Fallback: copy bytes and append a tEXt chunk before IEND (keeps valid PNG, may not be visible)
    # Better fallback: overwrite a few mid-image IDAT bytes is unsafe. Use solid PPM→PNG via pure zlib? 
    # Simplest visible-ish fallback without PIL: write a tiny overlay by regenerating with struct PNG.
    raw = src.read_bytes()
    # Try shutil copy then note mark is metadata-only
    dst.write_bytes(raw)
    # Attempt minimal RGB redraw using only stdlib for small faces
    try:
        _stdlib_mark_png(src, dst, label)
    except Exception as ex:
        # keep copy; document limitation
        (dst.parent / (dst.name + ".mark-fallback.txt")).write_text(
            f"PIL unavailable; left original bytes. err={ex}\n", encoding="utf-8"
        )


def _stdlib_mark_png(src: Path, dst: Path, label: str) -> None:
    """Decode PNG via zlib IDAT (truecolor/indexed limited), paint red bar, re-encode."""
    import struct as st

    data = src.read_bytes()
    assert data[:8] == b"\x89PNG\r\n\x1a\n"
    pos = 8
    ihdr = None
    idats = []
    other_pre = []
    other_post = []
    seen_idat = False
    while pos < len(data):
        ln, typ = st.unpack_from(">I4s", data, pos)
        chunk = data[pos + 8 : pos + 8 + ln]
        pos += 12 + ln
        if typ == b"IHDR":
            ihdr = chunk
            other_pre.append((typ, chunk))
        elif typ == b"IDAT":
            seen_idat = True
            idats.append(chunk)
        elif typ == b"IEND":
            break
        elif not seen_idat:
            other_pre.append((typ, chunk))
        else:
            other_post.append((typ, chunk))
    if ihdr is None or not idats:
        raise RuntimeError("bad png")
    w, h, bit, ctype, comp, filt, inter = st.unpack(">IIBBBBB", ihdr)
    if inter != 0 or comp != 0 or bit != 8 or ctype not in (2, 6):
        raise RuntimeError(f"unsupported png {bit}/{ctype}/{inter}")
    raw = zlib.decompress(b"".join(idats))
    bpp = 3 if ctype == 2 else 4
    stride = 1 + w * bpp
    if len(raw) != stride * h:
        raise RuntimeError("png size")
    rows = [bytearray(raw[i * stride : (i + 1) * stride]) for i in range(h)]
    # undo filters → work on unfiltered, then re-filter as None
    def paeth(a, b, c):
        p = a + b - c
        pa, pb, pc = abs(p - a), abs(p - b), abs(p - c)
        if pa <= pb and pa <= pc:
            return a
        if pb <= pc:
            return b
        return c

    prev = bytearray(w * bpp)
    pixels = []
    for row in rows:
        f = row[0]
        cur = bytearray(row[1:])
        if f == 1:
            for i in range(len(cur)):
                left = cur[i - bpp] if i >= bpp else 0
                cur[i] = (cur[i] + left) & 255
        elif f == 2:
            for i in range(len(cur)):
                cur[i] = (cur[i] + prev[i]) & 255
        elif f == 3:
            for i in range(len(cur)):
                left = cur[i - bpp] if i >= bpp else 0
                up = prev[i]
                cur[i] = (cur[i] + ((left + up) // 2)) & 255
        elif f == 4:
            for i in range(len(cur)):
                left = cur[i - bpp] if i >= bpp else 0
                up = prev[i]
                ul = prev[i - bpp] if i >= bpp else 0
                cur[i] = (cur[i] + paeth(left, up, ul)) & 255
        elif f != 0:
            raise RuntimeError(f"filter {f}")
        pixels.append(cur)
        prev = cur
    band = max(2, min(w, h) // 8)
    for y in range(h):
        for x in range(w):
            if y < band or x < band:
                i = x * bpp
                pixels[y][i] = 255
                pixels[y][i + 1] = 0
                pixels[y][i + 2] = 0
                if bpp == 4:
                    pixels[y][i + 3] = 255
    # re-encode filter None
    out_rows = b"".join(bytes([0]) + bytes(r) for r in pixels)
    idat = zlib.compress(out_rows, 9)

    def chunk(typ: bytes, payload: bytes) -> bytes:
        return st.pack(">I", len(payload)) + typ + payload + st.pack(">I", crc32(typ + payload))

    out = bytearray(b"\x89PNG\r\n\x1a\n")
    for typ, payload in other_pre:
        out += chunk(typ, payload)
    out += chunk(b"IDAT", idat)
    for typ, payload in other_post:
        out += chunk(typ, payload)
    out += chunk(b"IEND", b"")
    dst.write_bytes(out)


def cmd_extract_template(args: argparse.Namespace) -> int:
    t = ensure_original_template(Path(args.template))
    print(f"template: {t} ({t.stat().st_size} bytes)")
    v = validate_zip(t)
    print(f"validate: ok={v['ok']} members={v['members']}")
    return 0 if v["ok"] else 1


def cmd_rebuild(args: argparse.Namespace) -> int:
    template_path = ensure_original_template(Path(args.template))
    assets = Path(args.assets) if args.assets else resolve_assets_root(None)
    # If user passed export/assets, OK; if bin_222, OK
    out = Path(args.out)
    meta = parse_zip(template_path)
    entries = build_entries_from_tree(
        meta,
        assets,
        reuse_unchanged=not args.no_reuse,
        deflate_level=args.level,
    )
    info = write_zip(entries, out)
    v = validate_zip(out)
    info["validate_ok"] = v["ok"]
    info["validate_bad"] = v["bad"]
    report = Path(args.report) if args.report else out.with_suffix(out.suffix + ".report.json")
    report.write_text(json.dumps(info, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(info, indent=2))
    return 0 if v["ok"] else 1


def cmd_roundtrip(args: argparse.Namespace) -> int:
    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    template_path = ensure_original_template(Path(args.template))
    assets = Path(args.assets) if args.assets else DEFAULT_ASSETS

    # 1) rebuild identical
    meta = parse_zip(template_path)
    entries = build_entries_from_tree(meta, assets, reuse_unchanged=True, deflate_level=args.level)
    rt_path = out_dir / "roundtrip_bin222.zip"
    info = write_zip(entries, rt_path)
    v = validate_zip(rt_path)
    cmp_ = compare_zips(template_path, rt_path)

    # 2) marked face
    face_name = args.face or "assets/face/naruto.png"
    # pick existing
    face_fs = file_for_entry(assets, face_name)
    if not face_fs.is_file():
        # try common
        for cand in ["assets/face/naruto.png", "assets/face/aizen.png", "assets/face/ichigo.png"]:
            p = file_for_entry(assets, cand)
            if p.is_file():
                face_name, face_fs = cand, p
                break
    marked_dir = out_dir / "overlay"
    marked_path = marked_dir / face_name
    mark_png(face_fs, marked_path, label="B2")
    overlay = {face_name: marked_path}
    entries2 = build_entries_from_tree(
        meta, assets, reuse_unchanged=True, deflate_level=args.level, overlay=overlay
    )
    marked_zip = out_dir / "marked_face_bin222.zip"
    info2 = write_zip(entries2, marked_zip)
    v2 = validate_zip(marked_zip)
    cmp2 = compare_zips(template_path, marked_zip)

    # content of marked entry must differ
    e_old = next(e for e in meta if e.filename == face_name)
    e_new = next(e for e in entries2 if e.filename == face_name)
    face_changed = e_old.content != e_new.content and e_old.crc != e_new.crc

    result = {
        "roundtrip": {
            "zip": str(rt_path),
            "write": info,
            "validate_ok": v["ok"],
            "compare": cmp_,
            "pass": bool(v["ok"] and cmp_["content_equal"] and (cmp_["byte_equal"] or cmp_["order_equal"])),
            "byte_equal": cmp_["byte_equal"],
        },
        "marked_face": {
            "member": face_name,
            "marked_png": str(marked_path),
            "zip": str(marked_zip),
            "write": info2,
            "validate_ok": v2["ok"],
            "face_changed": face_changed,
            "old_crc": f"{e_old.crc:08x}",
            "new_crc": f"{e_new.crc:08x}",
            "old_usize": e_old.usize,
            "new_usize": e_new.usize,
            "compare_vs_original": cmp2,
            "pass": bool(v2["ok"] and face_changed),
        },
    }
    # Strict PASS: roundtrip content+CRC equal (prefer byte_equal when reuse)
    rt_pass = bool(v["ok"] and cmp_["content_equal"] and cmp_["order_equal"])
    if args.require_bytes:
        rt_pass = rt_pass and cmp_["byte_equal"]
    result["roundtrip"]["pass"] = rt_pass
    result["overall_pass"] = rt_pass and result["marked_face"]["pass"]

    report = out_dir / "ROUNDTRIP-RESULT.json"
    report.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print("ROUNDTRIP:", "PASS" if rt_pass else "FAIL")
    print("MARKED:", "PASS" if result["marked_face"]["pass"] else "FAIL")
    print("OVERALL:", "PASS" if result["overall_pass"] else "FAIL")
    return 0 if result["overall_pass"] else 1


def cmd_validate(args: argparse.Namespace) -> int:
    v = validate_zip(Path(args.zip))
    print(json.dumps(v, indent=2))
    return 0 if v["ok"] else 1


def build_argparser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description="Repack BVN DefineBinaryData id=222 ZIP")
    sub = p.add_subparsers(dest="cmd", required=True)

    p0 = sub.add_parser("extract-template", help="Carve original ZIP from main.swf if needed")
    p0.add_argument("--template", default=str(DEFAULT_TEMPLATE))
    p0.set_defaults(func=cmd_extract_template)

    p1 = sub.add_parser("rebuild", help="Rebuild ZIP from assets tree")
    p1.add_argument("--template", default=str(DEFAULT_TEMPLATE))
    p1.add_argument("--assets", default="", help="bin_222 or export dir (contains assets/)")
    p1.add_argument("--out", default=str(DEFAULT_OUT_DIR / "repacked_bin222.zip"))
    p1.add_argument("--report", default="")
    p1.add_argument("--level", type=int, default=9)
    p1.add_argument("--no-reuse", action="store_true", help="Always recompress (no byte reuse)")
    p1.set_defaults(func=cmd_rebuild)

    p2 = sub.add_parser("roundtrip", help="Round-trip + marked-face test")
    p2.add_argument("--template", default=str(DEFAULT_TEMPLATE))
    p2.add_argument("--assets", default=str(DEFAULT_ASSETS))
    p2.add_argument("--out-dir", default=str(DEFAULT_OUT_DIR))
    p2.add_argument("--face", default="assets/face/naruto.png")
    p2.add_argument("--level", type=int, default=9)
    p2.add_argument("--require-bytes", action="store_true", help="Require byte-identical ZIP")
    p2.set_defaults(func=cmd_roundtrip)

    p3 = sub.add_parser("validate", help="Validate local+central CRC vs content")
    p3.add_argument("zip")
    p3.set_defaults(func=cmd_validate)

    return p


def main(argv: Optional[List[str]] = None) -> int:
    args = build_argparser().parse_args(argv)
    if getattr(args, "assets", None) == "":
        args.assets = None
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
