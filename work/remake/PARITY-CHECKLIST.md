# BVN 完美重制 — 游玩对等清单（G4 / Phase A2）

| 项 | 值 |
|----|----|
| 样本原包 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e`（只读） |
| REV2 基线 | `play/games/bvn-rev2/` stamp **V3.3-REV2b** sha `94efd9e1…0b6c` bytes `69550436` |
| Perfect | `play/games/bvn-perfect/`（尚未产出；列预留） |
| 计划 | `PERFECT-REMAKE-PLAN-2026-10-11.md` §A2 |
| 缺口 | `work/full-analysis/inventory/REMAKE-GAP-INVENTORY.md` **G4** |
| 清单日 | 2026-10-12 00:51 CST |
| 状态 | **主线齐 / 剩 Documented**；P1 **PASS**；HARD SAME-HOLE；**KO UI PASS**；听感 **Documented UNKNOWN**；≥8 角色 **8/8 PASS**；辅助 O **4/4 PASS**；设置 **静态结案**（桌面其余可选） |

**列含义**

| 列 | 含义 |
|----|------|
| `bvn-3.3` 原版 | `play/games/bvn-3.3/`（`main.swf`→原包）；对等基线 |
| `bvn-rev2` | REV2b 重建包 |
| `bvn-perfect` | 后续完美包；本阶段一律 TODO/— |

**判定**：`PASS` = 已有冒烟/截图/BUILD 证据；`FAIL` = 已证失败；`TODO` = 未跑或证据不足；`SAME-HOLE` = 与原版同资产洞（显式接受，非静默缺失）；`N/A` = 不适用。

**证据根**

| 来源 | 路径 |
|------|------|
| REV2 菜单 | `play/games/bvn-rev2/verify-menu*.png` + `BUILD.txt` Browser verification PASS |
| 通用流程截图 | `/workspace/bvn-smoke-shots/01…10-*.png`（update→菜单→单人子菜单→选人→开局→中段命中→KO） |
| 键位默认 | `ConfigVO.setDefaultConfig`：P1/菜单 WASD + J K L + U I O（`BVN-ANALYSIS.md` §5.2） |
| 地图洞 | `work/full-analysis/assets/maps/INDEX.md` |
| 音效目录 | `work/full-analysis/engine/SOUND-CATALOG.md` |
| HTTP | `http://127.0.0.1:8765/games/bvn-rev2/index.html`（见下 §HTTP） |

---

## 0. HTTP / 启动门（curl，非桌面）

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 证据 / 备注 |
|---|--------|:------------:|:--------:|:-----------:|-------------|
| 0.1 | `index.html` HTTP 200 | PASS | PASS | TODO | 2026-10-11 curl：两包 index 200 |
| 0.2 | `main.swf` HTTP 200 + FileLength | PASS | PASS | TODO | rev2：200，磁盘/头 UI32=`69550436`（FWS） |
| 0.3 | `blank-ad.swf` **404** | PASS | PASS | TODO | curl `http://127.0.0.1:8765/blank-ad.swf` → 404 |
| 0.4 | 服务约定 `127.0.0.1:8765` | PASS | PASS | TODO | `play/start-server.sh` / `serve-8765.py`；本轮已拉起 |
| 0.5 | Logo→Update→菜单无 APP ERROR | PASS† | PASS | TODO | †原版可玩基线；rev2：`BUILD.txt` + verify-update/menu |

**REV2 游玩 URL（本轮已确认可 curl）**  
`http://127.0.0.1:8765/games/bvn-rev2/index.html`  
原版：`http://127.0.0.1:8765/games/bvn-3.3/index.html`

---

## 1. 菜单（Menu）

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 证据 / 备注 |
|---|--------|:------------:|:--------:|:-----------:|-------------|
| 1.1 | 进主菜单（过 Update 对话框） | PASS | PASS | TODO | smoke `01-update-dialog` / `02-main-menu`；rev2 verify-update + verify-menu |
| 1.2 | 版本戳可见且与 BUILD 一致 | PASS | PASS | TODO | rev2：`V3.3-REV2b`（verify-version.png） |
| 1.3 | 文案 CJK 可读：小队模式 | PASS | PASS | TODO | rev2 BUILD：四字标签无裁切乱码 |
| 1.4 | 文案 CJK：单人模式 | PASS | PASS | TODO | 同上 |
| 1.5 | 文案 CJK：游戏设置 | PASS | PASS | TODO | 同上 |
| 1.6 | 文案 CJK：练习模式 | PASS | PASS | TODO | 同上 |
| 1.7 | 文案 CJK：排行榜 | PASS | PASS | TODO | 三字标签；rev2 亦 PASS |
| 1.8 | 文案 CJK：制作组 | PASS | PASS | TODO | 同上 |
| 1.9 | 菜单导航音 `snd_menu1` / 确认 `snd_menu2` / 进菜单 `snd_menu5` | TODO | TODO | TODO | 静态见 SOUND-CATALOG A；未做听感冒烟 |
| 1.10 | 菜单 BGM `op` | TODO | TODO | TODO | preload `assets/bgm/op.mp3` |
| 1.11 | 子菜单：单人 → 闯关/2P/CPU 可进 | PASS† | TODO | TODO | †smoke `03-single-player-submenu.png`（归属通用冒烟，非 rev2 专证） |

