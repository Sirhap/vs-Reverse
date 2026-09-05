# `time_txtmc` — 倒计时一位数字 MC

一句话目的：计时每一位的字形。F1 `stop`。引擎 `getItemClass` 取 Class，`MCNumber` 每位 `new` 一颗，`gotoAndStop(1+digit)`。

源文件：`decompiled/ui/fight/scripts/time_txtmc.as`（20 行）

## 如何挂上引擎

**不是** `time_mc` 上的嵌套实例。[`FightTimeUI`](../../../engine/game/bvn/ui/fight/FightTimeUI.md) L31：

```
ResUtils.I.getItemClass(ResUtils.I.fight, "time_txtmc")
```

再 `new MCNumber(_loc3_, 0, 1, 20, 2)`：每格宽 20，**2 位补零**（`60`→`"60"`，`9`→`"09"`）。`startFrame=1` → 时间轴 **帧 1 = 数字 0**，帧 10 = 9。见 [`MCNumber`](../../../engine/kyo/display/MCNumber.md)。

无限时间不取本 Class。每逻辑帧 `number=` 会拆掉重建两位 MC。

无公开实例。无 `ct`。

## 逐行说明

- **L5** `symbol="symbol24"`。
- **L6** `public dynamic class time_txtmc extends MovieClip`。无字段。
- **L9–13 构造**：`addFrameScript(0, frame1)` → **F1**。
- **L15–18 `frame1`**：`stop()`。默认停在 0 的字形。`MCNumber.createNum` 立刻 `gotoAndStop(1+digit)` 覆盖。帧 2–10 无脚本。?
