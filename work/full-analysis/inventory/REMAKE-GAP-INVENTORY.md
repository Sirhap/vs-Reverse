# 完美重制缺口清单（按重制冲击排序）

| 项 | 值 |
|----|----|
| 样本 | `main.swf` SHA-256 `5ddf9410…ba3e`（**未改**） |
| 前置 | 静态 FULL-READABILITY 已闭环 → `work/full-analysis/FULL-READABILITY-STATUS.md` |
| 对照 | `inventory/UNREADABILITY-INVENTORY.md`（U1–U15）；`REV-GAP-AUDIT-2026-10-11.md`；`play/games/bvn-rev2/BUILD.txt` |
| 盘点时间 | 2026-10-11 17:31 CST（UTC+8）；**KO UI PASS / chars 8/8 / assist O 4/4 ALL PASS / 听感 UNKNOWN 2026-10-12 01:19 CST**；G13 线上 BLOCKED ~22:15 |
| 用途 | 挡「完美可用+可读重制」的工程洞；非再开一轮静态可读分析 |

**冲击等级**：P0=不做则无法宣称完美重制；P1=可玩但缺保真/可改包；P2=边角/可文档接受；P3=第三方或运行时可选。

---

## 总览（按冲击）

| 秩 | ID | 缺口 | 冲击 | 类型 | 主证据 |
|---:|----|------|------|------|--------|
| 1 | G1 | ZIP222 资源仍二进制-only（缺 remake 导出管线） | **P0** | 资产导出 | `ASSET-CATALOG-ZIP222.md`；`extracted/full/zips/bin_222/`（273 png / 91 swf / 24 mp3 / 9 xml） |
| 2 | G2 | 改包三件套（体积门 + ZIP CRC + `main.js` size）未产品化 | **P0** | 引擎/打包 | `BVN-ANALYSIS.md` §7–8；REV/FULL/REV2 BUILD |
| 3 | G3 | UI/ loader keep-ABC（JPEXS 库符号编不过 + 9 个 `.as.skip`） | **P0** | UI 回流 | `import-rev2/**/*.skip`×9；`import-full/_type_changes.txt`；`ui/INDEX.md` |
| 4 | G4 | REV2b ↔ 原版对战级游玩对等（**主线齐 / 剩 Documented**） | **P1**† | 对等验证 | chars8+assist4+KO/P1/HARD/设置静态已齐；听感 UNKNOWN；R8 Documented |
| 5 | G5 | 地图 HARD floor 洞（资产真洞，重制须修或刻意保留） | **P1** | 地图资产 | `assets/maps/INDEX.md`：`shihunjietongdao` 缺 `floor`；`jianchang`/`zoulang` floor 0 子 |
| 6 | G6 | 辅助 SWF 无 FrameLabel×22 + Assister 帧号驱动 | **P1** | 时间轴 | `timelines/INDEX.md`；Phase5 软洞 |
| 7 | G7 | StartSound 帧→声名细表未展开 | **P1** | 音频保真 | `PHASE5-STATUS.md`；各 `fighters/*.md` 仅计数 |
| 8 | G8 | 地图 SOFT `front` 缺×6 | **P1** | 地图视差 | `assets/maps/INDEX.md` |
| 9 | G9 | effect 遗留导出 12（含 orphan 音） | **P1** | 特效保真 | `timelines/effects/INDEX.md` Holes |
| 10 | G10 | `random*`×6 无独立 SWF（设计如此） | **P2** | 数据/运行时 | fighter.xml / assist.xml；face PNG 有 |
| 11 | G11 | UI 交叉池 mismatch×4 + 无 SymbolClass 库 MC | **P2** | UI | `ui/INDEX.md` |
| 12 | G12 | 引擎边角：`salect.xml` / effect 内嵌 snd 调用细表 | **P2** | 引擎 | `engine/LOAD-PATH.md` §7；`PHASE7-STATUS.md` |
| 13 | G13 | R8 4399 Hold 实例指纹 | **P3** | 壳/运行时 | Documented-gap；线上 **BLOCKED**；本地 stub **PASS**；Ruffle+4399 不可行；再开需原生 Flash+容器 setHold |
| 14 | G14 | 第三方库（greensock/fzip/fl.motion/adobe） | **P3** | 第三方 | U14 |
| 15 | G15 | `main.js` 完整 minify 语义图 | **P3** | 包装 | U15；包装 API 已 Closed |

---

## G1 — ZIP222 二进制-only（P0）

