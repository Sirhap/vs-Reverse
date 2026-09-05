# `AssetManager` — 资源中枢单例

一句话目的：游戏资源门面。启动时 `loadBasic` 顺序拉预载音效 / `effect.swf` / 位图字体 / 脸图与地图缩略图；运行时 `getSound`/`getEffect`/`getFighterFace*`/`getMapPic` 取已缓存资源；`loadXML`/`loadSWF`/`loadSound`/`loadBitmap` 转发给当前 `IAssetLoader`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/AssetManager.as`（440 行）

## Callers / callees

- **Callers**：
  - `bleachvsnaruto_2.initlize`：`setAssetLoader(ZipAssetLoader)`。
  - `GameLoadingState`：`needPreLoad` / `loadPreLoad` / `loadBasic`。
  - `GameData`：`loadXML` 拉 fighter/assist/select/map/mission，以及 `loadSelect`。
  - `GameLoader`：`loadSWF`。
  - `SoundCtrl`：`getSound` / `getEffect` / `loadSound`。
  - `BitmapAssetLoader`：`loadBitmap` / `disposeAsset`（反向依赖：本类又持有一个 `BitmapAssetLoader`）。
  - UI / 状态：`getFont("font1")`（`MenuBtn`/`SetBtn`/`AlertUI`/`ConfrimUI`/`KeyMapping`/`SetBtnDialog`/`CongratulateState`/`WinnerState`/`GameOverState`）；`getFighterFace`（`SelectFighterItem`/`QiBar`）；`getFighterFaceBar`（`FightFaceUI`）；`getFighterFaceWin`（`WinnerState`）；`getMapPic`（`MapSelectUI`）；`getSound` 作 BGM（`MenuState`/`SelectFighterStage`/`LoadingState`/`SettingState`/`HowToPlayState`/`CreditsState`/`GameOverState`/`CongratulateState`/`WinnerState`）。
  - `EffectVO.cacheBitmapData` / `BishaFaceEffectView`：`getEffect`。
- **Callees**：`IAssetLoader`（默认 `AssetLoader`，运行时 `ZipAssetLoader`）、`KyoClassLoader`、`KyoSoundLoader`、`BitmapAssetLoader`、`BitmapFontLoader`、`FighterModel`/`AssisterModel`/`MapModel`、`KyoUtils.array_deleteSames`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `I` | 懒单例 getter |
| `_assetLoader` | 可替换的 `IAssetLoader` |
| `_effectSwfPath` | 常量 `"assets/effect.swf"`，`getEffect` 用同一字符串当 `KyoClassLoader` 的 swf id |
| `_fighterFaceCache` | **声明后从未读写**，死字段。真正脸图缓存在 `BitmapAssetLoader._cacheObj` |
| `loadSWF` vs loader `loadSwf` | 对外大写 SWF，对内接口小写 |
| `loadPreLoadSounds` | 读 `preload.xml` 的 bgm/sound 列表，不是 `IAssetLoader.loadPreLoad`（那是解 ZIP） |
| `type` 中文 | 进度条文案：「声音」「特效」「字体」「图片」 |

## 逐行说明

### 包与 import（L1–19）

显示对象、`Point`、`Sound`。数据模型只为枚举脸图/地图 URL。kyo：位图字体、ClassLoader、SoundLoader、`KyoUtils`。

### 字段（L23–38）

- `_i`：单例。
- `_swfLoader`：只收 `assets/effect.swf`。`getEffect` 从它的 ApplicationDomain `getDefinition`。
- `_soundLoader`：预载 SFX/BGM（`preload.xml`）。战斗中角色/地图 BGM 不走这里，走 `SoundCtrl._soundLoader`。
- `_bitmapLoader`：脸图 + 地图预览图队列。
- `_bitmapFontLoader`：当前只装 `font1`。
- `_assetLoader = new AssetLoader()`：默认 URL 实现。网页包启动立刻换成 ZIP。
- `_effectSwfPath`：编译期常量，与 L86/L194 字符串相同。
- `_fighterFaceCache = {}`：未使用。

### 构造 / `I`（L40–52）

空构造。`I` 首次访问 `new AssetManager()`。`bleachvsnaruto` 在 `setAssetLoader` 前就会碰到 `AssetManager.I`，因此默认 `AssetLoader` 会被构造出来再被丢弃引用（等 GC）。

### `getFont`（L54–57）

`_bitmapFontLoader.getFont(name)`。字体 id 来自 XML `info.@face`（`loadFonts` 装的是 `assets/font/font1.xml`，调用方一律 `"font1"`）。未加载返回 `null`。

### `setAssetLoader`（L59–62）

替换 `_assetLoader`。不 dispose 旧实例。必须在任何 `load*` 之前调用，否则会按 HTTP 去拉 `assets/`（网页包没有松散文件）。

### `loadBasic`（L64–112）—— 启动四段加载

`GameLoadingState.loadConfigBack` 在 XML 配表齐了之后调用。签名：`(back, process=null)`。

`process(progress, type, loadStep, loadCount)`：`GameLoadingState.loadAssetProcess` 用它刷条和「正在加载X资源(step/count)」。

状态机闭包：

| 变量 | 值 |
|------|-----|
| `loadStep` | 0 起。**每次 `loadNext` 结束都 +1**，包括 case 4。 |
| `loadCount` | 恒 4（四段资源，不含 init）。 |
| `type` | 当前段中文名，下次 `loadProcess` 带出去。 |

`loadNext` switch：

1. **case 0**：`loadPreLoadSounds(loadNext, loadProcess)`，`type="声音"`，立刻 `loadProcess(0)`。
2. **case 1**：`loadGraphics(["assets/effect.swf"], …)`，`type="特效"`。
3. **case 2**：`loadFonts`，`type="字体"`。
4. **case 3**：`loadBitmaps`，`type="图片"`。
5. **case 4**：`initAssets()`，然后 `back()`。不再 `loadProcess`。

注意：`loadProcess(0)` 时 `loadStep` 尚未 +1；随后的进度回调发生在异步完成过程中，那时 `loadStep` 已经是下一段的编号。加载条上的 `(step/4)` 会提前一格。`type` 在启动该段时赋值，进度回调看到的名字是对的。

`loadProcess` 把 loader 给的 0–1 原样上抛。各段自己决定这个 0–1 是「当前文件」还是「本段队列」。

任一段若失败且不回调 `loadNext`（字体 XML/图失败就是这样），`back` 永不触发，启动停在 `GameLoadingState`。

### `loadPreLoadSounds`（L114–133）

`_assetLoader.loadXML("assets/config/preload.xml", …)`。

解析：

- `bgm.@path` + 每个 `bgm.item` 文本 → 完整 URL。
- `sound.@path` + 每个 `sound.item` 文本 → 完整 URL。

拼进一个 Array，交给 `loadSnds`。无 fail 回调：preload.xml 缺失则静默，`loadBasic` 卡死。

这与 `needPreLoad`/`loadPreLoad` **不是一回事**：后者解 ZIP 包；这里是 ZIP（或 HTTP）里那份「必须先听到的音效清单」。

### `loadSnds`（L135–179）

顺序队列：

1. `snds = sounds.concat()`，`sndLen = length`。
2. `loadNext`：空则 `back()`；否则 `shift` 到 `curUrl`，`_assetLoader.loadSound(curUrl, loadCom, loadErr, loadProcess)`。
3. `loadCom(Sound)`：`_soundLoader.addSound(curUrl, sound)`（**完整 URL 当 key**），`dispose(curUrl)`，下一首。
4. `loadErr`：`trace("加载声音失败 : " + curUrl)`，**仍继续**（缺文件不挡启动）。
5. `loadProcess(p)`：`progress = (sndLen - snds.length - 1 + p) / sndLen`。`shift` 之后 `snds.length` 是剩余未开始数，减 1 表示「当前这首」。`sndLen==0` 会除零 → `NaN`。

`KyoSoundLoader.getSound` 既按完整 URL 查，也按「最后一段去掉扩展名」查。所以 `SoundCtrl.playAssetSound("select")` / `AssetManager.I.getSound("op")` 能命中 `…/select.mp3`。

### `initAssets`（L181–190）

`getFont("font1")` 若存在，调字距：

| 字段 | 值 | 作用 |
|------|-----|------|
| `charGap` | -8 | 字与字重叠/收紧（位图字偏宽） |
| `spaceGap` | 10 | 空格宽 |
| `offsetY` | -5 | 垂直微调 |

只在 `loadBasic` 全部成功后跑一次。

### `getEffect`（L192–196）

`_swfLoader.getClass(name, "assets/effect.swf")` 再 `new`。返回类型 `*`：特效 MC（`EffectVO`、`BishaFaceEffectView` 的 `"bisha_face_mc"`）或 Sound 符号（`SoundCtrl.playEffectSound`）。类不存在时 `KyoClassLoader` 抛 Error。effect.swf 没装完就调会抛 `"assets/effect.swf未加载!"`。

`KyoClassLoader.addSwf` 在登记 ApplicationDomain 后会 `unloadAndStop` Loader；定义留在 domain 里。

### `getSound`（L198–201）

`_soundLoader.getSound(key)`。key 可以是完整 URL 或无路径无扩展名的基名。未找到返回 `null`（`SoundCtrl.playAssetSound` 直接 return）。

### `getFighterFace`（L203–217）

小头像。`_bitmapLoader.getBitmap(vo.faceUrl)` —— **每次 new Bitmap 包同一份 BitmapData**，不是共享 DisplayObject。缺图 `null`。

默认尺寸 `Point(50,50)`。直接改 `width`/`height`（拉伸，不保持比例）。

调用：选人格子 `SelectFighterItem`、气条旁 `QiBar`。

### `getFighterFaceBig`（L219–233）

大脸。URL `faceBigUrl`，默认 `245×62`。

**本包没有任何外部调用方**（grep 只命中定义）。资源仍会在 `loadBitmaps` 里预载（`getFighterFaceUrls(..., true, true)` 无条件 push `faceBigUrl`）。

### `getFighterFaceBar`（L235–249）

血条头像。`faceBarUrl`，默认 `102×64`。`FightFaceUI` 用。`getFighterFaceUrls` 对角色 `param2=true` 才收集 bar；辅助角色那次调用两个 flag 都是默认 false，辅助没有 bar/win 预载。

### `getFighterFaceWin`（L251–269）

胜利立绘。`faceWinUrl` 空则立刻 `null`（有的角色没配）。默认 `300×250`。`WinnerState` 组胜利脸。

### `getMapPic`（L271–285）

地图预览。`MapVO.picUrl`，默认 `450×240`。`MapSelectUI` 用。

四类 getter 都是「缓存里取 BitmapData → new Bitmap → 拉伸」。同一 URL 多次 get 得到不同 Bitmap、同一份像素。改一张的 width 不影响另一张。

### `loadXML` / `loadSWF` / `loadSound` / `loadBitmap` / `disposeAsset`（L287–310）

纯转发 `_assetLoader`。`loadXML` 的 fail **没有默认 null**（与接口不同），调用方必须传 fail。`GameData.loadSelect` 传了空 fail（只 trace）。

### `loadGraphics`（L312–346）

通用 SWF 队列。`loadBasic` 只传入 `["assets/effect.swf"]`。

- `loads = loadarray.concat()`。
- 成功：`loadedAmount++`（**从未读取**，死计数）、`_swfLoader.addSwf(curUrl, loader)`、`dispose(curUrl)`、下一张。
- 失败：`trace("Error :: " + url + " load fail!")`，**继续**。若 effect.swf 失败，后续 `getEffect` 会抛。
- 进度：把 `process` **原样**传给 `loadSwf`，即当前这一份 SWF 的 0–1，不是队列总进度。单文件时等价。

### `loadBitmaps`（L348–355）

拼 URL 列表：

1. 全部角色：`getFighterFaceUrls(allFighters, true, true)` → face + big + bar + win。
2. 全部辅助：`getFighterFaceUrls(allAssisters)` → 只有 face + big。
3. 全部地图：`getMapPicUrls` → `picUrl`。
4. `KyoUtils.array_deleteSames` 去重（共享脸图只拉一次）。
5. `_bitmapLoader.loadQueue(urls, back, process)`。内部再调 `AssetManager.loadBitmap`，形成「AssetManager ↔ BitmapAssetLoader」互调，但 `loadQueue` 走的是 `_bitmapLoader` 实例方法，不会递归 `loadBitmaps`。

依赖：必须先 `GameData.loadConfig` 填好三个 Model，否则空列表瞬间完成，选人时全是空头像。

### `loadFonts`（L357–391）

只装一份：`url = "assets/font/font1.xml"`。

1. `loadXML` → `loadXMLCom`：记下 XML；`pages.page.@file` 是 png 文件名；拼 `dirname(xml) + file` 为 `fontBitmapUrl`；`loadBitmap`。
2. `bitmapCom`：`as Bitmap` → `addFont(xml, bitmapData)`（key = `info.@face`）→ `dispose` png → `back()`。
3. `bitmapFail`：只 `trace("字体图片加载失败", url)`。**不** `back()`，`loadBasic` 停住。trace 里的 `url` 是 XML 路径不是 png。
4. `loadXMLFail`：同样只 trace，卡住。

### `getFighterFaceUrls`（L393–416）

遍历 `Object`（Model 的 id→VO 表）。每个 VO：

- 有 `faceUrl` / `faceBigUrl` 就 push（不看 flag）。
- `param2 && faceBarUrl` → bar。
- `param3 && faceWinUrl` → win。

空字符串在 AS3 为 falsy，会跳过。

### `getMapPicUrls`（L418–426）

每个 `MapVO.picUrl` 都 push，**不过滤空**。空字符串会进加载队列，失败只 trace，继续。

### `needPreLoad` / `loadPreLoad`（L428–436）

转发给 `_assetLoader`。ZIP：`true` + `ZipCtrler.init`。URL：`false` + 空函数。

`GameLoadingState` 先 preload（解包），再 `GameData.loadConfig`（XML），再 `loadBasic`（音效/特效/字体/图）。
