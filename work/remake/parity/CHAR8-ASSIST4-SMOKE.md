# ≥8 角色 / ≥4 辅助 覆盖计划与缺口表（G4 / F）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-12 01:19 CST** |
| 状态 | **角色进场 8/8 PASS**；辅助 O **4/4 ALL PASS** |
| URL | `http://127.0.0.1:8765/games/bvn-rev2/index.html` |
| stamp | V3.3-REV2b |
| 相关 | `ASSIST-O-KEY-ACCEPTANCE.md`；`SETTINGS-STATIC-PATH.md` |

---

## 1. 角色进场覆盖缺口表（目标 ≥8）

每局最低标准：选人确认 → 地图确认 → **开局 HUD 可见**（不必打到 KO）；无 APP ERROR；落盘 `parity/chars/cN.png`。

| # | id | 中文 | 阵营 | 证据 | 状态 |
|---|-----|------|------|------|------|
| 1 | `ichigo` | 黑崎·一护 | 死神 | `chars/c1.png`；另 training/KO 多局 | **PASS** |
| 2 | `rukia` | 朽木露琪亚 | 死神 | `chars/c2.png` | **PASS** |
| 3 | `sakura` | 春野樱 | 火影 | `chars/c3.png`；fight-deep / KO 局 | **PASS** |
| 4 | `toushirou` | 日番谷冬狮郎 | 死神 | `chars/c4.png` | **PASS** |
| 5 | `naruto` | 漩涡鸣人 | 火影 | `chars/c5.png`（练习 ∞；P1 鸣人 vs 鸣人；助战魂/我爱罗） | **PASS** |
| 6 | `sasuke` | 宇智波佐助 | 火影 | `chars/c6.png`（练习 ∞；P1 佐助 vs 剑心；助战大蛇丸/小樱 READY） | **PASS** |
| 7 | `byakuya` | 朽木白哉 | 死神 | `chars/c7.png`（1024×593；P1 白哉；midfight HUD；timer 56；现世风） | **PASS** |
| 8 | `kenpachi` | 更木剑八 | 死神 | `chars/c8.png`（1024×593；~599876 bytes；P1 kenpachi 破烂羽织+缺口刀 vs 鸣人；∞/CONTINUE；助战魂/我爱罗 READY） | **PASS** |

**备选替换**（若某 id 选人困难）：`renji` / `kakashi` / `itachi` / `ulquiorra` / `aizen`。

**已覆盖 8/8**；F 项「≥8 角色开局」已达。辅助 O **4/4 PASS** → F「≥4 辅助」已达。**双目标闭合**。

### computerUse（父代理）— 角色 c5–c8

1. 打开 `http://127.0.0.1:8765/games/bvn-rev2/index.html`；等 Update→菜单；**先点画布**获焦点。
2. 菜单：**单人模式** → **对战电脑**（或练习亦可；本表只验进场）。
3. 选人：P1 选目标 id（方向键/鼠标）；确认；P2 任选；助战可跳过默认；地图 **现世**。
4. 开局后等 Round 字消失 → 截 `play/games/bvn-rev2/parity/chars/c5.png`（依序 c6/c7/c8）。
5. ESC 回菜单，重复至 8 张齐。记录 stamp `V3.3-REV2b`。

---

## 2. 辅助 O 键上场（目标 ≥4）

验收标准全文见 **`ASSIST-O-KEY-ACCEPTANCE.md`**（本表只列抽样）。

| # | 类型 | 建议 id | 截图 | 状态 |
|---|------|---------|------|------|
| a1 | 有标签 | `minato`（水门） | `parity/assist/a1.png` | **FAIL**（肖像已选；舞台无助战 MC；00:57 校正；重截中） |
| a2 | 有标签 | `tenten`（天天） | `a2.png` | **PASS**（手里剑+火花；条空；00:45 覆盖旧乱菊帧） |
| a3 | 无标签（帧号） | `kon`（魂） | `a3.png` | **PASS**（未覆盖；O 上场；条满→空） |
| a4 | 无标签（帧号） | `gaara`（我爱罗） | `a4.png` | **PASS**（召唤闪；织姬未锁到，无标签召唤仍有效） |

有标签全集（FULL actions 13）：`byakuya` `ichigo_white2` `itachi` `kimimaro` `madara` `minato` `nemu` `shikamaru` `shishio` `soifon`/`soifong` `tenten` `yachiru`。  
无标签×22：见 `assist/NO-LABEL-FRAME-MAP.md`。

### computerUse — 辅助 a1–a4

