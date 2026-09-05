# GreenHD 壳符号对照表

权威源：`decompiled/main/scripts/`。`[Alias(key="charCodes")]` 已用 `String.fromCharCode` 还原。`?` 表示静态证据不足。

壳分三步（时间轴帧标签）：**FM** = `ƒ.ǵ`（Frame Manager）、**FA** = `ƒ.Ǵ`（加载 UI）、**FB** = `ƃ.FB`（配置门）、**FC** = `ɕ.ȑ`（应用宿主）。文档类 `BleachVSNaruto` 只把时间轴交给 FM。

---

## 包

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƒ` | `greenload.runtime` | 时间轴容器、FrameTask 泵、三层 Sprite |
| `ƃ` | `greenload.fb` | 配置门 / 平台 / 远程更新 |
| `ɕ` | `greenload.fc` | 体积门、反套壳、实例化 `bleachvsnaruto` |
| `ǹ` | `greenload.model` | AppModel / 平台匹配 / 加载状态 / 事件 |
| `ȁ` | `greenload.codec` | 版本号、字符串编解码、SWF 头编解码 |
| `Ȋ` | `greenload.net.internal` | Loader 状态机、回调表、重复计数、ns |
| `Ȑ` | `greenload.net.events` | `load_*` 事件 |
| `Ƿ` | `greenload.ui` | 默认转圈加载条 |
| `com.green.net` | `com.green.net` | URLLoader / Loader 包装 |
| `com.green.method` | `com.green.method` | 环境探测 / JS embed 桥 |
| `com.sh` | `com.sh` | 4399 Hold（不在本清单源文件内，FB/ȑ 的 callee） |
| `Ȇ` | `greenload.htmltext` | 错误页 HTML TextField（不在清单内，FB callee） |

## 命名空间

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƒ.ŋ` | `greenload_internal` | FB / ȑ 用来暴露壳内部方法（`bind`、`text_bin_loader` 等） |
| `Ȋ.Ǵ` | `greenload`（URI `http://www.greenhd.net/ns/greenload`） | `ǽ`/`Ǿ`/`Ȏ` 的内部 setter（`setType`） |

---

