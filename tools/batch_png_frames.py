#!/usr/bin/env python3
"""Batch-export a small PNG frame range from fighter/assist action sprites via FFDec.

Reads actionSpriteId + first labeled span (default 站立) from
work/remake/export/_meta/fighter/<stem>/framelabel-slices.json and runs:

  java -jar ffdec-cli.jar -format sprite:png -selectid ID -select ID:start-end
       -ignorebackground -export sprite OUT SWF

Default: playable top-level fighters under assets/fighter/*.swf.
With --fz: assists under assets/fighter/fz/*.swf that HAVE FrameLabel meta
(skips the 22 no-label assists in _meta/fighter/NO-LABELS.md).
MainTimeline assists (actionSpriteId=0) export root frames via a temp SWF with
expanded displayRect + zoom, then auto-crop. Does NOT touch main.swf.
"""
from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]  # /workspace/bvn-3.3
EXPORT = ROOT / "work" / "remake" / "export"
META = EXPORT / "_meta" / "fighter"
ASSETS = EXPORT / "assets" / "fighter"
FRAMES = EXPORT / "_frames"
FFDEC = Path("/workspace/tools/ffdec/ffdec-cli.jar")
SUMMARY_PATH = FRAMES / "BATCH-SUMMARY.json"

# First-wave sample set (already exported); skipped by default when discovering all.
DONE_FIGHTERS = [
    "ichigo",
    "rukia",
    "sasuke",
    "naruto",
    "kakashi",
    "itachi",
    "sakura",
    "orihime",
]

# Back-compat alias for callers/docs that referenced DEFAULT_FIGHTERS.
DEFAULT_FIGHTERS = list(DONE_FIGHTERS)

# Prefer standing idle; cap at 15 so a slightly longer 站立 still fits sample size.
DEFAULT_MAX_FRAMES = 15

# Assists with FrameLabel live under _meta/fighter/fz/<id>/; no-label list is skipped.
NO_LABELS_PATH = META / "NO-LABELS.md"
FZ_ASSETS = ASSETS / "fz"
FZ_FRAMES = FRAMES / "fz"
FZ_META = META / "fz"
# Main timeline assists render ~30px tall on a 1x1 stage; zoom for readable samples.
FZ_FRAME_ZOOM = 15
FZ_DISPLAYRECT = "[-80px,-120px,80px,40px]"


def discover_playable() -> list[str]:
    """Top-level assets/fighter/*.swf stems (excludes fz/ assists)."""
    if not ASSETS.is_dir():
        return []
    stems = sorted(p.stem for p in ASSETS.glob("*.swf") if p.is_file())
    return stems


def load_meta(stem: str) -> dict:
    path = META / stem / "framelabel-slices.json"
    if not path.is_file():
        raise FileNotFoundError(f"missing meta: {path}")
    return json.loads(path.read_text(encoding="utf-8"))


def resolve_range(meta: dict, label: str | None, max_frames: int) -> tuple[int, int, str]:
    slices = meta.get("slices") or []
    chosen = None
    if label:
        for s in slices:
            if s.get("label") == label:
                chosen = s
                break
        if chosen is None:
            raise ValueError(f"label {label!r} not found; have {[s.get('label') for s in slices[:12]]}")
    else:
        # prefer 站立, else first slice, else frames 1..max_frames
        for s in slices:
            if s.get("label") == "站立":
                chosen = s
                break
        if chosen is None and slices:
            chosen = slices[0]

    if chosen:
        start = int(chosen["start_frame"])
        end = int(chosen["end_frame"])
        name = str(chosen.get("label") or "span")
    else:
        start, end, name = 1, max_frames, "1-N"

    if end < start:
        end = start
    count = end - start + 1
    # Standing sample: keep full span if ≤ max_frames; else first max_frames (typically 1-9).
    if count > max_frames:
        end = start + max_frames - 1
        count = max_frames
    return start, end, name


def count_pngs(out_dir: Path) -> int:
    if not out_dir.is_dir():
        return 0
    return sum(1 for p in out_dir.rglob("*.png") if p.is_file())


