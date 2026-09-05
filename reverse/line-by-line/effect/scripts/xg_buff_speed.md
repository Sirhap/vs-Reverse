# `(无名包).xg_buff_speed` — 速度 buff 循环光

一句话目的：速度 buff 持续期间跟随角色的循环光。`BuffEffectView`。

源文件：`decompiled/other/effect/scripts/xg_buff_speed.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `buff_speed`：add，`isBuff`。`speedUp` → `doBuffEffect`。8 帧循环，无 offset。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 7 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 140**（FFDec `symbol140`），**8 帧** @30fps，约 4 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_buff_speed extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol140")]`：FFDec 把 sprite 140 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_buff_speed()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
