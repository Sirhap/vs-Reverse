# `KyoStageEvent` — 切屏事件

一句话目的：`KyoStageCtrl.goStage` 成功换屏时派发。type 只有 `"CHANGE_STATE"`，附带新 `Istage`。本 SWF **无 listener**。

源文件：`decompiled/main/scripts/net/play5d/kyo/stage/events/KyoStageEvent.as`（21 行）

## Callers / callees

- **Dispatch**：`KyoStageCtrl.goStage` L93，`new KyoStageEvent(CHANGE_STATE, stg)`。同类名被拒时不派。
- **Listen**：`decompiled/main` 内 `addEventListener` 搜不到 `CHANGE_STATE` / `KyoStageEvent`。可能留给未接入的平台 overlay。
- **Callees**：`flash.events.Event`、`Istage`。

## 逐行说明

### 常量（L9）

`CHANGE_STATE = "CHANGE_STATE"`。与 type 字面量同文。

### 字段（L11）

`stage`：新的 `Istage`，不是旧的。`goStage` 在 `buildAfterDestory` 路径下会在新屏 `build` **之前**派出。本游戏不走那条。

### 构造（L13–18）

`(type, stage, bubbles=false, cancelable=false)`。`super(type, bubbles, cancelable)`，再赋 `this.stage`。`KyoStageCtrl` 只传前两个。不覆盖 `clone` / `toString`。
