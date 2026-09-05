# `hits_num_mc` — 连击一位数字 MC

一句话目的：连击每一位的字形。F1 `stop`。引擎 `getItemClass` 取 Class，`MCNumber` 每位 `new` 一颗，`gotoAndStop(1+digit)`。

源文件：`decompiled/ui/fight/scripts/hits_num_mc.as`（20 行）

## 如何挂上引擎

**不是** [`hits_mc`](hits_mc.md) 上的嵌套实例。[`HitsUI`](../../../engine/game/bvn/ui/fight/HitsUI.md) L22：

```
ResUtils.I.getItemClass(ResUtils.I.fight, "hits_num_mc")
```

再 `new MCNumber(_loc2_, 0, 1, 35)`：每格宽 **35**，**不**补零（`bits=0`）。`startFrame=1` → 时间轴 **帧 1 = 数字 0**，帧 10 = 9。见 [`MCNumber`](../../../engine/kyo/display/MCNumber.md)。

`_txtmc.x = -width + 45`：数字右对齐到 45px 锚点。`hits1` 再把整块 `_mc.x` 往右推 `width-45`，多位数向右长；`hits2` 不推块。

`number=` 每次拆掉重建各位。第一击不 `show`（事件层 hits>1 才来），但构造时已经 `new MCNumber(..., 0, ...)` 出了一个「0」，被 F1 `visible=false` 挡住。

无公开实例。无 `ct`。

## 逐行说明

- **L5** `symbol="symbol243"`。
- **L6** `public dynamic class hits_num_mc extends MovieClip`。无字段。
- **L9–13 构造**：`addFrameScript(0, frame1)` → **F1**。
- **L15–18 `frame1`**：`stop()`。默认停在 0 的字形。`MCNumber.createNum` 立刻 `gotoAndStop(1+digit)` 覆盖。帧 2–10 无脚本。?
