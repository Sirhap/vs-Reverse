# `key_set_dialog_mc` — 等按键对话框皮肤

一句话目的：键位页「SET ALL」盖在 [`keyset_mc`](keyset_mc.md) 上的提示框。英文位图字进 `ct_msg` / `ct_keyname`；中文 `txt` 写「请按下一个键设置【…】」。本 MC 不听键盘。

源文件：`decompiled/ui/setting/scripts/key_set_dialog_mc.as`（21 行）

## 如何挂上引擎

[`SetBtnDialog`](../../../engine/game/bvn/ui/SetBtnDialog.md) 构造：`createDisplayObject(ResUtils.I.setting, "key_set_dialog_mc")`。[`SetCtrlBtnUI`](../../../engine/game/bvn/ui/SetCtrlBtnUI.md) `ui.addChild(_dialog.ui)`。真正听 `"keyDown"` 的是 `SetCtrlBtnUI`（stage），用 `isShow` 当闸。

子件用法：

| 子件 | 引擎 |
|---|---|
| `ct_msg` | `BitmapFontText(font1)`，`text="PUSH A KEY FOR"`，`y=-30`，水平居中后 `addChild` |
| `ct_keyname` | 另一份 `BitmapFontText`，`y=-30`。`show(英文名, 中文名)` 才填 `UP` / `ATTACK` / `SUPER SKILL` 等（来自 [`KeyMapping.name`](../../../engine/game/bvn/ui/KeyMapping.md)），再居中 |
| `txt` | 原生 `TextField`。`defaultTextFormat = 楷体 20`。`show` 写 `"请按下一个键设置【" + cn + "】"`。不走 `UIUtils.formatText`，也不看 `GameUI.SHOW_CN_TEXT`——中文行 **总是** 有 |

开场 `ui.visible=false`，但 `SetBtnDialog.isShow` 字段默认 `true`（逻辑闸和可见性不一致，见 SetBtnDialog.md）。`hide()` 同时关 visible + isShow。

SWF：`setting`，链接名 `key_set_dialog_mc`，`symbol="symbol44"`。

## 逐行说明

### 包与 Embed（L1–7）

无名包。import `MovieClip` + `TextField`。`public dynamic class key_set_dialog_mc extends MovieClip`。[Embed] `symbol="symbol44"`。

### 字段（L10–14）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L10 | `ct_keyname` | `MovieClip` | 键英文名容器 |
| L12 | `ct_msg` | `MovieClip` | `"PUSH A KEY FOR"` 容器 |
| L14 | `txt` | `TextField` | 中文提示 |

### 构造 `key_set_dialog_mc()`（L16–19）

- L18: `super();`
- 无 `addFrameScript`。显隐 / 文案全是 `SetBtnDialog.show/hide`。
