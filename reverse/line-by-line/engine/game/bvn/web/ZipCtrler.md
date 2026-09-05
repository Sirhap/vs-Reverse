# `ZipCtrler` — 嵌入 `assets_zip` 的 FZip 单例

一句话目的：把 DefineBinaryData 里那份 ~65MB ZIP 用 `deng.fzip.FZip.loadBytesStep` 解开，按路径取出 XML / Loader / Sound。网页包唯一资源仓库（UI 八件除外）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/web/ZipCtrler.as`（137 行）

## Callers / callees

- **Callers**：仅 `ZipAssetLoader`（`init` / `getXML` / `getLoader` / `getSound` / `removeFile`）。`getText` 只被 `getXML` 用。
- **Callees**：`deng.fzip.FZip`、`FZipFile`、`Loader.loadBytes`、`Sound.loadCompressedDataFromByteArray`。
- **触发链**：`GameLoadingState.loadGame` → `AssetManager.loadPreLoad` → `ZipAssetLoader.loadPreLoad` → `ZipCtrler.I.init`。

## 命名备注

嵌入 Class：`assets_zip$1de7dd7d6855592a2a2b869bcaf19a4b1288174545`（main.swf SymbolClass / BinaryData id=222 量级）。`new _embedZip()` 得到 `ByteArray`。

`_zipAssetLoader` 字段（L22）**声明后从未赋值、从未读取**，死字段。真正的 `ZipAssetLoader` 实例在 `bleachvsnaruto._zipAssetLoader`。

ZIP 条目名必须等于开发树 URL，例如 `assets/config/fighter.xml`、`assets/effect.swf`。改文件不改 local header CRC 会在 FZip 解析期失败。

`loadBytesStep(bytes, 20)` 的 `20` 是切片帧率：每片最多约 `1000/20=50ms`（见 `FZip.onStepLoad`），避免 65MB 同步解压卡死。完成派 `"complete"`，中途 `"progress"`。

## 逐行说明

### 单例 `I`（L29–36）

懒创建。整个运行期一份 FZip。

### 字段（L16–22）

- `_embedZip`：嵌入 ZIP Class，`init` complete 后置 null 以便 GC。
- `_zipBytes`：解开前的 ByteArray，complete 后 `clear()` + null。
- `_fZip`：解析器。
- `_zipAssetLoader`：未使用。

### `init`（L38–65）

`param1` 完成、`param2` 进度（0–1）。无 fail 参数。

闭包：

- `onZipComplete`：卸 complete、`_zipBytes.clear()`、两字段 null、调 `back()`。**不**卸 progress 监听。
- `onZipProcess`：`process(bytesLoaded / bytesTotal)`。`Boolean(process)` 在 AS3 对 Function 为 true。

然后：

1. `_zipBytes = new _embedZip()`（ByteArray 子类实例）。
2. `new FZip()`，听 `"complete"` / `"progress"`。
3. `_fZip.loadBytesStep(_zipBytes, 20)`。

未听 `ioError` / FZip 内部 CRC 失败。解析出错时 `GameLoadingState` 的 fail 不会被调（见 ZipAssetLoader）。

### `getLoader`（L67–82）

总是先 `new Loader()`。try：`getFileByName(url)` → `loadBytes(file.content)`。catch：`trace("ZipCtrler.getLoader Error ::", e)` 并 `_loc3_ = null`。

缺文件、content 空、loadBytes 同步抛都会变 null，调用方走 fail。成功则 Loader 已在异步解码；`ZipAssetLoader` 必须马上加 complete 监听。

无 `LoaderContext`：默认新 ApplicationDomain。角色 SWF 的类名因此不污染主域（和 `ResUtils` 并入 currentDomain 相反）。

### `removeFile`（L84–88）

`trace("remove file from zip :", name)` + `FZip.removeFileByName`。脸图缓存完、effect.swf 进 ClassLoader 后由 `dispose` 调用，释放 ZIP 内原始字节。

### `getText`（L90–107）

try：取文件、`position=0`、`readUTFBytes(bytesAvailable)`。失败 trace，返回未赋值的 `_loc3_`（`null`）。不关 BOM。XML/配置都当 UTF-8。

### `getSound`（L109–127）

try：取字节、`position=0`、`new Sound().loadCompressedDataFromByteArray(bytes, bytesAvailable)`（MP3）。失败 trace，返回 null。同步填 Sound，`ZipAssetLoader.loadSound` 仍下一帧才回调。

### `getXML`（L129–133）

`getText` 然后 `new XML(_loc2_)`。无 try：文本非法会抛到 `loadXML`。`_loc2_==null` 时 `new XML(null)` 得到空 XML，truthy，调用方当成功。?
