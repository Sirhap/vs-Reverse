# `FightTimeUI` — 回合倒计时 /「无限」

一句话目的：绑 `time_mc`。`gameTimeMax==-1` 亮 `wuxian`（无限）；否则用 `MCNumber(time_txtmc)` 显示剩余秒，两位补零。每逻辑帧从 `GameRunDataVO.gameTime` 刷新。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightTimeUI.as`（56 行）

## Callers / callees

- **Callers**：只 `FightBar`。构造 `new FightTimeUI(_ui.timemc)`；每帧 `render`；BITMAP `addChildren(_timerMc.timeUI)`（可能 null）。
- **Callees**：`GameCtrl.I.gameRunData.gameTimeMax` / `gameTime`；`ResUtils.I.getItemClass(ResUtils.I.fight, "time_txtmc")`；`MCNumber`。

## 时间从哪来

- `GameRunDataVO.reset`：`gameTimeMax = config.fightTime`（默认 60），`gameTime = gameTimeMax`。
- 练习 `GameCtrl.buildGame`：`gameTimeMax = -1`（`gameTime` 仍可能是 60，但不递减）。
- `GameCtrl.renderGameTime`：仅 `actionEnable && !_startCtrl && !_endCtrl` 且 `gameTimeMax != -1`。每 30 逻辑帧减 1 秒（**不是** `FPS_GAME`，写死 30）。到 0 调 `timeover()`。
- 本类只读不写。`FightUI.showEnd` 看的是 `isTimerOver`，与数字是否到 0 解耦（`timeover()` 会置 flag）。

## 命名备注

- **没有** `destory`。`FightBar.destory` 也不拆它。
- `timeUI` getter 返回 `_numMc`（`MCNumber`），**不是** `_ui`。无限模式 `_numMc==null`，BITMAP 不加进 `_children`；`wuxian` 留在 `timemc` 里被烘焙进 FightBar 底图。
- `MCNumber(cls, 0, 1, 20, 2)`：每格宽 20，**2 位补零**。60→`"60"`，9→`"09"`，0→`"00"`。超过 99 会变成 3 位（`MCNumber` 只保证最少 bits，不截断）。
- 位置 `_numMc.x=-22; y=-15` 相对 `time_mc`。BITMAP `setChildrenPosition` 会加上 `timemc` 祖先位移。
- `wuxian` 是 SWF 里的「无限」字 MC。有限时间 `visible=false`，但 MC 仍在 `_ui` 上。

## 逐行说明

### 字段 / 构造（L11–39）

`_ui=time_mc`。读 `gameTimeMax`：

- `==-1`：`_renderTime=false`，`wuxian.visible=true`。不创建数字。练习模式。
- 否则：`_renderTime=true`，new `MCNumber`，偏移 (-22,-15)，`addChild` 到 `_ui`，藏 `wuxian`，`number=gameTimeMax`（开场显示上限，之后 `render` 跟剩余）。

构造时 `GameCtrl.I.gameRunData` 必须已 `reset`/`buildGame`。`FightBar` 在 `FightUI` 构造里 new，晚于 `GameState.build`→`GameCtrl.initlize`，但 **早于** `buildGame` 把练习的 -1 写进去。?

顺序：

```
GameState.build        → new GameUI（还没有 FightUI）
GameCtrl.startGame / buildGame
  练习：gameTimeMax=-1
  gameState.initFight → gameUI.initFight → new FightUI → new FightBar → new FightTimeUI
```

所以练习能看到 -1。VS/街机 `fightTime` 已在 `reset` 写入。下一回合 `nextRound` 把 `gameTime` 拉回 max，本类下一帧 `render` 跟上；**不**重建 FightTimeUI。

### `timeUI` getter（L41–44）

返回 `_numMc`。BITMAP 用。无限 → null。

### `render`（L46–54）

`!_renderTime` return。否则 `_numMc.number = gameRunData.gameTime`。每逻辑帧都赋值；`MCNumber` setter 即使数字没变也会拆掉重建所有位 MC（每帧 2 个 `time_txtmc`）。60fps 下有点浪费，但位数固定开销小。?

`gameTime` 减到 0 后 `timeover` 停递减，数字停在 0。负值不会出现（`<=0` 就停）。
