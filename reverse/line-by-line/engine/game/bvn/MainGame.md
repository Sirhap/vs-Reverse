# `MainGame` — 引擎门面：初始化与状态跳转

一句话目的：壳交权后的游戏单例。`initlize` 拉 UI 资源、渲染、输入、存档，再经 `KyoStageCtrl` 切 Logo/菜单/选人/战斗等状态。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/MainGame.as`（222 行）

## Callers / callees

- **Callers**：`bleachvsnaruto.buildGame` 做 `new MainGame().initlize(this, stage, …)`，成功后 `etHandler` 调 `goLogo()`。各 state / `MenuBtnGroup` / `PauseDialog` / `GameCtrl` 经 `MainGame.I` 调 `go*`。`Ctrler4399` 读 `stageCtrl.currentStage`。`GameInputer` 用 `getFPS()`。
- **Callees**：`ResUtils.I.initalize`、`GameRender`、`GameInputer`、`GameData`、`KyoStageCtrl.goStage`、本批全部 `state.*`、`GameCtrl.I.startGame`、`GameInterface.instance`（moreGames / submitScore / showRank）、`EffectModel.I.initlize`、`GameLoger`、`GameConfig`、`SelectFighterStage.AUTO_FINISH`、`LoadingState.AUTO_START_GAME`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `initlize` | 原拼写，不是 initialize |
| `I` | 单例；构造里赋值，无双重检查 |
| `stageCtrl` | 静态 `KyoStageCtrl`，状态机真正执行者 |
| `VERSION` | 当前反编译现场是 `V3.3-REV`。SWF ABC 字符串池仍是 `V3.3`（见 `BVN-REVERSE.md`）。改 `.as` 不会写回 SWF。 |

`goGameOver` 在 `decompiled/main/scripts` 内 **无调用方**。对局失败走 `GameCtrl` → `goContinue()`。

## 逐行说明

### 包与 import（L1–27）

`net.play5d.game.bvn`。导入全部本批 state、`GameRender`、`GameCtrl`、`GameData`、`EffectModel`、`GameInputer`、`GameInterface`、`ResUtils`、`GameLoger`、`KyoStageCtrl`。不导入壳包。

### 静态字段（L32–40）

- `VERSION = "V3.3-REV"` / `VERSION_DATE = "2019.3.32"`：展示用。日期 `3.32` 不是合法日历，是作者戳。
- `UPDATE_INFO`：可空。`bleachvsnaruto.buildGame` 在出厂三项配置未改时写入 3.3 更新长文；`MenuState` 首次运行弹 `GameUI.alert`。
- `stageCtrl`：`initlize` 成功后才非空。此前调 `go*` 会 NPE。
- `I`：最新一次 `new MainGame()`。正常路径只 new 一次。

### 实例字段（L42–46）

`_rootSprite` = 壳挂上的 `bleachvsnaruto`；`_stage` = 主舞台；`_fps` 默认 60，与 `Stage.frameRate` 同步。

### 构造（L48–52）

`I = this`。无防护；再 new 会覆盖单例。

### `root` / `stage` getter（L54–62）

给 UI / 平台接口取容器和舞台。`initlize` 完成前为 null。

### `initlize`（L64–103）—— 引擎启动

签名：`(root:Sprite, stage:Stage, initBack, initFail)`。`bleachvsnaruto` 传入自身、`STAGE`、`initBackHandler`、空的 `initFailHandler`。

闭包顺序：

1. **`ResUtils.I.initalize(resInitBack, initFail)`**（L102）：先解 8 个内嵌 UI SWF Class（title/select/fight/setting/loading/common/howtoplay/gameover）。失败走 `initFail`（壳里是空函数）。
2. **`resInitBack`**（L70–93）：
   - 记下 root/stage。
   - `GameRender.initlize(stage)`：挂 `ENTER_FRAME`。
   - `GameInputer.initlize(_stage)`：键位监听。
   - `GameData.I.loadData()`：读本地存档（`bvn3.01`）。
   - `GameData.I.config.applyConfig()`：画质 → `setGameFps` / shine / smoothing / 音量。
   - `GameInputer.updateConfig()`：把存档键位灌进 P1/P2。
   - `root.scrollRect = (0,0,GAME_SIZE)`：裁 800×600，超出不画。
   - `stageCtrl = new KyoStageCtrl(_rootSprite)`。
   - `goStage(new GameLoadingState())` 再 `_loc1_.loadGame(loadGameBack, initFail)`：preload.xml → fighter/assist/select/map/mission XML。这是 **启动加载**，不是选人后的 `LoadingState`。
3. **`loadGameBack`**（L94–101）：`EffectModel.I.initlize()` 从 effect.swf 建特效表，然后调 `initBack`。壳在这里挂 `enterFrame`，等到 `isInTop` 再 `goLogo()`。

注意：`initlize` **不**自动 `goLogo`。壳 `etHandler` 才切 Logo。本函数结束时当前 stage 仍是 `GameLoadingState`（加载完后 Kyo 不一定自动卸，取决于 `goLogo` 的 `goStage`）。

### `resetDefault`（L105–111）

把对局/选人自动化开关打回默认：

- `GameCtrl.I.autoEndRoundAble = true`
- `GameCtrl.I.autoStartAble = true`
- `SelectFighterStage.AUTO_FINISH = true`
- `LoadingState.AUTO_START_GAME = true`

只在 `goMenu` 调用。从暂停回标题会清掉「手动控回合」之类的临时改动。

### `getFPS` / `setFPS`（L113–122）

`getFPS` 返回内部 `_fps`，不是 `stage.frameRate` 实读。`setFPS` 两者一起改。菜单态普遍 30；`goGame` 用 `GameConfig.FPS_GAME`（画质 low=30，其余 60）。

### `goLogo`（L124–128）

`goStage(new LogoState())` + FPS 30。壳 `etHandler` 唯一调用点。Logo 播完自己 `goMenu`。

### `goMenu`（L130–136）

1. 向舞台派 `DataEvent("5d_message", ["go_menu_stage"])`（`GameInterfaceManager` 在 localhost 听这个通道）。
2. `resetDefault()`。
3. `MenuState`，FPS 30。

### `goHowToPlay`（L138–142）

`HowToPlayState`。`MenuBtnGroup` 在 `SHOW_HOW_TO_PLAY` 为真时，街机入口先到这里。

### `goSelect`（L144–148）

`SelectFighterStage`。菜单多数模式、`GameOverState` 继续后再选人都进这里。

### `loadGame`（L150–155）

`goStage(new LoadingState(), true)`：第二参 `sameChange=true`，允许与当前类相同仍切换（选人后再次 load 不会被 Kyo 的同名短路）。`SelectFighterStage.goLoadGame` 经 `StateCtrl.transIn` 进来。这是 **选人后** 拉角色/地图 SWF，不是启动 `GameLoadingState`。

### `goGame`（L157–163）

`new GameState()` → `goStage` → **立刻** `GameCtrl.I.startGame()` → FPS=`FPS_GAME`。`LoadingState` 完成后 `StateCtrl.transIn(MainGame.I.goGame)`。startGame 依赖 GameState 已 `build`（Kyo 的 `goStage` 里 build/addChild/afterBuild 是同步的，所以顺序安全）。

### `goOption`（L165–169）

`SettingState`。菜单「OPTION」。

### `goContinue`（L171–177）

`GameOverState.showContinue()` 再 `goStage`。`GameCtrl` 街机失败调用。

### `goGameOver`（L179–185）

`GameOverState.showGameOver()`。**本包无调用方**。继续次数耗尽时 `GameOverState` 内部自己切 gameover 画面，不经此方法。保留的公开 API。

### `goWinner`（L187–192）

`WinnerState`。`GameCtrl` 在 VS 胜出 / 非全通关时调用。

### `goCredits`（L194–198）

`CreditsState`。菜单制作组。

### `moreGames`（L200–203）

转 `GameInterface.instance.moreGames()`。本包实现是 `GameInterfaceManager`：localhost 派 `["more_games"]`。

### `goCongratulations`（L205–209）

`CongratulateState`。`GameCtrl` 闯关全通。

### `submitScore` / `showRank`（L211–219）

转平台接口。分数取 `GameData.I.score`。4399 路径见 `Ctrler4399` / `SubmitScoreBtn`；无 Hold 时基本是 `trace`。
