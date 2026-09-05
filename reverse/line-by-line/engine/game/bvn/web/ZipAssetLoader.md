# `ZipAssetLoader` — `IAssetLoader` 的 ZIP 实现（替换 HTTP `AssetLoader`）

一句话目的：网页包不按 URL 拉 `assets/`，全部从嵌入 ZIP 按**同名路径**取。`needPreLoad()==true`，loading 条先跑 `ZipCtrler.init`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/web/ZipAssetLoader.as`（142 行）

## Callers / callees

- **Callers**：`bleachvsnaruto.initlize` `new ZipAssetLoader()` → `AssetManager.I.setAssetLoader`。之后 `AssetManager.loadXML/loadSWF/loadBitmap/loadSound/disposeAsset/needPreLoad/loadPreLoad` 全部转这里。`GameLoadingState.loadGame` 因 `needPreLoad` 真而先 `loadPreLoad`。
- **Callees**：`ZipCtrler.I.getXML/getLoader/getSound/removeFile/init`；`kyo.utils.setFrameOut`；`bleachvsnaruto.STAGE`。

## 命名备注

对比默认 `ctrl/AssetLoader`（实现同一 `IAssetLoader`）：

| | `AssetLoader` | `ZipAssetLoader` |
|--|---------------|------------------|
| XML | `KyoURLoader` HTTP | `ZipCtrler.getXML` |
| SWF/图 | `Loader.load(URLRequest)` | `ZipCtrler.getLoader` → 已 `loadBytes` |
| 音 | `new Sound(URLRequest)` | `ZipCtrler.getSound` |
| `dispose` | 空 | `removeFile` 从 FZip 删条目 |
| `needPreLoad` | `false` | `true` |
| `loadPreLoad` | 空 | `ZipCtrler.init` 解析 embed zip |

正式包走 ZIP。`AssetLoader` 留给未打包的开发树。

`loadPreLoad(success, fail, process)` 调 `ZipCtrler.I.init(success, process)`：**fail 被丢掉**。ZIP 解析失败不会走 `GameLoadingState.loadPreloadFail`，除非 FZip 自己抛。

## 逐行说明

### 空构造（L12–15）

无状态。真正 ZIP 在 `ZipCtrler` 单例。

### `loadXML`（L17–28）

`ZipCtrler.I.getXML(url)`。有则 `doNextFrame(success, xml)`；否则 `doNextFrame(fail)`。同步读、异步回调（下一帧），避免 `GameData.loadConfig` 在同一栈里连打多个 load。

`getXML` 在 getText 失败时仍 `new XML(null)` 得到空 XML 对象（truthy），fail 分支可能走不到。? 坏 XML 文本会在 `new XML` 处抛，本方法无 try。

### `loadSwf`（L30–55）

`getLoader(url)`：内部已经 `Loader.loadBytes(entry.content)`。null → 下一帧 `fail`。

否则听 `contentLoaderInfo.complete`：卸监听、`process(1)`、`back(loader)`（注意回调的是 **Loader**，`AssetManager.loadGraphics` 要这个才能 `KyoClassLoader.addSwf`）。

**监听加在 `loadBytes` 之后**。Flash 里 loadBytes 通常异步，complete 还没派，一般没问题。无 `ioError`。无中途进度（ZIP 已在内存）。

### `loadBitmap`（L57–82）

与 loadSwf 同结构，但 `back(loader.content)`（`DisplayObject`，期望 Bitmap）。`BitmapAssetLoader.cacheBitmap` 吃这个。同样 `process(1)` 一次。

### `loadSound`（L84–109）

`getSound` 已 `loadCompressedDataFromByteArray`。成功：下一帧里先 `back(sound)` 再 `process(1)`（顺序与 SWF/图相反）。失败下一帧 `fail`。

### `dispose`（L111–114）

`ZipCtrler.I.removeFile(url)`。`AssetManager` 在 effect.swf 进 ClassLoader 后、脸图进 BitmapData 缓存后会调，把 ZIP 条目丢掉省内存。

### `doNextFrame`（L116–128）

`func==null` return。否则 `setFrameOut(apply, 1, bleachvsnaruto.STAGE)`：STAGE 上等 1 帧再 `func.apply(null, rest)`。缺 STAGE 时 `setFrameOut` 会自己 new 一个不在显示列表的 Sprite 听 ENTER_FRAME，仍能触发。

### `needPreLoad`（L130–133）

恒 `true`。`GameLoadingState` 因此先解 ZIP 再 `GameData.loadConfig`（fighter.xml 等也在 ZIP 里）。

### `loadPreLoad`（L135–138）

`ZipCtrler.I.init(param1, param3)`。`param2` fail 未转发。进度是 FZip `bytesLoaded/bytesTotal`（解析切片，不是下载）。
