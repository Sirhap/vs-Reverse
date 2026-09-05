# `EffectView` — 光栅化特效播放器（基类）

一句话目的：把 `EffectVO.bitmapDataCache` 当逐帧 Bitmap 播。运行时不再实例化 MC。`EffectCtrl` 挂到 `_effectLayer`，结束靠 `addRemoveBack`。`SpecialEffectView` / `BuffEffectView` / `SteelHitEffect` 都继承本类；无旗的 VO 直接用本类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/EffectView.as`（242 行）

## Callers / callees

- **工厂**：`EffectManager.getEffectView(vo)`：池里找 `!isActive`，否则按旗 new 子类，最后才 `new EffectView(vo)`。池 key = **EffectVO 对象引用**（命中路径是 clone 后的 VO，每种 HitVO 实例一条池）。
- **导演**：`EffectCtrl.addEffect`：`start(x,y,direct)` + `addRemoveBack(removeEffect)` + push `_effects`。`doEffectVO` 成功则 `_effectLayer.addChild(display)`。`render` 每逻辑帧调空的 `render()`；`renderAnimate` 30fps 语义调 `renderAnimate()`。`BGEffect` 额外把 display 插到 GameState index 0，并可设 `holdFrame`。
- **子类**
  - `SpecialEffectView`：覆盖 `setTarget`/`start`/`render`
  - `BuffEffectView`：构造 `loopPlay=true`，覆盖 `setTarget`/`render`，另 `setBuff`
  - `SteelHitEffect`：只覆盖 `setTarget`
- **数据**：`EffectVO`：`blendMode`、`bitmapDataCache`、`frameLabelCache`、`randRotate`、`sound`。烘焙在 `EffectModel.initlize` → `cacheBitmapData`。**最后一帧永不烘焙**（`while currentFrame < totalFrames`），`length-1` 是倒数第二帧。
- **Callees**：`EffectCtrl.EFFECT_SMOOTHING`；`SoundCtrl.I.playEffectSound`；`KyoMath.asRadians` / `getPointByRadians`。

**不是** `IGameSprite`。不进 `_gameSprites`，无碰撞、无重力。只是一层 Bitmap。

## 命名备注

- `destory`：原拼写。不 dispose 位图（与 VO 缓存共享）。
- `addRemoveBack`：remove callback，不是「移除背景」。
- `_orgX/_orgY`：逻辑锚点（命中中心 / 角色脚底）。`display.x/y` = 锚点 + 该帧 `offset`（烘焙时 MC `getBounds`）。
- `_curFrame`：位图 Vector **0-based**。`frameLabelCache` 的 key 是 MC **1-based** `currentFrame`。`"loop"` / `"finish"` 对帧会错一位。?
- `holdFrame == -1`：默认「播完即删」。`BGEffect("kobg", 2)` 写成 `hold*30` 动画拍。
- `autoRemove` 默认 true。`loopPlay` 为 true 时走另一支，**不** autoRemove（buff）。

## 池化生命周期

```
getEffectView(vo)
  有 !isActive → 复用（display 还在，bitmapDataCache 同一引用）
  否则 new 对应子类，push 池
