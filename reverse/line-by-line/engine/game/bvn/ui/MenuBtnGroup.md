# `MenuBtnGroup` — 主菜单按钮组（树、键盘、触摸、错开淡入）

一句话目的：主菜单的可操作列表。`build()` 读 `GameInterface.instance.getGameMenu()`，空则 `GameInterface.getDefaultMenu()`。顶层钮竖排错开，有 `children` 的项点开后插入子钮。键盘走 `GameInputer` `"MENU"`，鼠标/触摸走 `MenuBtn` 包装事件。选中后按 `func` 或 `getFucByLabel` 写 `GameMode.currentMode` 并切状态。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/MenuBtnGroup.as`（524 行）

## Callers / callees

- **Callers**：仅 `MenuState.showBtns`（L104–118）：`new MenuBtnGroup()`，`enabled=false`，坐标 **(470, 100)**，优先挂到 `stg_title` 子级 `"btnct"`，否则 `_ui.addChild`。然后 `build()` + `fadIn(0.2, 0.04)`，400ms 后 `enabled=true`。`MenuState.destory` 先 `parent.removeChild` 再 `destory()`。
- **Callees**：`MenuBtn`；`GameInterface.instance.getGameMenu` / `GameInterface.getDefaultMenu`；`GameMode.currentMode`；`MessionModel.I.reset`；`MainGame.I.goHowToPlay` / `goSelect` / `goOption` / `goCredits` / `moreGames`；`GameConfig.TOUCH_MODE` / `SHOW_HOW_TO_PLAY` / `GAME_SIZE`；`GameRender.add/remove(render)`（**无 owner**，进 `"anyone"` 桶）；`GameInputer.up/down/select("MENU",1)` / `back(1)`；`GameUI.showingDialog()`；`TweenLite` + `Back.easeOut`。
- **本包无子类**。`mouseHandler` / `touchHandler` / `selectBtn` 标了 `protected`，decompiled 下无 `extends MenuBtnGroup`。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `fadIn` | fade 少 e |
| `destory` | destroy 的原拼写 |
| `getFucByLabel` | Func 少 n |
| `toogleChildren` | toggle 的原拼写 |
| `_showIngChildrenBtn` | Showing 的 Ing |
| `ACRADE` | Arcade。菜单 `txt` 与 `GameMode.TEAM_ACRADE` 同错 |
| `enabled` | 键盘总闸。`selectBtn` 期间 false；`MenuState` 错开淡入 400ms 内也 false |
| `_xadd = -40` | 下一钮相对左移，形成楼梯 |
| `_yadd = 5` | 钮间额外缝 |

菜单数据字段：`{txt, cn, children?, func?}`。`txt` → `MenuBtn.label`（`getFucByLabel` 键）；`cn` → 屏幕字；`func` 有则选中直接调，否则查表。

### 默认菜单树（`getDefaultMenu`）

| 顶层 `txt` / `cn` | 子项 `txt` | `currentMode` | 出口 |
|-------------------|------------|---------------|------|
| TEAM PLAY / 小队模式 | TEAM ACRADE / 闯关模式 | 10 | `MessionModel.reset`；`SHOW_HOW_TO_PLAY` → `goHowToPlay` 否则 `goSelect` |
| | TEAM VS PEOPLE / 2P对战 | 11 | `goSelect` |
| | TEAM VS CPU / 对战电脑 | 12 | `goSelect` |
| SINGLE PLAY / 单人模式 | SINGLE ACRADE / 闯关模式 | 20 | 同 TEAM ACRADE |
| | SINGLE VS PEOPLE / 2P对战 | 21 | `goSelect` |
| | SINGLE VS CPU / 对战电脑 | 22 | `goSelect` |
| OPTION / 游戏设置 | — | — | `goOption` |
| TRAINING / 练习模式 | — | 40 | `goSelect` |
| CREDITS / 制作组 | — | — | `goCredits` |
| MORE GAMES / 更多游戏 | — | — | `moreGames` |

`GameInterfaceManager.getGameMenu` 在下标 4（CREDITS 前）插入 `{txt:"RANK", cn:"排行榜", func:Ctrler4399.showRank}`。RANK **不**进 `getFucByLabel`，靠 `func`。无 `SURVIVOR` 项；`getFucByLabel` 仍有 `"SURVIVOR"` → mode 30 的死分支，本包菜单树点不到。?

`SHOW_HOW_TO_PLAY` 默认 true，街机先教学再选人。VS / TRAINING / SURVIVOR 不进 HowToPlay。

## 逐行说明

### 字段（L19–33）

- `enabled = true`：`render` / `mouseHandler` 开头闸。`touchHandler` **不读**。
- `_btnConfig`：菜单 Object 数组。
- `_xadd = -40` / `_yadd = 5`：楼梯偏移。`protected`，无子类改。
- `_btnIndex`：当前悬停下标。焦点在子菜单时是 **子数组** 下标，不是顶层。
- `_startPoint`：`build` 时的 `(x,y)`，给 `moveScroll` 当原点。
- `_btnHeight`：第一枚顶层钮的 `height`（75，除非日后改默认）。
- `_btns:Array`：只含顶层 `MenuBtn`。子钮只活在父 `.children` 里。
- `_showIngChildrenBtn`：正在展开的父钮；`null` = 没展开。

### 构造（L36–44）

`super()`。`GameConfig.TOUCH_MODE`（默认 false）则 `scaleX = scaleY = 1.3`（反编译 `_temp_2`）。触摸模式后面 `build` 还 `y += 50`。

### `destory`（L47–57）

1. `GameRender.remove(render)`（无 owner，与 `add` 配对，从 `"anyone"` 删）。
2. 遍历 `_btns`：`removeEventListener("touchTap"/"click"/"mouseOver", …)`。本类 **没覆盖** `MenuBtn.removeEventListener`，这三行走 `EventDispatcher` 空表，**卸不掉 `ui` 上的 `selfHandler`**。真正清理指望 `dispose` → `removeAllEventListener`，那边也卸错对象（见 `MenuBtn.md`）。
3. `_loc1_.dispose()`：递归 `children`。
4. `_btns = null`。不 `removeChild` 子 `ui`（调用方先把 Group 从父级拿掉）。

### `fadIn`（L60–74）

`param1` 时长默认 0.5，`param2` 错开默认 0.05。`MenuState` 传 `(0.2, 0.04)`。

只动 **顶层** `_btns`（不含已展开的子钮）：每钮 `ui.scaleX = 0.01`，`TweenLite` 到 1，`delay = index * param2`，`Back.easeOut`。Y 方向不缩放。`MenuState` 在 400ms 后才 `enabled=true`，避免弹出过程中误选。

### `build`（L77–102）

1. `_startPoint = new Point(x, y)`。此时已是 (470, 100)。**先于** 触摸 `y += 50`，所以触摸模式下 `_startPoint.y` 比实际 `y` 小 50，影响后面 `moveScroll`。本包 `TOUCH_MODE` 默认 false。
2. `_btnConfig = GameInterface.instance.getGameMenu()`。本包 GIM 返回默认树 + RANK，不会 null。
3. 若仍 falsy，回落 `GameInterface.getDefaultMenu()`（无 RANK）。
4. 逐项 `addMenuBtn(_loc1_)`（顶层，`param2=false`）。
5. `setBtns(true, false)`：立刻摆坐标并 `addChild(ui)`，不 tween。
6. 非触摸：`hoverBtn(_btns[0])`（第一项 TEAM PLAY 高亮 + `sndSelect`）。触摸不预高亮。
7. 触摸：`this.y += 50`。
8. `GameRender.add(render)` 无 owner。

### `addMenuBtn`（L105–144）

`param1` 菜单 Object，`param2=true` 表示这是子钮、不要推进 `_btns`。

1. `new MenuBtn(txt, cn, func)`。
2. `TOUCH_MODE` 听 `"touchTap"` → `touchHandler`，否则 `"click"` + `"mouseOver"` → `mouseHandler`。走 `MenuBtn.addEventListener` 包装，实际签名 `(String, MenuBtn)`。
3. 若不是子钮：`index = _btns.length`，push；第一次记 `_btnHeight`。
4. 若 `param1.children` 有值：`parent.children = []`，对每个子配置 **递归** `addMenuBtn(child, true)`，`childMode()`，`index = 子下标`。子钮此刻 **不上屏**，等 `toogleChildren`。
5. 返回刚建的钮（递归用）。

子钮也登记了 click/touch。`destory` 只遍历 `_btns`，子钮的 listener 靠父 `dispose` 递归。

### `mouseHandler`（L147–160）

`enabled` 假则 return。`"mouseOver"` → `hoverBtn`；`"click"` → `selectBtn`。没有 `"mouseOut"`：移走不会 `normal`，要等另一钮 hover。

### `touchHandler`（L163–178）

**不检查 `enabled`。** `MenuState` 前 400ms / `selectBtn` 动画期间键盘被挡，触摸仍能点。?

1. 有 `children`：`hoverBtn` + `selectBtn` 一次完成（`selectBtn` 见 children 就 `toogleChildren`）。等于单击展开，不必二次确认。
2. 无 children：若还没 hover（`!isHover()`，看 `bg.visible`）只 `hoverBtn`；已经 hover 才 `selectBtn`。第一次点高亮，第二次才进游戏。

展开中再点同一父钮：`selectBtn` → `toogleChildren` 发现已打开则关上。

### `moveScroll`（L181–197）

菜单过长时把 Group 往上推，让当前项留在屏内。

1. 无 `_startPoint` 或 `_btns.length < 7` 则 return。默认树 6 项不滚；GIM 插入 RANK 后 7 项才滚。
2. 底边 `GAME_SIZE.y - 10`。若 `_startPoint.y + this.height` 还没越过底边，return（含展开子项后变高的情况：`this.height` 含已 addChild 的子 `ui`）。
3. `可见高 = 底边 - _startPoint.y`；`每项份额 = 可见高 / _btns.length`（按顶层数量，不含子项）。
4. `itemH = _btnHeight + _yadd`（80）。
5. 目标 `y = _btnIndex * (份额 - itemH) + _startPoint.y`。`份额 < itemH` 时系数为负，index 越大 Group 越往上。
6. `TweenLite.to(this, 0.2, {y})`。

`_btnIndex` 在子菜单里是子下标，却拿去乘顶层公式，展开后滚动会偏。? 本包 7 项刚过阈值，展开 TEAM 的 3 个子项后总高度才明显超屏。

### `hoverBtn`（L200–238）

两段：先扫顶层 `_btns`，再若有展开父则扫它的 `children`。

顶层循环：命中则 `hover()` + `_btnIndex = 顶层下标` + `moveScroll()`；否则 `normal()`。命中的是子钮时，顶层没有任何 `== param1`，于是 **全部顶层 `normal()`**——但展开父 `_isOpen`，`normal()` 直接 return，父钮外观保持帧 2。

子项循环：命中则 `hover()` 且 **`_btnIndex` 改写成子下标**（覆盖刚写的顶层值）；否则 `normal()`。

鼠标滑过顶层其它项（子菜单仍开着）时：该顶层 `hover()`，子项全 `normal()`，`_btnIndex` 变成顶层下标。不自动 `closeChildren`。键盘 `render` 此时仍把焦点数组当成 `children`（见下），下标可能越界或指错项。?

### `selectBtn`（L241–271）

`protected`。键盘 / 鼠标 / 触摸汇合点。

1. `target.children` 为真（空数组也真，但本包要么 null 要么有元素）→ `toogleChildren(target)` 并 return。**不**播 `select` 动画，**不**关 `enabled`。
2. 有 `target.func` 用它，否则 `getFucByLabel(target.label)`。RANK 走 func；默认叶项走查表。未知 label 则 `func` 保持 `undefined`，稍后 `!= null` 失败，等于空操作但仍播动画。
3. 闭包 `callFunc`：若 `func != null` 则调；然后 `this.mouseChildren = this.mouseEnabled = true`（反编译 `_temp_1`），`enabled = true`。AS3 嵌套函数的 `this` 仍是本实例。
4. `enabled = false`（挡键盘）。**没有**先把 `mouseEnabled/mouseChildren` 置 false，`callFunc` 却设回 true，像是对称代码缺了前半。触摸 `touchHandler` 又不看 `enabled`，动画期间仍能点。?
5. `target.select(callFunc)`：1s 弹性淡入 + `sndConfrim`，完成才切状态。

`goSelect` / `goOption` 会 `goStage` 换掉 `MenuState`，其 `destory` 卸 Group。tween `onComplete` 若在 destory 之后才到，`callFunc` 仍跑（`func` 已执行完？不，func 在 callFunc 里，destory 不杀 TweenLite）。正常路径是 tween 完才 `goStage`，Group 还在。若中途强切，残留 tween 可能对已 destory 的对象写 `enabled`。?

### `getFucByLabel`（L274–371）

`switch(label)` 返回闭包。每个分支都是 `function():void { … }`，在选中动画结束后才执行。

| case | 副作用 |
|------|--------|
| `"TEAM ACRADE"` | `currentMode = 10`；`MessionModel.I.reset()`；`SHOW_HOW_TO_PLAY` ? `goHowToPlay` : `goSelect` |
| `"TEAM VS PEOPLE"` | 11；`goSelect` |
| `"TEAM VS CPU"` | 12；`goSelect` |
| `"SINGLE ACRADE"` | 20；同 TEAM ACRADE 的 reset + HowToPlay/Select |
| `"SINGLE VS PEOPLE"` | 21；`goSelect` |
| `"SINGLE VS CPU"` | 22；`goSelect` |
| `"SURVIVOR"` | 30；`reset()`；`goSelect`。本包菜单无此项 |
| `"OPTION"` | `goOption`（`SettingState`） |
| `"TRAINING"` | 40；`goSelect` |
| `"CREDITS"` | `goCredits` |
| `"MORE GAMES"` | `moreGames` → GIM → 4399 游戏列表 + `5d_message` |

无 `"RANK"`、无 `"TEAM PLAY"` / `"SINGLE PLAY"`（这两项有 children，到不了这里）。`reset()` 清 `_curStageId` / 当前关，并把 `GameData.I.score = 0`。VS / TRAINING / OPTION / CREDITS / MORE GAMES 不 reset。

写的是字面量 `10`/`20` 等，不引用 `GameMode.TEAM_ACRADE` 常量。

### `toogleChildren`（L374–393）

1. 若已有展开父：
   - `_loc2_ = (点的就是当前展开父)`。
   - 若点的是 **另一个** 父：先把旧父 `normal()`（旧父 `_isOpen`，`normal` 无效，靠下一步 `closeChild` 复位）。
   - `closeChildren(_loc2_, _loc2_)`：点自己则关完再 `setBtns(true, true)` 动画收拢；点别人则 `closeChildren(false, false)` **不**立刻重排，只把旧子 `ui` 从显示列表拿掉。
   - 点自己：return（完成折叠）。
2. `_showIngChildrenBtn = param1`。
3. `setBtns(true, true)`：顶层 tween 到新坐标，把子钮 addChild，子钮 `scaleX` 从 0.01 错开弹出。
4. `param1.openChild()`：父钮切帧 2。
5. `hoverBtn(param1.children[0])`：默认高亮第一个子项。`children` 空则 NRE；本包不会。

### `closeChildren`（L396–419）

`param1` = 关完后是否 `setBtns`；`param2` 传给 `setBtns` 的 tween 开关。

1. 遍历 `_showIngChildrenBtn.children`，`try removeChild(ui)`（可能已经不在显示列表）。
2. `closeChild()` 复位父钮。
3. `_showIngChildrenBtn = null`。
4. `param1` 真则 `setBtns(false, param2)`。这里 `param1`（`setBtns` 的「是否 addChild」）传的是 **false**：只改坐标，不重新 addChild。顶层钮已经在显示列表里，false 没问题；子钮刚被 removeChild，也不会被加回来。

键盘 ESC：`_btnIndex = 父.index` 再 `closeChildren(true, true)`。**不** `hoverBtn(父)`，父钮视觉上回到帧 1 且 `bg` 不一定 visible，要再按上下才会高亮。?

### `setBtns`（L422–477）

把顶层（以及当前展开的子项）按楼梯排好。

`param1`：是否 `addChild(ui)`。`param2`：是否 tween。

累计 `_loc8_`（x，从 0 起每次 `+= _xadd`）和 `_loc6_`（y，每次 `+= height + _yadd`）。

对每个顶层钮：

1. `param2` 真：0.2s tween 到 `(x,y)`；否则直接赋。
2. 累加偏移。
3. `param1` 真则 `addChild(ui)`（重复 addChild 只提到最前，不报错）。
4. 若该钮就是 `_showIngChildrenBtn`：内层循环子钮。子钮坐标 **直接赋**（不 tween x/y）。`param2` 真则 `scaleX=0.01` 再 0.2s tween 到 1，`delay = 子下标 * 0.04`，`Back.easeOut`。`param1` 真则 `addChild(子.ui)`。然后继续累加楼梯。

`_loc5_`（子循环下标）在函数开头置 0，**不会在每个父之间重置**。只有一个父会进内层，无影响。

第一次 `build`：`setBtns(true, false)` 无 tween。展开：`setBtns(true, true)` 顶层滑开腾位子、子项弹出。收拢：`setBtns(false, true)` 顶层滑回。

### `render`（L480–520）

每帧。`GameRender` `"anyone"` 桶。

1. `!enabled` return。
2. `GameUI.showingDialog()` return（主菜单首次运行的 `GameUI.alert("UPDATE", …)` 期间不抢键）。鼠标/触摸 **不**走这条。
3. 焦点数组 `_loc1_ = _showIngChildrenBtn ? children : _btns`。
4. `GameInputer.up("MENU", 1)`：刚按下。`_btnIndex--`，`<0` 则绕到末项。`hoverBtn(_loc1_[_btnIndex])`。
5. `down` 对称，越过末项回到 0。
6. `select("MENU", 1)`：`selectBtn(_loc1_[_btnIndex])`。确认键来自 `ConfigVO.key_menu.selects`（默认 JKL UIO）。
7. `GameInputer.back(1)`：固定通道 `"MENU"` / `"back"`。若正在展开子菜单：把 `_btnIndex` 写回父 `index`，`closeChildren(true, true)`。**已经在顶层时 ESC 无操作**（不回 Logo、不退出）。

`hoverBtn` 里对顶层循环仍会改 `_btnIndex`。键盘在子菜单里 `up`：先 `_btnIndex--` 再 `hoverBtn(children[newIndex])`，`hoverBtn` 先把 `_btnIndex` 写成某个顶层值再写成子下标，最终仍是子下标。顺序正确是因为子循环在后。

无 `left`/`right`。楼梯只是视觉，不是二维导航。
