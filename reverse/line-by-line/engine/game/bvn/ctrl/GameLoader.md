# `GameLoader` — 按 id 加载角色 / 辅助 / 地图 SWF 并包装成运行时对象

一句话目的：选人结束后的加载队列执行器。查 `FighterModel`/`AssisterModel`/`MapModel` 得到 `fileUrl`，经 `AssetManager.loadSWF` 取出 content，包装为 `FighterMain` / `Assister` / `MapMain`。Loader 留在 `_loaderCache` 以免被回收。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameLoader.as`（184 行）

## Callers / callees

- **Callers**：几乎只有 `LoadingState` 的 `_loadQueue`：
  - `func: GameLoader.loadFighter`，params = `[id, cacheFighter, loadFail, loadProcess, o.runobj]`
  - `func: GameLoader.loadAssister`，params 类似，成功写入 `GameCtrl.I.gameRunData[group][id]`
  - `func: GameLoader.loadMap`，成功把 `MapMain` 赋给 `gameRunData.map`，并可能追加地图 BGM
  - `GameCtrl.destory`：若没有 continueLoser（非整场续关），`GameLoader.dispose()` 卸所有 SWF。
- **Callees**：`FighterModel.I.getFighter`、`AssisterModel.I.getAssister`、`MapModel.I.getMap`、`AssetManager.I.loadSWF`、`Debugger.log`、`FighterMain`/`Assister`/`MapMain` 构造。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `customBackParam` | 成功回调第二实参。`LoadingState` 传 `o.runobj`（含 `group`/`id` 等），用来把实例塞进 p1/p2 槽。 |
| `_loaderCache` | 已完成的 `Loader` 向量。content 挂在 Loader 上，unload 前 DisplayObject 保持活。 |
| `loadIOError` 文案 | 不论角色还是地图，fail 字符串都是 `"加载场景文件错误"`。 |
| `getFighter`/`getAssister` 第二参 `true` | 两个 Model 方法都 **忽略** 该 Boolean，只是 `_obj[id]`。 |

## 逐行说明

### 静态字段（L20）

`_loaderCache: Vector.<Loader>`。一场战斗期间角色+辅助+地图的 Loader 全堆在这。续关（`continueLoser != null`）时 `GameCtrl.destory` **不** dispose，SWF 留下给下一局；真正回菜单/整场结束才卸。

### 空构造（L22–25）

全静态。从未被 `new`（grep 无实例化）。

### `loadFighter`（L27–62）

签名：`(fighterId, back, fail=null, process=null, customBackParam=null)`。

1. 闭包 `loadComplete(DisplayObject)`：`new FighterMain(mc as MovieClip)`，`data = fv`，再按有无 `customBackParam` 调 `back(fighter)` 或 `back(fighter, customBackParam)`，然后 `back=null`（防二次 complete）。
2. `fv = FighterModel.I.getFighter(fighterId, true)`。没有 VO：`trace("GameLoader.loadFighter :: ID不存在:", id)`，`fail("角色ID错误")`，return。**不会**去 loadSWF。
3. `loadSWF(fv.fileUrl, loadComplete, fail, process)`。`fileUrl` 来自 fighter.xml 的 `file.@url`。

`MovieClip` 强转：若 ZIP 里该文件不是 MC（或 loadBytes 失败成空），`FighterMain` 会拿到 null/非 MC，后续时间轴逻辑会炸。本函数不检查 `content is MovieClip`。

`LoadingState` 的成功回调用 `customBackParam`（`o.runobj`）把 fighter 缓存到 p1/p2 指定槽，再 `loadNext()`。

### `loadAssister`（L64–99）

与 `loadFighter` 同构，差别：

- `new Assister(mc as MovieClip)`。
- VO 来自 `AssisterModel.I.getAssister(fighterId, true)`（辅助表，不是角色表）。`LoadingState` 文案里有时用 `FighterModel.I.getFighter(o.id)` 取 **显示名**，那是 UI 用，加载仍走 AssisterModel。
- fail 文案同样 `"角色ID错误"`。
- 参数名叫 `fighterId`，实际是辅助 id。

### `loadMap`（L101–136）

同构：

- `new MapMain(content as Sprite)`（地图根是 Sprite，不一定是 MovieClip）。
- `mv = MapModel.I.getMap(mapId)`，无第二参。
- fail：`"场景ID错误"`。
- `data = mv`。

`LoadingState` 的 map 回调 **不传** `customBackParam`，且没把 `loadProcess` 放进 params（地图那条 queue 只有 id/success/fail），所以地图加载无进度回调。

### `dispose`（L138–154）

`while (_loaderCache.length) { shift; unloadAndStop(true) }`。`unloadAndStop(true)` 停时间轴并试图卸声音。失败（有的播放器/Ruffle 对 `unloadAndStop` 不完整）catch 后 `trace("GameLoader ::", e)` 再 `unload()`。

不清空 content 引用、不 null 已构造的 FighterMain/MapMain。调用方必须先停用这些对象（`GameCtrl.destory` 里 `destoryFighters` 在 dispose 之前）。若仍有 DisplayObject 在舞台上，unload 后会变空壳。

### `loadSWF`（L156–180）—— 私有共用路径

签名：`(url, back, fail=null, process=null)`。注意这里 `back` 期望 `(Loader) → void`，与三个 public 的 `loadComplete(DisplayObject)` 不同。

内部：

1. `loadComplete(Loader)`：`back(loader.content)` 再 `back=null`，然后 **`_loaderCache.push(loader)`**。先回调再缓存：若 `back` 抛错，Loader 不会进 cache，可能被 GC 导致 content 消失。
2. `loadIOError`：`Debugger.log("GameLoader.loadSWF :: 找不到文件:", url)`，`fail("加载场景文件错误")`。角色/辅助失败也用「场景」二字。
3. `AssetManager.I.loadSWF(url, loadComplete, loadIOError, process)`。

ZIP 路径：`ZipAssetLoader.loadSwf` 从包内 `getLoader`；没有该文件则下一帧 `fail`。HTTP 路径：真正 404 才 ioError。

`process` 透传到 AssetManager。`LoadingState.loadProcess` 用它刷条。

没有 securityError / 超时。成功后不 `disposeAsset`：角色 SWF 的 Loader 必须留下，和 `loadGraphics` 里 effect.swf「登记 domain 后 unload」策略相反。
