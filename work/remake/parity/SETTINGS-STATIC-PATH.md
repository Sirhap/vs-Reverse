# 设置 / HowToPlay / Credits 静态路径与可读性（G4 §7）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-12 00:51 CST** |
| 判定 | **静态结案 PASS**（链 + CJK）；HowToPlay 桌面 PASS（`howtoplay-01/02.png`）；设置主屏/Credits/重绑桌面**可选非挡** |
| 样本 | `main.swf` SHA-256 `5ddf9410…ba3e`（未改） |
| 用途 | 补 PARITY §7；桌面冒烟前关「静默缺失 / 文案洞」 |

---

## 菜单入口（`MenuBtnGroup.getFucByLabel`）

| label | 中文菜单 | 行为 |
|-------|----------|------|
| `OPTION` | 游戏设置 | `MainGame.I.goOption()` → `SettingState` |
| `TRAINING` | 练习模式 | `GameMode=40` → `goSelect()` |
| `CREDITS` | 制作组 | `MainGame.I.goCredits()` → `CreditsState` |
| `SINGLE ACRADE` / `TEAM ACRADE` | 闯关 | 若 `GameConfig.SHOW_HOW_TO_PLAY` → `goHowToPlay()` 否则 `goSelect()` |

源：`decompiled/main/scripts/net/play5d/game/bvn/ui/MenuBtnGroup.as`。

---

## SettingState / SetBtnGroup — 静态 CJK 核对

UI：`ResUtils.I.setting` / `stg_set_ui`；BGM `back`。  
主项来自 `SetBtnGroup.initMainBtns`（无 `GameInterface.getSettingMenu` 覆盖时）。**本轮逐条核对源码 `cn` 字符串**：

| 键 / 项 | `cn` 字面量 | 静态可读 |
|---------|-------------|:--------:|
| P1 键位 | 玩家1 按键设置 | PASS |
| P2 键位 | 玩家2 按键设置 | PASS |
| AI | 电脑等级 | PASS |
| AI opts | 非常简单/简单/正常/困难/非常困难/地狱 | PASS |
| 操作模式 | 按键操作模式 → 正常模式 / 经典模式 | PASS |
| HP | 生命值 → 50%…500% | PASS |
| 时间 | 对战时间 → 30秒/60秒/90秒/无限制 | PASS |
| SFX | 游戏音效 → 0%…100% | PASS |
| BGM | 背景音乐 → 0%…100% | PASS |
| 画质 | 画质等级 → 低/中/… | PASS |
| 底部 | 还原默认按键 / 应用 / 取消 / 设置全部 | PASS |

键位重绑：`goKeyConfig` → `SetCtrlBtnUI`；APPLY → `saveData` + `applyConfig` + `updateConfig` + `goMenu`。

源：`state/SettingState.as`；`ui/SetBtnGroup.as`。

---

## HowToPlayState — 静态可读性

- UI：`movie_howtoplay`；BGM `back`
- 从 `GameData.I.config.key_p1` 填：
  `txt_up/down/left/right/attack/jump/dash/skill/bisha/special`
  （`special` ← `kc.letterons` = 默认 **O**；`KyoKeyCode.code2name`）
- Skip：`skip_btn` 或 back → 帧 `"skip"` → `goSelect()`

→ §7.3 **HowToPlay 显示当前 P1 键名** 静态成立。  
桌面须目视：键名未裁切、字体不糊成方框。

源：`state/HowToPlayState.as`。

---

## CreditsState — 静态可读性

`getCreditsText()` 返回中文 HTML（设计/美术/研发…剑jian 等）。静态字面量 **PASS**（UTF-8 无 mojibake）。  
桌面须目视滚动/换行。

源：`state/CreditsState.as` L81–83。

---

## 与桌面冒烟的关系

| # | PARITY 项 | 静态链 | 静态 CJK | 桌面进屏 |
|---|-----------|:------:|:--------:|:--------:|
| 7.1 | 游戏设置可进可出 | PASS | PASS | **可选**（静态结案） |
| 7.2 | 键位重绑保存 | PASS | PASS | **可选** |
| 7.3 | HowToPlay P1 键名 | PASS | PASS | **PASS**（01/02.png） |
| 7.4 | 制作组 Credits | PASS | PASS | **可选** |
| 7.5 | 排行榜 | 入口存在 | — | P3 |
| 7.6 | 小队模式 | TEAM* labels | — | TODO |

### 静态结案（00:51 CST）
- 源码链 + `cn` CJK 已全 PASS；HowToPlay 桌面已有 `howtoplay-01/02.png` → §7.3 PASS。
- §7.1/7.2/7.4 桌面进屏**不挡**离线主线（同 HARD 静态结案口径）；标 **可选**。

### computerUse（可选补截，≤3 步）
1. URL `http://127.0.0.1:8765/games/bvn-rev2/index.html`；菜单鼠标点 **游戏设置** → 截 `parity/settings/01-main.png`。
2. 点 **玩家1 按键设置** → 截 `02-p1-keys.png`；ESC 回设置再 ESC 回菜单。
3. 菜单点 **制作组** → 截 `04-credits.png`。（HowToPlay 已有，不必重截。）


### 23:52 HowToPlay 桌面 PARTIAL
- 误入/截到 HowToPlay：`parity/settings/howtoplay-01.png`（左右行走说明 + WASD/UIOJKL）、`howtoplay-02.png`（跳跃/K 高亮）。
- 桌面进屏：HowToPlay **PARTIAL PASS**；设置/Credits/结束屏仍 TODO。
- `main.swf` 未改。


### 2026-10-12 00:51 CST 静态结案
- §7 设置/说明：**静态结案 PASS**；HowToPlay 桌面已齐；其余桌面可选。
- 不挡「运行时对等主线」盖章。`main.swf` 未改。
