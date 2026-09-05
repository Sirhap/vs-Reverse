# `MessionStageVO` — 街机一关：敌方名单 / 辅助 / 地图 / 倍率

一句话目的：关卡线上的一关。组队模式吐最多 3 个敌方 id（不足补 null）；单人模式从名单里随机 1 个。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionStageVO.as`（49 行）

## Callers / callees

- **Callers**：
  - `MessionVO.initByXML` 填充。
  - `MessionModel.getCurrentMessionStage`；`initMession` 里 `getFighters()` 写入 `p2Select`。
  - `GameLogic.resetFighterHP` / `setMessionEnemyAttack`：读 `hpRate` / `attackRate`。
- **Callees**：`KyoRandom.getRandomInArray`（单人抽敌）；`MessionVO`（回指，读 `gameMode`）。

## 命名备注

`mession` 字段是父 `MessionVO`。`fighters` 是 **id 字符串数组**，不是 `FighterVO`。

## 逐行说明

### 字段（L8–18）

- `fighters:Array`：XML `@fighter` 逗号拆开。
- `assister` / `map`：敌方辅助 id、地图 id。
- `mession`：父线，`getFighters` 用它的 `gameMode`。
- `attackRate` / `hpRate` 默认 1。

### 构造（L20–23）

空。

### `getFighters`（L25–46）

- **`mession.gameMode == 0`（组队表）**：拷贝 `fighters`，若长度 `< 3` 用 `null` 补到 3。已 ≥3 不裁切。`LoadingState` 遇到 null 会跳过该槽。?
- **否则（单人表）**：`[KyoRandom.getRandomInArray(fighters)]` 只出一个。空数组时 `getRandomInArray` 行为见 kyo 包（? 可能 null）。

本方法不读 `GameMode.currentMode`，只读 XML 表类型。生存模式走哪张表由 `MessionModel` 决定。
