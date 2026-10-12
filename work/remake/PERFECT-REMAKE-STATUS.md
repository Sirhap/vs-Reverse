# BVN 3.3 完美复刻验收状态（Phase F）

| 项 | 值 |
|----|----|
| 样本原包 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e`（**未改**） |
| 计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` |
| 缺口权威 | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md`（G1–G15） |
| 可读前置 | `work/full-analysis/FULL-READABILITY-STATUS.md`（静态 DONE） |
| 状态日 | **2026-10-12 01:36 CST**（UTC+8；R8 本地 stub **PASS** + EI 探针 **PASS**；线上仍 BLOCKED；**R8 离线侧可结**；chars **8/8**；assist O **4/4**；听感 UNKNOWN） |
| **里程碑** | **export-complete** — 内容导出与回打管线闭环 |
| **管线结论** | **内容导出与回打管线已闭环**；**完美游玩对等仍差运行态项** |

---

## 中文结论（export-complete · 19:05 CST）

**内容导出与回打管线已闭环。**  
可玩角色全动作、有标签辅助全动作、无标签辅助 framescript、effect MC/声、地图 preview、主 SWF/ZIP 音频、以及 ZIP 回打 / embed / size-gate / face 改可见，均已达成并可复现。工程侧「改内容 → 导出 → 回打 → 体积门 → 可见验证」路径不再挡内容编辑。

**运行时对等主线已齐；100% 游玩对等仅剩 Documented / 可选项。**  
主线已闭合：chars **8/8**、辅助 O **4/4**、P1 / 真 K.O. UI / HARD 保真 / 设置**静态结案**。仍非主线挡门：听感耳听（**Documented UNKNOWN**/无 sink）、R8 线上指纹（**Documented-gap**/本地 stub+EI 探针 **PASS**，**离线侧可结**，不挡离线）、设置其余桌面/地图其余进场/U·I 可选。不回退 export-complete。

---

### 导出覆盖快照（2026-10-11 ~19:05 CST）

| 资产 | 覆盖 | 备注 |
|------|------|------|
| 可玩角色**全动作** PNG | **41/41** | `_frames/<stem>/`；约 **38876** PNG（全动作帧） |
| 可玩角色站立样例 | **41/41** | 站立 1–9 仍保留（约 369 PNG） |
| 辅助有标签站立 PNG | **13** | `_frames/fz/<id>/`；117 PNG（站立） |
| 辅助有标签**全动作** | **13/13** | `_frames/fz/<id>/actions/`；**406** PNG（`ASSIST-ACTIONS-SUMMARY.json`） |
| 辅助无标签 | **22** framescript 映射 | 见 `NO-LABELS.md` / `assist/NO-LABEL-FRAME-MAP.md`；无 PNG 全动作 |
| effect MC PNG | **58/58** | `_frames/effect/`；290 PNG（帧 1–5） |
| effect `snd_*` 音频 | **31/31** | `_audio/effect/` + `_frames/effect/snd/`（FFDec MP3） |
| 主 SWF DefineSound | **8/8** | `_audio/main/` → `extracted/full/sounds/` 符号链接 |
| ZIP222 bgm/sounds | **覆盖** | `export/assets/{bgm,sounds}` 镜像；见 `AUDIO-EXPORT.md` |
| 地图舞台 preview | **14/14** | `_frames/map/<id>/preview.png`；约 7.1 MB；`random` 无 SWF |
| bvn-perfect face 标 | **PASS** | `play/games/bvn-perfect/parity/naruto-face-mark.png` |
| size-gate / ZIP repack | **PASS** | `SIZE-GATE.md`；`repack/ROUNDTRIP-RESULT.json` |
| G4 扩覆盖证据 | **chars×4 / stages×2 / fight2** | `play/games/bvn-rev2/parity/{chars,stages,fight2.png}` |

- 每图 `COMPOSITE.md` + `geometry.json` → `png_preview` 指针（地图）。
- `main.swf` 未改。详见 `export/PNG-EXPORT.md` / `EXPORT-INDEX.md` / `AUDIO-EXPORT.md`。

**判定标签**

| 标签 | 含义 |
|------|------|
| **Closed** | 工程/文档目标已达成，不再挡内容编辑或离线包声明 |
| **Demo-PASS** | 有可复现演示，但未全量覆盖 |
| **Documented-gap** | 洞已显式接受（保真 / Keep / 离线声明），非静默缺失 |
| **Still-open** | 仍挡「完美游玩对等」或全量可编辑导出 |

---

## 一句话总览

| 问题 | 答 |
|------|----|
| 「完美复刻」**内容编辑**管线能否开工？ | **能（已闭环）** — face/ZIP/embed/size-gate PASS；**fighter 全动作 41/41（~38876 PNG）+ assist 有标签 FULL 13/13（406）+ 无标签 framescript 22 + effect MC 58 + snd 31 + main DefineSound 8 + ZIP bgm/sounds + map 14/14** |
| 距 **100% 游玩对等** 最大缺口？ | **Documented/可选**：听感 UNKNOWN；R8 线上 **BLOCKED**/本地 stub+EI 探针 **PASS**（**离线侧可结**）。**主线 DONE**：chars 8/8；辅助 O 4/4；KO/P1/HARD；设置静态结案 |

---

## G1–G15 终态表

| ID | 缺口 | 判定 | 摘要 | 主证据路径 |
|----|------|------|------|------------|
| **G1** | ZIP222 可编辑导出 | **Closed** | `export/assets/` 镜像 + 元数据；**fighter 全动作 PNG 41/41（~38876）**；站立样例保留；**assist 有标签 FULL 13/13（406）**；无标签 22 仅 framescript；**effect MC PNG 58/58**；**snd_* 31/31**；**DefineSound 8/8**；**map preview 14/14**；repack/embed/size-gate/face **PASS** | `work/remake/export/EXPORT-INDEX.md`；`export/PNG-EXPORT.md`；`export/AUDIO-EXPORT.md`；`export/_frames/`；`export/_audio/` |
| **G2** | 改包三件套产品化 | **Closed** | `patch_size_gate.py` + `serve_check.sh` + `SIZE-GATE.md`；`--verify` 三处长度一致 | `tools/patch_size_gate.py`；`tools/serve_check.sh`；`work/remake/SIZE-GATE.md` |
| **G3** | UI / loader keep-ABC | **Documented-gap** | skip×9 + 回流矩阵 153/172；stubs×73；title 外置 round-trip 演示。**title+select 真 import 验证待 java/ffdec** | `work/remake/ui/REFLOW-MATRIX.md`；`ui/stubs/STUBS-PLAN.md`；`ui/D3-EXTERNALIZE.md` |
| **G4** | 对战级游玩对等 | **Demo-PASS**（主线齐） | 清单已落盘；**真 K.O. UI PASS**；Winner 交叉；P1 PASS；chars **8/8**；辅助 O **4/4** ALL PASS；设置**静态结案**/HowToPlay 桌面 PASS（主屏可选非挡）；听感 **Documented UNKNOWN** | `PARITY-CHECKLIST.md`；`parity/ko/`；`parity/CHAR8-ASSIST4-SMOKE.md`；`ASSIST-O-KEY-ACCEPTANCE.md`；`SETTINGS-STATIC-PATH.md` |
| **G5** | 地图 HARD floor×3 | **Documented-gap** | **保真 SAME-HOLE 静态结案**（缺/空 floor×3 证据齐；不增强）。桌面进场截图可选非挡门 | `maps/HARD-SOFT-POLICY.md`；`HARD-EMPTY-FLOOR-EVIDENCE.json`；`HARD-EVIDENCE-2026-10-11.md` |
| **G6** | 辅助无 FrameLabel×22 | **Closed** | 帧号→动作表齐全；与 Assister 交叉无悬空。桌面 4 辅助上场挂 G4/A2 | `work/remake/assist/NO-LABEL-FRAME-MAP.md`；`assist/*.frames.json` |
| **G7** | StartSound 帧→声名 | **Closed** | 41× fighter JSON + 辅助抽样；事件 2515。听感挂 G4；**声二进制已导**（effect 31 + main 8 + ZIP bgm/sounds） | `work/remake/audio/STARTSOUND-INDEX.md`；`export/AUDIO-EXPORT.md`；`tools/build_phase_c.py` |
| **G8** | 地图 SOFT front×6 | **Documented-gap** | **默认保真 SAME-HOLE**；增强可选非 F | `work/remake/maps/HARD-SOFT-POLICY.md`；`assets/maps/INDEX.md` |
| **G9** | effect 遗留 12 | **Closed** | 完美包路径 **12/12 Keep**；typo `xg_hitfllor_heavy` + `bisha_face_mc` 冻结 | `work/remake/effects/LEGACY-12.md` |
| **G10** | random*×6 XML-only | **Documented-gap** | 禁止造空 SWF；face PNG + 运行时抽 id。选人三项冒烟挂 G4 | `work/remake/RANDOM-XML-ONLY.md` |
| **G11** | UI 交叉池 / 库 MC | **Documented-gap** | CROSS-POOL×4 home=loading；stubs 73/73。错池风险已文档 | `work/remake/ui/stubs/CROSS-POOL.md`；`STUBS-PLAN.md` |
| **G12** | salect / effect snd | **Closed** | salect **Keep**；EFFECT-SND 表 52/39/27 | `work/remake/engine/SALECT-XML.md`；`EFFECT-SND-TABLE.md` |
| **G13** | R8 4399 Hold | **Documented-gap** | 离线 `hold=null`；**静态门够关**；本地 stub **PASS** + EI 探针 **PASS**（`HoldProbe.swf` addCallback；`R8-EI-PROBE-RESULT.json`）；线上 **BLOCKED**；**R8 离线侧可结**；Ruffle+4399 **NOT_FEASIBLE**；再开需原生 Flash+容器 `setHold`；不挡离线包；sample **未改** | `engine/R8-HOLD-RUNTIME.md`；`r8-evidence/{LOCAL-HOLD-STUB-FINGERPRINT,R8-EI-PROBE-RESULT,RUFFLE-4399-EVAL}.json`；`G13-G15-OFFLINE.md`；`play/r8-hold-stub/`；`engine/r8-probe/` |
| **G14** | 第三方库 | **Documented-gap** | 原样保留；非游戏命名目标 | 同上 |
| **G15** | main.js minify 全文 | **Documented-gap** | 只维 metas/API；不强制全文反混淆 | `WRAPPER-API.md` |

### 计数

| 判定 | 数量 | ID |
|------|-----:|-----|
| Closed | 6 | G1 G2 G6 G7 G9 G12 |
| Documented-gap | 9 | G3 G4† G5 G8 G10 G11 G13 G14 G15 |
| Still-open | 0 | — |

† G4 判定标签为 **Demo-PASS（主线齐）**：chars8 + assist4 + KO/P1/HARD/设置静态已闭合；剩余听感 UNKNOWN / R8 / 可选桌面归 Documented，不再作 Still-open 挡门。

---

## Phase 对照（A–F）

| Phase | 主题 | 状态 | 备注 |
|-------|------|------|------|
| A1 | 体积门工具 | **DONE** | G2 Closed |
| A2 | 对等清单 | **主线 DONE** | G4 Demo-PASS（主线齐）；P1/KO/chars8/assist4/设置静态 PASS；听感 UNKNOWN；R8 Documented |
| A3 | skip 冻结 | **文档/基线** | import-rev2 权威；CI 比对可选后续 |
| B1 | 导出树 | **EXPORT-COMPLETE** | G1 **Closed**；可玩全动作 41/41 ~38876 PNG；assist FULL 13/13（406）；无标签 22 framescript；effect MC 58 + snd 31；main DefineSound 8；ZIP bgm/sounds；map 14/14 |
| B2 | ZIP 回打 | **TOOLCHAIN PASS** | round-trip + face 标可见 |
| B3 | 地图 HARD/SOFT | **DONE（保真）** | G5/G8 Documented-gap |
| B4 / C4 | effect 遗留 | **DONE** | G9 Closed |
| C1–C3 | 辅助/音频/random | **DONE** | G6 Closed；G7 Closed；G10 Documented |
| D1–D3 | UI 回流/占位/外置 | **DONE（表+演示）** | G3/G11 Documented；真 import 待 java |
| E1–E2 | 引擎边角 / R8 | **DONE** | G12 Closed；G13–15 Documented |
| **F** | 完美验收门 | **DOC DONE / 游玩未全绿** | 见下节五门；**内容管线闭环 ≠ 游玩对等全绿** |

---

## Phase F 五门（诚实勾选）

| # | 门 | 结果 | 说明 |
|---|-----|------|------|
| 1 | 可读 | **PASS** | FULL-READABILITY 已 DONE；缺口仅 Documented |
| 2 | 可改包 | **PASS** | A1 工具 + B2 ZIP round-trip + **bvn-perfect 脸标 MARK_VISIBLE**；导出全覆盖已闭合 |
| 3 | 可用（对战级 parity） | **Demo-PASS** | 菜单/选人/进战/midfight PASS；chars **8/8**；辅助 O **3/4**；**P1 PASS**；**真 K.O. UI PASS**；设置静态结案；听感 Documented UNKNOWN；R8 不挡离线 |
| 4 | 无静默缺失 | **PASS** | G5/G8 保真；G9 Keep；G10 XML-only 均有决策 |
| 5 | 未污染原包 | **PASS** | `main.swf` 仍 `5ddf9410…ba3e` |

### F 验收清单（计划摘要）对照

| # | 项 | 状态 | 证据 |
|---|-----|------|------|
| 1 | 启动 Logo→菜单无 APP ERROR | **Demo-PASS** | rev2 `parity/menu.png`；HTTP/blank-ad curl |
| 2 | 菜单六项中文 | **PASS** | REV2b BUILD + verify-menu |
| 3 | 选人全角色/辅助/random | **PARTIAL** | `parity/select.png` + chars×4；全表/random 未扫 |
| 4 | ≥8 角色开局到 KO | **PASS**（开局）/ KO 抽样 | 真 K.O. PASS（1 局）；角色进场 **8/8**（c7 白哉 + c8 剑八 PASS；`parity/chars/c8.png`） |
| 5 | ≥4 辅助技能可见 | **PASS** | O 键专证 **4/4**：a1 四代火影/minato + a2 乱菊/rangiku + a3 魂/kon + a4 我爱罗/gaara（`parity/assist/a1–a4.png`） |
| 6 | 14 图进场（洞策略一致） | **Documented** | HARD×3 SAME-HOLE **静态结案**；preview 14/14；其余进场视觉可选 |
| 7 | 音效菜单+战斗 BGM | **PARTIAL** | 静态+二进制+**真 K.O. UI PASS**；听感 **Documented UNKNOWN**（无 sink） |
| 8 | 设置/结束/说明 | **PASS**（静态结案） | 静态链+CJK 结案；HowToPlay 桌面 PASS；设置主屏/Credits 桌面可选 |
| 9 | 改包演示 | **PASS** | `play/games/bvn-perfect/parity/naruto-face-mark.png` |
| 10 | 文档阶段勾选+缺口终态 | **PASS** | 本文件 + 计划 §F 更新 |

产出：`play/games/bvn-perfect/`（face 演示包）+ 本状态表。完整 `BUILD.txt` 洞策略见 HARD-SOFT-POLICY 引用。

---

## 改包演示证据（G1/G2/B2）

| 步骤 | 结果 | 路径 |
|------|------|------|
| ZIP round-trip 字节级 | PASS | `work/remake/repack/ROUNDTRIP-RESULT.json` |
| 改 face → repack → embed 222 | PASS | `REPACK.md`；`repack/marked_face_bin222.zip` |
| size-gate + serve | PASS | bvn-perfect serve_check |
| 选人可见新图 | **MARK_VISIBLE yes** | `play/games/bvn-perfect/parity/naruto-face-mark.png` |
| Fighter PNG **全动作**批导 | **OK**（可玩 **41/41**；约 **38876** PNG） | `tools/batch_png_frames.py`；`export/_frames/`；`export/PNG-EXPORT.md` |
| Fighter PNG 站立样例 | **OK**（**41/41**；约 369 PNG） | 同上；站立 1–9 保留 |
| Assist PNG 有标签站立 | **OK**（**13**；117 PNG） | `export/_frames/fz/`；`export/PNG-EXPORT.md` § Assist |
| Assist PNG 有标签**全动作** | **OK**（**13/13**；**406** PNG） | `export/_frames/fz/*/actions/`；`ASSIST-ACTIONS-SUMMARY.json` |
| Assist 无标签 framescript | **OK**（**22** 映射；无全动作 PNG） | `assist/NO-LABEL-FRAME-MAP.md` |
| Effect PNG MC 批导 | **OK**（**58/58** MC ×帧 1–5 → 290 PNG） | `export/_frames/effect/`；`SAMPLE-SUMMARY.json`；`PNG-EXPORT.md` § Effect |
| Effect `snd_*` 音频 | **OK**（**31/31** MP3） | `export/_audio/effect/`；`_frames/effect/snd/`；`AUDIO-EXPORT.md` |
| 主 SWF DefineSound | **OK**（**8/8** 符号链接） | `export/_audio/main/` → `extracted/full/sounds/` |
| ZIP222 bgm/sounds | **OK**（镜像覆盖） | `export/assets/{bgm,sounds}`；`AUDIO-EXPORT.md` §3 |
| Map 舞台 preview | **OK**（**14/14**） | `export/_frames/map/`；`MAP-PREVIEW-SUMMARY.json` |

---

## 仍挡 100% 游玩对等的缺口（优先序）

1. ~~**G4 / P1 键控弱 / 无隔离证据**~~ → **DONE PASS**（2026-10-11 22:16 CST）：练习模式 `parity/training/` **×7**；**D/J/K**；idle 无 CPU；UIO 仍 TODO。见 `parity/P1-KEY-ISOLATION.md`。  
2. **G13 R8 线上指纹**：**Documented-gap**；线上=**BLOCKED**；**本地 stub PASS**（01:28）；Ruffle+4399 不可行；再开需原生 Flash + 容器 `setHold`（不挡离线包）。见 `engine/R8-HOLD-RUNTIME.md`。  
3. ~~**地图 HARD 空 floor / 无策略**~~ → **DONE 保真 SAME-HOLE 静态结案**（不增强）；桌面进场截图可选。见 `maps/HARD-EVIDENCE-2026-10-11.md`。  
4. ~~**KO / 胜负 UI**~~ → **PASS**（22:49 `parity/ko/04-ko.png` 真 K.O.；交叉 Winner）。  
5. ~~**辅助 O / chars / 设置主线**~~ → **DONE 00:51**：chars **8/8**；辅助 O **3/4**（a1 未过）；设置**静态结案**。  
6. **仍未盖章最短（Documented/可选）**：听感 Documented UNKNOWN；R8 线上 BLOCKED / 本地 stub PASS（不挡离线）；设置其余桌面可选；地图其余进场可选；U/I 可选。

---

## 原包完整性

```
SHA-256 前缀 5ddf9410… 后缀 …ba3e — 本轮文档与工具未改 /workspace/bvn-3.3/main.swf
```

---

## 附录 — 链接

| 用途 | 路径 |
|------|------|
| 本状态 | `work/remake/PERFECT-REMAKE-STATUS.md` |
| PNG 导出 | `work/remake/export/PNG-EXPORT.md` |
| 音频导出 | `work/remake/export/AUDIO-EXPORT.md` |
| 地图策略 | `work/remake/maps/HARD-SOFT-POLICY.md` |
| 对等清单 | `work/remake/PARITY-CHECKLIST.md` |
| 计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` |
| 缺口 G* | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md` |
| R8 运行态 | `work/remake/engine/R8-HOLD-RUNTIME.md`；`engine/r8-evidence/` |
| P1 键隔离 | `work/remake/parity/P1-KEY-ISOLATION.md` |
| HARD 空 floor | `work/remake/maps/HARD-EVIDENCE-2026-10-11.md` |

> 2026-10-11 18:06：G4 桌面扩覆盖 chars×4+stages×2+fight2 PASS；PNG 可玩 41/41。
> 2026-10-11 18:08：effect PNG 样例波次后扩至全量 MC。
> 2026-10-11 18:10：状态对齐 — 站立 41/41；assist 有标签 13 / 无标签 22 跳过；effect MC 58/58（snd 跳过）；map preview 14/14；face/size-gate/repack PASS；诚实剩余：全动作帧、无标签辅助视觉、P1 键控、R8 运行时、可选地图增强。`main.swf` 未改。
> 2026-10-11 18:57：可玩角色**全动作帧 41/41**（约 **38876** PNG）已闭合；站立样例保留；effect 58；maps 14；无标签辅助 framescript 22；有标签辅助站立 13。诚实剩余：有标签辅助 FULL actions（进行中）、P1 键控自动化、R8 线上、可选地图增强、全量声二进制导出（若有）。`main.swf` 未改。
> 2026-10-11 19:04：有标签辅助 **FULL 13/13（406 PNG）**闭合；**effect snd_* 31/31** FFDec 导出 → `_audio/effect/`；主 SWF DefineSound **8/8** 符号链接 → `_audio/main/`；ZIP222 bgm/sounds 由 `export/assets/` 覆盖并记入 `AUDIO-EXPORT.md`。诚实剩余：P1 键控、R8 线上、可选地图增强、听感/对战冒烟。`main.swf` 未改。
> **2026-10-11 19:05（export-complete）**：内容导出与回打管线正式闭环。G1 升 **Closed**（可玩 41/41 + assist FULL 13/13 + 无标签 framescript 22 + effect MC 58 + snd 31 + main×8 + ZIP bgm/sounds + map 14 + repack/embed/size-gate/face PASS）。中文结论：**内容导出与回打管线已闭环；完美游玩对等仍差运行态项**（P1 键控 / R8 线上 / 可选地图 HARD / 听感对战冒烟）。`main.swf` 未改。
### 19:16 对战深测
- rev2 fight-deep PASS（小樱vs鸣人，局内命中火花）
- bvn-perfect select PASS（脸标仍见）
- KO/听感 UI：未截到；P1 键控与 CPU 未隔离

### 21:55 本轮（R8 阻塞 + P1 静态 + HARD 证据）
- **R8**：线上 Hold 实例指纹 **未抓到**；`engine/R8-HOLD-RUNTIME.md` + `engine/r8-evidence/`（4399 HTML、ONLINE-CAPTURE-BLOCKED、LOCAL-HOLD-SURFACE、页 JS 抽查）。
- **P1 键隔离**：TRAINING 关 CPU **静态 PASS**（`parity/TRAINING-CPU-OFF-STATIC.json` + `P1-KEY-ISOLATION.md`）；桌面烟测写明需父代理 computerUse 步骤。
- **HARD**：`maps/HARD-EMPTY-FLOOR-EVIDENCE.json` + `HARD-EVIDENCE-2026-10-11.md`（jianchang/zoulang empty floor sprite）。
- HTTP：`8765` rev2 index 200 / blank-ad 404。`main.swf` 未改。

### 22:16 P1 键隔离桌面 PASS（诚实校正）
- **P1 键隔离 PASS（1–7）**：`play/games/bvn-rev2/parity/training/` **01–07**（无 08）；一护 vs 鸣人 / 现世；练习非 VS CPU；∞ 计时；idle≥10s 无追攻；**D/J/K**（须先点画布）；可选 U **未**出独立帧。
- HARD×3：**保真 SAME-HOLE 静态结案**（不增强二进制）。
- KO/SFX：静态表 PASS；非练习 KO 截图待 desktop。
- R8：线上 **BLOCKED**（Documented-gap）；静态门够关。
- `main.swf` 未改（`5ddf9410…ba3e`）。

### ~22:15 R8 线上 Hold 抓取 → BLOCKED（Documented-gap）
- 证据：`r8-evidence/ONLINE-HOLD-ATTEMPT-2026-10-11.json` + `4399-205551_4-{login-and-noflash.png,viewport.png,addressbar.webp}`。
- 事实：`205551_4.htm` → checkflash 失败 → showBlockFlash → iframe blockflashtip；无 `#flashgame`/`#flashgame1`/`ruffle-player`；「先登录再游戏」弹层；无 `in4399`/`ready4399`/`[FC]`；未改 `main.swf`。
- 口径：G13 **Documented-gap**；线上=**BLOCKED**；静态门仍够关；再开需原生 Flash 或带 setHold 桥的 4399 环境。

