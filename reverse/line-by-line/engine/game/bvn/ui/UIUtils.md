# `UIUtils` — 中文 TextField 默认格式

一句话目的：给系统 `TextField` 套默认字体「黑体」，可选 `LOCK_FONT` 覆盖，再调平台钩子 `formatTextFunction`。位图字（`BitmapFontText` / font1）不走这里。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/UIUtils.as`（41 行）

## Callers / callees

- **Callers**（均 `formatText(tf, {…})`）：
  - `MenuState.afterBuild`：右下角版本 `"V3.3-REV"`（黑字 18px）。
  - `AlertUI.build`：中文说明，白 20px、居中、`leading:10`。
  - `ConfrimUI.build`：中文说明，白 20px、居中（无 leading）。
  - `SetBtnLine`：按钮下方中文（`SHOW_CN_TEXT` 才建）。
  - `MenuBtn`：菜单钮中文。
  - `SelectedFighterUI` / `MapSelectUI`：选人/选图中文名。
- **Callees**：`flash.text.TextFormat`；`KyoUtils.setValueByObject` 把 `{align,color,size,leading,…}` 写进 `TextFormat`。
- **钩子写入**：本包 **从不** 给 `formatTextFunction` / `LOCK_FONT` 赋值。留给壳/平台（例如换字体）。`DEFAULT_FONT` 也无外部改写。

## 命名备注

无 `destory`。构造空，当静态工具类用。`formatText` 只设 `defaultTextFormat`，**不** `setTextFormat`；调用方都是先 format 再赋 `.text`，Flash 会用 default。若对已有文字的 TF 再 format，已画的字可能不变，? 本包无此顺序。

## 逐行说明

### 静态字段（L10–14）

- `formatTextFunction:Function`：`(TextField) → void`。非空则在设完 format 后调用，可再改 embed/滤镜等。
- `DEFAULT_FONT = "黑体"`。
- `LOCK_FONT = null`：非空则 **覆盖** 调用方传入的 `font`（以及 DEFAULT）。先 `setValueByObject` 再锁，所以对象里写 `font` 也无效。

### 构造（L16–19）

空 `super()`。无实例用法。

### `formatText`（L21–39）

`(tf:TextField, style:Object = null)`。

1. `style` 非空：`new TextFormat()`，`font = DEFAULT_FONT`，`KyoUtils.setValueByObject(tfFormat, style)`（`align`/`color`/`size`/`leading` 等 TextFormat 公开字段），若 `LOCK_FONT` 再强制 `font`。`tf.defaultTextFormat = tfFormat`。
2. `style` 空：跳过 TextFormat，仍可能走钩子。
3. `formatTextFunction != null` 则 `formatTextFunction(tf)`。

`AlertUI` 的 style 含 `leading:10`（多行更新说明）；`ConfrimUI` 没有。颜色字面量 `16777215` = 白。不设 `embedFonts`；「黑体」依赖系统字体，缺字体时 Flash 回退，? 视播放器。
