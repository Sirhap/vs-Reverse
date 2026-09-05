# `select_map_txt_mc` — 地图名条底图

一句话目的：选地图层底部的空名牌。无子件、无脚本。`GameUI.SHOW_CN_TEXT`（默认 true）才实例化，上面再挂一份描边 `BitmapText` 写 `MapVO.name`。

源文件：`decompiled/ui/select/scripts/select_map_txt_mc.as`（14 行）

## 如何挂上引擎

[`MapSelectUI.build`](../../../engine/game/bvn/ui/select/MapSelectUI.md)：

1. 仅 `SHOW_CN_TEXT` 时 `createDisplayObject(ResUtils.I.select, "select_map_txt_mc")` → `_txtmc`。
2. 水平居中，`y = GAME_SIZE.y - height - 35`。
3. `new BitmapText(true, 0xFFFFFF, [GlowFilter(0,1,3,3,3)])`，`UIUtils.formatText` 白 14 居中，`width = _txtmc.width`，`_txtmc.addChild(_txt)`。
4. `showMap` 写 `_txt.text = MapVO.name`（XML `@name`，如「现世」「随机场景」）。

`SHOW_CN_TEXT=false` 整条不建，地图只剩 [`select_map_mc`](select_map_mc.md) 预览。`destory` 只 `_txt.destory()`，不单独 destory 本 MC。

SWF：`select`，链接名 `select_map_txt_mc`，`symbol="symbol90"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class select_map_txt_mc extends MovieClip`。[Embed] `symbol="symbol90"`。

### 无字段

没有 `public var`。名牌图在时间轴里，字是引擎 `addChild` 的 `BitmapText`。

### 构造 `select_map_txt_mc()`（L9–12）

- L11: `super();`
- 无 `addFrameScript`。