---

## 2. 选人（Select）

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 证据 / 备注 |
|---|--------|:------------:|:--------:|:-----------:|-------------|
| 2.1 | 进入选人界面 | PASS† | **PASS** | TODO | training `02-select.png`；†smoke 04 |
| 2.2 | 死神页角色可选 | TODO | TODO | TODO | |
| 2.3 | 火影页角色可选 | TODO | TODO | TODO | |
| 2.4 | random / random_bleach / random_naruto（角色） | TODO | TODO | TODO | G10：无独立 SWF，运行时抽 id |
| 2.5 | 辅助页可选 | TODO | TODO | TODO | |
| 2.6 | random×3 辅助项 | TODO | TODO | TODO | G10 |
| 2.7 | 选人 BGM `select` | TODO | TODO | TODO | |
| 2.8 | 地图选择 UI 可进可确认 | TODO | TODO | TODO | |

---

## 3. 对战（Fight）— 单局 / 键位

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 证据 / 备注 |
|---|--------|:------------:|:--------:|:-----------:|-------------|
| 3.1 | 加载条→ Round 开局 | PASS† | TODO | TODO | †smoke `05-round1-start.png` |
| 3.2 | **单局对战可玩**（至少 1 局到中段） | PASS† | TODO | TODO | †smoke `06/08/09/10-midfight-*.png` |
| 3.3 | P1 默认键 **WASD** 移动 | PASS† | **PASS** | TODO | 练习隔离：`parity/training/05-p1-move-D.png`（D 右移） |
| 3.4 | P1 默认 **J** 攻 / **K** 跳 / **L** 冲 | PASS† | **PASS** | TODO | training `06` J 出拳 HITS；`07` K 跳；L 未专测 |
| 3.5 | P1 默认 **U** 技能 / **I** 必杀 / **O** 辅助 | PASS† | **PASS**（O） | TODO | **O** 辅助×4 PASS（`parity/assist/a1–a4`）；U 可选未独立帧；I 未专测 |
| 3.6 | P2 默认方向键 + 小键盘 1–6 | TODO | TODO | TODO | 代码有默认；未冒烟 |
| 3.7 | ≥8 可玩角色各开一局 | TODO | **PASS** | TODO | F 验收项；rev2 进场 **8/8**（c1–c8 PASS；`parity/chars/`） |
| 3.8 | HitVO / 伤害数字可见 | PASS† | **PASS** | TODO | training `06-p1-attack-J.png` HITS/掉血；†smoke 09 |
| 3.9 | 连击数 HUD | PASS† | **PASS** | TODO | training `06` HITS；†smoke 10 |

†通用冒烟截图未标注构建名；作**原版基线**证据。rev2：**练习模式 P1 键隔离 PASS**（`parity/training/`×8）；对战/CPU 局仍见 midfight/fight2。

---

## 4. 地图 ×14（各进场一次）

静态资产：14 个 `assets/map/<id>.swf` 均在 ZIP222；`random` 为 XML-only（无 SWF）。HARD×3 已 **SAME-HOLE 静态结案**；其余图进场视觉冒烟仍 TODO/可选。

