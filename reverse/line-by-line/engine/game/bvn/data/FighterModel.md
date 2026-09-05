# `FighterModel` — 可玩角色 XML 表（单例）

一句话目的：`fighter.xml` → `id → FighterVO`。选人、加载 SWF、胜利台词、闯关按 P1 阵营选关卡线，都查这张表。与 `AssisterModel` 同构。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/FighterModel.as`（63 行）

## Callers / callees

- **init**：`GameData.loadConfig` 第一环 `assets/config/fighter.xml` → `initByXML`。
- **读**：
  - `SelectFighterStage` / `SelecterItemUI` / `SelectIndexUIGroup`：格子与已选。
  - `GameLoader.getFighter(id, true)`：角色 SWF。
  - `LoadingState`：把 SelectVO 的 id 换成 VO。
  - `WinnerState`：`winnerId` + 全员遍历 `getAllFighters`。
  - `AssetManager`：头像 URL。
  - `MessionModel.initMession`：`getFighter(p1Select.fighter1)` 取 `comicType`。
- **Callees**：`FighterVO`。

## 命名备注

`getFighter` 第二参 `param2:Boolean=false` **未读**。`GameLoader` 传 `true`。

不含辅助；辅助走 `AssisterModel`。同一 `id` 若两张表都有是两份 VO。

## 逐行说明

### 单例 / `_fighterObj`（L6–22）

与 `AssisterModel` 相同的懒单例 + Object 字典。

### `getAllFighters`（L24–27）

返回内部 Object。`WinnerState` `for each`、`AssetManager` 收 URL。

### `getFighters`（L29–43）

`(comicType=-1, filter=null)`：可选按阵营 + 谓词过滤，返回新 Vector。选人随机池用。

### `getFighter`（L45–48）

`_fighterObj[id]`。未知 id → undefined。`param2` 忽略。

### `initByXML`（L50–60）

清空重建。`param1.fighter` 节点各 `new FighterVO().initByXML`，按 id 入库。重复 id 后者覆盖。
