# `hits_mc` — 连击数字根 MC（屏幕固定位）

一句话目的：连击 HUD。`ct` 里塞 `MCNumber(hits_num_mc)`；时间轴标签 `fadin` / `update` / `fadout`。引擎 `gotoAndPlay`，**不**经 `FightUI.renderAnimate`。P1=`hits1` 会按数字宽度把整块往右推。

源文件：`decompiled/ui/fight/scripts/hits_mc.as`（45 行）

## 如何挂上引擎

本类是 [`ui_fight.hits1` / `hits2`](ui_fight.md)。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) `new HitsUI(ui.hits1/hits2)`。`showHits(n, team)` → `show(n)`；`hideHits(team)` → `hide()`。

[`HitsUI`](../../../engine/game/bvn/ui/fight/HitsUI.md)：

- `ResUtils.I.getItemClass(ResUtils.I.fight, "hits_num_mc")` → `new MCNumber(cls, 0, 1, 35)` 放进 **`ct`**。
- `gotoAndPlay("fadin"|"update"|"fadout")` 靠 Flash 时间轴自己跑。
- 只有 **`name=="hits1"`** 才 `_mc.x = _orgPos.x - _txtmc.x`；`hits2` 不动块，只把数字本身左移。
- **不**调 `GameState.getGameSpriteGlobalPosition`。连击是屏幕布局，不跟角色。

上游：`FighterEventCtrl.addHits` 在 `GameLogic.addHits` 返回 **>1** 才 `showHits`（第一击不弹）。`onHurtResume` / `onHurtDown` → `hideHits(uiID)`。`uiID` 是 team 1/2。

标签名（AS 里没有，在 SWF）：`"fadin"` / `"update"` / `"fadout"`。

## 时间轴

`addFrameScript N` = 时间轴 **F{N+1}**：

| 脚本下标 | 时间轴 | 函数 | 作用 |
|---|---|---|---|
| 0 | **F1** | `frame1` | `stop` + `visible=false`（idle / fadout 终点） |
| 9 | **F10** | `frame10` | `visible=true`（fadin 中途显） |
| 19 | **F20** | `frame20` | `stop`（fadin 完） |
| 37 | **F38** | `frame38` | `stop`（update 完） |
| 55 | **F56** | `frame56` | `gotoAndStop(1)`（fadout 完回隐） |

推断：`"fadin"` 在 F1 之后、F10 之前；`"update"` 在 F20 之后、F38 之前；`"fadout"` 在 F38 之后、F56 之前。具体帧 ?。

已显示再 `show` 走 `"update"` 弹一下，不重播 fadin。`hide` 不关 `_txtmc`，fadout 播完本脚本自己回 F1。

## 逐行说明

### 头 / Embed（L1–6）

无名包。`symbol="symbol30"`。`public dynamic class hits_mc extends MovieClip`。

### 公开实例（L9–11）

- **L9 `ct`**：`MovieClip`。`HitsUI` 把 `MCNumber` `addChild` 进来。`destory` try `ct.removeChild`。
- **L11 `hitsmc`**：`MovieClip`。「HITS」字样一类装饰。引擎**从不读写**。?

### 构造（L13–16）

`addFrameScript(0, frame1, 9, frame10, 19, frame20, 37, frame38, 55, frame56)`。

### `frame1`（L19–23）—— F1

`stop(); this.visible = false;`。默认隐藏。`fadout` 终点 `gotoAndStop(1)` 也落到这里，再隐一次。

### `frame10`（L25–28）—— F10

`this.visible = true;`。fadin 播到中途才露，避免第 1 帧闪数字。不 `stop`，继续播到 F20。

### `frame20`（L30–33）—— F20

`stop()`。fadin 完成，停在「已显示」姿势。等下次 `update` / `fadout`。

### `frame38`（L35–38）—— F38

`stop()`。update 跳动完成。数字还在，`_isShow` 仍 true。

### `frame56`（L40–43）—— F56

`gotoAndStop(1)`。fadout 走完，跳回 F1（再跑 `frame1`：`visible=false`）。不派 `COMPLETE`——引擎不听本 MC 事件，只靠 `_isShow` 旗。
