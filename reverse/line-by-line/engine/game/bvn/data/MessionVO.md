# `MessionVO` — 一条街机关卡线（漫画阵营 × 模式）

一句话目的：`mission.xml` 里一组 `<stage>`。按 `comicType` + `gameMode` 区分火影/死神 × 组队/单人。`MessionModel` 持有全部线，当前关是 `stageList[index]`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionVO.as`（43 行）

## Callers / callees

- **Callers**：`MessionModel.initByXML` `new`+`initByXML`；`getMession(comicType, gameMode)` 查找。`MessionStageVO.mession` 回指本对象。
- **Callees**：`MessionStageVO`。

## 命名备注

`Mession` = mission 的原拼写，类名/文件名/XML 文件 `mission.xml` 不一致。

`gameMode` 这里是 **XML 关卡表类型 0=组队 / 1=单挑**，不是 `GameMode.currentMode`（10/20/…）。`MessionModel` 用 `GameMode.isTeamMode() ? 0 : 1` 来查。

## 逐行说明

### 字段（L6–10）

- `comicType`：与 `FighterVO.comicType` 相同，选人后按 P1 第一人的漫画阵营选线。
- `gameMode`：0 组队表 / 1 单人表。
- `stageList:Vector.<MessionStageVO>`：关序列，下标 = 当前关。

### 构造（L12–15）

空。

### `initByXML`（L17–40）

1. `comicType` / `gameMode` 从根节点属性。
2. `stageList = new Vector`。
3. `while (i < param1.stage.length())`：每个 `<stage>`：
   - `new MessionStageVO()`，`mession = this`。
   - `assister`、`map` 属性。
   - `fighters = @fighter.split(",")`。
   - `hpRate` / `attackRate`：`Number(attr) > 0` 才用，否则 1。缺省或 0 都当 1。

`_loc4_:Object = param1.stage[i]` 实际是 XML 节点，用 `@` 取属性。
