# `ShadowEffectView` — 残影 / afterimage

一句话目的：每隔若干动画拍把目标 Display 画成一张带颜色偏移的 Bitmap，插到 `container` 最底，alpha 从 0.8 每次 -0.1。`EffectCtrl` 用 `Dictionary[DisplayObject → ShadowEffectView]` 一对一登记。不进对象池。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/ShadowEffectView.as`（147 行）

## Callers / callees

- **创建**：`EffectCtrl.startShadow(display, r, g, b)`。`SHADOW_ENABLED` 闸（默认 true，本包无写入）。已有该 display 的 View：只改 r/g/b、`stopShadow=false`（复活）。否则 `new`，`onRemove=removeShadow`，`container=_effectLayer`。
- **停止**：`endShadow(display)` → `stopShadow=true`。不再拍新图，旧图淡完 `removeSelf` → `delete Dictionary[target]`。
- **SWF**：`FighterEffectCtrl.shadow(r,g,b)` 默认 0,0,0（无 ColorTransform 的残影）。鬼步 `shadow(0,0,255)` 蓝。`endGhostStep` 自己 `endShadow`。
- **tick**：`EffectCtrl.renderAnimate` 对 Dictionary `for each` 调 `render()`（30fps 语义）。**不是**逻辑 `render`。
- **下场**：`EffectCtrl.destory` 只把 Dictionary 置 null，**不**调本类 `destory()`。若还在淡，Bitmap 留在 `_effectLayer` 直到层拆掉。
- **Callees**：`KyoUtils.drawDisplay(target, true, true, 0, colorTransform)`。

## 命名备注

- `destory`：原拼写。淡出结束只 `onRemove`，不走 `destory`。View 对象丢给 GC，Bitmap 已在 `removeBitmap` 里 dispose。
- `stopShadow`：公开旗。`startShadow` 对已有 View 把它扳回 false，可在淡出中途重新开始拍。
- 与 `BitmapFilterView` 无关系。必杀藏的是 Filter，残影仍在 `_effectLayer`；必杀 pause 仍跑 `EffectCtrl.renderAnimate`，残影继续淡。
- `r/g/b` 是 ColorTransform **offset**（-255..255 语义），不是 0–1。

## 逐行说明

### 字段（L13–35）

- `target`：被拍的 DisplayObject（角色 `getDisplay()`）。
- `r/g/b`：默认 0。全 0 则 `drawDisplay` 不传 ColorTransform。
- `container`：`EffectCtrl` 写成 `_effectLayer`。`addChildAt(bp, 0)` 垫在角色层最底。
- `_bps`：活着的残影 Bitmap。
- `_alphaLose=0.1`、`_alphaStart=0.8`：8 拍淡到 0（0.8, 0.7, …, 0.0）。
- `_addBpGap=1`、`_addBpFrame`：`_addBpFrame++ > 1` 才拍，即每 **2** 个动画拍一张。30fps 动画 → 15 张/秒。
- `stopShadow` / `onRemove`。

### 构造（L37–45）

记下 target 与 r/g/b，`_addBpFrame=0`。不立刻拍。第一张要等 `render` 里计数超过 gap。

### `destory`（L47–66）

`target=null`。按下标扫 `_bps`：`bitmapData.dispose()`，try `container.removeChild`。`_bps=null`。

**不**调 `onRemove`。**不**空 `container`/`onRemove`。本包几乎不调这条（`EffectCtrl.destory` 丢 Dictionary）。若有人调，Dictionary 会留死 View。

while 里 `_loc2_++` 不 splice，只清空，安全。

### `render`（L68–94）

先处理生成，再淡：

1. `stopShadow`：`_bps.length<=0` 则 `removeSelf()`（通知 EffectCtrl 删 Dictionary）。仍有旧图则继续淡，不拍新的。
2. 否则 `_addBpFrame++ > _addBpGap`：`addShadowBp()`，计数清 0。起步：0→1 不拍，1→2 拍。之后 0,1,2 循环，每 2 拍一张。
3. 按下标扫 `_bps`：`alpha -= 0.1`；`<=0` 则 `removeBitmap`（**splice 当前下标** 再 `_loc2_++`）。删掉后后面的元素前移，`++` 会 **跳过下一个**。被跳过的那张晚一拍再淡/再删。?

`removeSelf` 不在本函数末尾无条件调，只在 stop 且空时。正在跑的残影不会把自己摘出 Dictionary。

### `addShadowBp`（L96–119）私有

`r/g/b` 任一非 0：`new ColorTransform()`，只写三 offset（multiplier 保持 1）。全 0：`_loc3_` 保持 null，`drawDisplay` 第五参 null。

`target.getBounds(target)` 本地盒。

`KyoUtils.drawDisplay(target, true, true, 0, ct)`：

- 目标空或宽高 ≤0 → null，本函数 return，本拍没残影
- transparent=true，fill=0
- 按 bounds 平移 draw，可选 ColorTransform

摆放：

- `alpha = 0.8`
- `x = target.x + bounds.x * target.scaleX`（镜像时 bounds.x 为负，乘 scaleX 仍对齐）
- `y = target.y + bounds.y` —— **不乘 scaleY**。若角色 scaleY≠1，残影竖向会错。角色通常 scaleY=1。?
- `scaleX/Y` 抄目标（左右翻转）
- `container.addChildAt(bp, 0)`：永远在层底，被角色盖住，残影在身后
- push `_bps`

每张都是新 BitmapData，淡完 dispose。鬼步高速位移时层底会积最多约 8 张（0.8/0.1）。

### `removeBitmap`（L121–136）私有

`indexOf` + splice。try `container.removeChild`（已不在列表则吞 Error）。`bitmapData.dispose()`。不置 bitmap 引用空，局部马上离开。

### `removeSelf`（L138–144）私有

`onRemove != null` 则 `onRemove(this)`。`EffectCtrl.removeShadow`：`delete _shadowEffects[view.target]`。此时 `stopShadow` 且 `_bps` 已空，没有未 dispose 的图。

不 null `onRemove`/`target`/`container`。对象无引用后 GC。