def already_sampled(stem: str) -> bool:
    """True if _frames/<stem> already has PNGs or meta marks sample_ok."""
    if count_pngs(FRAMES / stem) > 0:
        return True
    try:
        meta = load_meta(stem)
    except FileNotFoundError:
        return False
    status = (meta.get("png_frames") or {}).get("status")
    return status == "sample_ok"


def export_one(
    stem: str,
    *,
    label: str | None,
    max_frames: int,
    dry_run: bool,
) -> dict:
    meta = load_meta(stem)
    sprite = meta.get("actionSpriteId")
    if sprite is None:
        raise ValueError(f"{stem}: no actionSpriteId")
    sprite = int(sprite)
    start, end, span_name = resolve_range(meta, label, max_frames)
    swf = ASSETS / f"{stem}.swf"
    if not swf.is_file():
        raise FileNotFoundError(f"missing SWF: {swf}")
    out = FRAMES / stem
    select = f"{sprite}:{start}-{end}"
    cmd = [
        "java",
        "-jar",
        str(FFDEC),
        "-format",
        "sprite:png",
        "-selectid",
        str(sprite),
        "-select",
        select,
        "-ignorebackground",
        "-export",
        "sprite",
        str(out),
        str(swf),
    ]
    result = {
        "stem": stem,
        "actionSpriteId": sprite,
        "label": span_name,
        "start": start,
        "end": end,
        "expected_frames": end - start + 1,
        "out": str(out.relative_to(EXPORT)),
        "cmd": " ".join(cmd),
        "ok": False,
        "png_count": 0,
    }
    if dry_run:
        result["ok"] = True
        result["dry_run"] = True
        return result

    out.mkdir(parents=True, exist_ok=True)
    # clear previous sprite dumps for this stem to avoid stale counts
    for child in list(out.iterdir()):
        if child.is_dir() and child.name.startswith("DefineSprite_"):
            for p in child.rglob("*"):
                if p.is_file():
                    p.unlink()
            # leave empty dirs; ffdec will rewrite

    proc = subprocess.run(cmd, capture_output=True, text=True)
    result["returncode"] = proc.returncode
    result["stderr_tail"] = (proc.stderr or proc.stdout or "")[-500:]
    result["png_count"] = count_pngs(out)
    result["ok"] = proc.returncode == 0 and result["png_count"] > 0

    # update meta png_frames note (non-destructive status)
    try:
        meta["png_frames"] = {
            "status": "sample_ok" if result["ok"] else "failed",
            "dir": f"_frames/{stem}/",
            "actionSpriteId": sprite,
            "label": span_name,
            "range": f"{start}-{end}",
            "png_count": result["png_count"],
            "tool": "tools/batch_png_frames.py",
            "ffdec": str(FFDEC),
        }
        notes = meta.get("notes") or []
        note = "PNG sample export via FFDec (batch_png_frames.py)."
        if note not in notes:
            # drop deferred note if present
            notes = [n for n in notes if "PNG frame dump deferred" not in n]
            notes.append(note)
            meta["notes"] = notes
        for s in meta.get("slices") or []:
            if s.get("label") == span_name and int(s.get("start_frame", -1)) == start:
                s["png_export"] = {
                    "dir": f"_frames/{stem}/",
                    "range": f"{start}-{end}",
                    "count": result["png_count"],
                }
        (META / stem / "framelabel-slices.json").write_text(
            json.dumps(meta, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    except Exception as e:  # noqa: BLE001
        result["meta_update_error"] = str(e)

    return result



def load_no_label_assist_ids() -> set[str]:
    """Ids listed in NO-LABELS.md (fz__<id> rows)."""
    ids: set[str] = set()
    if not NO_LABELS_PATH.is_file():
        return ids
    for line in NO_LABELS_PATH.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line.startswith("| `fz__"):
            continue
        # | `fz__gaara` | `fz/gaara` | assist | ...
        parts = [p.strip() for p in line.split("|") if p.strip()]
        if not parts:
            continue
        stem = parts[0].strip("`")
        if stem.startswith("fz__"):
            ids.add(stem[4:])
    return ids


def discover_labeled_assists() -> list[str]:
    """fz/*.swf ids that have framelabel-slices.json (HAVE FrameLabel)."""
    skip = load_no_label_assist_ids()
    if not FZ_ASSETS.is_dir():
        return []
    out: list[str] = []
    for swf in sorted(FZ_ASSETS.glob("*.swf")):
        aid = swf.stem
        if aid in skip:
            continue
        meta_path = FZ_META / aid / "framelabel-slices.json"
        if meta_path.is_file():
            out.append(aid)
    return out


def load_meta_fz(aid: str) -> dict:
    path = FZ_META / aid / "framelabel-slices.json"
    if not path.is_file():
        raise FileNotFoundError(f"missing meta: {path}")
    return json.loads(path.read_text(encoding="utf-8"))


def already_sampled_fz(aid: str) -> bool:
    if count_pngs(FZ_FRAMES / aid) > 0:
        return True
    try:
        meta = load_meta_fz(aid)
    except FileNotFoundError:
        return False
    return (meta.get("png_frames") or {}).get("status") == "sample_ok"


def _crop_frame_pngs(out_dir: Path) -> int:
    """Auto-crop exported PNGs to content; empty frames keep a 1x1 transparent pixel."""
    try:
        from PIL import Image
    except ImportError:
        return count_pngs(out_dir)
    pngs = sorted(out_dir.glob("*.png"))
    if not pngs:
        return 0
    # Shared crop box across non-empty frames so sheet stays aligned
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
        # pad a little
        pad = 4
        x0 = max(0, x0 - pad)
        y0 = max(0, y0 - pad)
        for p, im in images:
            if im.getbbox():
                im.crop((x0, y0, min(im.width, x1 + pad), min(im.height, y1 + pad))).save(p)
            else:
                # empty idle frame: same canvas size, transparent
                w = min(im.width, x1 + pad) - x0
                h = min(im.height, y1 + pad) - y0
                Image.new("RGBA", (max(1, w), max(1, h)), (0, 0, 0, 0)).save(p)
    return count_pngs(out_dir)


def export_one_fz(
    aid: str,
    *,
    max_frames: int,
    dry_run: bool,
) -> dict:
    """Export standing sample for one labeled assist → _frames/fz/<id>/."""
    meta = load_meta_fz(aid)
    sprite = meta.get("actionSpriteId")
    if sprite is None:
        raise ValueError(f"{aid}: no actionSpriteId")
    sprite = int(sprite)
    swf = FZ_ASSETS / f"{aid}.swf"
    if not swf.is_file():
        raise FileNotFoundError(f"missing SWF: {swf}")
    out = FZ_FRAMES / aid

    # Assists rarely have 站立; prefer it, else frames 1..max_frames (idle→intro).
    start, end, span_name = 1, max_frames, "站立/1-N"
    try:
        start, end, span_name = resolve_range(meta, None, max_frames)
        # If first label starts late (e.g. end@10), still sample early standing frames 1-N
        if start > 1 or span_name not in ("站立", "1-N"):
            # For assists: standing sample = root/sprite frames 1..min(9,max)
            start, end, span_name = 1, min(9, max_frames), "standing-1-N"
    except Exception:
        start, end, span_name = 1, min(9, max_frames), "standing-1-N"

    # Cap typical sample at 9 when using standing-1-N
    if span_name == "standing-1-N":
        end = min(end, 9, max_frames)
        start = 1

    result = {
        "stem": f"fz/{aid}",
        "actionSpriteId": sprite,
        "label": span_name,
        "start": start,
        "end": end,
        "expected_frames": end - start + 1,
        "out": str(out.relative_to(EXPORT)),
        "ok": False,
        "png_count": 0,
        "kind": "assist",
    }

    if dry_run:
        result["ok"] = True
        result["dry_run"] = True
        result["mode"] = "frame+zoom"
        return result

    out.mkdir(parents=True, exist_ok=True)
    # clear previous dumps
    for child in list(out.iterdir()):
        if child.is_file() and child.suffix.lower() == ".png":
            child.unlink()
        elif child.is_dir() and child.name.startswith("DefineSprite_"):
            shutil.rmtree(child, ignore_errors=True)

    # Assists: standing/idle is on MainTimeline (frame1=stop). actionSpriteId>0 is
    # often an attack FX clip — for standing samples always use root frames + zoom.
    result["mode"] = "frame+zoom"
    with tempfile.TemporaryDirectory(prefix="fz_png_") as td:
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
            return result
        cmd = [
            "java", "-jar", str(FFDEC),
            "-zoom", str(FZ_FRAME_ZOOM),
            "-format", "frame:png",
            "-select", f"{start}-{end}",
            "-ignorebackground",
            "-export", "frame",
            str(out),
            str(tmp_swf),
        ]
        result["cmd"] = " ".join(cmd)
        proc = subprocess.run(cmd, capture_output=True, text=True)
        result["returncode"] = proc.returncode
        result["stderr_tail"] = (proc.stderr or proc.stdout or "")[-500:]
        result["png_count"] = _crop_frame_pngs(out)
        result["ok"] = proc.returncode == 0 and result["png_count"] > 0

    # update meta
    try:
        meta["png_frames"] = {
            "status": "sample_ok" if result["ok"] else "failed",
            "dir": f"_frames/fz/{aid}/",
            "actionSpriteId": sprite,
            "label": span_name,
            "range": f"{start}-{end}",
            "png_count": result["png_count"],
            "mode": result.get("mode"),
            "tool": "tools/batch_png_frames.py --fz",
            "ffdec": str(FFDEC),
        }
        notes = meta.get("notes") or []
        note = "PNG standing sample export via FFDec (batch_png_frames.py --fz)."
        if note not in notes:
            notes = [n for n in notes if "PNG frame dump deferred" not in n and "java/ffdec runtime not available" not in n]
            notes.append(note)
            meta["notes"] = notes
        (FZ_META / aid / "framelabel-slices.json").write_text(
            json.dumps(meta, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    except Exception as e:  # noqa: BLE001
        result["meta_update_error"] = str(e)

    return result


def load_prior_summary() -> dict[str, dict]:
    if not SUMMARY_PATH.is_file():
        return {}
    try:
        data = json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return {}
    if not isinstance(data, list):
        return {}
    return {r["stem"]: r for r in data if isinstance(r, dict) and "stem" in r}


def write_summary(rows_by_stem: dict[str, dict]) -> None:
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
    ordered = [rows_by_stem[k] for k in sorted(rows_by_stem)]
    SUMMARY_PATH.write_text(
        json.dumps(ordered, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "fighters",
        nargs="*",
        default=None,
        help="fighter/assist ids (default: discover; with --fz: labeled fz assists)",
    )
    ap.add_argument("--label", default=None, help="FrameLabel to export (default: 站立 / first)")
    ap.add_argument(
        "--max-frames",
        type=int,
        default=DEFAULT_MAX_FRAMES,
        help=f"cap frames per fighter (default {DEFAULT_MAX_FRAMES}; standing 1-9 or span ≤15)",
    )
    ap.add_argument(
        "--skip-done",
        action="store_true",
        default=True,
        help="skip stems already sampled (default: on when discovering all)",
    )
    ap.add_argument(
        "--no-skip-done",
        action="store_true",
        help="re-export even if _frames/<stem> already has PNGs",
    )
    ap.add_argument(
        "--all",
        action="store_true",
        help="explicitly select every playable top-level fighter SWF",
    )
    ap.add_argument(
        "--include-done",
        action="store_true",
        help="when discovering, also include the first-wave DONE_FIGHTERS set",
    )
    ap.add_argument(
        "--fz",
        action="store_true",
        help="export labeled fz/ assists (skip NO-LABELS.md); writes _frames/fz/<id>/",
    )
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument(
        "--list",
        action="store_true",
        help="print selected stems and exit",
    )
    args = ap.parse_args()

    if not FFDEC.is_file():
        print(f"ERROR: FFDec not found: {FFDEC}", file=sys.stderr)
        return 2

    skip_done = not args.no_skip_done

    if args.fz:
        if args.fighters:
            stems = list(args.fighters)
        else:
            stems = discover_labeled_assists()
            skip_n = load_no_label_assist_ids()
            print(f"Labeled assists: {len(stems)} (skipped no-label: {len(skip_n)})")
        if skip_done and not args.fighters:
            before = list(stems)
            stems = [s for s in stems if not already_sampled_fz(s)]
            skipped = [s for s in before if s not in stems]
            if skipped:
                print(f"Skipping already sampled ({len(skipped)}): {', '.join(skipped)}")
        if args.list:
            print(f"{len(stems)} assists: {', '.join(stems)}")
            return 0
        if not stems:
            print("Nothing to export (empty fz selection).")
            return 0
        prior = load_prior_summary()
        rows = []
        for aid in stems:
            try:
                row = export_one_fz(aid, max_frames=args.max_frames, dry_run=args.dry_run)
            except Exception as e:  # noqa: BLE001
                row = {"stem": f"fz/{aid}", "ok": False, "error": str(e), "png_count": 0}
            rows.append(row)
            prior[row["stem"]] = row
            status = "OK" if row.get("ok") else "FAIL"
            extra = row.get("error") or (
                f"sprite={row.get('actionSpriteId')} mode={row.get('mode')} "
                f"{row.get('label')} {row.get('start')}-{row.get('end')} pngs={row.get('png_count')}"
            )
            print(f"[{status}] fz/{aid}: {extra}")
        ok_n = sum(1 for r in rows if r.get("ok"))
        total_png = sum(int(r.get("png_count") or 0) for r in rows)
        print(f"\nDone: {ok_n}/{len(rows)} assists this run, {total_png} PNGs → {FZ_FRAMES}")
        if not args.dry_run:
            write_summary(prior)
            print(f"Summary: {SUMMARY_PATH} ({len(prior)} entries)")
        return 0 if ok_n == len(rows) else 1

    if args.fighters:
        stems = list(args.fighters)
    else:
        stems = discover_playable()
        if not args.include_done and not args.all:
            # default discovery: remaining only (exclude first-wave names even if empty dirs)
            done_set = set(DONE_FIGHTERS)
            stems = [s for s in stems if s not in done_set]

    if skip_done and not args.fighters:
        before = list(stems)
        stems = [s for s in stems if not already_sampled(s)]
        skipped = [s for s in before if s not in stems]
        if skipped:
            print(f"Skipping already sampled ({len(skipped)}): {', '.join(skipped)}")

    if args.list:
        print(f"{len(stems)} fighters: {', '.join(stems)}")
        return 0

    if not stems:
        print("Nothing to export (empty selection).")
        return 0

    prior = load_prior_summary()
    rows = []
    for stem in stems:
        try:
            row = export_one(stem, label=args.label, max_frames=args.max_frames, dry_run=args.dry_run)
        except Exception as e:  # noqa: BLE001
            row = {"stem": stem, "ok": False, "error": str(e), "png_count": 0}
        rows.append(row)
        prior[stem] = row
        status = "OK" if row.get("ok") else "FAIL"
        extra = row.get("error") or (
            f"sprite={row.get('actionSpriteId')} {row.get('label')} "
            f"{row.get('start')}-{row.get('end')} pngs={row.get('png_count')}"
        )
        print(f"[{status}] {stem}: {extra}")

    ok_n = sum(1 for r in rows if r.get("ok"))
    total_png = sum(int(r.get("png_count") or 0) for r in rows)
    print(f"\nDone: {ok_n}/{len(rows)} fighters this run, {total_png} PNGs → {FRAMES}")
    if not args.dry_run:
        write_summary(prior)
        print(f"Summary: {SUMMARY_PATH} ({len(prior)} entries)")
    return 0 if ok_n == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())
