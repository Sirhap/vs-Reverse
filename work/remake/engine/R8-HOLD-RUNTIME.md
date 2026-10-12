# R8 — 4399 Hold 运行态指纹（本轮证据）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-12 ~01:36 CST**（本地 stub PASS + **EI 探针 PASS**；线上仍 BLOCKED；**R8 离线侧可结**） |
| 静态门 | **够关** — 阻塞写清 + 本地 Hold 面 + 离线 `hold=null` + stub 反射 + **EI addCallback 探针** |
| 缺口 | G13 / SHELL R8（**Documented-gap**；线上=BLOCKED；本地 stub=**PASS**；EI 探针=**PASS**） |
| 线上实例指纹 | **BLOCKED**（2026-10-11 ~22:15 CST；见 §1） |
| 本地 stub | **PASS**（`LOCAL-HOLD-STUB-FINGERPRINT.json`；标明非线上） |
| EI 探针 | **PASS**（`R8-EI-PROBE-RESULT.json`；`HoldProbe.swf` addCallback；非 sample） |
| main.swf | **未改**（`5ddf9410…ba3e`） |
| R8 离线结案 | **可结** — stub+探针+静态门齐；线上仍 Documented-gap |

---

## 1. 结论（诚实）

| 问 | 答 |
|----|----|
| 线上 Hold 抓取结果？ | **BLOCKED**（2026-10-11 ~22:15 CST）— `checkflash`→`blockflashtip`；无 `#flashgame`；登录健康墙；无 `in4399`/`ready4399`/`[FC]` |
| 本轮能否交付「线上 Hold 实例指纹」？ | **否** — `ONLINE-HOLD-FINGERPRINT.json` **未写** |
| 本地 stub？ | **PASS** — `127.0.0.1:8765/r8-hold-stub/` 反射 `isReady`（null→false / bind→true）+ 7 直通方法；Ruffle 已载 `main.swf` 但 **`setHold` 未暴露为 EI** |
| EI 探针？ | **PASS** — 另打 `HoldProbe.swf`（`ExternalInterface.addCallback("setHold")`）；页 JS `setHold(mock)` → `isReady` false→true；6 直通 + `probePing`；见 §3.4 |
| Ruffle+4399？ | **不可行**（Hold 指纹）— 见 §7 / `RUFFLE-4399-EVAL.json` |
| 是否阻塞离线完美包？ | **否** — G13 Documented-gap；静态门够关；`hold=null` 空路径可打；**R8 离线侧可结** |
| 再开条件（线上）？ | 需 **原生 Flash**（或等价）**且** 4399 **容器**执行 `timeline.setHold(hold)` |

---

## 2. 线上捕获阻塞（为何 curl/WebFetch 不够）

1. Hold **不是** HTML 字面量：`205551_4.htm` 仅 `OBJECT#flashgame` embed；页脚 JS **无** `setHold`/`Hold`。  
2. 常见 CDN `hold.js` 探测失败 — **无公开独立 Hold SDK**。  
3. 注入链：4399 **容器** → `timeline.setHold(hold)`（`ǵ.ȷ`）→ `change` → `FB.set_hold` → `Ǽ.bind` → 游戏 `bleachvsnaruto.setHold(raw)`。实例字段只在 **容器注入后** 存在。  
4. ~22:15 desktop：无 Flash → embed 被换掉；指纹对象未出现。

证据：`ONLINE-HOLD-ATTEMPT-2026-10-11.json` + 三截图 + `ONLINE-CAPTURE-BLOCKED.json`。

---

## 3. 本地替代证据

### 3.1 壳契约（静态；本轮加深）

见 `LOCAL-HOLD-SURFACE.json`（更新 2026-10-12）/ `SHELL-SYMBOL-MAP.md` §R8：

| 方向 | 名称 |
|------|------|
| 注入 | `setHold` / `Ǽ.bind` |
| 读 | `hold` / `isReady` / `isLog` |
| 直通 | `showGameList` `showSort` `showRefer` `showLogPanel` `userLogOut` `changeScore`；`renderTime`→`getServerTime` |
| 事件 | stage `logreturn(.ret)` / `userLoginOut` / `MVC_CLOSE_PANEL` / `serverTimeEvent(.data="Y-M-D H:i:s")` |
| 登录 ret | `uid` / `name` / `nickName`（`ȇ`；超此为 runtime-only） |
| 游戏消费 | `GameInterfaceManager`/`Ctrler4399` → raw hold：`showGameList`/`showSort`/`showRefer(score)` |
| 反套壳 | `inLoader && !ˢ && isReady` → shell error（`ȑ.§ͣ§`） |
| 域 | `ˢ` 4399 家族 glob（含 `4399wanju`/`3304399`） |

本包：`forceSH=false`，`forceSHCheck=true`。非 4399 → `set_hold(false)` → bind 空 → **`isReady=false`**。

### 3.2 本地 Hold stub（本轮 PASS）

| 项 | 值 |
|----|----|
| URL | `http://127.0.0.1:8765/r8-hold-stub/index.html` |
| 实现 | `play/r8-hold-stub/hold-mock.js`（`MinimalHoldMock` + `ServiceHoldReflector`） |
| null 路径 | `isReady=false` |
| bind 路径 | `isReady=true`；methods=`changeScore,getServerTime,showGameList,showLogPanel,showRefer,showSort,userLogOut` |
| 直通探针 | showGameList/showSort/showRefer(12345)/changeScore(1)/showLogPanel/renderTime → call_log 已记 |
| Ruffle | `main.swf` **loaded=true**；`ruffle-player.setHold === undefined`（MC 属性 ≠ EI callback） |
| play 包装 | `main.js` **无** setHold/Hold 字面量 — stub 独立页，未改游戏 SWF |
| 落盘 | `r8-evidence/LOCAL-HOLD-STUB-FINGERPRINT.json`（`online:false` / `LOCAL_STUB_PASS`） |

