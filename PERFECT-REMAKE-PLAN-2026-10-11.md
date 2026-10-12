# BVN 3.3 完美重制计划（2026-10-11）

| 项 | 值 |
|----|----|
| 目标 | **PERFECT remake**：完全可用 + 完全可读，内容与行为无静默缺失 |
| 样本 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e`（**禁止改原包**；重制产出落 `play/games/`） |
| 前置 | 静态 FULL-READABILITY **DONE** → `work/full-analysis/FULL-READABILITY-STATUS.md` |
| 缺口权威表 | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md`（G1–G15） |
| 基线可玩 | `play/games/bvn-rev2/`（V3.3-REV2b，菜单 CJK PASS）；`bvn-full/`（引擎回流 PLAYABLE） |
| 约束 | 不重编 GreenHD 壳 ABC；loader×9 keep-ABC；改包走体积门三件套 |

**与「可读终验」的差别**：可读 = 静态能说清。完美重制 = 能导出、能改、能回打、能对等游玩。

---

## 总路线（一页）

```
Phase A  对等基线与门禁工具化     ← G2 G4
Phase B  ZIP/嵌套 SWF 导出回打     ← G1 G5 G8 G9
Phase C  时间轴/音频保真表         ← G6 G7 G10
Phase D  UI 可编（keep-ABC→可回流）← G3 G11
Phase E  引擎边角与包装            ← G12 G13–G15
Phase F  完美验收门               ← 全 G*
```

每阶段格式：**缺什么 / 为何挡 / 怎么修 / DONE**。

---

## Phase A — 对等基线与门禁工具化

### A1 体积门 + metas + 服务约定（G2）

| | |
|--|--|
| **缺什么** | FileLength、`#04236f9c`/`#4236f9c`、`main.js` `app.size`、HTTP、`flashframe=2`、blank-ad=404 的对策散落在各 BUILD，无统一脚本 |
| **为何挡** | 任意变长重制必过壳门；漏一侧即 APP ERROR 或加载失败 |
| **怎么修** | 1) `tools/patch_size_gate.py`：读 SWF 长度 → 写 offset4 UI32 LE + 两处 ASCII（等长 hex 填充）→ 同步 `main.js` metas base64。<br>2) `tools/serve_check.sh`：断言 `127.0.0.1:8765`、blank-ad 404、`app.flashframe=2`。<br>3) 文档合并进本计划附录「改包检查表」。 |
| **DONE** | 工具已落盘：`tools/patch_size_gate.py` + `tools/serve_check.sh` + `work/remake/SIZE-GATE.md`；`--verify` 三处长度一致；`serve_check` 可断言 HTTP/404/flashframe。一键 import→菜单冒烟仍走既有 JPEXS 流程（工具不替代 import）。 |

### A2 游玩对等清单（G4）

| | |
|--|--|
| **缺什么** | REV2b 仅验证菜单中文；无 vs 原版的选人/对战/地图/音效清单 |
| **为何挡** | 无法证明「完美可用、无所失」 |
| **怎么修** | 落盘 `work/remake/PARITY-CHECKLIST.md`（见缺口清单 G4 表）；对 `bvn-3.3` 与 `bvn-rev2`（及后续 perfect 包）逐项打勾；证据图进 `play/games/<build>/parity/` |
| **DONE** | 清单全绿，或「与原版同资产洞」显式标注；无未解释差异 |
| **状态（2026-10-11 17:51 CST）** | **IN PROGRESS（局部 Demo）** — 清单 `PARITY-CHECKLIST.md`；rev2 桌面：`parity/{menu,select,fight,midfight}.png` **PASS**；**P1 键控自动化弱/FAIL**（D/J/K）。bvn-perfect 脸标 **MARK_VISIBLE**。地图×14 进场/≥8 角色/辅助×4/听感/设置三态仍 TODO。HTTP 8765 curl PASS。未达全绿 → G4 **Still-open**。 |

