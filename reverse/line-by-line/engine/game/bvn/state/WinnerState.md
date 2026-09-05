# `WinnerState` — Arcade 过关胜利立绘

一句话目的：Arcade **未通关** 时的 30fps 胜利页：胜者立绘 + 随机台词 + SCORE。Continue 推进下一关（`messionComplete` + `loadGame`）；不是制作组、也不是全通关祝贺。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/WinnerState.as`（290 行）

## Callers / callees

- **Callers**：
  - `MainGame.goWinner`（L187–191）：`new WinnerState()` → `goStage` → FPS 30。
  - **唯一游戏内入口** `GameCtrl.fightFinish`（L389–405）：Arcade 且 P1 胜，且 **`!MessionModel.I.missionAllComplete()`**。全通关走 `goCongratulations`（`CongratulateState`），**不进本页**。VS 模式走 `goSelect`，也不进。
  - `KyoStageCtrl`：`build` 里才 `createDisplayObject`（与 `GameOverState` 相反）。
- **Callees**：
  - `FighterModel` / `FighterVO.getRandSay` / `GameData.winnerId` / `p1Select.getSelectFighters`。
  - `AssetManager.getFighterFaceWin` / `getFont("font1")` / `getSound("winloop")`。
  - `ResUtils.I.loading` + `ResUtils.WINNER` = `winner_stg_mc`（胜利页打在 loading SWF 里，不是 gameover SWF）。
  - `SoundCtrl.BGM` / `playAssetSound("win")` / `sndSelect` / `sndConfrim`。
  - `GameInputer` / `GameRender`。
  - `GameInterface.instance.moreGames()`（4399 `showGameList` + `5d_message more_games`）。
  - `GameUI.confrim`（ui：确认框「BACK TITLE? / 返回到主菜单？」→ `MainGame.goMenu`）。
  - `StateCtrl.transIn` + `MessionModel.I.messionComplete` + `MainGame.I.loadGame`。
  - `CreditsState`：**本类不进制作组**。制作组在主菜单 `MenuBtnGroup` → `goCredits`。
  - `CongratulateState`：全通关由 `fightFinish` 直接去，绕过本类。

## 命名备注

- `GameData.I.winnerId` 在 `fightFinish` 里赋成 `p1.currentFighter.data.id`（当场胜出的那名，不一定是队首）。
- `destory` 时间轴标签也叫 `"destory"`（拼写贯穿）。
- `testFighterSays` 是调试器，**无调用点**。
- `goNext` 不管 Arcade/队模式：一律 `messionComplete` + `loadGame`。`messionComplete` 若已是最后一关会 `return`（但最后一关不会进本页）。

## 过关后去哪

```
fightFinish Arcade P1 胜
  missionAllComplete?  --yes→ goCongratulations（祝贺 + 可提交分）
                       --no-→ winnerId = 当场 P1 id
                              goWinner → 本类
                                btn_cont / MENU select
                                  transIn → messionComplete（关卡+1，Arcade 加过关分 5k/15k）
                                           loadGame → LoadingState 载下一关地图/敌
                                btn_exit → GameUI.confrim → goMenu
                                btn_more → 平台更多游戏
