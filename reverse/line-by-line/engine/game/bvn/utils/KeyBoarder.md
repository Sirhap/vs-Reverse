# `KeyBoarder` — 舞台键盘总线（不是 `GameKeyInput`）

一句话目的：Stage 上挂一份 `keyDown`/`keyUp`，转发给所有 `listen` 的函数。游戏键位映射在 `GameKeyInput`，本类只做扇出和焦点。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/KeyBoarder.as`（82 行）

## Callers / callees

- **Callers**：
  - `GameKeyInput.initlize`：`KeyBoarder.initlize(stage)` + `listen(keyBoardHandler)`（L24–25）。
  - `GameKeyInput.focus` → `KeyBoarder.focus()`（L45）。
  - `GameCtrl.initlize` / `pause` 恢复（L114、L467）`focus()`。
  - `SelectFighterStage.build`（L96）`focus()`。
- **Callees**：`Stage.addEventListener("keyDown"|"keyUp")`。不读 `KeyConfigVO`。
- **`unListen`**：本包 **零调用**。

## 命名备注

保留 `initlize`（少 z）。和输入栈分层：

```
Stage keyDown/keyUp
  → KeyBoarder.keyBoardHandler     原始 KeyboardEvent 广播
      → GameKeyInput.keyBoardHandler   记 _downKeys[keyCode]=1/0
          → GameInputer                 MENU / P1 / P2 多路
```

`GameInterfaceManager.getGameInput` 对 MENU/P1/P2 **各 new 一个** `GameKeyInput`，三者都 `listen` 到同一条总线，各自一份 `_downKeys`。这不是三套硬件键盘。

`GameInterfaceManager.keyHandler`（Ctrl+F8/F9）走的是 **STAGE 上另一条 `keyUp`**，不经过本类。

## 逐行说明

### 静态字段（L9–13）

- `_inited`：只初始化一次。
- `_stage`：`focus()` 用。
- `_keyHandlers: Vector.<Function>`：去重列表。

### 空构造（L15–18）

全静态。

### `initlize`（L20–30）

已 init 则 return。否则记 stage，听 `"keyDown"` / `"keyUp"`（字符串，即 `KeyboardEvent.KEY_DOWN/UP`）。`GameInputer.initInput` 会对三个 `GameKeyInput` 各调一次 `initlize`，后两次被挡掉，监听不会重复挂。

### `focus`（L32–39）

未 init 则 return。`_stage.focus = _stage`：把焦点从 TextField / 网页抢回来，否则按键进不了 SWF。选人、开战、从暂停恢复都会再 focus。

### `listen`（L41–51）

未 init 则 **静默 return**（先 listen 再 initlize 会丢）。`indexOf == -1` 才 push，同一函数不重复。

### `unListen`（L53–63）

`indexOf` 两次（一次判断一次 splice）。本包没有人退订；`GameKeyInput` 也没有 destory。

### `keyBoardHandler`（L65–78）

未 init return。按下标顺序同步调用每个 handler，传入原始 `KeyboardEvent`。handler 里再 `switch(type)`。没有 `stopImmediatePropagation`，三路 `GameKeyInput` 都会看到同一事件。
