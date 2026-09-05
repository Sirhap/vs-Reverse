# `interfaces.ILoger` — 可替换日志后端

一句话目的：单方法 `log(String)`。`GameLoger` 有 hook 则转发，否则 `trace`。本包没有实现类，也没有人调 `GameLoger.setLoger`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/ILoger.as`（9 行）

## Callers / callees

- **Holder**：`utils.GameLoger._loger`。`setLoger(ILoger)` 写入；`GameLoger.log` 若 `_loger` 非空则 `_loger.log`，否则 `trace`。
- **Implementors**：本 `decompiled/main/scripts` grep 无。`setLoger` 亦无调用点。留给调试包 / 远程 overlay 接 HTML 或 4399 日志。
- **实际输出**：`MainGame.initlize` 一串 `GameLoger.log("res init ok")` 等，本包全部落到 `trace`。

## 命名备注

类名 `ILoger` / 方法 `setLoger` 缺 g（Logger）。与 `destory` 同类笔误，保留。

## 逐行说明

### `log`（L6）

`(msg:String):void`。无级别、无 fmt、无 rest。实现方自己加时间戳或外抛。接口刻意极窄，核心不依赖 flash 的 `trace` 以外的任何通道。
