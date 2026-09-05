# `SelectCharListConfigVO` — 选人格子表（行列 + 格子数组）

一句话目的：一份选人/辅助网格：`HCount`×`VCount` 和 `list`（`SelectCharListItemVO`）。`SelectStageConfigVO` 各持角色表、辅助表各一份。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectCharListConfigVO.as`（18 行）

## Callers / callees

- **Callers**：
  - `SelectStageConfigVO`：`charList` / `assistList`；`newListByXML` 填充。
  - `GameLogic.canSelectFighter` / `canSelectAssist`：读 `GameData.I.config.select_config.charList` / `assistList`，扫 `list` 的 `fighterID`。
  - `SelectFighterStage.buildList`：按本 VO 摆格子。
- **Callees**：无。`list` 元素类型是约定，不是字段类型（`Array`）。

## 逐行说明

### 字段（L6–10）

- `list:Array = []`：`SelectCharListItemVO`。XML 里每个有 id 的格一条；空格不进数组。
- `HCount` / `VCount`：列数 / 行数。`SelectStageConfigVO.newListByXML` 从 XML 属性写入。未赋时 AS3 int=0。

### 构造（L12–15）

空。真正填充在 `SelectStageConfigVO.newListByXML`。
