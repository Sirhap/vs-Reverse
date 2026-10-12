#!/usr/bin/env python3
"""Batch-export FULL FrameLabel action spans for fighters/assists via FFDec.

For each fighter (default):
  1) Dump the primary action DefineSprite (all frames) once via FFDec.
  2) Slice PNGs into _frames/<stem>/actions/<label>/ by framelabel-slices.json
     spans, capped at --max-frames-per-label (default 40; smaller spans export
     in full). Open-ended last labels (end_frame=null) take up to the cap from
     start_frame through whatever frames exist in the dump.

With --fz (labeled assists under assets/fighter/fz/):
  Meta: _meta/fighter/fz/<id>/framelabel-slices.json
  Out:  _frames/fz/<id>/actions/<label>/
  Skips the 22 no-label assists (NO-LABELS.md; framescript samples already done).
  actionSpriteId > 0 → DefineSprite dump + slice (same as fighters).
  actionSpriteId == 0 (MainTimeline) → temp SWF displayRect + zoom frame export
  per label span, then auto-crop into actions/<label>/.
  Summary: _frames/fz/ASSIST-ACTIONS-SUMMARY.json (does not overwrite fighter
  BATCH-ACTIONS-SUMMARY.json).

Does NOT modify main.swf or source fz/*.swf. Preserves standing samples and
framescript dirs under _frames/<stem>/ / _frames/fz/<id>/.

Default wave-1 fighters: ichigo rukia sasuke naruto kakashi itachi sakura orihime.

Combat priority (--combat-only): keep labels matching 站立/走/跳*/瞬*/砍*/招*/
摔*/攻击/技能 (locomotion + attacks). Use when disk/time is constrained.
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]  # /workspace/bvn-3.3
EXPORT = ROOT / "work" / "remake" / "export"
META = EXPORT / "_meta" / "fighter"
ASSETS = EXPORT / "assets" / "fighter"
FRAMES = EXPORT / "_frames"
FFDEC = Path("/workspace/tools/ffdec/ffdec-cli.jar")
SUMMARY_PATH = FRAMES / "BATCH-ACTIONS-SUMMARY.json"
ASSIST_SUMMARY_PATH = FRAMES / "fz" / "ASSIST-ACTIONS-SUMMARY.json"
NO_LABELS_PATH = META / "NO-LABELS.md"
FZ_ASSETS = ASSETS / "fz"
FZ_META = META / "fz"
FZ_FRAMES = FRAMES / "fz"
FZ_FRAME_ZOOM = 15
FZ_DISPLAYRECT = "[-80px,-120px,80px,40px]"

WAVE1 = [
    "ichigo",
    "rukia",
    "sasuke",
    "naruto",
    "kakashi",
    "itachi",
    "sakura",
    "orihime",
]

DEFAULT_MAX_PER_LABEL = 40

# Combat / locomotion priority (站立/走/跳/攻击/技能 + common attack roots)
COMBAT_PREFIXES = (
    "站立",
    "走",
    "瞬",
    "起跳",
    "跳",
    "落",
    "砍",
    "招",
    "摔",
    "攻击",
    "技能",
)



def load_no_label_assist_ids() -> set[str]:
    """Parse NO-LABELS.md for fz/<id> stems to skip."""
    skip: set[str] = set()
    if not NO_LABELS_PATH.is_file():
        return skip
    for line in NO_LABELS_PATH.read_text(encoding="utf-8").splitlines():
        # table rows like | `fz__gaara` | `fz/gaara` | assist | ...
        if "`fz/" not in line:
            continue
        for part in line.split("|"):
            part = part.strip().strip("`")
            if part.startswith("fz/") and "/" in part[3:]:
                skip.add(part.split("/", 1)[1])
            elif part.startswith("fz/") and part.count("/") == 1:
                skip.add(part.split("/", 1)[1])
    return skip


def discover_labeled_assists() -> list[str]:
    """Return stems 'fz/<id>' for labeled assists (have framelabel-slices.json)."""
    skip = load_no_label_assist_ids()
    out: list[str] = []
    if not FZ_META.is_dir():
        return out
    for meta_dir in sorted(FZ_META.iterdir()):
        if not meta_dir.is_dir():
            continue
        aid = meta_dir.name
        if aid in skip:
            continue
        if (meta_dir / "framelabel-slices.json").is_file():
            out.append(f"fz/{aid}")
    return out


def crop_frame_pngs(out_dir: Path) -> int:
    """Auto-crop exported MainTimeline PNGs to shared content bbox."""
    try:
        from PIL import Image
    except ImportError:
        return sum(1 for p in out_dir.glob("*.png") if p.is_file())
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
    return sum(1 for p in out_dir.glob("*.png") if p.is_file())


def ffdec_export_frames(
    swf: Path,
    start: int,
    end: int,
    out: Path,
    *,
    zoom: int = FZ_FRAME_ZOOM,
    displayrect: str = FZ_DISPLAYRECT,
) -> tuple[int, str]:
    """MainTimeline frame export via temp SWF with expanded displayRect + zoom."""
    out.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="fz_act_") as td:
        tmp_swf = Path(td) / swf.name
        hdr = [
            "java",
            "-jar",
            str(FFDEC),
            "-header",
            "-set",
            "displayrect",
            displayrect,
            str(swf),
            str(tmp_swf),
        ]
        proc_h = subprocess.run(hdr, capture_output=True, text=True)
        if proc_h.returncode != 0 or not tmp_swf.is_file():
            tail = (proc_h.stderr or proc_h.stdout or "")[-800:]
            return proc_h.returncode or 1, f"displayrect rewrite failed: {tail}"
        cmd = [
            "java",
            "-jar",
            str(FFDEC),
            "-zoom",
            str(zoom),
            "-format",
            "frame:png",
            "-select",
            f"{start}-{end}",
            "-ignorebackground",
            "-export",
            "frame",
            str(out),
            str(tmp_swf),
        ]
        proc = subprocess.run(cmd, capture_output=True, text=True)
        tail = (proc.stderr or proc.stdout or "")[-800:]
        return proc.returncode, tail


def load_meta(stem: str) -> dict:
    path = META / stem / "framelabel-slices.json"
    if not path.is_file():
        raise FileNotFoundError(f"missing meta: {path}")
    return json.loads(path.read_text(encoding="utf-8"))


def is_combat_label(label: str) -> bool:
    if not label:
        return False
    return any(label.startswith(p) for p in COMBAT_PREFIXES)


def safe_label_dir(label: str) -> str:
    """Filesystem-safe label dir name (keep CJK; strip path separators)."""
    s = label.strip()
    s = s.replace("/", "_").replace("\\", "_").replace("\0", "")
    s = re.sub(r"\s+", "_", s)
    return s or "unnamed"


def resolve_slices(
    meta: dict,
    *,
    max_per_label: int,
    combat_only: bool,
    raw_max_frame: int | None,
) -> list[dict]:
    """Return list of {label, start, end, full_count, export_count, capped}."""
    out: list[dict] = []
    for s in meta.get("slices") or []:
        label = str(s.get("label") or "")
        start = s.get("start_frame")
        end = s.get("end_frame")
        if start is None:
            continue
        start = int(start)
        if combat_only and not is_combat_label(label):
            continue
        if end is None:
            # open-ended last label: take up to cap from start, limited by dump
            if raw_max_frame is not None:
                end = min(start + max_per_label - 1, raw_max_frame)
            else:
                end = start + max_per_label - 1
            full_count = None
        else:
            end = int(end)
            if end < start:
                end = start
            full_count = end - start + 1
            if full_count > max_per_label:
                end = start + max_per_label - 1
        export_count = end - start + 1
        capped = full_count is not None and full_count > max_per_label
        if full_count is None:
            capped = True  # open-ended treated as capped
        out.append(
            {
                "label": label,
                "dir": safe_label_dir(label),
                "start": start,
                "end": end,
                "full_count": full_count,
                "export_count": export_count,
                "capped": capped,
                "combat": is_combat_label(label),
            }
        )
    return out


def find_sprite_png_dir(raw_root: Path, sprite_id: int) -> Path | None:
    """FFDec writes DefineSprite_<id>_*/N.png under the export root."""
    matches = sorted(
        p for p in raw_root.iterdir() if p.is_dir() and p.name.startswith(f"DefineSprite_{sprite_id}")
    )
    if matches:
        return matches[0]
    # fallback: any DefineSprite_* with pngs
    for p in sorted(raw_root.iterdir()):
        if p.is_dir() and p.name.startswith("DefineSprite_") and any(p.glob("*.png")):
            return p
    return None


def max_frame_in_dir(sprite_dir: Path) -> int:
    nums = []
    for p in sprite_dir.glob("*.png"):
        if p.stem.isdigit():
            nums.append(int(p.stem))
    return max(nums) if nums else 0


def ffdec_export_sprite(swf: Path, sprite_id: int, out: Path) -> tuple[int, str]:
    out.mkdir(parents=True, exist_ok=True)
    cmd = [
        "java",
        "-jar",
        str(FFDEC),
        "-format",
        "sprite:png",
        "-selectid",
        str(sprite_id),
        "-ignorebackground",
        "-export",
        "sprite",
        str(out),
        str(swf),
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    tail = (proc.stderr or proc.stdout or "")[-800:]
    return proc.returncode, tail


def slice_actions(
    sprite_dir: Path,
    actions_root: Path,
    spans: list[dict],
    *,
    dry_run: bool,
) -> list[dict]:
    """Copy frame PNGs into actions/<label>/; return per-span results."""
    results = []
    for span in spans:
        dest = actions_root / span["dir"]
        row = dict(span)
        row["out"] = str(dest.relative_to(EXPORT)) if not dry_run or actions_root.is_relative_to(EXPORT) else str(dest)
        try:
            row["out"] = str(dest.relative_to(EXPORT))
        except ValueError:
            row["out"] = str(dest)
        pngs = []
        missing = []
        for fr in range(span["start"], span["end"] + 1):
            src = sprite_dir / f"{fr}.png"
            if src.is_file():
                pngs.append(src)
            else:
                missing.append(fr)
        row["png_count"] = len(pngs)
        row["missing"] = missing[:10]
        row["ok"] = len(pngs) > 0 and len(missing) == 0
        if missing and pngs:
            row["ok"] = True  # partial OK if some frames present
            row["partial"] = True
        if dry_run:
            row["ok"] = True
            row["dry_run"] = True
            results.append(row)
            continue
        if dest.exists():
            shutil.rmtree(dest)
        dest.mkdir(parents=True, exist_ok=True)
        for src in pngs:
            shutil.copy2(src, dest / src.name)
        row["png_count"] = sum(1 for p in dest.glob("*.png") if p.is_file())
        row["ok"] = row["png_count"] > 0
        results.append(row)
    return results


def export_fighter(
    stem: str,
    *,
    max_per_label: int,
    combat_only: bool,
    keep_raw: bool,
    dry_run: bool,
    raw_dir: Path | None = None,
) -> dict:
    t0 = time.time()
    meta = load_meta(stem)
    sprite = meta.get("actionSpriteId")
    if sprite is None:
        raise ValueError(f"{stem}: no actionSpriteId")
    sprite = int(sprite)
    swf = ASSETS / f"{stem}.swf"
    if not swf.is_file():
        raise FileNotFoundError(f"missing SWF: {swf}")

    actions_root = FRAMES / stem / "actions"
    result: dict = {
        "stem": stem,
        "actionSpriteId": sprite,
        "actionExport": meta.get("actionExport"),
        "combat_only": combat_only,
        "max_frames_per_label": max_per_label,
        "ok": False,
        "labels": [],
        "label_count": 0,
        "png_count": 0,
        "raw_frames": 0,
        "elapsed_s": 0,
    }

    # Plan spans without raw_max first (open-ended use cap)
    planned = resolve_slices(meta, max_per_label=max_per_label, combat_only=combat_only, raw_max_frame=None)
    result["label_count_planned"] = len(planned)
    result["expected_pngs"] = sum(s["export_count"] for s in planned)

    if dry_run:
        result["labels"] = planned
        result["ok"] = True
        result["dry_run"] = True
        result["mode"] = "frame+zoom" if sprite == 0 else "sprite"
        result["elapsed_s"] = round(time.time() - t0, 2)
        return result

    actions_root.mkdir(parents=True, exist_ok=True)
    is_assist = stem.startswith("fz/")
    result["kind"] = "assist" if is_assist else "fighter"
    cleanup_raw = False
    raw_parent: Path | None = None

    # MainTimeline assists (actionSpriteId==0): per-label frame+zoom export
    if sprite == 0:
        result["mode"] = "frame+zoom"
        spans = planned  # open-ended already capped; no raw_max known a priori
        label_rows = []
        raw_max = 0
        for span in spans:
            dest = actions_root / span["dir"]
            if dest.exists():
                shutil.rmtree(dest)
            dest.mkdir(parents=True, exist_ok=True)
            with tempfile.TemporaryDirectory(prefix=f"fz_raw_{safe_label_dir(stem)}_") as td:
                raw_tmp = Path(td) / "frames"
                rc, tail = ffdec_export_frames(swf, span["start"], span["end"], raw_tmp)
                result["ffdec_returncode"] = rc
                result["stderr_tail"] = tail
                row = dict(span)
                if rc != 0:
                    row["ok"] = False
                    row["png_count"] = 0
                    row["error"] = f"ffdec frame export rc={rc}"
                    label_rows.append(row)
                    continue
                # copy selected frames into dest (FFDec names by frame number)
                for fr in range(span["start"], span["end"] + 1):
                    src = raw_tmp / f"{fr}.png"
                    if src.is_file():
                        shutil.copy2(src, dest / src.name)
                crop_frame_pngs(dest)
                row["png_count"] = sum(1 for p in dest.glob("*.png") if p.is_file())
                row["ok"] = row["png_count"] > 0
                row["partial"] = row["ok"] and row["png_count"] < span["export_count"]
                if row["png_count"]:
                    nums = [int(p.stem) for p in dest.glob("*.png") if p.stem.isdigit()]
                    if nums:
                        raw_max = max(raw_max, max(nums))
                label_rows.append(row)
        result["raw_frames"] = raw_max
    else:
        result["mode"] = "sprite"
        # Raw dump location
        cleanup_raw = False
        if raw_dir is None:
            raw_parent = FRAMES / stem / "_raw_sprite"
            if raw_parent.exists():
                shutil.rmtree(raw_parent)
            raw_parent.mkdir(parents=True, exist_ok=True)
            cleanup_raw = not keep_raw
        else:
            raw_parent = raw_dir
            raw_parent.mkdir(parents=True, exist_ok=True)

        rc, tail = ffdec_export_sprite(swf, sprite, raw_parent)
        result["ffdec_returncode"] = rc
        result["stderr_tail"] = tail
        if rc != 0:
            result["error"] = f"ffdec failed rc={rc}"
            result["elapsed_s"] = round(time.time() - t0, 2)
            if cleanup_raw and raw_parent.exists():
                shutil.rmtree(raw_parent, ignore_errors=True)
            return result

        sprite_dir = find_sprite_png_dir(raw_parent, sprite)
        if sprite_dir is None:
            result["error"] = f"no DefineSprite_{sprite} dir under {raw_parent}"
            result["elapsed_s"] = round(time.time() - t0, 2)
            if cleanup_raw and raw_parent.exists():
                shutil.rmtree(raw_parent, ignore_errors=True)
            return result

        raw_max = max_frame_in_dir(sprite_dir)
        result["raw_frames"] = raw_max
        result["raw_dir"] = (
            str(sprite_dir.relative_to(EXPORT)) if sprite_dir.is_relative_to(EXPORT) else str(sprite_dir)
        )

        # Re-resolve with known raw_max for open-ended labels
        spans = resolve_slices(
            meta, max_per_label=max_per_label, combat_only=combat_only, raw_max_frame=raw_max
        )
        label_rows = slice_actions(sprite_dir, actions_root, spans, dry_run=False)
    result["labels"] = [
        {
            "label": r["label"],
            "dir": r["dir"],
            "start": r["start"],
            "end": r["end"],
            "full_count": r["full_count"],
            "export_count": r["export_count"],
            "png_count": r["png_count"],
            "capped": r["capped"],
            "combat": r["combat"],
            "ok": r["ok"],
            "partial": r.get("partial", False),
        }
        for r in label_rows
    ]
    result["label_count"] = len(label_rows)
    result["png_count"] = sum(int(r["png_count"]) for r in label_rows)
    result["labels_ok"] = sum(1 for r in label_rows if r["ok"])
    result["ok"] = result["labels_ok"] == len(label_rows) and len(label_rows) > 0
    result["actions_dir"] = str(actions_root.relative_to(EXPORT))
    result["elapsed_s"] = round(time.time() - t0, 2)

    # Update meta: png_actions summary (non-destructive to png_frames standing sample)
    try:
        meta["png_actions"] = {
            "status": "actions_ok" if result["ok"] else "partial",
            "dir": f"_frames/{stem}/actions/",
            "actionSpriteId": sprite,
            "max_frames_per_label": max_per_label,
            "combat_only": combat_only,
            "mode": result.get("mode"),
            "label_count": result["label_count"],
            "png_count": result["png_count"],
            "raw_frames": raw_max,
            "tool": "tools/batch_action_frames.py" + (" --fz" if is_assist else ""),
            "ffdec": str(FFDEC),
        }
        notes = meta.get("notes") or []
        note = (
            "PNG full action FrameLabel spans via FFDec (batch_action_frames.py --fz)."
            if is_assist
            else "PNG full action FrameLabel spans via FFDec (batch_action_frames.py)."
        )
        if note not in notes:
            notes.append(note)
            meta["notes"] = notes
        # annotate each exported slice
        by_label = {r["label"]: r for r in label_rows}
        for s in meta.get("slices") or []:
            lab = s.get("label")
            if lab in by_label:
                r = by_label[lab]
                s["png_actions"] = {
                    "dir": f"_frames/{stem}/actions/{r['dir']}/",
                    "range": f"{r['start']}-{r['end']}",
                    "count": r["png_count"],
                    "capped": r["capped"],
                }
        (META / stem / "framelabel-slices.json").write_text(
            json.dumps(meta, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
    except Exception as e:  # noqa: BLE001
        result["meta_update_error"] = str(e)

    if cleanup_raw and raw_parent is not None and raw_parent.exists():
        shutil.rmtree(raw_parent, ignore_errors=True)

    return result


def write_summary(rows: list[dict], *, assist: bool = False) -> Path:
    out_path = ASSIST_SUMMARY_PATH if assist else SUMMARY_PATH
    out_path.parent.mkdir(parents=True, exist_ok=True)
    # compact labels in summary file (drop per-frame noise)
    compact = []
    for r in rows:
        c = {k: v for k, v in r.items() if k != "stderr_tail"}
        if "labels" in c and isinstance(c["labels"], list):
            c["labels"] = [
                {
                    "label": x.get("label"),
                    "start": x.get("start"),
                    "end": x.get("end"),
                    "png_count": x.get("png_count"),
                    "capped": x.get("capped"),
                    "ok": x.get("ok"),
                }
                for x in c["labels"]
            ]
        compact.append(c)
    key = "assists" if assist else "fighters"
    ok_key = "assists_ok" if assist else "fighters_ok"
    payload = {
        "schema": "bvn-remake-assist-actions-v1" if assist else "bvn-remake-batch-actions-v1",
        "generated": time.strftime("%Y-%m-%d %H:%M:%S CST"),
        "tool": "tools/batch_action_frames.py" + (" --fz" if assist else ""),
        "ffdec": str(FFDEC),
        "max_frames_per_label": DEFAULT_MAX_PER_LABEL,
        key: compact,
        "totals": {
            key: len(compact),
            ok_key: sum(1 for r in compact if r.get("ok")),
            "labels": sum(int(r.get("label_count") or 0) for r in compact),
            "pngs": sum(int(r.get("png_count") or 0) for r in compact),
        },
    }
    out_path.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return out_path


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "fighters",
        nargs="*",
        default=None,
        help="fighter stems (default: wave1 eight)",
    )
    ap.add_argument(
        "--wave1",
        action="store_true",
        help="explicitly select the first-wave 8 fighters",
    )
    ap.add_argument(
        "--max-frames-per-label",
        type=int,
        default=DEFAULT_MAX_PER_LABEL,
        help=f"cap frames per FrameLabel (default {DEFAULT_MAX_PER_LABEL})",
    )
    ap.add_argument(
        "--combat-only",
        action="store_true",
        help="only 站立/走/跳*/瞬*/砍*/招*/摔*/攻击/技能 labels",
    )
    ap.add_argument(
        "--keep-raw",
        action="store_true",
        help="keep _frames/<stem>/_raw_sprite/ full dump after slicing",
    )
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--list", action="store_true", help="print planned spans and exit")
    ap.add_argument(
        "--fz",
        action="store_true",
        help="export labeled fz/ assists (skips 22 no-label); summary → fz/ASSIST-ACTIONS-SUMMARY.json",
    )
    args = ap.parse_args()

    if not FFDEC.is_file():
        print(f"ERROR: FFDec not found: {FFDEC}", file=sys.stderr)
        return 2

    if args.fz:
        if args.fighters:
            stems = []
            for a in args.fighters:
                a = a.strip().replace("\\", "/")
                if a.startswith("fz/"):
                    stems.append(a)
                else:
                    stems.append(f"fz/{a}")
        else:
            stems = discover_labeled_assists()
            if not stems:
                print("ERROR: no labeled fz assists found", file=sys.stderr)
                return 2
    elif args.fighters:
        stems = list(args.fighters)
    elif args.wave1 or not args.fighters:
        stems = list(WAVE1)

    if args.list or args.dry_run:
        for stem in stems:
            meta = load_meta(stem)
            spans = resolve_slices(
                meta,
                max_per_label=args.max_frames_per_label,
                combat_only=args.combat_only,
                raw_max_frame=None,
            )
            exp = sum(s["export_count"] for s in spans)
            print(
                f"{stem}: sprite={meta.get('actionSpriteId')} "
                f"labels={len(spans)} expected_pngs≈{exp} combat_only={args.combat_only}"
            )
            if args.list:
                for s in spans:
                    cap = " CAP" if s["capped"] else ""
                    print(f"  {s['label']:24s} {s['start']:5d}-{s['end']:5d} ({s['export_count']}){cap}")
        if args.list and not args.dry_run:
            return 0

    if args.list and not args.dry_run:
        return 0

    rows = []
    for stem in stems:
        print(f"=== {stem} ===")
        try:
            row = export_fighter(
                stem,
                max_per_label=args.max_frames_per_label,
                combat_only=args.combat_only,
                keep_raw=args.keep_raw,
                dry_run=args.dry_run,
            )
        except Exception as e:  # noqa: BLE001
            row = {"stem": stem, "ok": False, "error": str(e), "png_count": 0, "label_count": 0}
        rows.append(row)
        status = "OK" if row.get("ok") else "FAIL"
        print(
            f"[{status}] {stem}: labels={row.get('label_count') or row.get('label_count_planned')} "
            f"pngs={row.get('png_count') or row.get('expected_pngs')} "
            f"raw={row.get('raw_frames')} elapsed={row.get('elapsed_s')}s "
            f"{row.get('error') or ''}"
        )

    ok_n = sum(1 for r in rows if r.get("ok"))
    total_png = sum(int(r.get("png_count") or 0) for r in rows)
    total_lab = sum(int(r.get("label_count") or 0) for r in rows)
    kind = "assists" if args.fz else "fighters"
    print(f"\nDone: {ok_n}/{len(rows)} {kind}, {total_lab} labels, {total_png} PNGs")
    if not args.dry_run:
        summary_path = write_summary(rows, assist=bool(args.fz))
        print(f"Summary: {summary_path}")
    return 0 if ok_n == len(rows) else 1


if __name__ == "__main__":
    sys.exit(main())
