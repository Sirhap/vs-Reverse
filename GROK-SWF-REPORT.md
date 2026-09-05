# Bleach vs Naruto 3.3 — SWF inspection report

Inspected the real file at `/workspace/bvn-3.3/main.swf` (byte-identical copy at `/home/box/Downloads/main.swf`). The 67 MB SWF was **not** read as text. Header, tags, ABC string pools, and the inner ZIP were parsed with Python (`struct` + `mmap` + `zipfile`); XML catalogs were read from that ZIP and from `/workspace/bvn-3.3/extracted/assets/`. HTML/JS loader files in this directory were read directly.

## 1. File identity

| Field | Value |
|---|---|
| Path | `/workspace/bvn-3.3/main.swf` |
| Size | 69,431,196 bytes (declared FileLength matches actual size) |
| SHA-256 | `5ddf9410af93872c2b988af81e2580d466cc0f87d5e885198687f129cc00ba3e` |
| Same bytes as | `/home/box/Downloads/main.swf` |
| `file(1)` | Macromedia Flash data, version 14 |
| Signature | `FWS` (uncompressed) |
| SWF version | 14 |
| Stage | 800×600 px (RECT 0,16000,0,12000 twips) |
| Frame rate | 30 fps (`fps_raw` 7680 = 30.0 in 8.8 fixed) |
| Timeline frames | 3 |

Those match the facts given in the prompt. Additional identity from the file itself:

- Document class / frame-1 label: `BleachVSNaruto`
- Game ABC constants: `VERSION = V3.3`, `VERSION_DATE = 2019.3.32`
- HTML wrapper metadata (not inside the SWF): `info.id = BleachVSNaruto_3_3`, `info.version = 3.3.1`, `info.date = 2026-04-11 09:56:02`
- Engine package: `net.play5d.game.bvn` (5DPLAY / 剑jian)

## 2. SWF format (what the bytes actually contain)

This is **not** a conventional timeline cartoon. It is a 3-frame ActionScript 3 wrapper that embeds almost all game data as binary blobs.

### Header

```
offset 0  FWS
offset 3  version = 14
offset 4  FileLength = 69431196 (little-endian UI32)
offset 8  RECT nbits=15, 800×600 px
offset 17 FrameRate = 30.0
offset 19 FrameCount = 3
offset 21 first tag
```

Background color tag: `#000000`. ScriptLimits: MaxRecursionDepth 1000, ScriptTimeoutSeconds 60.

FileAttributes flags byte `0x19`: ActionScript 3 is set, HasMetadata is set, UseDirectBlit/UseGPU are clear. **No Metadata tag (77) is present** despite the HasMetadata bit. ProductInfo (tag 41) is 26 bytes of non-Adobe-looking data (`productId 0x52e60704`); it does not decode to a sensible compile date and is consistent with a third-party packer rather than Flash Professional/Flex.

### Tag inventory (38 tags, file consumed exactly, leftover 0)

| Tag | Count | Role here |
|---|---:|---|
| FileAttributes | 1 | AS3 movie |
| ScriptLimits | 1 | 1000 / 60s |
| SetBackgroundColor | 1 | black |
| ProductInfo | 1 | packer residue |
| FrameLabel | 3 | `BleachVSNaruto`, `FB`, `FC` |
| DoABC | 4 | AVM2 bytecode, all named `merged`, flags=1 (lazy init) |
| SymbolClass | 3 | bind character IDs to AS3 names |
| ShowFrame | 3 | one per timeline frame |
| DefineBitsJPEG2 | 3 | two PNGs + one JPEG (see below) |
| DefineBinaryData | 9 | 65.7 MB assets ZIP + 8 nested UI SWFs |
| DefineSound | 8 | embedded MP3 UI/KO SFX |
| End | 1 | at EOF |

No DefineShape, DefineSprite, DefineFont, PlaceObject, or ExportAssets tags. Graphics and characters live **inside** the ZIP and nested SWFs, not on this timeline.