**诚实边界**：stub 证明壳/游戏契约可反射；**不等于**线上 Hold 类型名/额外字段/实测 `logreturn.ret`。


### 3.4 EI 探针 SWF（本轮 PASS；另打，未动 sample）

| 项 | 值 |
|----|----|
| 目的 | 证明：当 `setHold` 经 **`ExternalInterface.addCallback`** 注册时，Ruffle **会**把它暴露给页 JS（对比 main.swf MC 属性不可调） |
| SWF | `play/r8-hold-stub/HoldProbe.swf`（源 `work/remake/engine/r8-probe/src/HoldProbe.as`；mxmlc 编出 ~2114 B） |
| 页 | `http://127.0.0.1:8765/r8-hold-stub/ei-probe.html` |
| 验证 | headless Chrome dump-dom + curl 静态 200；`R8-EI-PROBE-RESULT.json` → **PASS** |
| null | `player.isReady()===false` |
| setHold(mock) | `typeof player.setHold==="function"`；返回 true；`isReady()===true` |
| 直通 | showGameList/showSort/showRefer/changeScore/showLogPanel/renderTime 均 `ok` |
| ping | `probePing()==="R8-EI-PROBE-OK"` |
| EI 局限 | JS mock 经 EI 进 AS 后 **函数字段被丢**（仅数据属性 `_uid/_name/…`）；直通由 SWF 侧 addCallback + `__R8_EI_PASSTHRU__` 回调页 |
| sample | **未改** `5ddf9410…ba3e`；未碰 hatch |

**桌面复验（需父代理 computerUse 时）**

1. 确认 `play/serve-8765.py` 在听 `127.0.0.1:8765`。  
2. 打开 `http://127.0.0.1:8765/r8-hold-stub/ei-probe.html`。  
3. 看 banner 下日志：`setHold=function`、`null-path isReady=false`、`bound-path isReady=true`、`result=PASS`。  
4. 可选：DevTools `window.__R8_EI_PROBE_RESULT__`。  
5. **勿**用本页替换线上 4399；**勿**改 `games/*/main.swf`。

### 3.3 仍仅 runtime-only（线上）

- Hold 对象 **真实类型名** / 超直通面的可枚举属性  
- `logreturn.ret` 超 `uid/name/nickName` 的实测字段  
- `serverTimeEvent.data` 线上样例  
- 4399 域下 `in4399=true` / `ready4399=true` 日志行  

---

## 4. 需父代理 — 线上指纹再开条件

前置：原生 Flash（或带 **容器 setHold** 的 4399 环境）。仅装 Ruffle 扩展 **不够**（§7）。

步骤仍见旧 §4 提纲；成功后写 `ONLINE-HOLD-FINGERPRINT.json` 并将 §1 改为 CAPTURED。

**勿改**仓库根 `main.swf`；勿碰 hatch/生产。

---

## 5. 静态门是否够关（复核 2026-10-12 ~01:36）

| 门 | 状态 | 说明 |
|----|------|------|
| 阻塞文档 | **PASS** | ONLINE-CAPTURE-BLOCKED + ONLINE-HOLD-ATTEMPT + 本文件 |
| 页面临界 | **PASS** | 4399 HTML + 五件脚 JS 无 Hold 字面量 |
| 本地 Hold 面 | **PASS** | `LOCAL-HOLD-SURFACE.json`（壳+游戏消费+事件样例+反套壳） |
| 离线空路径 | **PASS** | `hold=null` / `isReady=false` |
| 本地 stub 反射 | **PASS** | `LOCAL-HOLD-STUB-FINGERPRINT.json`（非线上） |
| EI addCallback 探针 | **PASS** | `R8-EI-PROBE-RESULT.json`；`HoldProbe.swf`（另打） |
| Ruffle+4399 | **NOT_FEASIBLE** | `RUFFLE-4399-EVAL.json` |
| 线上实例指纹 | **BLOCKED** | 不挡离线完美包 / G13 Documented-gap |

→ **静态门够关；R8 离线侧可结**（stub PASS + EI 探针 PASS + 文档齐）；线上仍 Documented-gap/BLOCKED。

---

## 6. 交叉

- `G13-G15-OFFLINE.md` · `WRAPPER-API.md` §3/§6  
- `work/full-analysis/shell/SHELL-SYMBOL-MAP.md` §R8  
- `REMAKE-GAP-INVENTORY.md` G13  
- stub 源：`play/r8-hold-stub/`
- EI 探针：`play/r8-hold-stub/{HoldProbe.swf,ei-probe.html}` · `work/remake/engine/r8-probe/` · `r8-evidence/R8-EI-PROBE-RESULT.json`

---

## 7. Ruffle + 4399 评估（结论：不可行）

详见 `r8-evidence/RUFFLE-4399-EVAL.json`。

| 障碍 | 说明 |
|------|------|
| checkflash | 无原生 Flash → `#swfdiv` 换成 `blockflashtip`；无 embed 给 Ruffle 升级 |
| 登录墙 | 健康系统「先登录再游戏」 |
| Hold 不在页 JS | 由 4399 **容器**调 `timeline.setHold`；页内无桥 |
| Ruffle EI | `main.swf`：`setHold` 非 addCallback，JS 调不到 MC 属性；**另打** `HoldProbe.swf` addCallback → JS **可调**（探针 PASS） |

假设 Ruffle 扩展在 checkflash 前劫持 embed：SWF 或可播，但 **仍无人 setHold** → `isReady=false`，只是离线空路径，**不是**线上指纹。
