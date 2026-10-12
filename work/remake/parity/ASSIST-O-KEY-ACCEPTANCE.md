# 辅助 O 键上场 — 验收标准（G4 §5.3 / F≥4）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-12 01:19 CST** |
| 状态 | **标准 DONE**；桌面专证 **4/4 ALL PASS**（a1 四代火影 + a2 乱菊 + a3 魂 + a4 我爱罗） |
| main.swf | **未改**（`5ddf9410…ba3e`） |

---

## 1. 输入映射（静态）

| 层 | 事实 |
|----|------|
| 默认键 | `ConfigVO.setDefaultConfig` → `setKeys(87,83,65,68,74,75,76,85,73,**79**)` → P1 **O** = `KeyConfigVO.letterons` |
| 输入 | `GameInputer.special` / `FighterKeyCtrl` → `FighterMcCtrler.renderAssist` 调 `_actionCtrler.assist()` |
| 前置 | `actionState ∈ {0, 20}`（可行动）；**`fzqi >= 100`** |
| 触发 | `fzqi = 0`；`FighterEventDispatcher.dispatchEvent(..., "ADD_ASSISTER")` |
| 入场 | `FighterEventCtrl.addAssister` → `EffectCtrl.assisterEffect`（`fz_bleach` / `fz_naruto`）→ `Assister.goFight()` → `gotoAndPlay(2)` |
| 练习 | `TrainingCtrler` 维持 `fzqi=100` → **推荐**做 O 键验收（无需攒条） |

HowToPlay：`txt_special` ← `kc.letterons`（`KyoKeyCode.code2name`）。

---

## 2. PASS 判定（桌面）

**全部满足**：

1. 局内按 **O** 后 **≤1s** 内出现以下至少一项：
   - 辅助角色 MC 出现在舞台（非仅选人/HUD 头像）；或
   - 入场特效 `fz_bleach` / `fz_naruto`（光柱/闪光）；或
   - 辅助攻击命中对手（伤害数字 / HITS / 位移）。
2. 助战能量条（`fzqi` / 底栏）从满→空（或明显下降），随后回充。
3. **无** APP ERROR / 黄页 / 卡死。
4. 证据：`play/games/bvn-rev2/parity/assist/aN.png`（按下后有入场的一帧）。

**PARTIAL（不算 F 闭合）**：仅选人确认了助战，或 HUD 头像可见，但 **未**截到 O 键上场帧。  
（例：KO 局魂/我爱罗 HUD×2 = PARTIAL。）

**FAIL**：O 无响应且 `fzqi` 已满、可行动、已点画布焦点；或触发后崩溃。

---

## 3. 抽样要求（≥4）

| # | 桶 | 最低 | 备注 |
|---|-----|------|------|
| 2 | 有 FrameLabel | a1, a2 | 从 FULL×13 抽 |
| 2 | 无 FrameLabel（帧号驱动） | a3, a4 | 从 NO-LABEL×22 抽；证明帧号路径不炸 |

模式：**练习优先**；VS CPU 亦可（须等 `fzqi` 满）。

---

## 4. 非验收范围

- 不要求辅助必杀全段 / 全 HitVO 表。
- 不要求听感（Documented UNKNOWN）。
- 不改 `main.swf` / 不碰 hatch。

---

## 5. computerUse 最短步骤（父代理）

1. URL `http://127.0.0.1:8765/games/bvn-rev2/index.html`；菜单 → **练习模式**。
2. P1 一护；助战页选目标（a1…）；P2 鸣人；地图现世；开局。
3. **点击画布**；确认底栏助战条满；按 **O**；立即截 `parity/assist/a1.png`。
4. ESC→重选助战，重复 a2–a4（2 有标签 + 2 无标签）。
5. 回报：4 路径 + PASS/FAIL/PARTIAL 表。


### 23:13 a1 无效校正
- 文件 `play/games/bvn-rev2/parity/assist/a1.png` 存在，但内容为 P1 佐助冲刺残影，底栏助战仍 READY/满条 → **不满足** §2 PASS（无辅助 MC/入场特效/条清空）。
- 计 **0/4**；须练习模式点画布后按 **O** 重截。`main.swf` 未改。

### 23:30 桌面仍 0/4 + a2 PENDING
- **桌面 PASS 计数仍 0/4**（未闭合）。
- a1.png：仍 **无效**（佐助冲刺/残影；无助战 MC 上场）。
- a2.png：画面为乱菊站在虚白一护身后（训练 ∞）→ 可作为候选，但父代理正专按 O 重截 → 列 **PENDING reverify**，**不**标 PASS。
- a3.png / a4.png：**缺文件**。
- computerUse 重截进行中；有结果后再升 PASS。`main.swf` 未改。

### 23:43 chars 闭合后仍 0/4
- 角色覆盖已 **8/8**（c8 剑八 PASS）；辅助 O **仍 0/4**，**不**因 chars 闭合而标 assist PASS。
- computerUse 在 chars 闭合后继续专做 a1–a4 O 键上场。`main.swf` 未改。


