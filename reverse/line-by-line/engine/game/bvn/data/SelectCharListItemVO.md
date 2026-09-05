# `SelectCharListItemVO` — 选人网格上的一格

一句话目的：格子坐标 `(x,y)`、角色/辅助 id、可选头像偏移。选人 UI 一项对应一条。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectCharListItemVO.as`（26 行）

## Callers / callees

- **Callers**：
  - `SelectStageConfigVO.newListByXML`：`new SelectCharListItemVO(col, row, id, offset?)`。
  - `SelectFighterStage.addFighterItem`：用本 VO 建 `SelectFighterItem`。
  - `SelectFighterItem.selectData`：点选时取 `fighterID`。
  - `GameLogic.canSelectFighter/Assist`：只读 `fighterID` 是否在允许列表。
- **Callees**：`flash.geom.Point`（`offset` 类型）。

## 逐行说明

### 字段（L8–14）

- `x` / `y`：网格列/行，不是像素。`SelectFighterStage` 乘格宽格高再加 `offset`。
- `fighterID`：`FighterVO.id` / 辅助 id。空格不会被 new。
- `offset:Point`：可 null。XML 带 offset 时 clone 一份，避免共享。

### 构造（L16–23）

`(col, row, fighterID, offset=null)` 原样写入。无校验。
