# `BitmapFont` — BMFont XML + 图集

一句话目的：解析 AngelCode BMFont XML，按 char id 切图，把字符串拼成一张 `BitmapData`。本游戏只有 `font1`。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFont.as`（163 行，含内部 `InsCharVO`）

## Callers / callees

- **构造**：`BitmapFontLoader.addFont` / `loadBitmapData` 完成回调。
- **`translate`**：仅 `BitmapFontText.text` setter。
- **字段写入**：`AssetManager.initAssets` 对 `font1` 设 `charGap=-8`、`spaceGap=10`、`offsetY=-5`。
- **Callees**：`BitmapData.copyPixels`。内部类 `InsCharVO`。

## BMFont 约定

XML 形如：

```xml
<font>
  <info face="font1" size="..."/>
  <pages><page file="font1.png"/></pages>
  <chars>
    <char id="65" x=".." y=".." width=".." height=".." xoffset=".." yoffset=".." xadvance=".."/>
  </chars>
</font>
```

`id` 是 Unicode 码点。AS3 动态 Object 的键会把数字/字符串互相强制，`_fontCache[65]` 与 `_fontCache["65"]` 同一槽。

## 逐行说明

### 字段（L9–26）

- `charGap` / `spaceGap` / `offsetX` / `offsetY`：拼字间距与整体平移。默认全 0。
- `_source`：整张图集，不拷贝，外部 `dispose` 会废掉所有字。
- `_fontCache`：`id → InsCharVO`。
- `_charWidth`：`info.@size`（字号，不是每字宽）。缺字空格用它。
- `_charHeight`：所有 char 的最大 `height`。输出图高度。
- `_yOffsetMin`：初始 999，取最小 `yoffset`，用来把字形顶对齐。

### 构造（L28–49）

`(xml, bitmapData)`。扫 `param1.chars.char`：

1. `new InsCharVO(xml)`。
2. 刷新 `_charHeight` 最大值。
3. 刷新 `_yOffsetMin` 最小值。
4. `_fontCache[id] = vo`。

空字体：`_charHeight` 默认 0（int），`translate` 会 `new BitmapData(width, 0)` —— FP 对 0 高可能抛。本游戏 font1 有字。

### `translate`（L51–102）

`param1` 要画的字符串。返回新 `BitmapData`（调用方持有，本类不缓存整句）。

**量宽**（L61–86）：

- `charCodeAt`。空格（32）且 `spaceGap` 真：只加 `spaceGap`，不进绘制列表。`AssetManager` 设了 `spaceGap=10`，走这条。
- 否则 `getChar`。缺字：若是空格（`spaceGap==0` 时落到这里）加 `_charWidth+charGap`；其它缺字 **静默跳过**。
- 命中：记下 `vo.x = 当前笔`，笔 `+= width + charGap`，推进绘制列表。

`charGap < 0`（font1 = -8）：总宽最后减回一个 gap，避免末尾多裁。

**绘制**（L91–100）：

`new BitmapData(总宽, _charHeight, true, 0)`。每位：

- 源矩形 `(sx, sy, width, height)`。
- 目标点 `(vo.x + offsetX, vo.y + (yoffset - _yOffsetMin) + offsetY)`。`vo.y` 构造默认 0，从未写入。
- `copyPixels(..., mergeAlpha=true)`。

**不用 `xadvance` / `xoffset`**。字距完全靠 `width + charGap`。BMFont 的 kerning 也不读。

输出图每次新分配。`BitmapFontText` 把旧 `bitmapData` 直接替换，**不** `dispose` 旧图（见那边）。

### `getChar`（L104–112）

缓存命中则 **`clone()`** 再返回（避免量宽时写 `vo.x` 污染原型）。未命中 null。

---

## 内部类 `InsCharVO`（L116–162）

包外不可见（无 `package`）。一个字符的图集矩形 + 偏移。

### 字段

`x/y`：拼字时的目标位置（`translate` 写 `x`）。`id` 是 **String**（XML 属性）。`sx/sy/width/height` 图集矩形。`xoffset/yoffset/xadvance` 从 XML 读，本类 `translate` 只用 `yoffset`。`_xml` 留给 `clone`。

### 构造（L141–156）

`(xml=null)`。有 XML 则把 `@id/@x/@y/@width/@height/@xoffset/@yoffset/@xadvance` 读成字段。AS3 XML 属性是 String，赋给 int 会 `Number(...)`。

### `clone`（L158–161）

`new InsCharVO(this._xml)`，重读 XML。不拷 `x/y`（新实例默认 0）。