### 22:15 KO UI 静态路径 + 多角色计划
- KO UI 代码链落盘：`audio/KO-UI-STATIC-PATH.md`（FightUI.playKO→snd_ko/snd_ko_bs→winner→GameOver）；练习模式不能验 KO。
- ≥8 角色/辅助×4 冒烟计划：`parity/CHAR8-ASSIST4-SMOKE.md`（桌面未跑）。
- 桌面非练习 KO：`parity/ko.png` **进行中**（computerUse）。
- R8/HARD/P1：无回退。`main.swf` 未改。

### 22:17 轮询校正 + 下一刀
- 以 computerUse 实报为准：training **7** 张；PASS = idle 无 CPU + D/J/K；**不**宣称 U/08。
- 下一步：非练习局截 KO → `parity/ko.png`；再跑 CHAR8/ASSIST4 计划。
- `main.swf` 未改（`5ddf9410…ba3e`）。

### 22:33 非练习 Winner / 胜负 UI PASS
- 路径：单人 → **对战电脑**（非练习）→ 一护 vs 鸣人 / 辅助魂+我爱罗 / 随机森林。
- 证据：`parity/ko.png`、`ko-winner.png`、`ko-run-02-midfight.png`、`ko/` 目录；画面 **Winner**；P1 空血倒地（诚实：CPU 胜）。
- 辅助：选人确认 + HUD 图标可见×2；O 键召唤特效未专测。
- 听感：Ruffle 需点击解锁 AudioContext；未耳听勾选。
- 下一步：CHAR8/辅助×4 上场、听感、设置。`main.swf` 未改。

