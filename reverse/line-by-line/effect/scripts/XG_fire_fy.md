# `(无名包).XG_fire_fy` — 火属性防御火花

一句话目的：挡住火属性时的防御火花。防住不挂燃烧。

源文件：`decompiled/other/effect/scripts/XG_fire_fy.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) `defense_7`：`XG_fire_fy`，`snd_defx`，freeze 400，add，`followDirect`，火色闪 0.2，shake pow 6。

无 `specialEffectId`。朝向用攻击者 `direct`（`EffectCtrl` + VO.`followDirect`）。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 14 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 802**（FFDec `symbol802`），**15 帧** @30fps，约 8 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fire_fy extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol802")]`：FFDec 把 sprite 802 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fire_fy()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
