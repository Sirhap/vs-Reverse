# `BitmapText` — TextField 光栅化成 Bitmap

一句话目的：内部藏一个 `TextField`，改字/字号/颜色后 `draw` 成 `BitmapData`。菜单中文、选人中文名走这条；英文大字走 `BitmapFontText`。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/BitmapText.as`（198 行）

## Callers / callees

- **Callers**：
  - `MenuBtn`：中文标签 `new BitmapText()`，`UIUtils.formatText` 黑体 28 白字。
  - `SelectedFighterUI` / `MapSelectUI`：`new BitmapText(true, 0xFFFFFF, [GlowFilter(0,1,3,3,3)])`。
- **Callees**：`TextField` / `TextFormat` / `BitmapData.draw` / `applyFilter`。
- **销毁**：`SelectedFighterUI.destory` 调 `BitmapText.destory`（本类方法名就是 `destory`）。

## 命名备注

- `destory`：destroy 的原拼写。
- `_filers`：filters 的原拼写。构造第三参，只在 `update` 里 `applyFilter`。
- 继承 `Bitmap`。覆盖 `width`/`height` setter 只改内部 TF，**不**改 Bitmap 尺寸（尺寸由 `bitmapData` 决定）。

## 逐行说明

### 字段（L13–17）

- `autoUpdate`：setter 里是否立刻 `update()`。默认 true。
- `_tf`：离屏 TextField，从不 `addChild`。
- `_filers`：滤镜数组，可为 null。

### 构造（L20–28）

`(autoUpdate=true, color=0, filters=null)`。`smoothing = true`。`new TextField()`，再 `this.color = param2`（会走 color setter；`autoUpdate` 已赋，空字也会 `update` 一次）。

默认 TF 宽 100、高 100（Flash 默认）。第一次 `update` 画 110×(textHeight+10) 的透明图。

### `width` / `height` setter（L30–38）

只写 `_tf.width` / `_tf.height`。不 `update`。随后改 `text` 才会重画。`Bitmap.width` 本身被盖掉，外部 `bt.width = 200` **不会**拉伸位图，只改 TF 排版宽。

### `textfield`（L40–43）

暴露 `_tf`。`UIUtils.formatText` 拿它设 `TextFormat`。

### `font` / `fontSize` / `color`（L45–86）

读写 `defaultTextFormat` 对应字段。setter 在 `autoUpdate` 时 `update()`。

`color` getter：`defaultTextFormat.color as uint`。TF 默认 color 可能是 `null`（转 0）。

### `align`（L87–95）

读写 `defaultTextFormat.align`。**不** `autoUpdate`。改对齐后要自己 `update` 或再改一个会触发的属性。?

### `text`（L97–109）

读写 `_tf.text`。setter `autoUpdate` → `update()`。

### `setTextFormat`（L111–118）

转发 TF，范围默认 -1,-1（整段）。`autoUpdate` → `update()`。

### `defaultTextFormat`（L120–136）

getter：若 `_tf.defaultTextFormat` 空则 `new TextFormat()` 写回去。setter 写 TF，`autoUpdate` → `update()`。

`UIUtils.formatText` 通常直接改 `textfield.defaultTextFormat` 再 `setTextFormat`。本类 getter 返回的是 TF **引用**；`MenuBtn` 经 `UIUtils` 改字段后，若没走本类 setter，要靠随后的 `text = ...` 触发重画。

### `textWidth` / `textHeight`（L138–156）

名字像度量，实际读写 **`_tf.width` / `_tf.height`**（排版框），不是 `TextField.textWidth`。?

### `update`（L158–181）

1. `_tf` 空则 return。
2. `_tf.height = textHeight + 10`（度量 + 10px 余量，避免裁字）。
3. 再把 `defaultTextFormat` 赋回 TF（部分 FP 版本改 default 不影响已有字）。
4. `new BitmapData(tf.width+10, tf.height, true, 0)` 透明。
5. `draw(_tf)`。TF 默认不 embed，设备缺「黑体」会回退。
6. `_filers` 非空：逐个 `applyFilter` 整图。Glow 可能被 `width+10` 裁边。
7. 旧 `bitmapData.dispose()`，换新的。

每次改字都新分配 BitmapData。菜单 hover 不改字，只改 ColorTransform，不走这里。

### `destory`（L183–194）

`try parent.removeChild(this)` 吞错。然后 `bitmapData.dispose()`，`_tf = null`。**不**清 `_filers`。`bitmapData` 已空再调会抛，无守卫。
