# `txtmc_score` — 街机分数一位数字 MC

一句话目的：分数每一位的字形。F1 `stop`。与 [`time_txtmc`](time_txtmc.md) 同模式：`getItemClass` 取 Class，不是嵌套实例。

源文件：`decompiled/ui/fight/scripts/txtmc_score.as`（20 行）

## 如何挂上引擎

[`FightScoreUI`](../../../engine/game/bvn/ui/fight/FightScoreUI.md) L17：

```
ResUtils.I.getItemClass(ResUtils.I.fight, "txtmc_score")
```

`new MCNumber(_loc2_, 0, 1, 10, 10)`：每格宽 10，**10 位补零**（`0`→`"0000000000"`）。挂在 [`score_mc.ct`](score_mc.md)，不是本类。`startFrame=1` → 帧 1 = 数字 0。见 [`MCNumber`](../../../engine/kyo/display/MCNumber.md)。

超过 10 位会继续加 MC（不截断）。负分 `int`→`uint` 会变成大正数；正常 `GameData.I.score≥0`。

无公开实例。仅街机 `initScore` 才 new。

## 逐行说明

- **L5** `symbol="symbol216"`。
- **L6** `public dynamic class txtmc_score extends MovieClip`。无字段。
- **L9–13 构造**：`addFrameScript(0, frame1)` → **F1**。
- **L15–18 `frame1`**：`stop()`。默认 0 字形。`createNum` 再 `gotoAndStop(1+digit)`。
