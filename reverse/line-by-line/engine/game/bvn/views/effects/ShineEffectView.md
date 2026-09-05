# `ShineEffectView` — 全屏闪光 overlay

一句话目的：继承 `Bitmap`。一张 `GAME_SIZE/10` 的纯色小图拉满屏，按 `FPS_SHINE_EFFECT` 抽帧把 alpha 减掉。亮色 `add`、暗色 `darken`。`EffectManager` 单独池化，不按 EffectVO 分组。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/ShineEffectView.as`（147 行）

## Callers / callees

- **工厂**：`EffectManager.getShine()`：扫 `_shineCache` 找 `!isActive`，否则 `new` 并 push。
- **导演**：`EffectCtrl.shine(color, alpha)`：
  1. `FPS_SHINE_EFFECT==0` 则关（Config 最低 15，预留）
  2. `_shineEffects.length > shineMaxCount`（3）踢 `[0].removeSelf()` —— 比较用 `>`，可叠 **4** 层才踢最旧
  3. `getShine()` → `init(color, alpha)` → `onRemove=removeShine` → push → **`_gameStage.addChild`**（不是 `_effectLayer`，盖住角色；UI 在 GameState 之外则仍在闪光下/上看 GameState 结构）
- **来源**：`doEffectVO` 读 VO.`shine`（缺省白 `0xFFFFFF` / 0.2）；`FighterEffectCtrl.shine` 白 0.3、其它 0.2；`FightUI` KO 白 0.5；`SteelHitEffect` 超钢体黄 `0xFFFF00` / 0.3。
- **tick**：`EffectCtrl.renderShine` 每 **逻辑帧** 扫 Vector 调 `render()`（自己内部再抽帧）。一边 `render` 一边 `removeSelf`→`splice`，可能跳过下一个。?
- **Callees**：`GameConfig.GAME_SIZE` / `FPS_GAME` / `FPS_SHINE_EFFECT`；`flash.utils.getTimer`（掉帧补偿）。

## 命名备注

- `destory`：原拼写。
- `_alpha` 是 **int**（百分数），`this.alpha` 是 Number。`param2 * 100` 赋给 int 截断。
- `_skipFrameRate = 1.2` 声明了，`skipFrame` 比较写死字面量 `1.2`，const 未使用。?
- `8388607` = `0x7FFFFF`：颜色大于它走 `add`（白/黄），否则 `darken` 且 alpha×0.8。
- 与 `EffectView` 无关。不是光栅动画，是全屏色块。

## 画质与抽帧

`ConfigVO.applyConfig`：`FPS_SHINE_EFFECT` low=15，medium/high/higher=30，best=60。默认字段 15。

`_renderGap = ceil(FPS_GAME / FPS_SHINE_EFFECT) - 1`。`render` 用 `_renderFrame % _renderGap != 0` 跳过：

| FPS_GAME | FPS_SHINE | gap | 实际 tick |
|----------|-----------|-----|-----------|
| 60 | 60 | 0 | gap>0 为假，每逻辑帧 |
| 60 | 30 | 1 | `n % 1 == 0` 恒真，仍每帧（不是 30） |
| 60 | 15 | 3 | 每 3 帧一次 ≈ 20fps，不是 15 |

抽帧公式和 `EffectCtrl.isRenderAnimate` 的 `>= gap` 清零不是同一套，medium 档几乎等于没降闪光帧率。?

`_loseAlpha = gap + 1`。初始 `_alpha = param2*100`。每 tick `_alpha -= _loseAlpha`，`<=5` 则移除。

例：白 0.2、60/15 → `_alpha=20`，lose=4。20→16→12→8→4≤5 删，约 4 tick × 3 逻辑帧 ≈ 0.2s。best 档 gap=0、lose=1，20→…→5 约 15 帧 ≈ 0.25s。暗色再 ×0.8，更短。

## 逐行说明

### 字段（L11–29）

- `onRemove`：`EffectCtrl.removeShine`。
- `isActive`：池旗。`init` 置 true，`removeSelf` 置 false。
- `_loseAlpha`：每 tick 减多少百分数。
- `_alpha`：当前百分数。
- `_renderGap` / `_renderFrame`：抽帧。
- `_isDestoryed`：`render` 闸。
- `_startTimer` / `_frameTime`：真实时间 vs 目标帧间隔。
- `_skipFrameRate`：死 const 1.2。

### 构造（L31–34）

`super(null, "never", false)`：无 BitmapData、pixelSnapping=never、smoothing=false。小图拉大本来就模糊，再平滑无意义。池里先 new 再 `init` 才有像素。

### `destory`（L36–43）

`_isDestoryed=true`。仍 active 则 `removeSelf`（dispose、摘 parent、onRemove）。已 inactive 的 bitmapData 在上次 `removeSelf` 已 dispose。`EffectManager.destory` 下场扫 shine 池。

### `init`（L45–73）

每次从池取出都要重跑（`EffectCtrl.shine`）。

1. 旧 `bitmapData` dispose。
2. `new BitmapData(GAME_SIZE.x/10, GAME_SIZE.y/10, false, param1)`：80×60、不透明、纯色填充。`false` 无 alpha 通道，透明度靠 **Bitmap.alpha**。
3. `width/height = GAME_SIZE` 拉满 800×600。
4. `isActive=true`。
5. `param1 > 8388607` → `blendMode="add"`；否则 `"darken"` 且 `param2 *= 0.8`。黑闪 `shine(0)` 走 darken。
6. `this.alpha = param2`；`_alpha = param2 * 100`（int）。
7. `_renderFrame=0`；`_renderGap = ceil(FPS_GAME/FPS_SHINE_EFFECT)-1`。
8. `_startTimer=0`（第一次 `skipFrame` 不做补偿）。
9. `_loseAlpha = _renderGap + 1`。
10. `_frameTime = 1000 / FPS_SHINE_EFFECT`（目标毫秒/拍，给 skipFrame）。

不 reset `onRemove`（`EffectCtrl` 每次都再赋）。不把旧 parent 摘掉；若上次 `removeSelf` 失败留在舞台，这次 `addChild` 会把它挪到最前。

### `render`（L75–99）

已 destory return。

`_renderGap > 0`：`_renderFrame++`，`% gap != 0` 则 return。gap=1 时永不 return。

然后 `skipFrame()`（可能加大 `_loseAlpha`）。

`_alpha -= _loseAlpha`。`<=5` → `removeSelf()`；否则 `this.alpha = _alpha * 0.01`。

阈值 5 不是 0，末尾直接摘，避免长时间停在几乎看不见的 overlay 上。多层闪光各自独立减。

### `skipFrame`（L101–120）私有

掉帧补偿：真实间隔比目标帧时长的 1.2 倍还长，就把 `_loseAlpha` 抬到 `ceil(lose * ratio)`（只增不减）。卡顿时闪光更快淡完，避免 pause 恢复后屏幕还白着。

`_startTimer==0`（`init` 后第一拍）跳过比较，只记下 `getTimer()`。之后每 **实际执行到的 tick**（过了抽帧闸的）更新。pause 菜单（`_isPauseGame`）连 `EffectCtrl.render` 都不进，`_startTimer` 停住；恢复后第一拍 ratio 巨大，`_loseAlpha` 被抬到可能一次减光，闪光几乎瞬间没。hit-stop 仍跑 `renderShine`，不受影响。

字面量 `1.2` 没用上字段 `_skipFrameRate`。

### `removeSelf`（L122–144）

`isActive=false`。有 bitmapData 则 dispose 置 null。有 parent：try `removeChild` 吞 Error。`onRemove != null` 则 `(this)`。

`EffectCtrl.removeShine` 从 `_shineEffects` splice。踢最旧那条 `length > 3` 时也走这里，会再 splice——`removeSelf` 在踢的时候 View 还在 Vector 里，回调能找到。

不 null `onRemove`。池复用靠 `isActive`。
