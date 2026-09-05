# `SelectFighterStage` — 选人 / 选辅助 / 选地图状态机

一句话目的：`Istage` 选人场景。按 `_curStep` 走人物 →（VsCPU 再走一遍 P2）→ 辅助 →（Vs/训练选图，街机/生存直接灌关卡）→ `MainGame.loadGame`。格子来自 `select.xml`（`SelectStageConfigVO`）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/SelectFighterStage.as`（917 行）

## Callers / callees

- **Callers（进本舞台）**：`MainGame.goSelect`（L144–148）`stageCtrl.goStage(new SelectFighterStage())` + FPS=30。入口：
  - `MenuBtnGroup.getFucByLabel`：TEAM/SINGLE ACRADE、VS PEOPLE、VS CPU、SURVIVOR、TRAINING。
  - `HowToPlayState.uiComplete`（街机先教学再选人）。
  - `GameOverState.showContYesComplete`（continue 后再选）。
  - `GameCtrl` 对局结束：`isVsCPU() || isVsPeople()` 时 `goSelect`（再打一局）。
- **Callers（本类公开钩子，本 SWF 无写入方）**：
  - `AUTO_FINISH`：仅 `MainGame.resetDefault`（`goMenu`）置 `true`。本包从不置 `false`；LAN/插件可关，自己调 `nextStep` / `goLoadGame`。
  - `setSelect(player, ids)` / `p1SelectFinish` / `p2SelectFinish`：给远端灌选择、轮询是否选完。本包无调用。
- **Callees**：
  - UI：`SelectUIFactory.createSelecter`、`SelectFighterItem`、`SelecterItemUI`、`SelectedFighterGroup`、`MapSelectUI`、`GameUI.confrim/closeConfrim/showingDialog`。
  - 数据：`GameData.config.select_config`（`select.xml`）、`GameData.p1Select/p2Select`（`SelectVO`）、`FighterModel` / `AssisterModel`、`GameMode`、`GameLogic.canSelectFighter/canSelectAssist`、`MessionModel.initMession`。
  - 控制：`GameRender.add/remove(render)`、`GameInputer`、`SoundCtrl`（BGM `select`、`sndSelect`、`sndConfrim`）、`StateCtrl.clearTrans/transIn`、`AssetManager.getSound`、`ResUtils`（`stg_select`）、`KeyBoarder.focus`、`KyoRandom`、`TweenLite`/`Back.easeOut`。
  - 事件：`GameEvent` `"SELECT_FIGHTER_STEP"` / `"SELECT_FIGHTER_FINISH"`；舞台 `DataEvent("5d_message")` JSON `select_fighter` / `select_map` / `select_finish`。
  - 出口：`goLoadGame` → `StateCtrl.I.transIn(MainGame.I.loadGame)` → `LoadingState`。返回菜单：`GameUI.confrim` → `MainGame.I.goMenu`。

## 符号对照 / 命名备注

| 符号 | 含义 |
|---|---|
| `AUTO_FINISH` | 本地默认 true：双方/单方选完自动 `nextStep` / `goLoadGame`。false 时仍 dispatch 事件，但不推进、不进加载。 |
| `SELECT_STATE_FIGHTER/ASSIST/MAP` | `_selectState` 枚举。**MAP=2 从未赋值**，选图走独立 `_mapSelectUI`。 |
| `_curStep` | 整段向导 0…5，与 `_selectState` 不是同一套。 |
| `_p1Slt` / `_p2Slt` | 光标 `SelecterItemUI`。P1 出生格 `(0,0)`，P2 `(9,0)`（默认 10 列的最右）。 |
| `_p1SelectedGroup` / `_p2SelectedGroup` | **死字段**：声明并在 `clear` 里 destory，从未赋值。真正的底部已选条是 `SelecterItemUI.group`（`SelectUIFactory` 建）。 |
| `_itemObj` | 键 `"x,y"` → `SelectFighterItem`。空格 / 缺 VO 不进表。 |
| `_twoPlayerSelectFin` | VsPeople 双方都 `selectFinish` 后只让 `nextStep` 走一次。 |
| `_tweenTime = 500` | 列表弹出时长；`initSelecter` 延迟这么多 ms；格子 delay 随机 `0..(_tweenTime-300)/1000`。 |
| `sndConfrim` | `SoundCtrl` 拼写（confirm）。本文件全部沿用。 |
| `startAcradeGame` / `GameMode.isAcrade` | arcade 拼写。 |
| `destory` | 全工程 destroy 拼写。 |
| `selectTimesCount` | 小队人物 3、单人/辅助 1。 |
| `inputType` | `"P1"` / `"P2"`。VsCPU 的 P2 被改成 `"P1"`，同一套键先选己再选电脑。 |
| `isVsCPU(param1=true)` | mode 12/22，**以及 TRAINING(40)**（默认参数把练习当 VsCPU）。 |
| `GameLogic.canSelect*` | 只问 `select.xml` 的 `charList` / `assistList` 里有没有这个 `fighterID`，不是解锁表。 |
| `SELECT_FIGHTER_INDEX` | **本文件不发**。`SelectIndexUIGroup` 在加载/出战顺序 UI 里发。 |

`_curStep` 推进表：

| `_curStep` 进入时 | `nextStep` 做什么 | 之后 |
|---|---|---|
| 0 | `initFighter()` | 1 |
| 1 | VsCPU：卸 P1 光标、`initSelecterP2`、P2 用 P1 键；否则 `fadOutList(initAssist)` | 2 / 3 |
| 2 | （VsCPU P2 人物完）`fadOutList(initAssist)` | 3 |
| 3 | VsCPU：卸 P1 光标、`initSelecterP2` 选辅助；`isVsPeople`：`fadOutList(initMap)`；否则 `startAcradeGame()` | 4 / 5 / 结束 |
| 4 | （VsCPU P2 辅助完）`fadOutList(initMap)` | 5 |
| 5 | `selectFinish()` | — |

case 3 第二段 `if (isVsCPU() \|\| isVsPeople())` 里 `isVsCPU()` **不可达**（已被第一段吃掉）。实际只有 VsPeople 走选图；街机/生存走 `startAcradeGame`。

模式差异：

| 模式 | `p2Select` | 人物次数 | 流程 |
|---|---|---|---|
| TEAM/SINGLE VS PEOPLE (11/21) | 新建 | 3 / 1 | 双方同时选人物 → 同时选辅助 → 选图 |
| TEAM/SINGLE VS CPU (12/22)、TRAINING (40) | 新建 | 3 / 1 | P1 选完 → 同一套 P1 键替 P2 选 → 辅助同样两遍 → 选图 |
| TEAM/SINGLE ACRADE (10/20)、SURVIVOR (30) | 人物阶段不建；`initMession` 才灌 P2 | 3 / 1 | 只选 P1 人物+辅助，**不选图**，关卡/地图/P2/辅助来自 `mission.xml` |

## 逐行说明

### 包与 import（L1–37）

`net.play5d.game.bvn.state`。Tween 用 greensock；输入/资源/数据/选人 UI 如上。实现 `net.play5d.kyo.stage.Istage`（`display` / `build` / `afterBuild` / `destory`）。

### 静态 / 阶段常量（L42–48）

- `AUTO_FINISH = true`（L42）：见上。
- `SELECT_STATE_FIGHTER = 0`、`ASSIST = 1`、`MAP = 2`（L44–48）。后文只用 0/1。

### 实例字段（L50–73）

- `_selectState`：当前列表是人物还是辅助（决定 `FighterModel` vs `AssisterModel`、`isSelectAssist`、随机池）。
- `_ui:stg_select`：`select` SWF 导出类，整台显示根。
- `_config:SelectStageConfigVO`：`GameData.I.config.select_config`，`setByXML(select.xml)` 填 `x/y/width/height/top/bottom/left/right/unitSize` + `charList` / `assistList`。
- `_curListConfig:SelectCharListConfigVO`：当前 `HCount/VCount/list[]`。
- `_itemObj`：网格字典。
- `_p1Slt/_p2Slt`：光标。
- `_p1SelectedGroup/_p2SelectedGroup`：死字段。
- `_mapSelectUI`：选图层，仅 Vs/训练。
- `_curStep = 0`：`build` 里第一次 `nextStep` 从 0 起步。
- `_tweenTime = 500`。
- `_twoPlayerSelectFin`：VsPeople 防双次 `nextStep`。

### 空构造（L76–79）

无初始化。舞台由 `stageCtrl.goStage` 调 `build`。

### `display`（L81–84）

`Istage` 要求。返回 `_ui`。`build` 前为 null。

### `build`（L86–98）—— 舞台入口

1. `_ui = ResUtils.I.createDisplayObject(ResUtils.I.select, ResUtils.SELECT)`，`SELECT = "stg_select"`。
2. `_config = GameData.I.config.select_config`（启动时 `GameData.loadConfig` 已读 `assets/config/select.xml`；`GameLogic.setGameMode(1)` 会改灌 `salect.xml` 拼写路径）。
3. `GameRender.add(render)`：每帧跑光标/随机/返回。
4. `GameInputer.focus()` 后立刻 `enabled = false`：等列表 tween 完 `initSelecter` 再开。
5. **`nextStep()`**：`_curStep==0` → `initFighter()`，`_curStep=1`。
6. BGM：`AssetManager.I.getSound("select")`。
7. `StateCtrl.I.clearTrans()`：清转场遮罩。
8. `KeyBoarder.focus()`：保证键回到舞台。
9. 向外抛 `DataEvent("5d_message", …, JSON.stringify(["select_fighter"]))`（4399/页面对接，不是 `GameEvent`）。

### `initFighter`（L100–113）

`trace("初始化选人")`。`clear()` 卸上一阶段。`_selectState = 0`。`buildList(_config.charList)` 铺人物格。

`GameData.I.p1Select = new SelectVO()` **每次进人物阶段都新建**（continue / 再战时清空上次选择）。

仅 `isVsPeople() || isVsCPU()` 才 `p2Select = new SelectVO()`。街机/生存此处没有 P2，由 `MessionModel.initMession` 后写。

再关输入，`setTimeout(initSelecter, _tweenTime)`：500ms 后才出光标，避免 tween 中乱移。

### `initAssist`（L115–123）

对称：`_selectState = 1`，`buildList(_config.assistList)`。**不重建 SelectVO**（人物阶段的 `fighter1..3` 要保留；辅助写 `fuzhu`）。同样 delay `initSelecter`。

VsCPU 人物阶段若已 `initSelecterP2`，这里 `clear()` 会 destory `_p2Slt`，辅助阶段 `initSelecter` 再按模式重建。

### `fadOutList`（L125–146）

关输入。目标点：`GAME_SIZE/2 - 30`（与 `buildList` 弹出原点相同）。每个 `_itemObj` 项 0.2s tween 到中心 `scale=0`，`delay = random*0.1`。有 callback 则 `TweenLite.delayedCall(0.3, param1)`。**不等所有格子 delay 结束**，固定 0.3s 后进下一阶段（`initAssist` / `initMap`），与格子 0.2+0.1 大致对齐。

### `clear`（L148–186）

若有 `_itemObj`：对每项摘 `"mouseOver"` / `"click"` / `"touchTap"`（`SelectFighterItem` 未 override `removeEventListener`，真正摘听在 `destory` → `removeAllEventListener`），再 `destory()`。置 `_itemObj = null`。

依次 destory 并 null：`_p1Slt`、`_p2Slt`、`_mapSelectUI`、`_p1SelectedGroup`、`_p2SelectedGroup`。后两个恒 null。

`initFighter` / `initAssist` / `initMap` / 舞台 `destory` 都走这里。

### `buildList`（L188–234）

`param1` = `charList` 或 `assistList`。

原点：`_config.x + left`、`y + top`。列间距：`HCount>1` 时 `(width - unitSize.x - left - right) / (HCount-1)`，否则 0；行间距同样用 `height/unitSize.y/top/bottom/VCount`。格子铺满 `_config` 矩形，单元默认 `unitSize=(50,50)`。

`_curListConfig = param1`，`_itemObj = {}`。弹出原点同样是屏心 -30。

遍历 `param1.list`（`SelectCharListItemVO`，XML 里按行/列生成，`x=列, y=行`）：

1. `addFighterItem`；失败（空 id / 无 VO）则跳过，网格出现空洞，光标靠 `moveSlt` 跳过。
2. 目标坐标 = 原点 + 间距 * `(selectData.x, y)`；若 `offset`（XML `@offset`）再加。
3. 先 `scale=0` 放在屏心，delay `random * (_tweenTime-300)/1000`（0～0.2s），0.3s `Back.easeOut` 弹到格子。

### `addFighterItem`（L236–261）

无 `fighterID` → null（XML 空格）。

VO：`_selectState==1` 用 `AssisterModel.I.getAssister(id)`，否则 `FighterModel.I.getFighter(id)`。找不到：`Debugger.log("SelectFighterStage.addFighterItem :: 未找到角色数据：" + id)`，return null。格子仍占 XML 坐标，只是不显示。

`new SelectFighterItem(vo, itemVO)`：脸图 `AssetManager.getFighterFace`。`TOUCH_MODE`（`GameConfig` 默认 false）只听 `touchTap`；否则 `mouseOver` + `click`。`SelectFighterItem.addEventListener` 把 UI 事件转成 `(type:String, item)`，所以后面 handler 不是 `MouseEvent`。

`_ui.addChild(item.ui)`。字典键 `x + "," + y`。

### `selectFighterMouseHandler`（L263–277）

无 item / 无 `selectData` return。`mouseOver` → `doHover`；`click` → `doSelect`。

### `selectFighterTouchHandler`（L279–306）

触摸没有 hover：先找当前 **enabled** 的光标，**P1 优先**，P1 不可用才 P2。都没有 return。

若光标已在该格 `isHoverFighter` → `doSelect`，否则 `doHover`（第一次点移动，第二次点确认）。

VsPeople 双开时鼠标/触摸始终先喂 P1，P2 只能键选（或等 P1 选完）。

### `doHover`（L308–330）

只动 **当前 enabled** 的那一个光标：P1 优先。若该格 id 已被该玩家 `isSelected`（小队已选过的人）则忽略，避免 hover 到锁定格。否则 `moveToSelectFighter` + `sndSelect()`。P1 处理完 **return**，不会同时移 P2。

### `doSelect`（L332–354）

同样 P1 优先。已选过的 id 直接 return（小队不能重复点同一人）。否则 `_p*Slt.select(playerSeltBack)` + `sndConfrim()`。

真正写入 `SelectVO` 的是 `SelecterItemUI.select`：辅助 → `fuzhu`；人物按 `selectTimes` 0/1/2 写 `fighter1/2/3`。`currentFighter.id` 在随机格上是闪到的那个，不是 `"random"`。播 `"select"` 帧，未满次数则短暂 `enabled=false` 后由帧脚本再打开并回调。

### `getFighterItem`（L356–363）

`_itemObj[x + "," + y]`。无表或空洞 → null。

### `initSelecter`（L365–378）

开输入。VsPeople：`initSelecterP1` + `initSelecterP2`，`_twoPlayerSelectFin = false`。否则只 P1（街机 / VsCPU 第一段 / 生存）。VsCPU 的 P2 光标由 `nextStep` case 1/3 稍后 `initSelecterP2`。

### `initSelecterP1`（L380–388）

`SelectUIFactory.createSelecter(1)`：`inputType="P1"`，`selectVO=GameData.p1Select`，底部 `selected_item_p1_mc` 组，x=10，y=`GAME_SIZE.y-80`。

`isSelectAssist = (_selectState==1)`。`selectTimesCount`：小队且不是辅助 → 3，否则 1。

`addChild` 光标 `ui` 和 `group`。`moveSlt(_p1Slt, 0, 0)` 落到左上第一个有效未选格。

### `initSelecterP2`（L390–398）

对称 player=2，`selected_item_p2_mc`，组 x=`GAME_SIZE.x-265`。出生 `moveSlt(_p2Slt, 9, 0)` —— 写死列 9，依赖 `select.xml` `HCount>=10`。列更少则 `getFighterItem(9,0)` 空，`moveSlt` 向右搜索会 wrap。

VsCPU 随后把 `inputType` 改成 `"P1"`。

### `moveSlt`（L400–518）—— 光标寻格

参数：光标、目标列 `param2`、目标行 `param3`、`param4=true` 表示空格/已选则继续搜。本文件全部默认 true，无 false 调用。

取 `_loc7_ = getFighterItem(x,y)`。若无格 **或** 该格已被本光标选过：

- `param4==false`：return true（当成功，不移动）。
- 否则按相对方向搜：

**向右**（`param2 > param1.x`）：`_loc10_`。从目标列起向右扫最多 `HCount` 格，**行不变**（`param1.y`），列 `> HCount-1` 则减 `HCount` wrap。找到未选中的格就 break。

**向左**（`param2 < param1.x`）：`_loc6_`。向左扫，`<0` 则 `HCount + col` wrap。

**向下**（`param3 > param1.y`）：`_loc8_`。行 `> VCount-1` 先置 0。从该行起到底，每行 `getHLineFighter(param1.x, row)`（同行附近找一个存在的格）。

**向上**（`param3 < param1.y`）：`_loc12_`。行 `<0` 置 `VCount-1`。从该行起到 0 同样 `getHLineFighter`。

水平搜的是「未选中」格；垂直搜只要求格存在（`getHLineFighter` 不看 `isSelected`）。

搜完仍无 `_loc7_` → return false（例如整行空）。

把光标 `x/y` 写成命中格的 `selectData.x/y`。若 **仍然** `isSelected`（垂直路径可能落到已选格）：

- 若本次是垂直（`_loc12_ || _loc8_`）：先递归 `moveSlt(x+1, y)`（无第 4 参，继续搜）。失败则按原方向再 `y-1` 或 `y+1`（**返回值丢弃**）。
- 无论递归成败，`return true`。

未选中：`moveToSelectFighter`，return true。

边界：键一直按到空区会 wrap；小队已选格被跳过。起点 `(0,0)` / `(9,0)` 若空/已选也会走进这套搜索。

### `isHoverFighter`（L520–523）

光标格坐标 == item 的 `selectData.x/y`。触摸二次确认用。

### `moveToSelectFighter`（L525–536）

`randoms = null`（离开随机格停止闪）。同步光标 `x/y`，`moveTo(ui.x, ui.y)` 对齐格子显示坐标（含 offset）。`currentFighter = fighterData`。有 `group` 则 `updateFighter` 刷新底部当前预览。最后 `checkRandom`：若该格是随机，会重新填 `randoms` 并立刻闪一帧。

### `checkRandom`（L538–566）

`currentFighter.id.indexOf("random") != -1`（`random`、`random_bleach` 这类都算）。

- `_selectState==0`：`FighterModel.I.getFighters(comicType, filter)`。filter：id 不含 `"random"`，且 `GameLogic.canSelectFighter(id)`（在 `charList` 里），且 `!slt.selectVO.isSelected(id)`（小队不重复）。
- `==1`：`AssisterModel.I.getAssisters(comicType, filter)`：不含 random，且 `canSelectAssist`。辅助不查 `isSelected`（只选 1 个）。
- 其它 state：return false。

命中则 `randFrame=0`，立刻 `renderRandom`，return true。`comicType` 跟随机格自己的 VO（XML 里随机项也有 `comic_type`），所以闪的是同一漫画侧。

`canSelect*` 不是成就锁，只是「这 id 是否出现在当前 select 表」。`setGameMode` 换 `salect.xml` 会改变可随机集合。

### `getHLineFighter`（L568–603）

在固定行 `param2` 上，从列 `param1` 做 0、+1、−1、+2、−2… 扫描。列需在 `[0, HCount)`。找到第一个存在的 `SelectFighterItem` 就返回。`_loc5_` 绝对值超过 `HCount` 返回 null。

**不跳过已选格**，所以 `moveSlt` 垂直命中后还要二次 `isSelected` 处理。

### `renderRandom`（L605–621）

有 `randoms` 才跑。`randFrame>0` 则清 0 并 return —— **每两帧换一次**。否则 `randFrame++`，`currentFighter = KyoRandom.getRandomInArray(randoms, false)`（`false` = 不从数组摘除，可重复闪到同一人）。刷新 `group`。确认时用的就是当前这个 `currentFighter`。`SelecterItemUI.select` 之后 `updateRandom` 会按已写入的 fighter1/2/3 从池里 `splice` 掉，避免小队随机三次抽到同一人。

### `render`（L623–720）—— 每帧

1. **返回**：`GameInputer.back(1)`（MENU 的 back，边沿 1）。有对话框则 `GameUI.closeConfrim()`；否则 `GameUI.confrim("BACK TITLE?","返回到主菜单？", MainGame.I.goMenu)`。拼写 `confrim`。
2. 对话框还在则 **整帧 return**（光标/选图都不动）。
3. **P1 光标 enabled**：先 `renderRandom`。方向键 `up/down/left/right(_p1Slt.inputType, 1)` → `moveSlt` 相邻格 + `sndSelect`。`select` 键 → `_p1Slt.select(playerSeltBack)` + `sndConfrim`。此处 **不像 doSelect 那样预检 isSelected**：已选格上按确认仍进 `SelecterItemUI.select`，会把同一 id 再写入下一个 fighter 槽。? 键选重复是否被 UI 挡住取决于格子是否还能被 `moveSlt` 停住（已选格会被跳过，所以正常键选停不到已选格；随机闪到已选 id 仍可能确认重复）。
4. **P2** 同样。VsPeople 双光标同时听各自 `inputType`。
5. **选图** `_mapSelectUI.enabled`：左右 `prev/next` + `sndSelect`；确认 `_mapSelectUI.select(onMapSelect)` + `sndConfrim`。`inputType` 在 `initMap` tween 完后设为 `"P1"`。无上下键。

`GameInputer.*(type, 1)` 的 `1` 是「刚按下」边沿，不是按住连发。

### `p1SelectFinish` / `p2SelectFinish`（L722–730）

`_p*Slt && _p*Slt.selectFinish()`。`selectFinish` = `selectTimes >= selectTimesCount`。给外部（联机）轮询。光标被 `destory` 后 `_p1Slt` 仍可能非 null 直到 `clear`。

### `setSelect`（L732–738）

`param1==1` 用 P1 否则 P2。`setCurrentSelect(param2)`：辅助则 `fuzhu=arr[0]`；人物写 fighter1/2/3 并 `group.addFighter` 后两个。`selectTimes = count`，`enabled=false`。然后 `removeSelecter()` 摘光标 MC（**保留 group**），`sndConfrim`。

**不**调 `playerSeltBack`，**不** `nextStep`，**不**发 `SELECT_FIGHTER_STEP`。设计给 `AUTO_FINISH=false` 时由外部灌选择再自己推进。本 SWF 无调用方。

### `playerSeltBack`（L740–771）

`SelecterItemUI.select` 动画帧结束回调，参数是该光标。

**已 `selectFinish()`**（次数用尽）：

- **VsPeople**：`GameEvent.dispatchEvent("SELECT_FIGHTER_STEP", getCurrentSelectes())`。人物阶段 payload 为 `[fighter1,fighter2,fighter3]`（单人后两项可能 undefined）；辅助为 `[fuzhu]`。取对方光标：对方也 finish 且尚未 `_twoPlayerSelectFin` → 置 true。`AUTO_FINISH==false` 则 **return**（仍会落到下面 `param1.destory()`）。否则 `nextStep()`。
- **非 VsPeople**（街机 / VsCPU / 训练 / 生存）：不发 STEP，直接 `nextStep()`。

然后 **`param1.destory()`**：关 enabled、摘光标 UI、**摘 group**。注意顺序是 **先 `nextStep` 再 destory**。

VsCPU case 1/3 里 `nextStep` 已 `removeSelecter` + `enabled=false` 并 `initSelecterP2`；回来后 `destory` 还会 `removeGroup`，P1 底部已选条在切到「替 CPU 选」时被拆掉。? 看起来像副作用，不是单独的 hide-cursor。

**未选完**（小队 3 人还剩次数）：若 **没有** `randoms`（不在随机格），把光标横移一格：`_loc3_ = param1 == _p1Slt == 1 ? 1 : -1`。AS3 `==` 左结合：`(param1 == _p1Slt) == 1`，`true==1` 为真，故 P1 向右 +1，P2 向左 −1。`moveSlt(..., true)` 会跳过已选。在随机格则不挪，继续闪下一人。

### `nextStep`（L773–823）—— 向导

`switch(_curStep)`，无 default。

**case 0**（`build` 第一次）：`initFighter()`，`_curStep=1`。

**case 1**（P1 人物次数用尽，或 VsPeople 双方人物都尽）：

- `isVsCPU()`（含 TRAINING）：`_p1Slt.removeSelecter()`；`enabled=false`；`initSelecterP2()`；`_p2Slt.inputType="P1"`；`_curStep=2`。P2 人物仍用 P1 键。break。
- 否则（VsPeople / 街机 / 生存）：`fadOutList(initAssist)`，`_curStep=3`。

**case 2**（VsCPU P2 人物尽）：`fadOutList(initAssist)`，`_curStep=3`。

**case 3**（辅助阶段，P1 尽；VsPeople 则双方尽）：

- `isVsCPU()`：同 case 1，再建 P2 光标选辅助，`inputType="P1"`，`_curStep=4`。break。
- `isVsCPU() || isVsPeople()`：前半死。VsPeople → `fadOutList(initMap)`，`_curStep=5`。
- else：`startAcradeGame()`。`_curStep` **不变**（仍 3）。街机不再进 case 5。

**case 4**（VsCPU P2 辅助尽）：先 `_curStep=5` 再 `fadOutList(initMap)`。选完图 `onMapSelect`→`nextStep` 进 case 5。

**case 5**：`selectFinish()`。

VsPeople 人物尽时 case 1 直接去辅助，**不会**给 P2 单独阶段（双光标一开始就都在）。VsCPU 是串行。

### `initMap`（L825–858）

`trace("选择地图")`。`5d_message` `["select_map"]`。`clear()` 卸人物/辅助格和光标。关输入。

`new MapSelectUI()`（内部 `build`：所有 `MapModel` 图含 random，默认 show 0）。记下原 x/y，缩到 0 放到屏心，0.3s `Back.easeOut` 弹回。`onComplete`：若 UI 还在，`addMouseEvents(mapPrevHandler, mapNextHandler, mapConfrimHandler)`，`inputType="P1"`，`enabled=true`，再开 `GameInputer`。

键控与鼠标都会进 `prev/next/select`。鼠标在 `MapSelectUI.mouseHandler` 里自己再播一次 `sndSelect/sndConfrim`，键盘路径在本类 `render` 播 —— 鼠标确认可能叠两声。?

### `mapPrevHandler` / `mapNextHandler` / `mapConfrimHandler`（L860–873）

转给 `_mapSelectUI.prev/next/select(onMapSelect)`。`mapConfrimHandler` 沿用 Confrim 拼写。`select` 若当前是 `id=="random"` 会循环 `KyoRandom.getRandomInArray` 直到不是 random，写入 `GameData.I.selectMap`。

### `onMapSelect`（L875–878）

`nextStep()` → 此时 `_curStep==5` → `selectFinish`。

### `startAcradeGame`（L880–884）

`MessionModel.I.initMession()`：按 P1 `fighter1` 的 `comicType` + 小队?0:1 取 `mission.xml` 的 `MessionVO`，当前 `_curStageId`（continue 后可能不是 0，菜单 `reset()` 才清）。灌 `p2Select.fighter*`、`fuzhu`、`selectMap`，`AI_LEVEL = config.AI_level`。然后 `selectFinish()`（不经过 case 5）。

### `selectFinish`（L886–895）

`GameEvent.dispatchEvent("SELECT_FIGHTER_FINISH")`（无 param）。`AUTO_FINISH==false` 则 return —— **不** `goLoadGame`，也 **不** 发 `select_finish` 的 `5d_message`。

否则 `goLoadGame()`，再 `5d_message` `["select_finish"]`。顺序：先切加载（transIn 回调），再发消息。

### `goLoadGame`（L897–901）

`trace("开始游戏")`。`StateCtrl.I.transIn(MainGame.I.loadGame)`：转场淡入后 `loadGame()` 建 `LoadingState`，`goStage(..., true)`。公开，外部在 `AUTO_FINISH=false` 时也可直接调。

### `afterBuild`（L903–905）

空。`Istage` 占位。

### `destory`（L907–914）

`clear()`；`GameRender.remove(render)`；关输入；`BGM(null)` 停选人曲；`GameUI.closeConfrim()` 以免确认框留到下一舞台。

**忽略 `param1:Function`**。若 `stageCtrl` 靠 destory 回调再挂下一舞台，这里不会调 —— 本工程其它 state 多数同样不调，转场走 `StateCtrl.transIn` 自己的 callback。

## 锁、音效、随机、联机钩子（收束）

- **锁**：无独立解锁表。空 XML 格与缺失 VO 不进 `_itemObj`；已写入本方 `SelectVO` 的 id 键/鼠都会跳过；随机池用 `canSelectFighter/Assist` 再滤一层「是否出现在当前 select 表」。
- **音效**：移光标 / 选图左右 = `sndSelect`（`snd_menu1`）；确认人物/辅助/图 = `sndConfrim`（`snd_menu2`）。BGM 资源名 `"select"`。
- **随机格**：id 含 `"random"` 即闪；确认落地为闪到的真实 id。地图 random 在 `MapSelectUI.select` 里重抽。
- **SELECT_FIGHTER_***：本文件只发 `STEP`（VsPeople 每次一方次数用尽）和 `FINISH`（整段结束）。`INDEX` 别处。
- **CPU 不是 AI 自选**：VsCPU/训练是玩家用 P1 键把 P2 选完。真正的电脑阵容只出现在街机 `initMession`。