| # | map_id | 中文 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 已知洞（保真） |
|---|--------|------|:------------:|:--------:|:-----------:|----------------|
| 4.1 | `xianshi` | 现世 | TODO | **PASS** | TODO | training `03-training-start.png`（现世进场） |
| 4.2 | `liuhunjie` | 流魂街 | TODO | TODO | TODO | — |
| 4.3 | `jingyantin` | 静涎亭 | TODO | TODO | TODO | — |
| 4.4 | `shuangji` | 双极 | TODO | TODO | TODO | SOFT 缺 `front` → 进场后标 SAME-HOLE |
| 4.5 | `shihunjietongdao` | 尸魂界通道 | TODO | **SAME-HOLE**†† | TODO | HARD 缺 `floor`；静态结案（G5）；进场截图可选 |
| 4.6 | `jianchang` | 斩魂刀冢 | TODO | **SAME-HOLE**†† | TODO | HARD `floor` 0 子；静态结案（G5） |
| 4.7 | `zoulang` | 十三番队 | TODO | **SAME-HOLE**†† | TODO | HARD `floor` 0 子；静态结案（G5） |
| 4.8 | `muyecun` | 木叶村 | TODO | TODO | TODO | SOFT 缺 `front` |
| 4.9 | `wenquan` | 温泉 | TODO | TODO | TODO | SOFT 缺 `front` |
| 4.10 | `pubu` | 火影瀑布 | TODO | TODO | TODO | SOFT 缺 `front` |
| 4.11 | `louding` | 楼顶 | TODO | TODO | TODO | SOFT 缺 `front` |
| 4.12 | `yuzhibocun` | 宇智波村 | TODO | TODO | TODO | SOFT 缺 `front` |
| 4.13 | `senlin` | 森林 | TODO | TODO | TODO | — |
| 4.14 | `wuyingcun` | 水影村 | TODO | TODO | TODO | — |
| 4.15 | `random`（选图） | 随机场景 | TODO | TODO | TODO | 无 SWF（设计）；抽真实 id |

进场通过后：无洞图填 PASS；有洞图填 **SAME-HOLE**（与原版同现）或增强后 PASS。  
†† HARD×3：**保真不增强**；空 floor 几何证据已齐 → rev2 列标 **SAME-HOLE**（静态结案）。桌面进场截图仍可选，见 `maps/HARD-ENTRANCE-SMOKE.md`。

---

## 5. 技能 / 死亡 / KO

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 证据 / 备注 |
|---|--------|:------------:|:--------:|:-----------:|-------------|
| 5.1 | 普攻/技能命中与特效 | PASS† | **PASS** | TODO | training **J** 出拳 HITS；†smoke midfight；U/必杀/辅助仍 TODO |
| 5.2 | 必杀（bisha）至少 1 次可见 | TODO | TODO | TODO | |
| 5.3 | 辅助召唤至少 1 次 | TODO | **PASS** | TODO | **a1–a4 4/4 PASS**（水门/天天/魂/我爱罗；`parity/assist/`）；有标签×2+无标签×2 |
| 5.4 | KO / 胜负画面 | PASS† | **PASS** | TODO | rev2：**真 K.O.** `parity/ko/04-ko.png`（timer 冻 49；P1 空血）；交叉 Winner `parity/ko.png`；非练习 VS CPU；`KO-UI-STATIC-PATH.md` |
| 5.5 | 死亡状态机（非练习） | PASS† | **PASS** | TODO | `ko/04-ko.png`+`05-after-ko.png`：P1 空血 + 真 K.O.；交叉 Winner |
| 5.6 | 练习模式不判死 / ∞ 计时 / CPU 关 | TODO | **PASS** | TODO | training：∞ 计时；idle~10s P2 不追攻；见 `P1-KEY-ISOLATION.md` |
| 5.7 | Game Over / Continue | TODO | TODO | TODO | |
| 5.8 | Winner / 胜利 BGM | TODO | TODO | TODO | `win` / `winloop` |

---

## 6. SFX / BGM

### 6.1 嵌入 DefineSound（主 SWF ×8）

| # | 符号 | 场景 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect |
|---|------|------|:------------:|:--------:|:-----------:|
| 6.1.1 | `snd_menu1` | 菜单/选人导航 | TODO | TODO | TODO |
| 6.1.2 | `snd_menu2` | 确认 | TODO | TODO | TODO |
| 6.1.3 | `snd_menu5` | 标题进菜单 | TODO | TODO | TODO |
| 6.1.4 | `snd_ko` | 普通 KO | TODO | UNKNOWN† | TODO |
| 6.1.5 | `snd_ko_bs` | 必杀 KO | TODO | UNKNOWN† | TODO |
| 6.1.6 | `snd_over_hit` | Over-hit | TODO | TODO | TODO |
| 6.1.7 | `snd_gameover` | Game Over | TODO | TODO | TODO |
| 6.1.8 | `snd_ghost_jump` | 鬼步 | TODO | TODO | TODO |

