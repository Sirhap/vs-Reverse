# `FloorVO` — 地图平台线段

一句话目的：一条水平落地台。只存 `xFrom..xTo` 与高度 `y`，`hitTest` 给角色脚底一个厚度带做落点判定。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/map/FloorVO.as`（28 行）

## Callers / callees

- **Callers**：
  - `MapMain.initFloor`：对 `floor` 层每个子 DisplayObject `new FloorVO()`，写入 `xFrom/xTo/y`。
  - `MapMain.getFloorHitTest(x, y, thickness)`：遍历 `_floors`，命中即返回该 VO。
  - `GameLogic.isInAir`：先查 `_floorContact[sprite]` 缓存的 VO 是否仍 `hitTest`；否则 `_map.getFloorHitTest`。命中则 `sprite.y = floor.y` 视为着地。
- **Callees**：无。纯数据。
- 不实现 `IGameSprite`，不进渲染列表。

## 命名备注

- `xFrom` / `xTo`：世界 X 开区间，左小右大。`MapMain` 用 `floor容器.x + child.x` 与 `+ child.width`。
- `y`：台面世界 Y（已加过 `initlize` 的底对齐偏移）。角色着地时 `y` 被直接赋成这个值。
- 无 `id`、无厚度字段；厚度是 `hitTest` 的第三个参数。

## 逐行说明

### 字段（L6–10）

`y = 0`、`xFrom = 0`、`xTo = 0`。全 public，无 getter。

### 构造（L12–15）

空 `super()`。

### `toString`（L17–20）

`"FloorVO::{xFrom:" + xFrom + ",xTo:" + xTo + ",y:" + y + "}"`。调试用，运行路径未见调用。

### `hitTest`（L22–25）

签名：`hitTest(param1:Number, param2:Number, param3:Number) : Boolean`

- `param1` = 角色 `x`
- `param2` = 角色 `y`
- `param3` = 半厚度（竖直容差）

条件（全部为**开区间**）：

```
param2 > y - param3 && param2 < y + param3 && param1 > xFrom && param1 < xTo
```

即脚点在 `[y-thickness, y+thickness]` 带内，且严格落在台面水平范围内。贴在 `xFrom`/`xTo` 端点上不算。

`GameLogic.isInAir` 传入的 thickness = `10 * GameConfig.SPEED_PLUS_DEFAULT`（60fps 时 5）。另外：若 `getVecY() < 0`（上升）根本不测地板；若 `getVecY() >= 5*SPEED_PLUS` 下落过快也不粘台（视为仍在空中）。已缓存的 VO 一旦 `hitTest` 失败就 `delete _floorContact` 并立刻判空中，同一帧不再搜其它台。
