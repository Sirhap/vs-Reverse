# `Box` — 实心矩形 Sprite

一句话目的：构造时 `graphics.drawRect` 一块填充。对话框半透明黑底、快速转场上下闸门。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/shapes/Box.as`（19 行）

## Callers / callees

- **Callers**：
  - `AlertUI`：`new Box(GAME_SIZE.x, 400, 0, 0.8)` 全宽、高 400、黑、alpha 0.8。
  - `ConfrimUI`：同色，高 300。
  - `QuickTransUI`：上下各 `new Box(GAME_SIZE.x, _center)` —— 默认色 0、alpha 1，不透明黑闸。
- **Callees**：`Sprite.graphics`。

## 逐行说明

### 构造（L8–16）

`(width, height, color=0, alpha=1, origin=null)`。

`beginFill(color, alpha)`。矩形原点：

- `origin` 空：从 (0,0) 画 `width×height`。调用方都走这条。
- 有 `Point`：从 `(-origin.x, -origin.y)` 画，把锚点移到 origin。

`endFill()`。之后不再改 graphics。尺寸变化靠 `scaleX/Y` 或 `TweenLite` 动 `y`（`QuickTransUI`）。
