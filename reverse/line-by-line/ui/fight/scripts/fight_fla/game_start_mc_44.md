# `fight_fla.game_start_mc_44` — ROUND / FIGHT / KO / TIMEOVER / DRAW / WINNER

一句话目的：战斗开场与终场大字。`ui_fight.startKOmc` 的运行时类型。引擎 `gotoAndStop` 标签后靠 `renderStartAndKO` **`nextFrame()`** 往前爬（不是 `play()`）。子件 `nummc` 播回合数，`winnermc` 播胜者条（perfect 分叉）。

源文件：`decompiled/ui/fight/scripts/fight_fla/game_start_mc_44.as`（147 行）

## 如何挂上引擎

[`ui_fight.startKOmc`](../ui_fight.md) 声明成 `MovieClip`，SWF 挂的就是本类。[`FightUI`](../../../../engine/game/bvn/ui/fight/FightUI.md) **不** `createDisplayObject("game_start_mc_44")`，随 `ui_fight` 一起出来。

引擎写入的动态字段（本类 `public var`，动态类）：

| 字段 | 谁写 | 默认（F1） | 用途 |
|---|---|---|---|
| `$round` | `showStart`：`gameRunData.round` | 1 | F27 钳 1..5 后 `nummc.gotoAndPlay("r"+$round)` |
| `$perfect` | `showWinner`：`winner.hp >= winner.hpMax` | false | F200/F201 抄到 `winnermc.isPerfect` |
| `$winnerX` | `showWinner`：team 1→30，team 2→546 | 30 | F200/F201 `winnermc.x` |
| `$winnerY` | **引擎不写** | 90 | F200/F201 `winnermc.y`。一直用 F1 默认 |

`startKOmc` 自身 y：`showStart` → -50；`playKO2` / `playTimeOver` → 0；`showWinner` → 30。

`clearStartAndEnd`：`gotoAndStop(1)`（回到 F1，复位上面四个字段并 `stop`）。

## 驱动方式：`nextFrame()` 不是 `play()`

[`FightUI.renderStartAndKO`](../../../../engine/game/bvn/ui/fight/FightUI.md)（`renderAnimate` 每 30fps 语义调一次）：

1. `currentFrameLabel == "stop"` → **return**（不再 `nextFrame`）。
2. 标签含 `"go:"` → `gotoAndStop(split("go:")[1])` 后 return（SWF 内部跳转约定，AS 无此字符串）。
3. 否则 `_loc2_.nextFrame()`。

因此：

- 开场/KO 段的推进速度跟 `GameUI` 的 30fps 抽帧对齐，**不是** SWF 文档帧率自己 `play()`。
- 帧脚本里的 `stop()` 挡的是原生 `play()`；**挡不住** 引擎的 `nextFrame()`。真正卡住爬行的是时间轴标签 **`"stop"`**（AS 看不见，应打在 F88 / F190 / F210 / F263 / F309 一带）。缺这个标签的话 COMPLETE 之后还会走进下一段。?
- 子件 [`round_num_mc_45`](round_num_mc_45.md) / [`元件25_46`](元件25_46.md) 是 `gotoAndPlay` / 默认 play，走 Flash 自己的帧。

BITMAP / 血条淡入与本 MC 无关。本片始终在 `ui_fight` 上。

## 引擎 `gotoAndStop` 标签 ↔ 本类脚本

对照 [`FightUI.md` 开场 / KO 时间线](../../../../engine/game/bvn/ui/fight/FightUI.md)。标签名在 SWF，AS 只钉脚本帧。

| 代码 `gotoAndStop` | 条件 | 本类脚本帧 | 派发 | 谁听 |
|---|---|---|---|---|
| `"start"` | `round < 5` | 经 F27 → F55 → F58 → **F88** | `"fight_in"`（F55）、`"fight"`（F58）、`COMPLETE`（F88） | `"fight"`：`onFight` **空体**只卸监听。`COMPLETE`：`GameStartCtrl` 清 `_uiPlaying` |
| `"start_final"` | `round ≥ 5` | F28 再播 `nummc`（FINAL 入口？），其后与 start 共用 F55/F58/F88 | 同上 | 同上 |
| `"ko"` | 非超时 KO（`playKO2`，hit 后 500ms） | 爬到 **F190** | `COMPLETE`（F190） | `koBack`：`freezeEnabled=true`、`resume()`、`_playOver=true` |
| `"winner"` | 胜者条（`showWinner`） | F200/F201 定位 + `isPerfect`；**F210** `stop` | 本 MC 不在 F210 派 COMPLETE；听 `winnermc` COMPLETE 再冒泡 | `renderEnd` **不**传 back。有 back 才 `winnerBack` |
| `"timeover"` | `isTimerOver` | 爬到 **F263** | `COMPLETE`（F263） | `timeoverBack`：平局 → `playDrawGame`；否则 `_playOver` + delay 1s |
| `"drawgame"` | 超时且 `_drawGame` | 爬到 **F309** | `COMPLETE`（F309） | `drawGameBack` → `finishBack` |
| 帧 1 | `clearStartAndEnd` | **F1** `stop` + 复位字段 | 无 | — |

