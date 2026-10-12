# KO UI 静态代码路径（G4 听感/KO 前置）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-11 22:49 CST** |
| 范围 | FightUI KO→Winner→GameOver 调用链 + 桌面真 K.O. 证据 |
| 配套 | `KO-SFX-STATIC-COMPARE.md`（声二进制 PASS；听感 Documented UNKNOWN） |
| main.swf | **未改**（`5ddf9410…ba3e`） |
| 静态门 | **PASS** |
| **KO UI 桌面** | **PASS**（`parity/ko/04-ko.png` 真 K.O.；timer 49；P1 空血） |

---

## 1. 结束链（非练习）

| 步 | 位点 | 行为 |
|----|------|------|
| 1 | `FightUI` 局末 | `renderStartAndKO` → 非 timer → `playKO(loser)` |
| 2 | `playKO` | `snd_over_hit`；500ms 后 `startKOmc` → `"ko"`；`playSwcSound(bsKO ? snd_ko_bs : snd_ko)` |
| 3 | `bsKO` | P1/P2 `actionState` ∈ {12,13}（必杀态）→ `snd_ko_bs` + `BGEffect("kobg")` |
| 4 | `koBack` | resume；随后 `_showWinnerDelay` → `showWinner` → `startKOmc` `"winner"` |
| 5 | `MainGame.goWinner` | `WinnerState` |
| 6 | `MainGame.goGameOver` | `GameOverState.showGameOver` → `snd_gameover` |

锚点文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightUI.as`（≈L202–L521）；`MainGame.as` `goWinner`/`goGameOver`；`GameOverState.as` L237–241。

## 2. 为何练习模式验不了 KO

`GameMode.TRAINING`：`TrainingCtrler` 回血 + `gameTimeMax=-1`；不走死亡/胜负 → **无** `playKO`。  
桌面必须用 **单人 VS CPU**（或可 KO 的非练习模式）。见 `parity/P1-KEY-ISOLATION.md`。

## 3. 与静态声对照

| 符号 | KO 链角色 | 静态字节 | 耳听 |
|------|-----------|:--------:|------|
| `snd_over_hit` | KO 前击中顿 | PASS | Documented UNKNOWN |
| `snd_ko` | 普通 KO | PASS | Documented UNKNOWN |
| `snd_ko_bs` | 必杀 KO | PASS | Documented UNKNOWN |
| `snd_gameover` | Game Over | PASS | Documented UNKNOWN |

## 4. 桌面证据（已闭合 UI）

| # | 项 | 产出 | 状态 |
|---|-----|------|------|
| 1 | 非练习局真 **K.O.** 大字 | `parity/ko/04-ko.png` | **PASS** |
| 2 | K.O. 后帧 / Winner 交叉 | `05-after-ko.png`；`parity/ko.png` | **PASS** |
| 3 | 听感勾选 §6.1.4–6.1.5 | 耳听 | **Documented UNKNOWN**（无输出设备） |

本文件闭合代码路径 + UI 桌面；听感不假装 PASS。