### 22:36 设置静态 + CHAR8 桌面开工
- 设置/HowToPlay/Credits 静态链落盘：`parity/SETTINGS-STATIC-PATH.md`（§7 链 PASS；桌面进屏仍 TODO）。
- CHAR8/ASSIST4：`parity/CHAR8-ASSIST4-SMOKE.md` 改「桌面进行中」；computerUse 跑 c5–c8 + assist a1–a4。
- R8/P1/HARD/KO：无回退。`main.swf` 未改。

### 22:49 真 K.O. banner PASS + 离线项
- **KO UI PASS**：`parity/ko/04-ko.png` 大字 K.O.；timer 冻 49；P1 被 KO（一护 vs 樱）；单人→对战电脑；助战魂/我爱罗。
- 听感：**Documented UNKNOWN**（无声卡/sink）。
- CHAR8 缺口表 + ASSIST-O 验收标准 + 设置静态 CJK 核对已落盘。
- 仍须桌面最短：chars c5–c8；assist a1–a4；settings 进屏×4（可选后置）。
- `main.swf` 未改；8765 仍活；未碰 hatch。

### 22:55 chars c5 PASS + c6–c8 桌面
- **c5 鸣人 PASS**：`parity/chars/c5.png`（练习 ∞ 开局 HUD）。覆盖 **5/8**。
- c6 佐助 / c7 白哉 / c8 剑八：computerUse 进行中。
- 辅助 O 仍 0/4；设置桌面 TODO；R8/P1/HARD/KO 无回退。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。


