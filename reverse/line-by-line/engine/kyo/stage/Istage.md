# `Istage` — 舞台状态接口

一句话目的：`KyoStageCtrl` 能切换的一屏。四个方法：取出显示对象、构建、上屏后、销毁。本引擎所有 `state.*` 都实现它。

源文件：`decompiled/main/scripts/net/play5d/kyo/stage/Istage.as`（18 行）

## Callers / callees

- **实现**（13 个，Batch A）：
  - `LogoState`、`MenuState`、`HowToPlayState`、`SelectFighterStage`、`LoadingState`、`GameState`、`SettingState`、`GameOverState`、`WinnerState`、`CreditsState`、`CongratulateState`、`GameLoadingState`
  - `MenuState` / `GameState` 同时 `extends Sprite`，其它多数组合一个内部 Sprite
- **消费者**：`KyoStageCtrl.goStage` / `addLayer` / `removeLayer` / `clean`；`MainGame.stageCtrl` 间接。
- **Callees**：`flash.display.DisplayObject`。

## 命名备注

`destory`：destroy 的原拼写。全引擎沿用（`FighterMain.destory`、`BitmapText.destory` 等）。接口第四个方法带可选回调 `Function = null`，给 `goStage(..., buildAfterDestory=true)` 用；本游戏 **从不** 传 true，所以实现里回调几乎都空着。

接口名小写 `s`（`Istage` 不是 `IStage`）。

## 逐行说明

### `get display`（L7）

返回要 `addChild` 到 `_mainStage` 的显示对象。`KyoStageCtrl.goStage` 在 `build()` **之后** 才读它（L65），所以 `build` 必须先把 display 造好。`MenuState` / `GameState` 自身就是 Sprite，`display` 返回 `this`。

### `build`（L9）

同步构造 UI。此时 display 还没上屏。`KyoStageCtrl` 调完立刻 `addChild`。

### `afterBuild`（L11）

display 已在显示列表。适合挂 `ENTER_FRAME`、播入场动画、开始输入。`goStage` 同步调用，无淡入。

`addLayer` 路径：若给了 `IStageFadEffect`，`afterBuild` 推迟到 `fadIn` 完成；本 SWF **没有** `IStageFadEffect` 实现，且 `addLayer` 本包零调用。

### `destory`（L13）

`param1` 完成回调。`goStage` 默认路径（`buildAfterDestory=false`）调 `destory()` 无参，然后立刻 `removeChild`。实现必须能在无回调时工作。

`removeLayer` 是先 `removeChild` 再 `destory()`（顺序与 `goStage` 相反）。
