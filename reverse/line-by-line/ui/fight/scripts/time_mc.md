# `time_mc` — 回合计时容器（数字或「无限」）

一句话目的：顶栏正中计时坑。有限时间由引擎往上叠 `MCNumber(time_txtmc)`；练习 `gameTimeMax==-1` 亮 `wuxian`。

源文件：`decompiled/ui/fight/scripts/time_mc.as`（17 行）

## 如何挂上引擎

[`hpbar_mc.timemc`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) `new FightTimeUI(_ui.timemc)`。

[`FightTimeUI`](../../../engine/game/bvn/ui/fight/FightTimeUI.md)：

- `gameTimeMax==-1`：`_renderTime=false`，`wuxian.visible=true`，不建数字。练习。
- 否则：`getItemClass(ResUtils.I.fight, "time_txtmc")` → [`MCNumber`](../../../engine/kyo/display/MCNumber.md)`(cls, 0, 1, 20, 2)`，偏移 `(-22,-15)`，`addChild` 到本 MC，藏 `wuxian`，初值 `gameTimeMax`。每逻辑帧写 `gameTime`。

BITMAP：`timeUI` getter 返回 **MCNumber 不是本 MC**。无限模式 `_numMc==null`，不进 `_children`；`wuxian` 留在本 MC 里烤进 FightBar 底图。

无 `destory`。下一回合不重建，只 `render` 跟上 `gameTime`。

## 逐行说明

- **L5** `symbol="symbol132"`。
- **L6** `public dynamic class time_mc extends MovieClip`。
- **L9 `wuxian`**：`MovieClip`。「无限」字。有限时间引擎 `visible=false`，MC 仍在显示列表。
- **L11–14 构造**：只 `super()`。无帧脚本、无数字槽——数字是代码 `addChild`。
