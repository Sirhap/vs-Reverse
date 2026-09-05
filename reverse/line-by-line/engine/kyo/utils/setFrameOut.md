# `setFrameOut` — 包级「N 帧后回调」

一句话目的：在某个 `DisplayObject` 上挂 `ENTER_FRAME`，计满 `frame` 次再调函数、卸监听。不是 `setTimeout`（与 FPS 绑定）。

源文件：`decompiled/main/scripts/net/play5d/kyo/utils/setFrameOut.as`（33 行）

包级函数（`public function`，无 class）。import 名就是 `setFrameOut`。

## Callers / callees

- **`GameOverState`**：
  - `setFrameOut(addChar, 2, _loc2_)`：角色槽还没出来，2 帧后再试。
  - `setFrameOut(addScore, 1, _loc2_)`：`ct_score` 找不到时 1 帧后再试。**此时 `_loc2_` 是 null**，见下。
- **`ZipAssetLoader.doNextFrame`**：`setFrameOut(fn, 1, bleachvsnaruto.STAGE)`，把回调推到下一帧，避免 ZIP 同步解析卡住当前栈。
- **Callees**：`Event.ENTER_FRAME`。`mc` 空则 `new Sprite()`（**不加到舞台**）。

## 逐行说明

### 签名（L7）

`(fun, frame, mc=null)`。`frame` 是「再等多少次 ENTER_FRAME」。闭包里 `++ii > mx`：`ii` 从 0 起，第一帧变成 1。`frame=1` 表示 **第 1 次 enterFrame 之后** 才触发（大约下一帧）。`frame=0`：第一帧 `1>0` 立刻触发。

### 监听目标（L25–29）

`_mc = mc || new Sprite()`。孤儿 Sprite **不在显示列表时，部分运行时不派 ENTER_FRAME**（官方 FP：不在 stage 上的 DO 仍可能收 ENTER_FRAME，Ruffle/AIR 行为有差）。?

`GameOverState.addScore` 的 else：`_loc2_ = getChildByName("ct_score")` 已是 null 才进 else，于是 `setFrameOut(..., null)` → 孤儿 Sprite。若 ENTER_FRAME 不来，分数永远不上。正路径是槽已存在，不走 else。?

`ZipAssetLoader` 传 `bleachvsnaruto.STAGE`，稳定。

### `onEnterframe`（L16–24）

`++ii > mx` 则 `fun()`、卸监听、`_mc=null`。无 try。`fun` 抛错则监听也卸不掉。无 `remove` API，不能取消。

同一 DO 上多次 `setFrameOut` 互不干扰（各自闭包）。
