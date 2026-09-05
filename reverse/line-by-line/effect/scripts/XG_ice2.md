# `(无名包).XG_ice2` — 遗留冰击火花（未登记）

一句话目的：22 帧冰剪辑，比现行 [`XG_ice`](XG_ice.md)（11 帧）长一倍。`initHitEffect(8)` 用的是 `XG_ice`，本类不进表。

源文件：`decompiled/other/effect/scripts/XG_ice2.as`（15 行）

## 如何挂上引擎

无 `EffectVO`、不烘焙、无声绑定。像旧版冰命中或另一套冰爆。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 743**（FFDec `symbol743`），**22 帧** @30fps，约 15 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_ice2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol743")]`：FFDec 把 sprite 743 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_ice2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
