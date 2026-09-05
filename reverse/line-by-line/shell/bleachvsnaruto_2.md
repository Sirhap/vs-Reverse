# `bleachvsnaruto` — 壳交权后的游戏根 Sprite

一句话目的：GreenHD 体积门通过后 `addChild` 的真正入口；初始化 `MainGame`、ZIP 资源、4399 接口。

源文件：`decompiled/main/scripts/bleachvsnaruto_2.as`（136 行）。类名无 `_2`，那是 FFDec 为避免与文档类文件冲突加的后缀。

## Callers / callees

- **Callers**：`ɕ.ȑ.§ͥ§` 对 `§͗§ = bleachvsnaruto` 做 `FB.getInstanceBy(..., DisplayObject)` → `new bleachvsnaruto()`；`ȑ.§͵§` `addChild` 到 `ǵ.Ɂ`。壳 `ȑ.ʹ` 会尝试 `setHold(FB.serviceHold.hold)`。
- **Callees**：`GameInterfaceManager`、`Ctrler4399`、`ZipAssetLoader`、`AssetManager`、`MainGame`、`GameData`、`GameConfig`、`GameCtrl`、`SoundCtrl`、`GameUtils`。

## 符号对照（本文件）

本文件标识符已是明文，无 Unicode 方法名。

| 名 | 角色 |
|----|------|
| `_4399_function_gameList_id` | 4399 游戏列表接口 id |
| `_4399_function_score_id` | 4399 分数接口 id |
| `serviceHold` | 静态；默认 `null`；`setHold` 写入 |
| `STAGE` | 主舞台 |
| `UPDATE_SHOWED` | 3.3 更新说明只塞一次 |
| `_mainGame` | `MainGame` 实例 |
| `_zipAssetLoader` | 内嵌 ZIP 加载器 |
| `_isDeactived` | 失焦暂停标记 |
| `_defaultQuality` | `"medium"`，用来判断「还是出厂设置」 |

## 逐行说明

### 静态字段（L23–31）

- 两个 `_4399_function_*_id` 是编译进 ABC 的 4399 开放平台密钥串，不是运行时再拉。
- `serviceHold = null`：本地 / Ruffle 无 Hold 时排行榜等为空操作。
- `UPDATE_SHOWED`：防止每次 `buildGame` 都覆盖 `MainGame.UPDATE_INFO`。

### 构造（L41–51）

已在舞台则立刻 `initlize()`；否则听 `addedToStage`。壳 `addChild` 之后会走到这条。

### `setHold`（L54–57）

`serviceHold = param1`。壳在 `addChild` 前调用（`ȑ.ʹ` 用 `uts(setHold)` 反射）。无 Hold 时 `isReady` 为假，该调用被 `try/catch` 吃掉。

### `initlize`（L59–74）

1. 卸 `addedToStage`。
2. `STAGE = stage`；关默认右键菜单。
3. `GameInterface.instance = new GameInterfaceManager()`：本地 `LocalConnection.domain=="localhost"` 时听 `5d_message`。
4. `Ctrler4399.init()`：GAME_OVER / 提交分数按钮。
5. 出厂配置：画质 `medium`、AI=1、`keyInputMode=1`。
6. `GameConfig.MAP_LOGO_STATE = 1`：地图层保留实例名 `logo4399`。
7. `ZipAssetLoader` 交给 `AssetManager`（资源走内嵌 ZIP，不走 HTTP）。
8. `buildGame()`。

### `activeHandler`（L76–97）

- `deactivate`：首次失焦则 `GameCtrl.I.pause(true)` + 停 BGM。已失焦则 return。
- 其它（`activate`）：若曾失焦则恢复 BGM。**不**调用 `GameCtrl.I.pause(false)` —— 战斗暂停要靠游戏内暂停 UI 解。注册发生在 `etHandler` 里 `goLogo` 之后。

### `buildGame`（L99–112）

1. 根 Sprite 填 800×600 黑底（壳随后 `ǵ.ɀ()` 清的是**时间轴** graphics，不是这个）。
2. `new MainGame().initlize(this, stage, initBackHandler, initFailHandler)`。
3. 若还没展示过更新说明，且三项配置仍是出厂值：把 `MainGame.UPDATE_INFO` 写成 3.3 更新长文（碎蜂、半虚一护、神威卡卡西等）。`decompiled` 里 `MainGame.VERSION` 若写成 `V3.3-MOD` 是导出后改动，SWF ABC 仍是 `V3.3`。

### `initBackHandler`（L114–117）

资源/引擎 init 成功：挂 `enterFrame` → `etHandler`，等自己真正处于舞台顶层。

### `etHandler`（L119–128）

`GameUtils.isInTop(this)` 为真才继续（避免套在别的 Loader 里抢跑）：

1. 卸 enterFrame。
2. 向 `MainGame.I.stage` 派 `DataEvent("5d_message", JSON.stringify(["games_inited"]))`。
3. `_mainGame.goLogo()` → `LogoState`。
4. 舞台听 activate/deactivate。

### `initFailHandler`（L131–134）

空函数。`MainGame.initlize` 失败回调被吞掉；体积门在此之前已经过了，这里失败不会再走 `FB.showError`。
