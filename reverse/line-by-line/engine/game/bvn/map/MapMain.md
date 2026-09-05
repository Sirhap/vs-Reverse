# `MapMain` — 地图 SWF 实例名解析、相机尺寸、平台、前景视差

一句话目的：把地图 SWF 根 `Sprite` 按约定实例名拆成边界、出生点、图层和 `FloorVO` 列表；给相机舞台尺寸；每帧做前景 0.1 视差，并让挡住角色的前景 MC 半透明。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/map/MapMain.as`（362 行）

## Callers / callees

- **创建**：`GameLoader.loadMap` `new MapMain(swfRoot as Sprite)`，`data = MapVO`。`LoadingState` 回调写入 `GameCtrl.I.gameRunData.map`。
- **初始化**：`GameCtrl.buildGame` → `map.initlize()` → `GameState.initFight(..., map)`（挂图层、放 P1/P2）→ `GameLogic.initGameLogic(map, camera)` → `GameMainLogicCtrler.initlize(..., map)`（只抄 `left+10` / `right-10`）。
- **每帧**：`GameState.render`：`map.render(-screenRect.x, -screenRect.y, zoom)`。
- **地板**：`GameLogic.isInAir` → `getFloorHitTest`。
- **相机**：`GameState.initCamera` 用 `getStageSize()`、`getMapBottomDistance()` 当 `offsetY`。
- **显隐**：`EffectCtrl` 必杀/替身/爆气/残影期间 `getMap().setVisible(false/true)`。
- **销毁**：`GameState.destory` → `map.destory()`。
- **Callees**：`GameConfig.GAME_SIZE` / `MAP_LOGO_STATE`、`GameData.I.config.quality`、`KyoUtils.drawDisplay`、`FloorVO`、`GameState.getGameSprites`、`IGameSprite.getArea`。
- 拼写：`initlize` / `destory` 与全工程一致。

## 命名备注

地图 SWF 根上的实例名契约（`getChildByName`，缺则对应字段保持 0 / null）：

| 实例名 | 用途 |
|---|---|
| `line_left` | `left = x` 左边界 |
| `line_right` | `right = x` 右边界 |
| `line_bottom` | `bottom = y` 地图底（越界/钳底） |
| `line_player_bottom` | `playerBottom = y` 角色站立线 |
| `p1` / `p2` | 出生点 |
| `map` | 主场景 MC → `mapLayer`，进 `_gameLayer` 最底，也是相机宽度来源 |
| `front` | 视差前景 Sprite |
| `front_fix` | 不视差、只做光学半透明的前景 |
| `bg` | 栅格化成 `bgLayer` Bitmap，挂在 `GameState` 最底（镜头外） |
| `floor` | 平台容器 Sprite，子件各成一条 `FloorVO` |
| `logo4399` | 图层内 4399 水印；`MAP_LOGO_STATE != 1` 时藏 |

`GameConfig.MAP_LOGO_STATE` 默认 0；本包 `bleachvsnaruto_2.initlize` 置 **1**（4399 发行显示 logo）。

`renderOptical`：前景里挡住角色显示盒的 **MovieClip** 子项 `alpha=0.5`。

## 逐行说明

### 字段（L19–46）

- `mapLayer:MovieClip`、`frontLayer:Sprite`、`frontFixLayer:Sprite`、`bgLayer:Bitmap`：拆出的层。
- `p1pos` / `p2pos`：`Point`，`initlize` 后 Y 已加底对齐偏移。
- `left/right/bottom/playerBottom`：世界坐标。X 不平移；Y 在 `initlize` 里 `+= (GAME_SIZE.y - line_bottom.y)`。
- `mapMc`：SWF 根。
- `data:MapVO`：id/name/fileUrl/picUrl/bgm。`LoadingState` 用 `data.bgm` 进战斗 BGM 队列。
- `gameState:GameState`：`initFight` 反写，供 `renderOptical` 取 sprite 列表。
- `_defaultFrontPos`：`front` 归一化并 Y 偏移后的位置，视差原点。
- `_floors:Array`：`FloorVO[]`。无 `floor` 层则为 `[]` 后立刻 return，`getFloorHitTest` 会空转。

### 构造（L49–52）

只存 `mapMc = param1`。真正拆名在 `initlize`（加载完成到开打之间，`buildGame` 才调）。

### `destory`（L54–87）

有 `mapMc` 则 `try stopAllMovieClips + removeChildren`（catch `trace`），置 null。四层引用置 null；`bgLayer` 额外 `bitmapData.dispose()`。不显式清 `_floors` / `gameState` / `data`。`GameState.destory` 是唯一调用点。

### `setVisible`（L89–111）

L91–94 `if(false) return;`：死代码，像编译掉的调试开关。然后分别设 `mapLayer/frontLayer/frontFixLayer/bgLayer.visible`（缺层跳过）。**不**藏 `mapMc` 本身（根已拆空）。`EffectCtrl.bisha/endBisha/replaceSkill/energyExplode/ghostStep` 用来让地图在特写时消失。

### `initlize`（L113–182）—— 核心解析

`GameConfig.GAME_SIZE` 为 `(800,600)`。

**1. 边界线（L116–135）**

`line_left/right/bottom/player_bottom` 有则抄 `x` 或 `y`。缺则保持 0。这些线通常是隐藏 shape，只取坐标。

**2. 出生点（L137–145）**

`p1`/`p2` 有则 `new Point(x,y)`。`GameState.initFight` 直接 `fighter.x/y = map.p1pos/p2pos`，缺 pos 会 NPE——地图 SWF 必须带 p1/p2。

**3. 图层（L147–153）**

- `map` as MovieClip
- `front` / `front_fix` as Sprite
- `bg`：`drawBitmap("bg", false, 0)` 栅格化；成功则 `normalizeLayer`

`drawBitmap` 的 `param2=false`：不按 `getBounds` 偏移，从 (0,0) 画；`param3=0` 且 transparent=false → 不透明黑底。原 `bg` 子件仍留在 `mapMc` 里，但 `initFight` 只 addChild 栅格副本，原件不进显示列表。

**4. 底对齐偏移 `_loc3_ = GAME_SIZE.y - bottom`（L154）**

把 `line_bottom` 对齐到屏幕底（600）。若作者把底线画在 y=500，全体下移 100。随后：

- `mapLayer`：normalize，`y += _loc3_`
- `frontLayer`：normalize，`y += _loc3_`，记下 `_defaultFrontPos`
- `frontFixLayer`：normalize，`y += _loc3_`
- `playerBottom` / `bottom` / `p1pos.y` / `p2pos.y` 同样加

X 不改。`bgLayer` 不加偏移（全屏背景，相机外）。

**5. `initFloor(_loc3_)`（L181）**

平台 Y 用同一偏移，保证台面与角色站立线同一坐标系。

`GameState.initFight` 图层顺序：`bgLayer`（State 上）→ `_gameLayer`：`mapLayer` → `_playerLayer` → `frontFixLayer` → `frontLayer`。无 `mapLayer` 则 throw `"map is error! :: mapLayer is null!"`。

### `drawBitmap`（L184–193）私有

`mapMc.getChildByName(name)` 有则 `KyoUtils.drawDisplay(disp, true, transparent, fill)`。`drawDisplay`：宽高 ≤0 返回 null；`BitmapData(w,h,transparent,fill)` 再 `draw`。第二参 `true` 是 drawDisplay 的「用 getBounds 平移」——但这里传入的是 `param2`（调用 `drawBitmap("bg", false, 0)` 所以 **false**，不平移）。返回 Bitmap 或 null。

### `normalizeLayer`（L195–226）私有

- 自身是 Bitmap：`smoothing = (quality == "best")`。
- 自身是 Sprite：每个 Bitmap 子项同样设 smoothing。
- 然后若 `GameConfig.MAP_LOGO_STATE != 1`：找子项 `logo4399`，有则 `visible=false`。

本包发行入口把 `MAP_LOGO_STATE=1`，4399 logo **显示**。质量非 `"best"` 时背景/图层 bitmap 不平滑（更像像素风、也省）。`bgLayer` 是 Bitmap 走第一支；`map/front/front_fix` 是 Sprite/MC 走第二支。

### `getStageSize`（L228–231）

`new Point(mapLayer.width, GameConfig.GAME_SIZE.y)` → `(地图MC宽, 600)`。`initCamera` 用它当世界大小：`GameCamera(_gameLayer, GAME_SIZE, stageSize, true)`，`setStageBounds(new Rectangle(0, -1000, w, h))`。宽度取 **显示宽** 不是 `right-left`；若 `mapLayer` 含超出设计的矢量，相机会偏。Y 固定 600 而不是 `bottom`。

### `getMapBottomDistance`（L233–236）

`bottom - playerBottom`。`camera.offsetY` 用它，让镜头垂直焦点落在站立线附近而不是地图最底。两线重合则为 0。

### `initFloor`（L238–262）私有

`_floors = []`。`getChildByName("floor") as Sprite` 失败则 return（之后 `getFloorHitTest` 对空数组）。否则每个 child：

```
xFrom = floor.x + child.x
xTo   = floor.x + child.x + child.width
y     = floor.y + child.y + yOffset
```

`yOffset` 即 `initlize` 的 `_loc3_`。子件用 **width** 当台长，旋转/skew 的平台会不准。空 child 跳过。顺序即时间轴顺序，`getFloorHitTest` 先命中先返回。

### `getFloorHitTest`（L264–278）

`(x, y, thickness) → FloorVO | null`。遍历 `_floors`，`FloorVO.hitTest` 真则立即返回。`GameLogic.isInAir` 的 thickness = `10 * SPEED_PLUS_DEFAULT`。无命中 null → 空中。见 `FloorVO.md`。

### `render`（L280–300）—— 视差

`GameState.render` 传入：

- `param1 = -screenRect.x`
- `param2 = -screenRect.y`
- `param3 = camera.getZoom(true)` —— **本函数未使用**（预留？）

有 `frontLayer`：

1. `_loc5_ = param1`（相机世界 X）
2. `_loc4_ = param2 + bottom`
3. `frontLayer.x = param1 * 0.1 + _defaultFrontPos.x` —— 水平 10% 视差
4. `_loc6_ = _defaultFrontPos.y` 随即被覆盖为 `_loc4_ * 0.1 + _defaultFrontPos.y`
5. L292：`_loc6_ < _defaultFrontPos.y && (_loc6_);` —— **反编译残缺**。原意应是 `if (_loc6_ < _defaultFrontPos.y) _loc6_ = _defaultFrontPos.y;`（钳住不让前景比默认位置更高 / 更小 y）。当前字节码只做比较，**没有赋值**，钳制失效。标 `?`。
6. `frontLayer.y = _loc6_`，再 `renderOptical(frontLayer)`

有 `frontFixLayer`：只 `renderOptical`，不改 x/y。

无前景则本函数空转。`bgLayer`/`mapLayer` 不视差（背景在相机外，map 随 `_gameLayer` 被相机带）。

### `renderOptical`（L302–333）私有

无 `gameState` 或层内无子项或 `getGameSprites()` 空则 return。对每个 child：条件 `_loc2_ is MovieClip != false` 即 `is MovieClip`（Bitmap/Shape 不动）。取其在 `param1` 空间的 `getBounds`，再加上层的 `x/y` 得到世界盒，与任意 sprite `getArea()` 相交则 `alpha=0.5`，否则 `1`。用来避免前景柱子挡住角色。`getArea()` null（基类无 `_area`）的对象不参与。每帧重算，角色走开即恢复。

### `checkHitGameSprite`（L335–359）私有

对 `Vector.<IGameSprite>` 逐个 `getArea()`，`param1.intersects` 真则 true。sprite 空或 area 空跳过。全否 false。不看 `getBodyArea`，所以用的是显示盒（战斗机覆盖后往往就是身体盒）。