```

`messionComplete`（`MessionModel` L93–106）：`_curStageId++`，`initMession()`，Arcade 则 `GameLogic.addScoreByPassMission()`（队模式且仍是 fighter1：15000，否则 5000，再乘键位系数）。分数在**离开本页时**才加，页上 `SCORE` 是进页时的值。

## 逐行说明

### 字段（L32–40）

- `_ui:MovieClip`：`winner_stg_mc`。
- `_scoreText`：位图字体，挂 `scoremc`。
- `_winnerFaces`：最多 3 张胜利脸图（队模式 3 人）。
- `_winSay`：胜者随机台词，`|` 换行。
- `_bgmDelay`：`setTimeout` id，6.5s 后切循环 BGM。

### 构造（L42–45）

空。UI 在 `build`。

### `display`（L47–50）

`_ui`。`build` 前是 null——`KyoStageCtrl` 先 `build()` 再 `addChild(display)`，安全。

### `buildData`（L52–82）私有

```
winnerVO = FighterModel.getFighter(GameData.winnerId)
p1 所选 id 列表 → Vector.<FighterVO>
_winSay = winnerVO.getRandSay()     // KyoRandom 从 says[]
```

脸图：

- 单人：`[getFighterFaceWin(唯一)]`。
- 多人：先把 **winnerId 对应那张** 放到 `[0]`（大位 `f0`），再从 vector `splice` 掉她，其余按原选人顺序进 `f1`/`f2`。

`getFighterFaceWin`：读 `faceWinUrl` 位图，默认缩到 300×250；无 URL 返回 null（`build` 会 `fN.visible=false`）。

`indexOf(winnerVO)` 比的是 VO 引用。`getFighter` 每次 new/缓存 ? 若每次新对象，`indexOf` 可能 -1，随后 `getFighterFaceWin(_loc3_[-1])` 会坏。通常 `FighterModel` 按 id 单例，`?` 若模型缓存则安全。

### `initText`（L84–111）

闭包 `txtCompleteHandler`：等 `txtmc` 派 `"complete"`，再建 `TextField`（x=33, w=548, h=66，多行换行，不可鼠标）。`TextFormat`：黑体 SimHei、黑、18、居中、leading 5。`setText` 写入 `_winSay`，`addChild` 到 `txtmc`。

`txtmc` 当前没有则什么都不做（不重试，不像 GameOver 的 `setFrameOut`）。依赖时间轴稍后仍会派 complete——若 `initText` 时已播过 complete，台词永远不出现。`build` 在 `goto` 默认播放之前调 `initText` 并立刻 `addEventListener`，通常赶得上。

### `testFighterSays`（L113–164）—— 死代码

左/右方向键（keyCode 37/39，`switch (keyCode-37)` case 0/2）在 **全部角色全部台词** 里翻，`setText` + `trace(id)`。先压 winner 自己的 says，再 `getAllFighters()` 全量。挂在 `MainGame.I.stage` 的 `keyDown`，**无摘监听**。`destory` 也不管它。从未被调用。

### `setText`（L166–171）

`param2.split("|").join("\n")`。高度 = `textHeight+5`，垂直居中到 90px 盒子：`y = 10 + (90-height)/2`。覆盖 `initText` 里写死的 height=66。

### `build`（L173–215）—— Istage 入口

1. `buildData()`。
2. `BitmapFontText`：`"SCORE " + GameData.I.score`，自身宽高居中（0,0 为中心，放到 `scoremc` 上）。
3. `_ui = createDisplayObject(loading, WINNER)`。听 `"complete"` → `onUIPlayComplete`。
4. `_ui.scoremc.addChild(_scoreText)`。
5. `f0/f1/f2`：有脸图 `addChildAt(face, 0)`（垫底），否则 `visible=false`。槽位是时间轴实例名，队 3 人对应 3 框。
6. `BGM(null)` 停战斗曲；`playAssetSound("win")` 一次性胜利音。
7. `GameInputer.enabled = false`（动画未完不能按）。
8. `initText()`。
9. `_bgmDelay = setTimeout(..., 6500)`：6.5s 后 `BGM(winloop)`。`destory` 会 `clearTimeout`，中途离开不漏。

### `onUIPlayComplete`（L217–230）

摘 complete。派 `DataEvent("5d_message", JSON ["winner_show"])` 给网页壳。

`btns` 子 MC：`btn_more` / `btn_cont` / `btn_exit` 各挂 click + mouseOver → `btnHandler`。

`GameRender.add(render)`，`GameInputer.enabled = true`。此后键盘 MENU select = Continue。

### `render`（L232–238）

只查 `GameInputer.select("MENU")`（**无边沿参数 1**，可能每帧都真）。真则 `goNext()`。无左右切按钮——三个按钮只吃鼠标。键盘等于直接 Continue。

`select` 若按住连发，`goNext` 会多次 `transIn`。`goNext` 先 `GameInputer.enabled=false`，第二次应被挡住。`?` 取决于 `GameInputer.select` 在 disabled 后是否仍缓存。

### `btnHandler`（L240–260）

`mouseOver`：只 `sndSelect` return。click：

| 按钮 | 行为 |
|------|------|
| `btn_more` | `GameInterface.instance.moreGames()`（4399 游戏列表；不离开本页） |
| `btn_cont` | `goNext()` |
| `btn_exit` | `GameUI.confrim("BACK TITLE?","返回到主菜单？", MainGame.I.goMenu)` |

任何 click（含 more）都 `sndConfrim`。确认框否=关框留在本页。

### `goNext`（L262–270）—— 下一关

`GameInputer.enabled = false`。`StateCtrl.I.transIn(callback)` 黑场切入，完成后：

```
MessionModel.I.messionComplete()   // 关卡+1 + Arcade 过关分
MainGame.I.loadGame()              // LoadingState，sameChange=true
```

`loadGame`：`new LoadingState`，`goStage(_loc1_, true)`——同类也可换（`sameChange`），FPS 30。加载完再 `goGame` 进新的 `GameState`。

**不**在这里 `goCredits` / `goCongratulations`。

### `afterBuild`（L272–274）

空。网页消息在 UI complete，不在 afterBuild（对比 `GameOverState` 在 afterBuild 就派）。

### `destory`（L276–287）

1. `GameRender.remove(render)`。
2. `GameInputer.enabled = false`。
3. `clearTimeout(_bgmDelay)`。
4. 派 `["winner_end"]`。
5. `_ui.gotoAndStop("destory")` 后 `_ui=null`。

**不**摘 `btns` 监听（与 GameOver 不同）。**不** `GameCtrl.destory`——离开战斗时 `GameState.destory` 已经 destory 过，且 `continueLoser` 为空，资源已 `GameLoader.dispose`。下一关由 `loadGame` 重新加载。

**不调用** `param1`。
