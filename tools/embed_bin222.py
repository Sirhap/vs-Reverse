#!/usr/bin/env python3
"""Embed a rebuilt assets ZIP into a *copy* of main.swf as DefineBinaryData id=222.

Never writes to the sample /workspace/bvn-3.3/main.swf unless --allow-original
is passed (discouraged). Prefer -o play/games/<build>/main.swf.

After a size-changing embed, run tools/patch_size_gate.py on the output.
"""
from __future__ import annotations

import argparse
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SAMPLE = ROOT / "main.swf"
TAG_DEFINE_BINARY_DATA = 87
DEFAULT_ID = 222


def find_binary_data(swf: bytes, character_id: int = DEFAULT_ID) -> dict:
    if swf[:3] not in (b"FWS", b"CWS", b"ZWS"):
        raise ValueError("not an SWF")
    pos = 8
    nbits = swf[pos] >> 3
    rect_bits = 5 + nbits * 4
    pos += (rect_bits + 7) // 8
    pos += 4
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
                return {
                    "tag_off": pos,
                    "hdr": hdr,
                    "length": length,
                    "cid": cid,
                    "payload_off": body + 6,
                    "payload_len": length - 6,
                    "next_off": body + length,
                }
        pos = body + length
    raise LookupError(f"DefineBinaryData id={character_id} not found")


def embed(swf_path: Path, zip_path: Path, out_path: Path, character_id: int = DEFAULT_ID) -> dict:
    swf = swf_path.read_bytes()
    zbytes = zip_path.read_bytes()
    if zbytes[:4] != b"PK\x03\x04":
        raise ValueError(f"{zip_path} is not a ZIP (missing PK header)")
    info = find_binary_data(swf, character_id)
    old_len = info["payload_len"]
    new_len = len(zbytes)
    new_tag_len = 6 + new_len  # UI16 id + UI32 reserved + payload

    if info["hdr"] != 6:
        raise RuntimeError("expected extended tag header for id=222")

    # Rebuild: prefix | tag hdr+id+reserved | new zip | suffix
    prefix = swf[: info["tag_off"]]
    # extended header: type<<6 | 0x3F, then UI32 length
    tag_hdr = struct.pack("<HI", (TAG_DEFINE_BINARY_DATA << 6) | 0x3F, new_tag_len)
    id_reserved = struct.pack("<HI", character_id, 0)
    suffix = swf[info["next_off"] :]
    out = prefix + tag_hdr + id_reserved + zbytes + suffix

    # Patch FileLength at offset 4
    out = bytearray(out)
    struct.pack_into("<I", out, 4, len(out))
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_bytes(out)

    return {
        "src_swf": str(swf_path),
        "zip": str(zip_path),
        "out": str(out_path),
        "character_id": character_id,
        "old_zip_bytes": old_len,
        "new_zip_bytes": new_len,
        "old_swf_bytes": len(swf),
        "new_swf_bytes": len(out),
        "delta": len(out) - len(swf),
        "size_gate_needed": len(out) != len(swf),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--swf", type=Path, default=SAMPLE, help="source SWF (read-only)")
    ap.add_argument("--zip", type=Path, required=True, help="repacked bin222 ZIP")
    ap.add_argument("-o", "--out", type=Path, required=True, help="output SWF path")
    ap.add_argument("--id", type=int, default=DEFAULT_ID)
    ap.add_argument(
        "--allow-original",
        action="store_true",
        help="permit writing over the sample main.swf (NOT recommended)",
    )
    args = ap.parse_args()

    out = args.out.resolve()
    sample = SAMPLE.resolve()
    if out == sample and not args.allow_original:
        print("Refusing to overwrite sample main.swf; pass --allow-original or use -o elsewhere", file=sys.stderr)
        return 2
    if args.swf.resolve() == sample and out == sample and not args.allow_original:
        print("Refusing to overwrite sample main.swf", file=sys.stderr)
        return 2

    info = embed(args.swf, args.zip, args.out, args.id)
    import json

    print(json.dumps(info, indent=2))
    if info["size_gate_needed"]:
        print(
            "\nNEXT: run size-gate on the output, e.g.\n"
            f"  python3 tools/patch_size_gate.py {args.out} --main-js <game>/main.js\n",
            file=sys.stderr,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
