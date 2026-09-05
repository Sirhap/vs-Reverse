# `SelectStageConfigVO` — 选人界面网格：边距、角色表、辅助表

一句话目的：`select.xml`（或 `salect.xml`）解析出来的选人布局。格子坐标 + 内边距给 `SelectFighterStage.buildList` 算每个头像位置；`charList`/`assistList` 是两张 `SelectCharListConfigVO`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectStageConfigVO.as`（114 行）

## Callers / callees

- **Callers**：
  - `ConfigVO.select_config` 默认 `new`。
  - `GameData.loadConfig` / `setSelectData` / `loadSelect`：`setByXML`。
  - `SelectFighterStage.build`：`_config = GameData.I.config.select_config`；`initFighter`/`initAssist` 分别 `buildList(charList)` / `buildList(assistList)`。`buildList` 用 `x+left`、`y+top`、`width/height`、`unitSize`、四边距算步长。
  - `GameLogic.canSelectFighter` / `canSelectAssist`：扫对应 list 的 `fighterID`。
- **Callees**：`SelectCharListConfigVO`、`SelectCharListItemVO`、`flash.geom.Point`。

## 命名备注

- XML 根下 `stage_setting.layout`、`char_list`、`assist_list`。
- `unitSize` 写死 `(50,50)`，**XML 不覆盖**。步长公式里当格子尺寸。
- `SelectCharListItemVO` 的 `x` = 列，`y` = 行。空格子 `fighterID` 原意该是 null，见 `newListByXML` 的判断漏洞。

## 逐行说明

### 字段（L8–28）

- `x/y`：网格原点。`buildList` 起点 = `x+left`、`y+top`。
- `width/height`：网格外框，默认 800×600。
- `top/bottom/left/right`：内边距。水平步长 `(width - unitSize.x - left - right) / (HCount-1)`，竖直同理。
- `charList` / `assistList`：选人 / 选辅助。结构相同，都是 `SelectCharListConfigVO`（`list` + `HCount` + `VCount`）。
- `unitSize`：格子大小 Point(50,50)。

### 构造（L30–33）

空。

### `setByXML`（L35–48）

`param1` = 整份 select XML。

1. `layout = param1.stage_setting.layout`（类型写成 Object，实际是 XML）。`Number(@x/@y/@width/@height/@top/@bottom/@left/@right)` 写入对应字段。缺属性 → `Number(undefined)` = `NaN`，布局会坏（?）。
2. `charList = newListByXML(param1.char_list)`。
3. `assistList = newListByXML(param1.assist_list)`。

不改 `unitSize`。可重复调用（`GameLogic.setGameMode` 换表）。

### `newListByXML`（L50–111）私有

`param1` = `char_list` 或 `assist_list` 的 `XMLList`。约定：直接子节点是**行**，行的子节点是**格**。

1. `new SelectCharListConfigVO()`。
2. `VCount = children().length()`：行数。
3. 对每一行 `_loc13_`：
   - 行 `@offset` 非空：`"x,y".split(",")` → 该行默认 `Point`。不 `Number()` 就塞进 Point，AS3 会 ToNumber。
   - 若本行列数 `> HCount`，更新 `HCount`（最终是最宽那一行的列数）。
   - 对每一格 `_loc14_`（列）：
     - `fighterID = child.toString()`。
     - `if (id && id.length < 1) id = null`：空字符串在 AS3 布尔为 false，**进不去**。空白格会留下 `""` 而不是 `null`。`addFighterItem` 对空 id 的处理见选人 UI（?）。
     - 格 `@offset`：有行 offset 则累加，否则 new Point。列 offset 同样 `"x,y"`。
     - `new SelectCharListItemVO(列, 行, fighterID, offset)` push 进 `list`。
4. 返回该 VO。

行/格都可以没有 offset（null）。`SelectFighterStage` 有 offset 才往像素坐标上加。