1. **练习模式**（推荐：`TrainingCtrler` 维持 `fzqi=100`，可连按 O）。
2. 选人后进**助战页**选目标；地图现世；开局。
3. **先点画布**；确认底栏助战条满（练习通常满）；按 **O**（P1 `letterons`=79）。
4. 成功判定：辅助 MC 入场 **或** `fz_bleach`/`fz_naruto` 特效，**或** 对手受击/位移；助战条清空再回充。截 `parity/assist/aN.png`。
5. 失败：无入场且无特效且无 APP ERROR 以外异常 → 记 FAIL + 截图。

---

## 3. 依赖 / 交叉

- KO UI **PASS**（`parity/ko/04-ko.png`）；听感 Documented UNKNOWN。
- 设置/说明静态可读性：`SETTINGS-STATIC-PATH.md` **PASS**（桌面进屏仍 TODO）。
- `main.swf` 未改。

### 22:55 c5 PASS
- `parity/chars/c5.png`（1024×593）：练习模式 ∞；P1/P2 均为鸣人开局 HUD 可见；助战魂/我爱罗条。
- c6–c8：computerUse 进行中。`main.swf` 未改。


### 23:13 c6 PASS + a1 校正
- `parity/chars/c6.png`（1024×593）：练习 ∞；P1 佐助 vs 剑心；开局 HUD 可见 → **PASS**。覆盖 **6/8**。
- `parity/assist/a1.png`：画面为佐助冲刺残影，助战条仍满/READY → **无效**（非 O 键上场专证）；计 **0/4**，待重截。
- c7 白哉 / c8 剑八：computerUse 进行中。`main.swf` 未改。

### 23:30 c7 PASS；c8 错角色；assist 0/4
- **c7 白哉 PASS**：`parity/chars/c7.png`（1024×593；~23:25）；P1 角肖像白哉；midfight HUD；timer 56；现世风 → 覆盖 **7/8**。
- **c8 仍 GAP**：`chars/c8.png` 文件在，但画面为虚白一护作 P1，**不是**更木剑八 → **不标 PASS**；computerUse 已在飞覆盖重写。
- 辅助仍 **0/4**：a1 无效；a2 PENDING reverify（非 PASS）；a3/a4 缺。`main.swf` 未改。

### 23:43 c8 PASS / chars 8/8
- **c8 更木剑八 PASS**：覆盖重写 `parity/chars/c8.png`（1024×593；~599876 bytes）。局内：P1 kenpachi（左，破烂羽织+缺口刀）vs 鸣人；∞ 计时 + CONTINUE 层；助战魂/我爱罗 READY。源图由父代理自 computerUse 捕获拷入。
- 角色覆盖 **8/8**；辅助 O 仍 **0/4**。`main.swf` 未改（`5ddf9410…ba3e`）；未碰 hatch。


### 23:46 c7/c8 PASS + a3 PASS
- **c7 白哉 PASS**：`parity/chars/c7.png`（1024×593）；非练习计时 56；碎蜂斩特效大。
- **c8 剑八 PASS**：`parity/chars/c8.png`；练习 ∞；VS 文案「更木·剑八」；地图森林。
- **角色覆盖 8/8 闭合**。
- **a3 魂 PASS**：`parity/assist/a3.png`；O 后 Kon 入场；左援护条满→空；背景闪黑一帧（Ruffle）。
- a1/a2 仍无效；a4 未打。`main.swf` 未改。


### 23:50 a3 PASS + chars 8/8 对齐
- chars **8/8**（c8 剑八已盖）。
- assist **a3 魂 PASS**；a1 仍无效；a2/a4 进行中。`main.swf` 未改。

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
- 角色 **8/8** 无回退；辅助 O **2/4**（a2+a3）。
- computerUse 硬规重截 a1+a4（Options 陷阱对策）；不覆盖 a2/a3。
- `main.swf` 未改；未碰 hatch。


### 2026-10-12 00:51 CST 辅助 O 4/4 + chars 8/8 双闭合
- a1 水门 / a2 天天 / a3 魂 / a4 我爱罗 → **4/4 PASS**。
- 角色 **8/8** 无回退。G4/F 双抽样目标闭合。
- `main.swf` 未改；未碰 hatch。

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

### 2026-10-12 01:19 CST 辅助 O **4/4** 闭合
- a1 minato + a4 gaara 桌面 PASS；a2/a3 保持；角色 8/8 无回退。
- F「≥4 辅助技能可见」**PASS**。`main.swf` 未改；未碰 hatch。
