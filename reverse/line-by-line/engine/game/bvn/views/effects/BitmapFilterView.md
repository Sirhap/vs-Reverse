# `BitmapFilterView` — 角色光晕滤镜精灵

一句话目的：实现 `IGameSprite`。每逻辑帧把目标 Display 画成带 `BitmapFilter` 的 Bitmap，跟在角色身上。钢体 glow 走这里。必杀时 `GameState.setVisibleByClass(BitmapFilterView, false)` 藏起来。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BitmapFilterView.as`（223 行）

## Callers / callees

- **创建**：仅 `EffectCtrl.startFilter(sprite, filter, offset)`。扫 `_filterEffects` 同一 `target` 则 `update`，否则 `new` + `GameCtrl.I.addGameSprite(0, view, 0)`（team 0、depth 0）+ push 向量。
- **关闭**：`EffectCtrl.endFilter(sprite)`：找到则 `removeGameSprite(view, true)`（`destory(true)`）+ splice。只拆一个。
- **SWF/引擎**：`FighterEffectCtrl.startGlow(color=0xFFFFFF)`：`GlowFilter(color, 1, 20, 20, 2, 1, false, true)`（inner=true）+ `Point(20,20)`。`setSteelBody(true)` 白光；`setSteelBody(true, true)` 超钢体黄 `0xFFFF00`。`endGlow` → `endFilter`。
- **显示闸**：`EffectCtrl.bisha`/`wanKai` 藏；`endBisha` 再可见。**`endWanKai` 不恢复**，万解后 glow 可能一直 invisible 直到有人 `endBisha` 或场景重建。?
- **主循环**：进 `_gameSprites`，`GameMainLogicCtrler.renderGameSprite`：`fixGameSpritePosition`（`allowCrossMap*` 为 true，基本不夹）→ `render()` 重画。**不是** BaseGameSprite，无重力。pause/`_isRenderGame=false` 时主逻辑停，光晕冻住。`EffectCtrl` **不**扫 `_filterEffects` 做 render。
- **Callees**：`KyoUtils.drawBitmapFilter`；`FighterMain.getMC().getCurrentFrameCount()`（同帧跳过重画）；`IGameSprite` 其余方法空实现。

## 命名备注

- `destory` / `isDestoryed`：原拼写。`destory(false)` **整段跳过**，连 `_isDestoryed` 都不置。
- `_filterEffects` 在 `EffectCtrl` **字段初始化**就 `new Vector`，`initlize`/`destory` 都不重置。跨场可能留死引用。?
- team=0：`TeamMap.getTeam(0)` 空，`Debugger.log("GameCtrl.addGameSprite :: team is null!")`。`set team` 是空函数，不会被写上。无碰撞（`getBodyArea`/`getCurrentHits` 返回 null）。
- 与 `ShadowEffectView` 不同：残影是抽帧 Bitmap 塞 `_effectLayer`；本类是正式精灵，depth 0 插在游戏层最底。

## `IGameSprite` 空壳一览

| 方法 | 行为 |
|------|------|
| `setVolume` / `renderAnimate` / `set direct` / `set team` / `hit` / `beHit` / `setIsTouchSide` / `setSpeedRate` | 空 |
| `getArea` / `getBodyArea` / `getCurrentHits` | `null`（不参与对撞） |
| `allowCrossMapXY` / `allowCrossMapBottom` | `true` |
| `getIsTouchSide` | `false` |
| `get/set x,y` | 转发 `_bitmap` |
| `get direct` | `target.direct` |
| `get team` | `null` |
| `getDisplay` | `_bitmap` |
| `isDestoryed` | `_isDestoryed` |

慢动作 `setSpeedRate` 不改重画频率；有游戏逻辑帧就每帧 `render`。

## 逐行说明

### 字段（L18–33）

- `_bitmap`：真正上舞台的 Bitmap。`bitmapData` 每帧（或每角色动画帧）换新。
- `target`：公开，`EffectCtrl` 用引用比较。
- `_filter` / `_filterOffset`：`update` 可换。
- `_isDestoryed`
- `_bitmapFrame`：上次重画时的 `FighterMC._curFrameCount`。非 Fighter 不用。
- `_targetDisplay`：`param1.getDisplay()`，构造时抓死。
- `_targetBounds`：`getBounds(self)`，给摆位置。
- `_targetFighter`：仅 FighterMain。

### 构造（L36–48）

`param1`=`BaseGameSprite`，`param2`=`BitmapFilter`，`param3`=`Point` 默认 null。

`_bitmap = new Bitmap(null, "auto", false)`：无图、不平滑。Fighter 则记下 `_targetFighter`。`_filterOffset` 可空——`render()` 读 `.x/.y` **会 NPE**。`startGlow` 总传 `(20,20)`。

### `setVolume`（L50–52）

空。暂停改音量扫精灵时 harmless。

### `update`（L54–58）

换 filter 与 offset。不立刻重画，下一拍 `render` 用新值。同目标重复 `startFilter` 走这里，不 new 第二份。

### `renderAnimate`（L60–62）

空。滤镜不跟 30fps 动画拍，跟逻辑 `render`。

### `render`（L64–86）

无 target / 无 display / 已 destory → return。

1. `renderBitmapData()`
2. `_bitmap.scaleX/Y = _targetDisplay.scaleX/Y`（转向镜像）
3. 位置：
   - `direct > 0`：`x = display.x - offset.x + bounds.x`
   - 否则：`x = display.x + offset.x - bounds.x`
   - `y = display.y - offset.y + bounds.y`（左右同一套）

`bounds` 是 **display 本地** `getBounds(self)`，左上相对注册点，通常 x 为负。滤镜 Bitmap 比角色大一圈（`drawBitmapFilter` 按 offset 扩矩形），减 offset 把光晕中心套回角色。

`_filterOffset` 空 → NPE。`_targetBounds` 在第一次 `renderBitmapData` 末尾才写；若那里提前 return（fighter 同帧跳过）而 bounds 仍是 undefined，同样 NPE。第一次必走重画。同帧跳过时 bounds 沿用上一帧，scale/坐标仍更新——角色平移但姿势不变时 glow 跟着走、不重绘像素。这是优化。

### `renderBitmapData`（L88–106）私有

Fighter：`getMC().getCurrentFrameCount()` 是 `FighterMC._curFrameCount`，`goFrame` 清零、每 `renderAnimate` +1，**不是** `currentFrame`。同一动作姿势不变时仍每动画拍递增，等于几乎每动画拍都重画；逻辑帧若 60、动画 30，两逻辑帧里有一帧 `== _bitmapFrame` 可跳过。切招 `goFrame` 归零，必重画。

非 Fighter（理论上 Assister 也能 `startGlow`）：每逻辑帧都重画。

有旧 `bitmapData` 先 `dispose`。然后：

`KyoUtils.drawBitmapFilter(_targetDisplay, _filter, true, _filterOffset)`：

1. 建 `display.width × height` 的 BitmapData，按 bounds 平移 draw
2. 滤镜矩形按 offset 向负方向扩、宽高 `+= offset*2`
3. `applyFilter` 得到更大的图，dispose 中间图

`inner=true` 的 GlowFilter：光在轮廓 **内侧**（钢体发白/发黄），不是外圈光晕。

最后 `_targetBounds = _targetDisplay.getBounds(_targetDisplay)`。

### `isDestoryed` / `getDisplay` / `direct` / `x` / `y` / `team`（L108–155）

见上表。`set direct` / `set team` 空：主循环若写这些不会同步到角色。`get x/y` 是滤镜图坐标，`fixGameSpritePosition` 可能去读；`allowCrossMap` true 通常不改。

### 碰撞 / 地图 / 速率空实现（L157–201）

`hit`/`beHit`/`getArea`/`getBodyArea`/`getCurrentHits` 全空/null。`checkHit` 拿不到盒子。`allowCrossMap*` true。`setSpeedRate` 空。

### `destory`（L203–220）

仅 `param1==true`：

- dispose `_bitmap.bitmapData`
- `_isDestoryed=true`
- 清空 `target` / `_filter` / `_filterOffset` / `_targetFighter` / `_targetBounds` / `_targetDisplay`

不从 parent 摘 `_bitmap`（`GameState.removeGameSprite` 已经摘了）。`param1==false`：什么都不做，`isDestoryed()` 仍 false，主循环可能继续 `render` 到已摘掉的对象。`endFilter` 传 true。
