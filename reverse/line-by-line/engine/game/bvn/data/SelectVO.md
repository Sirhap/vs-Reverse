# `SelectVO` — 一玩家本局已选：最多 3 人 + 1 辅助

一句话目的：选人过程往 `fighter1/2/3` 和 `fuzhu` 填 id 字符串。`GameData.p1Select` / `p2Select` 各一份；闯关敌方由 `MessionModel` 写 P2。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectVO.as`（53 行）

## Callers / callees

- **持有**：`GameData.p1Select` / `p2Select`。
- **new**：`SelectFighterStage` 进选人时 new P1，VS 人/CPU 再 new P2。`MessionModel.initMession`：`p2Select ||= new SelectVO()` 后写入敌方。
- **读**：
  - `SelecterItemUI` / `SelectIndexUIGroup`：头像条。
  - `LoadingState`：按 id 调 `GameLoader`。
  - `isSelected`：选人避免重复（同玩家）。
- **Callees**：`JSON.stringify`（`toString`）。

## 命名备注

`fuzhu` = 辅助。组队 3 人；单挑只填 `fighter1`。空槽保持 `null`/未赋值。

## 逐行说明

### 字段（L6–12）

四个 String，默认 undefined。`LoadingState` 只加载非空 id。

### 构造（L14–17）

空。

### `getSelectFighters`（L19–35）

按 1→2→3 把非空 id push 进新 Array。**不含** `fuzhu`。`LoadingState` / 出战顺序用这个长度当人数。

### `isSelected`（L37–40）

id 是否已是 fighter1/2/3。不含辅助。随机选人 `GameLogic`/`SelectFighterStage` 用来跳过已选。

### `toString`（L42–50）

`JSON.stringify({select:{fighter1,fighter2,fighter3,fuzhu}})`。调试；运行路径未见调用。
