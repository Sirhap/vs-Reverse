# `(无名包).XG_fz_naruto_mc` — 火影辅助出场火花

一句话目的：火影阵营（`comicType==1`）助战进场火花。声用 `snd_fz`。

源文件：`decompiled/other/effect/scripts/XG_fz_naruto_mc.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `fz_naruto`：`XG_fz_naruto_mc` + `snd_fz`。

与死神出场 [`XG_fz_bleach_mc`](XG_fz_bleach_mc.md) 成对。替身 [`XG_tishen`](XG_tishen.md) 也复用 `snd_fz`。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 11 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 776**（FFDec `symbol776`），**12 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fz_naruto_mc extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol776")]`：FFDec 把 sprite 776 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fz_naruto_mc()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
