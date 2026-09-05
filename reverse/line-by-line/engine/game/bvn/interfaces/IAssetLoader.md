# `interfaces.IAssetLoader` — 资源加载后端

一句话目的：XML/SWF/声音/位图的加载抽象。默认 `AssetLoader` 走 URL；网页 `bleachvsnaruto` 换成 `ZipAssetLoader` 从 zip 取。`needPreLoad` 决定开局是否先下整包。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IAssetLoader.as`（21 行）

## Callers / callees

- **Implementors**：`ctrl.AssetLoader`（`needPreLoad=false`，`dispose` 空）；`web.ZipAssetLoader`（`needPreLoad=true`，`loadPreLoad` → `ZipCtrler.I.init`）。
- **Holder**：`AssetManager._assetLoader`，默认 `new AssetLoader()`。`AssetManager.setAssetLoader` 由 `bleachvsnaruto_2.initlize` 换成 Zip。
- **转发**：`AssetManager.needPreLoad/loadPreLoad` 原样转发。`GameLoadingState` 若 `needPreLoad()` 则先 `loadPreLoad` 再 `loadBasic`。

## 逐行说明

### `loadXML`（L6）

`(url, complete, fail=null)`。成功回调 XML。无 progress。`AssetLoader` 用 `KyoURLoader.load` 再 `new XML(text)`。Zip 用 `ZipCtrler.getXML`，缺则 fail。

### `loadSwf`（L8）

`(url, complete, fail=null, process=null)`。complete 收 `Loader`。process 为 0..1。URL 版听 `complete/ioError/progress`；Zip 从包里 `getLoader`，没有则 fail。

### `loadSound`（L10）

签名同 SWF。complete 收 `Sound`。

### `loadBitmap`（L12）

签名同 SWF。URL 版 complete 收 Loader；Zip 版收 `loader.content`（DisplayObject）。调用方需兼容两种。?

### `dispose`（L14）

按 url 释放。AssetLoader no-op；Zip 调 `ZipCtrler.removeFile`。

### `needPreLoad`（L16）

是否必须先下大包。false = 直接按 url 拉散文件。本网页包 true。

### `loadPreLoad`（L18）

`(complete, fail=null, process=null)`。AssetLoader 空实现。Zip：`ZipCtrler.I.init(complete, process)` — 注意 GIM/Zip 把第二参当 **process** 不当 fail（接口第二是 fail）。`AssetManager.loadPreLoad` 原样透传。`GameLoadingState` 的实参顺序须与 Zip 实现对照。?