`"fight_in"`（F55）：**FightUI 不听**。可能给 SWF 内部音效/图层，或没接线的旧回调。?

## 时间轴总表（addFrameScript → F）

`addFrameScript N` = 时间轴 **F{N+1}**。本类 12 条脚本：

| 脚本下标 | 时间轴 | 函数 | 分组 | 行为 |
|---|---|---|---|---|
| 0 | **F1** | `frame1` | idle | `$round=1` `$perfect=false` `$winnerX=30` `$winnerY=90`；`stop` |
| 26 | **F27** | `frame27` | start | `$round` 钳 1..5；`nummc.gotoAndPlay("r"+$round)` |
| 27 | **F28** | `frame28` | start / start_final ? | 再 `nummc.gotoAndPlay("r"+$round)`（无钳制） |
| 54 | **F55** | `frame55` | start 共用 | `dispatch("fight_in")` |
| 57 | **F58** | `frame58` | start 共用 | `dispatch("fight")` |
| 87 | **F88** | `frame88` | start 结束 | `stop` + `Event.COMPLETE` |
| 189 | **F190** | `frame190` | ko 结束 | `stop` + `COMPLETE` |
| 199 | **F200** | `frame200` | winner | `winnermc` 的 x/y/`isPerfect` |
| 200 | **F201** | `frame201` | winner | 同上（再写一次） |
| 209 | **F210** | `frame210` | winner 结束 | `stop`；听 `winnermc` COMPLETE → 冒泡 `COMPLETE` |
| 262 | **F263** | `frame263` | timeover 结束 | `stop` + `COMPLETE` |
| 308 | **F309** | `frame309` | drawgame 结束 | `stop` + `COMPLETE` |

标签起点帧号不在 AS。按脚本位置推断段序：idle(F1) → start/start_final(…F88) → ko(…F190) → winner(F200–F210) → timeover(…F263) → drawgame(…F309)。中间美术帧无脚本，靠 `nextFrame()` 爬过。

## 按标签分组

### idle / `clearStartAndEnd`（F1）

`gotoAndStop(1)` 进这里。四个 `$` 字段复位。`stop()`。若 F1 也打了标签 `"stop"`，`renderStartAndKO` 不会从 idle 自己爬进 ROUND。?

### `"start"`（round < 5）

`showStart`：`fadIn()` HUD，`$round=round`，`gotoAndStop("start")`。然后每动画帧 `nextFrame()`：

1. **F27**：把 `$round` 钳在 `[1,5]`。有 `nummc` 则 `gotoAndPlay("r"+$round)` → [`round_num_mc_45`](round_num_mc_45.md) 自己播数字。
2. **F28**：再播一次 `nummc`（无钳制）。start 路径若经过 F28，数字会 `gotoAndPlay` 两次——从标签重来，视觉上像重入场。?
3. **F55**：派 `"fight_in"`。FightUI 不听。
4. **F58**：派 `"fight"`。`showStart.onFight` 只 `removeEventListener`，**不**开操作。真正能动手靠 F88 `COMPLETE` → `GameStartCtrl`。
5. **F88**：`stop` + `COMPLETE`。应配标签 `"stop"` 卡住 `nextFrame`。

`nummc` 空则 F27/F28 跳过（`if(Boolean(this.nummc))`）。正常 SWF 有。

### `"start_final"`（round ≥ 5）

同一套 fight_in / fight / COMPLETE。第 5 回合（BO3 少见；生存/组队回合能到 5+）走 FINAL 美术。

F28 紧挨 F27，候选：

- `"start_final"` 标签落在 F28：FINAL 跳过 F27 的钳制，直接播 `r`+$round。`$round` 若 >5，`"r6"` 可能缺标签。?
- 或两条路径都经过 F27+F28，F28 只是再播一次。?

