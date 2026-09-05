# `IGameUI` — 战斗 HUD 接口

一句话目的：`GameUI` 内部持有的战斗 UI 契约。本包唯一实现是 `FightUI`（`ui.fight`）。开场/KO/连击数/暂停都经此，不经 `GameUI` 包装方法。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/IGameUI.as`（36 行）

## Callers / callees

- **实现**：仅 `FightUI implements IGameUI`。
- **持有**：`GameUI._ui:IGameUI`。`GameUI.getUI()` 把它交给外部。
- **经 `GameUI.I.getUI()` / `gameState.gameUI.getUI()` 调用的方法**：
  - `pause` / `resume`：`GameCtrl.pause(true)` / `resume(true)`（ESC/back 切暂停；`PauseDialog` CONTINUE 走 `GameCtrl.resume(true)` 再回到这里）。
  - `showStart`：`GameStartCtrl` 1v1 step5 与 `startNextRound`。
  - `fadIn(true)`：`GameStartCtrl.skip`（跳过 intro 时补 HUD 淡入；正常 intro 由 `showStart` 内部 `fadIn`）。
  - `showEnd` / `clearStartAndEnd` / `fadOut(false)`：`GameEndCtrl` 平局与 KO 收尾。
  - `showHits` / `hideHits`：`FighterEventCtrl`（连击>1 显示，目标消失隐藏）。
- **经 `GameUI` 包装转发**：`setVolume`（`initFight` / `fadIn`）、`destory`、`fadIn`（练习 `GameUI.I.fadIn()`）、`render` / `renderAnimate`（`GameState.render` → `GameUI.render`）、`getUI`（`GameState.addChild(getUIDisplay)`）。
- **Callees**：无。纯接口。实现侧见 `FightUI`（本批不写）。

## 命名备注

`destory` / `fadIn` / `fadOut` 拼写与全引擎一致。`GameUI` 自身 **不** implement 本接口。

`fadIn`/`fadOut` 的 `Boolean` 默认 `true`：`FightUI` 传给 `FightBar`/`QiBar`，表示是否播入场/出场动画。`GameEndCtrl` 显式 `fadOut(false)` 立刻藏条。`QI_BAR_MODE==1` 时 `FightUI.fadIn` 会忽略该参数、气条强制 `fadIn(false)` 并改坐标。

## 逐行说明

### `setVolume`（L8）

`FightUI`：写 `ui_fight.soundTransform.volume`（HUD 影片剪辑自带音效）。`GameUI.initFight` / `fadIn` 用 `GameData.I.config.soundVolume`。

### `destory`（L10）

`FightUI`：卸 `SCORE_UPDATE`、destory `PauseDialog` / `FightBar` / `QiBar` / `HitsUI`。`GameState.destory` → `GameUI.destory` → 这里。

### `fadIn` / `fadOut`（L12–14）

HUD 条入场/出场。练习开场只走 `GameUI.fadIn()` 包装（默认 true）。`FightUI.showStart` 自己再 `fadIn()`。`GameEndCtrl` 回合切走前 `fadOut(false)`。

### `getUI`（L16）

返回根 `DisplayObject`。`FightUI` 返回 `ui`（`ui_fight`）。`GameUI.getUIDisplay()` 转发；`GameState.initFight` `addChild` 到战斗舞台（不进镜头层）。

### `render` / `renderAnimate`（L18–20）

`render`：每逻辑帧。`FightUI` 刷血条/气条/角色屏外箭头，并在 `_renderEnd` 时跑 KO 收尾状态机。

`renderAnimate`：被 `GameUI` 按 `FPS_GAME/30` 节流。`FightUI` 推进 `startKOmc`（FIGHT/KO 时间轴）。暂停时 `GameCtrl` 不调 `GameState.render`，两套都停。

### `showHits` / `hideHits`（L22–24）

`showHits(hits, side)`：`side==1` → `_hits1` 否则 `_hits2`。`FighterEventCtrl` 在 `GameLogic.addHits` 返回 >1 时调。

`hideHits(uiID)`：`uiID==1` 左否则右。目标从连击表移除时调。参数语义与 `showHits` 的 `side` 相同，都是 1/2。

### `showStart`（L26）

`(finishBack=null, params=null)`。`FightUI`：先 `fadIn()`，按 `gameRunData.round` 播 `start` 或 `start_final`（round≥5），听 `"complete"` 调 `finishBack`。`params` 本实现未用。`GameStartCtrl` 用 finishBack 清 `_uiPlaying`。

### `showEnd`（L28）

`(finishBack, params)`。`params.drawGame` 走 TIME OVER→DRAW；否则 `params.winner/loser` 走 KO→胜者特写。`FightUI` 把 finishBack 存进 `_endParam`，真正回调在 `renderEnd` / `drawGameBack`。`GameEndCtrl` 用它把 10s hold 提前清零。

### `clearStartAndEnd`（L30）

`FightUI`：`startKOmc.gotoAndStop(1)` 清 KO/FIGHT 片。`GameEndCtrl` 在平局结束与转场揭开前各调一次，避免残留。

### `pause` / `resume`（L32–34）

`FightUI.pause`：懒 `new PauseDialog()` 加到 `ui`，再 `show()`（箭头落在 CONTINUE）。`resume`：有对话框则 `hide()`（顺带 `GameUI.closeConfrim`）。`GameCtrl.pause(true)` 同时停逻辑；pause 对话框自己的 `SetBtnGroup` 仍吃 `GameRender`。