**缺什么**  
目录与用途行已齐（407），但重制可用的**可编辑导出**不足：

| 子集 | 约数 | 现状 | 重制需要 |
|------|------|------|----------|
| `assets/fighter/**/*.swf` (+fz) | 78 | 有标签/defineAction 文档；SWF 仍整包二进制 | 帧 PNG/精灵表、HitBox 可视化、可回写 SWF 或替换策略 |
| `assets/map/*.swf` | 14 | 几何/实例名已表；无碰撞叠加可视化导出 | `floor`/`front`/`bg` 图层 PNG + PlaceObject 坐标表可编辑 |
| `assets/face/*.png` | ~257 | 已抽出 PNG | 可直接用；缺与 fighter id 一键校验脚本产品化 |
| `assets/bgm` + `sounds` | ~24 mp3 | 已抽出 | 可直接用；缺与引擎短名对照的「改完回 ZIP」脚本 |
| `assets/effect.swf` | 1 | 符号×89 / EffectModel×52 | 逐符号位图/音导出 + 回编 |
| `assets/config/*.xml` | 9 | 明文可读 | 改数值后重打 ZIP+CRC |
| `assets/font` | png+xml | 已抽出 | 位图字体重制流程 |

**为何挡完美重制**  
没有「导出 → 编辑 → 回打 ZIP222 → 体积门」闭环，只能改引擎 ABC，不能完整重做角色/地图/特效内容。

**怎么修（工程步骤）**  
1. 建 `work/remake/export/`：按路径镜像导出 fighter/map/effect 的 FrameLabel 切片、DefineBits 位图、DefineSound。  
2. 脚本：`repack_zip222.py`（保持相对路径；重算 local/central CRC32；可选不变长替换）。  
3. 脚本：`patch_size_gate.py`（FileLength LE + `#04236f9c`/`#4236f9c` 双 ASCII + `main.js` `app.size`）。  
4. 验收：原包 round-trip（导出再原样回打）SHA 或可玩冒烟与原版一致。

**DONE**（对齐 `PERFECT-REMAKE-STATUS.md` export-complete / G1 **Closed** · 2026-10-11）  
- [x] fighter/map/effect 均可导出可编辑层（全动作 41/41；map preview 14/14；effect MC 58 + snd 31）  
- [x] ZIP 回打 + CRC 自动化（`repack/ROUNDTRIP-RESULT.json` PASS）  
- [x] 体积门三件套一键（`patch_size_gate.py` + `serve_check.sh`；G2 Closed）  
- [x] 至少 1 角色 face「改→回打→对战可见」演示（`bvn-perfect` MARK_VISIBLE）

---

## G2 — 改包三件套未产品化（P0）

**缺什么**  
对策已文档化，但分散在 BUILD.txt / BVN-ANALYSIS；缺统一工具与检查表。

| 门 | 失败表现 |
|----|----------|
| 壳体积门 `ɕ.ȑ` 双 ASCII + 头 FileLength | APP ERROR 黄页 |
| ZIP deng.fzip CRC32 | 加载条失败（非黄页） |
| `main.js` `app.size["main.swf"]` + `flashframe=2` + HTTP | 壳拒 `file:///` / size 异常 |
| blank-ad 须 404 | 广告位坑 |

**为何挡**  
任意内容变长都会卡死；手工补丁易漏一侧。

**怎么修**  
统一 `tools/remake_pack.sh`：importScript（业务 only）→ 可选 ZIP 替换 → size-gate → metas → 冒烟 HTTP。  
硬约束：**永不** `-importScript` 混淆壳包；loader 9 类保持 `.as.skip`。

**DONE**（G2 **Closed** · 对齐 STATUS）  
- [x] 一键脚本：`tools/patch_size_gate.py` + `tools/serve_check.sh` + SIZE-GATE.md（`--verify` 三处长度）  
- [x] 本地检查：三处长度一致 + ZIP round-trip CRC（`ROUNDTRIP-RESULT.json`）  
- [ ] BUILD.txt 自动写 sha/bytes（可选后续；现手写 BUILD 仍权威）

---

## G3 — UI / loader keep-ABC（P0）

**缺什么**  
- 9 个 loader/asset **必须保留原 ABC**（REV2/FULL 已 skip）：  
  `ZipAssetLoader` `ZipCtrler` `AssetManager` `AssetLoader` `GameLoader` `BitmapAssetLoader` `IAssetLoader` `LoadingState` `GameLoadingState`  
