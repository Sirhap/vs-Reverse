# `GameCtrl` — 对局单例总控

一句话目的：整场战斗的单例指挥。`startGame`/`doStartGame` 组队建场，`render` 驱动物理/开场/终场/练习，`gameEnd`/`drawGame`/`fightFinish` 切回合或离场，并持有 `GameStartCtrl` / `GameEndCtrl` / `GameMainLogicCtrler` / `FighterEventCtrl` / `TrainingCtrler`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameCtrl.as`（756 行）

## Callers / callees

- **Callers（decompiled）**
  - `MainGame.goGame` → `startGame()`；`resetDefault` 把 `autoEndRoundAble`/`autoStartAble` 置回 true。
  - `GameState.build` → `initlize(this)`；`GameState.destory` → `destory()`。
  - `GameOverState` 读 `gameRunData.continueLoser`，继续失败后再 `destory()`。
  - `LoadingState` 把角色/地图写进 `gameRunData`。
  - `FighterEventCtrl`：`add/removeGameSprite`、`getEnemyTeam`、`gameEnd`、`gameState.gameUI`。
  - `EffectCtrl`：`pause`/`resume`（无参，顿帧）、`setRenderHit`、`slow`/`slowResume`、`add/removeGameSprite`（team=0 特效）。
  - `FightUI`：无参 `pause`/`resume`（KO 镜头）；`PauseDialog` → `resume(true)`。
  - `FighterKeyCtrl`/`FighterAICtrl` 读 `actionEnable`；`FighterMcCtrler.getAttacker` → `getAttacker`。
  - `bleachvsnaruto_2` → `pause(true)`（失焦）。
- **Callees**：`GameStartCtrl`、`GameEndCtrl`、`GameMainLogicCtrler`、`FighterEventCtrl`、`TrainingCtrler`、`GameState`、`GameLogic`、`GameRender`、`GameInputer`、`EffectCtrl`、`SoundCtrl`、`GameUI`、`GameEvent`、`GameMode`、`MessionModel`、`MainGame`、`GameInterface.afterBuildGame`、`KeyBoarder`、`FighterKeyCtrl`/`FighterAICtrl`。

## 命名备注

- `initlize` / `destory`：全包拼写，不是 initialize/destroy。
- `isAcrade` / `MessionModel`：街机、关卡模型的原拼写。
- `autoStartAble` / `autoEndRoundAble`：插件闸。本包只有 `MainGame.resetDefault` 写回 true，未见置 false；`doStartGame`/`doGameEnd` 是绕过闸的公开入口。
- `startNextRound()`（L352）本包未见外部调用；内部下一回合走 `buildNextRound` → `doBuildNextRound`。
- `fightFinished` 只在本类置位，本包未见读取（? 给外部/调试）。
- `GameMode`：10/11/12 组队，20/21/22 单挑，30 生存，40 练习。

## 所有权（子控制器）

```
GameCtrl.I
├── gameState          GameState，initlize 注入
├── gameRunData        const GameRunDataVO，continue 时可跨 destory 保活
├── _teamMap           TeamVO 1=P1 / 2=P2；精灵挂 children
├── _fighterEventCtrl  initlize 创建，整场
├── _mainLogicCtrl     buildGame 创建，每帧物理
├── _startCtrl         开场/下一回合 intro，render 完 destory
├── _endCtrl           KO/平局 cinema，render 完 destory → runNext
└── _trainingCtrl      仅 mode==40
```

主循环（`GameRender.add(render)`，战斗 FPS=60）：

1. `renderPause`：intro 可 skip，或 ESC 暂停菜单
2. `_isPauseGame` → return（菜单暂停，EffectCtrl 也不跑）
3. `EffectCtrl.render` + `gameState.render`
4. `!_isRenderGame` → return（顿帧：镜头/特效仍跑，物理停）
5. `checkRenderAnimate` 按 30fps 置位
6. `_mainLogicCtrl.render` 物理 +（若置位）动画/攻击判定
7. `_startCtrl` / `_endCtrl` / `_trainingCtrl`

## 逐行说明

### 字段（L37–75）

- `_i`：懒单例。
- `gameState`：当前 `GameState`。
- `gameRunData`：`const` 新 `GameRunDataVO()`，不换实例。
- `actionEnable`：开场/终场 false，键位/AI `enabled` 都读它。
- `autoStartAble` / `autoEndRoundAble`：默认 true。
- `_teamMap`：对局队伍。
- `_startCtrl` / `_fighterEventCtrl` / `_trainingCtrl` / `_mainLogicCtrl` / `_endCtrl`：见上。
- `_isRenderGame`：物理是否跑。`pause()` 无参只关这个。
- `_isPauseGame`：暂停菜单。`pause(true)` 才置。
- `_gameRunning`：`initlize` true，`destory` false；pause/resume 的总闸。
- `_renderTimeFrame`：逻辑 30 帧扣 1 秒。
- `_renderAnimateGap` / `_renderAnimateFrame`：动画抽帧。`ceil(FPS_GAME/30)-1`，60fps 时 gap=1 → 每 2 物理帧一动画帧。
- `fightFinished`：`fightFinish` 置 true。
- `_gameStartAndPause`：intro 期间按了暂停，intro 结束后补 `pause(true)`。

### 空构造（L77–80）

真正初始化在 `initlize`。直接 `new GameCtrl()` 也能，但外部都走 `I`。

### `I` getter（L82–89）

懒创建单例。`destory` **不**清 `_i`，continue 后再 `initlize` 复用同一实例。

### `getAttacker`（L91–94）

转给 `_fighterEventCtrl.getAttacker(name, teamId)`。`FighterMcCtrler` 用。`_fighterEventCtrl` 空则 NPE（? 只应在对局中调）。

### `setRenderHit`（L96–102）

写 `_mainLogicCtrl.renderHit`。`EffectCtrl` 必杀镜头期间 false，暂停身体碰撞和攻击判定。ctrl 尚未 build 则空操作。

### `initlize`（L104–115）

`GameState.build` 调用：

1. 挂 `gameState`。
2. `_isPauseGame=false`，`_isRenderGame=true`，`_gameRunning=true`，`_gameStartAndPause=false`。
3. **新** `FighterEventCtrl` 并 `initlize()`（清并重绑 `FighterEventDispatcher`）。
4. `_renderAnimateGap = ceil(FPS_GAME/30)-1`。
5. `KeyBoarder.focus()`。

不创建 `_mainLogicCtrl`/`_startCtrl`——那是 `buildGame` 的事。不 `GameRender.add`——`doStartGame` 才加。

### `renderPause`（L117–145）—— 每帧最先

- **有 `_startCtrl` 或 `_endCtrl`**：`GameInputer.back(1)` 或 `select("MENU",1)` 则 `skip()`。开场可跳过 intro；终场 `GameEndCtrl.skip` 只在 win pose（step==2）清 hold。然后 **return**，intro 期间不能进暂停菜单。
- **否则** `back(1)`：已暂停则 `resume(true)`，否则 `pause(true)`。

`1` 是输入缓冲帧。

### `destory`（L147–189）

`GameState.destory` / `GameOverState` 调用：

1. `GameRender.remove(render)`、`GameLogic.clear()`、`GameInputer.clearInput()`。
2. 五个子 ctrl 依次 `destory` 并 null（`_mainLogicCtrl.destory` 是空函数）。
3. `gameState = null`（不 destory GameState，它是调用方）。
4. `p1FighterGroup.destoryFighters(continueLoser)`：街机 continue 保住败者；`p2` 全毁。
5. **无** `continueLoser` 才 `gameRunData.clear()` + `GameLoader.dispose()`；有则角色 SWF 留下给继续。
6. `_gameRunning = false`。

不重置 `fightFinished`/`actionEnable`/`_teamMap`。不 `null` `_i`。

### `getEnemyTeam`（L191–204）

`team.id==1` → team 2，`==2` → team 1。无 team 或其它 id → null。`FighterEventCtrl.onDie` 用它找胜者。

### `addGameSprite`（L206–230）

`param1` teamId，`param2` 精灵，`param3` 层索引默认 -1。

- `param3 != -1` → `gameState.addGameSpriteAt`（`EffectCtrl` 用 team=0、index=0 插底层特效）。
- 否则 `addGameSprite`。
- `_teamMap.getTeam(param1)`：有则 `param2.team = team`、`team.addChild`；若是 `FighterMain` 还设 `targetTeams = getOtherTeams`。
- team 空（特效 team=0）：`Debugger.log("GameCtrl.addGameSprite :: team is null!")`，精灵仍在显示列表，但不参与 `TeamMap` 对撞循环。

### `removeGameSprite`（L232–241）

显示列表移除 → team.removeChild → `param1.destory(param2)`。`param2` 默认 false；`EffectCtrl` 传 true 立即卸。

### `startGame`（L243–251）

`!autoStartAble` 直接 return。否则 `fightFinished=false`，`doStartGame()`。`MainGame.goGame` 在切到 `GameState` 之后立刻调。

### `doStartGame`（L253–262）

公开，绕过 `autoStartAble`：

1. `_isPauseGame=false`，`GameInputer.enabled=true`。
2. `gameRunData.reset()`：胜场/回合/计时清零（`gameTimeMax` 来自 `GameData.config.fightTime`）。
3. `initTeam()` → `buildGame()`。
4. `GameEvent "GAME_START"`。
5. `GameRender.add(render)` 进入主循环。

### `buildGame`（L264–310）—— 建场

取 `p1/p2.currentFighter` 与 `map`。

- **mode==40 练习**：`new TrainingCtrler().initlize([p1,p2])`，`gameTimeMax=-1`（无限时）。
- 缺人/缺图 → `throw new Error("创建游戏失败")`。
- **同 id 镜像**：P2 `ColorTransform.greenOffset=-85`；否则清 tint。
- `addFighter(p1,1)` / `addFighter(p2,2)`。
- `map.initlize()`；`gameState.initFight`（站位、镜头、HUD、arcade 敌攻修正）；`GameLogic.initGameLogic(map, camera)`。
- `new GameMainLogicCtrler().initlize(gameState, _teamMap, map)`。
- **练习**：`actionEnable=true`，`GameUI.I.fadIn()`，`playFightBGM("map")`，无 `_startCtrl`。
- **其它**：`new GameStartCtrl(gameState)`，`actionEnable=false`，`start1v1(p1,p2)`（introTeamId 默认 -1，BGM 用 P2）。
- `GameInterface.instance.afterBuildGame()` 插件钩。

### `addFighter`（L312–341）

null 则 return。

- **team 1**：`FighterKeyCtrl`，`inputType="P1"`，`classicMode = keyInputMode==1`。
- **team 2**：`GameMode.isVsCPU(false) || isAcrade()` → `FighterAICtrl`（`AILevel=MessionModel.I.AI_LEVEL`）；否则 P2 键鼠。`isVsCPU(false)` **不含** 练习 40，所以练习 P2 是键鼠。街机 10/20/30 与 VS CPU 12/22 才是 AI。
- `fighter.initlize()` + `setActionCtrl` + `addGameSprite(teamId, fighter)`。

### `removeFighter`（L343–350）

null 则 return，否则 `removeGameSprite`（destory false）。`nextFighter` 换人用。

### `startNextRound`（L352–355）

`doBuildNextRound(GameMode.isTeamMode())`。本包未见外部调用。

### `buildNextRound`（L357–360）

私有薄封装，`runNext` 调用。与公开 `startNextRound` 同体。

### `doBuildNextRound`（L362–386）

1. `gameState.resetFight`：双方拉回 p1/p2 位、idle、重置 HP、镜头。
2. **新** `GameStartCtrl`。
3. **`param1` 真（组队）**：
   - 有 `lastWinner` 则 `hp = lastWinnerHp`（终场按剩余时间回血后的值）。
   - intro 焦点：`lastWinnerTeam.id==1 ? 2 : 1`（**败方/换人方** intro + 播其 BGM）；无 lastWinnerTeam 则 -1。
   - `start1v1(p1current, p2current, introId)`。
4. **假（单挑下一局）**：`startNextRound()` 只播 FIGHT UI，无台词。
5. `isDrawGame=false`；`GameEvent "ROUND_START"`。

### `fightFinish`（L388–420）—— 整场结束

`fightFinished=true`。**两段 if 独立**，不是 if/else：

- **`isAcrade()`**（10/20/30）：
  - P1 胜：`missionAllComplete()` → `goCongratulations()`（trace「通关！」）；否则 `winnerId=p1.id`，`goWinner()`（「下一关」）。
  - 否则：`continueLoser = p1.currentFighter`，`goContinue()`（「跳转是否继续」）。
- **`isVsCPU() || isVsPeople()`**（含默认 `isVsCPU()` 的练习 40）：`"GAME_END"` + `goSelect()`。

街机 VS 条件互斥，本包不会双走。练习走第二段回选人。生存 30 是街机、不是 VS，走 continue/通关。

### `initTeam`（L422–430）

`_teamMap.clear()`（只清 `_teamObj`，`add` 时 `refreshTeams`）。`GameMode.getTeams()` 固定 `{id:1,name:"P1"}` `{id:2,name:"P2"}`，各 `new TeamVO`。

### `pause`（L432–451）

`!_gameRunning` return。

- `param1 && !_isPauseGame`（玩家暂停）：
  - 若 intro/outro 进行中：只标 `_gameStartAndPause=true` 然后仍落到 `_isRenderGame=false`。intro 期间物理也会停，菜单要等 intro 结束才由 `render` 补 `pause(true)`。
  - 否则 `"PAUSE_GAME"`、`_isPauseGame=true`、`GameUI.pause()`、舞台 `DataEvent("5d_message", ["game_pause"])`。
- **无论 param1**：`_isRenderGame=false`。`EffectCtrl`/`FightUI` 无参调用 = 顿帧。

### `resume`（L453–469）

`!_gameRunning` return。**总是** `_gameStartAndPause=false`。

- `param1 && _isPauseGame`：`"RESUME_GAME"`、清暂停、`GameUI.resume()`、`["game_resume"]`。
- 无参（顿帧结束）：不清 `_isPauseGame`。
- `KeyBoarder.focus()`；`_isRenderGame=true`。

### `gameEnd`（L471–482）

`!autoEndRoundAble` 或已有 `_endCtrl` → return。否则 `doGameEnd`。来源：`FighterEventCtrl.onDie`、`timeover`。

### `doGameEnd`（L484–506）

绕过闸：

1. `lastWinnerTeam/lastWinner/lastLoserData/lastLoserQi` 写入 rundata。
2. P1 胜：`p1Wins++`；败者 `hp<=0` 且街机 → `GameLogic.addScoreByKO()`。P2 胜只 `p2Wins++`。
3. `new GameEndCtrl().initlize(winner, loser)`。
4. `actionEnable=false`；`"ROUND_END"`。

`param1` null（敌队没有 `FighterMain`）会在 `.team` NPE（?）。

### `render`（L508–559）—— 主循环

局部 `_loc2_` 开场结束、`_loc1_` 终场结束。

1. `renderPause()`。
2. `_isPauseGame` return。
3. `EffectCtrl.I.render()` + `gameState.render()`（顿帧时这两步仍跑）。
4. `!_isRenderGame` return。
5. `checkRenderAnimate()`。
6. `_mainLogicCtrl.render()`。
7. **`_startCtrl`**：整段 `actionEnable=false`。`render()` 真 → destory、null、`actionEnable=true`、`setAllowLoseHP(true)`；若 `_gameStartAndPause` 则 `pause(true)` 并清标。
8. **`_endCtrl`**：`render()` 真 → destory、null、`runNext()`。
9. **`_trainingCtrl.render()`**（练习锁血/气）。

开场与终场理论上不同时存在。

### `checkRenderAnimate`（L561–575）

gap>0：`_renderAnimateFrame++ >= gap` 才 `renderAnimate()` 并清零。gap==0（战斗 FPS≤30 或 `slow` 把动画 FPS 拉到 ≥ 战斗 FPS）每物理帧都动画。

### `renderAnimate`（L577–587）

`_mainLogicCtrl.renderAnimate()` 置 `_renderAnimate=true`（下一 `renderMainLogic` 才消费）。`actionEnable && !_startCtrl && !_endCtrl` 才 `renderGameTime()`——倒计时跟动画帧走，慢动作时秒也变慢。

### `renderGameTime`（L589–603）

`gameTimeMax==-1`（练习）跳过。否则每 30 次动画帧 `gameTime--`，≤0 → `timeover()`。60fps、gap=1 时约 1 真实秒。

### `timeover`（L605–625）

trace `"time over!!!"`，`actionEnable=false`，`isTimerOver=true`。HP 相等 `drawGame()`；否则 HP 高者 `gameEnd`。平局不走 `autoEndRoundAble` 闸（`drawGame` 自己闸 `_endCtrl`）。

### `drawGame`（L627–639）

已有 `_endCtrl` return。`lastWinnerTeam/lastWinner=null`，`isDrawGame=true`，`new GameEndCtrl().drawGame()`，`actionEnable=false`。无 `"ROUND_END"`。

### `runNext`（L641–664）—— 终场后分流

`gameRunData.nextRound()`（round++，重置时间）。

- **组队**：`startNextTeamFight()` 真 → `buildNextRound(true)`，清 `lastWinner`，return。假 = 一方没人了 → 落下去 `fightFinish`。
- **单挑**：双方胜场都 <2 → `buildNextRound(false)`（BO3），清 `lastWinner` return。
- 否则 `fightFinish()`。生存 30 既非组队也非单挑，**一局即结束**。

### `startNextTeamFight`（L666–702）

**平局 `isDrawGame`**：

- 双方 `getNextFighter()`（fighter1→2→3）。
- 都没下一人：return **true** → 仍 `buildNextRound`（末对再打，平局不判负）。
- 仅 P1 有下一人：`lastWinnerTeam=P1`，return false → 结束，P1 胜。
- 仅 P2 有：P2 胜。
- 都有：两边 `nextFighter`（平局**双方换人**），return true。

**有胜者**：胜 team 1 则换 P2 下一人；胜 team 2 换 P1。`nextFighter` 假（没人）→ 整场结束。`lastWinnerTeam.id` 不是 1/2：清 null，return true（? 防御）。

### `nextFighter`（L704–732）

组空 / `getNextFighter()` 空 → false。

同 `comicType`：下一人 `qi = lastLoserQi+100` cap 300（同作品气继承）。然后 `removeFighter(current)`、`removeCurrentFighter()`（dispose 当前）、`currentFighter=next`、`addFighter(next, team.id)`。

### `slow`（L734–740）

`param1` 慢放倍率（`EffectCtrl.slowDown` 传入）。动画 FPS = `30/param1`；`setSpeedPlus(SPEED_PLUS_DEFAULT/param1)`；镜头 `tweenSpd = 2.5 * param1`（慢放时镜头 tween **变慢**，因为 param1>1 时 tweenSpd 变大？`2.5*param1` 更大 = 更快。? 需对照镜头实现：可能是时长系数）。

### `slowResume`（L742–747）

动画 30fps，`SPEED_PLUS_DEFAULT`，`tweenSpd=2.5`。

### `setAnimateFPS`（L749–753）

`_renderAnimateGap = ceil(FPS_GAME / param1) - 1`，帧计数清零。`initlize` 与 `slow` 共用。
