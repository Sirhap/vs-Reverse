# `EffectVO` — 一条特效的类名、闪光/震动/定帧和位图缓存

一句话目的：描述一个可播放特效。`className` 是 `effect.swf` 里的 MC 符号；其它字段是命中时要触发的副作用。`cacheBitmapData` 把整段 MC 光栅化成 `BitmapDataCacheVO` 序列，运行时 `EffectView` 只播位图、不再实例化 MC。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/EffectVO.as`（115 行）

## Callers / callees

- **Callers**：
  - `EffectModel`：`initEffects` / `addHitEffect` / `addDefenseEffect` `new EffectVO(className, props)`；`initlize` 末尾对表里每一条 `cacheBitmapData`；`getEffect`/`getHitEffect`/`getDefenseEffect` 返回本对象。
  - `EffectManager.getEffectVOByHitVO`：按 `HitVO` 克隆一份，改 `shake.y` 后缓存；`getEffectView` 按 `isSpecial`/`isBuff`/`isSteelHit` 选 `SpecialEffectView`/`BuffEffectView`/`SteelHitEffect`/`EffectView`。
  - `EffectView` 构造：读 `blendMode`、`bitmapDataCache`、`frameLabelCache`；`start` 读 `randRotate`/`sound`。
  - `EffectCtrl.doEffectVO`：`freeze`/`shake`/`shine`/`slowDown`/`specialEffectId`/`followDirect`。
  - `SpecialEffectView`：`targetColorOffset` 改角色 ColorTransform。
- **Callees**：`AssetManager.I.getEffect(className)`、`KyoUtils.setValueByObject` / `itemToObject`、`BitmapData`/`Matrix`/`Rectangle`、`BitmapDataCacheVO`。

## 命名备注

- `className`：SWF 导出名，大小写混用（`XG_bs` vs `xg_hitover`），必须与 `effect.swf` 一致。
- `shine` / `shake` / `slowDown`：匿名 Object，不是独立 VO。缺字段时 `EffectCtrl` 给默认。
- `isSpecial` / `isBuff` / `isSteelHit`：互斥分类旗，决定 View 子类。`EffectModel` 不会给同一条同时点两个。
- 本类无 `destory`；位图缓存进程内常驻。

## 逐行说明

### 字段（L13–43）

| 字段 | 含义 |
|------|------|
| `className` | `AssetManager.getEffect` 的符号名 |
| `shine` | `{color, alpha, blendMode?}`。`EffectCtrl.shine`。未设则不定闪 |
| `shake` | `{x, y, pow, time}`。`pow` 会被 `EffectManager` 抄到 `y`。`time` 毫秒 |
| `freeze` | hit-stop **毫秒**。0 不顿帧。`EffectCtrl.freeze` |
| `sound` | `SoundCtrl.playEffectSound` 的 id |
| `randRotate` | `EffectView.start` 随机 0–360° |
| `followDirect` | 防御特效为 true。`EffectCtrl` 用攻击者 `direct` 当特效朝向 |
| `slowDown` | `{rate, time}`。本表默认特效都没填，字段留给扩展 |
| `blendMode` | 默认 `"normal"`。命中火花多用 `"add"` / `"lighten"` / `"hardlight"` |
| `bitmapDataCache` | 逐帧 `BitmapDataCacheVO`；空帧是 `null` |
| `frameLabelCache` | `{帧号: 标签}`。`EffectView.gotoAndPlay("finish")` 靠它 |
| `specialEffectId` | 命中后再挂持续特效（`fire_ing`/`ice_ing`/`shock_ing`） |
| `targetColorOffset` | `[r,g,b]` 加到受击者 ColorTransform。仅 `isSpecial` |
| `isSpecial` / `isBuff` / `isSteelHit` | View 工厂旗，默认 false |

### 构造（L45–53）

`EffectVO(className, props=null)`。先存 `className`。`props` 非空则 `KyoUtils.setValueByObject(this, props)`：Object 的 key 对上公开字段就覆盖（含 `shine` 这种嵌套 Object）。`className` 已写入，props 里一般不再带。

### `clone`（L55–60）

`itemToObject(this)` 把公开字段抄成 Object，`delete className`（避免 props 再盖一次），`new EffectVO(原 className, obj)`。

`bitmapDataCache` / `frameLabelCache` 是**同一引用**（浅拷贝）。`EffectManager` 克隆 hit 特效是为了改 `shake.y` 而不污染模板，位图共享是有意的。

### `cacheBitmapData`（L62–112）

启动时 `EffectModel.cacheEffects` 对每条 VO 调一次。把 MC 逐帧画成位图。

1. `bitmapDataCache = new Vector`，`frameLabelCache = {}`。
2. `AssetManager.I.getEffect(className)` 取出 MC，`gotoAndStop(1)`。
3. **`while (currentFrame < totalFrames)`**：处理当前帧再 `nextFrame()`。
   - 有 `currentFrameLabel` → `frameLabelCache[帧号] = 标签`。
   - `width < 1 || height < 1`：空帧，`push(null)`。`EffectView` 该帧清 `bitmapData`。
   - 否则：
     - `new BitmapData(width, height, true, 0)`。
     - `getBounds(self)` 得注册点相对包围盒；`draw(mc, Matrix(1,0,0,1, -bounds.x, -bounds.y))` 把图形贴到位图 (0,0)。
     - `offsetX/Y = bounds.x/y`，播放时 `display.x = orgX + offsetX * direct`。
     - **去重**：上一帧 VO 存在，且 offset 相同、`bitmapData.compare(新图) == 0`（像素完全一样）→ 把**上一帧 VO 再 push 一次**（共享 BitmapData）。新 `BitmapData` 不 `dispose`，泄漏一帧（?）。
     - 否则 `new BitmapDataCacheVO` 存图和偏移再 push。
4. 循环条件是 `< totalFrames`：处理完第 `n-1` 帧后 `nextFrame` 到最后一帧，然后退出。**最后一帧永不烘焙**。`EffectView` 以 `length-1` 当结束帧，等于播到倒数第二帧就结束/循环。
5. 末尾把局部 MC / Rectangle / 上一帧 VO 置 null，不 `stopAllMovieClips`、不从显示列表移除（本来就没 addChild）。

`getEffect` 找不到符号会在这里炸（? `AssetManager` 返回 null 则 NPE）。必须在 `effect.swf` 预载完成之后调，对应 `MainGame` 的 `loadGameBack` → `EffectModel.initlize`。
