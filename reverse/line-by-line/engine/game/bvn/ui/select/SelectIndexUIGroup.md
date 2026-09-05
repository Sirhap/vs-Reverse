# `SelectIndexUIGroup` — 一侧出战顺序（竖条 + 辅助）

一句话目的：加载屏里 **一个玩家** 的出场顺序 UI。`build` 按 `SelectVO.getSelectFighters()` 竖排 `SelectedFighterUI`，辅助（`fuzhu`）单独摆在 `fzx/fzy` 不参与排序。键/鼠/触摸给未编号的人贴 1…n 的 `seltwzmc`，剩最后一人自动。完成时 `GameEvent "SELECT_FIGHTER_INDEX"` + `onFinish`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectIndexUIGroup.as`（377 行）

## Callers / callees

- **Callers**：只 `SelectIndexUI`。`buildItems` new 两个、设坐标 / `fzx` / `fighterOffset` / `setFighterScale`，再 `build(selected_item_p*_mc, p*Select)`。`initP1Group` / `initP2Group`：`initArrow` + `setKey` 或 `autoSelect`。公开 `getOrder` / `setOrder` / `isFinish` 给 `LoadingState` 钩子。
- **Callees**：
  - UI：`SelectedFighterUI`（脸条）、`seltwzmc` 在 `setFighterIndex` / `setAssister` 里由卡片自己贴。
  - 数据：`FighterModel.I.getFighter`、`AssisterModel.I.getAssister`、`SelectVO.getSelectFighters` / `fuzhu`。
  - 输入：`GameRender.add/remove(render)`、`GameInputer.focus` + `up/down/select(_inputType, 1)`。
  - 音：`sndSelect`（移动）、`sndConfrim`（贴序号）。
  - 其它：`GameUI.showingDialog` 挡住键；`KyoRandom.arraySortRandom`（街机 P2）；`TweenLite` 0.2s 重排 y；`GameEvent.dispatchEvent("SELECT_FIGHTER_INDEX", getOrder())`。
- **本 SWF 无 listener** 于 `SELECT_FIGHTER_INDEX`（留给 overlay / 联机）。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | destroy 拼写。 |
| `fuzhu` / `_fuzhu` | 辅助卡片。只展示，不进 `_fighters`，不能选。 |
| `fzx` / `fzy` | 辅助相对本组的像素。`fzy` 默认 325；`fzx` 由 `SelectIndexUI.buildItems` 按 P1/P2 写。 |
| `fighterOffset` | 人物条额外 x/y。`SHOW_MODE==1` 才改 x。 |
| `_gy = 100` | 人物竖间距。 |
| `_currentSelectId` | 下一个要贴的序号，从 **1** 起。对应 `seltwzmc` 帧 1/2/3。 |
| `_selectIndex` | `_fighters` 下标（0-based），箭头当前格。 |
| `_inputType` | `"P1"` / `"P2"`。VsCPU 的 P2 组被写成 `"P1"`。 |
| `trueY` | 卡片逻辑 y（未 tween）。箭头跟这个，不跟 `ui.y`。 |
| `sndConfrim` | confirm 拼写。 |
| `doConfrim` | 同上。 |

与选人底部条的关系：卡片类是同一套 `selected_item_p1_mc` / `p2_mc`，但本类 **不** 用 `SelectedFighterGroup`（那是选人阶段叠头像）。这里一人一张，按序号重排竖直位置。

选序规则（`doConfrim`）：手动贴 n−1 人，最后一人 `selectLast` 自动。3 人小队点 2 次即完。

## 逐行说明

### 包与 import（L1–18）

`Sprite`。`TouchEvent` 给 `TOUCH_MODE`。`GameEvent` 只在 `selectFinish` 发一次。

### 字段（L23–51）

- `isFinish`：默认 false。`autoSelect` / `setOrder` / `selectFinish` 置 true。`SelectIndexUI` default 模式从外部写 true。
- `fzx=0`、`fzy=325`。
- `onFinish`：`SelectIndexUI` 灌 `onSelectFinish` 或 VsCPU 包一层。
- `fighterOffset`：`new Point()`。
- `_fighters:Vector.<SelectedFighterUI>`：`build` 才 new。
- `_fighterScale=1`：`setFighterScale` / `build` 时用。
- `_arrowOffset` / `_arrow`：`initArrow`。
- `_selectIndex` / `_selectItem`：当前箭头目标。
- `_inputType`：`setKey`。
- `_currentSelectId=1`。
- `_gy=100`。
- `_fuzhu`：辅助卡，可 null（无 `fuzhu` 字符串）。

### 空构造（L53–56）

无初始化。必须 `build`。

### `getOrder`（L58–69）

`_fighters.sort(sortFighters)` **原地**排 Vector，再按新顺序 push `getFighter().id`。未编号（-1→10）排在后面，相对次序稳定否取决于 `sort` 是否稳定（AS3 `Vector.sort` 不保证稳定）。? 完成后每人有 1…n，结果即出战顺序。

`LoadingState.gotoGame`：`order[0/1/2]` → `fighter1/2/3`。单挑 Vector 长度 1，后两槽 `getCacheFighter(..., undefined)` → null。

### `setFighterScale`（L71–78）

`_fighterScale = param1`。再 `for each` 已有卡片 `scaleX=scaleY`。

`SelectIndexUI.buildItems` 在 **`build` 之前** 调（仅 `SHOW_MODE==1`）。此时 `_fighters` 仍 null。`for each in null` 在 AVM2 通常 TypeError。? 若没抛，`_fighterScale=0.85` 留给 `build` 里 `!= 1` 分支。

### `setOrder`（L80–96）—— 联机灌顺序

对每个卡片：`param1.indexOf(id)`，命中则 `setFighterIndex(index+1)`（数组 0 → 角标帧 1）。未命中保持 -1。

然后 `removeArrow()`、`isFinish=true`、`updateOrder()`。

**不** `dispatchEvent SELECT_FIGHTER_INDEX`，**不** `onFinish`。与手选收束不同。`LoadingState.setOrder` 走这里；`finish` 只看 `isFinish()`，不依赖 `onFinish`。

`setFighterIndex` 会 `mouseEnabled(false)` 并再贴一枚 `seltwzmc`。重复灌会叠角标。?

### `sortFighters`（L98–119）

比较 `getFighterIndex()`。-1 当成 10（未选沉底）。升序。相等返回 0。

### `destory`（L121–141）

`removeArrow()`（兼 `GameRender.remove(render)`）。若有 `_fighters`：每张摘 `"mouseOver"` / `"click"` / `"touchTap"`（听在 `SelectedFighterUI` 这个 dispatcher 上，不是 Sprite），再 `destory()`。`_fuzhu` 同样 destory。`_selectItem=null`。

摘听与 `mouseEnabled` 对称：组 `addEventListener` 在卡片对象上；`SelectedFighterUI.mouseHandler` 把 ui 事件 `dispatchEvent` 上来。

不 `removeChild` 自己。

### `build`（L143–184）

`param1` = `selected_item_p1_mc` 或 `p2_mc` 类；`param2` = 该玩家 `SelectVO`。

`_loc3_ = param2.getSelectFighters()`：非空 `fighter1/2/3` 的 id 数组，**不含** `fuzhu`。小队 3、单挑 1。

`_fighters = new Vector`。对每个 id：

1. `new SelectedFighterUI(new param1())`。
2. `setFighter(FighterModel.I.getFighter(id))`。id 无效则 VO 空，卡片无脸（见 `SelectedFighterUI.setFighter` 截断说明）。
3. `mouseEnabled(true)`：`TOUCH_MODE` 听 `touchTap`，否则 `buttonMode` + `mouseOver`/`click`。组再在卡片 dispatcher 上听同一组 type。
4. `ui.x = fighterOffset.x`；`ui.y = i*_gy + fighterOffset.y`；`trueY = i*_gy`（**不含** offset.y，箭头用 trueY + arrowOffset）。
5. `_fighterScale != 1` 则立刻缩放。
6. `addChild(ui)`。

若 `param2.fuzhu` 非空：再 new 一张，`AssisterModel.I.getAssister`，坐标 `(fzx, fzy)`，`setAssister()`（`seltwzmc` 帧 4），**不** `mouseEnabled`、**不**进 `_fighters`。`_fuzhu =` 这张。

无 `fuzhu`（? 正常选人必选辅助；若 VO 没写则没有角标卡）。

### `selectFighterTouchHandler`（L186–196）

`currentTarget as SelectedFighterUI`。`indexOf` -1 则 return（辅助卡不会到这里）。`selectIndex(_loc2_)` 再立刻 `doConfrim()` —— 触摸没有 hover 二次确认，点谁选谁。

已编号的卡 `mouseEnabled(false)` 已摘 `touchTap`，点不到。

### `selectFighterMouseHandler`（L198–215）

同样取下标。`mouseOver` → `selectIndex` + `sndSelect`；`click` → `doConfrim`。已编号卡摘了 ui 监听，mouseOver 不会上到组。

`selectIndex` 在目标已有序号且 `param2==0`（本路径默认 0）时直接 return，箭头不动。hover 已选中的人无效果。

### `initArrow`（L217–224）

存偏移，`_arrow.x = param2.x`，`addChild`。`selectIndex(0)` 落到第一人（未编号）。P1 偏移 `(-10, 30)`，P2 `(260, 30)`。

`autoSelect` / default 模式 **不** 调这个，无箭头。

### `selectIndex`（L226–248）—— 光标寻未编号格

`param1` 目标下标，`param2` 搜索方向（0=不续搜，±1=碰到已编号继续）。

先 wrap：`<0` → 最后一张；`> length-1` → 0。

取 `_fighters[param1]`。若 `getFighterIndex() != -1`（已贴序号）：

- `param2 != 0`：递归 `selectIndex(param1+param2, param2)`（仍会 wrap）。
- 否则 return，不改 `_selectIndex` / 箭头。

否则记下 `_selectIndex` / `_selectItem`，`_arrow.y = trueY + _arrowOffset.y`。**不**改 `_arrow.x`（用 init 时的）。

全员已编号时，方向非 0 的递归会在 0…n−1 间死循环。? 正常 `doConfrim` 在贴完 n−1 人后走 `selectLast` 而不是再 `selectIndex`。键在 `isFinish` 前仍 `render`；最后一次 `doConfrim` 立刻 `removeArrow` + `GameRender.remove`，不会再进。

`initArrow` 的 `selectIndex(0)`：第一人未编号，安全。

### `setKey`（L250–255）

`_inputType = param1`。`GameRender.add(render)`。`GameInputer.focus()`（不改 `enabled`；`LoadingState.build` 已 `enabled=true`）。

每组各 add 一次。VsPeople 两组同时 render，用不同 `inputType`。VsCPU P2 组 `setKey("P1")`，此时 P1 组已 `selectFinish` → `removeArrow` 已摘自己的 render，不会两份 P1 键。

重复 `setKey` 会再 `GameRender.add` 一份。本包只调一次。

### `autoSelect`（L257–273）—— 街机 P2

把 `_fighters` 拷进 Array，`KyoRandom.arraySortRandom`（`sort` 比较器随机 ±1，不是均匀洗牌）。按乱序 `setFighterIndex(1,2,3…)`。`selectFinish()`。

不经过 `doConfrim`，无 `sndConfrim`。`selectFinish` 仍发 `SELECT_FIGHTER_INDEX` 并调 `onFinish`。

### `removeArrow`（L275–289）

有箭头则 `try removeChild` 吞错，`_arrow=null`。**总是** `GameRender.remove(render)`（即使没箭头 —— `setOrder` 在 default 模式调也安全，remove 不存在的 fn 见 `GameRender`）。

### `render`（L291–311）

`GameUI.showingDialog()` → 整帧 return（`LoadingState` 回菜单确认框）。

`GameInputer.up/down(_inputType, 1)`：边沿 1，不连发。`selectIndex(_selectIndex ± 1, ±1)` + `sndSelect`。已编号格被方向参数跳过。

`select` 键 → `doConfrim()`。无左右键。

不查 `isFinish`（finish 时已 remove render）。

### `doConfrim`（L313–331）

无 `_selectItem` 则空过（没 `initArrow` 时键确认无事；`autoSelect` 不走这里）。

否则：

1. `_selectItem.setFighterIndex(_currentSelectId)`（贴 `seltwzmc` 帧 N，关鼠标）。
2. `_currentSelectId++`。
3. **若 `_currentSelectId > _fighters.length - 1`**：`selectLast()` + `selectFinish()`。
4. 否则 `updateOrder()` + `selectIndex(1, 1)`（从下标 1、方向 +1 找下一个未编号）。
5. `sndConfrim()`。

对 3 人：第一次 id 1→2，`2 > 2` false，重排后从下标 1 找；第二次 id 2→3，`3 > 2` true，最后一人自动编号 3 并结束。只需点两下。

对 1 人（本类在 default 模式根本不 `setKey`；若误进）：第一次 `2 > 0` true，`selectLast` 找不到 -1，该人已是 1，直接 finish。

`selectIndex(1, 1)` 写死从 1 起而不是 `_selectIndex+1`。`updateOrder` 已把已编号沉到上面，未编号在下面，下标 1 通常是下一个未选。2 人时第一次就会走 `selectLast`，不会到这支。

### `selectLast`（L333–343）

第一个 `getFighterIndex()==-1` 的卡 `setFighterIndex(_currentSelectId)` 后 return。只填一个。找不到则空过。

### `selectFinish`（L345–355）

`removeArrow()`、`isFinish=true`、`updateOrder()`。有 `onFinish` 则先 `GameEvent.dispatchEvent("SELECT_FIGHTER_INDEX", getOrder())` 再 `onFinish()`。

`setOrder` 不走这里，所以联机灌顺序不发 INDEX。`autoSelect` 走这里，街机 P2 会发（payload 是乱序后的 id）。

`getOrder` 再次 `sort`（`updateOrder` 刚排过）。

### `updateOrder`（L357–374）

`_fighters.sort(sortFighters)`。按下标 `i*_gy` 写 `trueY`。`|trueY - ui.y| > 2` 才 `TweenLite.to(ui, 0.2, {y})`。不改 x、不改 scale。

第一次确认后：编号 1 的人到 y=0，两个 -1（当 10）保持相对顺序到 y=100/200。箭头下一帧 `selectIndex` 再对齐 trueY。

`TweenLite` 未 `kill`。`destory` 中途可能还有 tween 打已 destory 的 ui。? `LoadingState.destory` 回菜单时。
