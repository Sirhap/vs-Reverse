# `qbar_barmc` — 气格外壳（四格 + 数字）

一句话目的：气条的条身。内层 `bar` 是 `bar1..bar4`；`txtmc` 显示当前气格数（1..4）。引擎 `QiBar.InsBar` 只动这两处，本类无帧脚本。

源文件：`decompiled/ui/fight/scripts/qbar_barmc.as`（19 行）

## 如何挂上引擎

[`qbar_mc.barmc`](qbar_mc.md)。[`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md) 构造 `_bar = new InsBar(_ui.barmc)`。引擎不按本类名 `getItemClass`。

`InsBar.setProcess(qi/100)`（封顶 3）：

| 格 | 可见 | `scaleX` |
|---|---|---|
| `bar.bar1` | `process>0` | `process`（≤1）或 1 |
| `bar.bar2` | `process>1` | `process-1`（1..2）或 1 |
| `bar.bar3` | `process>2` | `process-2`（2..3） |
| `bar.bar4` | `process>=3` | 不管（满 300 亮第 4 格） |

`txtmc.gotoAndStop(int(process)+1)`：0→1，1.x→2，2.x→3，3→4。见 [`qbar_txtmc_34`](fight_fla/qbar_txtmc_34.md)。

`setDirect`：只翻 `txtmc.scaleX` ±1。条本身不翻——P2 的 `fzqi2` SWF 已镜像。

## 逐行说明

- **L5** `symbol="symbol57"`。
- **L6** `public dynamic class qbar_barmc extends MovieClip`。
- **L9 `bar`**：[`qbar_barmcgroup`](qbar_barmcgroup.md)。四格容器。
- **L11 `txtmc`**：声明 `MovieClip`。运行时是 [`fight_fla.qbar_txtmc_34`](fight_fla/qbar_txtmc_34.md)。
- **L13–16 构造**：只 `super()`。无帧脚本。缩放 / 显隐 / 切数字全在 `InsBar`。
