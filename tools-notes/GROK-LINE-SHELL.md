# Task: line-by-line reverse of GreenHD / shell AS3

User goal: understand EVERY line of BVN 3.3 decompiled code. Start with the obfuscated shell.

## Inputs (read-only sources)
- File list: `/workspace/bvn-3.3/reverse/line-by-line/_maps/shell-files.txt`
- Sources under `/workspace/bvn-3.3/decompiled/main/scripts/`
- Existing notes: `/workspace/bvn-3.3/reverse/02-greenhd.md`, `/workspace/bvn-3.3/BVN-REVERSE.md`

## Outputs (write these)
1. `/workspace/bvn-3.3/reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md`
   - Table: obfuscated name → suggested clear name → role (class/method/field)
   - Cover every public/private type and important methods you encounter in the shell files.

2. For EACH `.as` in the shell file list, write an annotated markdown sibling under:
   `/workspace/bvn-3.3/reverse/line-by-line/shell/`
   Mirror relative path, e.g. `com/green/net/ǽ.md`, `ƃ/FB.md`, `ɕ/ȑ.md`.
   Each file MUST contain:
   - One-line purpose
   - Callers / callees (what calls this, what it calls)
   - Symbol rename table for identifiers used in THIS file
   - Section **逐行说明**: walk the file in order; for every function and every non-trivial statement block, explain what it does in Chinese. Empty braces / trivial getters can be one short line. Do not skip functions.

3. `/workspace/bvn-3.3/reverse/line-by-line/shell/00-INDEX.md`
   - Boot order through the shell into MainGame
   - Checklist of all annotated files (relative paths)

## Rules
- Chinese prose for explanations.
- Do not modify `decompiled/` sources (annotation only in `reverse/line-by-line/`).
- Do not rebuild SWF / do not touch play/.
- Prefer accuracy over guessing; if a symbol is unclear, mark `?` and say why.
- Finish the ENTIRE shell file list in this run if possible; if time-box hits, complete FB.as, ȑ.as, and all `com/green/**` first, then remaining unicode packages, and note remaining paths in 00-INDEX.md.

## Done when
- 00-INDEX.md exists and lists every shell `.as` as done or explicitly remaining.
- SHELL-SYMBOL-MAP.md exists with substantial renames.
- At least all `com/green/**`, `ƃ/FB.as`, `ɕ/ȑ.as` have full 逐行说明 md files.
