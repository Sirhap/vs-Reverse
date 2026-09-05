# Task: line-by-line reverse — fighters Batch G

Shell + net.play5d engine (A–D) + fighters Batch A–F are DONE.
Continue 长城任务 with **fighters Batch G only**.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/fighters-batch-G-files.txt`
Fighters: **sasuke_xz_old, soifon, temari, toushirou, ulquiorra, uryuu, yin** (~68 `.as`).

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/fighters/`
   Mirror path after `decompiled/fighters/`, e.g.
   - `soifon/scripts/soifon_fla/MainTimeline.md`
   - `ulquiorra/scripts/ulquiorra_fla/Timeline_1.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`$fighter_ctrler`, `FighterMain`, face/sound exports)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs (`bsface*`, `snd_*`, empty `元件*` / `sprite*`) may be short (purpose + size + what they export), still one md each
   - Large `MainTimeline` / `*全动作*` / `AI面*` / skill clips: group by label/frame ranges; document every `$fighter_ctrler.*` / hit / bullet / state transition; do not skip action frames

2. `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-BATCH-G-INDEX.md`
   - Overview of this batch’s fighters
   - Shared timeline patterns
   - Checklist: every listed file done or remaining

3. Update `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-INDEX.md`
   - Mark Batch G done; note ui/effect still pending; do not start ui yet.

## Quality reference
Match Batch A–F notes under `fighters/` and engine `FighterMain` / ctrler docs.
Reuse patterns from `00-BATCH-A-INDEX.md` … `00-BATCH-F-INDEX.md` (AI面 / 全动作 / face / hurt sound).

## Rules
- Chinese. Do not modify `decompiled/`. No play/rebuild SWF.
- ONLY Batch G fighters above — do not annotate other roster folders, `fz/` again, or `decompiled/ui`.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in fighters-batch-G-files.txt has a non-stub md + `00-BATCH-G-INDEX.md` + fighters `00-INDEX.md` listing G done / ui pending.
