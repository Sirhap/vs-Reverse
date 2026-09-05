# `FightScoreUI` — 街机分数条

一句话目的：绑 `score_mc`。用 `MCNumber(txtmc_score)` 显示 `GameData.I.score`，10 位补零。仅街机 `FightBar.initScore` 创建。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightScoreUI.as`（27 行）

## Callers / callees

- **Callers**：`FightBar.initScore`（`FightUI` 构造，且 `GameMode.isAcrade()`）`new FightScoreUI(_ui.scoremc)`；`FightBar.setScore` ← `FightUI.updateScore` ← `"SCORE_UPDATE"` 或 `initlize`。
- **Callees**：`ResUtils.I.getItemClass(ResUtils.I.fight, "txtmc_score")`；`MCNumber`。
- **加分源**（不直接调本类）：`GameLogic.addScoreByHitTarget`（P1 命中）、`addScoreByKO`、`addScoreByPassMission` 等 dispatch `"SCORE_UPDATE"`。见 `GameEvent.md`。

## 命名备注

- **没有** `destory` / `render`。数字只在 `setScore` 时改。
- `MCNumber(cls, 0, 1, 10, 10)`：每格宽 10，**10 位补零**。0 → `"0000000000"`。超过 10 位会继续加 MC（`MCNumber` 不截断）。
- 挂在 `score_mc.ct`。BITMAP 下 `scoremc` 被抬到 `ui_fight`，`ct` 仍在，addChild 有效。
- 非街机：`FightBar` 构造把 `scoremc.visible=false`（BITMAP 则整块 `_children` 开场隐藏，且从不 `initScore`）。VS/练习无分数。
- `isAcrade` = mode 10 组队街机 / 20 单挑街机 / 30 生存。拼写 Acrade。

## 逐行说明

### 字段 / 构造（L9–20）

`_ui=score_mc`。取 `txtmc_score` Class（SWF 帧 1 `stop`，每帧一个数字字形）。`new MCNumber(..., 0, 1, 10, 10)` 放进 `_ui.ct`。初始 10 个 0。

`txtmc_score` 本身无 `ct`；容器是 `score_mc.ct`。

### `setScore`（L22–25）

`_nummc.number = param1`。`int`→`uint`，负分会变成大正数。正常 score≥0。`FightUI.updateScore` 传 `GameData.I.score` 整型。
