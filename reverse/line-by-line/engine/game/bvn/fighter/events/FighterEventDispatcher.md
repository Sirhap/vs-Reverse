# `FighterEventDispatcher` — 招式事件静态总线

一句话目的：进程级 `EventDispatcher` + 「type → 唯一 listener」表。角色/子弹/攻击体/辅助不自己冒泡，统一 `dispatchEvent(sprite, type, params)` 给 `FighterEventCtrl`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/events/FighterEventDispatcher.as`（53 行）

## Callers / callees

- **listen / 清空**：`FighterEventCtrl.initlize` 先 `removeAllListeners` 再绑 7 个；`destory` 再 `removeAllListeners`。
- **dispatch**：`FighterMcCtrler`（子弹/攻击体/辅助/死/受击结束）、`FighterMC`（倒地）、`AssisiterCtrler` / `FighterAttackerCtrler`（子弹/攻击体）、`GameLogic.hitTarget`。
- **Callees**：`FighterEvent`、`EventDispatcher`、`BaseGameSprite`。

## 命名备注

`_addedEvents[type] = listener` **每个 type 只留一个函数**。再 `addEventListener` 同 type 会覆盖表项，但底层 Dispatcher 仍可能堆多个 listener（本包每场只 add 一次，init 前 removeAll，实际不堆）。

`hasEventListener` 本包无调用。

`DO_ACTION` 不走本总线（见 `FighterEvent.md`）。

## 逐行说明

### 静态字段（L8–10）

- `_dispatcher`：真正的 Flash 总线，不挂显示列表。
- `_addedEvents`：type → Function，供 removeAll 时反查。

### 空构造（L13–16）

全静态。

### `hasEventListener`（L18–21）

表里该 type 非 null。**不是** `EventDispatcher.hasEventListener`（remove 后表项 delete 才空）。

### `addEventListener`（L23–27）

签名与原生相同（type, listener, useCapture=false, priority=0, useWeakReference=false）。先写入 `_addedEvents` 再转发。`FighterEventCtrl` 只用前两参。

### `removeEventListener`（L29–33）

`delete` 表项 + 原生 remove。capture 标志必须与 add 时一致（本包都 false）。

### `removeAllListeners`（L35–42）

遍历表 `removeEventListener(type, fn)`（默认 capture=false），再 `_addedEvents = {}`。每场 init/destory 都调，避免跨局串听。

### `dispatchEvent`（L44–50）

`(fighter, type, params=null)`：`new FighterEvent(type,false,false)`，写 `fighter`/`params`，丢给 `_dispatcher`。无 listener 则静默。
