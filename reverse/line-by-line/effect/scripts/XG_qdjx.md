# `(无名包).XG_qdjx` — 重拳命中火花

一句话目的：重拳（hitType 3）命中火花。重击套餐。

源文件：`decompiled/other/effect/scripts/XG_qdjx.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) hitType **3 DA_HEAVY**：`XG_qdjx`，`snd_hit_heavy`，add，`randRotate`，freeze 400，白闪 0.2，shake pow 6。

遗留 [`XG_qdjx2`](XG_qdjx2.md) 未用。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 651**（FFDec `symbol651`），**17 帧** @30fps，约 9 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_qdjx extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol651")]`：FFDec 把 sprite 651 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_qdjx()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
