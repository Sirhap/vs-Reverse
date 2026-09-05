# `player_pos_p2` — P2 屏外标记

一句话目的：与 [`player_pos_p1`](player_pos_p1.md) 同结构的空 MC。P2 出画、zoom≤1.8 时用。不同 Embed symbol，SWF 图形可能朝另一侧。?

源文件：`decompiled/ui/fight/scripts/player_pos_p2.as`（15 行）

## 如何挂上引擎

[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 构造 L72–76：`createDisplayObject(ResUtils.I.fight, "player_pos_p2")`，默认隐藏，`ui.addChild`。

`renderPlayerPosUI` 与 P1 同一段：`zoom>1.8` 两侧一起藏；否则绑 `p2FighterGroup.currentFighter`，`getPlayerPos` 同样的屏幕坐标 + 钳制（含 y 溢出误写 x 的 bug）。?

本类无 `setDirect`。若箭头要朝右，靠 symbol219 的美术，不是代码翻转。

## 逐行说明

- **L5** `symbol="symbol219"`（P1 是 222）。
- **L6** `public dynamic class player_pos_p2 extends MovieClip`。无字段。
- **L9–12 构造**：只 `super()`。无帧脚本。与 P1 AS 除类名/symbol 外相同。
