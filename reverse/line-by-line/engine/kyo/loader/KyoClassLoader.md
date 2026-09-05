# `KyoClassLoader` — SWF ApplicationDomain 表

一句话目的：按 URL/id 存 `ApplicationDomain`，`getClass(name, swfId)` 取出导出类。`AssetManager` **不用 `load()`**，effect.swf 由 `IAssetLoader.loadSwf` 拉完再 `addSwf`。

源文件：`decompiled/main/scripts/net/play5d/kyo/loader/KyoClassLoader.as`（169 行）

## Callers / callees

- **Callers**：仅 `AssetManager`：
  - `_swfLoader = new KyoClassLoader()`
  - `loadGraphics` 完成：`_swfLoader.addSwf(curUrl, loader)`（`curUrl` 为 `"assets/effect.swf"`）
  - `getEffect(className)`：`_swfLoader.getClass(param1, "assets/effect.swf")` 再 `new`
- **Callees**：`Loader` / `ApplicationDomain` / `Dictionary`。
- **本包无调用**：`load()`、`loadedAmount`、进度/错误事件。角色/地图 SWF 走 `GameLoader` + `ResUtils`，不进本表。

## 逐行说明

### 字段（L16–28）

- `_classes`：`id → ApplicationDomain`。
- `_urls`：`load()` 队列。
- `_defaultId`：第一次成功加载的 id。`getClass` 第二参空时用它。
- `_loadedAmount` / `_loadLength`：进度。
- `_directory`：`Loader → url`，完成时反查 id。
- `_loading`：重入锁。

### `getClass`（L35–53）

`(className, swf=null)`。`swf ||= _defaultId`。域缺失抛 `Error(swf+"未加载!")`。`getDefinition` 失败再抛 `"在 "+swf+" 中找不到 "+className+" 的定义!"`。

`AssetManager.getEffect` 显式传 `"assets/effect.swf"`，不靠 default。ZIP 路径必须与 `addSwf` 的 id 逐字相同。

### `loadedAmount`（L55–58）

只读。`load()` 每取出一个 URL 就 `++`，在 COMPLETE 之前就加。本包无读。

### `load`（L60–78）

`param1` String 或 Array。已在 `_loading` 抛 `"不可以在没完成加载时继续调用此方法!"`。

设 `_urls`、`_loadLength`、`_loadedAmount=0`，**先 `loadNext()` 再 `_loading=true`**。若 `loadNext` 同步失败（空数组 return false）不会进 `checkComplete`，`_loading` 仍被设 true，之后再也 load 不了。? 本包不走 `load()`。

### `addSwf`（L80–93）

`(id, Loader)`。把 `contentLoaderInfo.applicationDomain` 存进 `_classes[id]`。然后 `unloadAndStop(true)`，旧 FP 没有该方法则 `unload()`。域在 unload 后仍可用（定义已在 ApplicationDomain）。

`AssetManager` 随后 `_assetLoader.dispose(curUrl)` 清 ZIP 缓存。

**不**设 `_defaultId`。只靠 `addSwf` 时 `getClass` 第二参不能空。

### `loadNext`（L95–110）

队列空 return false。否则 `++_loadedAmount`，`new Loader`，听 COMPLETE/PROGRESS/IO_ERROR，`shift` URL 去 load，`_directory[loader]=url`。return true。无并发上限，但 `checkComplete` 串行：完成才下一份。

### `removeLoader`（L112–127）

卸三监听，`unloadAndStop` / `unload`。不从 `_directory` 删除。

### `loadComplete`（L129–138）

取 url，`_defaultId ||= url`，存 domain，`removeLoader`，`checkComplete`。

### `loadProgress`（L140–143）

原样 `dispatchEvent(ProgressEvent)`。无聚合百分比。

### `loadError`（L145–156）

尽量读 `loaderInfo.loaderURL`（那是**加载器自己的 SWF 地址**，不是失败的子 URL）。`trace("loadError", url)`，dispatch IO_ERROR，`checkComplete`。

**不** `removeLoader`，监听还在。**不**从 `_directory` 清。失败项不会进 `_classes`，之后 `getClass` 抛「未加载」。

### `checkComplete`（L158–165）

`loadNext()==false` 则 `_loading=false`，dispatch `Event.COMPLETE`。空队列第一次 `load([])` 不会走到这里。
