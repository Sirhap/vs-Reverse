# `stg_gameover_mc` — 续关 / GAME OVER 根 MC

一句话目的：`gameover` SWF 唯一导出。Arcade 失败后的续关页 + GAME OVER 页共用这一条时间轴：四段标签各播到 `stop` + `Event.COMPLETE`，引擎靠 `"complete"` 切阶段。

源文件：`decompiled/ui/gameover/scripts/stg_gameover_mc.as`（51 行）

## 如何挂上引擎

[`ResUtils.GAME_OVER`](../../../engine/game/bvn/utils/ResUtils.md) = `"stg_gameover_mc"`。[`GameOverState`](../../../engine/game/bvn/state/GameOverState.md) 构造：

```
createDisplayObject(ResUtils.I.gameover, ResUtils.GAME_OVER)
_ui.gotoAndStop(1)
```

先于 `goStage`。两条入口：

| 入口 | 谁调 | 本 MC |
|------|------|--------|
| `MainGame.goContinue` | Arcade P1 败 | 构造后立刻 `showContinue()` → `gotoAndPlay("continue")` |
| `MainGame.goGameOver` | 本包未见其它 `.as` 直调；续关选 NO 在同一实例上接 `showGameOver()` | `gotoAndPlay("gameover")` |

`Istage.display` 返回本 MC。FPS 30，与 SWF 头 `fps=30` 一致。

引擎 **不** `addEventListener(Event.COMPLETE)` 常量名，而是字符串 `"complete"`。本类 `dispatchEvent(new Event(Event.COMPLETE))` 的 type 就是 `"complete"`，对得上。

箭头不在本 SWF：[`select_arrow_mc`](../../common_ui/scripts/select_arrow_mc.md) 从 `common_ui` `addChild` 到本 MC。YES/NO/BACK 的键盘左右在 [`GameOverState.render`](../../../engine/game/bvn/state/GameOverState.md)。

SWF：`gameover_swf`（DefineBinaryData id 227），链接名 `stg_gameover_mc`，`symbol="symbol39"`。Sprite id=39，共 242 帧。AS 类 **没有** 标签字面量；下列帧号来自 SWF `FrameLabel`（`extracted/full/swf/bin_227.swf`）。

## 时间轴（按标签分组）

`addFrameScript` 0-based：`N` = 时间轴 `F{N+1}`。

| 标签 | 起始 | COMPLETE 脚本 | 段长 | 引擎 `gotoAndPlay` | complete 回调 |
|------|------|----------------|------|-------------------|---------------|
| （空闲） | F1 | — | — | 构造 `gotoAndStop(1)` | — |
| `"continue"` | F5 | **F50** `frame50` | ~46f / 1.5s | `showContinue` | `showContinueComplete` → `initBtn("btn_yes"/"btn_no")` + 箭头默认 YES |
| `"continue_no"` | F55 | **F85** `frame85` | ~31f / 1.0s | `showContNo` | `showContNoComplete` → `showGameOver()` |
| `"continue_yes"` | F92 | **F124** `frame124` | ~33f / 1.1s | `showContYes` | `showContYesComplete` → `loseScoreByContinue` + `goSelect` |
| `"gameover"` | F132 | **F238** `frame238` | ~107f / 3.6s | `showGameOver` | `gameOverComplete` → `GameEvent("GAME_OVER")` + `initBtn("btn_back")` |

时间轴顺序是 **continue → continue_no → continue_yes → gameover**（NO 段在 YES 段前面）。运行时 YES/NO 是互斥跳转，不会顺着播。每段 `stop()` 后到下一标签前有几帧空隙（F51–54 / F86–91 / F125–131 / F239–242），正常路径进不去。

## 字段 / 按钮 / 容器

引擎一律 `_ui.getChildByName(...)`，也可直接点 typed 字段。子件只在对应段存在：

