# `BishaFaceEffectView` — 必杀特写脸

一句话目的：从 `effect.swf` 取出 `bisha_face_mc`，把角色 SWF 导出的脸图塞进左右槽 `facemc1`/`facemc2`，再从第 2 帧播入场。只被 `BlackBackView.showBishaFace` 创建。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BishaFaceEffectView.as`（51 行）

## Callers / callees

- **Callers**
  - 仅 `BlackBackView.showBishaFace`：第一次 `new BishaFaceEffectView()`，把 `mc` addChild 到黑底上，再 `setFace(slot, bmp)` + `fadIn()`。`fadOut`/`destory` 走 `removeBishaFace` → 本类 `destory()`。
  - `EffectCtrl.showFace`：比双方 `display.x`，自己在右 → 槽 2，否则槽 1（无对手默认 1）。脸图来自 `FighterEffectCtrl.getFace`（SWF `defineBishaFace` 登记的 BitmapData 类，每次 `new` 包成 smoothing Bitmap）。
- **Callees**
  - `AssetManager.I.getEffect("bisha_face_mc")`：每次 `new` 一个 MC 实例（`effect.swf` 符号 `symbol926`）。
  - 时间轴：`bisha_face_mc` 公开 `facemc1`/`facemc2`；`addFrameScript(70, frame71)` 第 71 帧 `stop()`。

## 命名备注

- `fadIn`：全工程 fade 都少一个 e，不是 fadeIn。本类只 `gotoAndPlay(2)`，没有淡入逻辑。
- `destory`：原拼写。
- 槽号是 1/2，对应 MC 实例名 `facemc1`/`facemc2`，不是数组下标。
- 脸图固定拉到 **254×180**，与槽位尺寸写死对齐。

## 逐行说明

### 字段（L11–13）

- `mc:MovieClip`：公开。`BlackBackView` 用它设 `y`、`addChild`。
- `_faceObj:Object = {}`：`槽号 → DisplayObject`。只给 `destory` 扫 BitmapData；不用于取回。

### 构造（L15–19）

`mc = AssetManager.I.getEffect("bisha_face_mc")`。`getEffect` 对每个名字 `new Class()`，这里每次必杀第一张脸都是新 MC。找不到符号则 `new null()` 炸。必须在 `effect.swf` 预载之后（`MainGame.loadGameBack` → `EffectModel.initlize` 同一批资源）。

MC 默认停在第 1 帧（未 `fadIn` 前）。第 1 帧在 FLA 里多半是空/准备，入场从 2 开始。

### `setFace`（L21–32）

`param1` = 槽 1 或 2，`param2` = 脸 DisplayObject（实际是 `Bitmap`）。

1. `mc["facemc" + param1]` 动态取子 MC。没有该槽（槽号不是 1/2、或时间轴还没建实例）直接 return，脸图丢掉。
2. `_faceObj[param1] = param2`：同槽再设会覆盖引用，**旧脸不从显示列表摘、不 dispose**。两人连续必杀复用同一 `BishaFaceEffectView` 时，槽里可能叠多张脸。?
3. `param2.width = 254; height = 180`：非等比拉伸。
4. `_loc3_.addChild(param2)`：不 `removeChildren`。

`BlackBackView` 第一次创建后一直复用到 `fadOut`，超必/万解同一场黑底上可以先后 `setFace` 两次（自己一张、理论上对手槽另一张，但 `showFace` 每次只塞一个槽）。

### `fadIn`（L34–37）

`mc.gotoAndPlay(2)`。每次 show 都从头播入场，即使 MC 已经在播。第 71 帧脚本 `stop()`，之后停在最后一帧直到下次 `fadIn` 或黑底被摘。

无 `fadOut`：退场是整块 `BlackBackView` 从 `GameState` 摘掉，不是时间轴倒放。

### `destory`（L39–48）

只扫 `_faceObj`：是 `Bitmap` 则 `bitmapData.dispose()`。

**不做**：

- 从 `facemc*` 摘脸、从 parent 摘 `mc`
- `mc.stop()` / `stopAllMovieClips`
- 置 `mc` / `_faceObj` null

`BlackBackView.removeBishaFace` 调完立刻 `_bishaFace = null`。MC 仍是黑底的 child，随黑底一起离开显示列表。脸的 BitmapData 已被 dispose；若 `FighterEffectCtrl.getFace` 那次 `new Class()` 得到的是独立 BitmapData，这里释放正确。SWF 里若是共享贴图被 dispose，下次同角色必杀脸会空。? 当前路径每次 `new` 一份，dispose 安全。

下次 `showBishaFace` 会 **再 new** 一个 `BishaFaceEffectView`（因为引用已空），旧 `mc` 仍留在 `BlackBackView` 孩子里直到整场 `BlackBackView.destory`。多次必杀会在黑底上堆多个停住的 `bisha_face_mc`。?
