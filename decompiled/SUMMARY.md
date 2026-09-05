# BVN 3.3 ActionScript 3 decompile summary

- Finished: 2026-09-01 03:29 CST (UTC+8)
- Output: `/workspace/bvn-3.3/decompiled/`
- Downloads: `/home/box/Downloads/bvn-3.3-decompiled` → this directory
- Originals were not modified (`/workspace/bvn-3.3/main.swf`, `extracted/full/`)

## Tools

| Tool | Version / path |
|------|----------------|
| OpenJDK JRE | 21.0.12.1+1 (Debian package `openjdk-21-jre-headless`; binary `/usr/lib/jvm/java-21-openjdk-amd64/bin/java`) |
| JPEXS FFDec | 26.2.1 (`/workspace/tools/ffdec/ffdec.jar`, zip from GitHub `jindrapetrik/jpexs-decompiler` release `version26.2.1`) |

CLI (ActionScript source, not p-code):

```
java -jar ffdec.jar \
  -config autoDeobfuscate=1,parallelSpeedUp=1 \
  -format script:as -onerror ignore \
  -timeout 30 -exportFileTimeout 90 \
  -export script OUT_DIR FILE.swf
```

Main.swf used `-timeout 60 -exportFileTimeout 120`. FFDec default script format is AS3 source (`script:as`).

No fallback ABC decompiler was needed. FFDec ran successfully.

## Totals

| Metric | Count |
|--------|------:|
| Unique SWFs decompiled | 100 (1 main + 76 fighters + 14 maps + 8 UI + 1 effect) |
| FFDec export failures | **0** |
| `.as` files total | **894** |
| `net.play5d` appeared | **yes** — 181 `.as` files under `main/scripts/net/play5d/` (symlink `main/net` → `scripts/net`) |
| Nested-SWF duplicates skipped | 99 files in `extracted/full/nested-swf/*.swf` (copies of zips/bin_222 + UI bins) |

FFDec writes scripts under a `scripts/` subdirectory of each output folder.

## 1. main/ — engine (`main.swf`)

- Source: `/workspace/bvn-3.3/main.swf` (FWS v14, 69,431,196 bytes; 4 DoABC tags)
- Status: **OK** in 6.754s
- Scripts exported: **264 / 264**
- `net.play5d*.as`: **181**
- Notable: `MainGame.VERSION = "V3.3"`

Packages under `decompiled/main/scripts/net/play5d/`:

- `game/bvn/` — engine: `MainGame`, `GameConfig`, ctrl, data, fighter, input, map, state, ui, views, web, events, interfaces, utils
- `kyo/` — shared display/loader/stage/utils

Also present (not play5d):

- `com.greensock` (TweenLite), `deng.fzip` (FZip), `fl.motion`, `com.adobe.utils`
- Obfuscated identifier packages (`com.green.*`, `com.sh.*`, single-character package names) — FFDec auto-deobfuscate left those class names as stored in ABC
- Symbol-class stubs for embedded ZIP/SWF/PNG/sound assets

## 2. fighters/ — 76 character SWFs

Source: `/workspace/bvn-3.3/extracted/full/zips/bin_222/assets/fighter/*.swf` (+ `fz/`).

- Status: **all OK**
- `.as` files: **468**
- Layout: `fighters/<name>/scripts/` and `fighters/fz/<name>/scripts/`
- Typical content: `*_fla.MainTimeline` plus clip/sound document classes (animation timeline AS3), not the engine

Playable fighters (41) `.as` counts: aizen 10, byakuya 9, chad 5, didala 6, gaara 9, grimmjow 11, ichigo 23, ichigo_zero 24, ikkaku 7, itachi 14, jiraiya 8, juggo 8, kakashi 10, kakashi_sw 6, karin 9, kenpachi 9, kenshin 9, killerbee 5, konan 6, lee 14, madara 8, mayuri 12, naruto 18, naruto_xr 15, neji 12, obito 12, orihime 10, orochimaru 9, pain 17, renji 7, rukia 8, sakura 7, sasuke 11, sasuke_xz 9, sasuke_xz_old 9, soifon 11, temari 6, toushirou 12, ulquiorra 10, uryuu 11, yin 9.

Assist / fz (35): mostly 1–2 `.as` files each (document class only).

## 3. maps/ — 14 map SWFs

Source: `extracted/full/zips/bin_222/assets/map/*.swf`.

- Status: **all OK** (FFDec export succeeded)
- `.as` files: **0**
- These SWFs have display/animation assets only (no DoABC / no timeline scripts). Empty `scripts/` dirs are expected, not failures.

Maps: jianchang, jingyantin, liuhunjie, louding, muyecun, pubu, senlin, shihunjietongdao, shuangji, wenquan, wuyingcun, xianshi, yuzhibocun, zoulang.

## 4. ui/ — 8 nested UI SWFs

Source: `extracted/full/swf/bin_*.swf` (DefineBinaryData ids), named from main SymbolClass.

| Output dir | Source | Symbol | `.as` |
|------------|--------|--------|------:|
| ui/common_ui | bin_225.swf | common_ui_swf | 8 |
| ui/fight | bin_226.swf | fight_swf | 33 |
| ui/gameover | bin_227.swf | gameover_swf | 1 |
| ui/howtoplay | bin_228.swf | howtoplay_swf | 3 |
| ui/loading | bin_229.swf | loading_swf | 12 |
| ui/select | bin_2210.swf | select_swf | 8 |
| ui/setting | bin_2211.swf | setting_swf | 5 |
| ui/title | bin_2215.swf | title_swf | 3 |
| **ui total** | | | **73** |

All OK.

## 5. other/

| Output | Source | `.as` | Status |
|--------|--------|------:|--------|
| other/effect | `zips/bin_222/assets/effect.swf` (5.2 MB) | 89 | OK |

## Skipped (duplicates only)

Not decompiled a second time (same bytes as zips/ + swf/ originals above):

- `extracted/full/nested-swf/zips__bin_222__assets__fighter__*.swf`
- `extracted/full/nested-swf/zips__bin_222__assets__map__*.swf`
- `extracted/full/nested-swf/zips__bin_222__assets__effect.swf`
- `extracted/full/nested-swf/swf__bin_*.swf`

No unique SWFs were skipped for speed. All 100 unique files finished.

## Failures

**None.** Every unique SWF returned FFDec `OK`. Maps with 0 scripts are asset-only, not errors.

Per-file log: `decompiled/_results.tsv` (status, name, as-count, seconds). JVM logs: `decompiled/_logs/`.

## Notes

- FFDec `autoDeobfuscate=1` was on. Many third-party / loader class names in main remain obfuscated Unicode identifiers as stored in ABC; `net.play5d.*` names were already readable.
- Originals under `bvn-3.3/main.swf` and `extracted/full/` were only read.
