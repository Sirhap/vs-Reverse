# `(无名包).XG_bs` — 必杀黑底火花

一句话目的：普通必杀（非超必）时在角色头顶偏上播的 add 混合火花。

源文件：`decompiled/other/effect/scripts/XG_bs.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `bisha`：`className=XG_bs`，`sound=snd_bs`，`blendMode=add`。

[`FighterEffectCtrl.bisha(false, face?)`](../../engine/game/bvn/fighter/ctrler/FighterEffectCtrl.md) → [`EffectCtrl.bisha`](../../engine/game/bvn/ctrl/EffectCtrl.md)：justRenderAnimate + pause + 黑底 + 可选 [`bisha_face_mc`](bisha_face_mc.md) 特写 + 本剪辑在 `(x, y-50)` + 藏地图。超必走 [`XG_cbs`](XG_cbs.md)（`bisha_super`），不走本类。

万解 `wanKai` **不用**本类，强制 `bisha_super`。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 842**（FFDec `symbol842`），**17 帧** @30fps，约 6 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_bs extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol842")]`：FFDec 把 sprite 842 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_bs()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
