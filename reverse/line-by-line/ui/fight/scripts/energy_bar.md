# `energy_bar` — 出战角色体力条（不是气）

一句话目的：顶栏体力。`barmc.bar` 按 `energy/energyMax` 缩 `scaleX`；`txtmc` 按 `comicType` 切死神/火影字，低体力闪、overload 停红帧。

源文件：`decompiled/ui/fight/scripts/energy_bar.as`（20 行）

## 如何挂上引擎

[`hpbar_mc.energy1` / `energy2`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) `new EnergyBar(_ui.energy1/2)`；P2 `setDirect(-1)` 只翻文字。

[`EnergyBar`](../../../engine/game/bvn/ui/fight/EnergyBar.md)：

- `_bar = new InsBar(_ui.barmc.bar)` → 真正 `scaleX` 的那截，类型见 [`energybar_barmc`](energybar_barmc.md) / [`energybar_bar_8`](fight_fla/energybar_bar_8.md)。
- `_txt = new InsTxt(_ui.txtmc)`。期望 `txtmc.mc`（[`energybar_txt_mc_3`](fight_fla/energybar_txt_mc_3.md)）。
- `setType(comicType)`：0 → `txtmc` 帧 1 死神，1 → 帧 2 火影。
- overload → 条/字 `gotoAndStop(2)`；`rate<0.3` 闪 1↔2；否则帧 1。

**不是** [`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md)。气 + 辅助气在 `ui_fight.fzqi1/2`。

BITMAP：整块抬到 `ui_fight`。`destory` 只 null `_fighter`。

## 逐行说明

- **L5** `symbol="symbol101"`。
- **L6** `public dynamic class energy_bar extends MovieClip`。
- **L9 `barmc`**：[`energybar_barmc`](energybar_barmc.md)。体力条外壳，内层 `bar` 才被 InsBar 缩放。
- **L11 `txtmc`**：声明 `MovieClip`。运行时是 [`fight_fla.energybar_txt_mc_3`](fight_fla/energybar_txt_mc_3.md)（有 `mc` 子级）。InsTxt 多处 `if(_mc.mc)` 护栏。
- **L13–16 构造**：只 `super()`。无帧脚本。闪/overload 全在引擎 `InsBar` / `InsTxt`。
