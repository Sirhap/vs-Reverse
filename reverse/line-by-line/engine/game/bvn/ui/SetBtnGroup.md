# `SetBtnGroup` — 通用设置/对话框按钮组（主列表、键位页、暂停、Alert）

一句话目的：竖排或横排一组 `SetBtn`，左边一枚 `select_arrow_mc` 当焦点。键盘走 `GameInputer`（默认 `"MENU"`），鼠标 hover/click，触摸 tap。子钮的 `"SELECT"` / `"OPTION_CHANGE"` 经 `SetBtnEvent.newEvent()` 再往上派，让外层 `currentTarget` 是 Group。设置主列表在 `getSettingMenu()` 为 null 时用内置 P1/P2 KEY SET … QUALITY，并硬加 APPLY。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnGroup.as`（589 行）

## Callers / callees

- **Callers**（decompiled 下全部 `new SetBtnGroup`）：
  - `SettingState.build`：`startY=30`，`endY=550`，`gap=70`，`initMainSet()` + `initScroll(GAME_SIZE.x, 600)`。听 `"SELECT"` / `"OPTION_CHANGE"`。
  - `SetCtrlBtnUI` 构造：`startY=30`，`initKeySet()`（SET ALL / SET DEFAULT / APPLY / CANCEL）。听 `"SELECT"`。
  - `PauseDialog`：`setBtnData([GAME TITLE, MOVE LIST, CONTINUE], 2)`，初始箭头在 CONTINUE。
  - `AlertUI`：`direct=0` 横排，`setBtnData([OK], 1)`（1 个钮，下标 1 会绕回 0）。
  - `ConfrimUI`：横排 YES/NO，`setBtnData(..., 1)` 初始在 NO。
  - `CreditsState`：单钮 BACK，`y = GAME_SIZE.y - 150`。
  - `CongratulateState`：单钮 BACK，`x=230`，滚完字幕才 `keyEnable=true`。
  - `MoveListSp`：单钮 BACK，出招表右下。
- **Callees**：`SetBtn`；`ResUtils.I.common_ui` 的 `select_arrow_mc`；`GameInterface.instance.getSettingMenu`；`GameData.I.config`（`getValueByKey`）；`GameRender.add/remove(render, this)`（**owner=`this`**，多实例必须分开桶）；`GameInputer.focus` / `enabled=true` / `up|down|left|right|select`；`SoundCtrl.I.sndSelect`；`TweenLite` 改 `scrollRect.y`；`SetBtnEvent.newEvent`。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `optoinKey` | 数据字段拼错。读完赋到 `SetBtn.optionKey` |
| `keyEnable` | 本组件输入闸。`SettingState` 进内页时关主列表；`SetCtrlBtnUI.fadIn/fadOut` 开/关自己这份 |
| `direct` | `0` 横排，`1` 竖排（默认）。没有常量名 |
| `gameInputType` | 默认 `"MENU"`。本包调用方都不改 |
| `destory` | destroy 的原拼写 |
| `startX=100` `startY=50` `gap=75` | 默认。`SettingState`/`SetCtrlBtnUI` 改 `startY`；Alert/Confrim 改成 `startX=startY=0`，`gap=200` |

### 两套数据 schema

| API | 英文键 | 中文 | 档 | 当前值 | 额外 |
|-----|--------|------|----|--------|------|
| `initMainBtns`（主设置） | `txt` | `cn` | `options` | 从 `ConfigVO.getValueByKey(optoinKey)` | 可选 `select:Function` |
| `setBtnData`（其它） | `label` | `cn` | `options` | 数据里的 `optionValue` | — |

两边 options 元素都是 `{label, cn, value}`。`initMainBtns` **总是**在末尾再 `addBtn("APPLY","应用")`，即使自定义 `getSettingMenu` 已经带了 APPLY。

### 默认主列表（`getSettingMenu()` 本包返回 null）

| `txt` | `cn` | `optoinKey` | 档 `.value` |
|-------|------|-------------|-------------|
| P1 KEY SET | 玩家1 按键设置 | — | 无 options → SELECT → `SettingState.goKeyConfig(1, key_p1)` |
| P2 KEY SET | 玩家2 按键设置 | — | 同上，`key_p2` |
| COM LEVEL | 电脑等级 | `AI_level` | 1 VERY EASY … 6 HELL |
| OPERATE MODE | 按键操作模式 | `keyInputMode` | 0 NORMAL / 1 CLASSIC |
| LIFE | 生命值 | `fighterHP` | 0.5 / 1 / 2 / 3 / 5（倍率） |
| TIME | 对战时间 | `fightTime` | 30 / 60 / 90 / -1（∞） |
| SOUND | 游戏音效 | `soundVolume` | 0 / 0.1 / 0.3 / 0.5 / 0.7 / 1 |
| BGM | 背景音乐 | `bgmVolume` | 同上 |
| QUALITY | 画质等级 | `quality` | `"low"` / `"medium"` / `"high"` / `"best"`（无 `higher`） |
| APPLY | 应用 | — | 硬加。`saveData` + `applyConfig` + `updateConfig` + `goMenu` |

`ConfigVO` 默认：`AI_level=1`，`keyInputMode=1`（CLASSIC），`fighterHP=1`，`fightTime=60`，音量 0.7，`quality="medium"`。`setOptionByValue` 按这些把箭头拨到对应档。

### 其它调用方的 label

| 调用方 | labels | 初始箭头 |
|--------|--------|----------|
| `initKeySet` | SET ALL / SET DEFAULT / APPLY / CANCEL | 0 |
| `PauseDialog` | GAME TITLE / MOVE LIST / CONTINUE | 2 |
| `AlertUI` | OK | 1→绕 0 |
| `ConfrimUI` | YES / NO | 1（NO） |
| `CreditsState` / `CongratulateState` / `MoveListSp` | BACK | 0 |

## 逐行说明

### 字段（L21–41）

- `keyEnable = true`：`render` / `mouseHandler` / `touchHandler` 总闸。
- `startX=100` `startY=50`：第一钮原点。`endY=0`：竖向滚动的可见底；0 表示用 `scrollRect.height`。
- `gap=75`：钮间距（竖=Δy，横=Δx）。
- `direct=1`：竖。
- `gameInputType="MENU"`。
- `_btns:Vector.<SetBtn>`。
- `_arrow:select_arrow_mc`。
- `_arrowIndex = -1`：尚无焦点。`setArrowIndex` 同值提前 return，所以第一次从 -1 拨到 0 一定生效。
- `_scrollRect`：仅 `initScroll` 后才有。暂停/对话框/制作组都不滚。

### 构造（L43–51）

`TOUCH_MODE` 则 `scaleX = scaleY = 1.1`。主菜单 Group 是 1.3；这里略小。

### `initScroll`（L54–57）

`param1` 宽、`param2` 高 → `new Rectangle(0,0,w,h)` 赋给 `this.scrollRect`。`SettingState` 传 `(GAME_SIZE.x, 600)`。之后 `moveScroll` tween 这个 Rectangle 的 `y`。

### `initMainSet`（L60–66）

设置页主列表入口：

1. `initMainBtns()` 建钮（含 APPLY）。
2. `initArrow()` 默认箭头 0。
3. `GameRender.add(render, this)`。
4. `GameInputer.focus()` + `enabled = true`。

`SettingState.build` 在 `initMainSet` 之后才 `initScroll`，第一次 `setArrowIndex(0)` 时还没有 `_scrollRect`，`moveScroll` 直接 return。之后用户往下拨才滚。

### `initKeySet`（L69–83）

键位页四钮，中文「设置全部 / 还原默认按键 / 应用 / 取消」。转 `setBtnData`，箭头默认 0。无 options，全是 SELECT。

### `setBtnData`（L86–109）

通用建表。`param1` 数组，`param2` 初始箭头（默认 0）。

1. `_btns = new Vector.<SetBtn>()` —— **直接丢掉旧 Vector**，不 `destory` 旧钮。只应调一次。
2. 每项 `addBtn(label, cn, options)`。
3. 若数据有 `optoinKey`（`!= undefined`）抄到 `SetBtn.optionKey`。用 `!= undefined` 是为了允许合法空串；本包都是正常字段名。
4. 若有 `optionValue`，`setOptionByValue`（不派事件）。
5. `initArrow(param2)`。
6. `GameRender.add(render, this)` + `focus` + `enabled=true`。

`initMainSet` 不走这里（自己 `initMainBtns` + `initArrow` + add render）。主列表的当前档来自 `ConfigVO`，不是数据里的 `optionValue`。

### `destory`（L112–127）

有 `_btns` 则逐个：`destory()`（只丢英文 BitmapFontText）、卸 `touchTap` / `mouseOver` / `click` / `OPTION_CHANGE` / `SELECT`。本类 **extends Sprite**，这些 listener 是挂在 SetBtn 自己身上的，`removeEventListener` 对得上。

然后 `_btns = null`；`GameRender.remove(render, this)`。不 `removeChild` 箭头/钮（调用方通常把整个 Group 拿掉）。不卸外层在 Group 上听的 `"SELECT"`——调用方自己卸（`SettingState` / `PauseDialog` 等）。`CreditsState.destory` 先 `destory()` 再 `removeEventListener`，顺序反过来，但 destory 并不清 Group 自己作为 Dispatcher 的表，后卸仍有效。

### `initMainBtns`（L130–330）

1. `_btns = new Vector`。
2. `GameInterface.instance.getSettingMenu()`。本包 GIM **恒 null**。
3. null 则用 L139–312 那份硬编码表（见上表）。`QUALITY` 的 value 是字符串 `"low"`…`"best"`，其它是 Number。
4. `ConfigVO config = GameData.I.config`。
5. 逐项 `addBtn(txt, cn, options)`。若数据有 `select` 函数，赋给 `SetBtn.onSelect`（默认表没有）。`optionKey = optoinKey`（没有该键则 `undefined`）。有 `optionKey` 才 `setOptionByValue(config.getValueByKey(...))`。
6. 循环后再 `addBtn("APPLY","应用")` —— 无 options，走 SELECT。

自定义 `getSettingMenu` 若自己带 APPLY，这里会变成两个 APPLY。本包不会。

### `addBtn`（L333–366）

`param1` 英文，`param2` 中文，`param3` options（可空）。

1. `new SetBtn(label, cn)`。
2. `TOUCH_MODE` 听 `"touchTap"`，否则 `"mouseOver"` + `"click"`。原生 Sprite 事件，handler 吃 `MouseEvent`/`TouchEvent`。
3. `direct==0`：`x = startX + gap * index`，`y = startY`（横排）。`direct==1`：`x = startX`，`y = startY + gap * index`（竖排）。其它 `direct` 不设坐标，落在 (0,0) 叠在一起。?
4. `addChild(btn)`。
5. 有 `param3`：`setOption` + 听 `"OPTION_CHANGE"` → `onChangeOption`。**不**听 SELECT。
6. 无 `param3`：听 `"SELECT"` → `onSelect`。
7. `_btns.push`，返回该钮。

### `touchHandler`（L369–394）

`!keyEnable` return。`currentTarget as SetBtn`，找不到下标 return。

- 点的就是当前 `_arrowIndex`：有 option → `nextOption()`（只能往下一档，环绕）；无 option → `select()`。
- 否则只 `setArrowIndex(下标, true)`（移动箭头 + 音效），**不**确认。与 `MenuBtnGroup` 触摸二次确认同一套。

有 option 的行没有「往回拨」的触摸手势。

### `mouseHandler`（L397–432）

`!keyEnable` return。

- `"mouseOver"`：`setArrowIndex(index)`（默认带音效）。快速划过会连响 `sndSelect`。
- `"click"`：无 option → `select()`。有 option：看 `e.target.name`（点穿到箭头 Sprite）。`"prevArrow"` / `"nextArrow"` 调对应档。点在英文标签 / 线上：`target` 不是箭头，什么都不做。`if(!param1.target) break` 防御空 target，正常 click 不会。

`SetBtnLine` 已 `mouseEnabled=false`，点线等于点到 SetBtn 自己，`name` 对不上箭头。

### `initArrow`（L435–439）

`createDisplayObject(common_ui, "select_arrow_mc")`，`addChild`，`setArrowIndex(param1)` 默认 0。每次 `setBtnData` / `initMainSet` 都会再 new 一枚。第二次调用会留下旧箭头在显示列表里（本包各实例只 init 一次）。

### `setArrowIndex`（L442–479）

`id` 目标下标，`sound` 默认 true。`SetCtrlBtnUI.fadIn` 调 `setArrowIndex(0)` 把焦点拉回 SET ALL。

1. 与当前 `_arrowIndex` 相同则 return（含音效也不播）。
2. `<0` 绕到末项；`> length-1` 绕到 0。空 `_btns` 会在 `_btns[id]` NRE；`render` 有 length 检查，`initArrow` 时至少已有钮。
3. 记 `_arrowIndex`。箭头放到 `btn.x - 10`，`btn.y + 15`。
4. `_btns.every(...)`：命中 `hover()`，其余 `hoverOut()`。`every` 回调恒 `return true`，等于 for-each。
5. `sound` 真则 `sndSelect()`。`initArrow(0)` 第一次从 -1 过来会播一次。
6. `moveScroll()`。

公开方法。`PauseDialog.show` 调 `setArrowIndex(2)` 每次打开暂停都指回 CONTINUE。

### `moveScroll`（L482–512）

无 `_scrollRect` return。只处理 `direct==1`。

1. `_btns.length < 8` return。默认主列表 10 项（9+APPLY）会滚；键位页 4 项 / 暂停 3 项 / BACK 1 项都不滚。
2. 可见底 `endY != 0 ? endY : scrollRect.height`。`SettingState.endY=550`。
3. `this.height < 可见底` return（还没超）。
4. `份额 = (可见底 - startY) / length`；目标 `scrollRect.y = -_arrowIndex * (份额 - gap)`。
5. `TweenLite.to(_scrollRect, 0.2, {y, onUpdate:updateScroll})`。tween 普通 Rectangle 的 y，靠 onUpdate 写回 `this.scrollRect`（Flash 的 scrollRect 是拷贝赋值，改字段不自动生效）。

箭头本身在 Group 本地坐标里跟着钮走；滚的是裁剪窗，视觉上箭头+钮一起滑。

横排 `direct==0` 完全不滚。

### `updateScroll`（L515–517）

`this.scrollRect = _scrollRect`。TweenLite 每帧改 y 后贴回去。

### `render`（L520–570）

每帧，owner=本实例。

1. `!keyEnable` return。
2. `_btns` 空 return。
3. `_loc1_ = _btns[_arrowIndex]`。`_arrowIndex` 仍是 -1 时会取到 `undefined`，后面 `prevOption` NRE。`initArrow` 总会先 `setArrowIndex`，正常不会。
4. `up`：仅 `direct==1` 时 `setArrowIndex(index-1)`。横排上键无效。
5. `down`：对称。
6. `left`：横排则左移箭头；**竖排则 `prevOption()`**（无 options 的行 `prevOption` 内部 return，等于空操作，但仍过一层）。
7. `right`：横排右移；竖排 `nextOption()`。
8. `select(gameInputType, 1)`：**一律 `_loc1_.select()`**。有 options 的行会派没人听的 SELECT，并 `sndConfrim`。键盘不能靠确认键改档，只能左右。

无 `GameInputer.back`。取消靠 CANCEL/BACK 钮，或外层自己听 ESC（本类不管）。`GameUI.showingDialog()` **不**在这里检查——主设置页上弹 Alert 时，Group 仍吃键盘。`PauseDialog.btnGroupSelectHandler` 自己判 `showingDialog`；`MenuBtnGroup.render` 才挡。设置页被 Alert 盖住时主列表可能还在动。?

`SettingState.goInnerSetPage` 把主列表 `keyEnable=false`，避免和键位页抢键。键位页自己另有一份 Group。

### `onChangeOption`（L573–575）

`dispatchEvent(param1.newEvent())`。浅拷贝 type/bubbles/字段，换 target 为 Group。`SettingState` 听到的 `currentTarget` 是 Group。

### `onSelect`（L578–585）

若该 `SetBtn.onSelect != null` 先调（自定义菜单钩子）。然后同样 `newEvent()` 往上抛。`selectedLabel` 保留。外层一律 `switch(e.selectedLabel)` 字符串，不用常量。
