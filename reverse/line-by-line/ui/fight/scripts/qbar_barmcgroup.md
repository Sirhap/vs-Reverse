# `qbar_barmcgroup` — 气格四格（bar1..bar4）

一句话目的：四条气格 MovieClip 的容器。`qi/100` 映射 0–3：前三格分段填满，`bar4` 只在满 300 时亮。本类无逻辑。

源文件：`decompiled/ui/fight/scripts/qbar_barmcgroup.as`（22 行）

## 如何挂上引擎

[`qbar_barmc.bar`](qbar_barmc.md)。[`QiBar.InsBar`](../../../engine/game/bvn/ui/fight/QiBar.md) 写 `_ui.bar.bar1..bar4` 的 `visible` / `scaleX`。引擎不 `new` 本类。

气格：`FighterMain.qiMax=300` const；UI 用 `qi/100` 封顶 3。`bar1`=0–100，`bar2`=100–200，`bar3`=200–300，`bar4` 在 `>=300` 时 `visible=true`（scale 不管）。

`setProcess` 从 >2 掉到 ≤2 时**不**把 `bar3.scaleX` 收回；只 `bar3.visible=false`。?

## 逐行说明

- **L5** `symbol="symbol45"`。
- **L6** `public dynamic class qbar_barmcgroup extends MovieClip`。
- **L9–15 `bar1` / `bar2` / `bar3` / `bar4`**：各一颗 `MovieClip`。无子字段。InsBar 当 stretch 条用。
- **L17–20 构造**：只 `super()`。无帧脚本。
