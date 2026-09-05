# `player_pos_p1` — P1 屏外标记

一句话目的：空 MovieClip。镜头 zoom≤1.8 且 P1 出画时，把它挪到屏幕边缘标角色头顶。

源文件：`decompiled/ui/fight/scripts/player_pos_p1.as`（15 行）

## 如何挂上引擎

**不是** [`ui_fight`](ui_fight.md) 时间轴孩子。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 构造 L71–76：

```
_p1PosUI = ResUtils.I.createDisplayObject(ResUtils.I.fight, "player_pos_p1")
visible = false
ui.addChild(_p1PosUI)
```

`render` → `renderPlayerPosUI(camera.getZoom())`：

- `zoom > 1.8`：P1/P2 都 `visible=false`（近景不需要）。
- 否则有 `p1FighterGroup.currentFighter` → `getPlayerPos` 写 x/y，`visible=true`。
- `getGameSpriteGlobalPosition(sprite, 0, -50)`：屏幕坐标，Y 偏 -50（标头顶）。
- 钳制：x∈[20, 780]；y<60 → 60（避开顶 HUD）；y>595 时代码写成 **`x = GAME_SIZE.x-5`**（795），应改 y。? 飞出底边标记会跳到右缘。
- 组队换人间隙 `currentFighter==null` **不**把 visible 拉回 false。?

无公开实例。美术箭头/三角在 SWF 时间轴，本 AS 无字段。P2 对称见 [`player_pos_p2`](player_pos_p2.md)（不同 symbol）。`destory` 不清这两个引用，随 `ui.removeChildren` 摘掉。

## 逐行说明

- **L5** `symbol="symbol222"`。
- **L6** `public dynamic class player_pos_p1 extends MovieClip`。无字段。
- **L9–12 构造**：只 `super()`。无帧脚本。