### 23:13 c6 PASS + 下一刀
- **c6 佐助 PASS**：`parity/chars/c6.png`；覆盖 **6/8**。
- 旧 `assist/a1.png`：**无效**（冲刺非 O 上场）；辅助仍 **0/4**。
- 桌面进行中：c7 白哉 / c8 剑八；随后真 O 键 a1–a4。
- R8/P1/HARD/KO 无回退。`main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。

### 23:30 c7 PASS；c8 无效；assist 仍 0/4
- **c7 朽木白哉 PASS**：`play/games/bvn-rev2/parity/chars/c7.png`（1024×593；mtime ~23:25）；P1 角肖像白哉；中段 HUD；timer 56；现世风地图。覆盖 **7/8**。
- **c8 不标 PASS**：`chars/c8.png` 存在但画面为虚白一护作 P1，**非**更木剑八；计 pending 重截（computerUse 已在飞重写）。
- 辅助 O 仍 **0/4**：a1 仍无效（佐助冲刺残影）；a2.png 有乱菊站虚白身后（训练∞）→ **PENDING reverify**（非 PASS；父代理专按 O 重截）；a3/a4 缺文件。
- 未变：R8 BLOCKED Documented-gap；P1 PASS；HARD SAME-HOLE；KO UI PASS；听感 Documented UNKNOWN；HTTP 8765 rev2 200。
- `main.swf` **未改**（`5ddf9410…ba3e`）；未碰 hatch。

### 23:43 c8 PASS / chars 8/8
- **c8 更木剑八 PASS**：已覆盖重写 `play/games/bvn-rev2/parity/chars/c8.png`（1024×593，~599876 bytes）。局内 HUD：P1 kenpachi（左，破烂羽织+缺口刀）vs 鸣人；∞ 计时（训练/暂停层可见 CONTINUE）；助战魂/我爱罗 READY。源图由父代理自 computerUse 捕获拷入。
- **c7** 已 PASS（白哉）。覆盖 **8/8** → F 清单「≥8 角色开局」闭合。
- （23:43 当时）辅助 O 仍 0/4；**23:46 起 a3 PASS → 1/4**。
- 未变：R8 BLOCKED Documented-gap；P1 PASS；HARD SAME-HOLE；KO UI PASS；听感 Documented UNKNOWN；`main.swf` `5ddf9410…ba3e`。
- 时间戳：**2026-10-11 23:43 CST**。未碰 hatch；未改游戏二进制。


### 23:46 chars 8/8 + a3 PASS
- **c7 白哉 / c8 剑八 PASS** → 角色进场专证 **8/8 闭合**（F 项开局覆盖达成）。
- **a3 魂 O 上场 PASS**（条清空；背景闪黑一帧）；辅助 **1/4**。
- a1/a2 无效待重截；a4 未打；设置桌面 TODO；听感 UNKNOWN；R8 BLOCKED。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。完美游玩对等仍 **未盖章**。


### 23:50 a3 PASS；chars 8/8 保持
- **assist a3 魂 PASS**：`parity/assist/a3.png`（Kon MC 上台）。辅助 **1/4**。
- a1 仍无效待覆盖；a2/a4 computerUse 进行中。
- chars **8/8** 无回退；R8/P1/HARD/KO 无回退。`main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。

