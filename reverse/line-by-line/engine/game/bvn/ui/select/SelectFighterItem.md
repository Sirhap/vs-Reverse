# `SelectFighterItem` — 选人网格一格

一句话目的：`select.xml` 一格的显示包装。脸图塞进 `slt_item_mc`，自身 `EventDispatcher` 把 UI 鼠标/触摸转成 `(type:String, item)` 回调。空 id / 缺 VO 根本不会被 `SelectFighterStage.addFighterItem` new 出来，因此不进 `_itemObj`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectFighterItem.as`（85 行）

## Callers / callees

- **Callers**：只 `SelectFighterStage.addFighterItem`（L248）`new SelectFighterItem(vo, itemVO)`。`vo` 来自 `FighterModel.getFighter` 或 `AssisterModel.getAssister`；`itemVO` 是 `SelectCharListItemVO`（列 x、行 y、`fighterID`、可选 `offset`）。成功才 `_ui.addChild(item.ui)`，字典键 `x+","+y`。
- **事件**：舞台 `TOUCH_MODE` 听 `"touchTap"`，否则 `"mouseOver"` + `"click"`。handler 签名是 `(String, SelectFighterItem)`，不是 `MouseEvent`（见 `selfHandler`）。
- **读取字段**：`selectData`（寻格 / hover 比较）、`fighterData`（`currentFighter`、随机池）、`ui`（坐标、addChild）。`moveToSelectFighter` 用 `ui.x/y` 对齐光标，不用 `position`。
- **销毁**：`SelectFighterStage.clear` 对每项摘听（本类未 override `removeEventListener`，真正摘在 `destory` → `removeAllEventListener`）再 `destory()`。
- **Callees**：`AssetManager.I.getFighterFace`（默认 50×50）、`ResUtils.I.select` → `"slt_item_mc"`。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | destroy 拼写。 |
| `slt_item_mc` | 格子 MC。子件 `ct:MovieClip` 放脸。与光标 `select_item_mc` 不是同一个。 |
| `selectData` | XML 格（坐标 + id），不是 `SelectVO`。 |
| `fighterData` | 人物和辅助都是 `FighterVO`。 |
| `position` | 声明 `new Point()`，**从未写入**。死字段。 |
| `faceSize` | `(50,50)` 私有，**从未读取**。`getFighterFace` 自己默认 50×50。 |

SWF：`slt_item_mc`（`select` SWF）。`buttonMode=true` 出手指；`mouseChildren=false` 避免点到脸 Bitmap。

## 逐行说明

### 包与 import（L1–10）

`EventDispatcher` 子类，**不是** DisplayObject。舞台 addChild 的是 `.ui`。

### 字段（L15–25）

- `selectData` / `fighterData`：构造写入。
- `ui`：**字段初始化**就 `createDisplayObject`（`new` 时、`super()` 之后立刻跑），构造体再往 `ct` 塞脸。
- `position` / `faceSize`：见上，死。
- `_listeners`：`type → Function`。override `addEventListener` 用。

### 构造（L27–39）

`(FighterVO, SelectCharListItemVO)`。存两个 VO。`getFighterFace(param1)` 有图则 `ui.ct.addChild`。无图（缺 URL / 未预载）格子仍在，只是空框。

`mouseChildren=false`、`buttonMode=true`。不在这里 `addEventListener` —— 舞台按触摸模式再挂。

辅助阶段 `FighterVO` 来自 `AssisterModel`，脸走 `faceUrl`（辅助预载只有 face + big，见 `AssetManager.loadBitmaps`）。

### `addEventListener`（L41–49）—— 改签名的关键

override。若 `ui.hasEventListener(param1)` 已有 → **直接 return**（不会换回调、也不会叠 selfHandler）。

否则 `ui.addEventListener(type, selfHandler, …)`，并把调用方 Function 存 `_listeners[type]`。

结果：舞台以为在听本对象，实际听的是 `ui`；回调不是 Event，而是 `selfHandler` 拼出来的两个参数。

`useCapture` / `priority` / `useWeakReference` 原样传给 `ui`。本包全默认。

### `removeAllEventListener`（L51–58）

遍历 `_listeners`：`ui.removeEventListener(_loc1_, _listeners[_loc1_])`。

**对不上**：真正挂在 `ui` 上的是 `selfHandler`，不是存进去的舞台回调。`removeEventListener` 用错 listener 引用，**摘不掉**。随后 `_listeners={}`。

`clear` 里舞台还调了一次本对象的 `removeEventListener("mouseOver"|…)`（继承自 `EventDispatcher`，本对象上本来就没这些听）。真正的摘听失败。`destory` 若成功 `removeChild`，格子离开显示列表后事件不再派发，靠 GC。若 `ui.parent` 空，监听留在 MC 上。?

### `selfHandler`（L60–63）

`_listeners[param1.type](param1.type, this)`。把 Event 丢掉，改传 type 字符串和 **本 SelectFighterItem**。

舞台 `selectFighterMouseHandler` / `selectFighterTouchHandler` 因此第一个参数是 `"mouseOver"` / `"click"` / `"touchTap"`。

`_listeners[type]` 若已被 `removeAllEventListener` 清掉仍收到 UI 事件 → 对 `undefined` 调用，运行时错。正常路径 destory 后 ui 已摘。

### `destory`（L65–82）

有 `ui` 则 `removeAllEventListener()`（摘听失败，见上）。`ui && ui.parent` 才 `try removeChild(ui)` 并 `ui=null`。无 parent 时 **不** null `ui`，MC 与失败的监听一起留着。

不 destory 脸 Bitmap、不关 `buttonMode`。
