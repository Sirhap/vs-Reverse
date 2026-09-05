# `AssisterModel` — 辅助角色 XML 表（单例）

一句话目的：`assist.xml` 解析成 `id → FighterVO`。选人、加载、预加载头像都从这里取辅助，结构与 `FighterModel` 几乎同文。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/AssisterModel.as`（63 行）

## Callers / callees

- **init**：`GameData.loadConfig` 链：`fighter.xml` 之后 `assets/config/assist.xml` → `initByXML`。
- **读**：
  - `SelectFighterStage`：格子是辅助态时 `getAssister(id)`；随机池 `getAssisters(comicType, filter)`。
  - `SelecterItemUI` / `SelectIndexUIGroup`：已选 `fuzhu`。
  - `GameLoader`：`getAssister(id, true)` 拉辅助 SWF。
  - `AssetManager`：`getAllAssisters()` 收集头像 URL。
- **Callees**：`FighterVO.initByXML`（辅助和主角共用 VO）。

## 命名备注

辅助数据复用 `FighterVO`，没有独立 AssisterVO。`fuzhu` 是选人/对局侧字段名，本表 key 仍是 `id`。

`getAssister` 第二参数 `param2:Boolean=false` **未使用**（`FighterModel.getFighter` 同样）。`GameLoader` 传 `true`，疑似历史 clone 开关。

## 逐行说明

### 单例（L6、L15–22）

懒创建 `_i`。无 `destory`，进程级。

### `_assisterObj`（L8）

`id → FighterVO`。`initByXML` 前为 null，提前 `getAssister` 会 NPE。

### 空构造（L10–13）

外部应走 `I`。

### `getAllAssisters`（L24–27）

返回内部 Object（不是拷贝）。`AssetManager` 遍历值。

### `getAssisters`（L29–43）

`(comicType=-1, filter:Function=null)`：

1. 新 Vector。
2. `for each` 值：若 `filter` 非空且 `!filter(vo)` 则 skip。
3. `comicType==-1` 或 `vo.comicType==comicType` 才 push。

`SelectFighterStage` 随机辅助时按当前角色 comicType 过滤，并再滤已选。

### `getAssister`（L45–48）

`_assisterObj[id]`。缺 id 得 `undefined`（AS3 字典），调用方当 `FighterVO` 用可能 NPE。`param2` 忽略。

### `initByXML`（L50–60）

`_assisterObj = {}`。对 `param1.fighter` 每个节点 `new FighterVO().initByXML`，按 `id` 入库。根节点标签与主角 XML 一样叫 `fighter`。