## `ƒ` — 运行时容器

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƒ.ǵ` | `FrameManager` | 壳单例；绑定主 MC、停时间轴、泵 FrameTask |
| `ǵ.ɐ` / Alias `current` | `current` | 单例 getter |
| `ǵ.ɍ` | `_instance` | 私有单例槽 |
| `ǵ.Ɏ` | `_taskers` | FrameTask 类队列（`ƒ.Ǵ`、`ƃ.FB`、`ɕ.ȑ`） |
| `ǵ.ɏ` | `_logs` | 带时间戳的 trace 缓冲 |
| `ǵ.Ȩ` | `_userData` / Hold 对象 | `setHold` 注入的 4399 Hold |
| `ǵ.ȩ` | `_taskIndex` | 已执行的 FrameTask 下标 |
| `ǵ.Ȫ` | `_bytesTotal` | 来自 `[Background(color="#4236f9c")]` → `0x4236f9c` = 69431196 |
| `ǵ.ȫ` | `_isDebugSWF` | `describeType` 有 `__go_to_definition_help` 则为调试 SWF |
| `ǵ.Ȭ` | `_timeline` | 文档类 MovieClip |
| `ǵ.ȭ` | `_appContainer` | 底层，放游戏实例 |
| `ǵ.Ȯ` | `_progressBarContainer` | 中层，放加载条 |
| `ǵ.ȯ` | `_remoteContainer` | 顶层，放远程 SWF overlay |
| `ǵ.Ȱ` | `attach` | 文档类构造调用：停时间轴、叠三层、注册任务 |
| `ǵ.ȱ` | `readFrameTaskMeta` | 读自身 `[FrameTask(p2=ƃ,c2=FB,p3=ɕ,c3=ȑ)]` |
| `ǵ.Ȳ` | `installTimelineHooks` | 把 `setHold`/`size` 写到主 MC；读 Background / debug 元数据 |
| `ǵ.ȳ` | `onAddedToStage` | 泵帧 + 监听 loaderInfo |
| `ǵ.ȴ` | `listenLoaderInfo` | init/progress/complete/unload/ioError |
| `ǵ.ȵ` | `pumpFrames` | `nextFrame()` 直到 `framesLoaded`，再跑 FrameTask |
| `ǵ.Ȣ` | `onLoaderInfo` | 先泵帧再把事件转发出去 |
| `ǵ.ȶ` | `forwardEvent` | `willTrigger` 才 `dispatchEvent` |
| `ǵ.ȷ` | `setHold` | 写 `_userData`，派 `change` |
| `ǵ.ȸ` | `metaNamed` | `describeType` 过滤 metadata |
| `ǵ.ȹ` | `runFrameTasks` | 对每个已加载帧找 `[FrameTask]` 静态方法并调用 |
| `ǵ.Ⱥ` | `taskNameAt` | 任务类名字符串 |
| `ǵ.Ȼ` | `taskClassAt` | `getDefinitionByName` 或直接 Class |
| `ǵ.ȼ` | `appendTask` | 去重入队 |
| `ǵ.Ƚ` | `aliasInfo` | `{type:"Alias", FM, FA, FB, FC}` 给远程 SWF 参数 |
| `ǵ.Ⱦ` | `fillBackground` | 全屏纯色（FA 启动时填黑） |
| `ǵ.dispose` | `dispose` | 卸 loaderInfo 监听、清空任务、派 `clear` |
| `ǵ.ȿ` | `clearChildren` | 卸掉时间轴全部子节点 |
| `ǵ.ɀ` | `clearBackground` | `graphics.clear` |
| `ǵ.Ɂ` | `appContainer` | Alias `appContainer` |
| `ǵ.ɂ` | `progressBarContainer` | Alias `progressBarContainer` |
| `ǵ.Ƀ` | `remoteContainer` | Alias `remoteContainer` |
| `ǵ.Ʉ` | `userData` | Alias `userData`（Hold） |
| `ǵ.Ʌ` | `inLoader` | `!!timeline.loaderInfo.loader` |
| `ǵ.Ɇ` | `stepTotal` | 任务数 |
| `ǵ.ɇ` | `isTop` | 舞台中心点命中是否落在本时间轴内 |
| `ǵ.Ɉ` | `isDebugSWF` | 体积门跳过条件 |
| `ǵ.ɉ` | `loaded` | `framesLoaded == totalFrames` |
| `ǵ.Ɋ` | `taskers` | 队列副本 + Alias 信息 |
| `ǵ.ɋ` | `logs` | 日志数组 |
| `ǵ.Ɍ` | `pushLog` | 时间戳 + `trace` + `ExternalInterface.call("console.g", …)` |
| `ǵ.uts` | `fromCharCode` | 字符串还原 |
| `ǵ.ɑ` | `jsCall` | `ExternalInterface.call.apply` |
| `ǵ.gd` | `getDefinitionByName` | 反射 |
| `ǵ.ɒ` | `qualifiedName` | `getQualifiedClassName` |
| `ǵ.Ȧ` | `logFM` | 前缀 `[FM]` |

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƒ.Ǵ` | `FrameAdapter` / `LoadingUI` | FrameTask FA：加载条、throttle、activate |
| `Ǵ.version` | `version` | `"2.0"` |
| `Ǵ.labelXML` | `labelXML` | progress / unload / ioError 中英繁俄 |
| `Ǵ.Ȝ` | `_bar` | 当前进度条 DisplayObject |
| `Ǵ.ț` | `_uiState` | `ǹ.Ǹ` 进度/文案/节流/激活 |
| `Ǵ.ȝ` | `initLoadingUI` | `[FrameTask]` 入口 |
| `Ǵ.Ȟ` | `setProgress` | 写状态并反射 `progress`/`setProgress` |
| `Ǵ.ȟ` | `setLabel` | 写状态并反射 `label`/`setLabel` |
| `Ǵ.Ƞ` | `onThrottle` | `state != "resume"` → 节流中 |
| `Ǵ.ȡ` | `onActivate` | activate/deactivate |
| `Ǵ.Ȣ` | `onLoadEvent` | complete/progress/ioError/unload/clear |
| `Ǵ.ȣ` | `removeProgressBar` | 从舞台卸条 |
| `Ǵ.Ȥ` | `changeProgressBar` | 换成自定义或默认转圈 |
| `Ǵ.ȥ` | `applyToBar` | 按 key/type 反射设属性或调方法 |
| `Ǵ.Ȧ` | `logFA` | 前缀 `[FA]` |
| `Ǵ.ȧ` | `throttled` | Alias `throttle` |
| `Ǵ.active` | `active` | 窗口是否前台 |
| `Ǵ.language` | `language` | `Capabilities.language` |
| `Ǵ.getLabel` | `getLabel` | 多语言 XML |

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƒ.ŋ` | `greenload_internal` | namespace 声明，无成员 |

---

## `ƃ.FB` — 配置门

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ƃ.FB` | `FrameBridge` | 版本/embed 参数/平台/远程配置 |
| `FB.app_model` | `_appModel` | 解析后的 `ǹ.ǿ` |
| `FB.m_app_model` | `RAW_APP_MODEL` | 明文对象（本包不是加密 ByteArray） |
| `FB.m_platforms` | `PLATFORMS` | 4399 / Kongregate 域名通配 |
| `FB.m_sh_manager` | `_serviceHold` | `com.sh.Ǽ` 实例 |
| `FB.wait` | `wait` | 远程 overlay 要求继续等 |
| `FB.text_bin_loader` | `textBinLoader` | 拉 `data.vsgod.win/v1` |
| `FB.swf_loader` | `swfLoader` | 远程 SWF overlay |
| `FB.init_fb` | `init_fb` | `[FrameTask]` 入口 |
| `FB.bind` | `bind` | 偏函数 |
| `FB.get_domain` | `getPageHostname` | JS ancestorOrigins / referrer / Security.pageDomain |
| `FB.get_domain_of` | `hostnameOf` | `file:` → `localhost` |
| `FB.set_hold` | `bindHold` | `serviceHold.bind(userData, timeline)`；`forceSH` 则等服务器时间 |
| `FB.start_remote` | `startRemote` | 拉远程文本/SWF；发布未满 latency 则跳过 |
| `FB.remoteLoading` | `remoteLoading` | 任一 loader 忙 |
| `FB.remoteSkipped` | `remoteSkipped` | 两 loader 都还是 READY |
| `FB.remoteLoaded` | `remoteLoaded` | overlay SWF COMPLETE |
| `FB.on_bin_loaded` | `onBinLoaded` | SWF 魔数 / XML / JSON / 纯 URL |
| `FB.load_url` / `load_bytes` | | overlay 加载 |
| `FB.get_url` | `appendCacheBust` | `?id=&r=` 排序查询串 |
| `FB.show_html` | `showHtml` | 用 `Ȇ.ȅ` 居中显示 HTML 错误页 |
| `FB.getInstanceBy` | `getInstanceBy` | Class/String/Array → 实例，并按类型过滤 |
| `FB.get_error_html` / `get_outdate_html` | | 错误/升级页模板 |
| `FB.updateLoadingUI` | `updateLoadingUI` | `LOADING_bvn` 或默认转圈 |
| `FB.showError` | `showError` | 配置/权限/体积失败 UI |
| `FB.appID` | `ID` | `"BleachVSNaruto_3_3"` |
| `FB.shouldWait` | `WAITTOP` | `waitTop`（本包 `false`） |
| `FB.PUBLISH_DATE` | `PUBLISH_DATE` | `2019-4-28` |
| `FB.serviceHold` | `serviceHold` | 4399 Hold 包装 |