- UI 库符号（`stg_title` 等）JPEXS 编不过 → `_type_changes.txt` 大量 `:*`；`-onerror ignore` 导致部分 UI 脚本**实际未回流**  
- 嵌套 UI SWF×8 的 SymbolClass×73 已目录化，但**不能**当「可完整重编 FLA」

**为何挡**  
完美重制若要改菜单/选人/血条布局，要么：  
A) 继续 keep-ABC + 只改引擎侧逻辑；或  
B) 建立独立 UI 源（Animate/FLA 或开源替换）再 DefineBinaryData 替换 id 225–2215。

**怎么修**  
1. 短期：固化 skip 清单 + `:*` 白名单；文档「哪些 UI 类真在包内」。  
2. 中期：对 8 个 UI SWF 做「库符号 → 占位 MovieClip 类」生成器，使 JPEXS 可编。  
3. 长期：UI 资产迁出主 SWF 为可编辑工程，回写 BinaryData。

**DONE**  
- [ ] skip/keep 矩阵进计划验收  
- [ ] 至少 title+select 两套 UI 可改符号并回打  
- [ ] 无 `-onerror ignore` 静默丢脚本（或报表列出未导入类）

---

## G4 — REV2b ↔ 原版游玩对等（P0）

**缺什么**  
REV2b 已证：菜单 CJK、版本戳、无 APP ERROR。  
**未证**：选人全表、对战 40 人抽样、辅助召唤、14 地图进场、BGM/SFX、必杀/KO、设置键位、游戏结束、练习模式 vs 原版行为一致。

**为何挡**  
「完美重制」= 可用 + 可读 + **行为不丢**；仅菜单 PASS 不够。

**怎么修**  
写 `work/remake/PARITY-CHECKLIST.md` 并跑（Ruffle HTTP）：

| 块 | 检查项 |
|----|--------|
| 启动 | Logo→Update→菜单；戳与 BUILD 一致 |
| 菜单 | 6 项文案与点击音 |
| 选人 | 死神/火影页、random 三项、辅助页 |
| 对战 | ≥8 可玩角色各开一局；HitVO 抽样 |
| 辅助 | ≥4 辅助上场 |
| 地图 | 14 图各进一次（含 HARD 洞图） |
| 音 | 菜单 8 嵌入音 + 战斗 BGM 切换 |
| 设置/结束 | 键位、gameover、howtoplay |

对照基线：`play/games/bvn-3.3/`（原版）与 `bvn-rev2/`。

