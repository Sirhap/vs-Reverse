# `FightUI` — 战斗 HUD 根（`IGameUI`）

一句话目的：实现 `IGameUI`。从 `ResUtils.fight` 实例化 `ui_fight`，装配顶部血条组、两侧气条、连击数字、开场/KO MC、屏外角色标记和暂停框。`GameUI.initFight` 创建，`GameState` 把它挂在镜头层**外面**（屏幕坐标 800×600）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightUI.as`（579 行）

## Callers / callees

- **Callers**
  - `GameUI.initFight`：`new FightUI()` + `setVolume(config.soundVolume)` + `initlize(p1Group, p2Group)`。已有 `FightUI` 则复用，不 destory。
  - `GameUI.render` → `IGameUI.render`；按 30fps 语义再 `renderAnimate`。`GameState.render` 每逻辑帧调 `gameUI.render()`。
  - `GameUI.fadIn` → `FightUI.fadIn()`（默认 `true`）再 `setVolume`。`GameUI.fadOut` **误调** `fadIn()`，终场不走这条。
  - `GameStartCtrl`：intro 结束 `showStart(cb)`；skip 且尚未 FIGHT 时 `fadIn(true)`。
  - `GameEndCtrl`：`showEnd(cb, {winner,loser})` 或 `{drawGame:true}`；结束 `clearStartAndEnd`；KO 路径再 `fadOut(false)`。
  - `FighterEventCtrl.addHits`：hits>1 才 `showHits(hits, teamUiID)`；`removeHits` → `hideHits(uiID)`。
  - `GameCtrl.pause(true)` / `resume(true)`：菜单暂停才转到 `FightUI.pause` / `resume`。无参 `pause()`（KO 顿帧）**不**弹暂停框。
  - `GameCtrl.buildGame` 练习模式：`GameUI.I.fadIn()`（立刻出 HUD，无 ROUND/FIGHT）。
- **Callees**
  - 子件：`FightBar`、`QiBar`×2、`HitsUI`×2、`PauseDialog`。
  - `ResUtils.I.createDisplayObject(ResUtils.I.fight, "ui_fight"|"player_pos_p1"|"player_pos_p2")`。
  - `EffectCtrl`：`freezeEnabled`、`doEffectById("hit_end")`、`shine`、`BGEffect("kobg")`、`shake`、`slowDown`/`slowDownResume`。
  - `GameCtrl.I`：`pause`/`resume`（无参顿帧）、`gameRunData`、`gameState.cameraFocusOne` / `getGameSpriteGlobalPosition` / `camera.getZoom`。
  - `SoundCtrl.I.playSwcSound`：`snd_over_hit`、`snd_ko` / `snd_ko_bs`（同包 SWC，无 import）。
  - `GameEvent`：街机听 `"SCORE_UPDATE"`。
  - `GameMode.isAcrade` / `isSingleMode`；`GameData.I.score`；`GameConfig.GAME_SIZE` / `FPS_GAME`。

## HUD 布局 / SWF

全部来自 `ResUtils.fight`（嵌入 `fight_swf$…`，链接名见 `decompiled/ui/fight/scripts/`）。**不**走 `ResUtils` 常量表。

```
GameState（Istage Sprite）
├── map.bgLayer
├── _gameLayer          ← GameCamera 作用对象
│   ├── mapLayer / _playerLayer / front*
└── ui_fight            ← FightUI.ui，屏幕空间，不随镜头滚
    ├── hpbarmc         FightBar：P1 左 / P2 右 / 计时正中
    │   ├── face1 / face2     FightFaceGroup（3 槽头像）
    │   ├── bar1 / bar2       FighterHpBar（绿条+红拖尾）
    │   ├── energy1 / energy2 EnergyBar（体力 energy，不是气）
    │   ├── timemc            FightTimeUI
    │   ├── win_p1 / win_p2   WinUI 胜场灯
    │   └── scoremc           FightScoreUI（街机才亮）
    ├── fzqi1 / fzqi2   QiBar：气 0–300 + 辅助 fzqi + 辅助脸
    ├── hits1 / hits2   HitsUI：连击数字（屏幕固定位，不跟角色）
    ├── startKOmc       fight_fla.game_start_mc_44：ROUND/FIGHT/KO/…
    ├── player_pos_p1/p2 代码 addChild，zoom≤1.8 时标屏外角色
    └── PauseDialog     代码 addChild，菜单暂停
