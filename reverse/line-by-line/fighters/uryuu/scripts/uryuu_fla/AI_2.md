# `uryuu_fla.AI_2` — AI 判定面 AImain

一句话目的：动作 MC 上的 `AImain` 元件类：AI/距离判定「面」。`FighterMC.initHitRange` 把本 clip `gotoAndStop(2)`，按 `FighterHitRange.getALL()` 取 `*mian` bounds，再 `gotoAndStop(1)` 并 `visible=false`。

源文件：`decompiled/fighters/uryuu/scripts/uryuu_fla/AI_2.as`（56 行）

## 如何挂上引擎

实例名必须是 `AImain`（`FighterMC.getChildByName("AImain")`）。`renderChildren` 跳过它，不自动播。[`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 常量对应下列子件。缺某个 `*mian` 则该招没有独立 AI 范围盒。 缺：`bsmian`、`kbsmian` → 对应招没有独立 AI 范围盒。 多余 `absmian`（不在 `getALL()`，? 不采样）。

## 逐行说明

- **Embed** `source="/_assets/assets.swf", symbol="symbol10"`。
- **构造** `addFrameScript(0, frame1)`。
- **`frame1`**：`stop()`。运行时真正被拨到第 2 帧采样，第 1 帧是收起态。

| L | 子件 | `FighterHitRange` |
|---|---|---|
| L22 | `tkanmian` | JUMP_ATTACK 跳轻 |
| L24 | `kanmian` | ATTACK 地面轻 |
| L26 | `zh2mian` | ZHAO2 |
| L28 | `sbsmian` | BISHA_UP 上必 |
| L30 | `tzmian` | JUMP_SKILL 跳重 |
| L32 | `zh3mian` | ZHAO3 |
| L34 | `cbsmian` | BISHA_SUPER 超必 |
| L36 | `zh1mian` | ZHAO1 |
| L38 | `absmian` | 不在 getALL()，? 不采样 |
| L40 | `kj2mian` | SKILL2 上攻 |
| L42 | `kj1mian` | SKILL1 下攻 |