`m_app_model` 字段（明文）：`minVersion=11.0`、`recVersion=11.6`、`id=BleachVSNaruto_3_3`、`easys=["kong"]`、`params.allowScriptAccess=always`、`params.allowNetworking=all`、`recParams.allowFullScreen=true`、`loading=LOADING_bvn`、`forceSH=false`、`forceSHCheck=true`、`publishDate=2019-4-28 00:00:00`、`latency=864000000`（10 天毫秒）。

`m_platforms.filters` 解码：

- 4399：`*.(((4399(api|pk|dmw|er|en)?|(505|edu)?4399|3387).com)|4399.cn|4399.net)`，types=`4399` + `sh`
- Kongregate：`*.(kongregate|kongcdn).com`，types=`kongregate` + `kong`

---

## `ɕ.ȑ` — 应用宿主

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ɕ.ȑ` | `FrameContent` | 体积门、反套壳、addChild 游戏 |
| `ȑ.§͚§` | `appType` | `0` 无 / `1` DisplayObject / `2` ByteArray→Loader |
| `ȑ.§͛§` | `asVersion` | `3`（本包）或 `2`（AVM1） |
| `ȑ.§͜§` | `connectionSalt` | `Math.random()*0xFFFFFF` |
| `ȑ.§͝§` | `appDisplay` | 上舞台的 DisplayObject |
| `ȑ.§͞§` | `appInstance` | `bleachvsnaruto` 或 ByteArray |
| `ȑ.§͟§` | `connectionName` | `"message_" + salt` |
| `ȑ.§͠§` | `isWaiting` | 在等 throttle / waitTop / 远程 |
| `ȑ.§͘§` | `appLoader` | `com.green.net.Ǿ` |
| `ȑ.§͙§` | `appLC` | `LocalConnection` |
| `ȑ.§͡§` | `LOG_TAG` | `"[FC]"` |
| `ȑ.Ȧ` | `logFC` | 前缀 `[FC]` → `ǵ.Ɍ` |
| `ȑ.labelXML` | `labelXML` | `appError` / `shell` |
| `ȑ.§͗§` | `APP_DEF` | **`bleachvsnaruto` 类对象** |
| `ȑ.§͢§` | `boot` | `[FrameTask]`：已 loaded 则立刻 `onAppLoaded`，否则听 `complete` |
| `ȑ.§ͣ§` | `onAppLoaded` | 反套壳 → 体积门 → `initApp` |
| `ȑ.§ͤ§` | `isDebugStandalone` | `Capabilities.isDebugger && (External\|\|StandAlone)`；**本文件无调用** |
| `ȑ.§ͥ§` | `materializeApp` | Class/ByteArray/拼接数组 → 实例 |
| `ȑ.§ͦ§` | `isSizeTampered` | `bytesTotal != loaderInfo.bytes.length` |
| `ȑ.§ͧ§` | `initApp` | DO 直挂 vs `loadBytes` + LC |
| `ȑ.§ͨ§` | `onInnerSwf` | AVM1 包一层 Sprite；AVM3 取 content |
| `ȑ.§ͩ§` | `onLcStatus` | LC asyncError/status → trace |
| `ȑ.§ͪ§` | `setVolume` | AVM1 路径先静音再恢复 |
| `ȑ.§ͫ§` | `lcClient` | `{moregames, rank, score, getData}` |
| `ȑ.§ͬ§` | `dispatchGameApi` | 派 `as2/as3game_event`，默认调 Hold |
| `ȑ.§ͭ§` | `afterInit` | 派 `appInit`；远程忙则听错误 |
| `ȑ.§ͮ§` | `listenRemoteErrors` | 挂/卸三个 `load_*_error` |
| `ȑ.§ͯ§` | `onRemoteError` | 远程失败仍继续 addApp |
| `ȑ.Ͱ` | `reloadApp` | 停 loader、关 LC、卸实例、重跑 `onAppLoaded` |
| `ȑ.ͱ` | `clearBytes` | 清掉 ByteArray 素材 |
| `ȑ.Ͳ` | `shouldWait` | 远程 wait / throttle / waitTop 且非 isTop |
| `ȑ.ͳ` | `onWaitTick` | enterFrame 等到不必等 |
| `ȑ.ʹ` | `injectHoldAndState` | `setHold(hold)`；尝试 `__info__.setState`（本包 `__info__` 恒 null） |
| `ȑ.§͵§` | `addAppToStage` | **第二道体积门** `#04236f9c` |
| `ȑ.Ͷ` | `onStageFill` | 等到舞台中心有子节点再卸加载条 |
| `ȑ.ͷ` | `stageCenterEmpty` | 中心点无对象 |
| `ȑ.§͸§` | `failApp` | `appError` → `FB.showError` |
| `ȑ.§͹§` | `connectManager` | `connect(name+"_app_to_manager")` |
| `ȑ.ͺ` | `sendToApp` | `send(name+"_manager_to_app", …)` |
| `ȑ.ͻ` | `app` | 舞台上的 DO |
| `ȑ.instance` | `instance` | 素材/类实例 |
| `ȑ.ͼ` | `appType` | getter |
| `ȑ.ͽ` | `actionscriptVersion` | getter |
| `ȑ.§;§` | `appLoaderInfo` | type2 用 inner loader，否则主 SWF |
| `ȑ.Ϳ` | `appLoader` | |
| `ȑ.§΀§` | `appLocalConnection` | |
| `ȑ.§΁§` | `appConnectionName` | |
| `ȑ.§΂§` | `cancelWaiting` | |
| `ȑ.§΃§` | `addApp` | 门闩后 `addAppToStage` |
| `ȑ.§΄§` | `isReady` | `!!appDisplay` |
| `ȑ.§΅§` | `appInfo` | 想读 `__info__`，**实际恒 `null`** |
| `ȑ.Ά` | `infoDealing` | 恒 `false`（死代码） |
| `ȑ.§·§` | `unityDealing` | AS3 且 `isStarted != true` |
| `ȑ.§͌§` | `isWaiting` | |
| `ȑ.Έ` | `isPlaying` | `appDisplay.stage` |
| `ȑ.ɋ` | `logs` | 过滤 `[FC]` 前缀 |

