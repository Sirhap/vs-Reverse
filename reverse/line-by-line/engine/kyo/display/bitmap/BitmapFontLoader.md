# `BitmapFontLoader` — 位图字体登记表

一句话目的：按 `info.@face` 存 `BitmapFont`。本游戏 **不走 HTTP 加载**，`AssetManager.loadFonts` 用 ZIP 里的 XML+PNG 调 `addFont`。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFontLoader.as`（135 行）

## Callers / callees

- **Callers**：仅 `AssetManager`：
  - 字段 `_bitmapFontLoader = new BitmapFontLoader()`
  - `getFont(name)` → `getFont`
  - `loadFonts` 私有方法里 `addFont(fontXML, bitmap.bitmapData)`（ZIP/`IAssetLoader`，不是本类 `loadFonts`）
- **Callees**：`BitmapFont`、`KyoURLoader.load`、`BitmapLoader.load`。
- **本包无调用**：`clear`、`loadFonts`（本类的）、`loadFont`。网页直连加载链是给非 ZIP 构建留的。

## 接到主链

```
AssetManager.loadBasic
  → loadFonts (AssetManager 私有)
       loadXML assets/font/font1.xml
       loadBitmap 同目录 + pages.page.@file
       addFont(xml, bd)
  → initAssets：font1.charGap=-8, spaceGap=10, offsetY=-5
UI → AssetManager.getFont("font1") → BitmapFontText
```

## 逐行说明

### 字段（L12–20）

- `_urls`：`loadFonts` 队列。
- `_fontObj`：`face → BitmapFont`。
- `_loadAmount` / `_loadBack` / `_loadProcess`：批量进度。

### 构造（L22–25）

空。

### `clear`（L27–30）

`_fontObj = {}`。**不** `dispose` 图集。本包零调用。

### `loadFonts`（L32–39）

`(urls, back=null, process=null)`。记下回调，`_urls = param1`（**不 concat**，会 shift 掉调用方数组）。`_loadAmount = length`，`loadNext()`。本包零调用。

### `loadFont`（L41–47）

单份：XML 已在手。`pages.page.@file` + `param1` 目录前缀拼 PNG URL，转 `loadBitmapData`。`param1` 是 XML 的 URL，不是目录。本包零调用。

### `addFont`（L49–53）

`face = xml.info.@face`（font1.xml 里是 `"font1"`）。`new BitmapFont(xml, bd)` 覆盖同名。`AssetManager` 只加一次。

### `getFont`（L55–58）

按 face 取。没有返回 `undefined`（AS3 动态 Object）。`new BitmapFontText(undefined)` 随后 `translate` 会 NPE。`loadBasic` 失败时 `initAssets` 有 null 守卫，但 UI 仍可能在没字体时 `getFont`。

### `loadComplete`（L60–68）

调 `_loadBack` 一次后清空两个回调。

### `loadNext`（L70–101）

1. 有 `_loadProcess`：`cur = amount - urls.length`，传 `cur/amount`（刚开始 length 还没 shift，进度 0）。
2. 队列空 → `loadComplete`。
3. `shift` 一个 XML URL，`KyoURLoader.load`。
   - 成功：`new XML`，拼 PNG URL，`loadBitmapData(..., loadNext, loadNext)` —— 图成功或失败都继续下一份 XML。
   - 失败：`trace("BitmapFontLoader.loadXMLFail::"+url)`，仍 `loadNext`。不中断。

### `loadBitmapData`（L103–131）

`fontid = xml.info.@face`。`new BitmapLoader().load(pngUrl, ...)`。

- 成功：`_fontObj[fontid] = new BitmapFont(xml, bitmap.bitmapData)`，调 `back`。
- 失败：`trace("...loadBpFail::"+bpurl)`，调 `fail`。

**签名裂缝**：`BitmapLoader` 失败回调是 **无参** `fail()`（见 `BitmapLoader.md`），本处 `loadBpFail = function(param1:Event)`。AS3 无参调用有参闭包，`param1` 为 `undefined`，函数体能跑（只用 `bpurl`）。类型标注无运行时检查。
