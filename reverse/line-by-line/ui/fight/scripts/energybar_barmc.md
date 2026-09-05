# `energybar_barmc` — 体力条外壳

一句话目的：体力条的外层。公开 `bar`；引擎只缩这一截的 `scaleX`，并在帧 1/2 间切正常/耗尽样式。

源文件：`decompiled/ui/fight/scripts/energybar_barmc.as`（17 行）

## 如何挂上引擎

[`energy_bar.barmc`](energy_bar.md)。[`EnergyBar`](../../../engine/game/bvn/ui/fight/EnergyBar.md) 构造 `new InsBar(_ui.barmc.bar)`——绑的是 **内层 `bar`**，不是本 MC。

`InsBar`：

- `rate = energy/energyMax`，lerp `bar.scaleX`（系数 0.4）。
- `normal()` → `bar.gotoAndStop(1)`。
- `overLoad()` → `gotoAndStop(2)`（耗尽样式，scaleX 仍跟回复涨）。
- `flash()`：每 3 逻辑帧在 1↔2 切。

本类无帧脚本。内层 `bar` 的 Class 很可能是 [`fight_fla.energybar_bar_8`](fight_fla/energybar_bar_8.md)（F1 `stop`，至少两帧）。声明类型是 `MovieClip`，AS 未写死嵌套类名。?

P2 不翻本 MC（SWF `energy2` 已镜像）；只翻 `txtmc`。

## 逐行说明

- **L5** `symbol="symbol100"`。
- **L6** `public dynamic class energybar_barmc extends MovieClip`。
- **L9 `bar`**：`MovieClip`。唯一公开槽。InsBar 的 `_mc`。
- **L11–14 构造**：只 `super()`。
