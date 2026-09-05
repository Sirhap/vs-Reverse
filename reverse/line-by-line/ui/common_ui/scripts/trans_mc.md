# `trans_mc` — 场景切换遮罩（`fadin` / `fadout` / `stop`）

一句话目的：全屏转场 MC。宽条 JPEG 滑过盖住画面，再滑走揭开。F1 `stop`；F26 / F61 各 `stop` + `Event.COMPLETE`。[`TransUI`](../../../engine/game/bvn/ui/TransUI.md) **不听** COMPLETE，只 `gotoAndStop("fadin"|"fadout")` 再自己 `nextFrame`，直到 `currentFrameLabel == "stop"`。

源文件：`decompiled/ui/common_ui/scripts/trans_mc.as`（32 行）

## 如何挂上引擎

无名包导出。SWF char 5，`[Embed(symbol="symbol5")]`。链接名 `"trans_mc"`。

[`TransUI`](../../../engine/game/bvn/ui/TransUI.md) 构造：`ResUtils.I.createDisplayObject(ResUtils.I.common_ui, "trans_mc")` → 公开字段 `ui`。只 [`StateCtrl`](../../../engine/game/bvn/ctrl/StateCtrl.md) 用：

- `transIn` → `TransUI.fadIn` → `ui.gotoAndStop("fadin")` 再 `GameRender` 对齐 30fps `nextFrame`，撞到标签 `"stop"` 回调（默认 **不**卸 MC，停在满屏遮罩上切状态）。
- `transOut` → `fadOut` → `"fadout"`，播完默认 `removeTrainsUI`（拼写保留；实例复用，不 `destory`）。

方法名 `fadIn` / `fadOut` / `destory` 保留。SWF 标签是 `fadin` / `fadout`（没 e）。本类派的 `Event.COMPLETE` 本包无人监听。

## 时间轴（SWF，70 帧 / 标签）

舞台 800×600。遮罩条是 JPEG3 3474×600（char 1 → shape 2）；满屏盖是另一张 800×600 JPEG（char 3 → shape 4）。

| 帧 | 标签 | 帧脚本 | 画面 |
|----|------|--------|------|
| F1 | （无） | `stop` | 空。`new` 后停在这 |
| F2–F9 | | | 空 |
| F10 | **`fadin`** | | 宽条放在 x=-3380 |
| F11–F25 | | | 条每帧 +≈130.7px，扫向舞台 |
| F26 | **`stop`** | `stop` + COMPLETE | 换成 800×600 满屏图于 (0,0)。**transIn 停点** |
| F27–F44 | | | 满屏盖住（无新 Place） |
| F45 | **`fadout`** | | 宽条从 x=-1260 再滑 |
| F46–F60 | | | 继续往右滑到 x≈580 |
| F61 | **`stop`** | `stop` + COMPLETE | `RemoveObject` depth1，画面空。**transOut 停点** |
| F62–F70 | | | 空（多出来的尾帧，F61 已 stop 走不到） |

`TransUI.fadIn`：`gotoAndStop("fadin")` 停在 F10，标签不是 `"stop"`，于是下一动画帧 `nextFrame` → … → F26 标签 `"stop"` 调 `_fadInBack`。`fadOut` 从 F45 走到 F61。时间轴上的 `stop()` 挡不住 `nextFrame`。

## 逐行说明

无名包。`public dynamic class trans_mc extends MovieClip`。无公开字段。

### `trans_mc()`（L10–14）

- L12: `super();`
- L13: `addFrameScript(0, this.frame1, 25, this.frame26, 60, this.frame61);` — 下标 0/25/60 = 时间轴 **F1 / F26 / F61**。标签在 SWF 里，不在本脚本。

### `frame1`（时间轴 F1，L16–19）

- L18: `stop();` — 实例化后空屏静止，等 `TransUI` `gotoAndStop("fadin"|"fadout")`。

### `frame26`（时间轴 F26，L21–26）

- L23: `stop();`
- L24: `dispatchEvent(new Event(Event.COMPLETE));` — 满屏盖住。`TransUI` 不听这个事件，靠标签 `"stop"` 认终点。若误 `play()` 而不是 `nextFrame`，也会停在这。

### `frame61`（时间轴 F61，L28–31）

- L29: `stop();`
- L30: `dispatchEvent(new Event(Event.COMPLETE));` — 遮罩已卸。同样只给「有人听 COMPLETE」的路径用；引擎走标签。之后 F62–F70 不会被本类脚本碰到。
