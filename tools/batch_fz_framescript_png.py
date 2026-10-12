#!/usr/bin/env python3
"""Export addFrameScript keyframe PNGs for the 22 no-label fz assists.

Reads work/remake/assist/<id>.frames.json frameNumber list (cap ≤15),
expands displayRect on a temp SWF copy, FFDec -export frame with zoom,
auto-crops into work/remake/export/_frames/fz/<id>/framescript/.

Does NOT modify source fz/*.swf or main.swf.
"""
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

ROOT = Path(__file__).resolve().parents[1]
EXPORT = ROOT / "work" / "remake" / "export"
ASSIST = ROOT / "work" / "remake" / "assist"
FZ_ASSETS = EXPORT / "assets" / "fighter" / "fz"
FZ_FRAMES = EXPORT / "_frames" / "fz"
FFDEC = Path("/workspace/tools/ffdec/ffdec-cli.jar")
SUMMARY_PATH = FZ_FRAMES / "FRAMESCRIPT-SUMMARY.json"
MAP_MD = ASSIST / "NO-LABEL-FRAME-MAP.md"

FZ_FRAME_ZOOM = 15
FZ_DISPLAYRECT = "[-80px,-120px,80px,40px]"
MAX_FRAMES = 15
CST = ZoneInfo("Asia/Shanghai")


def discover_ids() -> list[str]:
    ids = sorted(p.stem.replace(".frames", "") for p in ASSIST.glob("*.frames.json"))
    # stem is like "sai.frames" if pattern wrong — use stem of "*.frames.json"
    ids = sorted(p.name[: -len(".frames.json")] for p in ASSIST.glob("*.frames.json"))
    return ids


def load_frames(aid: str) -> tuple[list[int], dict]:
    path = ASSIST / f"{aid}.frames.json"
    data = json.loads(path.read_text(encoding="utf-8"))
    nums = [int(f["frameNumber"]) for f in data.get("frames") or []]
    # preserve order, unique, cap ≤15
    seen: set[int] = set()
    capped: list[int] = []
    for n in nums:
        if n in seen:
            continue
        seen.add(n)
        capped.append(n)
        if len(capped) >= MAX_FRAMES:
            break
    return capped, data


def count_pngs(out_dir: Path) -> int:
    if not out_dir.is_dir():
        return 0
    return sum(1 for p in out_dir.glob("*.png") if p.is_file())


def crop_frame_pngs(out_dir: Path) -> int:
    try:
        from PIL import Image
    except ImportError:
        return count_pngs(out_dir)
    pngs = sorted(out_dir.glob("*.png"), key=lambda p: int(p.stem) if p.stem.isdigit() else p.stem)
    if not pngs:
        return 0
    boxes = []
    images = []
    for p in pngs:
        im = Image.open(p).convert("RGBA")
        images.append((p, im))
        b = im.getbbox()
        if b:
            boxes.append(b)
    if boxes:
        x0 = min(b[0] for b in boxes)
        y0 = min(b[1] for b in boxes)
        x1 = max(b[2] for b in boxes)
        y1 = max(b[3] for b in boxes)
        pad = 4
        x0 = max(0, x0 - pad)
        y0 = max(0, y0 - pad)
        for p, im in images:
            if im.getbbox():
                im.crop((x0, y0, min(im.width, x1 + pad), min(im.height, y1 + pad))).save(p)
            else:
                w = min(im.width, x1 + pad) - x0
                h = min(im.height, y1 + pad) - y0
                Image.new("RGBA", (max(1, w), max(1, h)), (0, 0, 0, 0)).save(p)
    return count_pngs(out_dir)


