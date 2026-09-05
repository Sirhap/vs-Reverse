# `MenuBtn` — 主菜单单钮（`mc_wzbtn` + 中文优先）

一句话目的：主菜单一项的逻辑对象。显示对象是 `common_ui` 的 `mc_wzbtn`，英文 `BitmapFontText` 造出来立刻藏掉，屏幕上只画中文 `BitmapText`。`MenuBtnGroup` 通过包装后的 `click` / `mouseOver` / `touchTap` 驱动 hover / select / 子菜单开合。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/MenuBtn.as`（203 行）

## Callers / callees

- **Callers**：仅 `MenuBtnGroup.addMenuBtn`。`new MenuBtn(txt, cn, func)`；有 `children` 时对子钮再 `childMode()`。`MenuState` 不直接碰本类。
- **Callees**：`ResUtils.I.createDisplayObject(common_ui, "mc_wzbtn")`；`AssetManager.I.getFont("font1")` → `BitmapFontText`；`BitmapText` + `UIUtils.formatText`（黑体 28 白字）；`TweenLite` + `Elastic.easeOut`；`SoundCtrl.I.sndSelect` / `sndConfrim`；`ColorTransform`。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `ui` | 真正上屏的 `mc_wzbtn`。本类 **extends EventDispatcher 不是 Sprite**，`addChild` 的是 `ui` 不是 `this` |
| `label` | 英文 `txt`（`getFucByLabel` 的 case 键） |
| `cn` | 中文。空则回落到 `label` |
| `func` | 菜单项自带回调。RANK 用这个（`Ctrler4399.showRank`）；默认树没有 `func`，走 `getFucByLabel` |
| `children` | 子 `MenuBtn[]`。TEAM PLAY / SINGLE PLAY 才有 |
| `_isOpen` | 父钮已展开子项。此时 `hover`/`normal` 直接 return |
| `sndConfrim` | confirm 的原拼写 |
| `destory` | 本类方法名是 `dispose`；中文 `BitmapText` 调的是 `destory` |

`mc_wzbtn` 约定：子级 `bg` 是高亮条 MC（帧 1 普通 / 帧 2 展开或子项）。`buttonMode=true`，`mouseChildren=false`（整钮一块点）。

## 逐行说明

### 字段（L17–35）

- `ui:*`：运行时是 `mc_wzbtn`。星号是因为 SWF 导出名没有在脚本里 import。
- `cn` / `label` / `func`：构造写入，之后只读。
- `height = 75`：`MenuBtnGroup` 排版用。`childMode` 改成 55。
- `index`：顶层是 `_btns` 下标；子钮是自己在 `children` 里的下标。`render` 里 ESC 关子菜单时靠它把 `_btnIndex` 拨回父项。
- `children:Array`：没有子项则为 `null`（`selectBtn` 用 `if(target.children)` 判断）。
- `_bitmapText`：英文位图字，**`visible=false`**，等于汉化补丁留下的死层。`openChild` / `childMode` 仍对它做 `colorTransform`，屏幕上看不见。
- `_cnTxt`：真正显示的中文。
- `_listeners:Object`：`type → 回调`。回调签名是 `(type:String, btn:MenuBtn)`，**不是** `(e:Event)`。
- `_isOpen`：默认 false。

### 构造（L39–67）

`param1` 英文 label，`param2` 中文（默认 `""`），`param3` 可选 `func`。

1. 记 `cn` / `label` / `func`。
2. `ResUtils.I.createDisplayObject(ResUtils.I.common_ui, "mc_wzbtn")` → `ui`。
3. `ui.buttonMode = true`；`ui.mouseChildren = false`（点击落到 `ui` 自己，不落到字）。
4. `new BitmapFontText(font1)`，`text = param1`，水平居中（`x = -width/2`），`visible = false`，`ui.addChild`。
5. `ui.bg.mouseEnabled = ui.bg.mouseChildren = false`（反编译 `_temp_4`），`ui.bg.visible = false`：默认不高亮。
6. `showTxt = (cn 非空) ? cn : label`。`new BitmapText()`，`UIUtils.formatText` 黑体 28、白色 `16777215`。`y = 10`，水平居中，`ui.addChild`。

同包 `UIUtils` 不必 import。

### `addEventListener` 覆盖（L70–77）

不走 `EventDispatcher` 自己的表，把 listener 挂到 **`ui`**：

1. `ui` 已有该 type 则 return（不能换回调、不能重复注册）。
2. `ui.addEventListener(type, selfHandler, …)`。
3. `_listeners[type] = 用户回调`。

`MenuBtnGroup` 因此把 `mouseHandler`/`touchHandler` 登记成「收到 type 字符串 + 本钮」。原生 `MouseEvent` 不会进 Group。

**不覆盖 `removeEventListener`。** Group 的 `destory` 对 `MenuBtn` 调 `removeEventListener("click", mouseHandler)` 走的是 `EventDispatcher` 空表，**卸不掉 `ui` 上的 `selfHandler`**。

### `removeAllEventListener`（L80–86）

遍历 `_listeners`，对 `ui` `removeEventListener(type, 用户回调)`。但 `ui` 上挂的是 `selfHandler`，用户回调根本没登记到 `ui`。**实际卸不掉。** `dispose` 依赖这条，等于监听泄漏。Group 从显示列表拿掉后通常整树一起丢，运行时未必炸。?

### `selfHandler`（L89–91）

`_listeners[e.type](e.type, this)`。把 Flash 事件压成 `(String, MenuBtn)`。`this` 是 `MenuBtn` 不是 `ui`。

### `isHover`（L94–96）

`ui.bg.visible`。触摸模式用：第一次 tap 只 hover，第二次才 select。

### `hover`（L99–113）

1. `_isOpen` 则 return（展开中的父钮保持帧 2，不被高亮动画打断）。
2. `bg` 已经 visible 则 return（防重复 tween / 重复音效）。
3. `bg.visible = true`；记下当前 `scaleX`，闪到 `0.01`，0.2s tween 回原值。
4. `SoundCtrl.I.sndSelect()`。

不改 `_cnTxt` 颜色。

### `normal`（L116–122）

`_isOpen` 则 return。否则 `ui.bg.visible = false`。不杀正在跑的 `TweenLite`。?

### `select`（L125–133）

选中反馈，**不**自己调 `func`（Group 在 tween 完成回调里调）。

1. `ui.alpha = -1`（立刻全透明；负 alpha 被 Flash 当成 0）。
2. `TweenLite.to(ui, 1, {alpha:1, ease:Elastic.easeOut, onComplete:param1})`。1 秒弹性淡入。
3. `SoundCtrl.I.sndConfrim()`。

`MenuBtnGroup.selectBtn` 把 `enabled=false` 再把 `callFunc` 当 `param1` 传入：播完才真正 `goSelect` / `goOption` 等。

### `openChild`（L136–148）

父钮展开子项时 Group 调用。已 open 则 return。

1. `_isOpen = true`。
2. `ui.bg.gotoAndStop(2)`。
3. 英文层 `ColorTransform`：`redOffset=50`，`greenOffset=blueOffset=-30`（偏红）。`_bitmapText` 不可见，等于没画。中文 `_cnTxt` **不**变色。

### `closeChild`（L151–159）

未 open 则 return。`_isOpen=false`，`bg.gotoAndStop(1)`，`_bitmapText.colorTransform(null)`。

### `dispose`（L162–182）

Group `destory` 时对顶层钮调用；顶层再递归子钮。

1. `_bitmapText.dispose()` 置空。
2. `removeAllEventListener()`（见上，卸不干净）。
3. 有 `children` 则逐个 `dispose()` 后置空。
4. `_cnTxt.destory()`（拼写保留）置空。

不 `removeChild`，不杀 `TweenLite`，不丢 `ui` 引用。`MenuState.destory` 先 `parent.removeChild(group)` 再 `group.destory()`，显示对象跟 Group 一起走。

### `childMode`（L185–199）

只在 `addMenuBtn(..., true)` 建子钮后调一次。

1. 同一套偏红 `ColorTransform` 打在不可见的 `_bitmapText` 上。
2. `_bitmapText.scaleX = scaleY = 0.75`，重新水平居中。
3. `ui.bg.scaleY = 0.75`，`scaleX = 0.9`，`gotoAndStop(2)`（子项默认用展开帧）。
4. `height = 55`（比父钮矮 20，Group 排版更密）。

中文 `_cnTxt` **不**缩小。子项视觉主要靠更矮的 `bg` 和更密的 y 间距。
