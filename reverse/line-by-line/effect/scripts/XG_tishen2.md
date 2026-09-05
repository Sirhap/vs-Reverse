# `(无名包).XG_tishen2` — 替身第二段（无声）

一句话目的：替身黑底期间第 1 逻辑帧补上的第二段。VO 无 sound。

源文件：`decompiled/other/effect/scripts/XG_tishen2.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `replaceSp2`：只有 `className=XG_tishen2`。

[`EffectCtrl.renderReplaceSkill`](../../engine/game/bvn/ctrl/EffectCtrl.md)：`frame==1` 时在记下的 pos 播本 id。1 秒后 `endReplaceSkill` resume。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 17 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 467**（FFDec `symbol467`），**18 帧** @30fps，约 10 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_tishen2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol467")]`：FFDec 把 sprite 467 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_tishen2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