体积门目标：`0x04236f9c = 69431196`（与 SWF FileLength、`#4236f9c` 同一数值）。

---

## `com.green.net`

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `com.green.net.ǽ` | `BinLoader` | 二进制 `URLLoader`：url/ms/repeat、回调、状态机 |
| `ǽ.§̀§` | `DEFAULT_REPEAT` | `uint.MAX` |
| `ǽ.§́§` | `DEFAULT_RELOAD_MS` | `2000` |
| `ǽ.ˤ` | `_urlLoader` | |
| `ǽ.§˥§` | `_request` | |
| `ǽ.ms` | `reloadDelay` | 失败重试间隔 |
| `ǽ.§˦§` | `_logLines` | 新日志 unshift 到头 |
| `ǽ.§˧§` | `_state` | `Ȋ.Ȏ` |
| `ǽ.§˨§` | `_count` | `Ȋ.ȋ` |
| `ǽ.§˩§` | `_callbacks` | `Ȋ.ȉ` |
| `ǽ.§˪§` | `_tStart` | `getTimer` |
| `ǽ.§˫§` | `_tEnd` | |
| `ǽ.§˭§` | `configure` | String→url；Object→字段；`start:true` 立刻 load |
| `ǽ.ˮ` | `applyOptions` | |
| `ǽ.ˬ` | `hookLoader` | |
| `ǽ.§˯§` | `onLoaderEvent` | |
| `ǽ.§˰§` | `enterStart` | state=START，++count，`load_start` |
| `ǽ.§˱§` | `enterWaiting` | `setTimeout(start, ms)` |
| `ǽ.§˲§` | `enterOpen` | |
| `ǽ.§˳§` | `enterProgress` | |
| `ǽ.§˴§` | `enterDealing` | 子类可覆盖（`Ǿ` 在这里 `loadBytes`） |
| `ǽ.§˵§` | `enterComplete` | |
| `ǽ.§˶§` | `enterSecurityError` | 直接 fail |
| `ǽ.§˷§` | `enterIOError` | 未耗尽 repeat 则等待重试 |
| `ǽ.§˸§` | `enterFail` | |
| `ǽ.§˹§` | `repeatExhausted` | |
| `ǽ.§˺§` | `data` | `ByteArray` |
| `ǽ.§˻§` | `progressText` | `%` 或 `loaded/total` |
| `ǽ.§˼§` | `bytesLoaded` | |
| `ǽ.§˽§` | `logAll` | 时间正序 |
| `ǽ.ɋ` | `logLines` | |
| `ǽ.§˾§` | `addProgressListeners` | progress/fail/complete |
| `ǽ.§˿§` | `elapsed` | |

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `com.green.net.Ǿ` | `SwfLoader` | 继承 `ǽ`，`Loader.loadBytes` |
| `Ǿ.§̂§` | `_context` | `LoaderContext` |
| `Ǿ.§̃§` | `_dealing` | 正在 loadBytes |
| `Ǿ.§̄§` | `onBytesEvent` | complete → 可选 `addChild`；ioError → fail |
| `Ǿ.§̅§` | `loaderContext` | |
| `Ǿ.container` | `container` | 父容器；若运行时有 `requestedContentParenu` 则写入 context（Adobe 内部拼写） |

