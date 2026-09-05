# `SelecterItemUI` — 选人光标（Selecter，不是 Selector）

一句话目的：格子上的 P1/P2 光标。记录当前格 `(x,y)`、`currentFighter`、已选次数，真正把 id 写入 `SelectVO`（人物 `fighter1/2/3`，辅助 `fuzhu`）。底部已选条是 `group`（`SelectUIFactory` 建），不是 `SelectFighterStage` 那对死字段。VsCPU 的 P2 光标 `inputType` 事后改成 `"P1"`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelecterItemUI.as`（225 行）

## Callers / callees

- **创建**：只 `SelectUIFactory.createSelecter(player)`。舞台 `initSelecterP1` 出生 `(0,0)`，`initSelecterP2` `(9,0)`。
- **移动**：`SelectFighterStage.moveSlt` / `moveToSelectFighter` 写 `x/y`、`moveTo(ui.x, ui.y)`、`currentFighter`；随机格填 `randoms` / `randFrame`。
- **确认**：舞台 `doSelect` / `render` 调 `select(playerSeltBack)`；鼠标已选过的 id 会预先 `isSelected` return，键确认不预检（已选格 `moveSlt` 会跳过，随机闪到已选 id 仍可能再写一次）。
- **联机**：`setSelect` → `setCurrentSelect` 后 `removeSelecter`（留 group）+ `sndConfrim`。不调 `playerSeltBack`。
- **结束**：`playerSeltBack` 在次数用尽时先 `nextStep` 再 `destory()`（光标 + group 都摘）。VsCPU `nextStep` 已 `removeSelecter` + `enabled=false` + `initSelecterP2`，回来 `destory` 仍 `removeGroup`，P1 底条被拆。
- **轮询**：`p1SelectFinish` / `p2SelectFinish` → `selectFinish()`。
- **Callees**：`SelectVO`、`FighterModel.getFighter`、`AssisterModel.getAssister`、`SelectedFighterGroup`、`ResUtils` `"select_item_mc"`、`KyoUtils.addFrameScript`（选中动画最后一帧回调）。

## 命名备注

| 符号 | 含义 |
|---|---|
| `Selecter` | 类名、工厂方法、舞台 `_p1Slt` 都是这个拼写。 |
| `destory` | destroy。 |
| `fuzhu` | 辅助 id。 |
| `selectTimes` / `selectTimesCount` | 已选次数 / 需要次数。小队人物 3，单人与辅助 1。 |
| `inputType` | `"P1"` / `"P2"`。工厂按 player 写；VsCPU P2 改 `"P1"`。 |
| `isSelectAssist` | 舞台 `_selectState==1`。决定写 `fuzhu` 还是 fighter*。 |
| `randoms` / `randFrame` | 随机格池。舞台 `checkRandom` / `renderRandom` 写；本类 `select` 后 `updateRandom` 从池里 splice 已写入的 fighter1/2/3。 |
| `enabled` | 默认 true。选中动画期间 false；未满次数则帧脚本再打开。舞台 `render` / `doHover` 只动 enabled 的光标。 |
| `_playerType` | 构造参数 1/2，只用来停 `ui.mc` 帧。之后不读。 |

SWF：`select_item_mc`（`select` SWF）。

| 子件 / 帧 | 含义 |
|---|---|
| `mc` | P1 `gotoAndStop(1)`，P2 `stop(2)`（颜色/箭头方向）。 |
| 时间轴帧 1 | 导出类 `frame1` = `stop()`。 |
| 帧标签 `"select"` | `select()` `gotoAndPlay("select")` 播选中动画。`KyoUtils.addFrameScript(ui, cb)` 默认挂 **最后一帧**（`totalFrames-1`）。 |

`ui.mouseChildren = ui.mouseEnabled = false`：光标不挡格子点击。

## 逐行说明

### 包与 import（L1–8）

不是 DisplayObject。显示是 `ui`。`KyoUtils` 只为 `addFrameScript`。

### 字段（L13–39）

- `ui:select_item_mc`。
- `currentFighter`：当前格 VO。随机格上是 **闪到的那一个**，不是 `"random"` 自己。`select()` 写的是 `.id`。
- `selectTimes` 默认 0（int）。
- `selectTimesCount=1`，舞台可改 3。
- `inputType` / `group` / `selectVO` / `isSelectAssist`。
- `x` / `y`：网格列行，不是像素。`moveTo` 才改 `ui.x/y`。
- `enabled=true`。
- `randoms:Vector.<FighterVO>` 默认 null。离开随机格时舞台置 null。
- `randFrame`：舞台每两帧切一次闪。
- `_playerType`。

### 构造（L41–50）

`(param1=1)` 存 `_playerType`。`createDisplayObject(..., "select_item_mc")`。`mouseChildren=false`、`mouseEnabled=false`（用 `_temp_3` 是反编译对连续赋值的写法）。`ui.mc.gotoAndStop(param1==1 ? 1 : 2)`。

不在这里建 `group` / `selectVO` —— 工厂随后赋值。

### `selectFinish`（L52–55）

`selectTimes >= selectTimesCount`。小队选满 3 人或单人/辅助 1 次后 true。`playerSeltBack` / 舞台 `p*SelectFinish` 用。

### `getCurrentSelectes`（L57–64）

辅助：`[selectVO.fuzhu]`。否则 `[fighter1, fighter2, fighter3]`（未填的槽是 undefined）。`SelectFighterStage.playerSeltBack` 在 VsPeople 次数用尽时当 `SELECT_FIGHTER_STEP` payload。

无 `selectVO` 会 NPE。正常工厂已灌。

### `setCurrentSelect`（L66–84）—— 外部灌选择

辅助：`fuzhu = param1[0]`，`group.updateFighter(AssisterModel.getAssister(fuzhu))`（第一张空槽改脸）。

人物：写 fighter1/2/3，`updateFighter(fighter1)` 填当前槽，再 `addFighter(fighter2)`、`addFighter(fighter3)` 叠上去。工厂已有一张空卡，结果 3 张。id 无效则 `getFighter` 空，`setFighter` return，卡空白。

最后 `selectTimes = selectTimesCount`、`enabled=false`。不播 `"select"` 动画、不 `addFrameScript`、不 callback。舞台 `setSelect` 再 `removeSelecter`。

### `isSelected`（L86–97）

无 `selectVO` → false。辅助：`fuzhu == param1`。人物：三槽任一相等。

舞台 `doHover` / `doSelect` / `moveSlt` 用它跳过本玩家已选 id。`SelectVO.isSelected` 不含 `fuzhu`；本方法辅助分支自己比。小队不能重复点同一人；辅助只选 1 个，比一次即锁。

### `select`（L99–145）—— 写入 SelectVO

`param1` 动画结束回调（舞台 `playerSeltBack`）。无 `selectVO` → `throw "未设置selectVO!"`。

**写 id**（`currentFighter.id`，随机格已是闪中的真实 id）：

- `isSelectAssist`：`fuzhu = id`（不看 `selectTimes`）。
- 否则 `switch(selectTimes)`：0→fighter1，1→fighter2，2→fighter3。其它次数（重复确认）什么都不写，但仍 `selectTimes++`。

然后 `selectTimes++`。若 **尚未** `selectFinish()`：`group.addFighter(currentFighter)`（为下一 slot 叠新卡；当前 hover 仍由之后的 `updateFighter` 改）。满员（第 3 人或 count=1）不加，当前预览槽就是最后一人。

`enabled=false`。`ui.gotoAndPlay("select")`。`updateRandom()` 从池里摘掉已写入的三槽。

`KyoUtils.addFrameScript(ui, fn)`：`param3` 默认 -1 → 挂 `totalFrames-1`。`addFrameScript` **替换** 该帧脚本，多次 select 不会叠。动画播到尾：

- 未满次数 → `enabled=true`（允许接着选）。
- 有 `back` → `back(_this)`。闭包抓构造时的 `this`（`_this = this`），避免帧脚本 `this` 指向 MC。

满次数时 enabled 保持 false，仍调 `back`。`playerSeltBack` 据此 `nextStep` + `destory`。

`currentFighter` 空会在 `.id` NPE。舞台只在格子有效时调。

### `moveTo`（L147–151）

像素对齐格子 `ui`。`moveToSelectFighter` 传入 `item.ui.x/y`（含 XML `offset`）。不改本对象 `x/y` 网格坐标（那两行舞台另外写）。

### `destory`（L153–158）

`enabled=false`；`removeSelecter()`；`removeGroup()`。动画帧脚本若稍后触发：`ui` 已 null，但闭包不碰 `ui`；`back(_this)` 仍可能跑。正常 `playerSeltBack` 先被帧脚本调用，再在里面 `destory`，不会二次。VsCPU `nextStep` 先 `removeSelecter`（`ui=null`）再 `playerSeltBack` 才 `destory`：若动画还没到最后一帧，`gotoAndPlay` 的 MC 已摘，帧脚本可能不跑；但 `nextStep` 不依赖这次 callback 推进（已经推进了）。回来的 `destory` 只再 `removeGroup`。

### `removeSelecter`（L160–173）

`ui && ui.parent` 则 `try removeChild(ui)`，`ui=null`。无 parent 不 null。VsCPU 只调这个，group 还在。

### `removeGroup`（L175–188）

同样 `try removeChild(group)`，`group=null`。`SelectedFighterGroup.destory` **不**在这里调 —— 只摘显示列表。组内 Tween / `_uis` 靠 GC。

### `updateRandom`（L190–203）

`randoms` 或 `selectVO` 空则 return。对 `fighter1/2/3` 做 `&& removeRand`（空串/undefined 跳过）。**不**摘 `fuzhu`（辅助随机只选一次，满员后光标 destory）。

小队三次随机：每次确认后把刚写入的 id 从 `randoms` splice 掉，`renderRandom` 不会再闪到已选。`KyoRandom.getRandomInArray(..., false)` 本身不摘除，靠这里。

### `removeRand`（L205–222）

线性扫 `randoms[i].id == param1`，命中 `splice` 一个。没有则不动。`randoms` 是 Vector，`splice` 合法。
