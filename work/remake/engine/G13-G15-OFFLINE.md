# G13–G15 离线完美包边角（Phase E2）

| 项 | 值 |
|----|----|
| 日期 | 2026-10-12 ~01:36 CST（G13 本地 stub PASS + EI 探针 PASS；**R8 离线侧可结**） |
| 范围 | R8 Hold（G13）· 第三方库（G14）· main.js minify（G15） |
| 总判 | **不挡离线完美包**；文档闭合即可 |
| main.swf | **未改** |

## G13 — R8 4399 Hold 实例指纹

| | |
|--|--|
| 判定 | **Documented-gap**（线上）；本地 stub **PASS**；EI 探针 **PASS**；**R8 离线侧可结** |
| 静态 | `SHELL-SYMBOL-MAP.md` §R8 + `LOCAL-HOLD-SURFACE.json`（壳直通 + 游戏消费 + 事件样例 + 反套壳） |
| 本地 | `hold=null` → `isReady=false`；**stub PASS**（`LOCAL-HOLD-STUB-FINGERPRINT.json` @ `127.0.0.1:8765/r8-hold-stub/`） |
| EI 探针 | **PASS** — 另打 `HoldProbe.swf`（`addCallback("setHold")`）；页 JS `setHold(mock)`；`R8-EI-PROBE-RESULT.json`；未动 sample/main.swf |
| 线上 | **BLOCKED**（2026-10-11 ~22:15 CST）— checkflash→blockflashtip + 登录墙；指纹 JSON 未写 |
| Ruffle+4399 | **NOT_FEASIBLE**（Hold 指纹）— `RUFFLE-4399-EVAL.json` |
| 再开条件 | **原生 Flash** + 4399 **容器** `timeline.setHold(hold)`（仅 Ruffle 不够） |
| 完美包 | BUILD 声明「不含 4399 Hold 指纹」；保留 `local-runtime-guard.js` |
| 证据 | `R8-HOLD-RUNTIME.md`；`r8-evidence/`（ONLINE-ATTEMPT、LOCAL-SURFACE、LOCAL-STUB、**EI-PROBE**、RUFFLE-EVAL） |
| 静态门 | **够关**（2026-10-12 ~01:36 复核） |
| DONE | 离线策略 + stub 契约反射 + EI 探针；**离线侧结案**；线上指纹仍 Documented-gap/BLOCKED |

## G14 — 第三方（greensock / deng.fzip / fl.motion / adobe…）

| | |
|--|--|
| 策略 | **原样保留** ABC；不强制重命名或抽换 |
| 理由 | 非游戏逻辑可读门；抽换易毁 ZIP/缓动/动画 |
| DONE | 本条 + 缺口表勾选 |

## G15 — main.js 完整 minify 语义图

| | |
|--|--|
| 策略 | **只维** `WRAPPER-API.md` 中 size/flashframe/ad/HTTP 约定 |
| 非目标 | 全文反混淆（REA `analyze_javascript_application` 对 main.js 易 OOM） |
| DONE | API 表落盘；U15 维持 Documented-Unreadable |

## 交叉

- `work/remake/engine/WRAPPER-API.md`
- `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md` G13–G15
- `work/full-analysis/FULL-READABILITY-STATUS.md` R8
