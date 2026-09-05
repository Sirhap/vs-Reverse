# `movie_howtoplay` — 操作说明演示根 MC

一句话目的：`howtoplay` SWF 主导出。闯关开局前播一段键位演示；引擎把 P1 键名填进 10 个 `TextField`，可点 `skip_btn` / 按返回·确认跳 `"skip"`，播完 `Event.COMPLETE` → 选人。

源文件：`decompiled/ui/howtoplay/scripts/movie_howtoplay.as`（52 行）

## 如何挂上引擎

[`HowToPlayState.build`](../../../engine/game/bvn/state/HowToPlayState.md)：

```
createDisplayObject(ResUtils.I.howtoplay, "movie_howtoplay")
addEventListener("complete", uiComplete)
gotoAndPlay(2)    // 跳过 F1 stop
```

入口：[`MenuBtnGroup`](../../../engine/game/bvn/ui/MenuBtnGroup.md) 选 `TEAM ACRADE` / `SINGLE ACRADE` 且 `GameConfig.SHOW_HOW_TO_PLAY`（默认 true）→ `MainGame.goHowToPlay()` → FPS 30。对战/练习不进本页。

SWF 头 `fps=24`，引擎 `setFPS(30)`，演示会比 FLA 略快。

`Istage.display` 返回本 MC。BGM `"back"`。

SWF：`howtoplay_swf`（DefineBinaryData id 228），链接名 `movie_howtoplay`，`symbol="symbol450"`。Sprite id=450，共 **1223** 帧。AS 类只有 F1 / F1211 脚本；标签 `"skip"` / `"destory"` 只在 SWF `FrameLabel`（`extracted/full/swf/bin_228.swf`），本 AS 无字面量。

嵌套导出：[`howtoplay_fla.arrow020321_6`](howtoplay_fla/arrow020321_6.md)（指向箭头，时间轴多次放置）、[`howtoplay_fla.元件48_11`](howtoplay_fla/元件48_11.md)（约 F926 PlaceObject3）。引擎不按名字 `createDisplayObject` 它们。

## 时间轴（按标签分组）

`addFrameScript` 0-based：`N` = `F{N+1}`。

| 段 | 帧 | 脚本 / 标签 | 引擎 |
|----|----|-------------|------|
| 停帧 | **F1** | `frame1`：`stop()` | 构造停在这。`build` `gotoAndPlay(2)` 跳过 |
| 演示正文 | F2 → F1210 | 无脚本。键位字幕、角色演示、箭头 | 正常路径一直播 |
| `"skip"` | **F1199** | 仅 FrameLabel | `render` 里 back/select，或 `skip_btn` click → `gotoAndPlay("skip")`。约 12 帧接到末帧 |
| `"destory"` / COMPLETE | **F1211** | `frame1211`：`stop` + `Event.COMPLETE`；同帧也是标签 `"destory"` | 正常播完和 skip 都落到这里 → `uiComplete` → `goSelect`。`destory()` `gotoAndStop("destory")` 停在同一帧 |

skip 不在 click 里 `goSelect`，等 COMPLETE。`destory` 先卸 complete 监听再 `gotoAndStop("destory")`，避免销毁时再进选人。

**1000ms** 后才 `GameRender.add(render)`、开输入、给 `skip_btn` 挂 click。入场约 1 秒不能 skip。

## 字段：每个文本槽 + skip_btn

全部在 F1 已放置。引擎 `setKeyText`：`KyoKeyCode.code2name(code)` 有返回才写 `.text`，未知键码（含空格）保持 SWF 默认字。只填 **P1**（`GameData.I.config.key_p1`），无 P2。

| L | 名字 | 类型 | `KeyConfigVO` | 默认 P1（`setDefaultConfig`） |
|---|------|------|---------------|------------------------------|
| L32 | `txt_up` | `TextField` | `up` | W |
| L20 | `txt_down` | `TextField` | `down` | S |
| L24 | `txt_left` | `TextField` | `left` | A |
| L26 | `txt_right` | `TextField` | `right` | D |
| L14 | `txt_attack` | `TextField` | `attack` | J |
| L22 | `txt_jump` | `TextField` | `jump` | K |
| L18 | `txt_dash` | `TextField` | `dash` | L |
| L28 | `txt_skill` | `TextField` | `skill` | U |
| L16 | `txt_bisha` | `TextField` | **`superKill`**（字段名不是 bisha） | I |
| L30 | `txt_special` | `TextField` | **`beckons`**（召唤/辅助） | O |
| L12 | `skip_btn` | `SimpleButton` | — | F1 放置（DefineButton2 id 36）。1000ms 后听 `"click"` → `skipBtnHandler` |

[`KyoKeyCode.code2name`](../../../engine/kyo/input/KyoKeyCode.md) 表外码返回 `null`，本页不写、不抛。必杀槽叫 `txt_bisha`、数据叫 `superKill`；特殊槽 `txt_special` ← `beckons`。

键盘 skip：`GameInputer.back(1)` **或** `GameInputer.select("MENU", 1)`，与鼠标同一 `gotoAndPlay("skip")`。

## 逐行说明

### 包与 Embed（L1–9）

无名包。`MovieClip`、`SimpleButton`、`Event`、`TextField`。[Embed] `source="/_assets/assets.swf", symbol="symbol450"`。`public dynamic class movie_howtoplay extends MovieClip`。

### 字段（L12–32）

见上表。10 个 `TextField` + 1 个 `SimpleButton`。无其它公开槽。

### 构造 `movie_howtoplay()`（L34–38）

- L36: `super();`
- L37: `addFrameScript(0, this.frame1, 1210, this.frame1211);`
  - **addFrameScript 0 = F1**
  - **addFrameScript 1210 = F1211**

### `frame1`（L40–43）

- L42: `stop();` —— 库预览/未 `play` 时停在第一帧。引擎必须 `gotoAndPlay(2)` 才开演。本帧 **不** 派 COMPLETE。

### `frame1211`（L45–49）

- L47: `stop();` —— 锁末帧。
- L48: `dispatchEvent(new Event(Event.COMPLETE));` —— type `"complete"` → `HowToPlayState.uiComplete` 卸监听后 `MainGame.I.goSelect()`。

同帧 SWF 标签 `"destory"`（拼写保留，贯穿引擎）。[`HowToPlayState.destory`](../../../engine/game/bvn/state/HowToPlayState.md)：停 BGM、卸 render、卸 complete、`gotoAndStop("destory")`。不摘 `skip_btn` click。不调 `param1`。
