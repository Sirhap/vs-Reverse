# `GameLoadingState` — 启动预载（preload → 配置 XML → 基础资源）

一句话目的：`MainGame.initlize` 的第一座舞台。先解 preload/zip，再 `GameData.loadConfig`（fighter→assist→select→map→mission），再 `AssetManager.loadBasic`，完了把控制权交回壳去 `goLogo`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/GameLoadingState.as`（125 行）

## Callers / callees

- **Callers**：`MainGame.initlize`：`ResUtils.initalize` 成功后 `new GameLoadingState()` → `stageCtrl.goStage(_loc1_)` → `_loc1_.loadGame(loadGameBack, initFail)`。`loadGameBack` 再 `EffectModel.I.initlize()` 并调壳 `initBack`；壳 `bleachvsnaruto_2.initBackHandler` 等置顶后 `goLogo()`。
- **Callees**：`ResUtils.I.loading` 的 `loading_cover_mc`（子级 `bar:loadingbar_mc`，其下 `bar.bar` scaleX + `bar.txt`）；`AssetManager.needPreLoad/loadPreLoad/loadBasic`；`GameData.loadConfig`；`Debugger.log`。
- **注意**：`MainGame.loadGame()` 进的是 **`LoadingState`**（选人后战前加载），不是本类。

## 命名备注

- `destory` / `MainGame.initlize` 拼写保留。
- 本类没有进度文字以外的失败 UI；失败只 `msg` + `_initFail`。壳 `initFailHandler` 本包为空。
- `loading_cover_mc.bar.bar` / `bar.txt`：进度条是内层 MC 的 `scaleX`。

## 逐行说明

### 字段 / 构造（L13–22）

- `_ui:loading_cover_mc`
- `_initBack` / `_initFail`：`loadGame` 传入的成功/失败回调。
- 构造空。

### `display`（L24–27）

返回 `_ui`。`goStage` 先 `build` 再 addChild，随后才 `loadGame`。

### `build`（L29–32）

只取出 `loading_cover_mc`。不开始加载。

### `loadGame`（L34–47）

保存回调。`AssetManager.I.needPreLoad()`：

- **真**：`loadPreLoad(loadPreloadBack, loadPreloadFail, loadPreloadProcess)`，文案「准备游戏资源」。
  - 本包 `ZipAssetLoader.needPreLoad()` **恒 true** → `ZipCtrler.init` 解嵌入 zip（进度 bytesLoaded/Total）。
  - 非 zip 的 `AssetLoader.needPreLoad()` 为 false。
- **假**：直接 `loadPreloadBack()`。

### `loadPreloadBack`（L49–53）

`GameData.I.loadConfig(loadConfigBack, loadConfigFail)`，文案「正在加载配置文件」。

`loadConfig` 链（`GameData.as`）：

1. `assets/config/fighter.xml` → `FighterModel.initByXML`
2. `assist.xml` → `AssisterModel.initByXML`
3. `select.xml` → `config.select_config.setByXML`
4. `map.xml` → `MapModel.initByXML`
5. `mission.xml` → `MessionModel.initByXML` 后 `back()`

失败文案在 `GameData` 内：人物 / 辅助 / 选人 / 地图 / 头卡。头卡失败 log 写「读取头卡数据出错」，但 `fail()` 字符串误写成「读取地图场景数据出错」。

### `loadPreloadFail`（L55–63）

`Debugger.log` + 文案「准备游戏资源失败!」；若有 `_initFail` 则传入原始 `param1`。

### `loadPreloadProcess`（L65–72）

进度夹到 ≤1，写 `_ui.bar.bar.scaleX`。不解压 zip 时不会走到。

### `loadConfigFail`（L74–82）

同上模式：「加载配置文件失败!」→ `_initFail(param1)`。

### `loadConfigBack`（L84–88）

`AssetManager.I.loadBasic(loadAssetBack, loadAssetProcess)`，文案「正在加载游戏资源」。

`loadBasic` 四步（step 0..3，count=4）：

0. 再读 `preload.xml` 收集 bgm/sound 路径，加载声音（type「声音」）
1. `assets/effect.swf`（「特效」）
2. 字体（「字体」）
3. 位图（「图片」）

然后 `initAssets()` 调成功回调。

### `loadAssetProcess`（L90–99）

`(progress, type, step, count)`。progress>1 则 `trace(type+"::进度超过100%")` 并夹到 1。条 `scaleX`；文案「正在加载{type}资源({step}/{count})」。

### `loadAssetBack`（L101–109）

调 `_initBack()` 后两边回调都置空，避免重复。

### `afterBuild`（L111–113）

空。

### `destory`（L115–117）

**空体**。不取消进行中的 loader。`goLogo` 时 `KyoStageCtrl` 仍会 `removeChild(_ui)`。不调 `param1`。

### `msg`（L119–122）

`_ui.bar.txt.text = param1`。
