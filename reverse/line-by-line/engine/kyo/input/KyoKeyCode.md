# `KyoKeyCode` — keyCode ↔ 显示名

一句话目的：静态键表。`code2name` 给设置页 / 操作说明把数字码画成字。字母、数字、方向、六颗编辑键；**空格不在查找表里**。

源文件：`decompiled/main/scripts/net/play5d/kyo/input/KyoKeyCode.as`（142 行）

## Callers / callees

- **Callers（`code2name`）**：
  - `KeyMapping.setKey`：无 `displayName` 时把 keyCode 变成字（随后 `toUpperCase`）。表外码返回 `null` → NPE。
  - `SetCtrlBtnUI.onKeyDown`：先查表，`null` 则忽略该键（避开上面的 NPE）。
  - `HowToPlayState`：把当前键配置画进说明。
- **Callers（常量）**：`Debugger.runScriect` 要连按 `P L A Y`（`KyoKeyCode.P/L/A/Y`）。本包 `Debugger.initDebug` 无调用方。
- **Callees**：`KyoKeyVO`。

## 命名备注

- `N0` 的 **name 是 `"O"` 不是 `"0"`**（L6）。主键盘 0 在设置页会显示成字母 O。Num0 才是 `"Num0"`。
- `SPACE` 常量存在（L118，code 32），但 **不在 `_keyArray`**（L120）。`code2name(32)` 返回 `null`。把空格绑成攻击键时，设置页 `KeyMapping` 会 NPE；SET ALL 路径因 `SetCtrlBtnUI` 先查表而直接忽略空格。
- 无 Shift / Ctrl / Alt / Enter / Esc / F1–F12。Esc=27 不在表里，SET ALL 忽略它。
- `Delete`/`End`/`PageDown`/`PageUp`/`Insert`/`Home` 的 name 是全大写英文。

## 表（code → name）

| 组 | codes | name |
|----|-------|------|
| 主键盘数字 | 48–57 | `N0`=`"O"`（应为 `"0"`），`N1`–`N9` = `"1"`–`"9"` |
| 小键盘 | 96–105 | `"Num0"`–`"Num9"` |
| 字母 | 65–90 | `"A"`–`"Z"` |
| 方向 | 38/40/37/39 | `"UP"` `"DOWN"` `"LEFT"` `"RIGHT"` |
| 编辑 | 46/35/34/33/45/36 | `"DELETE"` `"END"` `"PAGEDOWN"` `"PAGEUP"` `"INSERT"` `"HOME"` |
| 空格 | 32 | `"SPACE"`（常量在，查找表无） |

## 逐行说明

### 常量（L6–118）

每个 `public static const` 在类初始化时 `new KyoKeyVO`。这些实例进程内唯一，被 `_keyArray` 引用。

### `_keyArray`（L120）

`code2name` 的扫描源。顺序：主数字 → 小键盘 → A–Z → 方向 → 六颗编辑键。**无 SPACE**。

### 空构造（L122–125）

全静态。

### `code2name`（L127–138）

线性扫 `_keyArray`，`.code == param1` 则返回 `.name`，否则 `null`。不缓存。第一次未命中就整表走完。

返回值大小写与表一致（字母已大写）。`KeyMapping` 仍 `.toUpperCase()`。
