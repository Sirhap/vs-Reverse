# `SetBtnDialog` — 等按键对话框（`key_set_dialog_mc`）

一句话目的：键位页「SET ALL」时盖在 `keyset_mc` 上的提示框。英文行 `PUSH A KEY FOR <KEYNAME>`，中文行 `请按下一个键设置【…】`。**本类不监听键盘**；`SetCtrlBtnUI` 在 stage 上听 `"keyDown"`，用 `isShow` 当闸。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnDialog.as`（56 行）

## Callers / callees

- **Callers**：仅 `SetCtrlBtnUI`。构造里 `new SetBtnDialog()`，`ui.addChild(_dialog.ui)`。`setNextKey` → `show(英文名, 中文名)`；`onKeyDown` 写完一键后 `hide()`，再 `setNextKey`（下一键或结束）。
- **Callees**：`ResUtils.I.createDisplayObject(setting, "key_set_dialog_mc")`；`AssetManager.I.getFont("font1")` 两份 `BitmapFontText`；`ui.txt` 作为中文 `TextField`，楷体 20。

`destory`：本类没有。`SetCtrlBtnUI.destory` 也不丢 `_dialog`。键位页关掉靠 `SettingState.destoryInnerSetUI` 把整个 `keyset_mc` 从显示列表拿掉。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `ui:key_set_dialog_mc` | setting SWF 导出。子级约定：`ct_msg`（英文提示容器）、`ct_keyname`（键英文名容器）、`txt`（中文 TextField） |
| `isShow` | **默认 `true`**，但构造把 `ui.visible = false`。逻辑闸和可见性开场不一致 |
| `_pushTxt` | 固定 `"PUSH A KEY FOR"` |
| `_keyNameTxt` | `UP` / `ATTACK` / `SUPER SKILL` 等，来自 `KeyMapping.name` |
| `_cntxt` | `ui.txt`，中文「请按下一个键设置【cn】」 |

`KeyMapping` 的 `name`/`cn` 对照见 `SetCtrlBtnUI.md`（UP 上、…、SPECIAL 特殊）。

## 逐行说明

### 字段（L12–20）

- `ui`：根 MC。Group/页只 add 这个，不 add 本逻辑对象（本类 **不是** DisplayObject）。
- `isShow = true`：字段初始值。`SetCtrlBtnUI.onKeyDown` 开头 `if(!_dialog.isShow) return`。
- `_pushTxt` / `_keyNameTxt`：`font1` 位图字。
- `_cntxt`：中文 TextField 引用。

### 构造（L22–37）

1. `createDisplayObject(setting, "key_set_dialog_mc")`。
2. `ui.visible = false`（看不见，但 `isShow` 仍是 true）。
3. 两份 `BitmapFontText(font1)`，`y = -30`（反编译 `_temp_4`）。
4. `_pushTxt.text = "PUSH A KEY FOR"`，水平居中，丢进 `ui.ct_msg`。
5. `_keyNameTxt` 此时无 text，丢进 `ui.ct_keyname`。`show` 才填。
6. `_cntxt = ui.txt`，`defaultTextFormat = 楷体 20`。不走 `UIUtils.formatText`，也不看 `GameUI.SHOW_CN_TEXT`——中文行 **总是** 有（相对 `SetBtnLine` / `AlertUI`）。

开场 `isShow==true` 且 `visible==false`。`SET ALL` 的路径是：先 `stage.addEventListener("keyDown")`，再 `setNextKey` → `show()`（`isShow=true` 变得名副其实）。若在 `show` 之前漏进一个 keyDown，会按 `isShow` 当真去写 `_keyMappings[-1+1]`。`setNextKey` 紧跟在 addListener 之后，同一函数栈里，正常抢不到。?

### `show`（L40–46）

`param1` 英文键名，`param2` 中文。

1. `ui.visible = true`。
2. `_keyNameTxt.text = param1`，水平居中。
3. `_cntxt.text = "请按下一个键设置【" + param2 + "】"`。
4. `isShow = true`。

无 tween、不抢 focus（`SetCtrlBtnUI` 在 SET ALL 时 `stage.focus = stage`）。不关底下 `SetBtnGroup`——Group 的 `keyEnable` 已被 SET ALL 置 false，键盘确认不会误点 APPLY。

### `hide`（L49–53）

`ui.visible = false`；`isShow = false`。`onKeyDown` 随后立刻 `setNextKey`：有下一键会再 `show`（`isShow` 拉回 true）；没有则卸 `keyDown`。hide 与下一 show 之间若插进一个 keyDown，会被 `!isShow` 丢掉——避免把同一键写进下一动作。
