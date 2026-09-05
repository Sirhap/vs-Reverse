# `select_item_mc` — P1/P2 选人光标皮肤

一句话目的：格子上的玩家光标 MC。子件 `mc` 用帧 1/2 区分左右颜色；根时间轴 F1 `stop()`，确认时引擎 `gotoAndPlay("select")` 播选中动画。

源文件：`decompiled/ui/select/scripts/select_item_mc.as`（22 行）

## 如何挂上引擎

[`SelecterItemUI`](../../../engine/game/bvn/ui/select/SelecterItemUI.md) 构造：`createDisplayObject(ResUtils.I.select, "select_item_mc")`。工厂 [`SelectUIFactory.createSelecter`](../../../engine/game/bvn/ui/select/SelectUIFactory.md) `new SelecterItemUI(1|2)` 后舞台 `addChild(slt.ui)`。

引擎对实例做的事：

| 调用 | 效果 |
|---|---|
| `ui.mouseChildren = ui.mouseEnabled = false` | 光标不挡格子点击 |
| `ui.mc.gotoAndStop(player==1 ? 1 : 2)` | 子件 `mc`：F1=P1，F2=P2 |
| `ui.gotoAndPlay("select")` | 确认写入 `SelectVO` 后播选中动画 |
| `KyoUtils.addFrameScript(ui, cb)` | 挂 **最后一帧**（`totalFrames-1`），播完：未满次数再 `enabled=true`，再调 `playerSeltBack` |

与格子 [`slt_item_mc`](slt_item_mc.md) 不是同一个。光标像素对齐格子 `item.ui.x/y`（`SelecterItemUI.moveTo`）。

SWF：`select`，链接名 `select_item_mc`，`symbol="symbol106"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class select_item_mc extends MovieClip`。[Embed] `symbol="symbol106"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `mc` | `MovieClip` | 颜色/箭头方向。至少两帧：P1 停 1、P2 停 2。引擎只 `gotoAndStop`，不听它的脚本 |

### 构造 `select_item_mc()`（L11–15）

- L13: `super();`
- L14: `addFrameScript(0, this.frame1);` — **N=0 → 时间轴 F1**。

### `frame1`（时间轴 F1，L17–20）

- L19: `stop();` — 出生停在空闲。没有这段会从 F1 一直播进 `"select"`。

时间轴另有帧标签 `"select"`（本 AS 不声明，引擎硬编码）。确认后从该标签播到末帧；末帧脚本被 `KyoUtils.addFrameScript` **替换**（多次 select 不叠）。
