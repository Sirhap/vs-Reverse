# `HitsUI` — 连击数字（屏幕固定位）

一句话目的：包 `hits_mc`。用 `MCNumber(hits_num_mc)` 显示连击数，走 SWF 标签 `fadin` / `update` / `fadout`。P1=`hits1` 会按数字宽度把整块往右推，避免多位数盖住左边。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/HitsUI.as`（76 行）

## Callers / callees

- **Callers**：只 `FightUI`。构造 `new HitsUI(ui.hits1/hits2)`；`showHits(n, team)` → `show(n)`；`hideHits(team)` → `hide()`；`destory`。
- **上游**：`FighterEventCtrl.addHits` 在 `GameLogic.addHits` 返回 **>1** 才 `showHits`（第一击不弹）。`onHurtResume` / `onHurtDown` → `hideHits(uiID)`。`uiID` 是 team 1/2，不是 fighter 实例 id。
- **Callees**：`ResUtils.I.getItemClass(ResUtils.I.fight, "hits_num_mc")`；`net.play5d.kyo.display.MCNumber`。

## 不是世界坐标

`hits_mc` 是 `ui_fight` 上的屏幕布局。本类 **不**调 `GameState.getGameSpriteGlobalPosition`。那条 API 给 `FightUI.getPlayerPos` 的 `player_pos_p1/p2` 用。部分总览把「hits 数字跟角色」写在本类上，与源码不符。

`hits_mc` 帧脚本（`decompiled/ui/fight/scripts/hits_mc.as`）：

| 帧 | 脚本 |
|---|---|
| 1 | `stop(); visible=false` |
| 10 | `visible=true`（fadin 中途显） |
| 20 | `stop`（fadin 完） |
| 38 | `stop`（update 完） |
| 56 | `gotoAndStop(1)`（fadout 完回隐） |

`gotoAndPlay("fadin"|"update"|"fadout")` 靠 Flash 时间轴自己跑，**不**经 `FightUI.renderAnimate`。

## 命名备注

- `destory`：try 从 `ct` 摘 `_txtmc`，null 引用。不 `stop` MC。
- `_orgPos`：构造时 `hits_mc` 的 x/y。只有 **实例名 `"hits1"`** 才按数字宽度改 `_mc.x`；`hits2` 不动块，只把数字本身左移。
- `MCNumber(cls, 0, 1, 35)`：初始 0、数字从 MC 帧 `startFrame+digit`（帧 1=0？帧 1+0=1 是 0 的字形）、每格宽 35、`bits=0` 不补零。位数变长时 `width` 变。
- `_txtmc.x = -width + 45`：数字右对齐到一个 45px 锚点。
- `hits1`：`_mc.x = _orgPos.x - _txtmc.x`。因为 `_txtmc.x` 是负数（`-width+45`），整块往右移 `width-45`，多位数向右长。
- 已显示再 `show` 走 `"update"` 弹一下，不重播 fadin。
- `hide` 不关 `_txtmc`，fadout 播完 SWF 自己 `gotoAndStop(1)` 藏。

## 逐行说明

### 字段 / 构造（L9–26）

`_mc`=`hits_mc`（带 `ct`、`hitsmc`）。取 `hits_num_mc` Class，`new MCNumber(..., 0, 1, 35)` 放进 `_mc.ct`。记下 `_orgPos`。此时数字是 0 但 MC 帧 1 `visible=false`。

### `destory`（L28–46）

有 `_txtmc` 则 try `ct.removeChild`。null `_txtmc`/`_mc`/`_orgPos`。`FightUI.destory` 稍后 `ui.removeChildren()` 会把 `hits_mc` 也摘掉。

### `show`（L48–64）

1. `_txtmc.number = param1`：重建每位数字 MC（`MCNumber` setter 先 remove 旧的）。
2. `_txtmc.x = -width + 45`。
3. **仅** `_mc.name=="hits1"`：`_mc.x = _orgPos.x - _txtmc.x`。`hits2` 的 name 是 `"hits2"`，不进。
4. 已 `_isShow`：`gotoAndPlay("update")` return（连击 +1 的跳动）。
5. 否则 `_isShow=true`，`gotoAndPlay("fadin")`。

`param1` 类型 `int`，`MCNumber.number` 是 `uint`，负数会绕成大正数。正常 hits≥2。

### `hide`（L66–74）

未显示 return。`_isShow=false`，`gotoAndPlay("fadout")`。连击中途再 `show` 可以打断 fadout 重 fadin（`_isShow` 已 false）。SWF 若正在 fadout 被 fadin 切开，时间轴从 fadin 标签重来。