### A3 导入策略冻结

| | |
|--|--|
| **缺什么** | skip×9 与 `:*` 类型改写易在下一次 import 被破坏 |
| **为何挡** | 全量 import 会弄死 ZIP 加载 |
| **怎么修** | 以 `import-rev2` / `import-full-clean` 为权威；CI 比对 `.as.skip` 列表；禁止壳包路径进入 import 根 |
| **DONE** | skip 矩阵写入 BUILD；误 import 壳类时脚本失败退出 |

---

## Phase B — 资产导出与 ZIP 回打（核心内容重制）

### B1 导出树（G1）

| | |
|--|--|
| **缺什么** | `bin_222` 已解压，但缺「按帧/按图层」的重制工作区 |
| **为何挡** | 不能改角色立绘帧、地图平台、特效符号后回灌 |
| **怎么修** | 建 `work/remake/export/assets/` 镜像；用 JPEXS/自写解析：<br>• fighter/fz：FrameLabel 切片 PNG + defineAction JSON<br>• map：实例层 bounds 叠加图 + 几何 JSON（复用 `build_phase4_geometry.py`）<br>• effect：SymbolClass 逐符号导出<br>• face/bgm/sounds/font/config：直接复制明文/二进制 |
| **DONE** | 每类至少样例 1 套可打开编辑；路径与 `ASSET-CATALOG-ZIP222` 1:1 |
| **状态（2026-10-11 17:37 CST）** | **SAMPLE DONE** — `work/remake/export/assets/` symlink 镜像 bin_222（398 files）；样例：fighter `naruto` FrameLabel+defineAction JSON；map `muyecun` geometry JSON（phase4）；effect SymbolClass stub×89/sample×13；`EXPORT-INDEX.md`。PNG 帧/逐符号位图因无 java+ffdec 本轮跳过。main.swf 未改。全量 407 仍待批导 + B2 回打。 |

### B2 ZIP 回打 + CRC（G1/G2）

| | |
|--|--|
| **缺什么** | 手工重打易坏 deng.fzip CRC；无 round-trip 测试 |
| **为何挡** | 改资源后加载条失败，误判为「引擎坏了」 |
| **怎么修** | `repack_zip222.py`：写 local+central CRC；可选 store/deflate 与原条目策略一致；再嵌入 DefineBinaryData id=222（或整包替换流程见 BVN-ANALYSIS §8） |
| **DONE** | 原样 round-trip 可玩；改一张 face PNG 后选人可见新图 |
| **状态（2026-10-11 17:42 CST）** | **TOOLCHAIN PASS** — `tools/repack_zip222.py` + `embed_bin222.py`；round-trip **字节级 PASS**（`work/remake/repack/ROUNDTRIP-RESULT.json`）；marked `naruto.png` CRC 更新；嵌入路径文档见 `work/remake/REPACK.md`；`play/games/bvn-perfect/` stub。桌面选人可见新图仍待拷贝 play 包 + size-gate。main.swf 未改（`5ddf9410…`）。 |

### B3 地图 HARD / SOFT（G5/G8）

| | |
|--|--|
| **缺什么** | `shihunjietongdao` 无 `floor`；`jianchang`/`zoulang` floor 空；6 图无 `front` |
| **为何挡** | 「完美」须二选一：保真原版洞，或增强补全——不可假装没有 |
| **怎么修** | **默认保真**：parity 标同洞。<br>**增强可选**：按 `assets/maps/<id>.md` MATRIX 补 `floor`/`ban*` 或 `front`，回打 map SWF→ZIP |
| **DONE** | 策略写入 BUILD；增强则 3 HARD + 6 SOFT 有录屏证明 |
| **状态（2026-10-11 17:51 CST）** | **DONE（保真）** — `work/remake/maps/HARD-SOFT-POLICY.md`：默认 **fidelity / SAME-HOLE**（HARD×3 + SOFT front×6）；增强路径文档化但 **非 F 必需**。parity §4 洞列与策略对齐。main.swf 未改。 |

