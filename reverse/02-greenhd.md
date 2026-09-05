# 02 混淆壳 — com.green / ƃ.FB / ɕ.ȑ / ƒ.ǵ

权威源：`decompiled/main/scripts/` 下 Unicode 包名与 `com.green`、`com.sh`。FFDec `autoDeobfuscate=1` 仍保留 ABC 里的标识符。本册还原引导、体积门、LocalConnection、4399 钩子。不提供绕过利用代码。

总索引：[`../BVN-FULL-REVERSE.md`](../BVN-FULL-REVERSE.md)。引擎在壳交权之后，见 [`01-engine.md`](01-engine.md)。

## 时间轴三帧（main.swf）

`extracted/full/INVENTORY.md`：FWS v14，3 帧，4 个 DoABC。

| 帧 | 标签 | DoABC 大约体积 | 文档/符号 |
|---|---|---|---|
| 1 | FrameLabel + DoABC 11891 B + SymbolClass | 壳引导 | 符号 `0 → BleachVSNaruto` |
| 2 | DoABC 64830 B + JPEG id=1 + SymbolClass | 加载 UI / 壳逻辑 | `LOADING_bvn`、`bvn_png$…` |
| 3 | DoABC 8337 B + DoABC 334345 B + BinaryData/Sound/JPEG | 应用 + 资源 | `bleachvsnaruto`、ZIP id=222、8 个 UI ByteArray |

文档类 `BleachVSNaruto`（`decompiled/main/scripts/BleachVSNaruto.as`）在构造里只做一件事：

```actionscript
ǵ.ɐ.Ȱ(this, Ǵ);
```

`ǵ.ɐ` 是壳单例（Alias `"current"` ← 字节 `99,117,114,114,101,110,116`）。`Ȱ` 把主时间轴停住，叠三层 Sprite，并按 `[FrameTask]` 元数据拉后续任务类。

## 引导链

```
BleachVSNaruto()
  → ƒ.ǵ.Ȱ(timeline, ƒ.Ǵ)
       FrameTask 元数据 p2=ƃ c2=FB, p3=ɕ c3=ȑ
  → 逐帧 nextFrame，执行带 [FrameTask] 的静态方法
       ƒ.Ǵ.ȝ()     加载进度 UI、throttle/activate
       ƃ.FB.init_fb()  平台/版本/参数门
       ɕ.ȑ.§͢§()   体积门 + 启动应用实例
  → 应用侧 bleachvsnaruto（bleachvsnaruto_2.as）
```

`ƒ.ǵ.ȱ()` 读自身 `[FrameTask(p2="ƃ", p3="ɕ", c2="FB", c3="ȑ")]`，把 `ƃ.FB` 与 `ɕ.ȑ` 推进时间轴任务队列。时间轴帧数必须 ≥ 任务数，否则抛 `timeline frames length error`。

## ƃ.FB — 配置门与平台白名单

路径：`decompiled/main/scripts/ƃ/FB.as`。

静态模型 `m_app_model`（明文对象，不是加密 ByteArray）：

| 字段 | 值 | 含义 |
|---|---|---|
| `minVersion` | `"11.0"` | 低于此 Flash Player 弹升级 HTML |
| `recVersion` | `"11.6"` | 推荐版本 |
| `id` | `"BleachVSNaruto_3_3"` | 应用 id |
| `easys` | `["kong"]` | Kongregate 视为 easy（放宽脚本权限） |
| `params.allowScriptAccess` | `"always"` | 缺则报错或 reload |
| `params.allowNetworking` | `"all"` | 同上 |
| `recParams.allowFullScreen` | `"true"` | 建议参数 |
| `loading` | `LOADING_bvn` | 加载图标类 |
| `forceSH` | `false` | 不强制 serviceHold |
| `forceSHCheck` | `true` | 仍检查 4399/SH 就绪 |
| `publishDate` | `"2019-4-28 00:00:00"` | 发布戳 |
| `latency` | `864000000` | 10 天毫秒，和缓存/等待有关 |

