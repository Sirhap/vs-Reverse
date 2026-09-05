# `SetBtn` — 设置/通用列表单行（标签 + 可选左右档）

一句话目的：`SetBtnGroup` 的一行。要么是纯确认项（APPLY / BACK / YES），点了派 `"SELECT"`；要么带 `options` 左右拨档，改值派 `"OPTION_CHANGE"`（`optionKey` + `optionValue`）。高亮时底下拉一条 `SetBtnLine` 中文说明。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtn.as`（202 行）

## Callers / callees

- **Callers**：仅 `SetBtnGroup.addBtn`。`new SetBtn(英文label, 中文cn)`；有 options 再 `setOption` + 听 `"OPTION_CHANGE"`，否则听 `"SELECT"`。`setBtnData` 把数据里的 **`optoinKey`** 抄到本类的 `optionKey`，并用 `optionValue` / `ConfigVO.getValueByKey` 调 `setOptionByValue`。
- **监听本类事件**：`SetBtnGroup.onSelect` / `onChangeOption` 再 `newEvent()` 往上抛。最终：`SettingState`（主列表 APPLY / 键位项 / 改档）、`SetCtrlBtnUI`（SET ALL / SET DEFAULT / APPLY / CANCEL）、`PauseDialog`、`AlertUI`、`ConfrimUI`、`CreditsState`、`CongratulateState`、`MoveListSp`。
- **Callees**：`BitmapFontText(font1)`；`SetBtnLine`；`ResUtils.I.setting` 的 `txt_arrow_mc`（左右三角）；`SetBtnEvent`；`SoundCtrl.I.sndConfrim` / `sndSelect`。

本类 **extends Sprite**（和 `MenuBtn` 不同），自己就是显示对象，Group 直接 `addChild(this)`。鼠标事件走原生 `Sprite.addEventListener`，Group 的 `mouseHandler` 吃 `MouseEvent`。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `optionKey` | 本类字段拼写正确。对应 `ConfigVO` 字段名 |
| `optoinKey` | **数据侧**拼错。`SetBtnGroup.initMainBtns` / `setBtnData` 读这个再赋给 `optionKey` |
| `onSelect` | 可选回调。默认菜单不用；自定义 `getSettingMenu()` 项可带 `select:Function` |
| `_cn` | 中文说明，只给 `SetBtnLine` 用，不画在本 Sprite 上（英文位图字才是行标签） |
| `sndConfrim` | confirm 的原拼写 |
| `destory` | 只 `dispose` 了英文 `_label`，箭头 / `_optionTxt` / `_line` 不收 |

行结构（有 options 时，x 从左到右）：

```
[_label 英文]  +50px  [< prevArrow]  +10  [_optionTxt]  +10  [nextArrow >]
                 y=17                     当前档 label
