# `events.SetBtnEvent` — 设置/菜单按钮事件

一句话目的：`SetBtn` / `SetBtnGroup` / 内层键位页用的 UI 事件。带选中文案和 option 键值，`newEvent()` 克隆后向上 redispatch。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/events/SetBtnEvent.as`（37 行）

## Callers / callees

- **派发**：`SetBtn.select` → `SELECT`（`selectedLabel`）。`SetBtn.changeOption` → `OPTION_CHANGE`（`optionKey` / `optionValue`）。`SetCtrlBtnUI.onBtnSelect` → `APPLY_SET` / `CANCEL_SET`（无字段）。
- **监听**：`SetBtnGroup` 听子 `SetBtn` 的 `SELECT` / `OPTION_CHANGE`，`newEvent()` 后再 `dispatchEvent` 给外层。`SettingState` 听 `OPTION_CHANGE` 写 `ConfigVO.setValueByKey`，听 `SELECT` 进键位页或 APPLY 存档。`SetCtrlBtnUI` 听内部 `SELECT`。`PauseDialog` / `AlertUI` / `ConfrimUI` / `CreditsState` / `CongratulateState` 听 `SELECT`。
- **Callees**：仅 `flash.events.Event`。走显示列表冒泡链路（与 `GameEvent` 静态总线不同）。

## 逐行说明

### 常量（L8–14）

- `SELECT`：确认当前项。`selectedLabel` 是英文 `label`（如 `"APPLY"` / `"P1 KEY SET"` / `"BACK"`），不是 `cn`。
- `OPTION_CHANGE`：左右切选项。`optionKey` 对应 `ConfigVO` 字段名（`quality` / `soundVolume` 等），`optionValue` 为选项 `.value`。
- `APPLY_SET` / `CANCEL_SET`：内层键位页确定/取消。`SettingState.innerSetHandler` 据此 `fadOut` 并决定是否把临时键位写回。

调用方同样多用字面量 `"SELECT"`，不用 `SetBtnEvent.SELECT`。

### 实例字段（L16–20）

- `selectedLabel:String`：`SELECT` 用。
- `optionKey:String` / `optionValue:*`：`OPTION_CHANGE` 用。`APPLY_SET` / `CANCEL_SET` 保持默认 `null`。

### 构造（L22–25）

`param1` type，`param2` bubbles，`param3` cancelable。默认都不冒泡。`SetBtnGroup.newEvent()` 再向上派发时仍用原 `bubbles/cancelable`（同为 false），等于换 target 的拷贝，避免 `currentTarget` 仍是子 `SetBtn`。

### `newEvent`（L27–34）

浅拷贝：新实例 + 三个字段。`SetBtnGroup.onChangeOption` / `onSelect` 用它 redispatch，让 `SettingState` 收到的 `currentTarget` 是 Group 而不是单个 `SetBtn`。
