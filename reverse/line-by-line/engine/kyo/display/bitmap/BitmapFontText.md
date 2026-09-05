# `BitmapFontText` — 位图字体 Bitmap

一句话目的：拿一份 `BitmapFont`，`text=` 时 `translate` 出图贴到自身。菜单英文、设置项、对话框英文、结算分数都是它。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFontText.as`（66 行）

## Callers / callees

- **Callers**（均 `AssetManager.I.getFont("font1")`）：
  - `MenuBtn`（造完立刻 `visible=false`，屏幕上看中文 `BitmapText`）
  - `SetBtn` 标签 + 选项
  - `SetBtnDialog` 两行
  - `KeyMapping` 键帽字（再套灰度滤镜）
  - `AlertUI` / `ConfrimUI` 英文
  - `WinnerState` / `CongratulateState` / `GameOverState` 分数行
- **Callees**：`BitmapFont.translate`、`ColorTransform`。
- **销毁**：多数 UI 不调 `dispose`。`MenuBtn.dispose` 不碰 `_bitmapText`（反正 visible false）。换 text 不 `dispose` 旧 `bitmapData`。

## 逐行说明

### 字段（L11–15）

- `_font`：构造注入，不可换。
- `_text`：当前字符串。
- `_orgBitmapData`：`colorTransform` 第一次染色前的备份。

### 构造（L17–21）

`(font)`。`super(null, "auto", true)`：无初始位图、像素吸附 auto、smoothing true。随后 setter 再设一次 smoothing。

### `text` getter（L23–26）

返回 `_text`。未赋值是 `undefined`，不是 `""`。

### `text` setter（L28–35）

1. 记下字符串。
2. `bitmapData = _font.translate(param1)`。旧 `bitmapData` **不 dispose**。频繁改字（SET ALL 键名）会漏 BitmapData。?
3. `smoothing = true`。
4. `width = bitmapData.width`：把显示宽钉成像素宽（scaleX=1）。**不**设 height。父级用 `width` 做水平居中（`x = -width/2`）。

`translate` 对空串：量宽 0，`new BitmapData(0, h)` 在部分运行时抛。调用方都先有字。

### `colorTransform`（L37–52）

`param1 == null`：若有备份，`dispose` 当前图，`bitmapData = _orgBitmapData.clone()`（备份留下）。无备份则空 return。

非 null：第一次把当前图 clone 进 `_orgBitmapData`，再 `bitmapData.colorTransform(整矩形, param1)`。**原地改当前图**，不是改备份。连续两次染色会叠在已染色图上；要换色应先 null 还原。本包 UI 没用这个方法（`KeyMapping` 走 `filters`）。

### `dispose`（L54–62）

备份 dispose + null。然后 `bitmapData.dispose()`。无空守卫。本包调用稀少。
