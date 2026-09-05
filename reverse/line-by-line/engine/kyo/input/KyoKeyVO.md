# `KyoKeyVO` — 键名 + keyCode

一句话目的：一对 `name`/`code`。`KyoKeyCode` 每个常量都是本类实例。`isDown` 字段编译进来但从没人写。

源文件：`decompiled/main/scripts/net/play5d/kyo/input/KyoKeyVO.as`（31 行）

## Callers / callees

- **Callers**：`KyoKeyCode` 静态常量全部 `new KyoKeyVO(...)`。`Debugger.runScriect` 拿 `KyoKeyCode.P/L/A/Y` 比 `.code`。`code2name` 扫 `.code` 返回 `.name`。
- **Callees**：无。
- **本包无调用**：`isDown`、`clone()`。游戏真正的按键状态在 `GameKeyInput` 自己的表里，不经过本 VO。

## 逐行说明

### 字段（L5–10）

- `name`：给人看的键名。`KyoKeyCode.N0` 写成 `"O"` 不是 `"0"`（见 `KyoKeyCode.md`）。
- `code`：`Keyboard` 数字。
- `isDown`：从未赋值，恒 false。?

### 构造（L12–17）

`(name, code)`。不设 `isDown`。

### `toString`（L19–22）

返回 `name`。`trace` / 字符串拼接会打出名。

### `clone`（L24–27）

`new KyoKeyVO(name, code)`。**不**拷 `isDown`。本包零调用。
