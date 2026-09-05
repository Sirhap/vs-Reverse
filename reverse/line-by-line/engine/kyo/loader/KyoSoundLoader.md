# `KyoSoundLoader` — 声音登记表

一句话目的：`url → Sound` 字典。`getSound` 可按完整 URL 或「文件名去扩展名」取。本游戏 **不走 `loadSounds` HTTP 链**，由 `IAssetLoader.loadSound` 拉完再 `addSound`。

源文件：`decompiled/main/scripts/net/play5d/kyo/loader/KyoSoundLoader.as`（166 行）

## Callers / callees

- **`AssetManager`**（预加载 SFX/菜单 BGM）：
  - `_soundLoader = new KyoSoundLoader()`
  - `loadSnds` 成功：`addSound(curUrl, sound)` 再 `dispose(url)`
  - `getSound(name)` → 本类 `getSound`（短名，如 `"snd_menu"`）
- **`SoundCtrl`**（战斗 BGM，**另一份**实例）：
  - `loadFightBGM`：`new KyoSoundLoader()`，ZIP 拉完 `addSound(curUrl, sound)`
  - `playFightBGM`：`getSound(url)`（完整 URL）
  - `unloadFightBGM`：`unload()`
- **Callees**：`Sound` / `URLRequest` / `URLLoader`（仅 `loadPath`）。
- **本包无调用**：`loadSounds`、`loadPath`。`AssetManager` 有自己的串行 `loadSnds`。

## 逐行说明

### 字段（L13–23）

- `_urls` / `_curUrl`：HTTP 队列。
- `_soundObj`：键是 `addSound`/`loadCom` 时的 URL 字符串。
- `_loadBack` / `_loadProcess` / `_loadLength`：批量进度。

### `unload`（L30–41）

对每个 Sound `close()`（嵌入/已播完的会抛，**无 try**）。然后 `_soundObj = {}`。`SoundCtrl.unloadFightBGM` 走这里。ZIP 里的 Sound 多数不能 close。?

### `loadSounds`（L43–50）

`(urls, back, process)`。`_urls = param1.concat()`（拷一份）。`_loadLength = param1.length`，`loadNext()`。本包零调用。

空数组：`loadNext` 的 `shift()` 得到 `undefined`，`new Sound(URLRequest(undefined))` 会失败。?

### `getSound`（L52–70）

1. 精确键 `_soundObj[param1]`。
2. 否则扫键：取最后一个 `/` 之后、最后一个 `.` 之前，与 `param1` 比。`"assets/sound/hit.mp3"` 可用 `"hit"` 取到。
3. 都没有 return `null`。`SoundCtrl.playAssetSound` 对 null 静默。

无扩展名的键（少见）`lastIndexOf(".")==-1`，`substr(0,-1)` 为空串，对不上。

### `addSound`（L72–75）

直接登记。`AssetManager` / `SoundCtrl` 的主路径。

### `loadNext`（L77–85）

`shift` → `_curUrl`。`new Sound(URLRequest)` 立刻开始流式加载。听 COMPLETE / PROGRESS / IO_ERROR。不先判断空队列。

### `loadProcess`（L87–99）

`bytesLoaded/bytesTotal` 作当前文件分数。整体：`(已完成数 + 当前分数) / length`。`已完成数 = length - urls.length - 1`（当前这份已 shift）。`_loadProcess` 空则跳过。

### `loadCom`（L101–116）

卸三监听。`_soundObj[_curUrl] = sound`。队列空 `loadFin`，否则 `loadNext`。

### `loadErr`（L118–133）

卸监听。`trace("KyoSoundLoader.loadErr :: 加载声音失败 : " + sound.url)`。**不中断**，继续下一份或 `loadFin`。失败项不进表。

### `loadFin`（L135–142）

调 `_loadBack` 一次后清空。不清 `_loadProcess`。

### `loadPath`（L144–162）

`(dir, listXML, back)`。`URLLoader` 拉 `dir/listXML`，把根节点每个 child 的 `toString()` 当文件名，拼 `dir/name`，转 `loadSounds`。无失败监听。本包零调用。