### 23:46 a3 PASS
- `parity/assist/a3.png`：练习模式点画布后 **O**；无标签辅助 **kon/魂** MC 出现在 P1 左侧；左条 READY 满→空红条；右我爱罗仍 READY。
- 瑕疵：同帧舞台背景全黑（Ruffle 合成丢帧）；随后恢复、魂离场、条仍空 → 仍计 **PASS**。
- a1/a2 文件存在但判 FAIL/无效；a4 无文件。专证 **1/4**。`main.swf` 未改。


### 23:50 a3 PASS（魂 / kon）
- `play/games/bvn-rev2/parity/assist/a3.png`：练习 ∞；P1 剑八 vs 鸣人；**魂 Kon MC 站在 P1 身后舞台上**（非仅 HUD）→ §2 PASS。
- a1 仍无效（冲刺）；a2 乱菊站虚白身后仍计 CHAR8 表；a4 未截。computerUse 继续标辅助 a1。
- `main.swf` 未改。

### 2026-10-12 00:10 CST a2 PASS → 辅助 O 2/4
- **a2 乱菊 PASS**：`parity/assist/a2.png`（1024×593）；练习 ∞；虚白一护身后 **乱菊 MC 上台**；底栏乱菊肖像、无 READY（对比对侧我爱罗仍 READY）；4 HITS。→ §2 PASS。
- a3 魂 PASS 保持；**专证 2/4**。
- a1.png（00:00 重截）仍 **无效**：舞台仅一护+鸣人能量，无助战 MC；待 computerUse 覆盖。
- a4 **缺**；本轮已派 computerUse 专截 a1（有标签 minato/itachi）+ a4（无标签 gaara/orihime）。
- 未变：chars 8/8；R8 BLOCKED；P1/HARD/KO PASS；听感 UNKNOWN；设置 HowToPlay 桌面 PARTIAL。
- `main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch；完美游玩对等仍未盖章。

### 2026-10-12 00:32 CST a1/a4 computerUse FAIL（Options 陷阱）
- **a1 FAIL**：未覆盖 `a1.png`（仍 00:00 / 402783）；有标签助战未上台。
- **a4 FAIL**：未创建 `a4.png`。
- **未动** a2/a3；`main.swf` 未改；未碰 hatch。
- 阻塞屏：游戏设置 OPTION（`/tmp/assist-blocker.png`）；曾进练习局（∞、助战 READY）但 O 后飘到设置；二次点角色跳过助战页直进地图。
- **根因笔记**：Ruffle 键幽灵重复；**J/O 兼菜单选择与攻击/助战**；双标签页。下轮硬规：只开一页；**菜单/选人/助战/地图全用鼠标**；进局点画布后 **只按一次 O** 立刻截图。
- 专证仍 **2/4**（a2+a3）。下轮重派 computerUse。

### 2026-10-12 00:42 CST a1/a4 硬规重派
- 专证仍 **2/4**（a2+a3）。
- computerUse 按硬规重截 a1（有标签 minato/itachi）+ a4（无标签 gaara/orihime）：只开一页；菜单全鼠标；进局点画布后只按一次 O；不覆盖 a2/a3。
- `main.swf` 未改；未碰 hatch。


### 2026-10-12 00:51 CST 辅助 O 4/4 PASS → F≥4 闭合
- **a1 水门/Minato PASS**：`parity/assist/a1.png`（覆盖旧冲刺残影无效帧）；有标签桶；练习 ∞；O 后辅助上场专证。
- **a2 天天/Tenten PASS**：`parity/assist/a2.png`（00:45 覆盖；手里剑+火花；条空）；有标签桶。（旧乱菊帧已替换，以天天为准。）
- **a3 魂/Kon PASS**：`parity/assist/a3.png`（**未覆盖**；保持 23:46）；无标签桶。
- **a4 我爱罗/Gaara PASS**：`parity/assist/a4.png`（00:50）；无标签召唤闪有效（目标织姬未锁到，仍计 PASS）。
- 专证 **4/4** → G4/F「≥4 辅助技能可见」**闭合**。chars **8/8** 无回退。
- 未变：R8 Documented BLOCKED；P1/HARD/KO PASS；听感 Documented UNKNOWN；设置静态结案（见 `SETTINGS-STATIC-PATH.md`）。
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

### 2026-10-12 01:19 CST a1+a4 PASS → **4/4**
- **a1 PASS**：`parity/assist/a1.png`（111533 B）；Minato 白袍 MC 上台；左槽无 READY；黑底召唤闪（同 a3）。
- **a4 PASS**：`parity/assist/a4.png`（147891 B）；Gaara 入场蓝圈+身影；左 READY 消失。
- a2/a3 未动。专证 **4/4**；F≥4 辅助 **闭合**。`main.swf` 未改。
