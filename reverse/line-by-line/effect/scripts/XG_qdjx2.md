# `(无名包).XG_qdjx2` — 遗留重拳火花（未登记）

一句话目的：13 帧重拳变体。现行 hitType 3 用 [`XG_qdjx`](XG_qdjx.md)（17 帧）。

源文件：`decompiled/other/effect/scripts/XG_qdjx2.as`（15 行）

## 如何挂上引擎

无 VO。命名 `qdjx2` 与斩系 `kan2`/`kanx2`「第二版」同一套替换习惯，但这条没切过去。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 634**（FFDec `symbol634`），**13 帧** @30fps，约 15 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_qdjx2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol634")]`：FFDec 把 sprite 634 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_qdjx2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
