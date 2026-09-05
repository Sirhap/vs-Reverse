# `hpbar_barmc` — 单侧 HP 条（绿当前 + 红拖尾）

一句话目的：一条血的两个条子。`bar` 跟当前 HP，`redbar` 是受击后慢追上的缺口。

源文件：`decompiled/ui/fight/scripts/hpbar_barmc.as`（20 行）

## 如何挂上引擎

[`hpbar_mc.bar1` / `bar2`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) 构造 `new FighterHpBar(_ui.bar1/bar2)`。

[`FighterHpBar`](../../../engine/game/bvn/ui/fight/FighterHpBar.md)：`_bar=_ui.bar`，`_redbar=_ui.redbar`。每逻辑帧改 **`scaleX`**（满血默认 1）。绿条掉血系数 0.4、回血 0.04；红条 delay 后再 0.1 / 0.02。P2 的 `bar2` SWF 已朝左，本类和引擎都不 `scaleX*=-1`。

BITMAP：整块 `hpbar_barmc` 从本父级抬到 `ui_fight`，不烤进底图。

无帧脚本。条子内部若还有嵌套 MC，引擎当 `DisplayObject` 只缩 `scaleX`。

## 逐行说明

- **L5** `symbol="symbol112"`。
- **L6** `public dynamic class hpbar_barmc extends MovieClip`。
- **L9 `bar`**：`MovieClip`。当前 HP（绿/前景）。`FighterHpBar.render` lerp `scaleX`。
- **L11 `redbar`**：`MovieClip`。拖尾。受击 `HURT_ING`(21) delay 写死 100 帧；击飞/倒地再等 `1.5*FPS_GAME`。新伤害且红条在动会先 snap 到旧比率。
- **L13–16 构造**：只 `super()`。无 `addFrameScript`、无公开方法。
