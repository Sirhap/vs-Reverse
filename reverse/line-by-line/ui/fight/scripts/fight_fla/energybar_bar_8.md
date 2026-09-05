# `fight_fla.energybar_bar_8` — 体力条内层 clip

一句话目的：体力绿条真正被 `scaleX` 的那截 MovieClip。F1 `stop`，引擎再 `gotoAndStop(1|2)` 切正常/overload。

源文件：`decompiled/ui/fight/scripts/fight_fla/energybar_bar_8.as`（21 行）

## 如何挂上引擎

无名包的 [`energybar_barmc.bar`](../energybar_barmc.md) 声明成 `MovieClip`。本类是 fight SWF 里对应元件的导出（`fight_fla` + FFDec 后缀 `_8`），**很可能**就是那层 `bar`。引擎从不 `getItemClass("energybar_bar_8")`，只经 [`EnergyBar.InsBar`](../../../../engine/game/bvn/ui/fight/EnergyBar.md) 拿到 `_ui.barmc.bar`。?

`InsBar` 假定至少两帧：

| 帧 | 谁切 | 含义 |
|---|---|---|
| 1 | `normal()`；闪的另一极 | 正常体力 |
| 2 | `overLoad()`；`flash()` 种子 | 耗尽 / 闪红 |

`rate` 改的是 `scaleX`，与当前停在哪一帧无关。overload 回复时条子在帧 2 上变长。

## 逐行说明

- **L1** `package fight_fla`。
- **L5** `symbol="symbol97"`。
- **L6** `public dynamic class energybar_bar_8 extends MovieClip`。无公开实例。
- **L9–13 构造**：`super()`；`addFrameScript(0, frame1)` → 时间轴 **F1**。
- **L15–18 `frame1`**：`stop()`。防止时间轴自己播。引擎随后 `gotoAndStop(1|2)` 覆盖停帧。无 `COMPLETE`、无标签字符串（`in_bleach` 一类不在本 AS）。
