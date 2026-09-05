# `Ctrler4399` — 4399 结束画面插提交分按钮

一句话目的：听 `GAME_OVER` / `GAME_PASS_ALL`，在失败/通关 UI 上加 `SubmitScoreBtn`；`showRank`/`submitScore` 转给 `bleachvsnaruto.serviceHold`。没有 Hold 就是 no-op。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/web/Ctrler4399.as`（73 行）

## Callers / callees

- **Callers**：
  - `bleachvsnaruto.initlize`（L65）`Ctrler4399.init()`。
  - `GameInterfaceManager.getGameMenu` 把 RANK 的 `func` 指到 `Ctrler4399.showRank`。
  - `SubmitScoreBtn` click → `Ctrler4399.submitScore()`。
- **Callees**：`GameEvent.addEventListener`、`SubmitScoreBtn`、`TweenLite.to`、`MainGame.stageCtrl.currentStage`、`GameData.I.score`、`bleachvsnaruto.serviceHold.showSort` / `showRefer`。
- **事件源**：`GameOverState.gameOverComplete` dispatch `"GAME_OVER"`；`CongratulateState.playComplete` dispatch `"GAME_PASS_ALL"`（此时按钮组已建好，`getBtnY()` 有效）。

## 命名备注

4399 开放平台钩子，编译进网页包。真正 API 对象是壳注入的 `serviceHold`（`bleachvsnaruto.setHold`）。本地 / Ruffle `serviceHold === null`，`showRank`/`submitScore` 只 `trace` 后 return。

和 `GameInterfaceManager.submitScore/showRank` 几乎同文（都调 Hold）。菜单 RANK 走本类；`MainGame.showRank` 走 Interface。提交分按钮走本类（自己读 `GameData.I.score`），不是 `GameInterface.submitScore`。

## 逐行说明

### 空构造（L14–17）

全静态。

### `init`（L19–23）

注册两条 `GameEvent`。不检查是否 4399 域名，网页包启动必挂。按钮在事件发生时才 new。

### `gameHandler`（L25–44）

- **`GAME_OVER`**：`currentStage as GameOverState`，`new SubmitScoreBtn(570, 600)` addChild 到 `display as Sprite`（即 `_ui`），`TweenLite.to(..., 0.2, {y:500})` 从画面外抬到 500。坐标按 800×600。
- **`GAME_PASS_ALL`**：`currentStage as CongratulateState`，`y = getBtnY() + 40`（BACK 按钮组下方），`innerUI.addChild(new SubmitScoreBtn(560, y))`。无 tween。

cast 失败会运行时 TypeError。两条事件只在对应 State 里派，正常路径没问题。

### `showRank`（L46–54）

`trace("showRank")`。`serviceHold` 真则 `showSort()`（4399 排行榜面板）。无 Hold 到此结束。

### `submitScore`（L56–69）

`trace("submitScore")`。`GameData.I.score <= 0` 直接 return（不弹窗）。有 Hold 则 `showRefer(score)`（4399 提交/推荐面板）。无 Hold 只 trace。
