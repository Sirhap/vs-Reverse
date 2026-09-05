# `GameState` — 战斗舞台

一句话目的：`Istage` 战斗关。叠地图层 + 精灵层 + `GameUI`，持 `GameCamera`，给 `GameCtrl` 当舞台容器。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/GameState.as`（339 行）

## Callers / callees

- **Callers**：
  - `MainGame.goGame`（L157–163）：`new GameState()` → `stageCtrl.goStage` → **`GameCtrl.I.startGame()`** → `setFPS(FPS_GAME)`。`LoadingState` 转场回调进这里。
  - `KyoStageCtrl.goStage`：调 `build` / `afterBuild` / `destory`；`display` 即本 Sprite。
  - `GameCtrl`：`build` 里 `initlize(this)`；`doStartGame`/`buildGame` 调 `initFight`；`doBuildNextRound` 调 `resetFight`；`addGameSprite`/`removeGameSprite` 转发到本类；每帧 `gameState.render()`（`GameCtrl.render` L518）；`slow`/`slowResume` 改 `camera.tweenSpd`。
  - `GameStartCtrl`：开场 intro 调 `cameraFocusOne` / `cameraResume` / `camera.updateNow`。
  - `EffectCtrl`：`initlize(this,_playerLayer)`；必杀/卍解 `cameraFocusOne`/`cameraResume`、`setVisibleByClass`、`getMap`。
  - `GameMainLogicCtrler.initlize`：拿本实例后每帧 `getGameSprites()` 扫碰撞。
  - `MapMain`：`gameState` 回指，前景光学透明用 `getGameSprites()`。
  - `ui.fight.FightUI`（**ui 包，只作 callee 引用**）：KO/胜者特写 `cameraFocusOne`；hits 数字用 `getGameSpriteGlobalPosition`。
- **Callees**：`GameCtrl.I.initlize`/`destory`；`EffectCtrl.I.initlize`/`destory`；`GameUI`（ui：`initFight`/`render`/`destory`/`getUIDisplay`，内部再 new `FightUI`）；`GameCamera`；`MapMain`；`GameLogic.resetFighterHP`/`setMessionEnemyAttack`；`GameMode.isAcrade`；`GameConfig`；`IGameSprite`；`FighterMain`（**fighter 包，只作站位/朝向/idle**）。

## 命名备注

- 保留反编译拼写：`destory`、`initlize`（全引擎如此，不是 destroy/initialize）。
- `GameConfig.CAMERA_TWEEN_SPD = 2.5` 本文件**没用常量名**，三处都写死 `2.5 / GameConfig.SPEED_PLUS_DEFAULT`。60fps 时 `SPEED_PLUS_DEFAULT = 30/60 = 0.5` → tween = **5**。`GameCamera.tweenSpd` 类型是 `int`，赋值会截断。
- `GameCtrl.slowResume` 把 `tweenSpd` 设回字面 `2.5`（int→2），与本类 init 的 `/ SPEED_PLUS_DEFAULT` **不一致**。
- `Istage.destory(callback)`：本类**不调用** `param1`。`KyoStageCtrl` 默认 `destory()` 后立刻拆 display，不走 `buildAfterDestory`。

## 与 `GameCtrl.startGame` 的衔接

```
LoadingState.transIn(MainGame.goGame)
  → new GameState + goStage
       KyoStageCtrl: GameState.build()          // L128：绑 GameCtrl / EffectCtrl，new GameUI
                    addChild(GameState)         // display = this
                    afterBuild()                // 空
  → GameCtrl.I.startGame()
       autoStartAble 门
       doStartGame: gameRunData.reset / initTeam / buildGame / GAME_START / GameRender.add
       buildGame:
         练习模式 TrainingCtrler
         addFighter(P1 key, P2 key 或 FighterAICtrl)  // 内部 addGameSprite → 本类
         map.initlize()                             // 解析 p1/p2/map/front/bg
         gameState.initFight(p1Group, p2Group, map) // 本类：叠层、站位、镜头、FightUI
         GameLogic.initGameLogic(map, camera)
         GameMainLogicCtrler.initlize(gameState, teamMap, map)
         练习：立刻 actionEnable + FightUI.fadIn
         其它：GameStartCtrl.start1v1（镜头特写 intro）
