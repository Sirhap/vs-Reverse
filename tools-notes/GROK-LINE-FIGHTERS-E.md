# Task: line-by-line reverse — fighters Batch E

Shell + net.play5d engine (A–D) + fighters Batch A–D are DONE.
Continue 长城任务 with **fighters Batch E only**.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/fighters-batch-E-files.txt`
Fighters: **naruto, naruto_xr, neji, obito, orihime** (~67 `.as`).

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/fighters/`
   Mirror path after `decompiled/fighters/`, e.g.
   - `naruto/scripts/naruto_fla/MainTimeline.md`
   - `neji/scripts/neji_fla/全动作_1.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`$fighter_ctrler`, `FighterMain`, face/sound exports)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs (`bsface*`, `snd_*`, empty `元件*` / `sprite*`) may be short (purpose + size + what they export), still one md each
   - Large `MainTimeline` / `*全动作*` / `AI面*` / skill clips: group by label/frame ranges; document every `$fighter_ctrler.*` / hit / bullet / state transition; do not skip action frames

2. `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-BATCH-E-INDEX.md`
   - Overview of this batch’s fighters
   - Shared timeline patterns
   - Checklist: every listed file done or remaining

3. Update `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-INDEX.md`
   - Mark Batch E done; F–G still pending; do not start other batches.

## Quality reference
Match Batch A–D notes under `fighters/` and engine `FighterMain` / ctrler docs.
Reuse patterns from `00-BATCH-A-INDEX.md` … `00-BATCH-D-INDEX.md` (AI面 / 全动作 / face / hurt sound).

## Rules
- Chinese. Do not modify `decompiled/`. No play/rebuild SWF.
- ONLY Batch E fighters above — do not annotate other roster folders, `fz/` again, or `decompiled/ui`.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in fighters-batch-E-files.txt has a non-stub md + `00-BATCH-E-INDEX.md` + fighters `00-INDEX.md` listing E done / F–G pending.
