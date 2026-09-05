# `GameRunDataVO` — 一场对局的回合、胜场、计时和双方队伍

一句话目的：`GameCtrl.gameRunData` 上那份对局状态。两边各一个 `GameRunFighterGroup`，再加地图、回合数、计时、上一回合胜负残留（HP/气/队伍）。`reset` 开新局，`clear` 只丢引用（街机 continue 要保住败者实例）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/GameRunDataVO.as`（105 行）

## Callers / callees

- **Callers**：几乎全经 `GameCtrl.I.gameRunData`：
  - `GameCtrl`：`const` 持有；`doStartGame` → `reset`；`destory` → 两组 `destoryFighters`，无 `continueLoser` 才 `clear`；`doGameEnd`/`drawGame`/`timeover`/`runNext`/`doBuildNextRound`/`nextFighter`/`fightFinish` 读写胜场/回合/last*。
  - `LoadingState.gotoGame`：把加载好的 `FighterMain` 填进两组的 `fighter1/2/3` 和 `currentFighter`。
  - `FighterEventCtrl.addAssister`：按 team 取组的 `fuzhu`。
  - `GameEndCtrl`：终场关 `setAllowLoseHP(false)`；组队/生存按剩余时间给胜者回血，写 `lastWinnerHp`。
  - `FightUI` / `FightTimeUI`：回合、是否超时、当前角色、`getWins`。
  - `GameOverState`：读/清 `continueLoser`。
  - `GameLogic.addScoreByKO` / `addScoreByPassMission`：读 P1 当前角色。
- **Callees**：`GameRunFighterGroup`、`GameData.I.config`（`fighterHP`、`fightTime`）、`FighterMain`/`FighterVO`/`TeamVO`/`MapMain`（类型）。

## 命名备注

- `GameCtrl.gameRunData` 是 `const`，`destory` 不换实例。continue 跨场靠同一 VO。
- `lastWinnerHp` 默认 1000（= `FIGHTER_HP_MAX`），`reset` 却赋成 `config.fighterHP`（倍率 0.5–5）。真正进下一回合前会被 `GameEndCtrl` 写成当前血。
- `gameTimeMax == -1` 表示不计时（练习）；`GameEndCtrl` 误判的是 `gameTime == -1`。

## 逐行说明

### 字段（L9–39）

- `p1FighterGroup` / `p2FighterGroup`：`const` 各 new 一份。槽位 + `fuzhu` + `currentFighter`。
- `map`：`LoadingState` 写入，`GameCtrl.buildGame` 拿去 `initlize` + `initFight`。
- `p1Wins` / `p2Wins`：本局胜场。单挑先到 2 结束；组队按换人，不是 BO3。
- `lastWinnerTeam`：刚结束那回合胜者的 `TeamVO`。平局置 null。`runNext` 用它决定换哪边。
- `continueLoser`：街机 P1 输了整场时，指向 P1 当前 `FighterMain`。`destory` 时 `destoryFighters(continueLoser)` 保住这个实例和 SWF。
- `lastWinner`：胜者精灵。组队下一回合 `hp = lastWinnerHp`。
- `lastWinnerHp`：胜者带走的血。`GameEndCtrl` 在 win pose 阶段写入（组队/生存已加过时间奖励血）。
- `lastLoserData`：败者 `FighterVO`（不是精灵）。`nextFighter` 同 `comicType` 则继承气。
- `lastLoserQi`：败者当时的气。换人：`qi = lastLoserQi + 100`，封顶 300。
- `round = 1`：从 1 起。`FightUI` 显示。
- `gameTime` / `gameTimeMax`：剩余秒 / 上限秒。`GameCtrl.renderGameTime` 每 30 逻辑帧减 1。`gameTimeMax != -1` 才走计时。
- `isTimerOver`：超时判负时置 true，`FightUI` 播超时演出。
- `isDrawGame`：`drawGame` 置 true；组队平局两边都换人。

### 构造（L41–44）

空。真正清零靠 `reset`。

### `getWins`（L46–57）

`param1` = 某个 `FighterMain`。`team.id-1`：0→`p1Wins`，1→`p2Wins`，其它 0。`FightUI.showWins` 用。无 team 会 NPE（?）。

### `reset`（L59–74）

`GameCtrl.doStartGame` 每场开头：

- 胜场、回合、last*、超时/平局、`continueLoser` 清掉。
- `lastWinnerHp = config.fighterHP`：把**倍率**写进 int（1 → 1 血）。正常路径在第一次终场就被 `GameEndCtrl` 覆盖；若组队在终场前就读，会把胜者打成 1 HP（?）。
- `gameTimeMax = config.fightTime`，`gameTime = gameTimeMax`。练习随后 `buildGame` 把 `gameTimeMax` 改 `-1`（`gameTime` 仍是 60，但不递减）。

不碰两组 fighter 槽、不碰 `map`——角色是 `LoadingState` 预先填好的。

### `clear`（L76–83）

`map` 和所有 last*/`continueLoser` 置 null。不 `destory` 精灵（调用方已经 `destoryFighters`）。不重置 wins/round/time。仅当 `continueLoser == null` 时 `GameCtrl.destory` 才调，避免 continue 丢败者引用。

### `nextRound`（L85–90）

`round++`，`gameTime = gameTimeMax`，`isTimerOver = false`。不改 wins、不改 lastWinner（`runNext` 在 `buildNextRound` 之后才把 `lastWinner` 置 null）。`runNext` 一进就调这个，所以终场演出看到的已经是下一回合号。

### `setAllowLoseHP`（L92–102）

`param1` 写到**两边 currentFighter**。组判 `if (p1FighterGroup)` 恒真（const）。`currentFighter` 空则 NPE（?）。

`GameCtrl` 开场 ctrl 结束时 `true`；`GameEndCtrl` 终场开头 `false`，避免 KO 镜头里再掉血。
