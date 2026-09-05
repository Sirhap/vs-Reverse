# `KyoURLoader` — 文本 URLLoader

一句话目的：GET 一段文本（XML/纯字）给回调。`AssetLoader.loadXML` 走 `load`；ZIP 构建走 `ZipAssetLoader`，**不**经过本类。

源文件：`decompiled/main/scripts/net/play5d/kyo/loader/KyoURLoader.as`（163 行）

## Callers / callees

- **Callers**：
  - `AssetLoader.loadXML`：`KyoURLoader.load(url, text→new XML, fail)`。`bleachvsnaruto.initlize` 把 loader 换成 `ZipAssetLoader` 后，这条网页直连路径本包运行时 **不走**。
  - `BitmapFontLoader.loadNext`：HTTP 拉 font XML。`AssetManager` 不用本类 `loadFonts`，所以也不走。
- **Callees**：`URLLoader` / `URLRequest` / `URLVariables` / `ByteArray`。
- **本包无调用**：`post`、`getFileType`、`errorStr` 读取、`showDebug` 改写。

## 逐行说明

### 静态字段（L15–25）

- `errorStr`：最近一次 IO/Security 错误的 `toString()`。`load` 开头清 null。无人读。
- `showDebug = true`：IO 错误 `trace` 事件。Security 错误不 trace。
- BOM 常量：给 `getFileType` 用。

### `load`（L32–86）

`(url, back, failBack=null, param=null)`。

1. `errorStr = null`。
2. `new URLLoader()`。若 `param` 非空，`for-in` 把字段赋到 loader 上（例如 `{dataFormat:"binary"}`）。调用方都不传第四参，默认文本。
3. 听 COMPLETE / IO_ERROR / SECURITY_ERROR。
4. `load(URLRequest(url))`。

成功：`back(loader.data)`，`loader=null`（**不** removeEventListener）。失败：写 `errorStr`，`failBack()` 无参，trace（IO 且 showDebug）。Security 不 trace。

无超时。并发每次 `new` 一份，可重叠。

### `post`（L88–139）

`(url, data, back, failBack)`。`URLRequestMethod.POST`。`data` 已是 `URLVariables` 则直接用，否则 `for-in` 填新的 Variables。无 Security 监听。本包零调用。

### `getFileType`（L141–159）

读 ByteArray 头两字节（然后 `position=0`）：

| 头 | 返回 |
|----|------|
| FF FE | `Unicode`（UTF-16 LE） |
| FE FF | `Unicode big endian` |
| EF BB | `UTF-8`（没验第三字节 BF） |
| 其它 | `ANSI` |

UTF-8 无 BOM 会落到 ANSI。本包零调用。读之前不检查 `bytesAvailable>=2`，空数组会 EOF。
