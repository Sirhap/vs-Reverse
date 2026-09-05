# `fight_fla.qbar_txtmc_34` — 气格数字（txtmc）

一句话目的：`qbar_barmc.txtmc` 的运行时类型。F1 `stop`。引擎 `gotoAndStop(int(qi/100)+1)` 切 1..4 帧，显示当前气格数。

源文件：`decompiled/ui/fight/scripts/fight_fla/qbar_txtmc_34.as`（20 行）

## 如何挂上引擎

[`qbar_barmc.txtmc`](../qbar_barmc.md) 声明 `MovieClip`。[`QiBar.InsBar.setProcess`](../../../../engine/game/bvn/ui/fight/QiBar.md) L340–341：

```
txtmc.gotoAndStop(int(process)+1)
```

`process = qi/100` 封顶 3：

| process | 帧 | 含义 |
|---|---|---|
| 0 | 1 | 空 |
| 0.x～<2 | 1 或 2 | `int(1.x)+1=2` |
| 2.x | 3 | 刚进第三格数字就跳 3 |
| 3（满 300） | 4 | 满 |

引擎不按本类名 `getItemClass`。`setDirect` 翻的是本 MC 的 `scaleX` ±1。

无 `mc` 子级（体力字 [`energybar_txt_mc_3`](energybar_txt_mc_3.md) 才有）。本类只靠自身帧当字形。

## 逐行说明

- **L1** `package fight_fla`。
- **L5** `symbol="symbol54"`（紧挨 [`qbar_barmc`](../qbar_barmc.md) symbol57）。
- **L6** `public dynamic class qbar_txtmc_34 extends MovieClip`。无公开实例。
- **L9–13 构造**：`addFrameScript(0, frame1)` → **F1**。
- **L15–18 `frame1`**：`stop()`。默认停帧 1（空 / 0 格）。`setProcess` 的 `gotoAndStop` 覆盖。帧 2–4 无脚本——外层 `gotoAndStop` 钉住。?