```

P1 一律左侧（`face1`/`bar1`/`energy1`/`fzqi1`/`hits1`/`win_p1`），P2 右侧并 `setDirect(-1)`。计时在 `hpbarmc.timemc` 水平居中。气条 SWF 默认贴底；`QI_BAR_MODE==TOP` 才会被代码挪到血条附近 `(120,60)` / `(675,60)` scale 0.8。

`startKOmc` 时间轴由 `renderStartAndKO` 按动画帧 `nextFrame()` 推进（`gotoAndStop` 标签后靠代码走帧，不是 `play()`）。

## 命名备注 / 符号对照

- 拼写：`destory`、`initlize`、`fadIn`/`fadOut`、`isAcrade` 全工程如此。
- `QI_BAR_MODE`：语义对齐 `FightQiBarMode`（0=AUTO / 1=TOP / 2=BOTTOM），但**本包没有任何写入**，始终默认 `0`。`FightQiBarMode` 类本身也没被 import。
- `renderQibarPos`：按 zoom 把 AUTO 气条挪到顶部或还原——**从未被调用**（`render` 只调 `renderPlayerPosUI`）。AUTO 的动态位移是死代码。?
- `BITMAP_UI`：`GameUI.BITMAP_UI=true` 且本包无写入。血条/气条走位图烘焙路径，MC fadIn 动画基本不播。
- `showStart` 的 `onFight`：收到 `"fight"` 只卸监听，**空体**。真正开操作靠 `"complete"` → `GameStartCtrl` 清 `_uiPlaying`。
- `EffectCtrl.shake(5,0,1.5)`：第三参是**毫秒**。`FighterEffectCtrl.shake` 会 `*1000`，这里直接传 `1.5`，衰减极快（见 `EffectCtrl.md`）。几乎确定是 bug。
- `getPlayerPos` 下沿钳制写成了 `x = GAME_SIZE.x-5` 而不是 `y`。?
- `player_pos_*` 用 `getGameSpriteGlobalPosition(..., 0, -50)`。`GameState.md` 把这条写成「hits 数字」不准确——连击是 `hits_mc` 的 SWF 布局坐标，不跟角色。
- `setTimeout(playKO2, 500)` 是墙钟 500ms，不受 `GameCtrl.pause` / slowDown 影响。
- `actionState` 直接比数字：12/13=必杀、22=击飞、30=死（`FighterActionState`）。
- `snd_ko` / `snd_ko_bs` / `snd_over_hit`：main.swf 嵌入 MP3，`SoundCtrl.playSwcSound`。

## 开场 / KO 时间线（`startKOmc`）

`fight_fla.game_start_mc_44` 字段：`$round`、`$perfect`、`$winnerX`、`$winnerY`（本类不写 `$winnerY`，SWF 默认 90）。

| 代码 `gotoAndStop` | 条件 | 派发 |
|---|---|---|
| `"start"` | round < 5 | `"fight"`（帧 58）、`"complete"`（帧 88） |
| `"start_final"` | round≥5 | 同上结构 |
| `"ko"` | 非超时 KO | `"complete"`（帧 190 一带） |
| `"timeover"` | `isTimerOver` | `"complete"` |
| `"drawgame"` | 超时且平局 | `"complete"` |
| `"winner"` | 胜者条 | 子 MC `winnermc` COMPLETE 再向上派 |
| 帧 1 | `clearStartAndEnd` | `stop` |

`renderStartAndKO`：当前帧标签 `"stop"` 则停；标签 `"go:xxx"` 则 `gotoAndStop(xxx)`（SWF 内部跳转约定）；否则 `nextFrame()`。

`game_start_mc_44` 其它脚本帧：27/28 按 `$round` 播 `nummc` 的 `"r1".."r5"`；55 派 `"fight_in"`（本类不听）；58 `"fight"`；200/201 把 `winnermc` 挪到 `$winnerX/$winnerY` 并写 `isPerfect`；210 把 `winnermc` 的 COMPLETE 转发出去。

## `IGameUI` 对照

`decompiled/.../ui/IGameUI.as`。本类全部实现，另多一个 `showWins`（接口没有）。

| 接口 | 本类 | 谁调 |
|---|---|---|
| `setVolume` | 写 `ui.soundTransform` | `GameUI.initFight` / `fadIn` |
| `destory` | 拆子件 + `removeChildren` | `GameUI.destory` ← `GameState.destory` |
| `fadIn(Boolean=true)` | 血条+气条 | `showStart`、`GameUI.fadIn`、`GameStartCtrl.skip` |
| `fadOut(Boolean=true)` | 同上 | `GameEndCtrl` `getUI().fadOut(false)`；KO 中途只 fadOut 气条 |
| `getUI` | 返回 `ui_fight` | `GameUI.getUIDisplay` |
| `render` | 血/气/屏外标/终场 | `GameUI.render` 每逻辑帧 |
| `renderAnimate` | 淡入淡出 + startKOmc 走帧 | `GameUI` 30fps 语义 |
| `showHits(n, team)` / `hideHits(team)` | HitsUI | `FighterEventCtrl` |
| `showStart(cb, params)` | ROUND/FIGHT | `GameStartCtrl`（params 丢弃） |
| `showEnd(cb, obj)` | KO / TIMEOVER / DRAW | `GameEndCtrl` |
| `clearStartAndEnd` | `gotoAndStop(1)` | `GameEndCtrl` cinema 收尾 |
| `pause` / `resume` | `PauseDialog` | 仅 `GameCtrl.pause/resume(true)` |

`GameUI.fadOut()` 自己写成 `_ui.fadIn()`，等于废函数。终场不经过它。

## 两种 pause

| | `GameCtrl.pause()` | `GameCtrl.pause(true)` |
|---|---|---|
| 谁调 | `FightUI.playKO`、`EffectCtrl.freeze` | ESC / 失焦 |
| `_isRenderGame` | false（物理停） | false |
| `_isPauseGame` | 不变 | true，整段 `GameCtrl.render` return |
| `FightUI.pause` | **不调** | 弹 `PauseDialog` |
| HUD `render` | 仍走（`GameState.render` 在 pause 闸之前？否：`_isPauseGame` 在 EffectCtrl 之前 return，**菜单暂停时 HUD 也停**） | 停 |
| KO 顿帧 | HUD 仍 render（`_isPauseGame` 仍 false），`renderEnd` / 气条 fadOut 动画靠 `renderAnimate`——但 `GameUI.render` 在 `GameState.render` 里，而 `GameCtrl.render` 顺序是：菜单闸 → EffectCtrl → gameState.render → `_isRenderGame` 闸。无参 pause 只关 `_isRenderGame`，**HUD 继续**。 |

`PauseDialog`：半透明全屏底 + `SetBtnGroup` 三项 GAME TITLE / MOVE LIST / CONTINUE。TITLE 走 `GameUI.confrim("BACK TITLE?","返回到主菜单？")`（拼写 `confrim`）；MOVE LIST 叠 `MoveListSp`；CONTINUE → `GameCtrl.I.resume(true)`。

## KO / 超时 cinema 时序

```
GameEndCtrl.showEnd(cb, {winner, loser} | {drawGame:true})
        │
        ├─ isTimerOver
        │     playTimeOver()                    // 不 pause、不关 freeze
        │       startKOmc "timeover" + 气条 fadOut
        │       complete → timeoverBack
        │            ├─ drawGame: playDrawGame "drawgame" → complete → cb
        │            └─ 否则 _playOver=true, delay=1s → renderEnd 切胜者 → cb
        │
        └─ else playKO(loser)
              freezeEnabled=false
              hit_end + shine(白,0.5) + cameraFocusOne(loser)
              GameCtrl.pause()                  // 顿帧
              任一方 12/13 → BGEffect("kobg",2) + 稍后 snd_ko_bs
              shake(5,0,1.5)  + snd_over_hit    // 1.5ms bug
              500ms 墙钟 → playKO2 "ko" + snd_ko + 气条 fadOut
              complete → koBack: freezeEnabled=true, resume(), _playOver=true
              renderEnd 等 loser 22→slowDown(2,0) → 30→delay 1s/2s
              delay 到 0: cameraFocusOne(winner) + showWinner
                         单挑 showWins；直接 cb（winner MC 可能还在播）
