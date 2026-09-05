# `AssetLoader` — 默认 HTTP/URL 资源加载器

一句话目的：`IAssetLoader` 的开发树实现。用 `URLRequest` 从 `assets/…` 拉 XML / SWF / 位图 / 声音。正式网页包在 `bleachvsnaruto.initlize` 里被 `ZipAssetLoader` 整份替换，本类通常不进运行路径。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/AssetLoader.as`（168 行）

## Callers / callees

- **Callers**：`AssetManager` 字段初始化 `new AssetLoader()`（L34）。之后 **没有任何** `new AssetLoader()`。`bleachvsnaruto_2.initlize` 调 `AssetManager.I.setAssetLoader(ZipAssetLoader)`，把默认实例换掉。`IAssetLoader` 的运行时调用方全走 `AssetManager` 转发，因此本类方法在正式包里不会被调到。
- **Callees**：`KyoURLoader.load`（XML 文本）、`flash.display.Loader` + `URLRequest`（SWF/位图）、`flash.media.Sound` + `URLRequest`（声音）。实现 `IAssetLoader`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `loadSwf` | 接口名；`AssetManager` 对外包装成 `loadSWF` |
| `back` / `fail` / `process` | 成功 / 失败 / 进度（0–1） |
| `loadCom` / `loadErr` | `loadSound` 里的完成/错误闭包，与 SWF 侧 `loadComplete`/`loadError` 命名不统一 |
| 事件字符串 | `"complete"` / `"ioError"` / `"progress"`，等于 `Event.COMPLETE` 等常量 |

与 `ZipAssetLoader` 的契约差：ZIP 版 `needPreLoad()==true`，`dispose` 会 `ZipCtrler.removeFile`，失败/成功都 `setFrameOut` 到下一帧；本类 `needPreLoad()==false`，`dispose`/`loadPreLoad` 空实现，回调同步发生在 loader 事件里。

## 逐行说明

### 包与 import（L1–10）

`net.play5d.game.bvn.ctrl`。`Loader`/`Event`/`IOErrorEvent`/`ProgressEvent`/`Sound`/`URLRequest`。接口 `IAssetLoader`。XML 走 kyo 的 `KyoURLoader`（`URLLoader` 包装，不是 `Loader`）。

### 空构造（L15–18）

无状态。每次 `load*` 自建 Loader/Sound，不缓存。

### `loadXML`（L20–32）

签名：`(url, back, fail=null)`。

1. 把参数收进闭包 `url`/`back`/`fail`（反编译常见手法，避免匿名函数捕获 paramN）。
2. `KyoURLoader.load(url, onText, fail)`。成功回调拿到的是 **String**，再 `new XML(param1)` 交给 `back`。
3. `back == null` 则丢弃结果。`fail` 原样传给 `KyoURLoader`（IO/security 失败时无参调用）。
4. **不**报进度。ZIP 实现同样无 XML 进度。

`GameData.loadConfig` 链式拉 `fighter.xml` → `assist.xml` → `select.xml` → `map.xml` → `mission.xml`，全经 `AssetManager.loadXML` → 本方法（开发树）或 ZIP。

### `loadSwf`（L34–72）

签名：`(url, back, fail=null, process=null)`。回调 `back(Loader)` —— **整颗 Loader**，不是 `content`。`GameLoader.loadSWF` / `AssetManager.loadGraphics` 都依赖这一点，再 `param1.content` 或 `KyoClassLoader.addSwf`。

内部三闭包：

| 闭包 | 行为 |
|------|------|
| `loadComplete` | 卸 complete/ioError/progress。`back(loader)`。 |
| `loadError` | 同样卸监听。`fail()`，**不传 Error / URL**。 |
| `loadProcess` | `process(bytesLoaded / bytesTotal)`。`bytesTotal==0` 时是 `NaN`/`Infinity`，调用方未防。 |

然后 `new Loader()`，三监听挂在 `contentLoaderInfo`（不是 Loader 自身），`loader.load(new URLRequest(url))`。

无 `LoaderContext`：默认当前 ApplicationDomain / SecurityDomain。开发树里 effect.swf、角色 SWF 都进主域。ZIP 路径是 `loadBytes`，域策略由 `ZipCtrler.getLoader` 决定。

无 `securityError` 监听：跨域策略失败会静默（既不 complete 也不走 fail）。

### `loadBitmap`（L74–112）

结构与 `loadSwf` 几乎逐行相同，唯独 complete 时 `back(loader.content)` —— 期望 `Bitmap`/`DisplayObject`，不是 Loader。

`BitmapAssetLoader.load` 把这个 content `as Bitmap` 后抽出 `bitmapData` 进缓存。若 content 不是 Bitmap（例如加载了 SWF），`cacheBitmap` 会 trace 后跳过。

同样无 securityError；Loader 用完不 `unload`，位图数据靠 content 的 BitmapData 活着。`AssetManager.disposeAsset` 对本类是空操作。

### `loadSound`（L114–151）

`new Sound(new URLRequest(url))`：**构造即开始加载**。监听加在构造之后，Flash 同步不会立刻 COMPLETE，所以顺序安全。

- complete → 卸监听 → `back(sound)`（同一个 Sound 实例，已 load 完，可 `play`）。
- `ioError` → 卸监听 → `fail()`。这里类型是 `IOErrorEvent`，另两处 load 用的是宽 `Event`。
- progress → `process(bytesLoaded/bytesTotal)`。

无 `id3` / `securityError`。Sound 失败后实例被丢弃（闭包结束），没有 `close()`。

`AssetManager.loadSnds` / `SoundCtrl.loadFightBGM` 的成功回调会把 Sound 放进各自的 `KyoSoundLoader`。

### `dispose`（L153–156）

空。接口要求按 url 释放。ZIP 实现会 `ZipCtrler.I.removeFile`。`AssetManager` 在 SWF/声音/字体加载成功后都会调 `disposeAsset(url)`，对本类无副作用，对 ZIP 则从内存表删掉压缩条目。

### `needPreLoad`（L157–160）

恒 `false`。`GameLoadingState.loadGame`：若 false 则跳过 ZIP 解析，直接 `loadPreloadBack()` → `GameData.loadConfig`。开发树不需要先解 `assets_zip`。

### `loadPreLoad`（L162–165）

空。ZIP 实现是 `ZipCtrler.I.init(back, process)` 解析内嵌 ZIP。本类即使被误调 `loadPreLoad` 也不会回调 `back`，加载条会卡住 —— 但因 `needPreLoad==false`，`GameLoadingState` 不会走进来。