```

下一回合 **不** 重建 `GameState`：`GameCtrl.doBuildNextRound` → `resetFight`。

Arcade 结束：`GameCtrl.fightFinish` 按胜负 `goWinner` / `goContinue` / `goCongratulations`，`goStage` 会 `destory` 本实例（连带 `GameCtrl.destory`）。

## 逐行说明

### 字段（L25–37）

- `_gameLayer`：镜头作用对象（`GameCamera` 对它设 `scrollRect` + `scale`）。战斗地图/角色/前景都挂在这下面。
- `_playerLayer`：`IGameSprite.getDisplay()` 的父级；也是 `EffectCtrl` 的特效层。
- `_gameSprites`：逻辑列表，与显示列表分开。`GameMainLogicCtrler` / `MapMain.renderOptical` 都扫它。
- `_map`：当前 `MapMain`。
- `camera`：公开，供 `GameCtrl`/`GameLogic`/`GameStartCtrl` 直接改。
- `_cameraFocus`：双人跟随数组，存 **DisplayObject**（`FighterMain.getDisplay()`），不是精灵接口。`cameraResume` 用它还原。
- `gameUI`：战斗 HUD 门面（ui 包）。

### 构造（L39–45）

`super()` 后关 `_gameLayer` 的 `mouseEnabled`/`mouseChildren`。镜头层不吃鼠标；UI 在 `_gameLayer` 外面。`_temp_4` 是反编译对连续赋值的临时别名。

### `gameLayer` getter（L47–50）

给外部拿镜头层。本包未见其它 `.as` 读它（`GameCamera` 构造直接吃 `_gameLayer`）。

### `getMap`（L52–55）

`EffectCtrl` 必杀时 `getMap().setVisible(false)` 藏地图。

### `setVisibleByClass`（L57–70）

按**运行时类**开关精灵显示。对每个 `_gameSprites`：`getQualifiedClassName` → `getDefinitionByName` → 与 `param1` 比引用。命中则 `getDisplay().visible = param2`。

`param2` 类型是 `*`，实参是 Boolean。`EffectCtrl` 必杀/卍解用来藏 `BitmapFilterView`（残影滤镜精灵）。用 Class 比较而不是 `is`，避免接口/子类误伤。

### `display`（L72–75）

`Istage`：舞台控制器 addChild 的就是本 Sprite。

### `getGameSpriteGlobalPosition`（L77–82）

世界坐标 → 屏幕坐标。`camera.getZoom(true)` 取**缓动中的** `_stageScale`；`getScreenRect(true)` 取缓动中的 `_rect`。

公式：`((-rect.x + sprite.x + ox) * zoom, (-rect.y + sprite.y + oy) * zoom)`。

`scrollRect` 的 `(x,y)` 是可见区左上角世界坐标，所以要减。`FightUI` 调时 `oy = -50`，hits 数字浮在角色头顶。

### `getGameSprites`（L84–87）

返回内部 Vector **引用**（可被外部改，但调用方只读遍历）。

### `addGameSprite`（L89–98）

1. `indexOf != -1` 则忽略（防双加）。
2. push 逻辑列表。
3. `_playerLayer.addChild(display)`（顶层）。
4. `setVolume(GameData.I.config.soundVolume)`。

`GameCtrl.addGameSprite(teamId, sprite, at=-1)` 在此之后还绑 `TeamVO`。子弹/辅助/特效都走这条。

### `addGameSpriteAt`（L100–109）

同 `addGameSprite`，但 `addChildAt(..., param2)`。`GameCtrl.addGameSprite(..., param3)` 在 `param3 != -1` 时走这里。`EffectCtrl` 有 `addGameSprite(0, filterView, 0)` 把残影插到最底。

逻辑列表仍 `push` 到末尾，**z-order 与 Vector 下标无关**。

### `removeGameSprite`（L111–126）

`indexOf` 找不到直接 return。`splice` 后 `try/catch` 拆 display——精灵 display 可能已被别的路径摘掉。`GameCtrl.removeGameSprite` 还会 `team.removeChild` + `sprite.destory`。

### `build`（L128–133）—— Istage，`goStage` 时、`startGame` 之前

```
GameCtrl.I.initlize(this)           // 记 gameState，new FighterEventCtrl，算动画间隔
EffectCtrl.I.initlize(this, _playerLayer)
gameUI = new GameUI()               // 此时还没有 FightUI；initFight 才建
```

**不**在这里 `initFight`：地图/角色还在 `GameCtrl.buildGame` 里 `addFighter` + `map.initlize`。

### `initFight`（L135–193）—— 开局叠层 + 站位 + 镜头 + HUD

参数：P1/P2 的 `GameRunFighterGroup`、已 `initlize` 的 `MapMain`。

**层顺序（底→顶）** L139–156：

| 父 | 子 | 来源 |
|----|----|------|
| `this` | `_map.bgLayer` | 地图 `bg` 画成 Bitmap，**不受镜头** |
| `this` | `_gameLayer` | 镜头目标 |
| `_gameLayer` | `mapLayer` | 地面/场景 MC |
| `_gameLayer` | `_playerLayer` | 角色/子弹/特效 |
| `_gameLayer` | `frontFixLayer` | 固定前景 |
| `_gameLayer` | `frontLayer` | 视差前景（`MapMain.render` 跟镜头） |
| `this` | `gameUI.getUIDisplay()` | HUD，不受镜头 |

`_map.gameState = this` 给前景光学检测回指。

**P1**（L159–169）：`resetFighterHP` → 放到 `_map.p1pos`，`direct = 1`（朝右），`updatePosition`，display 进 `_cameraFocus`。

**P2**（L171–182）：同样回血。Arcade（`GameMode.isAcrade`：模式 20/10/30）再 `setMessionEnemyAttack`（关卡 XML 攻倍率）。`p2pos`，`direct = -1`（朝左）。

角色 display 此时应已在 `_playerLayer`（`addFighter` 先于 `initFight`）。本函数只改坐标/镜头/UI，不再 `addGameSprite`。

**镜头 + UI**（L183–190）：有 `mapLayer` 才继续。`_loc6_ = Point(mapLayer.width, GAME_SIZE.y)` **算了不用**——`initCamera` 自己 `getStageSize()`，同值。然后 `camera.focus(_cameraFocus)` 双人跟随，`gameUI.initFight`（ui：确保 `FightUI` 并 `initlize` 两组），`addChild` HUD。

无 `mapLayer` → `throw "map is error! :: mapLayer is null!"`。

### `resetFight`（L195–222）—— 下一回合，不重建舞台

同样回血、拉回 p1/p2 出生点、朝向。比 `initFight` 多 `_loc4_.idle()` / `_loc3_.idle()`，清战斗动作。P2 **不再** `setMessionEnemyAttack`（关卡攻倍率已在开局设过）。

`_cameraFocus` 重建。`gameUI.initFight` 刷新 HUD。`cameraResume()` 取消特写，回到双人跟。

不碰层结构、不 `initCamera`（已存在会 throw）。

### `cameraFocusOne`（L224–229）

单目标：`camera.focus([obj])`，`setZoom(3.5)`（超过 `autoZoomMax=2.5` 的特写），`tweenSpd = 2.5 / SPEED_PLUS_DEFAULT`。

调用点：`GameStartCtrl` intro 台词；`EffectCtrl` 必杀/卍解；`FightUI` KO 看失败者、再看胜利者。`autoZoom` 在单目标时 `renderTwo` 不跑，zoom 停在 3.5 直到 `cameraResume`。

### `cameraResume`（L231–235）

`focus(_cameraFocus)` 恢复双人。只改 `tweenSpd`，**不** `setZoom`——双人 `autoZoom` 会在后续 `render` 把倍率拉回 1–2.5。特写 3.5 靠缓动降下来。

### `initCamera`（L237–259）私有，仅 `initFight` 一次

已有 `camera` → `throw "camera inited!"`（防二次 `initFight`）。

```
stageSize = map.getStageSize()          // (mapLayer.width, 600)
new GameCamera(_gameLayer, GAME_SIZE, stageSize, true)
  // true → 启用 _fbR 边界夹紧
