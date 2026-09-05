# `(无名包).xg_hitover` — KO 收招火花

一句话目的：KO 演出收招时的火花。裸 VO：无声、无 add。

源文件：`decompiled/other/effect/scripts/xg_hitover.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `hit_end`：`xg_hitover`。

[`FightUI`](../../engine/game/bvn/ui/fight/FightUI.md) KO：关 `freezeEnabled`、`doEffectById("hit_end")`、shine、可选 `BGEffect("kobg")`、shake、`slowDown(2,0)`。24 帧。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 23 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 217**（FFDec `symbol217`），**24 帧** @30fps，约 10 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_hitover extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol217")]`：FFDec 把 sprite 217 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_hitover()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
