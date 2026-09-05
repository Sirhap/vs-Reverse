# `(无名包).XG_fire` — 火属性命中火花

一句话目的：火属性攻击打中时的命中火花，并给受击者挂持续燃烧 `fire_ing`。

源文件：`decompiled/other/effect/scripts/XG_fire.as`（15 行）

## 如何挂上引擎

[`EffectModel.initHitEffect`](../../engine/game/bvn/data/EffectModel.md) hitType **7 FIRE**：`XG_fire`，`snd_hit_fire`，add，freeze 400，火色闪 `0xFFFF67`，shake pow 6，**`specialEffectId=fire_ing`**。

命中链：`FighterMcCtrler.doHitEffect` → [`EffectCtrl.doHitEffect`](../../engine/game/bvn/ctrl/EffectCtrl.md) → [`EffectManager.getEffectVOByHitVO`](../../engine/game/bvn/utils/EffectManager.md) clone 本 VO（把 `pow` 抄到 `shake.y`）→ 普通 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md)。`doEffectVO` 末尾对 `FighterMain` 再 `doSpecialEffect("fire_ing")` → [`xg_fire_ing`](xg_fire_ing.md) + [`SpecialEffectView`](../../engine/game/bvn/views/effects/SpecialEffectView.md)。

防御命中走 [`XG_fire_fy`](XG_fire_fy.md)，不挂燃烧。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 22 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 825**（FFDec `symbol825`），**23 帧** @30fps，约 11 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fire extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol825")]`：FFDec 把 sprite 825 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fire()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