_line 在 _label.height 处，宽度=整行 width
```

`nextArrow.scaleX = -1`，两个都是同一 `txt_arrow_mc`，朝右的那个水平翻转当「下一档」。

## 逐行说明

### 字段（L13–31）

- `optionKey:String`：改档时写进 `SetBtnEvent.optionKey`。无 options 的行也会被 `initMainBtns` 赋成 `undefined`（数据没这个键）。
- `onSelect:Function`：`SetBtnGroup.onSelect` 在 redispatch 之前调。
- `_label`：英文位图字，`label` getter 返回它的 `.text`。
- `_options:Array`：`{label, cn, value}`。纯确认项保持 `null`。
- `_optionIndex`：AS3 int 默认 0。
- `_optionTxt`：当前档的英文 `label`。
- `_prevArrow` / `_nextArrow`：类型 `txt_arrow_mc`（setting SWF 导出）。
- `_line:SetBtnLine`：构造里就 `new`，默认 `hide()`。
- `_cn`：中文，Line 文案用。

### 构造（L33–45）

`param1` 英文，`param2` 中文。

1. `buttonMode = true`（手型）。不关 `mouseChildren`：有 options 时要点到箭头的 `name`。
2. `font1` 位图字，`text = param1`。
3. `new SetBtnLine()`，`y = _label.height`（贴在英文下面），`hide()`，先 `addChild(_line)` 再 `addChild(_label)`（字在线上面）。

构造 **不**建箭头；没 options 的行永远没有三角。

### `label` getter（L47–50）

`_label.text`。`SetBtnEvent.selectedLabel` 用这个，所以监听方 case 的是 `"APPLY"` / `"P1 KEY SET"` / `"BACK"` 这种英文，不是 `cn`。

### `destory`（L52–57）

只 `_label.dispose()`。不卸事件（Group 卸）、不 `dispose` `_optionTxt`、不丢箭头、不处理 `_line`。多次 `setBtnData` 会丢一批旧 `SetBtn` 引用，这些泄漏。本包各调用方通常只 `setBtnData` 一次。

### `hover`（L60–64）

`updateLine()` 后 `addChild(_line)`（提到最前，并保证在显示列表）。Group 的 `setArrowIndex` 对当前行调这个。

### `updateLine`（L66–76）

有当前 option 则 `line.show(width, cn + " - " + option.cn)`，否则 `line.show(width, cn)`。`width` 是整行（含箭头和档文字）的显示宽度，Line 按这个拉金线。

无 options 时 `getOption()` 返回 null，走纯 `cn`（「应用」「返回」等）。

### `hoverOut`（L79–88）

`_line.hide()`，`try removeChild(_line)`。Line 还活在对象上，下次 `hover` 再加回来。

### `select`（L91–96）

`new SetBtnEvent("SELECT")`，`selectedLabel = label`，`dispatchEvent`。然后 `sndConfrim()`。

**不管有没有 options 都派 SELECT。** Group 只给无 options 的行挂了 SELECT 监听，所以键盘在 COM LEVEL 上按确认：音效响、事件发出、**没人收**。鼠标 click 对有 options 的行根本不调 `select()`（只点箭头才 `prev/nextOption`）。

`bubbles` 默认 false，不冒泡。

### `setOption`（L99–114）

`param1` = options 数组。只应调一次（再调会再 `addChild` 一套箭头）。

1. 存 `_options`。
2. 两枚 `txt_arrow_mc`：`name = "prevArrow" / "nextArrow"`。`nextArrow.scaleX = -1`。两者 `y = 17`。
3. `new BitmapFontText(font1)` 作 `_optionTxt`。
4. `addChild` 左箭头、右箭头、档文字。
5. `updateOption()` 排 x、填字。

不在这里设 `_optionIndex`（保持 0 = 第一档），也不派 `OPTION_CHANGE`。

### `getOption`（L117–123）

无 `_options` 返回 `null`，否则 `_options[_optionIndex]`。越界不保护。

### `nextOption` / `prevOption`（L126–153）

无 options 则 return。下标 ±1，两端环绕。然后 `changeOption(newIndex)`（默认派事件）+ `sndSelect()`。

键盘：竖排时左右键走这两条。触摸：第二次点同一行走 `nextOption`（只能往后拨，不能往前）。鼠标：点对应箭头。

### `setOptionByValue`（L156–169）

按 `option.value == param1` 找下标，找到则 `changeOption(i, false)`（**不**派 `OPTION_CHANGE`，避免初始化把 Config 再写一遍）。找不到则保持 0，无日志。?

`==` 比较。档值有 Number（`0.5`/`1`）和 String（`"low"`）。`ConfigVO.getValueByKey` 类型需与档 `.value` 一致。

### `changeOption`（L172–189）

`param1` 新下标，`param2` 是否派事件（默认 true）。

1. `_optionIndex = param1`。
2. `updateOption()` + `updateLine()`（高亮文案跟着变）。
3. `param2` 真：`new SetBtnEvent("OPTION_CHANGE")`，取当前 option，写 `optionKey`（本对象字段）和 `optionValue = option.value`，`dispatchEvent`。当前 option 空则不派。

`SettingState.onOptionChange` 立刻 `ConfigVO.setValueByKey`。音量键会马上改 `SoundCtrl`；画质要等主列表 APPLY 的 `applyConfig`。

### `updateOption`（L192–198）

`_optionTxt.text = getOption().label`。无 option 时这里 NRE；只在 `setOption` 之后走。

排 x：

- `_prevArrow.x = _label.x + _label.width + 50`
- `_optionTxt.x = prev + 10`
- `_nextArrow.x = optionTxt.x + optionTxt.width + 10`

`_label.x` 默认 0。档文字变宽（`"VERY HARD"` vs `"EASY"`）时右箭头跟着挪。不重排 Line 宽度——`updateLine` 的调用方（`changeOption` / `hover`）会用新 `width` 重画。
