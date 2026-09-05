# Task: line-by-line reverse — net.play5d engine Batch A (main chain)

Shell reverse is DONE under `reverse/line-by-line/shell/`. Continue the长城任务 for the game engine.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/engine-batch-A-files.txt`
(~ MainGame, GameConfig, Debugger, GameQuailty, ctrl/**, state/**, events/**, interfaces/**, input/**, utils/**, web/**, map/**)

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/engine/`
   Mirror path after `net/play5d/`, e.g. `game/bvn/MainGame.md`, `game/bvn/ctrl/GameCtrl.md`.
   Each file:
   - One-line purpose (Chinese)
   - Callers / callees
   - Important field/method rename notes if names are unclear
   - **逐行说明**: every function + non-trivial blocks, Chinese, with line refs (L..)

2. `/workspace/bvn-3.3/reverse/line-by-line/engine/00-BATCH-A-INDEX.md`
   - How shell hands off to MainGame
   - State machine / ctrl overview for this batch
   - Checklist: every listed file done or remaining

3. Optionally append to `/workspace/bvn-3.3/reverse/line-by-line/_maps/ENGINE-NOTES.md` if useful cross-links.

## Rules
- Chinese. Do not modify `decompiled/`. Do not touch play/ or rebuild SWF.
- Do not annotate fighters/ui packages yet (later batches).
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` to stdout after each file so the supervisor sees activity.
- Match quality of existing shell notes (e.g. `reverse/line-by-line/shell/ƃ/FB.md`).

## Done when
Every file in engine-batch-A-files.txt has a non-stub md, and 00-BATCH-A-INDEX.md exists with full checklist.
