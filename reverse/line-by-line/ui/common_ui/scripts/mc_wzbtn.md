# `mc_wzbtn` — 主菜单按钮皮肤（含 `bg`）

一句话目的：主菜单一项的显示对象。时间轴 1 帧；唯一子级实例名 `bg`，类型运行时是 [`wzimg_bgimg_5`](common_ui_fla/wzimg_bgimg_5.md)。逻辑全在 [`MenuBtn`](../../../engine/game/bvn/ui/MenuBtn.md)，本类只提供壳和那条高亮。

源文件：`decompiled/ui/common_ui/scripts/mc_wzbtn.as`（15 行）

## 如何挂上引擎

无名包导出。SWF char 14，`[Embed(symbol="symbol14")]`。链接名 `"mc_wzbtn"`。

仅 `MenuBtn` 构造：`ResUtils.I.createDisplayObject(ResUtils.I.common_ui, "mc_wzbtn")` 赋给 `ui`。`MenuBtn` **extends EventDispatcher 不是 Sprite**，真正 `addChild` 到 [`MenuBtnGroup`](../../../engine/game/bvn/ui/MenuBtnGroup.md) 的是这份 `ui`。

引擎在壳上做的约定：

- `ui.buttonMode = true`，`ui.mouseChildren = false`（整钮一块点，点不到字、也点不到 `bg`）。
- 英文 `BitmapFontText` `visible=false` 加进来；真正看见的是中文 `BitmapText`（黑体 28 白字，`y=10`，水平居中）。
- `ui.bg`：`mouseEnabled/mouseChildren=false`，默认 `visible=false`。`hover` 才显示；`openChild` / `childMode` `bg.gotoAndStop(2)`；`closeChild` `gotoAndStop(1)`。

见 MenuBtn 文档「`mc_wzbtn` 约定」：`bg` 帧 1 普通 / 帧 2 展开或子项。

## 导出 / 尺寸

1 帧。F1：depth1 放置 char 13（`wzimg_bgimg_5`），**name=`bg`**，`(0, -5)`。高亮条位图 388×75；父级再往上抬 5px。本类没有其它子元件——字是引擎运行时 `addChild` 的。

## 逐行说明

无名包。`public dynamic class mc_wzbtn extends MovieClip`。

### 字段（L9）

- `public var bg:MovieClip;` — 时间轴实例。静态类型写成 `MovieClip`，运行时是 `common_ui_fla.wzimg_bgimg_5`（两帧高亮图）。`MenuBtn` 用 `ui.bg.visible` / `gotoAndStop` / `scaleX|Y`。

### `mc_wzbtn()`（L11–14）

- L13: `super();` — 空。无 `addFrameScript`。单帧皮肤，停在 F1。