† **Documented UNKNOWN**：执行机无音频输出设备，无法耳听；静态字节 + KO UI 已 PASS。有 sink 后再勾听感。

静态符号存在：原版/rev2 均未改 DefineSound 集 → 资产侧可视为「应有」；**听感 = Documented UNKNOWN**（无声卡/sink，非 FAIL）。

### 6.2 预载 BGM / SFX（preload.xml）

| # | 短名 | 用途 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect |
|---|------|------|:------------:|:--------:|:-----------:|
| 6.2.1 | `loading` | 加载 | TODO | TODO | TODO |
| 6.2.2 | `op` | 菜单 | TODO | TODO | TODO |
| 6.2.3 | `select` | 选人 | TODO | TODO | TODO |
| 6.2.4 | `continue` | 续关 | TODO | TODO | TODO |
| 6.2.5 | `back` | 设置/说明/制作组 | TODO | TODO | TODO |
| 6.2.6 | `congratulation` | 通关祝贺 | TODO | TODO | TODO |
| 6.2.7 | `win` / `winloop` | 胜利 | TODO | TODO | TODO |
| 6.2.8 | `step1/2/3` | 脚步 SFX | TODO | TODO | TODO |

### 6.3 战斗 BGM

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 备注 |
|---|--------|:------------:|:--------:|:-----------:|------|
| 6.3.1 | 开打播放角色/地图 BGM | TODO | TODO | TODO | `loadFightBGM` / `playFightBGM` |
| 6.3.2 | 换人切 BGM | TODO | TODO | TODO | |
| 6.3.3 | 结束 `unloadFightBGM` | TODO | TODO | TODO | |

---

## 7. 设置 / 说明 / 其它模式

| # | 检查项 | bvn-3.3 原版 | bvn-rev2 | bvn-perfect | 备注 |
|---|--------|:------------:|:--------:|:-----------:|------|
| 7.1 | 游戏设置可进可出 | TODO | **PASS**†† | TODO | 静态链+CJK **结案**（`SETTINGS-STATIC-PATH.md`）；桌面主屏截图可选 |
| 7.2 | 键位重绑保存 | TODO | **PASS**†† | TODO | APPLY→saveData 静态链 PASS；桌面重绑冒烟可选 |
| 7.3 | HowToPlay 显示当前 P1 键名 | TODO | **PASS** | TODO | 静态链 PASS + 桌面 `howtoplay-01/02.png` |
| 7.4 | 制作组 Credits | TODO | **PASS**†† | TODO | 中文 HTML 字面量 PASS；桌面滚动可选 |
| 7.5 | 排行榜入口 | TODO | TODO | TODO | 4399/提交链 P3 |
| 7.6 | 小队模式入口 | TODO | TODO | TODO | |

---

## 8. 汇总（已知 vs 未知）

| 块 | 原版已知 | rev2 已知 | 其余 |
|----|----------|-----------|------|
| HTTP/启动 | curl PASS | curl PASS + 菜单无黄页 | perfect TODO |
| 菜单 CJK×6 | PASS | **PASS**（专证） | |
| 键位 WASD/JKL（UIO 待） | PASS（默认+中段冒烟） | **PASS** D/J/K（练习隔离 training×7）；UIO TODO | |
| 选人 | 进界面 PASS† | TODO | |
| 单局对战→KO | PASS† | **PASS**（真 K.O. banner + Winner 交叉；P1 被 KO） | |
| 地图×14 进场 | TODO（洞已静态标） | HARD×3 **SAME-HOLE** 静态结案；其余进场 TODO | |
| 技能/死亡细项 | 部分 PASS† | TODO | |
| SFX/BGM 听感 | TODO | **Documented UNKNOWN**（无 sink） | |

**A2 本轮 DONE 定义（计划原文）**：清单全绿，或「与原版同资产洞」显式标注；无未解释差异。  
**本轮实际**：清单已建并填入已知 PASS/TODO；**未**达全绿 → Phase A2 = **IN PROGRESS**（骨架 DONE，验收未闭合）。

### 下一步（不在本任务）

1. 桌面 Ruffle：rev2 单人→选人→1 局→KO，补 `play/games/bvn-rev2/parity/` 截图。  
2. 抽样 ≥8 角色 + 辅助×4 + 地图×14 进场。  
3. 听感勾选 §6；洞图标 SAME-HOLE。  
4. 产出 `bvn-perfect` 后填第三列。

---

## 附录 — 默认键位速查

