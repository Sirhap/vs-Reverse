# `(无名包).XG_kanx` — 遗留重斩火花（未登记）

一句话目的：旧重斩（21 帧）。现行 hitType 6 用 [`XG_kanx2`](XG_kanx2.md)（17 帧）。

源文件：`decompiled/other/effect/scripts/XG_kanx.as`（15 行）

## 如何挂上引擎

钢体没有单独的重斩 id，重斩打钢体仍按 hitType 走 `steel_hit_kan` → `XG_kan2`。本类完全闲置。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 508**（FFDec `symbol508`），**21 帧** @30fps，约 10 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_kanx extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol508")]`：FFDec 把 sprite 508 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_kanx()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
