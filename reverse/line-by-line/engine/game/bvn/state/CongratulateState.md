# `CongratulateState` — 全关卡通关祝贺

一句话目的：小队/单人闯关 `missionAllComplete` 后的祝贺页。播祝贺 MC，再滚出 `mc_win_all` + 分数 + BACK；派 `GAME_PASS_ALL` 给 4399 交分按钮。BACK 回 **Logo** 不是菜单。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/CongratulateState.as`（134 行）

## Callers / callees

- **Callers**：`MainGame.goCongratulations()` → `goStage(new CongratulateState())` + `setFPS(30)`。来自 `GameCtrl.fightFinish`：`GameMode.isAcrade()` 且 P1 胜且 `MessionModel.I.missionAllComplete()`。
- **Callees**：`ResUtils` `cover_bgimg`、`mc_congratulations`（`ResUtils.CONGRATULATIONS`）、`"mc_win_all"`；`SoundCtrl.BGM("congratulation")`；`GameRender`；`BitmapFontText` + `AssetManager.getFont("font1")`；`GameData.I.score`；`SetBtnGroup` BACK；`GameEvent.dispatchEvent("GAME_PASS_ALL")`；BACK → `MainGame.goLogo()`。
- **交分**：本状态 **不** 调 `MainGame.submitScore`。`Ctrler4399.init` 听 `GAME_PASS_ALL`，把 `SubmitScoreBtn` 加到 `innerUI`（滚动层），y = `getBtnY()+40`。按钮再调 `Ctrler4399.submitScore` → Hold `showRefer(score)`。`MainGame.submitScore` 是另一条 `GameInterface.submitScore` 路径。

## 命名备注

- `destory` 拼写保留。
- `display` 返回 `_mainUI`（底图+内容），`innerUI` 返回 `_ui`（滚动层）。4399 必须用 `innerUI` 才能跟着滚。
- `_bg.alpha = -1`：AS3 会把 DisplayObject.alpha 夹到 [0,1]，实际从 0 起。

## 逐行说明

### 字段 / 构造（L25–37）

- `_mainUI`：根（display）。
- `_ui`：滚动内容层。
- `_exitHeight`：滚到此偏移停，并开 BACK 键。
- `_btngroup` / `_bg`。
- 构造空。

### `display`（L40–43）

返回 `_mainUI`。

### `innerUI`（L45–48）

给 `Ctrler4399` 挂交分钮。

### `build`（L50–64）

1. `new Sprite()` 作 `_mainUI`。
2. `cover_bgimg` 铺满，`_bg.alpha = -1`（即全透明），addChild。
3. `_ui` 空 Sprite 叠在底图上。
4. 取出 `mc_congratulations`，听 `"complete"`（弱引用），`gotoAndPlay(2)`。MC 帧 50 `stop` + `COMPLETE`。
5. BGM `"congratulation"`。

### `getBtnY`（L66–69）

返回 `_btngroup.y`。`playComplete` 之前 `_btngroup` 仍 null；4399 在 `GAME_PASS_ALL` 时才调，那时按钮已建。

### `playComplete`（L71–94）

祝贺动画结束：

1. 建 `mc_win_all`，`y = GAME_SIZE.y`（先在屏下），addChild 到 `_ui`。
2. `GameRender.add(render)` 开始上滚。
3. `BitmapFontText`：`"FINAL SCORE " + GameData.I.score`，水平居中，y = win_all 底 + 100。
4. `_exitHeight = 分数y - 320`：滚这么多之后停。
5. `SetBtnGroup`：x=230，y = 分数底 + 100，BACK/返回；`keyEnable=false`（滚完才开）。
6. **立刻** `GameEvent.dispatchEvent("GAME_PASS_ALL")` —— 交分钮在滚动开始时就挂上，跟着 `_ui` 往上走。

### `render`（L96–111）

每帧：

- `GameInputer.back(1)`：立刻 `_ui.y = -_exitHeight` 并 `sndSelect()`（跳过滚动）。
- `_ui.y -= 1`；`_bg.alpha += 0.005`。
- 若 `_ui.y < -_exitHeight`：卸 render，底图 alpha=1，`_btngroup.keyEnable = true`。

30fps 下大约 `_exitHeight` 帧。back 快进仍要等下一帧不等式成立才会开键。

### `selectBtnHandler`（L113–116）

BACK → `MainGame.I.goLogo()`（不是 goMenu）。

### `afterBuild`（L118–120）

空。

### `destory`（L122–131）

卸 render；有按钮则 destory + 卸 SELECT。不 dispose `_bg` BitmapData。不停 BGM。不调 `param1`。