---

## `com.green.method`

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ǻ` | `Env` | 播放器/页面/语言/协议探测（文件 `ǻ_2.as`） |
| `ǻ.ˁ` | `isCnLang` | `language` 归一成 `cn` |
| `ǻ.ʶ` | `objectID` | `ExternalInterface.objectID` |
| `ǻ.§˂§` | `pageDomain` | `Security.pageDomain`（若存在） |
| `ǻ.currentDomain` | `currentDomain` | `new LocalConnection().domain` |
| `ǻ.§˃§` | `hasThrottleEvent` | FP11.2+ |
| `ǻ.§˄§` | `canNavigate` | `navigateToURL` 不抛 SecurityError |
| `ǻ.§˅§` | `jsEvalOk` | `ExternalInterface.call("eval", true)` |
| `ǻ.ˆ` | `clipboardSet` | AIR Clipboard |
| `ǻ.ˇ` | `Capabilities` | |
| `ǻ.ˈ` | `playerType` | |
| `ǻ.ˉ` | `isDesktop` | AIR Desktop；此时 **不** `allowDomain("*")` |
| `ǻ.ɵ` | `isActiveX` | |
| `ǻ.ˊ` | `isPepper` | PlugIn + manufacturer 含 Pepper |
| `ǻ.ˋ` | `isPlugIn` | |
| `ǻ.ˌ` | `isBrowser` | ActiveX \|\| PlugIn |
| `ǻ.ʸ` | `loaderURL` | 空 Loader 的 `contentLoaderInfo.loaderURL` |
| `ǻ.ˍ` | `loaderIsFile` | loaderURL 以 `file:` 起 |
| `ǻ.ˎ` | `isDebugger` | |
| `ǻ.ˏ` | `isExternalOrStandalone` | |
| `ǻ.ː` | `versionFloat` | 如 `11.6` |
| `ǻ.ˑ` | `capabilitiesVersionRaw` | `"WIN 11,6,0,0"` 一类 |
| `ǻ.§˒§` | `versionTail` | 空格后最后一段，给 `Ȁ.compare` |
| `ǻ.§˓§` | `versionDots` | 逗号改点 |
| `ǻ.§˔§` | `language` | 可选把 `zh-*` 收成 `cn` |
| `ǻ.§˕§` | `nowString` | `Y-M-D[ H:i:s[.ms]]` |
| `ǻ.§˖§` | `hasTouch` | Multitouch.supportedGestures |
| `ǻ.§˗§` | `quit` | NativeApplication.exit / JS close / fscommand quit |
| `ǻ.§˘§` | `isFileProtocolPage` | 故意 `call("''.toString")` 吃 errorID 2060，从报文抠 `file:///` |

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `Ǻ` | `JsEmbed` | 定位 `<embed>`/`<object>`、读 PARAM、reload |
| `Ǻ.ɮ` | `_jsOkCached` | |
| `Ǻ.ɯ` | `jsAvailable` | `eval("true")==true` |
| `Ǻ.flash` | `flashElementExpr` | 能拿到当前 SWF DOM 节点的 JS 表达式 |
| `Ǻ.ʽ` | `getParam` | EMBED 属性或 OBJECT 子 PARAM |
| `Ǻ.ʾ` | `defaultParams` | wmode/allow* 默认值 |
| `Ǻ.reload` | `reload` | `setTimeout` 克隆节点并改 PARAM |
| `Ǻ.ˀ` | `reloadScript` | 生成那段替换节点的 JS |
| `Ǻ.objectID` | `objectID` | |
| 其余 `ɩ`–`ʿ` | 见 `com/green/method/Ǻ.md` | DOM/fullscreen/location 工具，FB 只用到 `ɯ/ʽ/ʾ/reload` |

