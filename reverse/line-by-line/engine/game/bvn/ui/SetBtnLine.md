# `SetBtnLine` — 设置行高亮金线 + 右对齐中文

一句话目的：`SetBtn` 悬停时贴在英文标签底下的下划线。金线按行宽从 0.1 倍 tween 到满宽；`GameUI.SHOW_CN_TEXT` 为真时右侧再画一行楷体说明（`cn` 或 `cn - 档.cn`）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnLine.as`（59 行）

## Callers / callees

- **Callers**：仅 `SetBtn`。构造里 `new SetBtnLine()` + `hide()`。`hover` → `updateLine` → `show(width, 文案)`；`hoverOut` → `hide()` 并 `removeChild`。`changeOption` 也会 `updateLine`（档变了刷新「中文 - 档名」）。
- **Callees**：`TweenLite`（只 tween `_line.scaleX`）；`UIUtils.formatText`（同包）；`GameUI.SHOW_CN_TEXT`（默认 true）。颜色字面量 `16641381` = `0xFDED65`（金黄），线和字同一色。

无 `destory`。随 `SetBtn` 一起丢。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `_line` | 空 `Sprite`，`graphics` 画 1px 金线 |
| `_txt` | 可选。`SHOW_CN_TEXT==false` 则整份中文不建 |
| `16641381` | `0xFDED65`。`AlertUI`/`ConfrimUI` 不用这个色，只有本线 |

`SetBtn.updateLine` 文案规则：有当前 option → `cn + " - " + option.cn`（如 `"电脑等级 - 正常"`）；否则纯 `cn`（`"应用"`）。

## 逐行说明

### 字段（L10–12）

- `_txt:TextField`：可能 null。
- `_line:Sprite`：线本身。tween 的是它的 `scaleX`，不是本对象。

### 构造（L14–31）

1. `mouseChildren = mouseEnabled = false`：点穿到底下的 `SetBtn` / 箭头。Group 的 click 才能读到 `target.name == "prevArrow"`。
2. `new Sprite()` 作 `_line`，`addChild`。此时还没 `graphics`，`show` 才画。
3. `GameUI.SHOW_CN_TEXT`（静态，默认 true）：
   - `new TextField()`。
   - `UIUtils.formatText`：`color=16641381`，`size=20`，`font="楷体"`，`align="right"`。`LOCK_FONT` 若被壳设置会覆盖 font。
   - `y = 4`（线在 y=0，字略偏下）。
   - `addChild(_txt)`。
4. 假则 `_txt` 保持 null，`show`/`hide` 跳过字。

### `show`（L34–46）

`param1` 线宽（`SetBtn.width`），`param2` 中文。

1. `_line.graphics.clear()` 后 `lineStyle(1, 16641381, 1)`，`lineTo(param1, 0)`。从 (0,0) 画到 (width, 0)。默认 `moveTo` 在原点。
2. `_line.scaleX = 0.1`，`TweenLite.to(_line, 0.3, {scaleX:1})`。默认注册点在左，所以从左边长出来。重复 `hover` 同一行会再清再画再 tween；`SetBtn.hover` 每次 `addChild(_line)` 但不先判「已经 hover」，Group 的 `setArrowIndex` 同 index 会提前 return，所以正常不会连刷。
3. `this.visible = true`。
4. 有 `_txt`：`width = param1`（右对齐的计算框），`text = param2`。**不**改 `height` / `wordWrap`。超长中文可能画出框。?

不杀上一次没跑完的 `TweenLite`。快速换行时旧 tween 仍可能改已换文案的 `_line.scaleX`。?

### `hide`（L49–55）

`visible = false`。有 `_txt` 则 `text = ""`。不 `clear` 线、不 `TweenLite.killTweensOf`。下次 `show` 会 `graphics.clear`。
