# `(无名包).XG_xdash` — 遗留冲刺火花（未登记）

一句话目的：25 帧、几乎每帧 Place 的冲刺剪辑。现行 dash 用 [`XG_rush`](XG_rush.md) / [`XG_rush_air`](XG_rush_air.md)。配对 [`snd_xdash`](snd_xdash.md) 同样未引用。

源文件：`decompiled/other/effect/scripts/XG_xdash.as`（15 行）

## 如何挂上引擎

`xdash` ≈ 横冲。启动不烘焙。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 446**（FFDec `symbol446`），**25 帧** @30fps，约 24 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_xdash extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol446")]`：FFDec 把 sprite 446 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_xdash()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