AS 无法区分，标 ?。F55/F58/F88 两段共用最稳。

### `"ko"`（F190）

`playKO`：顿帧、特写败者、500ms 墙钟后 `playKO2`：`y=0`，`gotoAndStop("ko")`，听 `"complete"`，`snd_ko` / `snd_ko_bs`，气条 `fadOut()`。

本类从 `"ko"` 爬到 **F190**：`stop` + `COMPLETE` → `koBack`。F89–F189 无脚本（KO 大字动画）。

### `"winner"`（F200 / F201 / F210）

`showWinner` 先写 `$winnerX` / `$perfect` 再 `gotoAndStop("winner")`。`$winnerY` 保持 90。

- **F200 / F201**：有 `winnermc` 则 `x=$winnerX`、`y=$winnerY`、`isPerfect=$perfect`。写两帧：可能 `"winner"` 落在 F200，下一帧再保险一次；也防 [`元件25_46`](元件25_46.md) F1 把 `isPerfect` 拨回 false。?
- **F210**：`stop()`。给 `winnermc` 加 `COMPLETE` 监听（弱引用），回调里 `dispatchEvent(COMPLETE)` 冒泡。本帧**自己不派** COMPLETE。`winnermc` 是 [`元件25_46`](元件25_46.md)：普通胜者 F29 完，perfect 拖到 F56。

`winnermc` 空则 F200/F201 跳过；F210 仍 `this.winnermc.addEventListener`——空引用会 NPE。正常 SWF 有。?

team 非 1/2：不写 `$winnerX`，沿用 30（F1 默认 / 上一场残留）。`showWinner` 无 winner/team 当 1。

### `"timeover"`（F263）

`playTimeOver`：**不** `pause()`、**不**关 freeze。`y=0`，`gotoAndStop("timeover")`，气条 fadOut。爬到 **F263** `stop`+`COMPLETE` → `timeoverBack`。

### `"drawgame"`（F309）

仅超时平局：`timeoverBack` 里 `playDrawGame` → `gotoAndStop("drawgame")`。爬到 **F309** `stop`+`COMPLETE` → `drawGameBack` → `finishBack`。不进胜者条，不置 `_playOver`。

## 事件一览

| 事件 | 帧 | 监听方 | 备注 |
|---|---|---|---|
| `"fight_in"` | F55 | **无人**（FightUI 不听） | |
| `"fight"` | F58 | `showStart.onFight` | 空体，只卸监听 |
| `Event.COMPLETE` | F88 | `showStart.startComplete` | 开场结束 |
| `Event.COMPLETE` | F190 | `koBack` | KO 大字结束 |
| `Event.COMPLETE` | F210 冒泡 | `showWinner.winnerBack`（可选） | 源是 `winnermc`，不是本帧脚本直接 dispatch |
| `Event.COMPLETE` | F263 | `timeoverBack` | |
| `Event.COMPLETE` | F309 | `drawGameBack` | |

事件名大小写：帧脚本 `new Event("fight")` / `"fight_in"`；COMPLETE 用 `Event.COMPLETE`（`"complete"`）。`QiBar` 听的 `"complete"` 是气条自己的，与本 MC 无关。

## 子件

| 实例 | 运行时类 | 引擎如何用 |
|---|---|---|
| `nummc` | [`round_num_mc_45`](round_num_mc_45.md) ? | F27/F28 `gotoAndPlay("r1".."r5")` |
| `winnermc` | [`元件25_46`](元件25_46.md) | F200/F201 定位 + `isPerfect`；F210 转 COMPLETE |

## 逐行说明

### 头 / Embed（L1–29）

`package fight_fla`。L3–27 是 Flash 时间轴脚本常见的 `adobe.utils.*` / `flash.*` 通配 import，本文件实际只用 `MovieClip` 和 `Event`。`symbol="symbol194"`（[`ui_fight`](../ui_fight.md) 是 symbol195，本 MC 就嵌在根上）。

`public dynamic class game_start_mc_44 extends MovieClip`：动态类，引擎才能在类型声明为 `MovieClip` 的 `startKOmc` 上写 `$round` 等。

### 字段（L32–41）

- **L32 `nummc`**：`MovieClip`。回合数字。见上。
- **L34 `winnermc`**：`MovieClip`。胜者条。见 [`元件25_46`](元件25_46.md)。
- **L36 `$round:int`**
- **L38 `$perfect:Boolean`**
- **L40 `$winnerX:Number`**
- **L41 `$winnerY:Number`**