`m_platforms` 两组（`types` / `filters` 为 charCode 数组）：

| types 解码 | 平台 |
|---|---|
| `4399` + `"sh"` | 4399 + 山海（SH）API |
| `kongregate` + `"kong"` | Kongregate |

`filters` 是域名通配（`*.4399.com`、`4399.cn`、`kongregate.com` 等）的字节串，由 `com.sh.Ǽ` 的正则 `^\*\.` → `(\S+.){0,}` 匹配当前页域名。

`init_fb()` 顺序：

1. `Security.allowDomain("*")` / `allowInsecureDomain("*")`（除非 `ǻ.ˉ`）
2. 构造 `ǹ.ǿ` 应用模型
3. `ȁ.Ȁ.compare(当前版本, minVersion)`，过低则 `show_html(get_outdate_html())`
4. 若在网页环境 `ǻ.ˌ`：
   - 有 JS 桥 `Ǻ.ɯ`：核对 `allowScriptAccess` / `allowNetworking`，不符则 `Ǻ.reload` 带正确参数
   - 无 JS 桥且 `ǻ.§˘§`（`file:///`）：`showError(getLabel("localURL"))` —— **禁止本地 file 协议直接打开**
   - 非 easy 平台且缺脚本/网络权限：`allowScriptAccess` / `allowNetworking` 中文报错
5. `updateLoadingUI()`
6. 若 `serviceHold.ˢ`（已挂 4399 Hold）则 `set_hold`；否则 `forceSHCheck` 继续等

`labelXML` 内置中英繁俄：配置错误、Flash 过旧、`file:///` 不允许、缺 `allowNetworking` / `allowScriptAccess`。

## 体积门（完整性）

`ɕ.ȑ.§ͦ§()`（`decompiled/main/scripts/ɕ/ȑ.as` 第 185–195 行）：

```
ǵ.ɐ.bytesTotal
  == ǵ.ɐ.timeline.loaderInfo.bytes.length
```

（`loaderInfo` / `bytes` / `length` 均用 `uts(charCodes)` 拼出。）

- 相等 → 函数返回 `false`（不视为「体积异常」），继续 `§ͧ§` 初始化应用
- 不等 → 返回 `true`，走 `§͸§` 失败/等待路径

含义：SWF 声明长度、加载器 `bytesTotal`、时间轴 `loaderInfo.bytes` 必须一致。追加 overlay、截断、或用另一个 Loader 套壳都会触发。同文件 `labelXML` 还有：

- `appError`：「程序发生错误：重要数据被破坏」
- `shell`：「不允许加壳运行」

`§ͣ§` 在 `ǵ.ɐ.Ʌ` 时若 `!FB.serviceHold.ˢ && FB.serviceHold.isReady` 则直接 `FB.showError("不允许加壳运行")`。这是 **反套壳**：再包一层 Loader 运行会被拒。

主文件实测：`declared_length == actual_length == 69431196`（`INVENTORY.md`），因此原包通过体积门。

## LocalConnection

两处，职责不同。

### 壳：`ɕ.ȑ`

静态 `§͙§:LocalConnection`。应用字节若不是 `DisplayObject`（嵌套 SWF 字节），则：

1. 随机 `connectionName = "message_" + 随机数`
2. `Ǿ.loadBytes` 加载内层，`parameters` 带上 `connectionName`、`connectionLength`、`in4399`、`ready4399`
3. 监听 `asyncError` / `status`

这是壳与内层 SWF 的进程内信道，不是游戏玩法协议。

### 引擎：`GameInterfaceManager`

`decompiled/main/scripts/net/play5d/game/bvn/web/GameInterfaceManager.as`：

```actionscript
if (new LocalConnection().domain == "localhost")  // 108,111,99,97,108,104,111,115,116
    bleachvsnaruto.STAGE.addEventListener("5d_message", messageHandler);
```

