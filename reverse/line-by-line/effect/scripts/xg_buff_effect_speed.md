# `(无名包).xg_buff_effect_speed` — 速度 buff 爆发火花

一句话目的：上速度 buff 时的一次性爆发。普通 `EffectView`。

源文件：`decompiled/other/effect/scripts/xg_buff_effect_speed.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `buff_effect_speed`：add。`FighterBuffCtrler.speedUp` → `doEffectById`。持续光是 [`xg_buff_speed`](xg_buff_speed.md)。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 158**（FFDec `symbol158`），**17 帧** @30fps，约 8 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_buff_effect_speed extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol158")]`：FFDec 把 sprite 158 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_buff_effect_speed()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
