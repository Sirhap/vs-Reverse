# ENGINE-NOTES — Batch A 交叉备忘

主索引：[`../engine/00-BATCH-A-INDEX.md`](../engine/00-BATCH-A-INDEX.md)。壳交接：[`../shell/00-INDEX.md`](../shell/00-INDEX.md)、[`../shell/bleachvsnaruto_2.md`](../shell/bleachvsnaruto_2.md)。

## 路径

源：`decompiled/main/scripts/net/play5d/game/bvn/...as`  
注：`reverse/line-by-line/engine/game/bvn/...md`（`net/play5d/` 之后镜像）

## 拼写（全文保留）

`initlize`、`destory`、`GameQuailty`、`GameLoger`、`ILoger`、`sndConfrim`、`confrim`、`specailSkill`、`getCreadits`、`Mession`（data 批）、`ACRADE`、`fuzhu`、`runScriect`、`initalize`（ResUtils）、`optoinKey`（ui 批）、`waiKai`。

## 壳 → 引擎接线

| 壳侧 | 引擎侧 |
|------|--------|
| `ɕ.ȑ` `new bleachvsnaruto` | 游戏根 Sprite |
| `bleachvsnaruto.initlize` | `ZipAssetLoader` + `MainGame.initlize` |
| `setHold` | `bleachvsnaruto.serviceHold`；无 Hold 则排行榜空操作 |
| `DataEvent("5d_message")` | `games_inited` / `go_menu_stage` / `select_*` / `loading_*` / `winner_*` / `more_games`。`GameInterfaceManager` 在 `LocalConnection.domain=="localhost"` 时听 |
| `MAP_LOGO_STATE=1` | `MapMain` 保留 `logo4399` |
| `UPDATE_INFO` | 出厂 quality/AI/keyInputMode 未改才写入；`MenuState` 首次弹 |

## 两个 Loading

- `GameLoadingState`：启动。preload.xml + 五份 XML。`MainGame.initlize` 里 `goStage`。
- `LoadingState`：选人后。`GameLoader` 拉 fighter/assister/map SWF。`MainGame.loadGame`。

## 时间倍率

`GameConfig.SPEED_PLUS_DEFAULT = 30 / FPS_GAME`。动画按 30fps 设计。`GameCtrl.slow` 改 `SPEED_PLUS`；`setGameFps` 会把它重置回 DEFAULT（切画质等于解除慢动作）。

`GameRender.isRender` 是 ENTER_FRAME 总闸，与 `GameCtrl.pause` 不是同一层。

## 画质字符串

`GameQuailty` 五个常量 **零引用**。真正生效的是 `ConfigVO.quality` 字面量，映射见 `GameQuailty.md`。

## 死/弱 API（Batch A）

- `MainGame.goGameOver`：无调用方。失败走 `goContinue`；次数耗尽由 `GameOverState` 内部切画面。
- `Debugger.initDebug` / `runScriect` / 五个 `*_ENABLED` 开关：本包除自身外零引用。
- `Debugger.log` 的 `trace.call(null, rest)` 会打印成数组。

## 单例

`MainGame.I`、`AssetManager.I`、`EffectCtrl.I`、`SoundCtrl.I`、`StateCtrl.I`、`GameCtrl.I`、`GameData.I`、`ResUtils.I`。构造即赋值，无锁。

## 不在本批

`data/**`（GameData/GameMode/ConfigVO/EffectModel…）、`fighter/**`、`ui/**`、`views/**`、`kyo/**`（`KyoStageCtrl` / `Istage`）。主链会点名它们，但不写逐行 md。
