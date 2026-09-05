# `GameEndCtrl` — 回合结束演出

一句话目的：KO 或平局的分步 cinema：END/KO UI → 胜者 `win()` 与组队回血 → 转场淡入 → 告诉 `GameCtrl.render` 去 `runNext`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameEndCtrl.as`（160 行）

## Callers / callees

- **Callers**：只 `GameCtrl`。`doGameEnd` → `initlize(winner,loser)`；`drawGame` → `drawGame()`；每帧 `_endCtrl.render()`；`renderPause` 在有 `_endCtrl` 时把 back/MENU 转成 `skip()`；结束或 `GameCtrl.destory` 调 `destory()`。
- **Callees**：`GameCtrl.I.gameRunData`（禁扣血、读 lastWinner/时间）；`GameUI.showEnd/clearStartAndEnd/fadOut`；`FighterMain.win`；`FighterActionState.isAllowWinState`；`GameMode.isTeamMode`；`StateCtrl.transIn`。

## 命名备注

- `initlize` / `destory`：原拼写。
- `_step` 用了 `0,1,2,3` 和跳板 `22`（转场中），不是连续枚举。
- `skip` 只在 `_step==2`（win pose 等待）生效，KO UI（step 0）和 `transIn`（step 22）不能跳。

## 逐行说明

### 字段 / 构造（L14–29）

`_winner` / `_loser`、`_step`、`_isRender`、`_holdFrame`、`_drawGame`。构造空。`_drawGame` 默认 false，只有 `drawGame()` 置 true。

### `initlize`（L31–38）

`setAllowLoseHP(false)`（双方当前角色不再掉血）。存胜负、`_step=0`、`_isRender=true`。不改 `_drawGame`（应保持 false；若同一实例先 draw 再 init 不会发生，每次都是 `new`）。

### `drawGame`（L40–46）

同样禁扣血，`_drawGame=true`，从 step 0 开始渲染。不设 winner/loser。

### `destory`（L48–52）

只 null 胜负引用。不关 `_isRender`（调用方已丢掉实例）。

### `render`（L54–69）

`GameCtrl` 每物理帧调。`!_isRender` → false。`_holdFrame-- > 0` → false（先减再比，所以赋值 N 会空等 N 帧）。然后 `_drawGame` ? `renderDrawGame` : `renderEND`。返回 true 时 `GameCtrl` destory 本对象并 `runNext()`。

### `renderDrawGame`（L71–89）

- **case 0**：`GameUI.showEnd(cb, {drawGame:true})`。cb 把 `_holdFrame=0`（UI 播完可提前结束等待）。`_step=1`，`_holdFrame=10*FPS_GAME`（60fps 约 10s 上限）。
- **case 1**：`_isRender=false`，`clearStartAndEnd()`，**return true**。
- 其它 / case 0 后：return false。

平局没有 `win()`、没有回血、没有 `transIn`/`fadOut`。

### `renderEND`（L91–150）

局部 `rundata/winner/timeRate/addHPMax/addHP` 是 case 1 用的，AS3 提升到函数顶。

- **case 0**：`showEnd(cb, {winner, loser})`，同样 10s hold，cb 可清 hold。`_step=1`。
- **case 1**：`!isAllowWinState(_winner.actionState)` → return false（**必杀 12/13 或万解 50 时卡住**，等状态离开）。然后 `_winner.win()`，hold `3*FPS_GAME`，`_step=2`。
  - 回血：`winner = rundata.lastWinner`（`doGameEnd` 已写，应等于 `_winner`）。
  - **组队或生存 mode==30**：`timeRate = gameTime==-1 ? 1 : gameTime/gameTimeMax`；`addHPMax = hpMax*0.2`；`addHP = addHPMax*timeRate`，下限 `hpMax*0.05`；`winner.hp += addHP`（**不 cap hpMax**，? 可超）。
  - 无论模式：`rundata.lastWinnerHp = winner.hp`，给下一回合 `doBuildNextRound` 还原。
- **case 2**：立刻 `_step=22`（让 `skip` 失效），null 胜负，`StateCtrl.transIn(cb, false)`，cb 把 `_step=3`。无 hold，转场完成前每帧落到 switch 无匹配 → false。
- **case 3**：`_isRender=false`，`clearStartAndEnd()`，`fadOut(false)`，return true。
- **case 22**：无分支，return false，等 transIn。

### `skip`（L152–158）

仅 `_step==2` 时 `_holdFrame=0`，下一帧进 case 2 开转场。step 0 的 KO UI、step 1 等必杀结束、step 22 转场都不能 skip。`GameCtrl.renderPause` 在 intro/outro 期间把 back/MENU 送到这里。