def export_one(aid: str, *, dry_run: bool = False) -> dict:
    frames, data = load_frames(aid)
    swf = FZ_ASSETS / f"{aid}.swf"
    out = FZ_FRAMES / aid / "framescript"
    result = {
        "id": aid,
        "stem": f"fz/{aid}",
        "mode": "framescript+zoom",
        "frames": frames,
        "frame_count_map": len(data.get("frames") or []),
        "rootFrames": data.get("rootFrames"),
        "expected_pngs": len(frames),
        "out": str(out.relative_to(EXPORT)),
        "ok": False,
        "png_count": 0,
        "capped": len(data.get("frames") or []) > MAX_FRAMES,
    }
    if not frames:
        result["error"] = "no frames in frames.json"
        return result
    if not swf.is_file():
        result["error"] = f"missing SWF: {swf}"
        return result
    select = ",".join(str(n) for n in frames)
    if dry_run:
        result["ok"] = True
        result["dry_run"] = True
        result["select"] = select
        return result

    out.mkdir(parents=True, exist_ok=True)
    for child in list(out.iterdir()):
        if child.is_file() and child.suffix.lower() == ".png":
            child.unlink()

    with tempfile.TemporaryDirectory(prefix=f"fz_fs_{aid}_") as td:
        tmp_swf = Path(td) / f"{aid}.swf"
        hdr = [
            "java", "-jar", str(FFDEC),
            "-header", "-set", "displayrect", FZ_DISPLAYRECT,
            str(swf), str(tmp_swf),
        ]
        proc_h = subprocess.run(hdr, capture_output=True, text=True)
        if proc_h.returncode != 0 or not tmp_swf.is_file():
            result["returncode"] = proc_h.returncode
            result["stderr_tail"] = (proc_h.stderr or proc_h.stdout or "")[-500:]
            result["error"] = "displayrect rewrite failed"
            return result
        cmd = [
            "java", "-jar", str(FFDEC),
            "-zoom", str(FZ_FRAME_ZOOM),
            "-format", "frame:png",
            "-select", select,
            "-ignorebackground",
            "-export", "frame",
            str(out),
            str(tmp_swf),
        ]
        result["cmd"] = " ".join(cmd)
        proc = subprocess.run(cmd, capture_output=True, text=True)
        result["returncode"] = proc.returncode
        result["stderr_tail"] = (proc.stderr or proc.stdout or "")[-500:]
        # Keep only requested frame filenames (FFDec names by frame number)
        kept = 0
        want = {str(n) for n in frames}
        for p in list(out.glob("*.png")):
            if p.stem not in want:
                p.unlink()
            else:
                kept += 1
        result["png_count"] = crop_frame_pngs(out)
        result["ok"] = proc.returncode == 0 and result["png_count"] > 0
        result["kept_before_crop"] = kept
    return result


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("ids", nargs="*", help="assist ids (default: all *.frames.json)")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--list", action="store_true")
    args = ap.parse_args()

    if not FFDEC.is_file():
        print(f"ERROR: FFDec not found: {FFDEC}", file=sys.stderr)
        return 2

    ids = list(args.ids) if args.ids else discover_ids()
    if args.list:
        for aid in ids:
            frames, data = load_frames(aid)
            print(f"{aid}: {len(frames)}/{len(data.get('frames') or [])} frames {frames}")
        print(f"total: {len(ids)}")
        return 0

    rows = []
    for aid in ids:
        try:
            row = export_one(aid, dry_run=args.dry_run)
        except Exception as e:  # noqa: BLE001
            row = {"id": aid, "stem": f"fz/{aid}", "ok": False, "error": str(e), "png_count": 0}
        rows.append(row)
        status = "OK" if row.get("ok") else "FAIL"
        extra = row.get("error") or (
            f"frames={row.get('frames')} pngs={row.get('png_count')}"
            + (" capped" if row.get("capped") else "")
        )
        print(f"[{status}] fz/{aid}: {extra}")

    ok_n = sum(1 for r in rows if r.get("ok"))
    total_png = sum(int(r.get("png_count") or 0) for r in rows)
    now = datetime.now(CST).strftime("%Y-%m-%d %H:%M:%S CST")
    summary = {
        "generated": now,
        "tool": "tools/batch_fz_framescript_png.py",
        "max_frames": MAX_FRAMES,
        "zoom": FZ_FRAME_ZOOM,
        "displayrect": FZ_DISPLAYRECT,
        "ok": ok_n,
        "total": len(rows),
        "png_total": total_png,
        "map": str(MAP_MD.relative_to(ROOT)),
        "results": rows,
    }
    if not args.dry_run:
        SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
        SUMMARY_PATH.write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(f"Summary: {SUMMARY_PATH}")
    print(f"\nDone: {ok_n}/{len(rows)} assists, {total_png} PNGs → {FZ_FRAMES}/<id>/framescript/")
    return 0 if ok_n == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())