### B4 effect 遗留 12（G9）

| | |
|--|--|
| **缺什么** | 12 个导出未进 EffectModel；typo `xg_hitfllor_heavy`；`bisha_face_mc` 运行时 |
| **为何挡** | 精简包可能误删仍被时间轴引用的 legacy；或漏导导致缺特效 |
| **怎么修** | 导出保留 89 全符号；逐项 Keep/Drop 表；保留 typo 符号名或引擎双名 |
| **DONE** | EffectModel 52 行 0 缺符号；遗留表闭合 |
| **状态（2026-10-11 17:45 CST）** | **TABLE DONE** — 见 Phase C4 / `work/remake/effects/LEGACY-12.md`（12/12 Keep）。 |

---

## Phase C — 时间轴与音频保真

### C1 辅助帧号图（G6）

| | |
|--|--|
| **缺什么** | 22 个辅助 primary FrameLabel=0，靠 `addFrameScript` |
| **为何挡** | 改辅助招式缺少可读锚点 |
| **怎么修** | 解析 decompiled 辅助 MainTimeline → `timelines/assists-frame-map.md`；可选补标签（须改 Assister 约定，谨慎） |
| **DONE** | 22 辅助帧号→动作齐全；抽样 4 个上场 parity |
| **状态（2026-10-11 17:45 CST）** | **TABLE DONE** — `work/remake/assist/NO-LABEL-FRAME-MAP.md` + 22× `assist/<id>.frames.json`；源 `addFrameScript` 全齐；与 Assister `goFight→帧2` / 帧1 `stop` 交叉无悬空。桌面 4 辅助上场 parity 仍挂 A2。main.swf 未改。 |

### C2 StartSound 细表（G7）

| | |
|--|--|
| **缺什么** | 仅有 StartSound 计数 |
| **为何挡** | 换音效无法按帧对齐 |
| **怎么修** | 扩展 `build_phase5.py` 输出帧/标签→声名；先做可玩 40 |
| **DONE** | 40 人细表 + 辅助抽样；与 `SOUND-CATALOG` / effect snd 无矛盾 |
| **状态（2026-10-11 17:45 CST）** | **TABLE DONE** — `tools/build_phase_c.py`；`work/remake/audio/STARTSOUND-INDEX.md` + 41× fighter JSON（12 全量 events 样例）+ 辅助抽样×8；StartSound 事件 **2515**（命名命中 59：SymbolClass/sha1-cross，其余稳定 `cid:`+sha1）。与 SOUND-CATALOG / effect snd 无矛盾。main.swf 未改。 |

### C3 random*（G10）

| | |
|--|--|
| **缺什么** | 6× XML-only，无 SWF（设计如此） |
| **为何挡** | 误造空 SWF 会破坏选人 |
| **怎么修** | 保持运行时抽真实 id；face/map PNG 保留；文档写明 |
| **DONE** | 选人三项 random 行为与原版一致 |
| **状态（2026-10-11 17:45 CST）** | **DOC DONE** — `work/remake/RANDOM-XML-ONLY.md`：禁止造空 SWF；face PNG + 运行时抽 id。选人三项冒烟挂 A2 parity。 |

### C4 effect 遗留 12 Keep/Drop（G9，衔接 B4）

| | |
|--|--|
| **缺什么** | 12 导出未进 EffectModel 无 Keep/Drop |
| **状态（2026-10-11 17:45 CST）** | **TABLE DONE** — `work/remake/effects/LEGACY-12.md`：完美包路径 **12/12 Keep**；冻结 typo `xg_hitfllor_heavy` + 运行时 `bisha_face_mc`。精简 Drop 仅回归后。 |

---

## Phase D — UI 可编辑回流

### D1 keep-ABC 透明化（G3）

