# `(无名包).XG_fykanx` — 重斩防御火花

一句话目的：挡住重斩（hitType 6）时的重防火花。带白闪（shine 自带 `blendMode=screen`）和震屏。

源文件：`decompiled/other/effect/scripts/XG_fykanx.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) `defense_6`：`XG_fykanx`，`snd_fykanx`，freeze 400，add，shine 白 alpha 0.1 **且 shine.blendMode=screen**（其它重防 shine 没写 blend），`followDirect`，shake pow 6 / 400ms。

拳防角色把 6→3，改播 [`XG_fyqx`](XG_fyqx.md)。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 18 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 602**（FFDec `symbol602`），**19 帧** @30fps，约 15 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fykanx extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol602")]`：FFDec 把 sprite 602 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fykanx()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
