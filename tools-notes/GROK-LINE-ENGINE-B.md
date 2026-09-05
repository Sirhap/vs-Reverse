# Task: line-by-line reverse — net.play5d engine Batch B (fighter + data)

Batch A is DONE (`reverse/line-by-line/engine/00-BATCH-A-INDEX.md`). Continue长城.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/engine-batch-B-files.txt`
(fighter/** including ctrler/ai/vos/models/events/utils, and data/**)

## Outputs
1. For EACH `.as`, annotated md under `/workspace/bvn-3.3/reverse/line-by-line/engine/` mirroring path after `net/play5d/` (e.g. `game/bvn/fighter/FighterMain.md`).
   Format (Chinese): purpose · callers/callees · **逐行说明** every function + non-trivial blocks with L.. refs. Match quality of Batch A / shell `ƃ/FB.md`.
2. `/workspace/bvn-3.3/reverse/line-by-line/engine/00-BATCH-B-INDEX.md` — fighter/data overview + full checklist.

## Rules
- Do not rewrite Batch A files. Do not modify `decompiled/`. No play/ rebuild.
- Skip ui/views/kyo (later). Echo `PROGRESS: wrote <path>` after each file.
- Prefer accuracy; mark `?` when unsure.

## Done when
Every listed file has non-stub md + 00-BATCH-B-INDEX.md checklist complete.