---

## `ǹ` 模型

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ǹ.ǿ` | `AppModel` | 包装 `m_app_model` + 平台匹配 |
| `ǿ.§̆§` | `_raw` | |
| `ǿ.§̇§` | `_platform` | `ǹ.Ȍ` |
| `ǿ.§̈§` | `raw` | |
| `ǿ.easy` | `easy` | 当前域匹配 `easys`（本包仅 `kong`） |
| `ǿ.latency` | `latencyMs` | Number / `HH:MM:SS` / `NdNh` 解析；**`HH:MM` 分支反编译用了未赋值 `_loc4_`，静态不可信** |
| `ǹ.Ȍ` | `PlatformMatcher` | 域名 glob → types |
| `Ȍ.§̓§` | `_types` | 命中平台后写入的 type 字符串 |
| `Ȍ.§̈́§` | `_domain` | |
| `Ȍ.ˣ` | `matchFilter` | `*.x` → `(\S+.){0,}x` |
| `Ȍ.§ͅ§` | `hasType` | type 列表或再跑一遍 glob |
| `Ȍ.§͆§` | `decodeToken` | charCode 数组或 String |
| `ǹ.Ǹ` | `LoadingUiState` | progress/label/throttled/active |
| `Ǹ.m_progress` / `ɡ` / `ɥ` | progress | |
| `Ǹ.ɞ` / `ɢ` / `ɦ` | label | |
| `Ǹ.ɟ` / `ɣ` / `ɧ` | throttled | |
| `Ǹ.ɠ` / `ɤ` / `ɨ` | active | 默认 `true` |
| `ǹ.ȃ` | `AppLifecycleEvent` | |
| `ȃ.§̧§` | `APP_INIT` | `"appInit"` |
| `ȃ.§̨§` | `APP_ADDED` | `"appAdded"` |
| `ǹ.Ȓ` | `AppKind` | `0/1/2`；**壳内无引用**，数值对齐 `ȑ.appType` |

---

## `ȁ` 编解码

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `ȁ.Ȁ` | `Version` | `"11.6"` 比较 |
| `Ȁ.§̉§` | `_raw` | |
| `Ȁ.§̊§` | `_nums` | |
| `Ȁ.§̏§` | `normalize` | 数字段 join `.` |
| `Ȁ.§̐§` | `parse` | 按 `.`/`,` 切，末段可带后缀 |
| `Ȁ.§̑§` | `suffix` | 非数字尾巴 |
| `Ȁ.§̒§` | `major` | |
| `Ȁ.§̓§` | `numericParts` | |
| `Ȁ.§̔§` | `numericPrefixEq` | |
| `Ȁ.compare` | `compare` | `<0` 表示 param1 < param2 |
| `Ȁ.§̋§` | `set` | |
| `Ȁ.§̌§` | `join` | |
| `Ȁ.§̍§` | `partCount` | |
| `Ȁ.§̎§` | `partAt` | |
| `ȁ.Ȃ` | `TextCodec` | JSON 去注释、编码探测、体积格式化 |
| `Ȃ.§̕§` / `ANSI` | `gb18030` | |
| `Ȃ.§̖§` | `utf-8` | |
| `Ȃ.§̗§` | `formatBytes` | B/KB/MB… |
| `Ȃ.§̘§` | `countSubstr` | |
| `Ȃ.§̙§` | `isCjk` | U+4E00–U+9FFF |
| `Ȃ.§̚§` | `dupPlusOne` | 重复 `n+1` 次（含原文） |
| `Ȃ.§̛§` | `repeat` | 重复 `n` 次 |
| `Ȃ.§̜§` | `parseJson` | 可选去注释 |
| `Ȃ.§̝§` | `bytesToJson` | FB 若 `m_app_model` 是 Class/ByteArray 会走这里 |
| `Ȃ.§̞§` | `trim` | |
| `Ȃ.§̟§` | `collapseBlankLines` | |
| `Ȃ.§̠§` | `stripComments` | `/* */` `//`，避开字符串 |
| `Ȃ.§̡§` | `fromCharCode` | |
| `Ȃ.§̢§` | `toCharCodes` | 可选偏移 |
| `Ȃ.§̣§` | `readMulti` | |
| `Ȃ.§̤§` | `bytesToString` | FB `on_bin_loaded` 用 |
| `Ȃ.§̥§` | `readAuto` | BOM / UTF-8 探测 |
| `Ȃ.§̦§` | `detectCharset` | FF FE / FE FF / EF BB / utf8 统计 |
| `Ȃ.isUTF8` | `isUTF8` | 多字节占比阈值 98% / 95%+30 |
| `ȁ.Ȅ` | `SwfCodec` | FWS/CWS/ZWS |
| `Ȅ.§̩§` | `repack` | 改签名并重压 |
| `Ȅ.§̪§` | `isSig` | |
| `Ȅ.§̫§` | `readFileLength` | offset 4 UI32 LE |
| `Ȅ.§̬§` | `decompressBody` | |
| `Ȅ.§̭§` | `lzmaBody` | ZWS → 标准 LZMA 流 |
| `Ȅ.§̮§` | `symbolClassNames` | 扫 tag 76 |
| `Ȅ.§̯§` | `integrityStub` | **恒 `false`** |
| `Ȅ.§̰§` | `scrambleHeader` | 随机化前 8 字节（ȑ 在 loadBytes 完成后调用） |
| `Ȅ.§̱§` | `readSig` | 前 3 字节 |