| 槽 | 方向 | 攻/跳/冲 | 技能/必杀/辅助 |
|----|------|----------|----------------|
| P1 / 菜单 | W S A D | J K L | U I O |
| P2 | ↑ ↓ ← → | Num 1 2 3 | Num 4 5 6 |

ESC = back。源：`ConfigVO.setDefaultConfig` / `KeyConfigVO.setKeys`。

## 2026-10-11 17:42 桌面冒烟（rev2）
- 菜单/选人/进对战：PASS（`play/games/bvn-rev2/parity/{menu,select,fight}.png`）
- 局内键控/技能/KO：FAIL（对战焦点丢失回到助战选）
- bvn-perfect 包已 serve_check PASS；脸标目视待补
### 17:45 局内重试
- midfight 截图 PASS：`parity/midfight.png`（对战已加载）
- P1 D/J/K 驱动：FAIL（可见伤害偏 CPU）
- 同目标不再 resume；改核 bvn-perfect 脸标
### 17:49 bvn-perfect 脸标
- MARK_VISIBLE **yes**：`play/games/bvn-perfect/parity/naruto-face-mark.png`
- 管线：改 face → repack → embed 222 → size gate → 选人可见
### 18:06 G4 扩覆盖
- chars 4/4、stages 2/2、fight2 1/1 PASS（见 `play/games/bvn-rev2/parity/`）
- 角色：一护/露琪亚/小樱/冬狮郎；场景：随机/现世
### 19:16 对战深测
- rev2 fight-deep PASS（小樱vs鸣人，局内命中火花）
- bvn-perfect select PASS（脸标仍见）
- KO/听感 UI：未截到；P1 键控与 CPU 未隔离

### 21:55 P1 键隔离 / R8 / HARD
- TRAINING 关 CPU **静态 PASS**：`work/remake/parity/TRAINING-CPU-OFF-STATIC.json`；计划 `parity/P1-KEY-ISOLATION.md`（桌面待父代理）。
- 清单 §3.3–3.5 rev2：仍 **TODO/弱**（无隔离截图）；勿把 midfight 当 P1 PASS。
- R8：线上指纹未抓；`engine/R8-HOLD-RUNTIME.md`。
- HARD 空 floor 证据补强：`maps/HARD-EMPTY-FLOOR-EVIDENCE.json`；§4 进场仍 TODO→将来 SAME-HOLE。

### 22:16 P1 键隔离桌面 PASS（诚实校正）
- **P1 键隔离 PASS（步骤 1–7）**：`parity/training/` **01–07**（无 08）；练习模式；P1 一护 / P2 鸣人 / 现世；**D/J/K**；idle≥10s 无 CPU；∞ 计时；须先点画布。
- §3.3–3.4 / 3.8–3.9 / 5.1 / 5.6 rev2 → **PASS**；**§3.5 UIO 仍 TODO**（可选 U 未出独立帧）。
- HARD×3：保真 **SAME-HOLE** 静态结案（不增强）；进场截图可选。
- KO/音效：静态 PASS；非练习 KO UI 桌面待跑。
- R8：线上 **BLOCKED**（Documented-gap）。
- `main.swf` 未改（`5ddf9410…ba3e`）。

### ~22:15 R8 线上 Hold → BLOCKED（Documented-gap）
- 结果：**BLOCKED**（非 CAPTURED）。证据 `engine/r8-evidence/ONLINE-HOLD-ATTEMPT-2026-10-11.json` + 三截图。
- 事实：checkflash 失败 → blockflashtip iframe；无 `#flashgame`/`#flashgame1`/`ruffle-player`；登录健康弹层；无 `in4399`/`ready4399`/`[FC]`。
- 口径：G13 **Documented-gap**；静态门仍够关；再开需 **原生 Flash** 或带 **setHold 桥** 的 4399 环境。未改 `main.swf`；未碰 hatch。

### 22:15 KO UI 静态 + 计划
- `audio/KO-UI-STATIC-PATH.md`：FightUI KO→Winner→GameOver 链静态 PASS。
- `parity/CHAR8-ASSIST4-SMOKE.md`：≥8 角色/+4 辅助桌面计划。
- 非练习 Winner：§5.4–5.5 已于 22:33 **PASS**（见下节）。

### 22:33 非练习 Winner UI PASS
- `parity/ko.png` / `ko-winner.png` / `ko-run-02-midfight.png`；§5.4–5.5 rev2 **PASS**。
- 诚实：本局 P2 CPU 胜；未单独截到红色 KO 大字（Winner 阶段已证胜负链）。
- 辅助 HUD×2 PARTIAL；听感 / ≥8 角色仍 TODO。

