# Task: line-by-line reverse — fighters Batch F

Shell + net.play5d engine (A–D) + fighters Batch A–E are DONE.
Continue 长城任务 with **fighters Batch F only**.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/fighters-batch-F-files.txt`
Fighters: **orochimaru, pain, renji, rukia, sakura, sasuke, sasuke_xz** (~68 `.as`).

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/fighters/`
   Mirror path after `decompiled/fighters/`, e.g.
   - `sasuke/scripts/sasuke_fla/MainTimeline.md`
   - `pain/scripts/pain_fla/全动作_1.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`$fighter_ctrler`, `FighterMain`, face/sound exports)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs (`bsface*`, `snd_*`, empty `元件*` / `sprite*`) may be short (purpose + size + what they export), still one md each
   - Large `MainTimeline` / `*全动作*` / `AI面*` / skill clips: group by label/frame ranges; document every `$fighter_ctrler.*` / hit / bullet / state transition; do not skip action frames

2. `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-BATCH-F-INDEX.md`
   - Overview of this batch’s fighters
   - Shared timeline patterns
   - Checklist: every listed file done or remaining

3. Update `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-INDEX.md`
   - Mark Batch F done; G still pending; do not start other batches.

## Quality reference
Match Batch A–E notes under `fighters/` and engine `FighterMain` / ctrler docs.
Reuse patterns from `00-BATCH-A-INDEX.md` … `00-BATCH-E-INDEX.md` (AI面 / 全动作 / face / hurt sound).

## Rules
- Chinese. Do not modify `decompiled/`. No play/rebuild SWF.
- ONLY Batch F fighters above — do not annotate other roster folders, `fz/` again, or `decompiled/ui`.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in fighters-batch-F-files.txt has a non-stub md + `00-BATCH-F-INDEX.md` + fighters `00-INDEX.md` listing F done / G pending.