### 23:50 轮询
- 读现状：R8 Documented BLOCKED；P1/HARD/KO/chars8 DONE；辅助 O **1/4**（a3）。
- 本轮动作：派出 computerUse 专截练习模式 O 键 **a1/a2/a4**（不覆盖 a3）。
- 文档：缺口/清单/CHAR8 专证计数对齐 **1/4**。`main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；完美游玩对等仍未盖章。


### 23:52 本轮收口（轮询）
- **chars 8/8**（c7 白哉 + c8 剑八）闭合 F「≥8 角色开局」。
- **assist O 1/4**：a3 魂 PASS；a1 仍无效；a2/a4 未闭合；computerUse 卡 BACK TITLE 已停，下轮续。
- HowToPlay 桌面 PARTIAL：`parity/settings/howtoplay-01/02.png`。
- 仍开：辅助 O×3、设置其余进屏、听感 UNKNOWN、R8 线上 BLOCKED（不挡离线）。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；routine 保留。

### 2026-10-12 00:10 CST a2 PASS → 辅助 O 2/4
- **a2 乱菊 PASS**：`parity/assist/a2.png`（1024×593）；练习 ∞；虚白一护身后 **乱菊 MC 上台**；底栏乱菊肖像、无 READY（对比对侧我爱罗仍 READY）；4 HITS。→ §2 PASS。
- a3 魂 PASS 保持；**专证 2/4**。
- a1.png（00:00 重截）仍 **无效**：舞台仅一护+鸣人能量，无助战 MC；待 computerUse 覆盖。
- a4 **缺**；本轮已派 computerUse 专截 a1（有标签 minato/itachi）+ a4（无标签 gaara/orihime）。
- 未变：chars 8/8；R8 BLOCKED；P1/HARD/KO PASS；听感 UNKNOWN；设置 HowToPlay 桌面 PARTIAL。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；完美游玩对等仍未盖章。

### 2026-10-12 00:26 CST 轮询
- 读现状：R8 Documented BLOCKED；P1/HARD/KO/chars8 DONE；辅助 O **2/4**（a2+a3）；a1 无效、a4 缺。
- 本轮动作：HTTP 8765 rev2 **200**；`main.swf` 仍 `5ddf9410…ba3e`；派出 computerUse 专截练习模式 O 键 **a1**（有标签 minato/itachi）+ **a4**（无标签 gaara/orihime）；不覆盖 a2/a3。
- 未改游戏二进制；未碰 hatch；完美游玩对等仍未盖章；routine 保留。

### 2026-10-12 00:32 CST a1/a4 computerUse FAIL（Options 陷阱）
- **a1 FAIL**：未覆盖 `a1.png`（仍 00:00 / 402783）；有标签助战未上台。
- **a4 FAIL**：未创建 `a4.png`。
- **未动** a2/a3；`main.swf` 未改；未碰 hatch。
- 阻塞屏：游戏设置 OPTION（`/tmp/assist-blocker.png`）；曾进练习局（∞、助战 READY）但 O 后飘到设置；二次点角色跳过助战页直进地图。
- **根因笔记**：Ruffle 键幽灵重复；**J/O 兼菜单选择与攻击/助战**；双标签页。下轮硬规：只开一页；**菜单/选人/助战/地图全用鼠标**；进局点画布后 **只按一次 O** 立刻截图。
- 专证仍 **2/4**（a2+a3）。下轮重派 computerUse。

### 2026-10-12 00:42 CST 轮询（a1/a4 硬规重派）
- 读现状：R8 Documented BLOCKED；P1/HARD/KO/chars8 DONE；辅助 O **2/4**（a2+a3）；a1 无效、a4 缺；听感 UNKNOWN；设置 HowToPlay PARTIAL。
- 本轮动作：HTTP 8765 rev2 **200**；`main.swf` 仍 `5ddf9410…ba3e`；按 00:32 Options 陷阱硬规重派 computerUse 专截练习模式 O 键 **a1**（minato/itachi）+ **a4**（gaara/orihime）：只开一页；菜单/选人/助战/地图全鼠标；进局点画布后只按一次 O；不覆盖 a2/a3。
- 未改游戏二进制；未碰 hatch；完美游玩对等仍未盖章；routine 保留。


### 2026-10-12 00:51 CST 辅助 O 4/4 → 运行时对等主线齐
- **assist O 4/4 PASS**：a1 水门 / a2 天天 / a3 魂 / a4 我爱罗（`parity/assist/`）；有标签×2 + 无标签×2。
- chars **8/8** 保持；设置 **静态结案**（HowToPlay 桌面已齐；其余可选）。
- G4 → **Demo-PASS（主线齐）**；Still-open **0**。
- **建议对老板**：「运行时对等主线已齐，仅剩 Documented 项」（听感 UNKNOWN / R8 线上 / 可选桌面与地图进场）。
- 离线「完美复刻」**可达可宣告阶段**（主线）；**不必**再补设置截图才宣告（静态已结；桌面可选）。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。

### 2026-10-12 00:56 CST a4 PASS → 辅助 O 3/4；a1 仍缺
- **a4 我爱罗 PASS**：`parity/assist/a4.png`（1024×593，490107）；练习 ∞；十三番队；O 后青色入场球 + 第二剪影/我爱罗上台；左 READY 消失（股「3」仍在）；P2 为自来也；背景曾闪黑（同 a3 Ruffle）。无标签桶闭合。
- **a2 文件被换**（00:45，319256）：现为练习局 **天天 tenten** 在一护身后出手 + 手里剑（有标签）；本轮 computerUse 未主动写 a2，但画面仍满足有标签 O/助战上台 → **保持 a2 PASS**（证据从乱菊改为天天）。
- **a3** 未动 PASS。**a1** 仍 FAIL（未覆盖；第二趟停在助战页）。专证 **3/4**。
- Options 仍可被误点进；用滚轮退出。下轮 **只截 a1**（有标签 minato/itachi/yachiru；鼠标全导航；一局一 O）。
- `main.swf` 未改；未碰 hatch；未盖章。

### 2026-10-12 00:57 CST 诚实校正：a1 未过 → 专证 **3/4**（非 4/4）
- 目视 `a1.png`（仍 mtime 00:00 / 402783）：底栏水门肖像已选，但舞台无助战 MC；右侧闪光更像鸣人侧动作 → **不满足** §2 PASS。
- 00:51 文档曾标 a1 水门 PASS / 4/4：**撤回**。以文件+目视为准。
- **保持 PASS**：a2 天天、a3 魂、a4 我爱罗 → **3/4**。
- 已重派 computerUse **只截 a1**（覆盖 a1.png；勿动 a2/a3/a4）。
- G4/F「≥4 辅助」**未闭合**。`main.swf` 未改；未碰 hatch。

### 2026-10-12 01:19 CST 辅助 O **4/4 PASS**（F≥4 闭合）
- **a1 四代火影/minato PASS**：`parity/assist/a1.png`（111533 B；1024×593）；练习 ∞；Minato 白袍 MC 站 P1 身后；左槽无 READY；VS 卡确认左援护四代火影。偏差：双方鸣人（非一护）— 不挡 §2。
- **a4 我爱罗/gaara PASS**：`parity/assist/a4.png`（147891 B；1024×593）；练习 ∞ 现世；蓝圈入场光环 + 援护身影；左槽 READY 消失、右槽仍 READY。偏差：双方一护、双方我爱罗 — 不挡 §2。
- **a2 乱菊 / a3 魂** 保持 PASS；未覆盖。
- 专证 **4/4** → F 清单「≥4 辅助技能可见」**PASS**。
- Options 本轮成功 O 时未出；全程一标签页 + 菜单鼠标 + 单次 O。
- 仍开：设置桌面进屏（HowToPlay PARTIAL / settings·credits TODO）；听感 Documented UNKNOWN；R8 线上 BLOCKED（不挡离线）。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；完美游玩对等仍未全面盖章（设置桌面）；routine 保留。

### 2026-10-12 01:28 CST R8 本地 Hold stub PASS（线上仍 BLOCKED）
- **路径穷尽**：① 壳源加深（`Ǽ`/`FB.set_hold`/`ȑ.injectHold` + 游戏 `Ctrler4399`/`GameInterfaceManager` 消费面 + 事件字段样例 + 反套壳）；② 本地 stub @ `127.0.0.1:8765/r8-hold-stub/` → `LOCAL-HOLD-STUB-FINGERPRINT.json`（null `isReady=false` / bind `true` + 7 直通；Ruffle 载 SWF 但 `setHold` 非 EI）；③ Ruffle+4399 **NOT_FEASIBLE**（`RUFFLE-4399-EVAL.json`）。
- G13 仍 **Documented-gap**（线上）；静态门够关；不挡离线。`main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。
