# `LogoState` — 片头 Logo，播完进主菜单

一句话目的：启动完成后的第一屏。播 `common_ui` 里的 `logo_movie`，片头 `complete` 后 `MainGame.goMenu()`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/LogoState.as`（47 行）

## Callers / callees

- **Callers**：`MainGame.goLogo()` → `stageCtrl.goStage(new LogoState())`。入口：`bleachvsnaruto_2.initBackHandler` 在 `GameUtils.isInTop` 后调 `goLogo`（`GameLoadingState` 成功之后）。通关 `CongratulateState.selectBtnHandler`、`GameOverState` 也会 `goLogo`。
- **Callees**：`ResUtils.I.createDisplayObject(common_ui, "logo_movie")`；`MainGame.I.goMenu()`。UI 类 `logo_movie`（common_ui SWF）：帧 1 `stop`，帧 66 `stop` + `Event.COMPLETE`。
- **Istage 交接**：`KyoStageCtrl.goStage`：若已有当前舞台则 `destory()`（不等回调）→ `removeChild(display)` → `build()` → `addChild(display)` → `afterBuild()`。同类名默认拒绝重入（`sameChange=false`）。`goLogo` 顺带 `setFPS(30)`。

## 命名备注

- 接口是 `Istage`（不是 `IStage`）。销毁方法是 `destory`（不是 destroy）。
- `MainGame.initlize`（不是 initialize）里先挂 `GameLoadingState`，**不是**本类。
- `_ui:logo_movie` 由嵌入 SWF 导出；本文件只听 `"complete"`。

## 逐行说明

### 字段 / 构造（L12–17）

- `_ui`：片头 MC。`display` 返回它，所以 `goStage` 必须先 `build()` 再 `addChild`。
- 构造空，`super()` 即可。

### `display`（L19–22）

舞台根显示对象。未 `build` 时为 `null`。

### `build`（L24–29）

1. 从 `ResUtils.I.common_ui` 取出导出名 `"logo_movie"`。
2. 听 `"complete"` → `playComplete`。
3. `gotoAndPlay(2)`：跳过帧 1 的 `stop`，播到帧 66。

### `playComplete`（L31–35）

卸监听后 `MainGame.I.goMenu()`。`goMenu` 会再 `goStage(new MenuState())`，从而 `destory` 本状态。

### `afterBuild`（L37–39）

空。显示对象已在 `goStage` 里 addChild。

### `destory`（L41–44）

只卸 `complete` 监听。不调 `param1` 回调（`goStage` 默认也不等它）。不 `stop` 时间轴；`KyoStageCtrl` 随后 `removeChild(_ui)`。