---

## `Ȋ` / `Ȑ` / `Ƿ`

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `Ȋ.Ǵ` | ns `greenload` | URI 见上 |
| `Ȋ.ȉ` | `LoadCallbacks` | onStart/Open/Progress/Complete/Error/Fail |
| `ȉ.§̾§` | `_loader` | 回调参数 |
| `ȉ.exec` | `exec` | 调函数 + 若 `willTrigger` 则派 `Ȑ.ȏ` |
| `Ȋ.ȋ` | `RepeatCounter` | |
| `ȋ.§̿§` | `_max` | `0` 被写成 `4294967295` |
| `ȋ.§̀§` / `ɐ` | `current` | |
| `ȋ.§́§` | `max` | |
| `ȋ.§͂§` | `reset` | |
| `ȋ.§˹§` | `exhausted` | `current >= max` |
| `Ȋ.Ȏ` | `LoadState` | 0 READY … 8 FAIL |
| `Ȏ.§͈§` | `_type` | |
| `Ȏ.setType` | `setType` | ns 内部 |
| `Ȏ.§͉§` | `isBusy` | loading \|\| waiting \|\| dealing |
| `Ȏ.§͊§` | `isLoading` | START/OPEN/PROGRESS |
| `Ȏ.§͋§` | `isOpenOrProgress` | |
| `Ȏ.§͌§` | `isWaiting` | |
| `Ȏ.§͍§` | `isDealing` | |
| `Ȏ.§͎§` | `isFinished` | complete \|\| fail |
| `Ȏ.§͏§` | `isComplete` | |
| `Ȏ.§͐§` | `isFail` | |
| `Ȏ.toString` | | **PROGRESS(3) 落入 `"unknow"`**（原文如此） |
| `Ȑ.ȏ` | `LoadEvent` | |
| `ȏ.§͖§` | `DEAL_ERROR` | `"load_deal_error"` |
| `ȏ.§͑§` | `isDealError` | |
| `ȏ.§͒§` | `isIOError` | |
| `ȏ.§͓§` | `isSecurityError` | |
| `ȏ.§͔§` | `isTransportError` | io \|\| security |
| `ȏ.§͐§` | `isFail` | |
| `ȏ.§͕§` | `isComplete` | |
| `ȏ.§͉§` | `isProgress` | |
| `Ƿ.Ƕ` | `Spinner` | 5 个圆点绕圈 |
| `Ƕ.ɝ` | `DEFAULT_COLOR` | `0xFFFFFF` |
| `Ƕ.ɓ` | `_dots` | 5×Shape |
| `Ƕ.loading` | `_keyframes` | `[0,0.2,1.5,1.86,3.4,3.6,5]` 秒 |
| `Ƕ.ɔ` | `_t0` | |
| `Ƕ.ɕ` / `ɚ` | `dotRadius` | 默认 3 |
| `Ƕ.ɖ` / `ɛ` | `color` | `>0xFFFFFF` 则用默认白 |
| `Ƕ.ɗ` / `ɜ` | `orbitRadius` | 默认 25 |
| `Ƕ.ɘ` | `applyKeyframe` | 旋转/透明度插值 |
| `Ƕ.ə` | `redraw` | |
| `Ƕ.align` | `align` | 恒 `"center"`（FA 用它居中） |

