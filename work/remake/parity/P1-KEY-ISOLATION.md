# P1 键隔离烟测 — 练习模式关 CPU（G4）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-11 22:16 CST**（桌面 PASS 步骤 1–7；静态此前 21:53） |
| 目标 | 证明 P1 默认键（WASD/JKL）驱动可见；排除 CPU 伤害噪声 |
| 本轮桌面结果 | **PASS**（练习模式；截图 **×7**；D/J/K） |
| 本轮静态结果 | **PASS** — TRAINING 下 P2=KeyCtrl 非 AI（见 JSON） |
| URL | `http://127.0.0.1:8765/games/bvn-rev2/index.html` |
| 角色/地图 | P1 **一护** / P2 **鸣人** / 地图 **现世**；戳 **V3.3-REV2b** |

---

## 1. 静态结论（可验证）

`GameMode.TRAINING=40`：

- `isVsCPU()` 默认 **true**（含练习），但  
- `GameCtrl.addFighter` P2 分支用 **`isVsCPU(false)`** → 练习 **不**挂 `FighterAICtrl`，改挂 `FighterKeyCtrl`/`P2`。  
- 另启 `TrainingCtrler`：双方回血/气；`gameTimeMax=-1`；跳过 Round 开场倒计时。

→ **练习模式 = CPU 关**（P2 仅人工键；无人按 P2 则木桩）。

证据：`work/remake/parity/TRAINING-CPU-OFF-STATIC.json`  
锚点：`GameMode.as` / `GameCtrl.as` L269–337 / `MenuBtnGroup.as` TRAINING / `ConfigVO.setDefaultConfig` P1=`WASD JKL UIO`。

### 为何旧 midfight 不能当 P1 键 PASS

`parity/midfight.png`、`fight-deep.png` 来自 **对战/CPU 局**：`isVsCPU(false)` 为真 → P2=AI → 「可见伤害」可能来自 CPU，键注入失败时无法证伪。

---

## 2. 桌面结果 — PASS（2026-10-11 ≈22:16 CST）

环境：本地 `8765`；**须先点击画布**再注键；**练习模式**（非 VS CPU）。

| # | 操作 | 结果 | 截图 |
|---|------|------|------|
| 1 | 开 URL → 过 Update → 主菜单 | PASS；戳 V3.3-REV2b | `parity/training/01-menu.png` |
| 2 | 选 **练习模式** | PASS → 选人 | `02-select.png` |
| 3 | P1 一护 / P2 鸣人 / 地图现世 | PASS 进局；∞ 计时 | `03-training-start.png` |
| 4 | ≥10s 内不按键 | PASS：P2 **不**追攻（CPU 关） | `04-idle-no-cpu.png` |
| 5 | 点画布后连按 **D** | PASS：P1 右移贴鸣人 | `05-p1-move-D.png` |
| 6 | 连按 **J** | PASS：出拳；**3 HITS** / 掉血 | `06-p1-attack-J.png` |
| 7 | 按 **K** | PASS：起跳 | `07-p1-jump-K.png` |
| 8 | **U/I/O**（可选） | **未截到**独立技能帧；不记 PASS | （无 `08-skill-UIO.png`） |

附加：SWF 曾跳 4399 登录页；未登录；Ruffle Continue 恢复对局。`blank-ad` 404。

落盘：`play/games/bvn-rev2/parity/training/` **共 7 张**。  
清单：`PARITY-CHECKLIST.md` §3.3–3.4 / 3.8–3.9 / §5.6 rev2 → **PASS**；§3.5 UIO 仍 **TODO**。

---

## 3. 键位速查

| 槽 | 方向 | 攻/跳/冲 | 技能/必杀/辅助 |
|----|------|----------|----------------|
| P1 | W S A D | J K L | U I O |
| P2 | ↑ ↓ ← → | Num 1 2 3 | Num 4 5 6 |

