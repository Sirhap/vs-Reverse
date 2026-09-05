# `SelectedFighterUI` — 已选 / 出战顺序一张脸条

一句话目的：一条 `selected_item_p1_mc` / `p2_mc` 的逻辑包装。选人底部叠图和加载屏出战顺序都用它。`setFighter` 写名字；`setFighterIndex` 贴 1/2/3 角标；`setAssister` 贴辅助角标（`seltwzmc` 帧 4）。自身 `EventDispatcher`，把 ui 的鼠标/触摸原样 `dispatchEvent` 给 `SelectIndexUIGroup`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectedFighterUI.as`（169 行）

## Callers / callees

- **选人底部**：`SelectedFighterGroup.addFighter` `new SelectedFighterUI(new _uiClass())`，`setFighter` / `updateFighter`。不 `mouseEnabled`（底部条不可点）。
- **出战顺序**：`SelectIndexUIGroup.build` 每人一张 + 可选辅助一张。人物 `mouseEnabled(true)`；辅助只 `setAssister()`。`setFighterIndex` 在确认顺序时。
- **Callees**：`AssetManager`（见 `setFighter` 截断）、`ResUtils.I.select` → `"seltwzmc"`、`GameUI.SHOW_CN_TEXT`、`UIUtils.formatText`、`BitmapText`、`GameConfig.TOUCH_MODE`。类型判断 `param1 is selected_item_p1_mc` 区分左右排版。
- **摘**：`SelectedFighterGroup.destory` 只 destory `_curUI`；`SelectIndexUIGroup.destory` 遍历人物 + `_fuzhu`。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | destroy 拼写。 |
| `seltwzmc` | 角标 MC。帧 1/2/3 = 出战序号，帧 4 = 辅助。链接名在 `loading` SWF 也有一份；当前域共享。 |
| `trueY` | 出战顺序用的逻辑 y。选人底部不用。 |
| `_fighterIndex` | -1 未选序。`sortFighters` 把 -1 当 10。 |
| `_face` | 声明了，可见字节码从未赋值。见 `setFighter`。 |
| `_uiWidth` | 声明了，全文未读写。死字段。 |
| `ctmc` | 条上名为 `"ct"` 的容器，自身还有子 `ct`（`ctmc.ct`）。 |

SWF：

| 链接名 | 用途 |
|---|---|
| `selected_item_p1_mc` | 左条，子件 `ct:ctmc`。字右对齐。 |
| `selected_item_p2_mc` | 右条。字左对齐，`x=10`。 |
| `seltwzmc` | 角标。P1 `x=-8`；P2 人物 `x=252-width`，辅助 `x=176`。`y=-5`。 |
| `ctmc` | 脸容器。 |

## 逐行说明

### 包与 import（L1–15）

`EventDispatcher`，不是 Sprite。显示对象是 `ui`。import 了 `AssetManager`，可见方法体里几乎没用到 —— 和 `setFighter` 截断吻合。

### 字段（L19–31）

- `ui`：构造传入的 MC。
- `trueY=0`：`SelectIndexUIGroup` 写。
- `_fighterIndex=-1`。
- `_face` / `_fighter` / `_text` / `_uiWidth`。

### 构造（L33–63）

`(Sprite)`。`mouseChildren=false`（点到条本身，不点子物件）。

`GameUI.SHOW_CN_TEXT`（默认 true）：`BitmapText(true, 0xFFFFFF, [GlowFilter(0,1,3,3,3)])`。

- `is selected_item_p1_mc`：字 14 白 **right**，`width = ui.width-10`（无 x，靠右对齐）。
- else（P2）：**left**，`x=10`，`width` 同样。
- `y = ui.height-25`，`addChild` 到条上。

`SHOW_CN_TEXT=false` 则全程无 `_text`，`setFighter` 只走脸（若有）。

### `mouseEnabled`（L65–86）

`true`：`TOUCH_MODE` 只听 `"touchTap"`；否则 `buttonMode=true` + `"mouseOver"` / `"click"`。listener 都是 `mouseHandler`，挂在 **`ui`** 上。

`false`：`buttonMode=false`，摘三种。`setFighterIndex` 贴完序号后关，避免再点已编号的人。

选人底部从不调，条不接收鼠标（光标 `SelecterItemUI.ui` 也 `mouseEnabled=false`，点穿到格子）。

### `mouseHandler`（L88–92）

`dispatchEvent(param1)`。AS3 会 clone 事件，`target/currentTarget` 变成 **本 SelectedFighterUI**。`SelectIndexUIGroup` 才能 `currentTarget as SelectedFighterUI`。

### `destory`（L94–107）

摘 ui 上三种监听。`_text.destory()`。**不** `removeChild(ui)`，**不**清 `_face` / `_fighter`。`SelectedFighterGroup.addFighter` 把上一张当 `_curUI.destory()` 时，MC 仍留在叠层，只是名字 Bitmap 没了。

### `setFighter`（L109–122）—— **反编译截断**

可见字节码：

1. 声明 `_loc3_:* = null`。
2. `param1` 空 → return（工厂 `addFighter(null)`、空 hover）。
3. `_fighter = param1`。
4. 有 `_text` 则 `_text.text = param1.name`。
5. `_loc2_ = ui.getChildByName("ct") as ctmc`。
6. **函数在此结束。** `_loc2_` / `_loc3_` / `_face` 再无使用。`_uiWidth` 从未出现。

四个 import 树（decompiled / import-full / keepzl / noload）同文，不是单次 FFDec 事故。

残留证据：

- 字段 `_face`、局部 `_loc3_`、取了 `ctmc` 却不用。
- `AssetManager.getFighterFaceBig` 默认 **245×62**（大横条），`AssetManager.md` 写「本包无调用方」，资源却无条件预载。
- `ctmc` 还有子 `ct`，典型写法是往 `ct.ct` 里 `addChild` 脸，替换旧 `_face`。

? 原函数后半应是：按 `ct.ct` 尺寸取 `getFighterFaceBig`（或 `getFighterFace`），摘旧 `_face`，新脸赋 `_face` 并 addChild。当前 dump 下 **脸图不会出现在已选条 / 出战条上**，只剩底图 + 名字（若 `SHOW_CN_TEXT`）。以 dump 为准，补全标问号。

`SelectIndexUIGroup` / 底部条都依赖这张脸；若运行时看得到大脸，则运行 SWF 含 FFDec 丢掉的指令。

### `getFighter`（L124–127）

返回 `_fighter`。`getOrder` 取 `.id`。`setFighter` 被空参 return 过的卡 `_fighter` 仍可能是上一份。?

### `getFighterIndex`（L129–132）

`_fighterIndex`。默认 -1。

### `setFighterIndex`（L134–150）

`_fighterIndex = param1`（1/2/3）。`createDisplayObject(..., "seltwzmc")`，`gotoAndStop(param1)`，`addChild` 到条上。

P1：`x=-8`。P2：`x = 252 - width`（靠右）。`y=-5`。

`mouseEnabled(false)`。每次调用 **再 new 一枚** 角标，不摘旧的。`setOrder` 重复灌会叠。?

不改 `trueY`。`updateOrder` 随后按新序号 tween y。

### `setAssister`（L152–166）

同样 `seltwzmc`，`gotoAndStop(4)`。P1 `x=-8`；P2 **写死 `x=176`**（和人物的 `252-width` 不同，辅助条更窄或角标位置不同）。`y=-5`。

不设 `_fighterIndex`、不 `mouseEnabled`（build 时就没开）。辅助不参与 `getOrder`。