focusX = focusY = true
offsetY = map.getMapBottomDistance()    // bottom - playerBottom，把脚底对齐画面
setStageBounds(Rectangle(0, -1000, w, h))  // 上沿放 1000px 余量给跳/镜头
autoZoom = true, min=1, max=2.5
tweenSpd = 2.5 / SPEED_PLUS_DEFAULT
setZoom(2)
setX(-(stageW - 350))                   // L253：`x/2*2` ≡ x；负值会被 _fbR 夹到 0
setY(-(map.bottom - 200))
updateNow()                             // 无缓动跳到该位，避免开场从 0,0 滑过来
```

`GAME_SIZE = (800,600)`。初始 zoom=2 是开场构图，随后 `focus` 双人 + autoZoom 接管。

### `render`（L261–276）—— 每帧，由 `GameCtrl.render` 在 `EffectCtrl.render` 之后、主逻辑之前

1. `camera.render()`：跟焦、autoZoom、写 `scrollRect`/`scale`。
2. `gameUI.render()`（ui：血条/气条/hits）。
3. 有 map+camera：`map.render(-rect.x, -rect.y, zoom(true))`。`MapMain` 用镜头位置做前景 0.1 视差，并按精灵重叠把前景 MC alpha 调到 0.5。

**不**遍历 `_gameSprites`——那是 `GameMainLogicCtrler.renderGameSprite`。

### `drawGameRect`（L278–287）/ `clearDrawGameRect`（L289–293）

调试画在 `_gameLayer.graphics`：默认红 `0xFF0000`、alpha 0.5。`param4` 为 true 先 `clear`。本包 **无调用点**（`Debugger` 或已剥掉的 hitbox 可视化）。画在镜头层上，会跟镜头走。

### `afterBuild`（L295–297）

空。`Istage` 要求；战斗真正开工在 `startGame`。

### `destory`（L299–335）—— 离开关时

**不调用** `param1`。顺序：

1. `this.removeChildren()`（bg / gameLayer / UI）。
2. while 弹出 `_gameSprites` 调 `removeGameSprite`（此时 display 可能已不在 `_playerLayer`，靠 try/catch）。
3. `_playerLayer` / `_gameLayer` `removeChildren` 后置 null。
4. `camera = null`（无 destory 方法）。
5. `gameUI.destory()`（ui）。
6. `EffectCtrl.I.destory()`。
7. **`GameCtrl.I.destory()`**：停 `GameRender`、清逻辑、拆 fighter 组。若 `continueLoser != null`（Arcade 败→续关）**保留**该角色、不 `GameLoader.dispose`，给 `GameOverState.addChar` 用。
8. `_map.destory()`。

续关路径：`fightFinish` 先写 `continueLoser` 再 `goContinue`；`goStage` 才进这里。故 destory 时 loser 已标记。

`GameOverState.destory` 会**再**调一次 `GameCtrl.I.destory()`（多数字段已 null，属幂等偏脏）。
