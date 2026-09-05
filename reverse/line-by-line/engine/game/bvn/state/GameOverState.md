# `GameOverState` — 续关 / 游戏结束

一句话目的：Arcade 失败后的 30fps 页。先 `showContinue`（YES 扣分回选人，NO 进 GAME OVER），或直接 `showGameOver` 亮分 + 回 Logo。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/GameOverState.as`（313 行）

## Callers / callees

- **Callers**：
  - `MainGame.goContinue`（L171–176）：`new` → **`showContinue()`** → `goStage` → FPS 30。来自 `GameCtrl.fightFinish`：Arcade 且 `lastWinnerTeam != 1`（P1 输），并先写 `gameRunData.continueLoser = p1.currentFighter`。
  - `MainGame.goGameOver`（L179–184）：`new` → **`showGameOver()`** → `goStage`。本包未见其它 `.as` 调 `goGameOver`；续关选 NO 在本类内部切到 `showGameOver`，不换 stage。
  - `Ctrler4399.gameHandler("GAME_OVER")`：把 `currentStage as GameOverState`，在 `display` 上叠 `SubmitScoreBtn`。
  - `KyoStageCtrl`：`build`/`afterBuild`/`destory`。注意构造里已经 `createDisplayObject`，`build` 为空。
- **Callees**：`StateCtrl.clearTrans`；`ResUtils`（`gameover` SWF / `stg_gameover_mc` / `select_arrow_mc`）；`SoundCtrl`（BGM `continue`、`snd_gameover`、确认/选择音）；`AssetManager.getSound`/`getFont`；`GameInputer`（MENU 左右/select）；`GameRender.add/remove(render)`；`GameLogic.loseScoreByContinue`；`MainGame.goSelect` / `goLogo`；`GameEvent("GAME_OVER")`；`GameCtrl.gameRunData.continueLoser` + `GameCtrl.destory`；`FighterMain`（**fighter，只作立绘**：scale/lose/idle/mc）；`setFrameOut`；`BitmapFontText`。

**不是** Winner 页，也不 `goMenu`。YES → 选人；GAME OVER 的 BACK → Logo。

## 命名备注

- `stg_gameover_mc` 时间轴标签：`continue` / `continue_yes` / `continue_no` / `gameover`。自定义事件 `"complete"` 驱动阶段切换（不是 Event.COMPLETE 常量，是时间轴 `dispatchEvent`）。
- `_keyInited` 声明了从未读写。
- `destory` / `initlize` 拼写保留。本类无 `initlize`。
- 续关代价在 `GameLogic.loseScoreByContinue`：**减 10000**，下限 0。**没有**「续关次数」计数；YES 后 `goSelect` 重选再战，不是原地复活。

## 两条入口

```
Arcade P1 败
  GameCtrl.fightFinish
    continueLoser = p1.currentFighter
    MainGame.goContinue
      new GameOverState()          // 清转场，停在帧 1
      showContinue()               // 播 continue + BGM + 把 loser 塞进 ct_char
      goStage → build()空 → afterBuild 派 "show_continue"
      GameState.destory            // 已 destory GameCtrl，但保留 continueLoser 与其 SWF

Arcade 直接结束 / 本类 NO 播完
  showGameOver()                 // 可在同一实例上从 continue_no 接过来
                                 // 或 goGameOver 新实例（无角色立绘）