addEffect: start → addRemoveBack(removeEffect) → _effects
播完 / remove() → removeSelf：isActive=false，回调，摘 parent
不 destory。下场 EffectManager.destory 才逐个 destory
```

`start()` 不重置 `holdFrame` / `loopPlay` / `_rotation`。同 VO 复用时这些应保持一致；`kobg` 的 hold 在 `BGEffect` 里每次重写，结束时 `holdFrame--` 落到 -1，刚好回到默认。

## 逐行说明

### 字段（L16–45）

| 字段 | 默认 | 含义 |
|------|------|------|
| `display` | 构造 new | 场景里的 Bitmap。不是 MC |
| `autoRemove` | true | 播到末帧且非 loop 则 `removeSelf` |
| `loopPlay` | false | 末帧回到 0。Buff 构造改 true |
| `holdFrame` | -1 | ≥0 时每动画拍 `--`，到 ≤0 删除；末帧会先绕回 0 |
| `isActive` | true | 池扫描旗。`removeSelf` 置 false，`start` 置 true |
| `_target` | — | `setTarget`。基类不读，子类用 |
| `_onRemoveFuncs` | 懒建 | `removeSelf` 按插入序 `(this)` 调完置 null |
| `_isDestoryed` | false | `renderAnimate` 开头闸 |
| `_data` | 构造 | EffectVO，只读 `randRotate`/`sound`/`blendMode` 已抄走 |
| `_bitmapDatas` | VO 缓存引用 | `Vector.<BitmapDataCacheVO>`，可含 `null` 空帧 |
| `_frameLabels` | VO 缓存引用 | `{帧号: 标签}` |
| `_orgX/_orgY` | 0 | `start`/`setPos` |
| `_curFrame` | — | 当前位图下标 |
| `_rotation` | 0 | `randRotate` 写入。非 0 时用旋转后的 offset |
| `_direct` | — | 1 或 -1。`display.scaleX` |

### 构造（L47–56）

`param1`=`EffectVO`。

1. `_data = param1`
2. `display = new Bitmap()`（默认 pixelSnapping=auto、smoothing 下面覆盖）
3. `display.blendMode = param1.blendMode`（VO 默认 `"normal"`，命中火花多为 `add`/`lighten`/`hardlight`）
4. `display.smoothing = EffectCtrl.EFFECT_SMOOTHING`（`ConfigVO`：low/medium/high=false，higher/best=true）
5. `_bitmapDatas` / `_frameLabels` 直接引用 VO 缓存，clone 的 hit VO 也共享同一份位图

不 `start`。池里 new 出来 `isActive` 已是 true，要等 `start` 才真正播；`getEffectView` 只认 `isActive==false` 才复用，所以刚 new、还没 start 的不会被别人拿走（单线程）。

### `setTarget`（L58–61）

只写 `_target`。基类播放不跟随。`doEffectVO` 在 `addEffect`/`start` **之后** 才 `setTarget`，子类上色发生在第一帧画面之后。

### `setPos`（L63–67）

只改锚点，不改 `display.x/y`。`SpecialEffectView`/`BuffEffectView` 每逻辑帧跟角色，画面要等到下一拍 `renderDisplay`。

### `start`（L69–86）

`param1/2` = 世界 x/y，`param3` = 朝向默认 1。

1. 记下 `_orgX/_orgY`。
2. `_direct = _rotation != 0 ? 1 : param3`。`_rotation` 是上场残留：`randRotate` VO 上场几乎必非 0，这次 `_direct` 被强制 1，但马上 `randRotate` 又把 `scaleX` 写成 1，无视觉差。非旋转 VO 的 `_rotation` 一直 0，朝向正常。
3. `display.scaleX = _direct`（-1 镜像）。
4. `_curFrame = 0`。
5. VO.`randRotate` → `randRotate()`。
6. VO.`sound` → `SoundCtrl.I.playEffectSound`。每次 start 都 new 一个 effect.swf 里的 Sound 播一遍，无法 stop。
7. `renderDisplay()`：立刻贴第 0 帧。随后第一拍 `renderAnimate` 会再画一次第 0 帧再 `++`，开头停一拍。
8. `isActive = true`。

不重置 `_rotation`（非 randRotate 保持 0）、不重置 `holdFrame`。

### `destory`（L88–96）

`_isDestoryed=true`。若仍 `isActive` 先 `removeSelf`（回调、摘 parent）。`display=null`。

**不** `bitmapData.dispose`（共享 VO 缓存）。不空 `_target`/`_data`/`_bitmapDatas`/`_onRemoveFuncs`（若已 inactive，funcs 可能已 null）。`EffectManager.destory` 下场才调。之后实例不再进池（整张 cache 丢掉）。

### `gotoAndPlay`（L98–114）

`param1` 是 `int` 或 `String`，两个 `if` 不是 else-if（互斥类型）。

- int：`_curFrame = int(param1)`，不 clamp。
- String：`for-in _frameLabels`，值相等则 `_curFrame = int(key)`。无 `break`，多帧同标签取最后一个。找不到则保持原帧。

`SpecialEffectView` 用 `"finish"`。key 是烘焙时的 `mc.currentFrame`（从 1 起），与 Vector 下标差 1。标签在 MC 帧 F：`_curFrame=F`，`renderDisplay` 取 `_bitmapDatas[F]`——对应 MC 帧 F+1，或 `F >= length` 时 Vector 越界 RangeError。?

`renderFrameLabel` 的 `"loop"` 走 `gotoAndPlay(1)`：跳到下标 1（MC 第 2 帧），不是动画开头 0。

### `randRotate`（L116–121）私有

`_rotation = Math.random() * 360`（0–360，含 0 几乎不含 360）。`display.rotation = _rotation`。`display.scaleX = 1`（取消朝向镜像，旋转火花不翻转）。

命中斩/拳重击等 `randRotate:true`。钢体火花同样。

### `render`（L123–126）

空。子类跟随/检查状态写在这里。`EffectCtrl.render` 每逻辑帧扫 `_effects` 都调，含 hit-stop。

### `renderAnimate`（L127–170）—— 播帧

`_isDestoryed` 则 return。

`_loc1_` = 本拍是否已经 `removeSelf`（不再画、不加帧）。

**`loopPlay`**（与 autoRemove 互斥的 if/else if）：

- `_curFrame == length-1` → `_curFrame = 0`
- 然后照常 `renderFrameLabel` + `renderDisplay` + `++`
- 永不因播完删除。Buff 走这条。

**否则若 `autoRemove`**：

1. 到末帧：
   - `holdFrame == -1`：`removeSelf`，`_loc1_=true`（本拍不再画）
   - 否则：`_curFrame = 0`（片段循环，等 hold 到期）
2. **每拍**若 `holdFrame != -1`：`if (holdFrame-- <= 0)` 则删除。后置 `--`：从 N 减到 0 的那拍 `0<=0` 为真，实际持续 **N+1** 拍。`BGEffect(hold=2)` → `holdFrame=60` → 61 拍 ≈ 2s@30fps。

`loopPlay` 为 true 时不进 autoRemove 支，`holdFrame` 被忽略。

未删除则：

1. `renderFrameLabel()`
2. `renderDisplay()`
3. `_curFrame++`（可越过 `length-1`；下一拍的末帧判断在 ++ 之前，所以末帧会先显示再在 **下一拍** 开头判定结束）

注意末帧判定用的是 **进入本拍时** 的 `_curFrame`。`start` 已画过 0；第一拍再画 0 然后变成 1。最后：进入拍时已是 `length-1`，先判定结束并 `removeSelf`，**末帧那张图只在 start/上一拍出现过**——若 length=1（只烘到 1 帧），start 画了 0，第一拍立刻 remove，只亮一拍。

`length==0`（空缓存）则 `length-1==-1`，末帧条件永不成立，`_bitmapDatas[0]` RangeError。正常 VO 至少一帧。

### `renderDisplay`（L172–196）私有

`_loc3_ = _bitmapDatas[_curFrame]`。越界抛错。

- `null`（空帧或未定义）：`display.bitmapData = null`，位置不动。烘焙时 `width<1 || height<1` 的帧是 null。
- 否则：把 **同一** BitmapData 引用赋给 display（多帧去重时共享）。
  - `_rotation != 0`：`KyoMath.asRadians(_rotation)` 后 `getPointByRadians(Point(offsetX, offsetY), rad)` 旋转锚点，`display.x/y = org + 旋转后的 offset`。不乘 `_direct`（randRotate 已 scaleX=1）。
  - 否则：`x = orgX + offsetX * _direct`，`y = orgY + offsetY`。镜像时 offsetX 取反，注册点仍对齐命中心。

`KyoMath.getPointByRadians`：`x' = x cos - y sin * s`，`y' = x sin + y cos * s`，第三参默认 1。

### `renderFrameLabel`（L198–207）私有

`_frameLabels[_curFrame]`。只有字符串 `"loop"` 进 `switch`（反编译 `===`）。命中则 `gotoAndPlay(1)`。其它标签（如 `"finish"`）本方法忽略，只给外部 `gotoAndPlay(String)` 查表。

因 key 错位，MC 第 N 帧的 `"loop"` 要等到 `_curFrame==N` 才触发，那时显示的已是另一帧。?

### `remove`（L209–212）

公开入口，转 `removeSelf`。`BuffEffectView` 到期走这里。

### `addRemoveBack`（L214–225）

懒建数组。`indexOf` 已有则跳过（同一 `removeEffect` 不会重复）。`BGEffect` 再挂一条闭包恢复地图。`removeSelf` 会把数组置 null，所以每次 `start`/`addEffect` 必须重新注册。

### `removeSelf`（L227–239）私有

1. `isActive = false`（回池）。
2. 逐个 `_onRemoveFuncs(this)`。`EffectCtrl.removeEffect`：`indexOf` + `splice`。`BGEffect` 的闭包：`getMap().setVisible(true)`。
3. `_onRemoveFuncs = null`。回调里若再 `addRemoveBack` 会建新数组，本拍末仍被这句清掉。?
4. `display && display.parent` 则 `removeChild`。不 dispose bitmapData。

不调 `destory`。池里的 View 带着空的 funcs、`isActive=false`、display 无 parent，等下次 `start`。
