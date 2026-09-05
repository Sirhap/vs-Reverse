# Task: line-by-line reverse — fighters Batch A

Shell + net.play5d engine (A–D) are DONE under `reverse/line-by-line/shell/` and `engine/`. Continue 长城任务 with **character SWF timelines**.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/fighters-batch-A-files.txt`
Fighters: **aizen, byakuya, chad, didala, fz** (~73 `.as`).
`fz/**` are assist/extra SWFs (smaller MainTimelines), not the main roster.

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/fighters/`
   Mirror path after `decompiled/fighters/`, e.g.
   - `aizen/scripts/aizen_fla/MainTimeline.md`
   - `fz/minato/scripts/minato_fla/MainTimeline.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`$fighter_ctrler`, `FighterMain`, face/sound exports)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs (`bsface*`, `snd_*`, empty `元件*`) may be short (purpose + size + what they export), still one md each
   - Large `MainTimeline` / `*全动作*` : group by label/frame ranges; document every `$fighter_ctrler.*` / hit / bullet / state transition; do not skip action frames

2. `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-BATCH-A-INDEX.md`
   - Overview of this batch’s fighters
   - Shared timeline patterns (AI面 / 全动作 / face / hurt sound)
   - Checklist: every listed file done or remaining

3. Also write `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-INDEX.md` as fighters master index (Batch A done; note B–G still pending; do not start other batches).

## Quality reference
Match `reverse/line-by-line/engine/` Batch A–D notes. Cross-link engine docs when useful:
`engine/game/bvn/fighter/FighterMain.md` and related ctrler notes.

## Rules
- Chinese. Do not modify `decompiled/`. No play/ rebuild SWF.
- ONLY Batch A fighters above — do not annotate other roster folders or `decompiled/ui` yet.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in fighters-batch-A-files.txt has a non-stub md + `00-BATCH-A-INDEX.md` + fighters `00-INDEX.md` listing A done / B–G pending.
