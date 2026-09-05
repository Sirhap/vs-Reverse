# `fight_fla.winmc_bleach_22` — 胜场灯内层动画

一句话目的：`winmc.w1` / `w2` 里那颗会 `gotoAndPlay` 的灯。三处 `stop`：F1、F20、F40。类名带 bleach，但同一 clip 也很可能兼火影段。

源文件：`decompiled/ui/fight/scripts/fight_fla/winmc_bleach_22.as`（30 行）

## 如何挂上引擎

[`winmc.w1` / `w2`](../winmc.md) 声明 `MovieClip`。[`WinUI`](../../../../engine/game/bvn/ui/WinUI.md) 对选中的那盏：

- `comicType==0` → `gotoAndPlay("in_bleach")`
- `comicType==1` → `gotoAndPlay("in_naruto")`

标签 **不在本 AS**（无字符串、无 `currentFrameLabel`）。引擎也不 `getItemClass("winmc_bleach_22")`。本类是 FFDec 给该元件的导出名（`_22` 时间轴 id），**很可能**就是 `w1`/`w2` 的运行时类型。?

和 [`hpbar_mc`](../hpbar_mc.md) 的 `fadin` 一样：标签在 SWF，脚本只在停帧 `stop()`。

## 帧脚本 ↔ WinUI 标签（推断，标 ?）

`addFrameScript(0, frame1, 19, frame20, 39, frame40)` → 时间轴 **F1 / F20 / F40**。

| 时间轴 | 脚本 | 可能含义 |
|---|---|---|
| **F1** | `stop` | 空闲。开场灯暗，等 `gotoAndPlay` |
| **F20** | `stop` | `in_bleach` 播完停点？约 20 帧 |
| **F40** | `stop` | `in_naruto` 播完停点？再 20 帧 |

无法从 AS 证明哪段对应哪标签：可能 F2–F20 死神、F21–F40 火影，也可能反过来，或两套标签都落在同一段。类名 `winmc_bleach` 只说明库元件叫这个，**不**排除内含 naruto 动画。`?`

不派 `Event.COMPLETE`。`WinUI` 也不听完播——`FightUI.renderEnd` 在 delay 归零时已经 `finishBack`，灯可能还在播。第一胜停在结束帧，第二胜播另一盏，旧灯不重置。

## 逐行说明

- **L1** `package fight_fla`。
- **L5** `symbol="symbol123"`（与 [`winmc`](../winmc.md) `symbol124` 相邻，像父子库元件）。
- **L6** `public dynamic class winmc_bleach_22 extends MovieClip`。无公开实例。
- **L9–13 构造**：`addFrameScript(0, frame1, 19, frame20, 39, frame40)`。
- **L15–18 `frame1`**：F1 `stop()`。默认停。
- **L20–23 `frame20`**：F20 `stop()`。无事件。
- **L25–28 `frame40`**：F40 `stop()`。无事件。
