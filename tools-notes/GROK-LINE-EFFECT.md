# Task: line-by-line reverse — effect Batch

Shell + net.play5d engine (A–D) + fighters Batch A–G + UI are DONE.
Continue 长城任务 with **`decompiled/other/effect/**` only**.

## File list (ONLY this batch)
`/workspace/bvn-3.3/reverse/line-by-line/_maps/effect-batch-files.txt`
Effect SWF scripts under `decompiled/other/effect/scripts/` (~89 `.as`).

## Outputs
1. For EACH `.as` in the list, write annotated md under:
   `/workspace/bvn-3.3/reverse/line-by-line/effect/`
   Mirror path after `decompiled/other/effect/`, e.g.
   - `scripts/XG_baoqi.md`
   - `scripts/xg_buff_effect_power.md`
   - `scripts/bisha_face_mc.md`
   Each file (Chinese):
   - One-line purpose
   - How it hooks engine (`EffectCtrl`, `EffectManager`, `EffectVO` / `EffectModel`, `EffectView` family, fighter `$effect_ctrler` / hit sparks / bisha face)
   - **逐行说明**: every function + non-trivial frame/action blocks with L.. refs
   - Tiny stubs / pure artwork clips may be short (purpose + size + export / linkage), still one md each
   - Clips with labels or multi-frame FX: group by label/frame; document spawn, loop, fade, attach point if present

2. `/workspace/bvn-3.3/reverse/line-by-line/effect/00-INDEX.md`
   - Overview of effect SWF linkages and how they map to engine Effect* classes
   - Shared patterns (hit sparks, element FX, buff, bisha face, assist FX)
   - Checklist: every listed file done or remaining

3. Update `/workspace/bvn-3.3/reverse/line-by-line/ui/00-INDEX.md` and `fighters/00-INDEX.md` only to note effect in progress / done — do not reopen those batches.

## Quality reference
Match UI/fighters annotation depth. Cross-link engine docs under:
`reverse/line-by-line/engine/game/bvn/ctrl/EffectCtrl.md`,
`utils/EffectManager.md`, `data/EffectVO.md`, `data/EffectModel.md`,
`views/effects/*`.

## Rules
- Chinese. Do not modify `decompiled/`. No play/rebuild SWF.
- ONLY paths in effect-batch-files.txt — do not re-annotate ui / fighters / engine / shell.
- Prefer accuracy; mark `?` when unsure.
- Echo `PROGRESS: wrote <path>` after each file.

## Done when
Every path in effect-batch-files.txt has a non-stub md + `effect/00-INDEX.md` checklist complete (89/89).
