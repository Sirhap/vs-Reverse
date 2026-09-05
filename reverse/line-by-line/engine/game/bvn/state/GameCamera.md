# `GameCamera` — 战斗镜头跟随与缩放

一句话目的：对 `_gameLayer` 写 `scrollRect` + `scale`，跟 1～N 个焦点（或一个点），可选按双人距离 autoZoom，并用 `_fbR` 夹舞台边界。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/GameCamera.as`（334 行）

## Callers / callees

- **Callers**：
  - `GameState.initCamera`：唯一构造点 `new GameCamera(_gameLayer, GAME_SIZE, stageSize, true)`，并设 `focusX/Y`、`offsetY`、`setStageBounds`、`autoZoom*`、`tweenSpd`、初始 `setZoom(2)`/`setX`/`setY`/`updateNow`。
  - `GameState.initFight` / `cameraFocusOne` / `cameraResume` / `render` / `getGameSpriteGlobalPosition`。
  - `GameCtrl.slow`：`tweenSpd = 2.5 * slowFactor`；`slowResume`：`tweenSpd = 2.5`（**不**除 `SPEED_PLUS_DEFAULT`，与 `GameState` 的 `2.5/SPEED_PLUS_DEFAULT` 不一致）。
  - `GameStartCtrl`：`camera.updateNow()` 让 intro 特写无缓动到位。
  - `GameLogic.initGameLogic(map, camera)` 存静态 `_camera`；`fixGameSpritePosition` 用 `getZoom()` + `getScreenRect()`（都是 **false** 默认，即无缓动目标矩形）在最小缩放时把角色夹在可见区内。
- **Callees**：仅 Flash `DisplayObject` / `Point` / `Rectangle`。不 import `GameConfig`。`CAMERA_TWEEN_SPD = 2.5` 是调用方的字面约定，本类只看到 `tweenSpd` 字段。

本包无 `camera.move` / `moveCenter` 调用（死 API）。

## 命名备注

- `tweenSpd:int`：大于 1 时每帧 `current += (target - current) / tweenSpd`，类似「剩余距离 / N」。**不是**像素/秒。`GameState` 赋 `2.5 / 0.5 = 5`（60fps）；类型 int 会截断小数。
- `tweenSpd <= 1`（含 0）：跳变，无缓动。`updateNow` / `focus(..., true)` 临时置 0 再 `render`。
- `_zoom`：目标倍率。`_stageScale`：当前（缓动）倍率。`getZoom(false)=_zoom`，`getZoom(true)=_stageScale`。
- `_rect`：缓动中的 `scrollRect`。`_noTweenRect`：目标矩形（无缓动）。`getScreenRect(true)=_rect`。
- `_fbR`：边界夹紧矩形。**`width`/`height` 被当成 maxX/maxY**，不是尺寸。仅构造 `param4=true` 时分配；`GameState` 传 true。
- `focusX` 默认 true；`focusY` 默认 **false**，`GameState.initCamera` 显式改 true。

## 坐标系

Flash：`scrollRect = (x,y,w,h)` 裁剪对象本地坐标，再画 `scaleX/Y`。

可见世界宽 ≈ `_screenSize.x / _stageScale`（800/zoom）。`setZoom` 把 `_noTweenRect` 的 w/h 设成 `screen / _zoom`，并把 `_foffsetX/Y` 设成半屏世界长度，用来把焦点放到画面中心。

`applySet`：`_stage.scrollRect = _rect`；`_stage.scaleX = scaleY = _stageScale`。显示宽度 = `rect.w * scale` ≈ 800。

## 逐行说明

### 字段（L10–50）

| 字段 | 含义 |
|------|------|
| `tweenSpd` | 缓动分母，int |
| `stageSize` | 地图世界尺寸（`MapMain.getStageSize`） |
| `focusX/Y` | 是否跟 X/Y |
| `offsetX/Y` | 焦点额外偏移。Y 用 `getMapBottomDistance` 把地面抬进画面 |
| `autoZoom` / `Min` / `Max` | 双人距离自动倍率，默认 1～3；战斗改成 1～2.5 |
| `_zoom` / `_stageScale` | 目标 / 当前倍率，初值 1 |
| `_noTweenRect` / `_rect` | 目标 / 缓动裁剪框，尺寸初值为屏幕 |
| `_stage` | 被摄对象 = `_gameLayer` |
| `_stageBounds` | 世界可滚动范围 |
| `_focus` | `Array` of `DisplayObject` |
| `_point` | 跟焦点（双人中点，或 `move` 指定） |
| `_fbR` | 夹紧用；null 则不夹 |
| `_foffsetX/Y` | 半屏世界坐标（随 zoom 变） |
| `_screenSize` | 屏幕像素，`(800,600)` |

### 构造（L52–69）

```
param1: DisplayObject   被摄层
param2: Point           屏幕尺寸 → _rect/_noTweenRect/_screenSize
param3: Point = null    stageSize；null 则 setStageSizeFromDisplay
param4: Boolean = false  true 则 new _fbR（启用边界）
```

`setStageBounds()` 无参：`_stage.getBounds(_stage)`。`GameState` 随后立刻用显式 `Rectangle(0,-1000,w,h)` 覆盖。

若没传 `stageSize`，`setStageSizeFromDisplay` 在 `setStageBounds` **之前**跑，此时 `_stageBounds` 仍 null——`_stageBounds.x` 会炸。战斗路径总传 `stageSize`，此分支未走。

### `getScreenRect`（L71–74）

`param1=true` → 缓动中 `_rect`（`GameState.render` / 屏幕坐标换算）。`false` → 目标 `_noTweenRect`（`GameLogic.fixGameSpritePosition`）。

### `updateNow`（L76–82）

保存 `tweenSpd`，置 0，`render()` 一次，还原。开场 intro / `initCamera` 末尾用，避免从 (0,0) 滑入。

### `setStageBounds`（L84–95）

无参：`getBounds(self)`。有参：直接存。然后 `setZoom(_zoom)` 重算 `_fbR` 与半屏偏移。`GameState` 传入 `y=-1000` 给跳跃/特写留头顶。

### `setStageSizeFromDisplay`（L97–100）

`width/scaleX + bounds.x`。依赖已有 `_stageBounds`，与构造顺序冲突，战斗不用。

### `getZoom`（L102–105）

见上：true=当前 `_stageScale`，false=目标 `_zoom`。`GameLogic` 用 false 判断是否已到 `autoZoomMin`。

### `setZoom`（L107–121）—— 改目标倍率，不立刻改 `_stageScale`

```
_zoom = param1
_noTweenRect.w/h = screen / _zoom
_foffsetX/Y = (screen/2) / _zoom     // 焦点居中补偿
若 _fbR:
  x = bounds.x * _zoom               // 注意：minX 乘了 zoom
  y = bounds.y * _zoom               // 战斗：-1000 * zoom
  width  = bounds.width  - screen.x/_zoom   // 当 maxX 用
  height = bounds.height - screen.y/_zoom   // 当 maxY 用
