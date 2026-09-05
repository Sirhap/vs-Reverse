# `(无名包).XG_kan` — 遗留轻斩火花（未登记）

一句话目的：旧轻斩剪辑（12 帧）。现行 hitType 1 用 [`XG_kan2`](XG_kan2.md)（10 帧）。

源文件：`decompiled/other/effect/scripts/XG_kan.as`（15 行）

## 如何挂上引擎

`initHitEffect(1, "XG_kan2", …)`。钢体斩也用 `XG_kan2`。本类不烘焙。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 532**（FFDec `symbol532`），**12 帧** @30fps，约 6 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_kan extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol532")]`：FFDec 把 sprite 532 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_kan()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
