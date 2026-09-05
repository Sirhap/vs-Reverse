# `HowToPlayState` — 操作说明（howtoplay_swf）

一句话目的：闯关开局前的操作演示。播 `howtoplay_swf` 的 `movie_howtoplay`，把 P1 键位写进字幕，可 skip，播完 `goSelect()`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/HowToPlayState.as`（104 行）

## Callers / callees

- **Callers**：`MainGame.goHowToPlay()` → `goStage(new HowToPlayState())` + `setFPS(30)`。仅 `MenuBtnGroup` 在 `TEAM ACRADE` / `SINGLE ACRADE` 且 `GameConfig.SHOW_HOW_TO_PLAY`（默认 true）时进入。对战/练习直接 `goSelect`。
- **Callees**：`ResUtils.I.howtoplay`（嵌入 `howtoplay_swf`）；`SoundCtrl.BGM("back")`；`GameData.I.config.key_p1`；`KyoKeyCode.code2name`；`GameRender` / `GameInputer`；结束 `MainGame.I.goSelect()`。
- **UI**：`movie_howtoplay` — 帧 1 `stop`，帧 1211 `stop` + `COMPLETE`；公开 `skip_btn` 与 `txt_up/down/left/right/attack/jump/dash/skill/bisha/special`。时间轴标签 `"skip"` / `"destory"` 只在 SWF 里，AS 导出类未见。

## 命名备注

- `destory` 拼写保留；时间轴也有同名标签 `"destory"`。
- 必杀文本槽是 `txt_bisha`，数据字段是 `KeyConfigVO.superKill`；特殊/辅助是 `txt_special` ← `beckons`。
- 只展示 **P1** 键位，没有 P2。

## 逐行说明

### 字段 / 构造（L22–27）

`_ui:movie_howtoplay`。构造空。

### `display`（L29–32）

返回 `_ui`。

### `build`（L34–59）

1. `createDisplayObject(howtoplay, "movie_howtoplay")`。
2. 听 `"complete"` → `uiComplete`；`gotoAndPlay(2)` 跳过帧 1 stop。
3. BGM `"back"`。
4. `kc = GameData.I.config.key_p1`，逐槽 `setKeyText`：方向、攻击、跳、冲、技能、必杀、特殊。
5. **1000ms 后**才 `GameRender.add(render)`、`GameInputer.focus/enabled`、给 `skip_btn` 挂 click。入场约 1 秒内不能 skip。

### `render`（L61–67）

`GameInputer.back(1)` **或** `GameInputer.select("MENU", 1)` → 卸 render，`_ui.gotoAndPlay("skip")`。skip 段播完仍应落到帧 1211 `COMPLETE`（时间轴约定，AS 未验证）。

### `skipBtnHandler`（L70–74）

鼠标点 skip：同样卸 render + `gotoAndPlay("skip")`。不在这里 `goSelect`，等 `complete`。

### `uiComplete`（L76–80）

卸 complete 监听，`MainGame.I.goSelect()`。正常播完和 skip 都走这里。

### `setKeyText`（L82–89）

`KyoKeyCode.code2name(code)` 有返回才写 `TextField.text`；未知键码保持 SWF 默认字。

### `afterBuild`（L91–93）

空。

### `destory`（L95–101）

`BGM(null)` 停背景；`GameRender.remove(render)`；卸 complete；`gotoAndStop("destory")` 停在销毁帧。不卸 `skip_btn` 的 click。不调 `param1`。
