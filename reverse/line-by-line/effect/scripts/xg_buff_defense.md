# `(无名包).xg_buff_defense` — 防御 buff 循环光

一句话目的：防御 buff 持续期间跟随角色脚底的循环光。`isBuff=true` → `BuffEffectView`。

源文件：`decompiled/other/effect/scripts/xg_buff_defense.as`（15 行）

## 如何挂上引擎

[`EffectModel.initBuffEffect`](../../engine/game/bvn/data/EffectModel.md) id `buff_defense`：`xg_buff_defense`，add，`isBuff`。无声、无 `targetColorOffset`。

[`FighterBuffCtrler.defenseUp`](../../engine/game/bvn/fighter/ctrler/FighterBuffCtrler.md) 先 `doEffectById("buff_effect_defense")` 播一次性 [`xg_buff_effect_defense`](xg_buff_effect_defense.md)，再 `doBuffEffect("buff_defense")` → [`BuffEffectView`](../../engine/game/bvn/views/effects/BuffEffectView.md)：`loopPlay=true`，逻辑帧跟 `FighterBuffVO.finished`。到期 `remove`，不改色（表无 offset）。

8 帧短循环。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 7 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 161**（FFDec `symbol161`），**8 帧** @30fps，约 4 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_buff_defense extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol161")]`：FFDec 把 sprite 161 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_buff_defense()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
