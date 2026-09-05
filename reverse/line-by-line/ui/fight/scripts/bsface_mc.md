# `bsface_mc` — 空 MC（HUD 必杀脸槽 / 遗留）?

一句话目的：fight SWF 里一颗空 MovieClip，无字段、无帧脚本。引擎**从不** `createDisplayObject("bsface_mc")`。角色必杀脸走战斗机 SWF 的 `BitmapData` 导出类 + `defineBishaFace`，与本类无关。

源文件：`decompiled/ui/fight/scripts/bsface_mc.as`（14 行）

## 如何挂上引擎

无直接调用方。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 只 `createDisplayObject` `"ui_fight"` / `"player_pos_p1"` / `"player_pos_p2"`。[`HitsUI`](../../../engine/game/bvn/ui/fight/HitsUI.md) / [`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md) 也不取这个链接名。

真正的必杀脸：

- 各战斗机 SWF 导出 `bsface1` / `bsface2` / …（`BitmapData`，常见 168×119）。
- 时间轴 `FighterCtrler.defineBishaFace("蓝染1", bsface1)` 只存 Class。
- 弹出在 `BishaFaceEffectView`，**不是** HUD 槽。

本类更像 FLA 里嵌在某条 HUD 时间轴上的装饰，或没删干净的库元件。可能出现在 `ui_fight` / `startKOmc` / 气条的内部图层，AS 看不到嵌套关系。?

`symbol="symbol244"`，紧挨 [`hits_num_mc`](hits_num_mc.md)（symbol243）——也许曾计划做连击旁的必杀脸，没接线。?

## 逐行说明

- **L5** `symbol="symbol244"`。
- **L6** `public dynamic class bsface_mc extends MovieClip`。无公开实例。
- **L9–12 构造**：只 `super()`。无 `addFrameScript`。
