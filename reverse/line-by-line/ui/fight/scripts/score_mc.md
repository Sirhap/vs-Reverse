# `score_mc` — 街机分数容器

一句话目的：顶栏分数坑。只有 `ct`；引擎把 10 位 `MCNumber(txtmc_score)` 塞进去。仅街机亮。

源文件：`decompiled/ui/fight/scripts/score_mc.as`（17 行）

## 如何挂上引擎

[`hpbar_mc.scoremc`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) 非 BITMAP 构造先 `scoremc.visible=false`。仅 `GameMode.isAcrade()`（10/20/30，拼写 Acrade）时 `FightUI` 构造调 `initScore()` → `new FightScoreUI(_ui.scoremc)`。

[`FightScoreUI`](../../../engine/game/bvn/ui/fight/FightScoreUI.md)：`getItemClass(..., "txtmc_score")`，`MCNumber(cls, 0, 1, 10, 10)` **`ct.addChild`**。`setScore` ← `FightUI.updateScore` ← `"SCORE_UPDATE"` 或 `initlize`。

BITMAP：`scoremc` 已抬到 `ui_fight`，`ct` 仍在，addChild 有效。VS/练习永不 `initScore`。无 `destory` / `render`。

## 逐行说明

- **L5** `symbol="symbol135"`。
- **L6** `public dynamic class score_mc extends MovieClip`。
- **L9 `ct`**：`MovieClip`。唯一槽。数字不在时间轴上，是代码加的。
- **L11–14 构造**：只 `super()`。无帧脚本。
