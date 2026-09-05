# `BitmapLoader` — 单张位图 URLLoader

一句话目的：`Loader` 拉一张图，成功把 `content as Bitmap` 交给回调。本游戏字体 PNG 不走这里（ZIP 走 `IAssetLoader.loadBitmap`）；只有 `BitmapFontLoader.loadBitmapData` 会 `new` 它，而那条批量 HTTP 链本包没人调。

源文件：`decompiled/main/scripts/net/play5d/kyo/loader/BitmapLoader.as`（60 行）

## Callers / callees

- **Callers**：仅 `BitmapFontLoader.loadBitmapData`。`AssetManager.loadFonts` 用 `_assetLoader.loadBitmap`（`ZipAssetLoader` / `AssetLoader`），**绕过**本类。
- **Callees**：`flash.display.Loader`、`URLRequest`。

## 逐行说明

### 字段（L12–14）

- `bitmap`：成功后的 `Bitmap`（`loader.content`）。`unload` 后仍持有那张 Bitmap 的引用。
- `url`：本次请求。

### 构造（L16–19）

空。

### `load`（L21–56）

`(url, back=null, fail=null)`。

记下 `this.url`。`new Loader()`，听 `COMPLETE` / `IO_ERROR`，`load(URLRequest)`。无进度、无 security error 监听。

**`loadComplete`**：

1. `bitmap = loader.content as Bitmap`。非位图内容（SWF）得到 `null`，仍当成功把 `null` 回给 `back`。
2. 卸两个监听。
3. `loader.unload()`（清 Loader 内容，Bitmap 数据仍在 `bitmap.bitmapData`）。
4. `loader = null`。
5. `back(bitmap)`。

**`loadFail`**：卸监听，`loader = null`（不 unload），`fail()` **无参**。

`BitmapFontLoader.loadBpFail` 写成 `function(param1:Event)`，运行时 `param1` 为 undefined，只 `trace` URL，能过。

监听未在失败以外的取消路径卸掉（没有 `close` API）。
