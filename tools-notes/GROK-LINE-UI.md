# Task: line-by-line reverse — UI Batch

Shell + net.play5d engine (A–D) + fighters Batch A–G are DONE.
Continue 长城任务 with **`decompiled/ui/**` only** (not effect yet).

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/ui-batch-files.txt`
UI SWFs under `decompiled/ui/`: **common_ui, fight, gameover, howtoplay, loading, select, setting, title** (73 `.as`).

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/ui/`
   Mirror path after `decompiled/ui/`, e.g.
   - `fight/scripts/ui_fight.md`
   - `common_ui/scripts/mc_wzbtn.md`
   - `select/scripts/select_fla/MainTimeline.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`net.play5d.game.bvn.ui.*`, MenuBtn, FightUI, SelectUI, TransUI, states)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs / pure artwork clips may be short (purpose + size + export), still one md each
   - Large `MainTimeline` / HUD bars / select grids: group by label/frame; document every engine callback / btn / text field; do not skip interactive frames

2. `/workspace/bvn-3.3/reverse/line-by-line/ui/00-INDEX.md`
   - Overview of UI SWFs and how they map to engine UI classes
   - Shared patterns (MenuBtn, bars, face slots, transitions)
   - Checklist: every listed file done or remaining

3. Optionally `/workspace/bvn-3.3/reverse/line-by-line/ui/00-BATCH-INDEX.md` if you prefer a batch-style checklist; keep `00-INDEX.md` authoritative.

4. Update `/workspace/bvn-3.3/reverse/line-by-line/fighters/00-INDEX.md` only if needed to note UI in progress — do not reopen fighters.
   When UI done, note that `decompiled/other/effect/**` is still pending (do **not** start effect in this batch).

## Quality reference
Match fighters/engine annotation depth. Cross-link engine docs under:
`reverse/line-by-line/engine/game/bvn/ui/` (FightUI, MenuBtn, Select*, TransUI, WinUI, HitsUI, …).

## Rules
- Chinese. Do not modify `decompiled/`. No play/rebuild SWF.
- ONLY `decompiled/ui/**` paths in the file list — do not annotate `other/effect`, maps, or fighters.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in ui-batch-files.txt has a non-stub md + `ui/00-INDEX.md` checklist complete, and effect still marked pending (not started).
