# BVN 3.3 全量可读性分析计划（2026-10-11）

**目标**：把 GreenHD 壳、引擎、ZIP/二进制资产全部做到「可读」——不是「可 rewrite 就够」。  
可读定义见各阶段验收标准。未改游戏二进制；提取物默认落 `work/full-analysis/`。

| 项 | 值 |
|----|----|
| 样本 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e` |
| 工作区 | `/workspace/bvn-3.3/work/full-analysis/` |
| 既有反编译 | `decompiled/`（894 `.as` / 0 FFDec 失败） |
| 既有逐行 | `reverse/line-by-line/`（~836 篇 + SHELL-SYMBOL-MAP） |
| 对照审计 | `REV-GAP-AUDIT-2026-10-11.md`、`REA-REANALYSIS-2026-10-11.md` |
| 本计划 | `FULL-ANALYSIS-PLAN-2026-10-11.md` |

---

## 0. 剩余不可读性总盘点（Phase 0 产出）

完整表：`work/full-analysis/inventory/UNREADABILITY-INVENTORY.md`。

| 类别 | 现状 | 为何仍算「不可读」 | 验收靶 |
|------|------|-------------------|--------|
| **A. GreenHD 混淆包** | 25/32 壳脚本有逐行；符号表已大量建议名 | 7 个 callee 无 line-by-line；`Ǻ` 大量冷路径符号未进主表；包名仍是 Unicode | 每个壳 `.as` 有注解 + 符号表无 `UNRESOLVED` 阻塞项 |
| **B. 壳 callee 缺口** | `com/sh/*`、`Ȇ/*`、`LOADING_*` 仅被 MAP 点名 | 无独立 `.md`；成员未系统命名 | 补齐 line-by-line + MAP 节 |
| **C. ZIP id=222** | 407 条目已清单；9 XML 可读；91 SWF/273 PNG/24 MP3 仍二进制 | 无「资产→引擎符号」目录；fighter/map SWF 内时间轴标签未枚举 | `ASSET-CATALOG.md`：每路径有类型/用途/引用点 |
| **D. DefineBinaryData UI×8** | 已抽出并反编译 73 `.as` | **Closed** Phase6：`work/full-analysis/ui/` SymbolClass×73 + stubs；JPEXS 重编 keep-ABC 已文档 | UI 符号类目录 + 与 `ResUtils`/`AssetManager` 交叉 |
| **E. DefineSound×8** | 已抽出 MP3；SymbolClass 有 `snd_*` 名 | 与 UI/菜单触发点对照未表格化 | 声音目录：id→符号→调用点 |
| **F. JPEG×3** | 已抽出 | 仅哈希符号名 | 标注加载条图 / 提交分 / movelist |
| **G. 地图 14 SWF** | 0 `.as`（纯显示） | 碰撞实例名 / 图层未从 SWF 标签枚举 | 每图：实例名、bounds、与 `map.xml` 对照 |
| **H. 角色时间轴** | 468 `.as` + 注解 | `*_fla` 自动符号名；帧标签全集未抽 | 每角色 frame labels + defineAction 索引 |
| **I. 特效 effect.swf** | 89 `.as` | 与 `EffectVO`/XML 交叉未完成 | effect 名 ↔ 资源符号表 |
| **J. 第三方库** | greensock / fzip / fl.motion / adobe.utils | 非混淆但非「游戏语义」 | 标为第三方；不强制改名 |
| **K. Ruffle/JS 包装** | metas VERIFIED | `main.js` 混淆单文件语义图未完整 | 包装 API 表（size/flashframe/广告位） |

**相对 REV-GAP「分析够 rewrite」的差别**：本计划要求 **资产目录 + 壳全符号 + 地图实例** 也进入可读状态，不是停在「已知对策」。

---

## 1. 分阶段

### Phase 1 — GreenHD 壳符号闭环（完成，R8 运行时洞）

| 项 | 内容 |
|----|------|
| 输入 | `decompiled/main/scripts/{ƒ,ƃ,ɕ,ǹ,ȁ,Ȋ,Ȑ,Ƿ,Ȇ,com/green,com/sh,LOADING*,Bleach*}` + `reverse/line-by-line/shell` + `SHELL-SYMBOL-MAP` |
| 动作 | 补缺 line-by-line；把 `Ǻ` 冷路径、`com.sh`、`Ȇ`、LOADING 写入 MAP；列 UNRESOLVED |
| 产出 | 更新 `SHELL-SYMBOL-MAP.md`；`work/full-analysis/shell/` 证据；缺篇补到 `reverse/line-by-line/shell/` |
| **验收** | （1）壳相关 `.as` 均有对应 `.md`；（2）MAP 含包/类/成员建议名；（3）UNRESOLVED 仅限静态不可判项并写明原因；（4）引导链 FM→FA→FB→FC 可用建议名复述 |

### Phase 2 — 主 SWF 嵌入资产目录

| 项 | 内容 |
|----|------|
| 输入 | `extracted/full/{binary-data,sounds,images,swf,nested-swf}` + SymbolClass |
| 动作 | 建 `ASSET-CATALOG-MAIN.md`：DefineBinaryData / Sound / JPEG 全员 |
| **验收** | 每 id 有：类型、字节、符号名、抽出路径、引擎引用类 |

### Phase 3 — ZIP id=222 全量目录

| 项 | 内容 |
|----|------|
| 输入 | `extracted/full/zips/bin_222/assets/**` + config XML |
| 动作 | 按 face/fighter/map/bgm/config/font/sounds/effect 建目录；XML 字段→资源路径交叉 |
| **验收** | 407 条目均有一行目录；XML 引用无悬空路径 |

### Phase 4 — 地图可读（无脚本仍要资产语义）

| 项 | 内容 |
|----|------|
| 输入 | 14 map SWF + `map.xml` + `FloorVO`/`GameLogic` |
| 动作 | 标签/实例名枚举 → `work/full-analysis/assets/maps/`；PlaceObject MATRIX + shape RECT 几何表 |
| **验收** | 每图有实例名表 + 与 `map.xml` id 对齐 |
| **状态** | ✅ **DONE** (2026-10-11 deepen) — 几何表+硬/软洞；`PHASE4-STATUS.md`；HARD floor miss=`shihunjietongdao`；SOFT front miss×6 |

### Phase 5 — 角色/特效时间轴标签与动作索引

| 项 | 内容 |
|----|------|
| 输入 | fighters `*_fla`、`05-fighter-actions.md`、effect |
| 动作 | 抽 frame labels / sound cues；建 per-fighter INDEX |
| **验收** | 可玩角色均有「标签→动作约定」表；effect 名可反查 |

### Phase 6 — UI 嵌套 SWF 符号与库类型

| 项 | 内容 |
|----|------|
| 输入 | `decompiled/ui/*` + ByteArray stubs |
| 动作 | 库符号表；标注 JPEXS `:*` 失败项 |
| **验收** | 8 个 UI SWF 各有符号目录；与 MenuState/FightUI 等交叉 |
| **状态** | ✅ **DONE** (2026-10-11) — `work/full-analysis/ui/` INDEX+8 md；SymbolClass Σ=73；JPEXS 反编译 0 失败 / 重编 keep-ABC；见 `PHASE6-STATUS.md` |

### Phase 7 — 引擎交叉引用图（只补洞）

| 项 | 内容 |
|----|------|
| 输入 | 已有 181 引擎注解 |
| 动作 | ZipAssetLoader/AssetManager 路径表；声音/UI 加载点 |
| **验收** | 从菜单→选人→对战的资源加载路径可用建议名走通 |
| **状态** | ✅ **DONE** (2026-10-11) — `work/full-analysis/engine/LOAD-PATH.md` + `SOUND-CATALOG.md`；见 `PHASE7-STATUS.md` |

### Phase 8 — 总验收与中文总结

| 项 | 内容 |
|----|------|
| 产出 | `work/full-analysis/FULL-READABILITY-STATUS.md` + 更新本计划勾选 |
| **验收** | UNREADABILITY 表全部 Closed 或 Documented-Unreadable（仅第三方/死代码） |
| **状态** | ✅ **DONE** (2026-10-11) — `FULL-READABILITY-STATUS.md`；U1–U15 终验 |

---

## 2. 全局验收标准（「一切可读」）

1. **命名符号**：壳混淆标识符在 MAP 中有建议英文名；引擎保持 `net.play5d` 原名。  
2. **资产目录**：主 SWF 9 BinaryData + 8 Sound + 3 JPEG + ZIP 407 条目均有目录行。  
3. **证据路径**：每条结论指向 `decompiled/` 或 `extracted/` 或 `work/full-analysis/`。  
4. **不改原包**：分析/提取只写 `work/full-analysis/` 与文档；游戏二进制只读。  
5. **诚实缺口**：静态不可判的标 UNRESOLVED + 原因；不装作已解。

---

## 3. 证据路径速查

| 用途 | 路径 |
|------|------|
| 本计划 | `/workspace/bvn-3.3/FULL-ANALYSIS-PLAN-2026-10-11.md` |
| 不可读清单 | `work/full-analysis/inventory/UNREADABILITY-INVENTORY.md` |
| 壳符号表 | `reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md` |
| 壳逐行 | `reverse/line-by-line/shell/` |
| 抽出 ZIP | `extracted/full/zips/bin_222/` |
| 主清单 | `extracted/full/INVENTORY.md` |
| Phase1 工作 | `work/full-analysis/shell/` |
| Phase6 UI | `work/full-analysis/ui/` |
| Phase7 引擎 | `work/full-analysis/engine/` |
| Phase8 终验 | `work/full-analysis/FULL-READABILITY-STATUS.md` |

---

## 4. Phase 进度

| Phase | 状态 | 备注 |
|-------|------|------|
| 0 盘点 | **DONE** | 见 inventory |
| 1 壳符号 | **DONE** | MAP+32 line-by-line；仅 R8 Hold 实例 Documented-Unreadable |
| 2 主SWF资产目录 | **DONE** | `work/full-analysis/ASSET-CATALOG-MAIN.md` (9+8+3) |
| 3 ZIP222目录 | **DONE** | `ASSET-CATALOG-ZIP222.md` 398文件+9目录=407；XML悬空0 |
| 4 地图实例 | **DONE** | 几何 deepen：MATRIX/RECT twip 表 + FloorVO；HARD=`shihunjietongdao`缺floor；SOFT=6图缺front；见 `PHASE4-STATUS.md` |
| 5 角色/特效时间轴 | **DONE** | `timelines/` INDEX + fighters + effects；见 PHASE5-STATUS |
| 6 UI嵌套符号 | **DONE** | `ui/INDEX.md` + 8 per-UI；SymbolClass Σ=73；JPEXS 反编译0失败/重编 keep-ABC；见 PHASE6-STATUS |
| 7 引擎交叉引用 | **DONE** | `engine/LOAD-PATH.md` + `SOUND-CATALOG.md`；菜单→选人→对战路径走通；见 `PHASE7-STATUS.md` |
| 8 总验收 | **DONE** | `FULL-READABILITY-STATUS.md`；inventory U1–U15 Closed/Documented |

更新日期：2026-10-11 14:50 CST（UTC+8）。
