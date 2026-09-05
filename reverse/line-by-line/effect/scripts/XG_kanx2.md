# `(无名包).XG_kanx2` — 重斩命中火花

一句话目的：重斩（hitType 6）命中火花。重击套餐：400ms freeze + 白闪 + 震屏 + 随机旋转。

源文件：`decompiled/other/effect/scripts/XG_kanx2.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) hitType **6 KAN_HEAVY**：`XG_kanx2`，`snd_kan2`，add，`randRotate`，freeze 400，白闪 0.2，shake `pow:6, time:400`（[`EffectManager`](../../engine/game/bvn/utils/EffectManager.md) 把 pow 抄到 `shake.y`）。

无 `isSteelHit`。无 `specialEffectId`。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 507**（FFDec `symbol507`），**17 帧** @30fps，约 18 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_kanx2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol507")]`：FFDec 把 sprite 507 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_kanx2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
