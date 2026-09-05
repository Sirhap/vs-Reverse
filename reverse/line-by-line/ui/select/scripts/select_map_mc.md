# `select_map_mc` — 选地图预览框

一句话目的：Vs / 训练选人向导最后一步的地图预览。五个命名子件：底 `bg`、图容器 `ct`、外框 `kuang`（点=确认）、左右箭头。逻辑全在 [`MapSelectUI`](../../../engine/game/bvn/ui/select/MapSelectUI.md)。

源文件：`decompiled/ui/select/scripts/select_map_mc.as`（24 行）

## 如何挂上引擎

`MapSelectUI.build`：`createDisplayObject(ResUtils.I.select, "select_map_mc")` 得到 `_mapmc`，`addChild` 到 `MapSelectUI`（再挂到 [`stg_select`](stg_select.md)）。街机 / 生存不进本 UI。

子件用法：

| 子件 | 引擎 |
|---|---|
| `bg` | 水平居中：`x = (GAME_SIZE.x - bg.width) / 2`（800 宽）。竖直 `y = GAME_SIZE.y * 0.25`（150）。只量宽度，不改 `bg` 自己 |
| `ct` | `ct.x -= 2` 像素微调。`showMap`：`ct.removeChildren()` 再 `addChild(getMapPic)`（默认 450×240，`_picCache` 复用） |
| `kuang` | `buttonMode=true`；听 `"mouseOver"`（只 `sndSelect`）+ `"click"` → `_confrimListener`（舞台 `mapConfrimHandler` → `select()`） |
| `left_arrow` | 同上，click → `_prevListener` → `prev()`（下标 −1，wrap） |
| `right_arrow` | click → `_nextListener` → `next()` |

`destory` 摘左右箭头和 `kuang` 的 `"mouseOver"` / `"click"`。键盘路径不经这些子件：舞台 `render` 直接 `prev/next/select`。

名条是另一导出 [`select_map_txt_mc`](select_map_txt_mc.md)，不是本 MC 的子件。

SWF：`select`，链接名 `select_map_mc`，`symbol="symbol100"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class select_map_mc extends MovieClip`。[Embed] `symbol="symbol100"`。

### 字段（L9–17）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `bg` | `MovieClip` | 量宽居中 |
| L11 | `ct` | `MovieClip` | 预览 Bitmap 容器 |
| L13 | `kuang` | `MovieClip` | 外框，点=确认 |
| L15 | `left_arrow` | `MovieClip` | 上一张 |
| L17 | `right_arrow` | `MovieClip` | 下一张 |

### 构造 `select_map_mc()`（L19–22）

- L21: `super();`
- 无 `addFrameScript`。交互全是引擎挂在子件上的鼠标监听。
