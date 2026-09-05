# `(无名包).XG_bsq` — 爆气起手火花

一句话目的：爆气/霸体爆发的前半段（`explodeSp`）。pause + 黑底期间先播这一段。

源文件：`decompiled/other/effect/scripts/XG_bsq.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `explodeSp`：`XG_bsq` + `snd_baoqi1`。

[`EffectCtrl.energyExplode`](../../engine/game/bvn/ctrl/EffectCtrl.md)：pause、黑底（不 fadIn）、藏地图、在 fighter 坐标 `doEffectById("explodeSp")`，然后 `_explodeSkillFrame = 0.7 * FPS_GAME`。到期 [`XG_baoqi`](XG_baoqi.md)。

角色侧同时开超钢体、造 `HitVO`（power 50, hitType 5, 击飞）。本剪辑本身无 freeze/shine。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 15 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 875**（FFDec `symbol875`），**16 帧** @30fps，约 16 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_bsq extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol875")]`：FFDec 把 sprite 875 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_bsq()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
