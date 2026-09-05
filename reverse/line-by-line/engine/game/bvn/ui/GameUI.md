# `GameUI` — 战斗 HUD 门面 + 静态对话框

一句话目的：战斗态 HUD 的宿主。`GameState.build` `new GameUI()`，`initFight` 里懒建唯一实现 `FightUI`；另提供静态 `alert` / `confrim` 盖在 `MainGame.I.root` 上，菜单/选人/暂停都走这里。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/GameUI.as`（223 行）

## Callers / callees

- **Callers（实例）**：
  - `GameState.build`：`gameUI = new GameUI()`（构造写 `I=this`）。
  - `GameState.initFight` / `resetFight`：`gameUI.initFight(p1Group, p2Group)`；`initFight` 还 `addChild(gameUI.getUIDisplay())`。
  - `GameState.render`：`gameUI.render()`。
  - `GameState.destory`：`gameUI.destory()`。
  - `GameCtrl.buildGame` 练习 mode==40：`GameUI.I.fadIn()`（无 `GameStartCtrl`，靠这层把血条/气条淡入）。
  - `GameCtrl.pause(true)` / `resume(true)`：`GameUI.I.getUI().pause()` / `.resume()`（到 `IGameUI`/`FightUI`，本类无这两个方法）。
  - `GameStartCtrl`：`_state.gameUI.getUI().showStart` / `fadIn(true)`。
  - `GameEndCtrl`：`GameUI.I.getUI().showEnd` / `clearStartAndEnd` / `fadOut(false)`。
  - `FighterEventCtrl`：`GameCtrl.I.gameState.gameUI.getUI().showHits` / `hideHits`。
- **Callers（静态对话框）**：
  - `GameUI.confrim("BACK TITLE?","返回到主菜单？", …)`：`SelectFighterStage` / `LoadingState` / `WinnerState.btn_exit` / `PauseDialog` GAME TITLE。确定后 `MainGame.I.goMenu`（暂停框自己还派 `back_title`）。
  - `GameUI.alert("UPDATE", MainGame.UPDATE_INFO)`：仅 `MenuState.afterBuild`（`isFristRun`）。
  - `GameUI.closeConfrim`：上述三态 `destory`、选人/加载再按 back 关掉已开的框、`PauseDialog.hide`。
  - `GameUI.showingDialog()`：`SelectFighterStage` / `LoadingState` / `PauseDialog.btnGroupSelectHandler` / `MenuBtnGroup.render` / `SelectIndexUIGroup.render` —— 有框时吞输入。
  - `GameUI.closeAlert`：本包无外部调用，只 `alert` 的 OK 闭包里走。
- **Callers（静态开关）**：`BITMAP_UI`（默认 true）→ `FightBar` / `QiBar` 走位图 HUD；`SHOW_CN_TEXT`（默认 true）→ `AlertUI` / `ConfrimUI` / `SetBtnLine` / `SelectedFighterUI` / `MapSelectUI` 建中文 `TextField`。本包 **无写入**，恒默认。
- **Callees**：`FightUI`（`IGameUI` 唯一实现，ui.fight 包，本批只作 callee）；`ConfrimUI` / `AlertUI`；`MainGame.I.root` 加对话框、`stage` 派 `DataEvent("5d_message")`；`GameData.I.config.soundVolume`；`GameConfig.FPS_GAME`。

## 命名备注

- `confrim` / `ConfrimUI` / `closeConfrim` / `destory` / `fadIn` / `fadOut` / `initlize`（`FightUI`）拼写全部保留。
- 本类 **不是** `IGameUI`。`getUI()` 返回内部 `IGameUI`；`getUIDisplay()` 才是要 `addChild` 的 `DisplayObject`。
- `GameUI.I` 与 `GameState.gameUI` 是同一实例（构造覆盖单例）。`destory` **不**清 `I`。
- `fadOut()`（L207）体内调的是 `_ui.fadIn()` 不是 `fadOut`。本包无人调这个包装方法：`GameEndCtrl` 走 `getUI().fadOut(false)`，所以这是死代码 + 写反。
- `alert` / `confrim` 的 `5d_message`：`show_alert` / `close_alert`；`show_confrim` / `close_confrim`（payload `[true|false]` 表示按了 YES/NO）。

## 与战斗循环的衔接

```
GameState.build          → new GameUI()          // 尚无 FightUI
GameCtrl.buildGame
  gameState.initFight    → GameUI.initFight      // new FightUI + initlize
                           addChild(getUIDisplay)
  练习：GameUI.I.fadIn()
  其它：GameStartCtrl.showStart → FightUI.fadIn + startKOmc
