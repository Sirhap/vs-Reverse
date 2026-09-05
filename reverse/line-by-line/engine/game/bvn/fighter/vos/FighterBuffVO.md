# `FighterBuffVO` — 一条限时属性 buff

一句话目的：记住改过哪个字段（`speed` / `attackRate` / `defenseRate`）、改之前的值、还剩多少逻辑帧。`FighterBuffCtrler.render` 每帧 `render()`，到期还原。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/vos/FighterBuffVO.as`（45 行）

## Callers / callees

- **Callers**：
  - `FighterBuffCtrler.addBuff` `new FighterBuffVO(paramName, seconds)`；同名已存在则 `setHold` 刷新。
  - `FighterBuffCtrler.render`：`render()` 为 true 则还原 `resumeValue`。
  - `EffectCtrl.doBuffEffect(name, fighter, this)`：给 `BuffEffectView.setBuff`。
- **Callees**：`GameConfig.FPS_GAME`（秒 → 帧）。

## 命名备注

`param` 是 **角色字段名字符串**，不是数值参数。数值在 Ctrler 里直接写 `_fighter[param] = value`。

`_holdFrame` 按 **战斗 FPS** 计（默认 60），与动画 30fps 抽帧无关。

## 逐行说明

### 字段（L8–14）

- `param:String`：如 `"speed"`。
- `resumeValue`：Ctrler 在首次 add 时写成当前字段值，到期写回。
- `finished`：到期或未开始。
- `_holdFrame`：剩余逻辑帧，默认 1。

### 构造（L16–22）

`(paramName, seconds=1)`：`_holdFrame = seconds * FPS_GAME`。`finished=false`。不写 `resumeValue`（Ctrler 后填）。

### `setHold`（L24–28）

刷新剩余时间为 `seconds * FPS_GAME`，清 `finished`。同名 buff 刷新不重建对象，保留原来的 `resumeValue`。

### `render`（L30–42）

已 finished → true。否则 `--_holdFrame <= 0` 则 finished=true 并返回 true（本帧到期，Ctrler 还原）。否则 false。

构造默认 1 秒 → 60 帧；`seconds=0` 则第一帧立刻到期。
