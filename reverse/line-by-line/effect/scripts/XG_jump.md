# `(无名包).XG_jump` — 起跳尘

一句话目的：地面起跳时脚下的尘。坐标用 **display** x/y，不是逻辑坐标。

源文件：`decompiled/other/effect/scripts/XG_jump.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `jump`：`XG_jump` + `snd_jump`。无 add。

[`FighterEffectCtrl.jump`](../../engine/game/bvn/fighter/ctrler/FighterEffectCtrl.md) → [`EffectCtrl.jumpEffect`](../../engine/game/bvn/ctrl/EffectCtrl.md)。空中二段跳走 [`XG_jump_air`](XG_jump_air.md)，共用 `snd_jump`。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 9 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 181**（FFDec `symbol181`），**10 帧** @30fps，约 4 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_jump extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol181")]`：FFDec 把 sprite 181 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_jump()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