### Three-frame timeline

| Frame | Label | Payload |
|---:|---|---|
| 1 | `BleachVSNaruto` | DoABC #0 (11,880 bytes) + SymbolClass character 0 → `BleachVSNaruto` |
| 2 | `FB` | DoABC #1 (64,819 bytes, GreenHD loader) + PNG id 1 (128×128) bound as `bvn_png$…` |
| 3 | `FC` | DoABC #2 (8,326 bytes, GreenHD app host) + DoABC #3 (334,334 bytes, **the actual game**) + the ZIP, nested SWFs, sounds, movelist JPEG, remaining SymbolClass |

DoABC #0–#3 all report ABC version **minor 16 / major 46** (standard AVM2).

### SymbolClass (runtime names)

Frame 1: `(0, BleachVSNaruto)` — document class.

Frame 2: `(1, bvn_png$5b80b8dd627c1840714eb0961fe9b705-1455588573)` — 128×128 PNG stored in a DefineBitsJPEG2 tag (starts with `\x89PNG`).

Frame 3 binds 19 symbols, including:

| ID | Bound name | Payload |
|---:|---|---|
| 222 | `assets_zip$1de7dd7d6855592a2a2b869bcaf19a4b1288174545` | ZIP, 65,699,574 bytes, `PK\x03\x04` |
| 225 | `common_ui_swf$…ByteArray` | nested CWS15 UI SWF |
| 226 | `fight_swf$…ByteArray` | nested CWS15 |
| 227 | `gameover_swf$…ByteArray` | nested CWS15 |
| 228 | `howtoplay_swf$…ByteArray` | nested CWS15 |
| 229 | `loading_swf$…ByteArray` | nested CWS15 |
| 2210 | `select_swf$…ByteArray` | nested CWS15 |
| 2211 | `setting_swf$…ByteArray` | nested CWS15 |
| 2215 | `title_swf$…ByteArray` | nested CWS15 |
| 221 | `submitscore_png$…` | 215×75 PNG |
| 2219 | `movelist_jpg$…` | 800×600 JPEG, **byte-identical** to `assets/movelist.jpg` inside the ZIP |
| 223, 224, 2212–2214, 2216–2218 | `snd_menu1/2/5`, `snd_gameover`, `snd_ghost_jump`, `snd_ko`, `snd_ko_bs`, `snd_over_hit` | MP3 DefineSound |

The `$<md5>-<int>` suffixes are Flex/Flash embed hashes, not encryption.

### Nested UI SWFs (DefineBinaryData, all `CWS` version 15)

These are zlib-compressed SWF 15 movies, one version newer than the FWS14 container. All are 800×600.

| ID | Role | Packed | Uncompressed | fps | frames |
|---:|---|---:|---:|---:|---:|
| 225 | common UI | 218,198 | 241,194 | 30 | 2 |
| 226 | fight HUD | 258,845 | 285,649 | 30 | 1 |
| 227 | game over | 245,798 | 256,028 | 30 | 1 |
| 228 | how to play | 237,336 | 265,699 | **24** | 1 |
| 229 | loading | 613,114 | 646,104 | 30 | 2 |
| 2210 | character select | 382,308 | 402,296 | 30 | 1 |
| 2211 | settings | 203,190 | 213,206 | 30 | 1 |
| 2215 | title | 499,256 | 510,867 | 30 | 1 |

Fighter/map SWFs inside the ZIP are also **CWS version 15**. The published container is FP14 only because the GreenHD wrapper is FP14; the playable content targets 15.

## 3. How the HTML / Ruffle loader uses this SWF

Game page named in the prompt: `https://gamebox.bvnplay.online/games/bvn-3.3/index.html`. The copy here is the same layout.

### `index.html`

- Title / keywords: “Bleach vs Naruto 3.3”.
- Full-viewport black `#container` with a `#loading` overlay (`icon.png` + `#label` = `LOADING`).
- Scripts, in order:
  1. `../../local-runtime-guard.js?v=20260711-frame-ready-v2` (a copy also sits next to `index.html` in this workspace)
  2. `main.js`

