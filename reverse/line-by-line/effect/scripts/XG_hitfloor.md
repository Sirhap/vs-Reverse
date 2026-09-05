# `(无名包).XG_hitfloor` — 普通砸地火花

一句话目的：受击落地强度 0 的着地火花。

源文件：`decompiled/other/effect/scripts/XG_hitfloor.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `hit_floor`：`XG_hitfloor` + `snd_hitfloor`。

[`EffectCtrl.hitFloorEffect(0)`](../../engine/game/bvn/ctrl/EffectCtrl.md) ← [`FighterEffectCtrl.hitFloor`](../../engine/game/bvn/fighter/ctrler/FighterEffectCtrl.md)。强度 1 走 [`xg_hitfloor_low`](xg_hitfloor_low.md)；强度 2 走 [`xg_hitfllor_heavy`](xg_hitfllor_heavy.md) **外加** [`xg_hitfloor_yan`](xg_hitfloor_yan.md) 烟。

主动落地（跳下）是 [`XG_luodi`](XG_luodi.md) `touch_floor`，不是本类。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 12 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 543**（FFDec `symbol543`），**13 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_hitfloor extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol543")]`：FFDec 把 sprite 543 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_hitfloor()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
