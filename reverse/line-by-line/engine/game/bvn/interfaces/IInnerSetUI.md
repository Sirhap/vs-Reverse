# `interfaces.IInnerSetUI` — 设置页内层 UI（键位页）

一句话目的：从设置主列表推进去的子页。要能 fadIn/fadOut、交出 DisplayObject、destory，并作为 `IEventDispatcher` 发出 `APPLY_SET` / `CANCEL_SET`。本包只有 `SetCtrlBtnUI`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IInnerSetUI.as`（18 行）

## Callers / callees

- **Implementor**：`ui.SetCtrlBtnUI`（P1/P2 键位）。`SettingState.goKeyConfig` `new SetCtrlBtnUI()` → `goInnerSetPage`。
- **Host**：`SettingState._innerSetUI`。`goInnerSetPage` 听 `"APPLY_SET"` / `"CANCEL_SET"`（`SetBtnEvent`），主列表 `fadOut` 后 `innerUI.fadIn()`。回来时 `fadOut` + `destory`。
- **基接口**：`flash.events.IEventDispatcher`（add/removeEventListener）。不是 `Event` 子类，实现者自己 `extends EventDispatcher`。

## 命名备注

`fadIn` / `fadOut` 缺 e（fade）。`destory` 同全引擎。

## 逐行说明

### `fadIn` / `fadOut`（L9–11）

进/出动画。`SetCtrlBtnUI`：0.3s TweenLite 把 `keyset_mc` 从屏幕底滑到 y=0（或滑回），完成后再开/关 `_btnGroup.keyEnable`。`SettingState` 用它们衔接主列表显隐。

### `getUI`（L13）

要 addChild 的根显示对象。`SettingState` 加到设置页容器。与 `IEventDispatcher` 分离：事件在逻辑对象上，不一定等于 DisplayObject。

### `destory`（L15）

卸按钮组、监听。`SettingState.destoryInnerSetUI` / 切页前调用。APPLY 时 `SetCtrlBtnUI` 已把临时键位写回 `KeyConfigVO`；CANCEL 丢弃 `_tmpKeyConfig`。
