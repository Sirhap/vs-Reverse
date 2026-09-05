# `GameLoger` — 启动日志门面（类名少一个 g）

一句话目的：给 `MainGame.initlize` 打阶段 trace。可注入 `ILoger`，本包从未注入，永远走 `trace`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/GameLoger.as`（34 行）

## Callers / callees

- **Callers**：仅 `MainGame.initlize` 的 `resInitBack`（L72–89）：`"res init ok"` / `"init game render"` / `"init game inputer"` / `"init game data"` / `"init config"` / `"init inputer config"` / `"init scroll"` / `"init stagectrl"` / `"init loading"`。
- **Callees**：`_loger.log`（`ILoger`）或 `trace`。
- **`setLoger`**：本包 **零调用**。`grep` 只有定义。

## 命名备注

保留 **`GameLoger` / `setLoger` / `_loger` / `ILoger`**，全部少 g（Logger）。不是笔误要修，是源码标识符。

与 `Debugger` 分工：

| | `GameLoger` | `Debugger` |
|--|-------------|------------|
| 用途 | 启动阶段一句 | 运行时开关 / FPS / 错误回调 |
| 实现 | 可插 `ILoger`，默认 `trace` | 自己 `trace` / `onErrorMsgCall` |
| 谁用 | `MainGame.initlize` | `GameLoadingState` 失败、`GameData` 读 XML 失败等 |

`ILoger`（`interfaces/ILoger.as`）只有 `log(String)`。本包没有任何 class `implements ILoger`。

## 逐行说明

### 静态字段（L8）

`_loger:ILoger` 默认 `null`。

### 空构造（L10–13）

全静态，构造无意义。

### `setLoger`（L15–18）

`param1` 赋给 `_loger`。渠道包若要接到网页 console / 4399 日志，应在 `bleachvsnaruto.initlize` 之前调用。本网页包没做。

### `log`（L20–30）

有 `_loger` 则转发；否则 `trace(param1)`。无格式、无时间戳、不 `try`。`MainGame` 九条都是 ASCII 短句，方便看 init 卡在哪一步。