It never mentions `main.swf` or Ruffle by name. The SWF URL and player are injected by `main.js`.

### `main.js` (4399-style H5 wrapper 4.8.1)

`main.js` is an obfuscated site wrapper (`nativeAppManager`, domain allow-lists, mid-game ads, service worker). After `No.call("ready")` it constructs a Flash/Ruffle player.

Embedded Base64 metadata (decoded from the file):

```json
{
  "info.id": "BleachVSNaruto_3_3",
  "info.developer": "d",
  "info.name": "BleachVsNaruto",
  "info.version": "3.3.1",
  "info.date": "2026-04-11 09:56:02",
  "element.container": "#container",
  "app.size": { "main.swf": 69431196 },
  "app.flashframe": 2
}
```

`info.version 3.3.1` / `info.date 2026-04-11` are **wrapper packaging** stamps. The SWF’s own `VERSION` string is still `V3.3` / `2019.3.32`.

Load path:

1. Detect Shockwave Flash plugin (`navigator.plugins` filename ending `.dll`, or `ActiveXObject("ShockwaveFlash.ShockwaveFlash")`).
2. **If a plugin is present:** insert `<object type="application/x-shockwave-flash">` with `allowFullScreen`, `allowScriptAccess=always`, `allowNetworking=all`, `wmode=opaque`, and a `<param name="movie" value="main.swf">` (default movie name if `app.flash.movie` is unset).
3. **Else if `RufflePlayer` is already defined:** `RufflePlayer.newest().createPlayer()`, fake `nodeName = "EMBED"`, same allow-* attributes.
4. **Else:** dynamically load `../../vendor/ruffle/ruffle.js` (overrideable via `app.ruffle.js`), then create the player. A local `ruffle.js` (460,624 bytes) is present in this directory for that fallback.
5. Fetch `main.swf` with `XMLHttpRequest`, `responseType = arraybuffer`, using `app.size["main.swf"] = 69431196` for progress when `lengthComputable` is false.
6. Call `player.load({ data, allowFullscreen: true, allowNetworking: "all", allowScriptAccess: true, polyfills: false, autoplay: "on", unmuteOverlay: "hidden", deviceFontRenderer: "canvas", splashScreen: false, preloader: false })`.
7. `#loading` is removed once `PercentLoaded` is non-zero and `TGetProperty("/", 12)` (current frame) is `>= app.flashframe - 1`. With `app.flashframe = 2`, the wrapper waits until the SWF has advanced off frame 1 (`FB`), i.e. into the game frame `FC`.

Ruffle config is also forced globally: `RufflePlayer.config.polyfills = false`.

### `ruffle.js` (local copy)

- Size 460,624 bytes; source map `ruffle.js.map`.
- Self-reported: `versionNumber "0.3.0"`, `versionChannel "stable"`, `buildDate "2026-06-14T08:26:54.161Z"`, `commitHash "4d3637f0ab2b0276e00f93a160de545db0f25c66"`.
- Heavy WASM references (expected for Ruffle).

### `local-runtime-guard.js`

Site-specific parent-frame protocol (`channel: bvnplay-runtime`, `protocolVersion: 2`, `releaseId: 20260711-frame-ready-v2`). It:

- Only runs inside an iframe under `/games/bvn-…/` with parent `bvnplay.online` or localhost.
- Posts `progress` / `runtime-visible` / `visual-ready` based on `#label` text (`LOAD RUFFLE`, `LOAD PLAYER`, `LOADING`) and the Ruffle canvas.
- Samples the Ruffle shadow-DOM canvas (96×72, 4 fps) to decide the game has actually painted.
- Injects a tight CSP, hides 4399 launcher/ad chrome (`#m-o`, `#ad-sign`, `#loading-start-button`, …), and redirects blocked network calls to `../../blank-ad.swf` / empty stub URLs.