仅当 LC 域名为 `localhost` 时监听自定义 `DataEvent("5d_message")`。`MainGame.goMenu` 会 `dispatchEvent(DataEvent("5d_message", …, JSON.stringify(["go_menu_stage"])))`。`moreGames()` 同样派发 `["more_games"]`。这是 play5d 给本地包装页（或调试桥）的消息，不是 4399 官方 API。

## 4399 钩子

### 壳侧 `com.sh.Ǽ`（SH / serviceHold）

路径：`decompiled/main/scripts/com/sh/Ǽ.as`。

- 用 `ExternalInterface.call` 读 `location.ancestorOrigins` / `document.referrer` / `document.domain` 判定宿主域名
- 与 `m_platforms.filters` 正则匹配 4399 / Kongregate
- 成功则把 4399 `Hold` 对象交给 `FB.set_hold` → 最终写入 `bleachvsnaruto.serviceHold`

### 应用侧 `bleachvsnaruto`

`decompiled/main/scripts/bleachvsnaruto_2.as`：

| 成员 | 值 |
|---|---|
| `_4399_function_gameList_id` | `944c23f5e64a80647f8d0f3435f5c7a8` |
| `_4399_function_score_id` | `d8c8d4731a33a0a581edc746e73eadc7200` |
| `serviceHold` | 默认 `null`；`setHold()` 由壳注入 |
| `MAP_LOGO_STATE` | 此处赋 `1`（显示地图 `logo4399`） |

`setHold(obj)` 是 4399 容器调用的入口。

### `Ctrler4399`

`decompiled/main/scripts/net/play5d/game/bvn/web/Ctrler4399.as`：

- 监听 `GAME_OVER` / `GAME_PASS_ALL`
- 在结束画面插入 `SubmitScoreBtn`
- `showRank()` → `serviceHold.showSort()`
- `submitScore()` → `serviceHold.showRefer(score)`（score≤0 直接 return）

`GameInterfaceManager.moreGames()` → `serviceHold.showGameList()`。无 `serviceHold` 时这些调用是空操作（本地 Ruffle 即如此）。

`MapMain.normalizeLayer`：若 `GameConfig.MAP_LOGO_STATE != 1`，隐藏实例名 `logo4399`。应用把该值设为 1，所以原版地图会留 4399 logo。

## com.green 网络层

| 类 | 路径 | 职责 |
|---|---|---|
| `com.green.net.ǽ` | `com/green/net/ǽ.as` | 二进制 `URLLoader` 包装：url/ms/repeat、onStart/onProgress/onComplete/onError/onFail |
| `com.green.net.Ǿ` | `com/green/net/Ǿ.as` | 继承 `ǽ` 的 `Loader`/`loadBytes`，可设 `ApplicationDomain` |
| `com.green.method.Ǻ` | `com/green/method/Ǻ.as` | 读页面 embed 参数、`reload` 刷新页面 |
| `com.green.method.ǻ` | `com/green/method/ǻ_2.as` | 环境探测：`LocalConnection.domain`、`Security.pageDomain`、语言 `cn`、是否 `file:///` |

`FB` 里 `text_bin_loader:ǽ`、`swf_loader:Ǿ` 用于壳自己拉配置/内层字节（本包应用主体已嵌入，不一定再走 HTTP）。

## ƒ.ǵ / ƒ.Ǵ — 运行时容器

`ƒ.ǵ`（文件 `ǵ_2.as`，类名 `ǵ`）：

- 单例 `ɐ`（current）
- `Ȱ`：绑定主 MC、停时间轴、加三层容器、注册 FrameTask
- 监听 `loaderInfo` 的 init/progress/complete/unload/ioError
- 用 `nextFrame()` 泵任务直到 `framesLoaded`
- `uts` / `gd` = `fromCharCode` / `getDefinitionByName`，调用 `flash.external.ExternalInterface`
- `setHold` 被写到主 MC 上，供 4399 容器调用

