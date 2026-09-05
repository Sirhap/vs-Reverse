# `(无名包).XG_fz_bleach_mc` — 死神辅助出场火花

一句话目的：死神阵营（`comicType!=1`）助战进场时的短火花。声用 `snd_dash`（不是 `snd_fz`）。

源文件：`decompiled/other/effect/scripts/XG_fz_bleach_mc.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `fz_bleach`：`XG_fz_bleach_mc` + `snd_dash`。

[`EffectCtrl.assisterEffect`](../../engine/game/bvn/ctrl/EffectCtrl.md)：`comicType==1` → [`XG_fz_naruto_mc`](XG_fz_naruto_mc.md)，否则本类。`FighterEventCtrl.addAssister` 与 `AssisiterCtrler.finish` 调。

助战 SWF 自己还会 `$assisterCtrler.effect.bisha` 等，那是另一套必杀黑底，不是本剪辑。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 10 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 336**（FFDec `symbol336`），**11 帧** @30fps，约 11 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fz_bleach_mc extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol336")]`：FFDec 把 sprite 336 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fz_bleach_mc()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