GameState.render         → GameUI.render → FightUI.render [+ 节流 renderAnimate]
GameCtrl.pause(true)     → IGameUI.pause → PauseDialog
GameEndCtrl              → IGameUI.showEnd / clearStartAndEnd / fadOut
GameState.destory        → GameUI.destory → FightUI.destory
```

下一回合 `resetFight` 再 `initFight`：已有 `FightUI` 则复用，只 `initlize` 换人。

## 逐行说明

### 静态 / 实例字段（L16–30）

- `I`：最近一次构造的实例。
- `BITMAP_UI=true`：血条/气条用 `BitmapData` 快照。本包只读。
- `SHOW_CN_TEXT=true`：对话框/选人中文行。本包只读。
- `_confrimUI` / `_alertUI`：静态单槽，同时最多各一个。`showingDialog` 是「任一非空」。
- `_ui:IGameUI`：战斗 HUD。`initFight` 前为 null。
- `_renderAnimateGap` / `_renderAnimateFrame`：把 HUD 动画对齐 30fps。`FPS_GAME=60` → `ceil(60/30)-1=1`，隔一帧才 `renderAnimate`；30fps → gap=0，每帧都跑。

### 构造（L32–37）

`I=this`。按 `GameConfig.FPS_GAME` 算 gap。不建 `FightUI`。

### `showingDialog`（L39–42）

`_confrimUI != null || _alertUI != null`。**不**看 `PauseDialog`（暂停框不算「对话框」）。菜单/选人用它挡方向键。

### `confrim`（L44–75）

`(enMsg, cnMsg, yes, no)`。闭包 `yesClose` / `noClose`：先调调用方回调，再 `closeConfrim()`，再派 `["close_confrim", true|false]`。

1. `closeConfrim()` 清旧框（避免叠两个）。
2. `new ConfrimUI()`，`setMsg`，挂 `yesBack`/`noBack`。
3. 先派 `["show_confrim"]`，再 `MainGame.I.root.addChild`。

调用方回调里常 `goMenu()`，会拆当前舞台；`closeConfrim` 在回调之后，root 仍在，卸框安全。`PauseDialog` 的 no 回调只重新 `keyEnable`。

### `alert`（L77–97）

`(enMsg, cnMsg, close)`。结构同 confrim：`closeBack` 里调 close → `closeAlert` → `["close_alert"]`。先 `addChild` 再派 `show_alert`（与 confrim 顺序相反，? 无功能差）。本包唯一调用不传 close。

### `closeAlert`（L99–113） / `closeConfrim`（L115–129）

有实例则 try `root.removeChild` catch 空，再 `destory()` 置 null。不在舞台上（已经切走）也能静默 destory。

### `getUI`（L131–134）

返回 `_ui`（`IGameUI`）。`GameCtrl`/`GameEndCtrl`/`FighterEventCtrl` 都从这里拿 `pause`/`showEnd`/`showHits` 等本类没包的方法。`_ui` 空时（`initFight` 前）NPE；实际 pause/end/hits 都在进战后。

### `getUIDisplay`（L136–139）

`_ui.getUI()` → `FightUI.ui`（`ui_fight`）。`GameState.initFight` 把它加到舞台（镜头层外面）。`_ui` 空会 NPE；只在 `initFight` 之后调用。

### `initFight`（L141–159）

`(p1:GameRunFighterGroup, p2)`。

1. 读 `GameData.I.config.soundVolume`。
2. 已有 `_ui` 且 **不是** `FightUI`：`destory` 再 `new FightUI()` + `setVolume`。本包只有 `FightUI` 实现 `IGameUI`，此分支防御。
3. `_ui` 空：同样 `new FightUI()` + `setVolume`。
4. 已是 `FightUI`：不重建，只走到 5。
5. `(_ui as FightUI).initlize(p1,p2)`：刷新脸/血/气条到当前出战与辅助。

`resetFight`（下一回合）走复用路径，HUD 实例和 `PauseDialog` 都留着。

### `render`（L161–172）

无 `_ui` 则 return。否则 `_ui.render()`（血条/气条/hits/KO 演出）。`isRenderAnimate()` 为真再 `renderAnimate()`。`GameCtrl` 暂停时整段 `GameState.render` 不跑，HUD 动画停；`PauseDialog` 的 `SetBtnGroup` 自己挂 `GameRender`，不受影响。

### `renderAnimate`（L174–180）私有

有 `_ui` 则 `_ui.renderAnimate()`（`FightUI` 推进 `startKOmc` 等）。

### `isRenderAnimate`（L182–194）私有

gap>0：`_renderAnimateFrame++ >= gap` 才 true 并清零，否则 false。gap==0 恒 true。与 `GameCtrl.checkRenderAnimate` 同一公式，但 **各自计数**，不共享相位。

### `fadIn`（L196–205）

有 `_ui`：`_ui.fadIn()`（默认 `true`=播动画）+ 再 `setVolume(soundVolume)`。练习开场、以及若有人调这个包装时用。`FightUI.showStart` 自己也会 `fadIn()`，练习不走 showStart 所以必须从这里调。

### `fadOut`（L207–213）

有 `_ui` 却调 `_ui.fadIn()`。本包无调用方。真正淡出是 `GameEndCtrl` → `getUI().fadOut(false)`。

### `destory`（L215–221）

有 `_ui` 则 `_ui.destory()`（`FightUI` 会 destory `PauseDialog`/血条/气条）。**不** `_ui=null`、**不** `I=null`、**不**关静态对话框。切菜单时 `SelectFighterStage.destory` 等会自己 `closeConfrim`；战斗 `GameState.destory` 不关 alert（战斗里本来也不弹）。