`ƒ.Ǵ`：`version = "2.0"`（Alias `"version"`），`[FrameTask] ȝ()` 创建加载条 `Ƿ.Ƕ`，处理 throttle（后台降帧）与 activate/deactivate。

`ƒ.ŋ`：自定义 namespace，FB/ȑ 用它暴露内部方法。

## 其余混淆包（清单）

| 路径 | 类 | 角色（据引用） |
|---|---|---|
| `ƃ/FB.as` | `FB` | 壳门面：版本、平台、loading、报错 HTML |
| `ɕ/ȑ.as` | `ȑ` | 应用启动、体积门、反套壳、LC |
| `ƒ/ǵ_2.as` | `ǵ` | 时间轴容器单例 |
| `ƒ/Ǵ.as` | `Ǵ` | 加载 UI FrameTask |
| `ƒ/ŋ.as` | `ŋ` | namespace |
| `com/green/net/ǽ.as` | `ǽ` | URLLoader |
| `com/green/net/Ǿ.as` | `Ǿ` | SWF Loader |
| `com/green/method/Ǻ.as` | `Ǻ` | embed 参数 / reload |
| `com/green/method/ǻ_2.as` | `ǻ` | 运行环境探测 |
| `com/sh/Ǽ.as` | `Ǽ` | 4399/SH 域名与 Hold |
| `com/sh/ȇ.as` `Ȉ.as` | | SH 辅助 |
| `ǹ/ǿ.as` | `ǿ` | 解析 `m_app_model` |
| `ǹ/Ǹ.as` `ȃ.as` `Ȍ.as` `Ȓ.as` | | 模型/多语言碎片 |
| `ȁ/Ȁ.as` | `Ȁ` | 版本号 compare |
| `ȁ/Ȃ.as` `Ȅ.as` | | 字节解码 / 完整性辅助 |
| `Ƿ/Ƕ.as` | `Ƕ` | 加载条显示对象 |
| `Ȇ/ȅ.as` `ȍ.as` | | 壳工具 |
| `Ȋ/Ǵ.as` | namespace | green.net 使用 |
| `Ȋ/ȉ.as` | 事件回调表 | onEvent 分发 |
| `Ȋ/ȋ.as` | 重复计数 | `repeat` |
| `Ȋ/Ȏ.as` | 状态 | |
| `Ȑ/ȏ.as` | 事件类型 | complete 等 |

完整路径见 [`CLASS-INDEX.md`](CLASS-INDEX.md) 的 `main / shell-obfuscated` 分组。

## 对本地 Ruffle 的含义

- `file:///` 会被 `FB` 拦住；必须 HTTP（仓库已有 `play/start-server.sh` → `127.0.0.1:8765`）。
- 体积门要求改包后 **文件长度与 loaderInfo.bytes 一致**。FFDec `-importScript` 回写若改变长度，需整文件替换，不能只改中间一段还假装原大小。
- `serviceHold == null` 时排行榜/更多游戏/提交分数为空操作，不影响开打。
- `allowScriptAccess` / `allowNetworking` 在 Ruffle 配置里通常放宽，不走 4399 reload。
- 不要把壳 DoABC（前两帧）当引擎改；玩法补丁在 `net.play5d` 与 ZIP 内资源。

## 证据

| ID | 路径 |
|---|---|
| E-shell-doc | `decompiled/main/scripts/BleachVSNaruto.as` |
| E-fb-model | `decompiled/main/scripts/ƃ/FB.as` `m_app_model` / `m_platforms` |
| E-volume | `decompiled/main/scripts/ɕ/ȑ.as` `§ͦ§` |
| E-lc-engine | `GameInterfaceManager.as` `LocalConnection().domain` |
| E-4399 | `bleachvsnaruto_2.as` `serviceHold`；`Ctrler4399.as` |
| E-inventory | `extracted/full/INVENTORY.md` 三帧 / 四 DoABC |
