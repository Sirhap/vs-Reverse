# `ƃ.FB` — 配置门、平台白名单、远程更新

一句话目的：FrameTask 第二步。核 Flash 版本、embed 权限、file:///、4399 Hold，再按域名决定是否拉 `data.vsgod.win`。失败则 HTML 错误页，成功则换加载条。

源文件：`decompiled/main/scripts/ƃ/FB.as`（692 行）

## Callers / callees

- **Callers**：`ƒ.ǵ.ȹ` 通过 `[FrameTask]` 调 `init_fb`。`ɕ.ȑ` 读 `serviceHold`、`text_bin_loader`、`swf_loader`、`remote*`、`wait`、`showError`、`getInstanceBy`、`bind`、`updateLoadingUI`。
- **Callees**：`ǻ`（环境）、`Ǻ`（embed/reload）、`ǹ.ǿ`（模型）、`ȁ.Ȁ`（版本）、`ȁ.Ȃ`/`Ȅ`（远程解码）、`com.sh.Ǽ`（Hold）、`Ȇ.ȅ`（HTML 文本）、`ƒ.ǵ`/`ƒ.Ǵ`/`Ƿ.Ƕ`。

## 符号对照（本文件）

见 `SHELL-SYMBOL-MAP.md` 的 `ƃ.FB` 段。`m_app_model` 与 `m_platforms` 已在那里展开。

## 逐行说明

### 静态字段（L29–78）

- `app_model`：解析后的 `ǿ`。
- `wait`：公开；远程 overlay 可把它置 true，让 `ȑ.Ͳ` 推迟 addChild。本包未见写入，默认 false。
- `m_sh_manager = new Ǽ()`：即使不在 4399 也有空 Hold 包装。`isReady` = `!!hold`，初始 false。
- `text_bin_loader` / `swf_loader`：`ŋ` 可见。
- `m_app_model`：明文对象，不是 ByteArray。`init_fb` 因此走 `else if (m_app_model)` 分支。
- `m_platforms`：charCode 数组，见符号表解码。
- `labelXML`：配置错误、版本过低、file:///、缺 allow* 的中英繁（俄文仅 localURL）。

### 空构造（L80–83）

全静态。

### `init_fb`（L85–219）—— FrameTask 入口

顺序：

1. **非 AIR Desktop** 则 `Security.allowDomain("*")` + `allowInsecureDomain("*")`。
2. **建 AppModel**：若 `m_app_model is Class`，`new` 成 ByteArray 再 `Ȃ.§̝§` 当 JSON（本包不是）；否则直接 `new ǿ(object, m_platforms)`。失败 → `showError(confError)` 并 return。
3. **版本门**：`Ȁ.compare(ǻ.§˒§, minVersion) < 0` → `show_html(get_outdate_html())` return。本包 min=`11.0`。
4. **网页环境 `ǻ.ˌ`**：
   - **有 JS 桥 `Ǻ.ɯ`**：对照 `params`（必须项）与页面实际 PARAM（`Ǻ.ʽ`）。不符则记入 `_loc4_`。再扫 `recParams`（建议项，本包 `allowFullScreen=true`）同样补进 `_loc4_`。若有任何需要改的：`ǵ.dispose()` + `Ǻ.reload(0, null, _loc4_)` **return**（页面会重挂 SWF，本次启动结束）。
   - **无 JS 桥**：若 `ǻ.§˘§`（HTML 是 file:///）→ `showError(localURL)`。否则若 **不是 easy 平台** → `showError(allowScriptAccess, 无 networking 则再附 allowNetworking 文案)`。Kongregate（easy）缺脚本权限也放行。
5. `updateLoadingUI()`：把 `LOADING_bvn` 放到进度层。
6. **Hold**：
   - `serviceHold.ˢ`（当前域是 4399 家族）：若已有 `userData`（`ǵ.Ʉ`，即页面已 `setHold`）立刻 `set_hold(forceSH)`；否则听 `"change"`。**return**（不在这里 start_remote；forceSH 为真才会在拿到服务器时间后拉远程）。
   - 否则若 `forceSHCheck`（本包 true）：`set_hold(false)` 或等 change。`false` 表示绑 Hold 但不因服务器时间去拉远程。
7. **按域名**：
   - `localhost`：仅当 `ǻ.ˏ`（独立/External 播放器）时，等 `"appAdded"` 再 `start_remote(false)`。浏览器里的 localhost HTTP **不会**在这里登记远程。
   - `edit.4399.com`：直接 return（编辑器预览不拉远程）。
   - **其它**：`start_remote()`（网页 4399 已在步骤 6 return，所以这里主要是非 4399 网页）。

Ruffle + 本地 HTTP：通常 `ˌ` 真、JS 桥视实现而定；`forceSHCheck` 会 `set_hold(false)`；域名若是 127.0.0.1 不是 `localhost` 字符串，会落到 default → `start_remote()` 去请求 `data.vsgod.win`（离线会失败）。`ȑ` 把远程错误当成可跳过，游戏仍 addChild。