---

## 文档类 / 游戏交接（清单内）

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `BleachVSNaruto` | `DocumentClass` | 只调用 `ǵ.ɐ.Ȱ(this, Ǵ)` |
| `bleachvsnaruto` | `GameRoot` | 壳 addChild 之后的真正入口；`MainGame.initlize` |
| `bleachvsnaruto.setHold` | `setHold` | 壳 `ʹ` 注入 `serviceHold.hold` |
| `LOADING_bvn` | `LoadingClip` | `m_app_model.loading`（不在本清单） |

---

## `uts` / `gd` / `ɑ` 惯例

几乎每个混淆类都有：

```actionscript
uts(...codes)  // "".constructor.fromCharCode.apply(null, rest)
gd(name)       // getDefinitionByName
ɑ(fn, ...args) // ExternalInterface.call.apply(null, [fn].concat(args))
```

目的：ABC 字符串池里不出现 `loaderInfo`、`ExternalInterface` 等敏感名，运行时拼出来。

---

## 不在 `shell-files.txt`、但壳会调用

| 路径 | 建议名 | 为何出现 |
|------|--------|----------|
| `com/sh/Ǽ.as` | `ServiceHold` | `FB.serviceHold`；`ˢ` = 当前域是 4399 家族 |
| `com/sh/ȇ.as` `Ȉ.as` | Hold 事件 | login / serverTime |
| `Ȇ/ȅ.as` | `HtmlLabel` | `FB.show_html` → `§̵§(html)` |
| `LOADING_bvn.as` | 加载图标 MC | `updateLoadingUI` |