| | |
|--|--|
| **缺什么** | `-onerror ignore` 静默跳过失败 UI 脚本；真正回流集合不清 |
| **为何挡** | 改 UI 逻辑以为进了包，实际仍是原 ABC |
| **怎么修** | import 后 `ffdec -selectclass` 抽样校验；生成「已回流 / 仍原 ABC」报表 |
| **DONE** | 报表进 BUILD；无静默丢失 |
| **状态（2026-10-11 17:48 CST）** | **MATRIX DONE** — `work/remake/ui/REFLOW-MATRIX.md`：skip×9；仍原ABC **19**（库类型 16 + 编译常量 3，来自 `bvn-rev2/import-clean.log` SEVERE）；回流 **153**/172。权威 `import-rev2`。main.swf 未改。 |

### D2 库符号可编译（G3/G11）

| | |
|--|--|
| **缺什么** | `stg_title` 等库 MC 无 AS 类，JPEXS 不能写类型 |
| **为何挡** | 菜单/选人/战斗 HUD 无法干净 rewrite |
| **怎么修** | 短期继续 `:*`；中期为 SymbolClass×73 生成空子类占位；注意交叉池 4 符号实际在 **loading** |
| **DONE** | title + select 可改并回打验证；交叉池表遵守 |
| **状态（2026-10-11 17:48 CST）** | **STUBS DONE** — `work/remake/ui/stubs/` SymbolClass 空子类 **73/73**（title×3 + select×8 已落文件）；`STUBS-PLAN.md` + `CROSS-POOL.md`（交叉池×4 home=loading）。title+select 回打验证仍待下一轮 import（无 java 本轮未跑 ffdec）。main.swf 未改。 |

### D3 （可选）UI BinaryData 外置工程

| | |
|--|--|
| **缺什么** | 8 个嵌套 SWF 仍整包二进制 |
| **为何挡** | 深度改版 UI 艺术资源困难 |
| **怎么修** | 每 UI 一工程 → 编译 SWF → 替换 id 225/226/…/2215 → 体积门 |
| **DONE** | 至少 1 个 UI SWF 完成外置替换演示 |
| **状态（2026-10-11 17:48 CST）** | **DEMO DONE** — `tools/replace_ui_bin.py`；title id=2215 round-trip 入 **副本** `play/games/bvn-perfect-ui-demo/`（payload 不变，与 rev2 同 sha）；`D3-EXTERNALIZE.md` + `D3-ROUNDTRIP-RESULT.json`。完整艺术外置工程仍可选后续。main.swf 未改。 |

---

## Phase E — 引擎边角与包装

### E1 salect.xml 与加载边角（G12）

| | |
|--|--|
| **缺什么** | `salect.xml` 是否死文件未闭合；effect 内嵌 snd 调用细表可选 |
| **为何挡** | 清包时误删风险 |
| **怎么修** | 运行时断点/日志确认 `loadConfig` 仅 `select.xml`；决策 Keep/Delete；可选补 snd 表 |
| **DONE** | 决策写入 BUILD；删则冒烟通过 |
| **状态（2026-10-11 17:55 CST）** | **KEEP DONE** — `work/remake/engine/SALECT-XML.md`：**Keep**（非死文件）。冷启动 `loadConfig`→`select.xml`；`GameLogic.setGameMode(1)`（Ctrl+F8）→`salect.xml` + `winner_stg_mc2` + `SHOW_MODE=1`；Ctrl+F9 回 `select.xml`。可选 snd 表：`EFFECT-SND-TABLE.md` + `tools/build_effect_snd_table.py`（EffectModel 52 行 / 39 带声 / 27 唯一 snd）。main.swf 未改。 |

### E2 R8 / 第三方 / main.js（G13–G15）