So: **the HTML never streams fighters separately.** It downloads this one 69.4 MB SWF, hands the bytes to Flash or Ruffle, and treats timeline frame 2 as “player started.” All character/map IO happens *inside* the AVM2 runtime from the embedded ZIP.

## 4. Embedded asset layout

DefineBinaryData id 222 is a ZIP of **407 entries**, all under `assets/`.

| | |
|---|---|
| ZIP payload | 65,699,574 bytes |
| Uncompressed sum | 66,003,663 bytes |
| Compression | 352 stored (method 0), 55 deflated (method 8) — SWFs/MP3s/PNGs are mostly stored |
| Comment | empty |
| DOS dates | peak 2018-07-12 (216 files); configs 2019-04-01 / 2019-04-04 |

Top-level under `assets/`:

| Prefix | Files | Notes |
|---|---:|---|
| `face/` | 258 | portrait PNG variants (`_b` big, `_m` bar, `_w` win) |
| `fighter/` | 41 playable SWFs + 35 `fz/` assist SWFs | CWS15 |
| `map/` | 14 SWFs + 15 PNG thumbs + `random.png` | CWS15 |
| `bgm/` | 21 MP3 | stage/character/UI music |
| `config/` | 8 XML | catalogs below |
| `sounds/` | 3 step MP3 + `sound.xml` | |
| `font/` | `font1.png` + `font1.xml` | bitmap font, 87 glyphs |
| `effect.swf` | 5,195,297 packed / 5,241,984 declared | shared VFX, CWS15 |
| `movelist.jpg` | 350,910 | same bytes as SWF JPEG id 2219 |

Extension mix: 273 PNG, 91 SWF, 24 MP3, 9 XML, 1 JPEG, plus directory markers.

**The XML files already under `/workspace/bvn-3.3/extracted/assets/` are byte-identical to the ZIP copies** (`assist.xml`, `fighter.xml`, `map.xml`, `mission.xml`, `preload.xml`, `salect.xml`, `select.xml`, `font/font1.xml`, `sounds/sound.xml`).

