# Task: finish shell line-by-line reverse (3 files + index)

Prior run wrote most of `/workspace/bvn-3.3/reverse/line-by-line/shell/` and a full `SHELL-SYMBOL-MAP.md`. Do NOT rewrite finished files unless a stub is empty.

## Still missing (ONLY these)
1. `/workspace/bvn-3.3/reverse/line-by-line/shell/ƒ/Ǵ.md`  ← source `decompiled/main/scripts/ƒ/Ǵ.as`
2. `/workspace/bvn-3.3/reverse/line-by-line/shell/ƒ/ǵ_2.md` ← source `decompiled/main/scripts/ƒ/ǵ_2.as` (FrameManager — critical)
3. `/workspace/bvn-3.3/reverse/line-by-line/shell/ɕ/ȑ.md` ← source `decompiled/main/scripts/ɕ/ȑ.as` (FC host — critical)
4. `/workspace/bvn-3.3/reverse/line-by-line/shell/00-INDEX.md`

## Format (same as existing siblings e.g. `ƃ/FB.md`)
- One-line purpose (Chinese)
- Callers / callees
- Symbol rename table for THIS file (or pointer into SHELL-SYMBOL-MAP)
- Section **逐行说明**: every function + non-trivial blocks, Chinese. Use line refs like L85–219.

## Also
- Append any new renames into `/workspace/bvn-3.3/reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md` if missing for these three classes.
- `00-INDEX.md`: boot order FM→FA→FB→FC→MainGame; checklist of all 25 shell `.as` as done (paths relative to shell/).

## Rules
- Chinese. Do not modify `decompiled/`. Do not touch play/ or rebuild SWF.
- Prefer accuracy; mark `?` when unsure.
- While working, periodically `echo PROGRESS: wrote X` to stdout so the supervisor sees activity (stdout was buffered empty last run).

## Done when
All four paths above exist and the three class md files have substantial 逐行说明 (not stubs).