| | |
|--|--|
| **缺什么** | 4399 Hold 指纹仅线上；第三方与 minify JS 非游戏逻辑 |
| **为何挡** | 不挡离线完美包；线上分发另测 |
| **怎么修** | 离线：`hold=null` + local-runtime-guard；第三方原样；`main.js` 只维 metas |
| **DONE** | 离线包声明「不含 4399 Hold 指纹」；线上可选附录 |
| **状态（2026-10-11 17:55 CST）** | **DOC DONE** — `work/remake/engine/WRAPPER-API.md`（metas `app.size`/`flashframe=2`/HTTP/blank-ad 404/Ruffle）；`G13-G15-OFFLINE.md`（Hold=null、第三方原样、minify 非目标）。离线声明模板已写入 WRAPPER §6。main.swf 未改。 |

---

## Phase F — 完美验收门

同时满足：

1. **可读**：沿用 FULL-READABILITY 终验（已 DONE），缺口仅 Documented。  
2. **可改包**：A1 工具 + B2 ZIP 回打演示通过。  
3. **可用**：F 清单（下）对战级 parity 通过。  
4. **无静默缺失**：G5/G8/G9/G10 均有 Keep 或 Fix 决策。  
5. **未污染原包**：`main.swf` sha 仍为 `5ddf9410…ba3e`。

| | |
|--|--|
| **状态（2026-10-11 17:51 CST）** | **DOC DONE / 游玩未全绿** — 权威表 `work/remake/PERFECT-REMAKE-STATUS.md`（G1–G15 逐项 Closed / Demo-PASS / Documented-gap / Still-open）。五门：可读 PASS；可改包 PASS（face 标可见）；可用 **PARTIAL**；无静默缺失 PASS（B3 保真 + G9 Keep + G10）；原包未污染 PASS。 |
| **管线** | **内容编辑管线就绪**（export 样例 + repack/embed + size-gate + bvn-perfect 脸标）。 |
| **诚实剩余** | P1 键控自动化 flaky；PNG 帧导出需 **java/ffdec**；R8 仅离线声明；地图增强 **可选**（非 F）。G4 仍为唯一 **Still-open**。 |

### 完美验收清单（摘要）

| # | 项 | 通过标准 | F 状态（17:51） |
|---|-----|----------|-----------------|
| 1 | 启动 | Logo→菜单，无 APP ERROR | Demo-PASS（rev2 menu） |
| 2 | 菜单文案 | 六项中文完整可读（REV2b 已有） | PASS |
| 3 | 选人 | 全角色/辅助/random 可选 | PARTIAL（进界面 PASS；全表未扫） |
| 4 | 对战 | ≥8 角色 × 开局到 KO/退出 | Still-open（midfight PASS；键控弱） |
| 5 | 辅助 | ≥4 辅助技能可见 | Still-open |
| 6 | 地图 | 14 图进场（洞策略一致） | Documented（SAME-HOLE；进场未跑） |
| 7 | 音效 | 菜单嵌入音 + 战斗 BGM | Still-open（表有；听感 TODO） |
| 8 | 设置/结束/说明 | 三态可进可出 | Still-open |
| 9 | 改包演示 | 改 VERSION 或 face 一张可见 | **PASS**（naruto-face-mark） |
| 10 | 文档 | 本计划阶段勾选 + 缺口表终态 | **PASS**（STATUS + B3 策略） |

产出：`play/games/bvn-perfect/`（脸标演示）+ `work/remake/PERFECT-REMAKE-STATUS.md`；完整对战级 `BUILD.txt` 待 G4 闭合后补洞策略戳。

---

## 阶段依赖与优先级

```
A1 门禁工具 ──┬── A2 对等清单
              ├── A3 skip 冻结
              │
              ├── B1 导出 ←── 可并行起步
              ├── B2 回打 ←── 依赖 A1
              ├── B3 地图策略
              ├── B4 effect 策略
              │
              ├── C1 C2 C3（可与 B 并行）
              ├── D1 D2（依赖 A3）
              ├── E*
              └── F 总验收 ←── 依赖以上 DONE
```

