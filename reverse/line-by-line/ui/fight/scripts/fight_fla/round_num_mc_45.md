# `fight_fla.round_num_mc_45` — ROUND 数字（nummc，r1..r5）

一句话目的：开场片里的回合数字。用作 [`game_start_mc_44.nummc`](game_start_mc_44.md)。F27/F28 `gotoAndPlay("r"+$round)` 播 r1..r5；六处 `stop` = 默认 idle + 五段结束（或 r1–r5 + 多一段）。?

源文件：`decompiled/ui/fight/scripts/fight_fla/round_num_mc_45.as`（45 行）

## 如何挂上引擎

[`game_start_mc_44`](game_start_mc_44.md) 字段 `nummc` 声明 `MovieClip`。本类是 fight SWF 里对应元件（`fight_fla` + FFDec 后缀 `_45`），**很可能**就是那层 `nummc`。引擎从不 `getItemClass("round_num_mc_45")`，只经开场片时间轴 `gotoAndPlay`。?

[`FightUI.showStart`](../../../../engine/game/bvn/ui/fight/FightUI.md) 写 `$round` 后 `gotoAndStop("start"|"start_final")`，再靠 `renderStartAndKO` `nextFrame()` 爬到 F27/F28，由父级脚本触发本 MC：

```
nummc.gotoAndPlay("r" + $round)
```

`$round` 在 F27 被钳到 1..5，所以标签只有 `r1`..`r5`。标签字符串不在本 AS，在 SWF 时间轴。

本 MC 用 **`gotoAndPlay`**（Flash 自己走帧），**不**经 `FightUI.renderStartAndKO`。父级 `nextFrame()` 只推 `startKOmc`，本子件靠自身 `play()` 播数字入场，碰到本帧脚本 `stop()` 停住。

## 时间轴

`addFrameScript N` = 时间轴 **F{N+1}**：

| 脚本下标 | 时间轴 | 间隔 | 推断 |
|---|---|---|---|
| 0 | **F1** | — | 默认 idle `stop`。`r1` 标签不应落在 F1（否则 `gotoAndPlay("r1")` 立刻被 `stop()` 掐死）。? |
| 16 | **F17** | 16 帧 | r1 结束 ? |
| 33 | **F34** | 17 帧 | r2 结束 ? |
| 50 | **F51** | 17 帧 | r3 结束 ? |
| 66 | **F67** | 16 帧 | r4 结束 ? |
| 81 | **F82** | 15 帧 | r5 结束 ? |

6 个 `stop` = idle + r1–r5，或 r1–r5 + 多一段（例如 FINAL 共用 r5 另有收尾）。? 无 `COMPLETE`、无字段。

## 逐行说明

- **L1** `package fight_fla`。
- **L5** `symbol="symbol162"`。
- **L6** `public dynamic class round_num_mc_45 extends MovieClip`。无公开实例。
- **L9–13 构造**：`addFrameScript(0, frame1, 16, frame17, 33, frame34, 50, frame51, 66, frame67, 81, frame82)`。
- **L15–18 `frame1`**：`stop()`。默认停。
- **L20–23 `frame17`**：`stop()`。
- **L25–28 `frame34`**：`stop()`。
- **L30–33 `frame51`**：`stop()`。
- **L35–38 `frame67`**：`stop()`。
- **L40–43 `frame82`**：`stop()`。

每段都是纯 `stop`，不派事件。父级开场片不听本 MC，只在 F55/F58/F88 自己派 `"fight_in"` / `"fight"` / `COMPLETE`。
