# `PauseDialog` — 战斗暂停三项（返回标题 / 出招表 / 继续）

一句话目的：半透明全屏 + `SetBtnGroup`。`FightUI.pause` 懒创建并 `show()`；CONTINUE 走 `GameCtrl.resume(true)`，GAME TITLE 再套一层 `GameUI.confrim`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/PauseDialog.as`（125 行）

## Callers / callees

- **Callers**：只 `FightUI`（经 `IGameUI.pause/resume`）。
  - `FightUI.pause`：无则 `new PauseDialog()` + `ui.addChild`，再 `show()`。入口是 `GameCtrl.pause(true)`（`renderPause` 里 `GameInputer.back(1)`，开场/收尾期间 back 改 skip 不进这里）。
  - `FightUI.resume`：`hide()`。入口 `GameCtrl.resume(true)`：再按 back，或本框 CONTINUE。
  - `FightUI.destory`：`_pauseDialog.destory()`。
- **Callees**：`SetBtnGroup`（三项，`setBtnData(..., 2)` 默认箭头 CONTINUE）；`MoveListSp`；`GameUI.confrim` / `showingDialog` / `closeConfrim`；`GameCtrl.I.resume(true)`；`MainGame.I.goMenu`；舞台 `DataEvent("5d_message")`：`back_title` / `back_title_cancel` / `move_list` / `move_list_cancel`。`GameCtrl.pause` 自己另派 `game_pause` / `game_resume`。

## 命名备注

`destory` / `confrim` 保留。按钮 label 是 `"GAME TITLE"` / `"MOVE LIST"` / `"CONTINUE"`，不是注释里的 BACK TITLE。`isShowing()` 本包 **无调用方**。

## 逐行说明

### 字段 / 构造（L13–40）

- `_bg`：`Sprite` 全屏 `GAME_SIZE` 黑 0.5 透明。
- `_btnGroup`：三项顺序 GAME TITLE → MOVE LIST → CONTINUE，中文「返回标题 / 出招表 / 继续游戏」。`setBtnData(..., 2)` → `initArrow(2)` 箭头在 CONTINUE。听 `"SELECT"`。`direct` 默认 1（竖排）。
- `_moveList`：懒建。
- 构造结束时 `visible` 仍 true；`FightUI` 创建后立刻 `show()`，首次不会闪一帧未 hide 的框（还没 addChild 完就 show）。若将来有人 `new` 却不 `show`，会以可见状态进舞台。

### `destory`（L42–55）

卸 SELECT、`SetBtnGroup.destory`；有出招表则 `MoveListSp.destory`。不从父级 removeChild（`FightUI.destory` 时整棵 `ui_fight` 一起拆）。

### `isShowing`（L57–60）

`return visible`。本包无人读。

### `show`（L62–67）

`visible=true`，`keyEnable=true`，`setArrowIndex(2)` 每次打开都回到 CONTINUE（即使用户上次停在 MOVE LIST）。

### `hide`（L69–74）

`visible=false`，`keyEnable=false`，`GameUI.closeConfrim()` —— 若 GAME TITLE 确认框还开着（例如用 back 而不是 NO 关掉暂停），把确认框一起拆掉。CONTINUE 路径：`GameCtrl.resume(true)` → `FightUI.resume` → 这里。

### `btnGroupSelectHandler`（L76–104）私有

`GameUI.showingDialog()` 则 return（确认框开着时三项不再响应，避免套娃）。

- **`"GAME TITLE"`**：先 `_btnGroup.keyEnable=false`（防重复弹）。`GameUI.confrim("BACK TITLE?","返回到主菜单？", yes, no)`。
  - yes：派 `["back_title"]`，`MainGame.I.goMenu()`（切 `MenuState`，`GameState.destory` 拆本框）。
  - no：恢复 `keyEnable`，派 `["back_title_cancel"]`。
- **`"MOVE LIST"`**：`showMoveList()`，派 `["move_list"]`。
- **`"CONTINUE"`**：`GameCtrl.I.resume(true)` → 派 `game_resume`、`FightUI.resume`、本框 `hide`。

### `showMoveList`（L106–116）私有

无 `_moveList` 则 `new MoveListSp()`，`onBackSelect=hideMoveList`，`addChild`（盖在三项上面）。关 `_btnGroup.keyEnable`，`_moveList.show()`（100ms 后出招表 BACK 才可按）。

### `hideMoveList`（L118–123）私有

`_moveList.hide()`（实例保留），恢复三项 `keyEnable`，派 `["move_list_cancel"]`。