```

`GameEndCtrl` 同时 hold 最多 10s，cb 把 hold 清 0。之后等 `isAllowWinState` 才 `winner.win()`，再 transIn，最后 `clearStartAndEnd` + `fadOut(false)`。

## 逐行说明

### 静态 / 实例字段（L27–59）

- `QI_BAR_MODE`：气条贴边策略。未赋值 → 0。
- `ui`：`ui_fight` 根，公开给 `getUI()` / `GameState.addChild`。
- `_fightbar`：顶部整条 HUD。
- `_qibar1` / `_qibar2`：绑 `ui.fzqi1` / `fzqi2`。P2 构造里 `setDirect(-1)`。
- `_hits1` / `_hits2`：绑 `ui.hits1` / `hits2`。`showHits` 用 team 1/2 选。
- `_endParam`：`showEnd` 的 `{winner,loser,drawGame,finishBack}`。播完置 null。
- `_renderEnd`：`render()` 里跑 `renderEnd` 的闸。
- `_playOver`：KO / TIMEOVER MC 的 `"complete"` 之后才 true，开始等击飞落地。
- `_showWinnerDelay`：落地后再等 N 逻辑帧才切胜者镜头。单位=游戏帧。
- `_drawGame`：超时平局走 `playDrawGame`，不进胜者条。
- `_isSlowDown`：击飞慢动作只开一次。
- `_pauseDialog`：懒创建。
- `_flyTimer`：`getTimer()` 记下进入 `HURT_FLYING` 的墙钟，用来决定胜者 delay 1s 还是 2s。
- `_p1PosUI` / `_p2PosUI`：`player_pos_p1` / `player_pos_p2`，默认 `visible=false`。

### 构造（L61–83）

1. `ResUtils.I.createDisplayObject(ResUtils.I.fight, "ui_fight")` → `ui`。
2. `new FightBar(ui.hpbarmc)`。
3. `new QiBar(ui.fzqi1)` / `new QiBar(ui.fzqi2)`，P2 `setDirect(-1)`。
4. `new HitsUI(ui.hits1)` / `new HitsUI(ui.hits2)`。
5. 再 `createDisplayObject` 两个 `player_pos_*`，隐藏后 `ui.addChild`。
6. **仅** `GameMode.isAcrade()`（mode 10/20/30）：`trace("fightUI.initlize")`（文案像 init，实际在构造）、`_fightbar.initScore()`、听 `"SCORE_UPDATE"`。VS/练习不显示分数。

此时角色还没绑，等 `initlize`。`GameUI` 构造完立刻 `setVolume`。

### `initlize`（L85–91）

`param1`=P1 `GameRunFighterGroup`，`param2`=P2。

- `_fightbar.setFighter`：脸/HP/体力。
- `_qibar1.setFighter(currentFighter, fuzhu)`：气条跟**当前出战**角色，脸用**辅助** `Assister.data`。
- `_qibar2` 同理。
- `updateScore(null)`：即使没听事件也刷一次（非街机 `_score` 为 null，空操作）。

`GameState.initFight` 与 `resetFight`（下一回合 / 组队换人）都会再进这里。`GameUI` 复用同一 `FightUI` 实例。

### `setVolume`（L93–98）

读 `ui.soundTransform`，改 `volume`，写回。`startKOmc` 里若有时间轴音效走这条。`GameUI.fadIn` 每次都重设为 `config.soundVolume`。

### `showWins`（L100–103）

转发 `_fightbar.showWin(fighter, wins)`。`IGameUI` **没有**这个方法；只有本类 `renderEnd` 在 `isSingleMode` 时自调。组队不亮胜场灯。

### `updateScore`（L105–108）

`GameEvent` `"SCORE_UPDATE"` 或 `initlize` 调用。写 `_fightbar.setScore(GameData.I.score)`。`param1` 未用。

### `destory`（L110–156）

顺序：

1. `GameEvent.removeEventListener("SCORE_UPDATE", updateScore)`（非街机也 remove，harmless）。
2. `_pauseDialog.destory()`。
3. `_fightbar` / `_qibar1` / `_qibar2` / `_hits1` / `_hits2` 各自 `destory` 后置 null。
4. `ui.removeChildren()` + `ui.stopAllMovieClips()`，catch 后 `trace(e)`。`ui=null`。

**不清**：`_p1PosUI`/`_p2PosUI`（随 `removeChildren` 摘掉，不单独 destory）、`_endParam`、终场标志、`QI_BAR_MODE`。`GameState.destory` → `GameUI.destory` 进这里。下一场 `GameUI.initFight` 会 `new FightUI()`（因为 `_ui` 已被 destory 置空？`GameUI.destory` 只调 `_ui.destory()` **不清 `_ui` 引用**——再 `initFight` 时 `_ui` 仍是已掏空的 `FightUI`，`_ui is FightUI` 为真，**不会 new**，只再 `initlize`。`ui` 已 null，后续 `render`/`fadIn` 会 NPE）。?

实际战斗结束走 `goStage` 拆掉整个 `GameState`（连带 `new GameUI()`），这条脏复用只在「同一 `GameState` 上 destory UI 再 initFight」时触发，本包没有这条路径。?

### `getUI`（L158–161）

返回 `ui`。`GameUI.getUIDisplay` / `GameState.addChild` 用。`IGameUI` 要求。

### `render`（L163–174）—— 逻辑帧

`GameUI.render` 每游戏帧（默认 60）进来，**不受** `GameCtrl._isRenderGame` 影响（`GameState.render` 在 EffectCtrl 之后、主逻辑之前）。菜单暂停 `_isPauseGame` 时 `GameCtrl.render` 提前 return，本函数也不跑。

1. `_fightbar.render()`：HP / 体力 / 计时。
2. `_qibar1/2.render()`：气、辅助气。
3. `camera.getZoom()` → `renderPlayerPosUI`。
4. `_renderEnd` 则 `renderEnd()`（KO 后等击飞落地、切胜者）。

**不**调 `renderQibarPos`。HitsUI 无 per-frame render（靠 MC `gotoAndPlay`）。

### `renderQibarPos`（L176–192）—— 死代码

`QI_BAR_MODE != 0` 直接 return。AUTO 且 `zoom < 1.5`：气条 `moveTo(120,60,0.8)` / `(675,60,0.8)`（贴顶缩小）；否则 `moveResume()` 回构造时记下的原位。本包 `render` 从不调用。?

### `renderAnimate`（L194–200）

`GameUI` 按 `ceil(FPS_GAME/30)-1` 抽帧（60fps 隔一帧）。转发 FightBar / 两条 QiBar 的 fad 动画，再 `renderStartAndKO()`。Hits / startKOmc 的 `gotoAndPlay` 走的是 Flash 自己的帧频，不经这里；但 `startKOmc` 被 `gotoAndStop` 后要靠这里 `nextFrame()`。

### `renderStartAndKO`（L202–223）

`_loc2_ = ui.startKOmc`，null 则 return（正常不会）。

- 有 `currentFrameLabel`：
  - `"stop"` → return（停在标签，等下次 `gotoAndStop` 切段）。
  - 含 `"go:"` → `gotoAndStop(split("go:")[1])` 后 return（SWF 用标签驱动跳转）。
- 否则 `nextFrame()`。

`showStart`/`playKO`/`playTimeOver`/`showWinner` 都是 `gotoAndStop` 到段首，之后全靠这条往前爬，爬到脚本帧 `stop()+dispatchEvent(COMPLETE)`。

### `fadIn`（L225–240）

`param1` 默认 true = 播 MC 淡入。先 `_fightbar.fadIn(param1)`。

- `QI_BAR_MODE == 1`（TOP）：两条气条 `fadIn(false)`（瞬显）再 `setPosAndScale` 到顶部缩小位。**忽略** `param1`。
- 否则（AUTO/BOTTOM/默认 0）：气条 `fadIn(param1)`，留在 SWF 原位。

`BITMAP_UI` 时子件自己把动画短路成 `visible=true`。练习 `GameUI.fadIn`、`showStart` 内部、`GameStartCtrl.skip` 都会进。

BOTTOM(2) 与 AUTO 在这条上行为相同（都不改坐标）。

### `fadOut`（L242–247）

三条都 `fadOut(param1)`。`GameEndCtrl` 终场 `fadOut(false)`：BITMAP 路径直接藏子件；非 BITMAP 血条 `visible=false`，气条同。KO 中途 `playKO2` / `playTimeOver` 只 fadOut 气条（默认 true）。

### `showHits`（L249–253）

`param1`=连击数，`param2`=team UI id。`==1` 用 `_hits1` 否则 `_hits2`。`FighterEventCtrl`：team.id 1→1、2→2。第一下 hits==1 时事件层就不调这里。

### `hideHits`（L255–259）

`param1` 同样是 team uiID。受击结束 / 倒地 `removeHits` 进来。连打中途不 hide。

### `showStart`（L261–288）

闭包：`finishBack`、`params`（**未使用**）、`onFight`、`startComplete`。

1. `fadIn()`（默认带动画）。
2. `round = gameRunData.round`。
3. `startKOmc.y = -50`（偏上）。
4. `$round = round`。SWF 帧 27 把 round clamp 到 1–5 再让 `nummc.gotoAndPlay("r"+round)`。
5. `gotoAndStop(round < 5 ? "start" : "start_final")`。第 5 回合（先到 2 胜的 BO3 里少见；生存/组队回合能到 5+）走 FINAL。
6. 听 `"fight"` → `onFight` 只 `removeEventListener`。帧 58 派这个，本类不当闸。
7. 若有 `finishBack`，听 `"complete"`（帧 88）再回调。`GameStartCtrl` 用它清 `_uiPlaying`。

`params` 形参对齐 `IGameUI.showStart(Function, Object)`，本实现丢弃。

### `showEnd`（L290–311）

`param1`=完成回调，`param2`=`{winner, loser, drawGame?}`。

1. `_endParam = param2 || {}`，再挂 `finishBack`。
2. `_drawGame = param2 ? param2.drawGame : false`。`param2` 刚被空对象兜底，但这里又用原 `param2`——若调用方传 `null`，`_endParam={}` 而 `_drawGame=false`。`GameEndCtrl` 总传对象。
3. `_renderEnd=true`，`_playOver=false`。
4. `gameRunData.isTimerOver` → `playTimeOver()`，否则 `playKO(param2.loser)`（平局 `drawGame` 且超时才走 timeover；非超时平局本包不存在）。

`GameEndCtrl` 同时 `_holdFrame=10*FPS_GAME`，UI 回调把 hold 清 0 以提前结束等待。

### `playKO`（L313–352）

闭包 `playKO2`：`startKOmc.y=0`，`gotoAndStop("ko")`，听 `"complete"`→`koBack`，`snd_ko_bs` 或 `snd_ko`，两条气条 `fadOut()`。

立即：

1. `_showWinnerDelay=0`。
2. `EffectCtrl.I.freezeEnabled=false`：挡住 KO 期间的 hit-stop，避免再 `GameCtrl.pause` 套娃。
3. `_isSlowDown=false`。
4. 有 `loser`：`doEffectById("hit_end", loser.x, loser.y)`、`shine(0xFFFFFF, 0.5)`、`cameraFocusOne(loser.getDisplay())`（zoom 3.5）。
5. `GameCtrl.I.pause()`：**顿帧**（`_isRenderGame=false`），不是菜单。镜头/特效/本 UI `render` 仍走。
6. 扫双方 `currentFighter`：任一方 `actionState==12||13`（必杀/超必）→ `bsKO=true`，`BGEffect("kobg", 2)`。
7. `shake(5, 0, 1.5)`：X 振幅 5、Y 0、时长 **1.5ms**。`param3<=0` 才会被 `EffectCtrl` 收成 500；1.5 原样用，lose 分母接近 0 → `ceil` 后至少 1，一两拍动画帧就抖完。?
8. `snd_over_hit`。
9. `setTimeout(playKO2, 500)`：真实 500ms 后才出 KO 大字。顿帧不影响 timeout。

无 loser（? 正常 KO 总有）则没有 hit_end / 特写，仍 pause + shake。

### `koBack`（L354–361）

`freezeEnabled=true`（写了**两遍**），卸 `"complete"`，`_playOver=true`，`GameCtrl.I.resume()` 恢复物理。之后 `renderEnd` 才能看击飞。

### `playTimeOver`（L363–370）

**不** `pause()`、**不**关 `freezeEnabled`。`startKOmc.y=0`，`gotoAndStop("timeover")`，听 `timeoverBack`，气条 fadOut。超时路径角色仍按逻辑帧落地（`GameCtrl.timeover` 已 `actionEnable=false`）。

### `timeoverBack`（L372–385）

`freezeEnabled=true`（超时路径本来就没关）。卸监听。

- `_drawGame`：`playDrawGame()`，`_showWinnerDelay=0`（**不**置 `_playOver`，`renderEnd` 一直早退，不切胜者）。
- 否则：`_playOver=true`，`_showWinnerDelay = 1 * FPS_GAME`（约 1 秒后出胜者，**不等** `actionState==30`）。超时败者可能还站着。

### `playDrawGame`（L387–392）

`gotoAndStop("drawgame")`，听 `drawGameBack`。

### `drawGameBack`（L394–401）

卸监听。`_endParam.finishBack != null` 才调。不改 `_renderEnd` / `_endParam`（随后 `GameEndCtrl` `clearStartAndEnd`）。

### `renderEnd`（L403–471）—— KO 后逻辑

每逻辑帧。闸：`!_playOver` 或 `!_endParam` return。

**已有 delay（`_showWinnerDelay>0`）**：减 1。到 ≤0：

1. `_endParam.winner` 有则 `cameraFocusOne(winner)`、`showWinner(winner)`（无 callback）。
2. `GameMode.isSingleMode()`（20/21/22）才 `showWins(winner, getWins(winner))`。组队/生存不亮灯。
3. `_endParam` 仍在则 **直接** `_endParam.finishBack()`——**不**判 null。`GameEndCtrl` 总有 cb。
4. `_renderEnd=false`，`_endParam=null`。
5. `return`（即使 delay 刚到 0 也不掉到下面的击飞逻辑）。

**delay==0 且尚未启动**：看 `_endParam.loser`。

- `actionState==22`（`HURT_FLYING`）且尚未慢动作：`_isSlowDown=true`，`EffectCtrl.slowDown(2, 0)`（rate 2、时长 0=不自动恢复），记下 `_flyTimer=getTimer()`。
- `actionState==30`（`DEAD`）：
  - 若曾经慢动作：飞了不到 2000ms → delay=`2*FPS_GAME`，否则 `1*FPS_GAME`。然后 `slowDownResume()`。
  - 否则（没经过 22，例如抓死/原地倒）：delay=`2*FPS_GAME`，仍 `slowDownResume()`（没 slow 过也 harmless）。

超时非平局在 `timeoverBack` 已设 delay=1s，本段 loser 逻辑会被 delay 分支抢先，**不再**等 DEAD。KO 路径 delay 一直为 0 直到落地，所以会等 22→30。

败者若永远不到 30（? 死亡动画卡死），`_playOver` 已 true 但 delay 起不来，`GameEndCtrl` 的 10s hold 到期后仍会 `clearStartAndEnd` / 进 win pose——UI 可能没播 winner。?

### `clearStartAndEnd`（L473–476）

`startKOmc.gotoAndStop(1)`（SWF 帧 1 `stop` 并复位 `$round=1` 等）。`GameEndCtrl` 在 cinema 收尾调用。不卸还在的 COMPLETE 监听（正常已卸）。

### `pause`（L478–486）

懒 `new PauseDialog()` 并 `ui.addChild`。每次 `show()`：visible、开键、箭头落在 CONTINUE（index 2）。`GameCtrl.pause(true)` 在 intro/outro 期间会推迟到 intro 结束（`_gameStartAndPause`），所以开场 FIGHT 播着时 ESC 先不弹框。

### `resume`（L488–495）

无 dialog 则 return。否则 `hide()`（藏、关键、`GameUI.closeConfrim`）。CONTINUE 按钮走 `GameCtrl.resume(true)` → 这里。

### `showWinner`（L497–526）

`startKOmc.y=30`。`teamid = winner.team.id`，无 winner/team 当 1。

- team 1：`$winnerX=30`（左）。
- team 2：`$winnerX=546`（右）。
- 其它 team id：不写 `$winnerX`，沿用 SWF 默认 30。

`$perfect = winner.hp >= winner.hpMax`。超时残留满血也算 perfect。`gotoAndStop("winner")`。SWF 帧 200/201 把 `winnermc` 挪到 `$winnerX/$winnerY` 并设 `isPerfect`。

`back` 非 null 才听 `"complete"`。`renderEnd` 不传 back——胜者条播完不经这里通知 `GameEndCtrl`（对方靠 10s hold / UI 里 `showEnd` 的 finishBack 已在 delay 归零时调过，**winner MC 可能还在播**）。?

### `renderPlayerPosUI`（L528–554）

`param1`=当前 zoom。

- `zoom > 1.8`：两个标记 `visible=false` 后 return。近景不需要屏外箭头。反编译 `_temp_1` 是连续赋值的临时名。
- 否则取 `p1FighterGroup.currentFighter` / P2，有则 `getPlayerPos` 写 x/y 并 `visible=true`。
- 某侧 current 为 null（组队换人间隙）不会把该侧 visible 设回 false。?

### `getPlayerPos`（L556–576）

`GameState.getGameSpriteGlobalPosition(sprite, 0, -50)`：屏幕坐标，Y 偏 -50（标在头顶）。公式：`((-scroll.x + x + ox) * zoom, (-scroll.y + y + oy) * zoom)`。

钳制：

- `x < 20` → 20；`x > GAME_SIZE.x-20`（780）→ 780。
- `y < 60` → 60（避开顶 HUD）。
- `y > GAME_SIZE.y-5`（595）→ **`x = GAME_SIZE.x-5`（795）**。明显笔误，本应改 y。角色飞出屏幕底部时标记会跳到右缘。?

返回同一 `Point` 对象（调用方立刻读 x/y，P1/P2 顺序调用会覆盖，但每侧读完就写进 MC，安全）。
