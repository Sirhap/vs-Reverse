# `(无名包).XG_baoqi` — 爆气爆炸段火花

一句话目的：爆气演出后半段（`explodeSp2`）的爆炸剪辑。黑底结束时在角色原坐标播一次。

源文件：`decompiled/other/effect/scripts/XG_baoqi.as`（15 行）

## 如何挂上引擎

[`EffectModel.initEffects`](../../engine/game/bvn/data/EffectModel.md) 登记 id `explodeSp2`，`className=XG_baoqi`，`sound=snd_baoqi`。启动时 [`EffectVO.cacheBitmapData`](../../engine/game/bvn/data/EffectVO.md) 经 [`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) `new` 本类，逐帧光栅化后丢掉 MC。

运行时 [`EffectCtrl.endEnergyExplode`](../../engine/game/bvn/ctrl/EffectCtrl.md)（`energyExplode` 倒数 0.7s 到期）`doEffectById("explodeSp2")` → [`EffectManager.getEffectView`](../../engine/game/bvn/utils/EffectManager.md) 普通 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md)。触发链：角色 SWF / [`FighterMain.energyExplode`](../../engine/game/bvn/fighter/FighterMain.md) → `$effect_ctrler.energyExplode` → [`FighterEffectCtrl`](../../engine/game/bvn/fighter/ctrler/FighterEffectCtrl.md)。

无 `isSpecial`/`isBuff`/`isSteelHit`。无 `blendMode`（默认 `normal`）。无 freeze/shine/shake。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 14 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 911**（FFDec `symbol911`），**15 帧** @30fps，约 8 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

前半段是 [`XG_bsq`](XG_bsq.md)（`explodeSp` + `snd_baoqi1`）。两段坐标都是调用瞬间的 fighter x/y。

## 逐行说明

无名包。`public dynamic class XG_baoqi extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol911")]`：FFDec 把 sprite 911 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_baoqi()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
