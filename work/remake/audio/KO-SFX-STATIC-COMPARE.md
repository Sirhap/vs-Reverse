# KO / 音效静态目录对照（G4 听感前置）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-11 22:49 CST** |
| 范围 | 主 SWF DefineSound×8 + effect `snd_*`×31 + ZIP BGM/step；KO UI 桌面证据 |
| 机器可读 | `KO-SFX-STATIC-COMPARE.json` |
| main.swf | **未改**（`5ddf9410…ba3e`） |
| 静态门 | **PASS**（字节/符号齐全；与 SOUND-CATALOG / AUDIO-EXPORT 一致） |
| **KO UI** | **PASS**（22:48 `parity/ko/04-ko.png` 真 **K.O.** banner；timer 冻 **49**；P1 空血） |
| **听感** | **Documented UNKNOWN**（机器无声卡/sink；无法耳听；非 FAIL） |

---

## 1. DefineSound×8（主 SWF）

导出为 `export/_audio/main/` 符号链接 → `extracted/full/sounds/`。本轮 sha16 全匹配。

| id | 符号 | 场景 | 调用 | 静态 |
|---:|------|------|------|:----:|
| 223 | `snd_menu1` | 菜单导航 | `SoundCtrl.sndSelect` | PASS |
| 224 | `snd_menu2` | 确认 | `sndConfrim` | PASS |
| 2214 | `snd_menu5` | 标题进菜单 | `MenuState.showBtns` | PASS |
| 2216 | `snd_ko` | 普通 KO | `FightUI` `playSwcSound` | PASS |
| 2217 | `snd_ko_bs` | 必杀 KO | 同上 `bsKO` | PASS |
| 2218 | `snd_over_hit` | Over-hit | `FightUI` | PASS |
| 2212 | `snd_gameover` | Game Over | `GameOverState` | PASS |
| 2213 | `snd_ghost_jump` | 鬼步 | `EffectCtrl` | PASS |

权威：`SOUND-CATALOG.md` §A；`AUDIO-EXPORT.md` §2。

---

## 2. effect.swf `snd_*`×31

`export/_audio/effect/` **31/31** MP3；与 `EFFECT-SND-TABLE.md` / `AUDIO-EXPORT.md` §1 对齐。  
含 hit / hitfloor / dash / bs 等战斗 SFX。LEGACY-12 内 `snd_fzbs`/`snd_hit1`/`snd_hit10`/`snd_xdash` **Keep**。

---

## 3. ZIP preload BGM / step

| 集 | 数 | 路径 |
|----|---:|------|
| BGM | 21 | `export/assets/bgm/*.mp3`（含 preload 8 + 战斗/地图） |
| step SFX | 3 | `export/assets/sounds/step{1,2,3}.mp3` |

---

## 4. KO UI 桌面证据（2026-10-11 ~22:48 CST）

| # | 文件 | 内容 |
|---|------|------|
| 1 | `parity/ko/01-menu.png` | 主菜单 |
| 2 | `parity/ko/02-vs-cpu-select.png` | 选人（非练习） |
| 3 | `parity/ko/03-midfight.png` | 中段；P1 空血倒地；助战 HUD 魂/我爱罗 |
| 4 | `parity/ko/04-ko.png` | **真 K.O. 大字**（黄橙红渐变）；timer **冻 49**；P1 空血 / P2 满血 |
| 5 | `parity/ko/05-after-ko.png` | K.O. 后帧；timer 仍 49；P1 空血 |
| 交叉 | `parity/ko.png` / `ko-winner.png` | 早期 Winner（可保留交叉） |

**局况**：单人 → **对战电脑**（非练习）；P1 一护 vs P2 春野樱；助战 魂/我爱罗；**本局 P1 被 KO**（血条空）但出真 **K.O.** banner。

**听感**：**Documented UNKNOWN** — 执行机无声卡/ALSA sink，无法耳听 `snd_ko`/`snd_ko_bs`；静态字节与代码链已 PASS；有输出设备后再勾耳听。

---

## 5. 仍需桌面（听感 / 其它）

| # | 项 | 状态 |
|---|-----|------|
| 1 | 菜单 `snd_menu1/2/5` 耳听 | Documented UNKNOWN（无输出设备） |
| 2 | 对战命中 SFX 耳听 | 同上 |
| 3 | KO `snd_ko`/`snd_ko_bs` 耳听 | 同上；**UI 已 PASS** |
| 4 | Game Over / Winner BGM 耳听 | 同上；Winner UI 已有 |
| 5 | 战斗 BGM 切换 | 运行态；耳听同 UNKNOWN |

---

## 6. 交叉

- `PARITY-CHECKLIST.md` §5.4 / §6  
- `PERFECT-REMAKE-STATUS.md` 听感项  
- `REMAKE-GAP-INVENTORY.md` G4 / G7  
- `KO-UI-STATIC-PATH.md`（FightUI.playKO 链）

## 7. 代码路径

见同目录 `KO-UI-STATIC-PATH.md`（FightUI.playKO 链）。桌面 KO UI **已 PASS**（`parity/ko/04-ko.png`）。