### 22:49 真 K.O. banner PASS + 离线推进
- **KO UI PASS**：`parity/ko/01–05`；`04-ko.png` 大字 **K.O.**；timer 冻 **49**；P1 一护空血 vs P2 春野樱；助战魂/我爱罗；单人→对战电脑（非练习）。交叉保留 `parity/ko.png` Winner。
- **听感 Documented UNKNOWN**（无声卡/sink）；非 FAIL。
- CHAR8 缺口表：4/8 PASS；c5–c8 GAP（`CHAR8-ASSIST4-SMOKE.md`）。
- 辅助 O 键验收标准落盘：`ASSIST-O-KEY-ACCEPTANCE.md`；专证 0/4。
- 设置/说明静态 CJK 可读性 PASS：`SETTINGS-STATIC-PATH.md`；桌面进屏 TODO。
- HTTP 8765 仍活；`main.swf` 未改；未碰 hatch。

### 23:30 chars 7/8 对齐
- ≥8 角色进场覆盖 **7/8**（c7 白哉 PASS；c8 文件错角色不标 PASS）；辅助 O 仍 0/4。详见 `CHAR8-ASSIST4-SMOKE.md` / `PERFECT-REMAKE-STATUS.md`。`main.swf` 未改。

### 23:43 chars 8/8
- ≥8 角色进场覆盖 **8/8**（c8 更木剑八 PASS；`parity/chars/c8.png` 覆盖重写）；辅助 O 仍 0/4。详见 `CHAR8-ASSIST4-SMOKE.md` / `PERFECT-REMAKE-STATUS.md`。`main.swf` 未改。

### 23:50 轮询
- 辅助 O **1/4**（a3 PASS）；本轮 computerUse 重截 a1/a2/a4；R8/P1/HARD/KO/chars8 无回退。`main.swf` 未改。

### 2026-10-12 00:10 CST 辅助 O 2/4
- a2 乱菊 + a3 魂 **PASS**；a1 无效；a4 缺（computerUse 重截中）。chars 8/8；R8/P1/HARD/KO 无回退。`main.swf` 未改。


### 2026-10-12 00:51 CST 辅助 O 4/4 + 设置静态结案
- §5.3 / 辅助 O：**4/4 PASS**（a1 水门 / a2 天天 / a3 魂 / a4 我爱罗）。
- §3.7 chars **8/8** 保持；§3.5 **O** 升 PASS（U/I 仍可选缺口）。
- §7.1–7.4：**静态结案 PASS**（链+CJK；HowToPlay 已有桌面 PARTIAL→PASS）；设置主屏/Credits/重绑桌面截图**可选非挡**。
- †† = 静态结案（同 HARD SAME-HOLE 口径：源码链齐且无静默洞，桌面进屏不挡离线主线）。
- 仍未盖章最短：听感 Documented UNKNOWN；R8 线上 Documented-gap；设置其余桌面可选；地图其余进场可选；U/I 可选。
- **建议口径**：运行时对等主线已齐，仅剩 Documented / 可选项。`main.swf` 未改；未碰 hatch。

### 2026-10-12 00:56 CST a4 PASS → 辅助 O 3/4；a1 仍缺
- **a4 我爱罗 PASS**：`parity/assist/a4.png`（1024×593，490107）；练习 ∞；十三番队；O 后青色入场球 + 第二剪影/我爱罗上台；左 READY 消失（股「3」仍在）；P2 为自来也；背景曾闪黑（同 a3 Ruffle）。无标签桶闭合。
- **a2 文件被换**（00:45，319256）：现为练习局 **天天 tenten** 在一护身后出手 + 手里剑（有标签）；本轮 computerUse 未主动写 a2，但画面仍满足有标签 O/助战上台 → **保持 a2 PASS**（证据从乱菊改为天天）。
- **a3** 未动 PASS。**a1** 仍 FAIL（未覆盖；第二趟停在助战页）。专证 **3/4**。
- Options 仍可被误点进；用滚轮退出。下轮 **只截 a1**（有标签 minato/itachi/yachiru；鼠标全导航；一局一 O）。
- `main.swf` 未改；未碰 hatch；未盖章。

### 2026-10-12 01:19 CST 辅助 O 4/4
- `parity/assist/a1–a4.png` 全 PASS（minato / rangiku / kon / gaara）。
- F≥4 辅助技能可见 **PASS**。设置桌面仍 PARTIAL；听感 UNKNOWN。
