# `(无名包).xg_hitfloor_yan` — 重砸地烟（lighten）

一句话目的：重砸地额外一层烟。`blendMode=lighten`，无声。只在强度 2 时和 heavy 火花一起播。

源文件：`decompiled/other/effect/scripts/xg_hitfloor_yan.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `hit_floor_yan`：只有 lighten。`hitFloorEffect(2)` 在 heavy 之后再 `doEffectById`。两份 View 同坐标叠画。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 17 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 246**（FFDec `symbol246`），**18 帧** @30fps，约 14 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_hitfloor_yan extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol246")]`：FFDec 把 sprite 246 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_hitfloor_yan()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