```

`_fbR.x/y` 乘 zoom、`width/height` 不乘，单位不完全一致。战斗 `bounds.x=0` 所以 minX 总是 0，问题被盖住。minY = `-1000*zoom` 随放大变更负，特写时允许镜头上移更多。

`renderAutoZoom` / `cameraFocusOne(3.5)` / `initCamera(2)` 都走这里。`renderZoom` 另把 `_rect.w/h` 按 **`_stageScale`** 更新。

### `focus`（L123–135）

`_focus = array`。长度 >1 时 `_point = new Point()`（给 `renderTwo` 写中点）；否则 `_point = null`，`renderX/Y` 直接读 `_focus[0].x/y`。

`param2=true`：同 `updateNow`，立刻到位。本包调用都是 `focus(arr)` 默认 false。

### `move`（L137–141） / `moveCenter`（L143–147）

清 `_focus`，跟一个世界点 / 地图中心。随后 `render()` 会执行 `_focus.length` → **NPE**（L155 没判 `_focus`）。本包无调用，死代码。若要用应先 `if(_focus && _focus.length>1)`。

### `render`（L149–172）—— 每帧入口

```
无 _focus 且无 _point → return
_focus.length > 1 → renderTwo(first, last)   // 不是任意对，是首尾
focusX → renderX
focusY → renderY
_stageScale != _zoom → renderZoom
applySet()
```

双人时 `renderTwo` 先写 `_point` 中点并可能 `setZoom`；然后 `renderX/Y` 跟这个中点。单人 `_point` 为 null，跟 `_focus[0]`。

### `applySet`（L174–178）

写回显示对象。每帧都写，即使值没变。

### `renderTwo`（L180–236）—— 双焦点中点 + autoZoom

X：较小 x 为左、较大为右；`_point.x = 左 + 间距/2`。Y 同样。

`autoZoom`：

- 跟 X：`screen.x / dx * 0.8`（两人水平距离越大 zoom 越小；0.8 留边）
- 跟 Y：`screen.y / dy * 0.8`
- 取 `min(zx, zy)` 再 `renderAutoZoom`

`dx=0`（重叠）→ 除零 → Inf → 被 `autoZoomMax` 夹住。`dy=0` 同理。若只 `focusX` 不 `focusY`，`_loc11_` 保持 `_zoom`，`min` 仍合理。战斗两者都开。

只用 `_focus[0]` 与 `_focus[last]`。当前战斗数组恒为 `[p1display, p2display]`。

### `renderAutoZoom`（L238–249）

夹到 `[autoZoomMin, autoZoomMax]` 后 `setZoom`。每帧都 `setZoom`，即使值没变（重算 `_fbR`/`_foffset`）。

### `renderX`（L251–257） / `renderY`（L259–265）

焦点 = `_point` 若有，否则 `_focus[0]`。减 `_foffset + offset`，把焦点放到屏幕中心（再加 `offsetY` 地面补偿）。然后 `setX`/`setY`。

### `setX`（L267–289） / `setY`（L291–313）

有 `_fbR` 则夹：`param < _fbR.x/y` 取 min；`param > _fbR.width/height` 取 **max**（字段名是尺寸，语义是上限）。

写入 `_noTweenRect.x/y`。`tweenSpd > 1`：`_rect.x += (target - _rect.x) / tweenSpd`；否则直赋。

注意：夹的是**目标**世界坐标，缓动中的 `_rect` 仍可能过冲一帧。

`initCamera` 的 `setX(-(mapW-350))` 为负，夹到 0。`setY(-(bottom-200))` 很负，夹到 `-1000*zoom`。

### `renderZoom`（L315–331）

`_zoom <= 0` throw `"zoom 不能 <= 0 !"`。缓动 `_stageScale` 同 X/Y 公式。然后：

```
_rect.width  = int(screen.x / _stageScale + 1)   // +1 >> 0 = 向下取整(x+1)
_rect.height = int(screen.y / _stageScale + 1)
```

`+1` 避免缩放后露边缝。`>> 0` 是 AS3 廉价 `int()`。

`_noTweenRect` 的尺寸在 `setZoom` 已按目标 `_zoom` 设好；这里只更新缓动中的 `_rect`。

## 与 `GameState` 的默认参数对照

| 项 | 值 |
|----|----|
| 屏幕 | `(800, 600)` |
| stageSize | `(mapLayer.width, 600)` |
| bounds | `(0, -1000, mapW, 600)` |
| autoZoom | 1～2.5 |
| 跟焦 | X+Y |
| offsetY | `bottom - playerBottom` |
| tween | `2.5 / SPEED_PLUS_DEFAULT`（60fps → 5） |
| 特写 | zoom 3.5，单 focus |
| 开场 | zoom 2，`updateNow` |
