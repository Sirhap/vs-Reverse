# `BlackBackView` — 必杀/替身/爆气/鬼步黑底

一句话目的：一张拉满 `GAME_SIZE` 的低分辨率黑 Bitmap，垫在 `GameState` 最底。必杀时再挂 `BishaFaceEffectView`。`fadIn`/`renderAnimate` 是空 stub，黑屏靠 `addChildAt(..., 0)` 立刻出现。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BlackBackView.as`（96 行）

## Callers / callees

- **Callers**：仅 `EffectCtrl`。
  - `initlize`：`_blackBack = new BlackBackView()`。一场一份，不进对象池。
  - `destory`：`_blackBack.destory()`。
  - `bisha` / `wanKai` / `ghostStep`：`_gameStage.addChildAt(_blackBack, 0)` + `fadIn()`（空）。
  - `replaceSkill` / `energyExplode`：同样 `addChildAt`，**不**调 `fadIn`。
  - `endBisha` / `endWanKai` / `endReplaceSkill` / `endEnergyExplode` / `endGhostStep`：`fadOut()`。
  - `showFace` → `showBishaFace(slot, bmp)`。仅 `bisha`/`wanKai` 有特写；替身/爆气/鬼步只有黑底。
  - `renderAnimate`：每动画拍调用，空函数。
- **Callees**：`GameConfig.GAME_SIZE`；`GameCtrl.I.gameState.camera.getZoom()`（特写 y）；`BishaFaceEffectView`。

## 命名备注

- `fadIn` / `fadOut`：少 e。`fadIn` 空；`fadOut` 才拆特写、从 parent 摘自己。
- `destory`：原拼写。
- `isRenderFadIn` / `isRenderFadOut`：声明了从未读写。残留的淡入淡出状态机，逻辑已删，黑底改成瞬间出现。
- 黑底加在 **GameState 自身** index 0，不是 `_playerLayer`。地图靠 `getMap().setVisible(false)` 藏，不是被黑底盖住。

## 与 `EffectCtrl` 演出的关系

| 演出 | addChildAt 黑底 | fadIn | 特写 | fadOut |
|---|---|---|---|---|
| freeze | — | — | — | — |
| bisha / wanKai | ✓ | ✓（空） | 可选 | 最后一人 cancelJustRenderAnimate 才 |
| replaceSkill | ✓ | — | — | 1 秒后 |
| energyExplode | ✓ | — | — | 0.7 秒后 |
| ghostStep | ✓ | ✓（空） | — | 两表都空才 |

同一 `_blackBack` 实例反复 add/remove。`fadOut` 用 try/catch 摘 parent，没挂着时不炸。

## 逐行说明

### 字段（L13–19）

- `_bishaFace`：当前特写。`fadOut`/`destory` 拆掉后置 null，下次必杀再 new。
- `isRenderFadIn` / `isRenderFadOut`：死字段。
- `_bg`：黑 Bitmap。

### 构造（L21–29）

1. `BitmapData(GAME_SIZE.x/10, GAME_SIZE.y/10, false, 0)`：80×60、不透明、填充色 0（黑）。与 `ShineEffectView` 同款「小图拉满屏」省 fill。
2. `_bg.width/height = GAME_SIZE`（800×600）拉满。
3. `addChild(_bg)`。作为 Sprite 自己没有其它绘制。

`false` 无 alpha 通道，黑底是实心的，透不出下面的地图——所以必须另藏 map。

### `destory`（L31–46）

有 `_bg`：try `removeChild`，`bitmapData.dispose()`，置 null。再 `removeBishaFace()`。

**不**从 `GameState` 摘自己。`EffectCtrl.destory` 随后把 `_blackBack` 引用丢掉，若仍在显示列表靠 `GameState.destory` 一起拆。

### `renderAnimate`（L48–50）

空。`EffectCtrl.renderAnimate` 每 30fps 语义拍仍会调。淡入淡出若曾按帧插值，已删干净。

### `fadIn`（L52–54）

空。调用方以为在淡入，实际 `addChildAt` 当下全黑。保留空方法避免改 `EffectCtrl` 签名。

### `fadOut`（L56–66）

1. `removeBishaFace()`：特写 `destory` + 引用清空。
2. try `parent.removeChild(this)`：从 GameState 摘掉。没 parent 吃掉 Error。

不 dispose `_bg`（下场还要用）。不 `visible=false`，靠移出显示列表。下一次 `addChildAt` 同一实例立刻全黑。

### `showBishaFace`（L68–84）

`param1` 槽 1/2，`param2` 脸 DisplayObject。

若还没有 `_bishaFace`：

1. `new BishaFaceEffectView()`。
2. zoom 默认 1；有 `GameCtrl.I.gameState.camera` 则 `getZoom()`。
3. `_bishaFace.mc.y = 100 + 100 / zoom`。超必 `cameraFocusOne` zoom 3.5 → y ≈ 128.6；普通必杀镜头未拉近 → y=200。只在 **第一次** 创建时写 y，同一次黑底上再 show 不改。?
4. `addChild(_bishaFace.mc)`。

然后无论新旧：`setFace` + `fadIn()`（MC 跳到第 2 帧重播）。

`bisha` 里 `showFace` 发生在 `cameraFocusOne` **之前**（超必）或根本不 zoom（普通）。超必路径：先 `showBishaFace` 用当前 zoom 算 y，再 `cameraFocusOne` 把 zoom 拉到 3.5。特写 y 按 **变焦前** 的 zoom 算。?

### `removeBishaFace`（L86–93）私有

有则 `destory()` 置 null。`BishaFaceEffectView.destory` 不把 `mc` 从本 Sprite 摘掉，停住的特写 MC 会留在孩子列表里，直到本对象 `destory` 或整场拆掉。多次必杀堆 MC。?