**建议下一刀（立即）**：稳住 P1 键控 / 人工补 G4 对战级（≥8 角色、辅助×4、地图×14 SAME-HOLE 进场、听感）→ 有 java 时批导 PNG 帧 + title/select import 验证 → 可选地图增强。B3/F 文档已落盘。不要再开 GreenHD/ABC 静态深挖。

---

## 附录 A — 改包检查表（每次发包）

工具：`tools/patch_size_gate.py` · `tools/serve_check.sh`（详解 `work/remake/SIZE-GATE.md`）。

```bash
python3 tools/patch_size_gate.py play/games/<build>/main.swf \
  --main-js play/games/<build>/main.js          # 或先 --dry-run / --verify
tools/serve_check.sh --game <build> [--start]   # HTTP :8765 + blank-ad 404 + flashframe=2
```

- [ ] 未改 `/workspace/bvn-3.3/main.swf` 原文件（只读输入）  
- [ ] import 根无 `com/green`、`ƃ`、`ɕ`、`ƒ` 等壳路径  
- [ ] 9× `.as.skip` 仍在  
- [ ] JPEXS `-onerror ignore` 后跑「回流报表」  
- [ ] 若动 ZIP：CRC 重算 + 抽检 3 条目  
- [ ] FileLength == 磁盘字节 == `#04236f9c`/`#4236f9c` 解析值 == `app.size["main.swf"]`（`patch_size_gate.py --verify`）  
- [ ] `flashframe=2`；HTTP 8765；blank-ad **404**（`serve_check.sh`）  
- [ ] BUILD.txt：bytes、sha256、stamp、洞策略  

## 附录 B — 关键路径

| 用途 | 路径 |
|------|------|
| 本计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` |
| 缺口排序 | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md` |
| 可读终验 | `work/full-analysis/FULL-READABILITY-STATUS.md` |
| 改包原理 | `BVN-ANALYSIS.md` §7–8 |
| REV 差距 | `REV-GAP-AUDIT-2026-10-11.md` |
| REV2 基线 | `play/games/bvn-rev2/BUILD.txt` |
| FULL 基线 | `play/games/bvn-full/BUILD.txt` |
| 地图/时间轴/UI/引擎 | `work/full-analysis/{assets/maps,timelines,ui,engine}/` |
| UI 回流/占位/外置 | `work/remake/ui/`（REFLOW-MATRIX · stubs · D3） |
| Phase E 引擎边角 | `work/remake/engine/`（SALECT-XML · WRAPPER-API · EFFECT-SND · G13-G15） |
| Phase F 验收状态 | `work/remake/PERFECT-REMAKE-STATUS.md`（G1–G15） |
| 地图 HARD/SOFT | `work/remake/maps/HARD-SOFT-POLICY.md` |

## 附录 C — 中文一句话

静态可读已闭环；**内容编辑管线已就绪**（ZIP 回打 + 体积门 + face 改可见）。仍卡 **对战级对等（G4 / P1 键控）**、全帧 PNG（需 java/ffdec）、R8 线上、地图增强可选。地图洞已保真文档化。按 STATUS 表收 G4，不再做一轮壳分析。

| 阶段 | 总进度（2026-10-11 17:51 CST） |
|------|--------------------------------|
| A1 | DONE |
| A2 | IN PROGRESS（menu/select/fight/midfight；键控弱） |
| B1 | SAMPLE DONE（PNG 帧待 java） |
| B2 | TOOLCHAIN PASS + face MARK_VISIBLE |
| B3 | **DONE（保真）** |
| C / D / E | DONE（表 + 演示 / Keep / 离线声明） |
| **F** | **DOC DONE**；游玩五门未全绿（G4 Still-open） |

计划时间：2026-10-11 17:51 CST（UTC+8）。权威验收：`work/remake/PERFECT-REMAKE-STATUS.md`。未改 `main.swf`。
