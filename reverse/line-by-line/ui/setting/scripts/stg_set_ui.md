# `stg_set_ui` — 设置页根 MC

一句话目的：`setting` SWF 根导出。主列表 [`SetBtnGroup`](../../../engine/game/bvn/ui/SetBtnGroup.md) 和键位内页都 `addChild` 到这里。子件 `ichigo` 是一护立绘，进/出键位页播 `"key_fadin"` / `"key_fadout"`。

源文件：`decompiled/ui/setting/scripts/stg_set_ui.as`（16 行）

## 如何挂上引擎

[`ResUtils.SETTING`](../../../engine/game/bvn/utils/ResUtils.md) = `"stg_set_ui"`。[`SettingState.build`](../../../engine/game/bvn/state/SettingState.md) `createDisplayObject(ResUtils.I.setting, ResUtils.SETTING)` → `_ui`，`Istage.display` 返回它。`MainGame.goOption()` 进本舞台。

引擎挂接：

| 调用 | 效果 |
|---|---|
| `_ui.addChild(_btnGroup)` | 主设置竖表（P1/P2 KEY SET … QUALITY + APPLY），`startY=30` `gap=70` `endY=550` |
| `_man = _ui.ichigo` | 立绘引用 |
| `_man.gotoAndPlay("key_fadin")` | `goInnerSetPage`：主表滑出、[`SetCtrlBtnUI`](../../../engine/game/bvn/ui/SetCtrlBtnUI.md) 从屏底滑入 |
| `_man.gotoAndPlay("key_fadout")` | `goMainSetting`：键位页滑走、主表回来 |
| `_ui.addChild(innerUI.getUI())` | 内页根是 [`keyset_mc`](keyset_mc.md) |

空构造。无 `addFrameScript`。时间轴标签在 `ichigo` 子件上，不在本根。嵌套元件 [`setting_fla.元件1_13`](setting_fla/元件1_13.md) 三处 `stop()` 可能就是这段立绘（F15/F25/F35 ↔ fadin / hold / fadout），见该文件 `?`。

SWF：`setting_swf`（DefineBinaryData id 2211），链接名 `stg_set_ui`，`symbol="symbol9"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class stg_set_ui extends MovieClip`。[Embed] `source="/_assets/assets.swf", symbol="symbol9"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `ichigo` | `MovieClip` | 一护立绘。引擎当 `_man`。标签 `"key_fadin"` / `"key_fadout"` 在这棵（或更深子）时间轴上。本 AS 不声明标签 |

### 构造 `stg_set_ui()`（L11–14）

- L13: `super();`
- 无脚本。主表 / 内页全是运行时 `addChild`。