`$` 前缀是时间轴脚本习惯，给引擎当「参数槽」。

### 构造（L43–47）

`addFrameScript(0, frame1, 26, frame27, 27, frame28, 54, frame55, 57, frame58, 87, frame88, 189, frame190, 199, frame200, 200, frame201, 209, frame210, 262, frame263, 308, frame309)`。

十二个下标 ↔ 上表。无其它函数。

### `frame1`（L49–57）—— F1

```
$round = 1;
$perfect = false;
$winnerX = 30;
$winnerY = 90;
stop();
```

每次落到 F1（含 `clearStartAndEnd`）都复位。`$winnerY=90` 是胜者条的**唯一**写入点。

### `frame27`（L59–73）—— F27（start）

```
if($round < 1) $round = 1;
if($round > 5) $round = 5;
if(Boolean(nummc)) nummc.gotoAndPlay("r" + $round);
```

钳制后播数字。`Boolean(nummc)` 防缺实例。`r`+$round 与 [`round_num_mc_45`](round_num_mc_45.md) 的 r1..r5 对齐。

### `frame28`（L75–81）—— F28（start_final ?）

只 `nummc.gotoAndPlay("r"+$round)`，**不再钳**。若 FINAL 从本帧进且 `$round>5`，标签可能 miss。?

### `frame55`（L83–86）—— F55

`dispatchEvent(new Event("fight_in"));`。不 `stop`。FightUI 不听。

### `frame58`（L88–91）—— F58

`dispatchEvent(new Event("fight"));`。不 `stop`。再爬 30 帧到 F88（FIGHT 大字收尾）。

### `frame88`（L93–97）—— F88（start 完）

`stop(); dispatchEvent(new Event(Event.COMPLETE));`

### `frame190`（L99–103）—— F190（ko 完）

同样 `stop` + `COMPLETE`。

### `frame200`（L105–113）—— F200（winner）

```
if(Boolean(winnermc)) {
  winnermc.x = $winnerX;
  winnermc.y = $winnerY;
  winnermc.isPerfect = $perfect;
}
```

不 `stop`。`isPerfect` 给 [`元件25_46`](元件25_46.md) F29 分叉。

### `frame201`（L115–123）—— F201

与 F200 **逐字相同**。连续两帧都写，防 `gotoAndStop("winner")` 落点差一帧、或子件 F1 把旗清掉。

### `frame210`（L125–132）—— F210（winner 等子件）

```
stop();
winnermc.addEventListener(Event.COMPLETE, function(e:Event):void {
  dispatchEvent(new Event(Event.COMPLETE));
}, false, 0, true);
```

匿名函数、弱引用（最后参 `true`）。每进 F210 加一次监听；`clearStartAndEnd` **不卸**。正常路径 `showWinner` 的 `winnerBack` 会卸本 MC 上的 COMPLETE，但 **winnermc 上这条匿名监听还在**。再打一场 winner 会再加一条。弱引用在本 MC 被摘掉时能收，同一实例复用可能叠监听、一次 COMPLETE 冒泡多次。? `GameEndCtrl` 终场 `clearStartAndEnd` 后整场 `destory` 拆 `ui_fight`，实战叠听窗口短。

`winnermc` 若 null，本帧 NPE。?

### `frame263`（L134–138）—— F263（timeover 完）

`stop` + `COMPLETE`。

### `frame309`（L140–144）—— F309（drawgame 完）

`stop` + `COMPLETE`。时间轴终点（至少到 F309）。

## 与 `FightUI` cinema 时序

详见 [`FightUI.md` KO / 超时 cinema](../../../../engine/game/bvn/ui/fight/FightUI.md)。本 MC 只负责大字：

```
showStart → "start"|"start_final" → F58 "fight"（空）→ F88 COMPLETE → 可操作
playKO → 500ms → "ko" → F190 COMPLETE → koBack
playTimeOver → "timeover" → F263 COMPLETE
                 ├─ draw → "drawgame" → F309 COMPLETE → cb
                 └─ 有胜者 → delay → showWinner "winner" → F210 等 winnermc
clearStartAndEnd → F1
```

`renderEnd` 在 delay 归零时**立刻** `finishBack()`，此时 winner 段可能刚 `gotoAndStop("winner")`，F210 / PERFECT 还在播。