### `bind`（L221–229）

`ŋ` 偏函数：`f.apply(thisObj, preset.concat(runtimeArgs))`。给 `addEventListener("change", bind(set_hold, null, forceSH))` 用。

### `get_domain` 族（L232–295）

与 `ǿ.get_domain` 同文：JS ancestorOrigins → Security.pageDomain → 空 Loader 的 loaderURL。`file:` → `"localhost"`。`uts`/`gd`/`uri_*` 同上。

### `set_hold`（L297–304）

`serviceHold.§˜§(ǵ.Ʉ, ǵ.timeline)`：把页面注入的 Hold 对象和主 MC 交给 `com.sh.Ǽ`，并开始听 4399 舞台事件。若 `param1`（forceSH）：`getServerTime(bind(start_remote, null, true))` —— 用服务器时间走 latency 窗。本包 `forceSH=false`，4399 路径在 `set_hold` 后**不**自动远程。

### `start_remote`（L306–316）

`param2` 当 Date（来自服务器）否则 `new Date()`。若 `param1 && now-publishDate < latency` → return（发布 10 天内跳过）。否则 `text_bin_loader.onComplete = on_bin_loaded`，`load(get_url("http://data.vsgod.win/v1", date))`。这是 GreenHD 的远程配置/热更通道，不是游戏 ZIP。

### `remoteLoading` / `remoteSkipped` / `remoteLoaded`（L319–332）

busy / 两 loader 都还 READY / overlay COMPLETE。`ȑ.§ͭ§`：若正在远程加载则先听 error，否则直接 addApp。

### `on_bin_loaded`（L334–398）

1. 若签名 `/\wWS/`（FWS/CWS/ZWS）→ `load_bytes` 当 overlay SWF。
2. 否则 `Ȃ.§̤§` 成字符串：
   - 当 XML：取 `xml[appID]` 或 `xml["default"]` 当 URL。
   - 当 JSON：同样按 appID / default。
   - 当 `scheme://host` 正则 → 当 URL。
3. 全失败则静默（不 showError）。`ȑ` 的 error 监听只覆盖 io/security/deal，**complete 但解析不出 URL 不算错误**，随后 addApp。

### `load_url` / `get_swf_loader` / `load_bytes`（L400–417）

overlay Loader：父容器 `ǵ.Ƀ`，**新 ApplicationDomain**（与游戏隔离），`parameters = ǵ.Ƚ()`（FM/FA/FB/FC 别名信息）。

### `get_url`（L419–452）

拆原 URL 的 query，覆盖：

- `id` = app_model.id
- `r` = 本地则 `Y-M-D H:M:S`，否则只 `Y-M-D`

键排序后拼回。缓存破坏 + 带上应用 id。

### `show_html`（L454–475）

`dispose` + `clearChildren` + 停两个 loader。`new ȅ()`（HTML TextField），`§̵§(html)`，过宽则 wordWrap，居中 addChild 到**时间轴**（不是 appContainer）。这会盖住后续游戏，除非不再 addApp。

### `getInstanceBy`（L477–514）

`ŋ`。若 `def` 已经是 rest 里某个 Class 的实例，原样返回。否则 String→`gd`+`new`，Class→`new`，Array→charCode 类名再 new。最后又 `classes.some(is_class)`，但 **无论是否匹配都 `return ins`**（第二个 if 与落空 return 相同）。`ȑ.§ͥ§` 传 `DisplayObject, ByteArray`：`bleachvsnaruto` 是 Class，`new` 出来是 Sprite，命中 DisplayObject。

### `get_error_html` / `get_outdate_html`（L516–640）

内嵌 HTML+CSS（微软雅黑）。错误页：`#error` 标题 + `<li>` 列表（空则 unknowError）。升级页：替换 `#tittle/warn/info1-3`，`#min/#rec/#cur`，`#update` 做成指向 `http://get.adobe.com/flashplayer` 的 `<a>`。

### `getLabel`（L642–646）

`labelXML[key][@language] || @en`。language 来自 `Ǵ.language` = `Capabilities.language`（`zh-CN` 等）。

### `updateLoadingUI`（L648–659）

`getInstanceBy(loading, DisplayObject)` → `Ǵ.Ȥ(clip, applyState)`。失败且 `param2` 则用 `Ƕ` 转圈。`ȑ.§ͣ§` 调 `updateLoadingUI(false)` 换条但不立刻刷进度。

### `showError`（L661–665）

`show_html(get_error_html(rest))`。`ȑ.§͸§` 先 unshift `appError` 文案。

### 公开 getter（L667–689）

`appID` / `shouldWait`（waitTop，本包 false）/ `PUBLISH_DATE` / `serviceHold`。
