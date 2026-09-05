# `(无名包).XG_ghost_step` — 鬼步残影火花

一句话目的：鬼步移动时脚下/身后的 add 火花。走路循环在鬼步状态下反复 `doEffectById`。

源文件：`decompiled/other/effect/scripts/XG_ghost_step.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `ghost_step`：`XG_ghost_step`，`snd_ghost_step`，`blendMode=add`。

两条声：**VO 的 `snd_ghost_step`** 在 `EffectView.start` 播；[`EffectCtrl.ghostStep`](../../engine/game/bvn/ctrl/EffectCtrl.md) 另外 `SoundCtrl.playSwcSound(snd_ghost_jump)`（主 SWF 嵌入，不在本库）。

触发：`$effect_ctrler.ghostStep` 开演出（pause + 黑底 + justRender 物理仍走）；之后 [`FighterEffectCtrl.walk`](../../engine/game/bvn/fighter/ctrler/FighterEffectCtrl.md) 若 `_inGhostStep` 则反复本 id，而不是 `step1/2/3` 脚步。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 15 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 313**（FFDec `symbol313`），**16 帧** @30fps，约 16 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_ghost_step extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol313")]`：FFDec 把 sprite 313 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_ghost_step()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
