# `BitmapAssetLoader` — 脸图/地图预览队列加载器

一句话目的：把一组 URL 顺序交给 `AssetManager.loadBitmap`，把 `BitmapData` 缓存在对象里，供 `getFighterFace*` / `getMapPic` 每次 `new Bitmap`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/BitmapAssetLoader.as`（125 行）

## Callers / callees

- **Callers**：仅 `AssetManager`。字段 `_bitmapLoader = new BitmapAssetLoader()`（L30）。`loadBitmaps`（L348–354）组 URL 后 `loadQueue`；`getFighterFace` / `getFighterFaceBig` / `getFighterFaceBar` / `getFighterFaceWin` / `getMapPic` 调 `getBitmap`。
- **Callees**：`AssetManager.I.loadBitmap`、`AssetManager.I.disposeAsset`。网页包里这两条落到 `ZipAssetLoader`（ZIP），不是 HTTP `AssetLoader`。

## 命名备注

类名无拼写问题。`_cacheObj` 的 key 是 URL 字符串，value 是共享的 `BitmapData`（不是 `Bitmap`）。`getBitmap` 每次 new 一份显示对象，多处 UI 可同时拿同一张脸。

与 `LoadingState._loadQueue` 无关：那边是角色/地图 SWF 队列，不走本类。

## 逐行说明

### 字段（L11–19）

- `_queueLength`：本次 `loadQueue` 的原始条数，进度分母。
- `_urls`：剩余 URL，`concat` 拷贝，会 `shift`。
- `_cacheObj`：`{ url: BitmapData }`。
- `_successBack` / `_processBack`：整队完成 / 0–1 进度。

### 空构造（L21–24）

无初始化逻辑。

### `getBitmap`（L26–34）

`param1` 当 URL。缓存没有 → `null`（调用方 `getFighterFace*` 也返回 null，UI 空着）。有则 `new Bitmap(_loc2_)`，**不**克隆像素。

### `loadQueue`（L36–43）

`param1` 数组、`param2` 成功、`param3` 进度（可空）。`concat()` 防调用方数组被掏空。立刻 `loadNext()`。

`AssetManager.loadBitmaps` 传入的 URL：全体角色 `faceUrl`/`faceBigUrl`/`faceBarUrl`/`faceWinUrl` + 辅助脸 + 地图 `picUrl`，再 `KyoUtils.array_deleteSames`。

### `load`（L45–67）—— 单张

闭包 `url`/`back`/`process` 绑进两个匿名函数：

- `loadCom(DisplayObject)`：`cacheBitmap` 后调 `back`（队列里 `back` 是 `loadNext`）。
- `loadFail()`：`trace("BitmapAssetLoader.loadFail ::", url)`，**仍然** `back()`。失败不中断队列，该 URL 无缓存。

`AssetManager.I.loadBitmap(url, loadCom, loadFail, process)`。ZIP 实现里 `process` 只在 complete 时被叫一次 `process(1)`，没有下载百分比。

### `cacheBitmap`（L69–94）

1. `param2 as Bitmap`。不是 Bitmap → `trace("BitmapAssetLoader.cacheBitmap Error")` **return**（不 `disposeAsset`，ZIP 里那条还占着）。
2. `try` 取 `bitmapData`；安全沙箱/已 dispose 会进 catch 并 trace。
3. 有 `_loc4_` 才写入 `_cacheObj`。
4. 无论 bitmapData 是否取到，只要是 Bitmap 就 `disposeAsset(param1)`：ZIP 包会 `ZipCtrler.removeFile`，HTTP `AssetLoader.dispose` 是空函数。缓存只留像素，不留 Loader。

### `loadNext`（L96–121）

内嵌 `loadProcess(Number)`：若有 `_processBack`，

```
已完成约数 = _queueLength - _urls.length - 1 + param1
进度 = 该值 / _queueLength
```

`shift` 之后 `_urls.length` 是剩余未开始数，`-1` 把「当前这一张」从已完成里扣掉，再加当前张的 0–1。ZIP 路径 `param1` 几乎总是 1，进度按文件个数跳。

队列空：调 `_successBack` 并置 null，return。否则 `shift` 一张，`load(url, loadNext, loadProcess)` 串行。
