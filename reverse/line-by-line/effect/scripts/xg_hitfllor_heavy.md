# `(无名包).xg_hitfllor_heavy` — 重砸地火花（原拼写 fllor）

一句话目的：受击落地强度 2 的重砸地火花。符号名少一个 o：`fllor`。

源文件：`decompiled/other/effect/scripts/xg_hitfllor_heavy.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `hit_floor_heavy`：`className=xg_hitfllor_heavy`（必须逐字匹配），`snd_hitfloor_heavy`。

[`EffectCtrl.hitFloorEffect(2)`](../../engine/game/bvn/ctrl/EffectCtrl.md) **同时**再播 [`xg_hitfloor_yan`](xg_hitfloor_yan.md)（lighten 烟、无声）。本剪辑本身 normal 混合。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 17 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 280**（FFDec `symbol280`），**18 帧** @30fps，约 9 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

引擎注释已标明这是原拼写，不是反编译错误。

## 逐行说明

无名包。`public dynamic class xg_hitfllor_heavy extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol280")]`：FFDec 把 sprite 280 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_hitfllor_heavy()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