| L | 名字 | 类型 | 时间轴 | 引擎 |
|---|------|------|--------|------|
| L10 | `btn_back` | `MovieClip` | F224 放入（gameover 段） | gameover COMPLETE 后 `initBtn`；click → `MainGame.goLogo()`（**不是** `goMenu`） |
| L12 | `btn_no` | `MovieClip` | F40 放入，F132 卸掉 | continue COMPLETE 后 `initBtn`；右键/hover；click → `showContNo` |
| L14 | `btn_yes` | `MovieClip` | F40 放入（continue 段），F132 卸掉 | 同上，左键；默认选中；click → `showContYes` |
| L16 | `ct_char` | `MovieClip` | F5 放入（continue 起），F132 卸掉 | `addChar`：把 `continueLoser` 的 `FighterMain.mc` `scale=3` 塞进来，先 `lose()`；YES 时 `_char.idle()` |
| L18 | `ct_score` | `MovieClip` | F132 放入（gameover 起） | `addScore`：`BitmapFontText` `"SCORE "+GameData.I.score`，`x = -width/2` 居中 |

`ct_char` / `ct_score` 若当前帧还没有，引擎 `setFrameOut` 重试（char 2 帧、score 1 帧）。直达 `showGameOver` 不调 `addChar`。

`initBtn`：`buttonMode=true`，听 `"mouseOver"` / `"click"`。子对象不在当前帧则静默 return。

## 引擎回调链

```
showContinue  → "continue"  → F50 COMPLETE → YES/NO + 箭头
  YES → "continue_yes" → F124 COMPLETE → score-=10000 → goSelect
  NO  → "continue_no"  → F85  COMPLETE → showGameOver（同实例）
showGameOver  → "gameover"  → F238 COMPLETE → GAME_OVER（4399 叠提交分钮）+ BACK → goLogo
```

[`Ctrler4399`](../../../engine/game/bvn/web/Ctrler4399.md) 听 `GAME_OVER`，把 `SubmitScoreBtn` `addChild` 到本 MC。

时间轴另有内嵌音：continue 段 F20 `StartSound` id16；gameover 段 F181 `StartSound` id33。引擎另外播 BGM `"continue"` / `snd_gameover`，两套叠在一起。

## 逐行说明

### 包与 Embed（L1–7）

无名包。`import MovieClip`、`Event`。[Embed] `source="/_assets/assets.swf", symbol="symbol39"`。`public dynamic class stg_gameover_mc extends MovieClip`。`dynamic` 让未声明的时间轴实例也能点。

### 字段（L10–18）

见上表。五个 `public var`，全是 `MovieClip`。无文本槽（分数是引擎往 `ct_score` 里 `addChild` 位图字）。

### 构造 `stg_gameover_mc()`（L20–24）

- L22: `super();`
- L23: `addFrameScript(49, this.frame50, 84, this.frame85, 123, this.frame124, 237, this.frame238);`
  - **addFrameScript 49 = F50**
  - **addFrameScript 84 = F85**
  - **addFrameScript 123 = F124**
  - **addFrameScript 237 = F238**

四段结构相同：停住 + 派 COMPLETE。没有 `play()` / `gotoAndStop`，跳转全是引擎标签。

### `"continue"` → `frame50`（L26–30）

- L28: `stop();` —— 续关入场锁在 F50。此时 `btn_yes` / `btn_no` 已在 F40 上场，`ct_char` 从 F5 就在。
- L29: `dispatchEvent(new Event(Event.COMPLETE));` → `showContinueComplete`。

### `"continue_no"` → `frame85`（L32–36）

- L34–35: 同结构。NO 拒绝动画结束 → `showGameOver()`，本实例继续播 `"gameover"`，不换 `Istage`。

### `"continue_yes"` → `frame124`（L38–42）

- L40–41: 同结构。YES 站起动画结束 → 扣 10000 分（下限 0）回选人。角色 `idle()` 在 **跳转时** 就调了，不在本帧。

### `"gameover"` → `frame238`（L44–48）

- L46–47: 同结构。GAME OVER 字/分亮完。F224 已放入 `btn_back`。之后 `initArrow("btn_back")`；页上只有 BACK，键盘左右会去找不存在的 yes/no（`setArrow` 找不到子对象只改字符串）。

无 `"destory"` 帧。`GameOverState.destory` **不** `gotoAndStop` 本 MC，只拆箭头监听、卸 `continueLoser`、`GameCtrl.destory()`。
