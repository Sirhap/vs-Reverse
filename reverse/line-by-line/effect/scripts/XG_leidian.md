# `(无名包).XG_leidian` — 电属性命中火花

一句话目的：电属性打中时的命中火花（**hardlight** 混合），并挂持续感电 `shock_ing`。

源文件：`decompiled/other/effect/scripts/XG_leidian.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) hitType **9 ELECTRIC**：`XG_leidian`，`snd_hit_dian`，**`blendMode=hardlight`**（命中表里唯一 hardlight），`specialEffectId=shock_ing`，freeze 400，电色闪 `0x8288D2`，shake pow 6。

持续段 [`xg_dian_ing`](xg_dian_ing.md)。遗留 [`xg_dian_ing2`](xg_dian_ing2.md) 未用。防御 [`XG_dian_fy`](XG_dian_fy.md) 用 add 不是 hardlight。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 11 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 701**（FFDec `symbol701`），**12 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_leidian extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol701")]`：FFDec 把 sprite 701 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_leidian()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