```

## 逐行说明

### 字段（L27–39）

- `_ui:stg_gameover_mc`：gameover SWF 导出。
- `_arrow:select_arrow_mc`：公共 UI 箭头。
- `_arrowSelected`：当前 `"btn_yes"` / `"btn_no"` / `"btn_back"`。
- `_keyInited`：死字段。
- `_keyEnabled`：键盘/鼠标都看它；播 YES 动画时关掉。
- `_char`：续关失败者 `FighterMain`（从 `continueLoser` 挪来）。
- `_btns`：已 `initBtn` 的 Sprite，destory 时摘监听。

### 构造（L41–46）

`StateCtrl.I.clearTrans()`：进页前拆转场遮罩（其它 state 少这么做）。`ResUtils.I.createDisplayObject(ResUtils.I.gameover, ResUtils.GAME_OVER)` → `stg_gameover_mc`，`gotoAndStop(1)`。**先于** `showContinue`/`showGameOver`，所以 `goStage` addChild 时 UI 已在。

### `showContinue`（L49–55）公开

听 `"complete"` → `showContinueComplete`。`gotoAndPlay("continue")`。`addChar()`。BGM `AssetManager.getSound("continue")`。

`goContinue` 在 `goStage` **之前**调它，时间轴已开始播；`build` 空、`afterBuild` 只给网页派消息。

### `showContinueComplete`（L57–63）

时间轴 continue 段结束。摘监听。`initBtn("btn_yes")` + `initBtn("btn_no")`。`initArrow("btn_yes")` 默认选 YES，并挂 `GameRender` 键盘轮询。

### `initBtn`（L65–76）

`_ui.getChildByName(name)` 当 Sprite。没有则静默 return（时间轴子对象未到该帧时可能空）。`buttonMode=true`，`mouseOver`/`click` → `btnMouseHandler`，推进 `_btns`。

YES/NO 在 continue 完成帧才存在；BACK 在 gameover 完成帧才 `initBtn("btn_back")`。

### `btnMouseHandler`（L78–90）

hover：`setArrow(target.name)`（移动箭头+选中音）。click：记下 name，`selectHandler()`。

### `render`（L92–110）—— `GameRender` 30fps（随 `setFPS(30)`）

`_keyEnabled` 假则 return。`GameInputer.left/right/select("MENU", 1)`：左 YES、右 NO、确定 `selectHandler`。**没有上/下**。`1` 是刚按下边沿。

GAME OVER 只有 BACK 时，左右仍会 `setArrow("btn_yes"|"btn_no")`——子对象不存在则 `setArrow` 只改 `_arrowSelected` 不动画，可能把选中从 `btn_back` 改丢。随后 select 会 `switch` 落到空。边缘情况。

### `selectHandler`（L112–126）

| `_arrowSelected` | 行为 |
|------------------|------|
| `btn_yes` | `showContYes` |
| `btn_no` | `showContNo` |
| `btn_back` | `MainGame.I.goLogo()`（**不是** `goMenu`） |

任意分支都 `sndConfrim()`。YES/NO 自己关键；BACK 直接换 stage，本实例随后 `destory`。

### `initArrow`（L128–142）

无箭头则从 `common_ui` 建 `select_arrow_mc` 加到 `_ui`。可选 `setArrow`。`GameRender.add(render)`，`GameInputer.focus()`，`_keyEnabled=true`。

重复 `initArrow`（continue 一次、gameover 再一次）不会重复 addChild 箭头，但会再次 `GameRender.add`——`GameRender` 若不去重会双 tick。`?` 取决于 `GameRender.add` 实现。

### `removeArrow`（L144–158）

try 拆箭头，null，`_keyEnabled=false`。**不** `GameRender.remove`——YES 动画期间键盘停，但 render 仍注册直到 `destory`。`_keyEnabled` 把门。

### `setArrow`（L160–170）

写 `_arrowSelected`。找到子对象则对齐 `x/y` 并 `sndSelect`。找不到只改字符串。

### `addChar`（L172–203）—— 把失败者立绘塞进 `ct_char`

取 `_ui.getChildByName("ct_char")`。有：

```
char = GameCtrl.I.gameRunData.continueLoser
char.scale = 3; x=y=0
setVelocity(0,0); setVec2(0,0)
renderSelf(); lose()          // 失败者动作
ct_char.addChild(char.mc)
_char = char
```

`try/catch` + `trace`：角色 mc 可能已无 parent 或 `lose()` 状态机异常。

**无 `ct_char`**：`setFrameOut(addChar, 2, _loc2_)`。此时 `_loc2_` 是 **null**。`setFrameOut` 对 null mc 会 `new Sprite()` 听 ENTER_FRAME，2 帧后再调 `addChar`——等时间轴子对象出现。`goGameOver` 直达路径不调 `addChar`。

`GameState.destory` → `GameCtrl.destory` 对 P1 组 `destoryFighters(continueLoser)`：**跳过**这个 fighter，所以 mc 还活着。

### `showContYes`（L205–215）

听 complete → `showContYesComplete`。`gotoAndPlay("continue_yes")`。关键。`_char.idle()` 从失败姿势站起来。`removeArrow`。

### `showContYesComplete`（L217–222）

**`GameLogic.loseScoreByContinue()`**：`score -= 10000`，`<0` 则 0。然后 **`MainGame.I.goSelect()`** 回选人（30fps 选人台），不是 `loadGame` 也不是原地下一回合。

分数惩罚在动画播完才扣，中途退出 ? 不会扣（本路径只能等 complete）。

### `showContNo`（L224–229）

`continue_no` 动画，`removeArrow`。**不**立刻关 `_keyEnabled`（但箭头没了，`setArrow` 仍可能被 hover 调到——按钮监听还在）。complete → `showGameOver`。

### `showContNoComplete`（L231–235）

进 `showGameOver()`，同一实例，不换 `Istage`。

### `showGameOver`（L237–245）公开

听 `"complete"` → `gameOverComplete`。`gotoAndPlay("gameover")`。`SoundCtrl.playSwcSound(snd_gameover)`（主 SWF 嵌入音，不是 AssetManager）。`BGM(null)` 停续关 BGM。`addScore()`。

从 continue_no 过来时角色可能仍在 `ct_char`；时间轴切 gameover 后该槽或被换掉，`destory` 再拆 mc。

### `addScore`（L247–261）

找 `ct_score`。有：`BitmapFontText(font1)`，文案 `"SCORE " + GameData.I.score`，水平居中 `x = -width/2`。无：`setFrameOut(addScore, 1, _loc2_)` 同样 `_loc2_` 为 null，1 帧重试。

续关 YES 已扣分则这里不会跑（YES 直接 goSelect）。NO/直达 GAME OVER 显示当前分（未扣续关费）。

### `gameOverComplete`（L263–269）

`GameEvent.dispatchEvent("GAME_OVER")` → `Ctrler4399` 叠提交分数按钮。`initBtn("btn_back")` + `initArrow("btn_back")`。只有一个选项，键盘左右是空操作（见上）。

### `display`（L271–274）

返回 `_ui`，不是 `this`（本类不继承 DisplayObject）。

### `build`（L276–278）

空。资源在构造里已经 new。

### `afterBuild`（L280–283）

`MainGame.I.stage.dispatchEvent(DataEvent("5d_message", ..., JSON.stringify(["show_continue"])))`。网页壳监听。即使 `goGameOver` 直达也会派 `"show_continue"`——名字与实际页不完全一致。

### `destory`（L285–310）

1. `GameRender.remove(render)`。
2. `_btns` 摘 mouseOver/click，置 null。
3. `_char.mc.parent.removeChild`（try），`_char=null`。
4. **`continueLoser = null`**。
5. **`GameCtrl.I.destory()`**。此时 loser 已空，`destory` 会 `gameRunData.clear()` + `GameLoader.dispose()`（若上一轮 `GameState.destory` 因 loser 非空而跳过 dispose，这里补上）。

**不调用** `param1`。不 `gotoAndStop` UI。YES 去选人、BACK 去 Logo、以及任何换 stage，都走这里。
