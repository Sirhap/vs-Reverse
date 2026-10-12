# 地图 HARD / SOFT 策略（G5 / G8 · Phase B3）

| 项 | 值 |
|----|----|
| 样本 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e`（**未改**） |
| 权威几何 | `work/full-analysis/assets/maps/INDEX.md` |
| 缺口 | `REMAKE-GAP-INVENTORY.md` **G5**（HARD floor）· **G8**（SOFT front） |
| 计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` §B3 |
| 决策日 | 2026-10-11 17:51 CST（UTC+8） |
| **默认策略** | **保真（fidelity）** — 与原版 **SAME-HOLE**；不静默补洞 |

---

## 1. 原则

完美重制对地图洞必须二选一，不可假装没有：

| 路径 | 含义 | Phase F 要求 |
|------|------|--------------|
| **保真（默认）** | 原样保留资产洞；parity / 验收标 `SAME-HOLE` | 文档闭合即可；进场行为与原版同现 |
| **增强（可选）** | 补 `floor`/`ban*` 或 `front` 后回打 map SWF→ZIP222 | **非** F 门禁；须录屏证明碰撞/视差后再改标 PASS |

本轮 **采用保真**。增强路径仅文档备查，**不**阻塞 Phase F。

---

## 2. HARD（G5）— FloorVO 平台

引擎：`MapMain.initFloor` 依赖根实例 `floor`；子级 `ban*` 等进入 `_floors` / FloorVO。缺 `floor` 或 0 子 → 无平台 hit-test；仍可靠 `line_player_bottom` / `line_bottom` 作地面。

| map_id | 中文 | 洞 | 运行时 | 保真判定 |
|--------|------|-----|--------|----------|
| `shihunjietongdao` | 尸魂界通道 | 根实例 **缺 `floor`** | `initFloor` no-op；`_floors=[]` | **SAME-HOLE** |
| `jianchang` | 斩魂刀冢 | `floor` 在、**0 子** | `_floors=[]`；靠 playerBottom | **SAME-HOLE** |
| `zoulang` | 十三番队 | `floor` 在、**0 子** | 同上 | **SAME-HOLE** |

证据：

- 汇总：`work/full-analysis/assets/maps/INDEX.md` §Hard holes  
- 单图：`assets/maps/{shihunjietongdao,jianchang,zoulang}.md` + `.dumpSWF.txt`  
- 导出样例：`work/remake/export/_meta/map/shihunjietongdao/`（FloorVO **0**；hard `floor`）  
- 引擎：`decompiled/main/scripts/net/play5d/game/bvn/map/MapMain.as`

**parity 填法**：进场冒烟通过后填 `SAME-HOLE`（非 FAIL、非静默 PASS）。

---

## 3. SOFT（G8）— `front` 视差层

`front` 全路径 `if(frontLayer)`；缺失不崩，仅无前景/光学校正层。

| map_id | 中文 | 洞 | 保真判定 |
|--------|------|-----|----------|
| `shuangji` | 双极 | 缺 `front` | **SAME-HOLE** |
| `muyecun` | 木叶村 | 缺 `front` | **SAME-HOLE** |
| `wenquan` | 温泉 | 缺 `front` | **SAME-HOLE** |
| `pubu` | 火影瀑布 | 缺 `front` | **SAME-HOLE** |
| `louding` | 楼顶 | 缺 `front` | **SAME-HOLE** |
| `yuzhibocun` | 宇智波村 | 缺 `front` | **SAME-HOLE** |

`front_fix` / `logo4399` 缺席属正常可选，**不**计入 SOFT 洞、**不**要求补。

证据：`work/full-analysis/assets/maps/INDEX.md` §SOFT holes；各 `assets/maps/<id>.md`。

---

## 4. 无 HARD/SOFT 洞的图（保真下应 PASS）

进场后应标普通 `PASS`（资产侧无洞）：  
`xianshi` `liuhunjie` `jingyantin` `senlin` `wuyingcun`  
另：`random` 无 SWF（G10 设计）→ 抽真实 id，见 `RANDOM-XML-ONLY.md`。

---

## 5. 可选增强路径（非 F 必需）

仅当产品明确要「修地图」时启用；默认包 **不**走此路径。

### 5.1 HARD 增强

1. 以几何表为锚：`work/full-analysis/assets/maps/<id>.md` + phase4 `geometry.json`。  
2. 在 map SWF 根补 `floor`（`shihunjietongdao`），或在已有 `floor` 下补 `ban*` 平台子级（`jianchang`/`zoulang`）；MATRIX/bounds 对齐 `line_player_bottom`。  
3. 回打：`repack_zip222.py` → `embed_bin222.py` → `patch_size_gate.py`（见 `REPACK.md` / `SIZE-GATE.md`）。  
4. 验收：三图进场 + 平台碰撞录屏；parity 由 `SAME-HOLE` 改为 `PASS`（增强）。

### 5.2 SOFT 增强

1. 为 6 图补根实例 `front`（位图/MC + PlaceObject）；引擎已 null-check，补上即启用视差。  
2. 同 ZIP 回打链路。  
3. 验收：6 图前景层可见 / 视差可辨。

### 5.3 增强门禁（若启用）

- [ ] 未改仓库根 `main.swf`（只改编译副本）  
- [ ] CRC + 体积门三件套  
- [ ] HARD×3 碰撞录屏 + SOFT×6 视差截图落 `play/games/<build>/parity/maps/`  
- [ ] `BUILD.txt` 写明「map enhance: HARD+SOFT」与原版差异表  

---

## 6. Phase F 闭合条件（保真）

| 项 | 状态 |
|----|------|
| 默认保真写入本文件 | **DONE** |
| G5×3 + G8×6 在 parity 标 SAME-HOLE 策略 | **DONE**（HARD×3 rev2 列已 **SAME-HOLE** 静态结案 22:09；SOFT 策略仍预标；桌面进场可选） |
| 增强录屏 | **N/A**（本轮不增强） |

**B3 DONE（保真路径）**：策略已写入；增强可选且不挡 F。

---

## 附录 — 与 PARITY-CHECKLIST §4 对齐

`work/remake/PARITY-CHECKLIST.md` 地图表「已知洞」列已指向 G5/G8；进场通过后有洞图填 **SAME-HOLE**，无洞图填 **PASS**。本策略为该列的权威解释。