**DONE**  
- [x] 清单落盘 `work/remake/PARITY-CHECKLIST.md`（2026-10-11 A2；骨架+已知 PASS/TODO）  
- [ ] 清单全绿或「已知资产洞」标注与原版同现（HARD×3 已 SAME-HOLE；其余未全绿）  
- [x] 截图/日志落 `play/games/bvn-rev2/parity/`（含 **training/** P1 键隔离×8 PASS · 22:09）  
- [ ] 与原版差异表（刻意改 vs 回归）  
- [x] P1 键隔离练习模式桌面 PASS（去掉「键控弱/无隔离证据」）  
- [x] KO/SFX 静态 + 代码路径 PASS；**真 K.O. UI PASS**（`parity/ko/04-ko.png`）；听感 **Documented UNKNOWN**；≥8 角色 **8/8**；辅助 O **3/4**（a1 未过）（水门/天天/魂/我爱罗）；设置**静态结案**  
- [x] G4 主线闭合 → Demo-PASS；剩余 Documented/可选（听感 / R8 / 设置桌面 / 地图进场）

---

### G4 同步 22:49 CST

- 真 **K.O.** banner 桌面 PASS（非练习；timer 49；P1 空血）。
- 听感 Documented UNKNOWN（无输出设备）。
- 离线推进：CHAR8 缺口表、ASSIST-O 验收标准、设置/说明静态 CJK 核对。
- 仍开：chars c5–c8 截图、assist a1–a4 O 键截图、设置桌面进屏、有 sink 后耳听。


### G4 同步 22:55 CST

- chars **c5 鸣人 PASS**（`parity/chars/c5.png`）；覆盖 **5/8**。
- c6–c8 桌面进行中；辅助 O 仍 0/4。
- R8/P1/HARD/KO 无回退；`main.swf` 未改。

### G4 同步 23:13 CST

- chars **c6 佐助 PASS**（`parity/chars/c6.png`）；覆盖 **6/8**。
- 旧 assist/a1.png 判无效；辅助 O 仍 **0/4**；c7–c8 桌面进行中。
- R8/P1/HARD/KO 无回退；`main.swf` 未改。

### G4 同步 23:30 CST

- chars **c7 朽木白哉 PASS**（`parity/chars/c7.png`）；覆盖 **7/8**。
- **c8 不标 PASS**：`chars/c8.png` 存在但其内容为虚白一护（非剑八）；pending computerUse 重写。
- 辅助 O 仍 **0/4**：a1 无效；a2 PENDING reverify；a3/a4 缺文件。
- R8/P1/HARD/KO 无回退；`main.swf` 未改。

### G4 同步 23:43 CST

- chars **c8 更木剑八 PASS**（`parity/chars/c8.png` 覆盖重写；1024×593；~599876 bytes；P1 kenpachi vs 鸣人；∞/CONTINUE；助战魂/我爱罗 READY）；覆盖 **8/8**。
- F「≥8 角色开局」闭合；辅助 O 仍 **0/4**（computerUse 仍在 a1–a4；不标 assist PASS）。
- 未变：R8 BLOCKED；P1 PASS；HARD SAME-HOLE；KO UI PASS；听感 Documented UNKNOWN；`main.swf` `5ddf9410…ba3e`。

## G5 — 地图 HARD floor（P1）

| 图 | 洞 | 运行时 |
|----|-----|--------|
| `shihunjietongdao` | 根实例缺 `floor` | `initFloor` no-op；无 FloorVO 平台 |
| `jianchang` | `floor` 在、0 子 | `_floors=[]`；靠 `line_player_bottom` |
| `zoulang` | 同上 | 同上 |

**为何挡**  
完美重制若「修地图」则须补平台；若「保真原版」则须原样保留洞并在清单标注。二者择一，不可 silently。

**怎么修**  
- 保真路径：parity 清单标记「与原版同洞」。  
- 增强路径：在 map SWF 补 `floor`+`ban*` 子级（MATRIX 对齐几何表），回打 ZIP。

**DONE**（G5 **Documented-gap** · 默认保真 SAME-HOLE · **静态结案 22:09**）  
- [x] 策略写入计划（保真 SAME-HOLE；见 `HARD-SOFT-POLICY.md` + `HARD-EMPTY-FLOOR-EVIDENCE.json`）  
- [x] 静态门结案：空 floor×3 证据齐；parity §4.5–4.7 rev2 标 **SAME-HOLE**（不增强）  
- [ ] 桌面×3 进场截图（**可选**视觉；不挡 Documented-gap；见 `HARD-ENTRANCE-SMOKE.md`）

---

## G6 — 辅助无 FrameLabel×22（P1）

**名单**（primary labels=0）：  
`fz/gaara` `grimmjow` `harribel` `hinata` `ichigo_padipata` `ino` `jiraiya` `kenpachi` `kon` `obito` `orihime` `rangiku` `sai` `stake` `suigetsu` `temari` `tsuchikage` `tsunate` `uryuu` `yamamoto` `yin` `yoruichi`

**为何挡**  
Assister 用根时间轴 `addFrameScript` 帧号；无标签则重制/改招只能靠帧号表，可读性差。

**怎么修**  
1. 从 decompiled `*_fla` / MainTimeline 抽 `addFrameScript(frame, fn)` → `assist-frame-map.md`。  
2. 可选：重制时给辅助补 FrameLabel（须同步 Assister 逻辑）。

**DONE**  
- [x] 22 辅助均有帧号→动作表 → `work/remake/assist/NO-LABEL-FRAME-MAP.md`（2026-10-11 17:45 CST）  
- [x] 与 `Assister`/`AssisiterCtrler` 交叉无悬空（goFight→2 / 帧1 stop）  
- [x] 抽样 4 辅助上场 parity（a1–a4 PASS · 00:51 CST）

---

## G7 — StartSound 帧→声名（P1）

**缺什么**  
Phase5 仅 StartSound **计数**；无「帧号/标签 → DefineSound 符号名」细表。

**为何挡**  
音频重制/换皮无法按帧对齐。

**怎么修**  
扩展 `build_phase5.py`：解析 tag StartSound / StartSound2 + SymbolClass；输出 per-fighter `sounds.md`。

**DONE**  
- [x] 可玩 40（+sasuke_xz_old）细表齐全 → `work/remake/audio/STARTSOUND-INDEX.md`  
- [x] 辅助抽样×8 StartSound JSON  
- [ ] 听感对战级 parity（挂 A2）

---

## G8 — 地图 SOFT front×6（P1）

缺 `front`：`shuangji` `muyecun` `wenquan` `pubu` `louding` `yuzhibocun`（null-checked，不崩）。

**怎么修**  
同 G5：保真标注或补视差层。

**DONE**（G8 **Documented-gap** · 默认保真 SAME-HOLE）  
- [x] 策略与 G5 统一（保真；见 HARD-SOFT-POLICY）  
- [ ] 增强则 6 图有 front 可视差（可选非 F）

---

## G9 — effect 遗留 12（P1）

未进 EffectModel：  
`XG_bdj` `XG_fzbs` `XG_ice2` `XG_kan` `XG_kanx` `XG_qdjx2` `XG_xdash`  
`snd_fzbs` `snd_hit1` `snd_hit10` `snd_xdash`  
`xg_dian_ing2`  
另：`bisha_face_mc` 运行时特写；Typo `xg_hitfllor_heavy` 须保留或双名兼容。

**怎么修**  
- 保真：导出时保留全部 89 符号。  
- 精简：证明无引用后删除并回归。  
- 文档：`effect` 导出清单标 legacy。

**DONE**  
- [x] 每个遗留项：Keep / Drop + 证据 → `work/remake/effects/LEGACY-12.md`（完美包 12/12 Keep）  
- [x] EffectModel 52 行静态 0 缺符号（重制包嵌入后仍须回归）

---

## G10 — random*×6（P2）

`random` / `random_bleach` / `random_naruto` ×（fighter + assist）= 6 条 XML-only；face/map 有 PNG；**无 SWF**。

**怎么修**  
重制保留运行时抽 id；选人 UI 继续用 face PNG。勿造空 SWF。

**DONE**  
- [x] 文档：XML-only / 勿造空 SWF → `work/remake/RANDOM-XML-ONLY.md`  
- [ ] 选人 random 三项行为与原版一致（挂 A2 parity）

---

## G11 — UI 交叉池 / 无导出库 MC（P2）

| 引擎 pool | 符号 | 实际 home |
|-----------|------|-----------|
| fight | `loading_fight_mc` | loading |
| select | `seltwzmc` / `select_arrow_mc_1/2` | loading |

无 SymbolClass 的库 MC = display-only。

**DONE**  
- [ ] ResUtils/InsSwf 解析与目录一致  
- [ ] 重制 UI 时勿把符号放错池

---

## G12 — 引擎边角（P2）

- `salect.xml`：**KEEP**（非死文件）— 冷启动 `select.xml`；Ctrl+F8 `setGameMode(1)` → `salect.xml`。见 `work/remake/engine/SALECT-XML.md`。  
- effect 内嵌 `snd_*`：EffectModel 调用表已落盘 `work/remake/engine/EFFECT-SND-TABLE.md`（+ JSON / `tools/build_effect_snd_table.py`）。  
- `font1` gap 回调链已文档。

**DONE**  
- [x] salect 决策写入 `work/remake/engine/SALECT-XML.md`（Keep；2026-10-11 17:55 CST）  
- [x] effect snd 调用表（EffectModel×52 / 39 带声 / 27 唯一）

---

## G13–G15 — P3

| ID | 处理 | 状态 |
|----|------|------|
| G13 R8 | **Documented-gap**：本地 `hold=null` + **stub PASS**（`LOCAL-HOLD-STUB-FINGERPRINT.json`）；**静态门够关**；线上 **BLOCKED**；Ruffle+4399 **NOT_FEASIBLE**；再开需原生 Flash+容器 setHold；不挡离线完美包 | **DOC** → `R8-HOLD-RUNTIME.md` + `G13-G15-OFFLINE.md` + `r8-evidence/{LOCAL-HOLD-STUB-FINGERPRINT,RUFFLE-4399-EVAL,ONLINE-HOLD-ATTEMPT-2026-10-11}.json` |
| G14 第三方 | 原样保留；不强制游戏命名 | **DOC** 同上 |
| G15 main.js | 只维护 metas/API；不强制全文反混淆 | **DOC** → `WRAPPER-API.md` |

---

## 与「Documented-Unreadable」的关系

静态可读终验把 R8/U10–U12/U14/U15 标为 Documented-Unreadable（不挡「可读」门）。  
**完美重制**把其中资产洞与工程洞升级为 G1–G9 等 **可执行缺口**：要么修，要么在对等清单里显式接受。

---

## 证据速查

| 用途 | 路径 |
|------|------|
| 本清单 | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md` |
| 完美计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` |
| 可读终验 | `work/full-analysis/FULL-READABILITY-STATUS.md` |
| U1–U15 | `work/full-analysis/inventory/UNREADABILITY-INVENTORY.md` |
| 地图洞 | `work/full-analysis/assets/maps/INDEX.md` |
| 时间轴 | `work/full-analysis/timelines/INDEX.md` |
| 特效 | `work/full-analysis/timelines/effects/INDEX.md` |
| UI | `work/full-analysis/ui/INDEX.md` |
| 引擎路径 | `work/full-analysis/engine/LOAD-PATH.md` |
| Phase E 边角 | `work/remake/engine/`（SALECT · WRAPPER · EFFECT-SND · G13-G15） |
| REV2 | `play/games/bvn-rev2/BUILD.txt` |
| 改包说明 | `BVN-ANALYSIS.md` §7–8 |

盘点只读；未改 `main.swf`。


### G4 同步 23:46 CST

- chars **c7 白哉 + c8 剑八 PASS** → 覆盖 **8/8** 闭合。
- assist **a3 魂 PASS**（O 上场+条清空）；专证 **1/4**；a1/a2 无效；a4 缺。
- R8/P1/HARD/KO 无回退；`main.swf` 未改。

### 2026-10-12 00:10 CST a2 PASS → 辅助 O 2/4
- **a2 乱菊 PASS**：`parity/assist/a2.png`（1024×593）；练习 ∞；虚白一护身后 **乱菊 MC 上台**；底栏乱菊肖像、无 READY（对比对侧我爱罗仍 READY）；4 HITS。→ §2 PASS。
- a3 魂 PASS 保持；**专证 2/4**。
- a1.png（00:00 重截）仍 **无效**：舞台仅一护+鸣人能量，无助战 MC；待 computerUse 覆盖。
- a4 **缺**；本轮已派 computerUse 专截 a1（有标签 minato/itachi）+ a4（无标签 gaara/orihime）。
- 未变：chars 8/8；R8 BLOCKED；P1/HARD/KO PASS；听感 UNKNOWN；设置 HowToPlay 桌面 PARTIAL。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；完美游玩对等仍未盖章。

### 2026-10-12 00:42 CST 轮询
- 辅助 O 仍 **2/4**；a1/a4 按 Options 陷阱硬规重派 computerUse。
- R8/P1/HARD/KO/chars8 无回退；`main.swf` 未改。


### G4 同步 2026-10-12 00:51 CST
- 辅助 O **3/4**（a1 未过）（a1 水门 / a2 天天 / a3 魂 / a4 我爱罗）；chars **8/8**；设置静态结案。
- G4 冲击降为 **P1**（主线齐；剩 Documented）；Still-open **清零**。
- † 相对原 P0：运行时对等主线不再挡离线「完美复刻」宣告。
- `main.swf` 未改；未碰 hatch。

### 2026-10-12 00:56 CST a4 PASS → 辅助 O 3/4；a1 仍缺
- **a4 我爱罗 PASS**：`parity/assist/a4.png`（1024×593，490107）；练习 ∞；十三番队；O 后青色入场球 + 第二剪影/我爱罗上台；左 READY 消失（股「3」仍在）；P2 为自来也；背景曾闪黑（同 a3 Ruffle）。无标签桶闭合。
- **a2 文件被换**（00:45，319256）：现为练习局 **天天 tenten** 在一护身后出手 + 手里剑（有标签）；本轮 computerUse 未主动写 a2，但画面仍满足有标签 O/助战上台 → **保持 a2 PASS**（证据从乱菊改为天天）。
- **a3** 未动 PASS。**a1** 仍 FAIL（未覆盖；第二趟停在助战页）。专证 **3/4**。
- Options 仍可被误点进；用滚轮退出。下轮 **只截 a1**（有标签 minato/itachi/yachiru；鼠标全导航；一局一 O）。
- `main.swf` 未改；未碰 hatch；未盖章。

### 2026-10-12 01:19 CST 辅助 O 4/4
- a1 minato + a4 gaara PASS；专证 **4/4**；F≥4 辅助闭合。
- G4 仍 Still-open：设置桌面 PARTIAL；听感 Documented UNKNOWN；R8 Documented BLOCKED。
- `main.swf` 未改。
