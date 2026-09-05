# `qbar_fzqi_mc` — 辅助气竖条（fzqi 0–100）

一句话目的：辅助气槽。内层 `barmc` 被 `InsFzBar` 竖直翻转后用 `scrollRect` 裁高度，从视觉底部往上长。满条（≥1）才亮 `qbar_mc.readymc`。

源文件：`decompiled/ui/fight/scripts/qbar_fzqi_mc.as`（16 行）

## 如何挂上引擎

[`qbar_mc.fzqibar`](qbar_mc.md)。[`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md) `_fzBar = new InsFzBar(_ui.fzqibar)`。

`InsFzBar` 构造：

1. `_ui.barmc.getBounds(barmc)` **算了不用**。?
2. `_scroll = Rectangle(0,0,width,height)`，记下 `_height`。
3. `barmc.scaleY=-1`，`barmc.y=barmc.height`：竖直翻转，让 `scrollRect` 从「视觉底部」往上长。?

`setProcess(fzqi/100)`：**无 lerp**，瞬时 `_scroll.height = process * _height` 赋回 `barmc.scrollRect`。`fzqi>100` 会超高；负 height 在 Flash 里未定义。正常 `renderFzQi` 把 fzqi 卡在 100。

满条判定在 `QiBar.render`：`_fzBar.getProcess()>=1` 才改 `readymc.visible` 并 `mc.play()`。

P2 `setDirect` 不翻本条——SWF 已镜像。

## 逐行说明

- **L5** `symbol="symbol65"`。
- **L6** `public dynamic class qbar_fzqi_mc extends MovieClip`。
- **L9 `barmc`**：`MovieClip`。真正被 `scrollRect` / `scaleY=-1` 的那截。无导出子类名（AS 只声明 MovieClip）。
- **L11–14 构造**：只 `super()`。翻转和 scroll 全在 `InsFzBar` 构造（每个 `QiBar` 一次）。