Runtime loading (from ABC #3 strings): `ZipAssetLoader` / `ZipCtrler` wrap **deng.fzip** (`FZip`, `FZipFile`). The embed name `assets_zip$1de7dd7d…` is the class that exposes the ZIP `ByteArray`. `AssetManager` then reads:

- `assets/config/preload.xml`
- `assets/config/fighter.xml`
- `assets/config/assist.xml`
- `assets/config/select.xml`
- `assets/config/salect.xml` (yes, both; the misspelling is in the SWF)
- `assets/config/map.xml`
- `assets/config/mission.xml`
- `assets/font/font1.xml`
- `assets/effect.swf`

Fighter/map SWFs and face PNGs are pulled from the same ZIP by the URLs in those XML files. They are **not** separate HTTP resources.

## 5. Fighters, maps, missions

### `fighter.xml` — 56 playable defs + 3 random slots

`comic_type="0"` = Bleach side, `"1"` = Naruto side. Several skins share one SWF via `startFrame`.

**Bleach (28 defs, including Kenshin crossover):**
`ichigo` (frames 1–4: base / 卍解 / 半虚 / 虚化), `ichigo_zero` (1–3: 零段 / 内虚 / 内虚卍解), `rukia` + `rukia_shijie`, `renji`, `kenpachi`, `ikkaku`, `yin`, `chad`, `uryuu`, `toushirou` + `toushirou_wanjie`, `byakuya` + `byakuya_wanjie`, `ulquiorra` + `ulquiorra_guiren`, `aizen`, `mayuri`, `orihime`, `grimmjow`, `soifon`, `kenshin` + `kenshin_bdz`.

**Naruto (28 defs):**
`naruto` (base / 一尾 / 四尾), `sakura`, `sasuke` + `sasuke_zy`, `sasuke_xz`, `karin`, `juggo`, `itachi`, `didala`, `kakashi`, `kakashi_sw` (神威, own SWF), `lee` + `lee_dm`, `neji`, `gaara`, `temari`, `jiraiya`, `orochimaru`, `killerbee`, `pain`, `konan`, `naruto_xianren` + `naruto_gold` (`naruto_xr.swf`), `obito` + `obito_s2`, `madara`.

Random sentinels: `random` / `random_bleach` / `random_naruto`.

40 unique fighter SWFs. Largest: `madara.swf` 3,567,956; `soifon.swf` 2,933,390; `naruto_xr.swf` 2,132,377. `sasuke_xz_old.swf` (1,920,610) is in the ZIP but **not referenced** by `fighter.xml`.

In-SWF changelog string (ABC #3), matching this roster:

```
3.3更新：
增加人物：碎蜂、一护·半虚（原虚化一护改为4段）、卡卡西·神威
重制人物：佩恩, 部分人物增加钢身招式
增加辅助人物：朽木·白哉
重制辅助人物：夜一, 部分辅助增加BUFF效果
增加音量设置功能，增加一护的虚化变身（S+WJ）
修复许多已知BUG
```

### `select.xml` vs `salect.xml`

Both are 7×10 grids (800×600 layout). `select.xml` is the 3.3 grid: **51 filled cells** (48 fighters + 3 random). Empty holes sit around Aizen/Kenshin/Madara and the random row. Assist sub-grid is in the same file (`<assist_list>`).

`salect.xml` is an older/alternate grid (50 filled, different placement, `top="50"` vs `top="100"`). The engine references **both** filenames; `select.xml` is the one that matches the published 3.3 roster (Soi Fon + Kakashi Kamui + Half-Hollow Ichigo).

### `assist.xml` — 34 real assists + 3 random

Files live under `assets/fighter/fz/`. Bleach 18 / Naruto 16. Includes crossovers `stake` (Tony Stark) and `shishio` (Rurouni Kenshin). Id `garra` (typo) points at `gaara.swf`. Duplicate assist SWFs `soifon.swf` and `soifong.swf` both exist (~308,167 bytes).

### `map.xml` — 14 stages + random

| id | name | BGM |
|---|---|---|
| random | 随机场景 | (thumb only) |
| xianshi | 现世 | city.mp3 |
| liuhunjie | 流魂街 | village.mp3 |
| jingyantin | 静涎亭 | wind.mp3 |
| shuangji | 双极 | wind.mp3 |
| shihunjietongdao | 尸魂界通道 | shandong.mp3 |
| jianchang | 斩魂刀冢 | wind.mp3 |
| zoulang | 十三番队 | village.mp3 |
| muyecun | 木叶村 | village.mp3 |
| wenquan | 温泉 | water.mp3 |
| pubu | 火影瀑布 | pubu.mp3 |
| louding | 楼顶 | wind.mp3 |
| yuzhibocun | 宇智波村 | village.mp3 |
| senlin | 森林 | wind.mp3 |
| wuyingcun | 水影村 | village.mp3 |

Each playable map is `assets/map/<id>.swf` + `assets/map/<id>.png`.

### `mission.xml` (root tag is the misspelling `<mession>`)

Four 8-stage arcade routes:

| comicType | gameMode | Side playing | Boss-ish last stages |
|---:|---:|---|---|
| 0 | 0 TEAM | Bleach fights Naruto cast | itachi ×2/×2, pain/konan 1.2, madara 1.5/2 |
| 0 | 1 SINGLE | same order, no HP/ATK multipliers except as omitted | madara |
| 1 | 0 TEAM | Naruto fights Bleach cast | ichigo_xuhua 1.5, ulquiorra/yin 1.2, aizen 1.5/2 |
| 1 | 1 SINGLE | same order, flat stats | aizen |

`MessionModel` / `MessionVO` in ABC keep that spelling.

### `preload.xml`

Preloads UI BGM (`loading`, `op`, `select`, `continue`, `back`, `congratulation`, `win`, `winloop`) and the three step sounds.

## 6. What else the file revealed (not in the prompt)

**GreenHD packer, not a raw 5DPLAY publish.** ABC #1/#2 live in `com.green.method` / `com.green.net` / `com.green.effect:LoadingWin` / `com.green.utils:SWF`. Strings include `http://www.greenhd.net/ns/greenload`, LocalConnection names `bleachvsnaruto`, `_app_to_manager` / `_manager_to_app`, anti-pack checks (`"No running in a loader."` / `不允许加壳运行`), and a Flash-version HTML error page. Frame labels `FB`/`FC` are that loader’s bootstrap, not game scenes.

**4399 arcade hooks still compiled in.** `Ctrler4399`, `SubmitScoreBtn`, `logo4399`, `in4399`, `ready4399`, `_4399_function_score_id`, `submitScore`, `moreGames`, plus the 215×75 `submitscore` PNG. The HTML guard actively suppresses the matching DOM ads when this build is iframed on bvnplay.online.

**Save / config.** `KyoSharedObject` + `SharedObject`; `GameConfig` fields `AI_LEVEL`, `volume`, `key_p1`, `key_p2`, `QUALITY`. Shared-object-ish string `bvn3.01` is present.

**Libraries inside ABC #3:** TweenMax (`com.greensock.*`), deng.fzip, `com.adobe.utils`, `fl.motion`. Game states: `LogoState`, `MenuState`, `LoadingState`, `SelectFighterStage`, `SettingState`, `HowToPlayState`, `GameState`, `GameOverState`, `WinnerState`, `CongratulateState`, `CreditsState`. Modes include `TRAINING`.

**Inner content is SWF15, wrapper is SWF14.** Ruffle must handle both the uncompressed FWS14 shell and zlib CWS15 loads from ByteArrays (`loadBytes` appears in the GreenHD ABC).

**Workspace companions (not part of the runtime):**

| File | What it is |
|---|---|
| `main.swf.4mb` | first 4,194,304 bytes of `main.swf` (MD5 of that prefix matches) |
| `main.swf.hdr` | first 256 bytes |
| `main.swf.zip` | PKZIP of the same `main.swf` (compressed 69,029,048) dated 2026-08-31 |
| `swf-tail.bin` | 2,230,001 bytes, **not** the SWF’s actual tail (different bytes) |

## 7. Method notes / limits

- Parsed every SWF tag; counted 38; verified End sits at EOF.
- Opened the 65.7 MB inner ZIP in-memory; listed all 407 names and sizes; hashed XML against `extracted/`.
- Parsed ABC **string pools only** (not full multiname/bytecode CFG). Class names and file paths above come from those pools.
- Nested CWS files were zlib-decompressed just far enough to read stage/fps/frames; they were not tag-walked.
- No browser/Ruffle execution in this pass; loader behavior is from reading `index.html`, `main.js`, `ruffle.js`, and `local-runtime-guard.js`.

## 8. Short architecture

```
index.html
  ├─ local-runtime-guard.js   iframe progress + ad/CSP lock
  └─ main.js  (wrapper 4.8.1)
       ├─ Flash plugin object  OR
       └─ ruffle.js 0.3.0 (2026-06-14) → load arraybuffer
            └─ main.swf  FWS14, 800×600, 30 fps, 3 frames
                 frame1 BleachVSNaruto   document stub
                 frame2 FB               GreenHD loader + 128px PNG
                 frame3 FC               GreenHD host
                                         + net.play5d.game.bvn (V3.3)
                                         + assets_zip (407 files)
                                         + 8 CWS15 UI movies
                                         + KO/menu MP3s
```

The 69.4 MB download **is** the game: catalogs, fighters, maps, music, and UI are inside it. The HTML/Ruffle layer only fetches that one file, waits until timeline frame 2, and paints the AVM2 stage.
