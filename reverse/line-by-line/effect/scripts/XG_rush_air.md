# `(无名包).XG_rush_air` — 空中冲刺残影

一句话目的：空中 dash 残影。与地面冲刺共用 `snd_dash_air`。

源文件：`decompiled/other/effect/scripts/XG_rush_air.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `dash_air`：`XG_rush_air` + `snd_dash_air`。22 帧，比地面 [`XG_rush`](XG_rush.md)（20 帧）略长。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 21 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 365**（FFDec `symbol365`），**22 帧** @30fps，约 14 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_rush_air extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol365")]`：FFDec 把 sprite 365 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_rush_air()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
