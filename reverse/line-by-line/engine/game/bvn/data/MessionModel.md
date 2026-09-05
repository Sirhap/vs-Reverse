# `MessionModel` — 街机关卡表单例：按阵营选线、推进关卡、灌 P2

一句话目的：读 `mission.xml` 得到全部 `MessionVO`。街机选人结束按 P1 第一人的 `comicType` + 组队/单人表类型取出一条线，把当前关的敌方/辅助/地图写进 `GameData.p2Select` 和 `selectMap`。过关 `messionComplete` 下标 +1。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionModel.as`（114 行）

## Callers / callees

- **Callers**：
  - `GameData.loadConfig` 第五段：`initByXML(new XML(mission.xml))`。
  - `MenuBtnGroup`：TEAM/SINGLE ACRADE、SURVIVOR 入口 `reset()`（清关卡进度和分数）。VS 入口不 reset。
  - `SelectFighterStage.startAcradeGame`：`initMession()` 再进 loading。
  - `WinnerState.goNext`：`messionComplete()` 再 `MainGame.loadGame`。
  - `GameCtrl.fightFinish` 街机 P1 胜：`missionAllComplete()` 真 → 通关祝贺，否则去 Winner。
  - `GameCtrl.addFighter`：P2 AI 的 `AILevel = MessionModel.I.AI_LEVEL`。
  - `GameLogic.resetFighterHP` / `setMessionEnemyAttack`：`getCurrentMessionStage()` 的 `hpRate`/`attackRate`。
- **Callees**：`MessionVO`/`MessionStageVO`、`FighterModel.getFighter`、`GameData`、`GameMode.isTeamMode`/`isAcrade`、`GameLogic.addScoreByPassMission`、`SelectVO`。

## 命名备注

- `Mession` = mission。XML 文件是 `mission.xml`，类名/方法是 Mession。`messionComplete` vs `missionAllComplete` 混用 m/ss。
- 本类 `gameMode` 查表用的是 **0 组队 / 1 单挑**（`MessionVO.gameMode`），不是 `GameMode.currentMode` 的 10/20。
- `AI_LEVEL` 默认 **6（HELL）**。只有 `initMession` 才从 `config.AI_level` 拷过来。VS CPU 不走 `initMession`，会吃到默认 6 或上一局街机残留。
- `ACRADE` 在 `GameMode`，本文件用 `isAcrade()`。

## 逐行说明

### 字段（L8–18）

- `_i`：懒单例。
- `AI_LEVEL = 6`：给 `FighterAICtrl`。设置里的 1–6 不会自动同步。
- `_curMession`：当前关卡线。
- `_curStageId`：当前关下标，`reset` 置 0。AS3 int 默认 0。
- `_curStage`：`_curMession.stageList[_curStageId]`。
- `_messions:Array`：全部 `MessionVO`。

### 构造 / `I`（L20–32）

空构造。外部一律 `I`。

### `initByXML`（L34–44）

`param1` = `mission.xml` 根。`_messions = []` 后 `for each` 每个 `param1.design`：`new MessionVO().initByXML` 再 push。重复加载会丢掉旧表。节点名是 `design` 不是 `mession`。

### `getMession`（L46–56）

`param1` = `comicType`（与 `FighterVO.comicType` 同：0 死神 / 1 火影，以角色 XML 为准），`param2` = 表类型 0/1。线性扫，两项都相等才返回。没有返回 `null`。

### `getCurrentMessionStage`（L58–61）

当前关 VO。VS/练习没 `initMession` 时是 null，`GameLogic.resetFighterHP` 的街机倍率分支会跳过。

### `initMession`（L63–83）

选人结束、以及过关推进后调用。

1. P1 队长：`FighterModel.I.getFighter(GameData.I.p1Select.fighter1)`。`p1Select` 或 fighter1 空会炸（?）。
2. `gameMode` 查表键：`GameMode.isTeamMode() ? 0 : 1`。生存（30）**不是** team，走单人表（`getFighters` 随机 1 个敌）。
3. `getMession(comicType, 0|1)` → `_curMession`。找不到则下一行 NPE（?）。
4. `_curStage = stageList[_curStageId]`。
5. `p2Select ||= new SelectVO()`。街机玩家没选 P2，这里建空的再填 CPU。
6. `getFighters()` 返回的 id 数组：下标 `i` 写到 `p2Select["fighter"+(i+1)]`。组队最多 3 个（不足补 null）；单人只有 `fighter1`。
7. `p2Select.fuzhu = _curStage.assister`，`selectMap = _curStage.map`。
8. `AI_LEVEL = config.AI_level`：这一刻才跟设置对齐。
9. `trace` 双方 SelectVO JSON，调试用。

不重置 `_curStageId`——推进关靠 `messionComplete` 先 +1 再进来。

### `reset`（L85–91）

`_curStageId = 0`，当前线和关置 null，`GameData.I.score = 0`。菜单进街机/生存时调。不改 `AI_LEVEL`。

### `messionComplete`（L93–106）

`WinnerState` 点继续：

- 已经 `missionAllComplete()`：`trace("mission all over!!!")` **return**。正常通关不走 Winner，不会进这里；这是防护。
- 否则 `_curStageId++`，`initMession()` 灌下一关敌人。
- 当前是街机（含生存）才 `GameLogic.addScoreByPassMission()`（组队且仍是首发 +15000，否则 +5000，再乘操作模式系数）。

### `missionAllComplete`（L108–111）

`_curStageId >= _curMession.stageList.length - 1`。

语义是「**当前已经是最后一关**」，不是「已经打完并越界」。`GameCtrl.fightFinish` 在 P1 赢时问这个：最后一关赢了直接祝贺，**不**再 `messionComplete`。非最后一关才去 Winner 再 +1。

`_curMession` 空会 NPE（? 只应在街机对局中问）。
