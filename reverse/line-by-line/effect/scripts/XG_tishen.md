# `(无名包).XG_tishen` — 替身第一段

一句话目的：死神受身/替身演出的第一段火花。pause + 黑底时立刻播在**位移前**的坐标。

源文件：`decompiled/other/effect/scripts/XG_tishen.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `replaceSp`：`XG_tishen` + `snd_fz`（和火影辅助出场同一声）。

[`FighterMain.replaceSkill`](../../engine/game/bvn/fighter/FighterMain.md) 先 `move(250*direct)`、idle、无敌；[`EffectCtrl.replaceSkill`](../../engine/game/bvn/ctrl/EffectCtrl.md) 再 pause、黑底、藏地图、本剪辑（坐标是调用瞬间，位移已发生）、hold 1 秒逻辑帧。第一拍 [`renderReplaceSkill`](../../engine/game/bvn/ctrl/EffectCtrl.md) 再播 [`XG_tishen2`](XG_tishen2.md)。

火影受身走爆气 `energyExplode`，不走替身。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 34 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 470**（FFDec `symbol470`），**35 帧** @30fps，约 25 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

本剪辑 35 帧，是 SWF 里最长的普通火花之一（必杀脸 71 帧除外）。

## 逐行说明

无名包。`public dynamic class XG_tishen extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol470")]`：FFDec 把 sprite 470 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_tishen()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
