# wrapper / main.js API 表（重制必维）（G15 / Phase E2）

| 项 | 值 |
|----|----|
| 日期 | 2026-10-11 17:55 CST（UTC+8） |
| 包装 | `main.js` wrapper **4.8.1** + `ruffle.js`；入口 `index.html` + `local-runtime-guard.js` |
| 权威 metas | `Po("{{metas}}",u("<base64>"))` 内 JSON（REA §4.4 已核） |
| 原包 size | `app.size["main.swf"]=69431196`；`app.flashframe=2` |
| 工具 | `tools/patch_size_gate.py` · `tools/serve_check.sh` · `work/remake/SIZE-GATE.md` |
| 策略 | **只维护 metas/约定 API**；不强制全文反混淆（U15 Documented-Unreadable） |
| main.swf | **未改** |

## 1. metas JSON（改包后必须同步）

原包解码示例：

```json
{
  "info.id": "BleachVSNaruto_3_3",
  "info.developer": "d",
  "info.name": "BleachVsNaruto",
  "info.version": "3.3.1",
  "info.date": "2026-04-11 09:56:02",
  "element.container": "#container",
  "app.size": { "main.swf": 69431196 },
  "app.flashframe": 2
}
```

| 键 | 类型 | 重制要求 |
|----|------|----------|
| `app.size["main.swf"]` | int | **= 磁盘字节 = SWF FileLength = 壳双 ASCII 门**；`patch_size_gate.py --main-js` 写入 |
| `app.flashframe` | int | **保持 `2`**（时间轴离开帧 1 / 进入 FB·FC 后摘 LOADING）；`serve_check.sh` 断言 |
| `info.id` / `info.name` | string | 默认可保留；改渠道名不影响离线玩，但勿弄坏 JSON |
| `info.version` | string | 壳渠道版 `3.3.1`（≠ ABC `V3.3`）；可随 BUILD 戳改，非体积门 |
| `info.date` | string | 可选更新 |
| `element.container` | CSS sel | 保持 `#container`（与 `index.html` 一致） |
| `info.developer` | string | 原样即可 |

**禁止**：手改 base64 漏改 `app.size`；把 `flashframe` 改成 0/1（LOADING 不摘或过早摘）。

## 2. 包装行为 API（重制须满足的运行约定）

| 约定 | 值 / 行为 | 失败表现 | 检查 |
|------|-----------|----------|------|
| 协议 | **HTTP(S)** 页面（推荐 `127.0.0.1:8765`） | `file:///` 壳/包装拒载或异常 | `serve_check.sh` |
| SWF 名 | 与 metas `app.size` 键一致，默认 `main.swf` | 进度/体积校验错 | 目录约定 |
| Flash 路径 | 有插件 → `<object movie=main.swf>` | — | `BVN-ANALYSIS` §2.5 |
| Ruffle 路径 | 无插件 → `ruffle.js` XHR `arraybuffer` → `player.load({data, allowNetworking:"all", splashScreen:false})` | 黑屏/卡 LOADING | 保留 `allowNetworking:"all"` |
| wrapper 版本文本 | 字面量 `4.8.1` | 非门禁 | 勿误删 |
| LOADING 摘除 | 等 SWF 到 `app.flashframe`（2） | 一直卡 LOADING | flashframe=2 |
| blank-ad | `play/blank-ad.swf`（相对 guard：`../../blank-ad.swf`）须 **HTTP 404** | 广告位坑 / 0% splash | `serve_check`；**不要**放可加载 blank SWF |
| 广告 DOM | guard 隐藏 `#m-o,#m-i,#ad-sign,#loading-start-button` 等 | 挡点击 | 保留 `local-runtime-guard.js` |
| games XML stub | guard 对 games 列表返回含 default→blank URL 的 XML，且该 URL **404** | Empty `<games>` 挂 0% | guard 注释已写明 |

## 3. 与壳 / 游戏的交接（G13 交界）

| 方向 | API | 离线完美包 |
|------|-----|------------|
| 页 → 壳 | 4399 **Hold** 注入 / `setHold` | **`hold=null`**：`ServiceHold.isReady=false`，空路径可打；**不含 4399 Hold 指纹**（声明见下 G13） |
| 壳 → 页 | `ExternalInterface`（`uts` 拼名 / `console.g` 等） | Ruffle `allowNetworking:"all"`；不依赖真实 4399 DOM |
| 游戏 → 包装 | 无强依赖 metas 字段名以外的 minify 符号 | 只维 metas |

完整 minify 语义图：**不强制**（堆满 / OOM 见 `REA-REANALYSIS`）；游戏逻辑不在 `main.js`。

## 4. 改包操作清单（size / flashframe / ad）

```bash
# 1) SWF 变长后三处体积门 + metas size
python3 tools/patch_size_gate.py play/games/<build>/main.swf \
  --main-js play/games/<build>/main.js

# 2) 校验
python3 tools/patch_size_gate.py play/games/<build>/main.swf \
  --main-js play/games/<build>/main.js --verify

# 3) HTTP + blank-ad 404 + flashframe=2
tools/serve_check.sh --game <build> [--start]
```

复制包装时一并带上：`index.html`、`main.js`、`ruffle.js`（或相对 vendor）、`local-runtime-guard.js`；**不要**提交可加载的 `blank-ad.swf`。

## 5. G14 / G15 处理（同 Phase E2）

| ID | 项 | 完美包策略 |
|----|-----|------------|
| G14 | greensock / fzip / fl.motion / adobe 等 | **原样保留**；不强制游戏命名重构 |
| G15 | `main.js` minify 全文 | **Closed-for-remake**：上表 API + metas 即可；反混淆非目标 |

## 6. 离线包声明模板（可进 BUILD.txt）

```
Offline perfect package:
- No 4399 Hold instance fingerprint (hold=null / local-runtime-guard).
- Wrapper metas: app.flashframe=2; app.size[main.swf]=<bytes>.
- blank-ad.swf must 404; serve via HTTP :8765 (or equiv).
- Third-party ABC (greensock/fzip/…) kept as upstream.
```

## 交叉引用

| 文档 | 用途 |
|------|------|
| `REA-REANALYSIS-2026-10-11.md` §4.4 | metas 实证 |
| `work/remake/SIZE-GATE.md` | 体积门工具 |
| `work/full-analysis/shell/SHELL-SYMBOL-MAP.md` §R8 | Hold API |
| `local-runtime-guard.js` | blank-ad / 广告锁 |
| `BVN-ANALYSIS.md` §2.5 | HTML/Ruffle 树 |

未改 `/workspace/bvn-3.3/main.swf`。
