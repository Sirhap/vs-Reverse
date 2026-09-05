# `QiBar` — 气条 + 辅助气 + 辅助脸

一句话目的：包 `qbar_mc`。主条显示 `FighterMain.qi`（0–300，三格），侧条 `fzqi`（0–100）满了播 `readymc`。脸是**辅助** `Assister.data`，不是出战角色。P2 `setDirect(-1)`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/QiBar.as`（388 行，含脚本级 `InsBar` / `InsFzBar`）

## Callers / callees

- **Callers**：只 `FightUI`。构造绑 `ui.fzqi1/fzqi2`；P2 `setDirect(-1)`；`initlize` → `setFighter(current, fuzhu)`；`render`/`renderAnimate`/`fadIn`/`fadOut`/`destory`；KO/超时 `fadOut()`；`QI_BAR_MODE==TOP` 时 `setPosAndScale(120|675, 60, 0.8)`；死代码 `renderQibarPos` 会 `moveTo`/`moveResume`。
- **Callees**：`AssetManager.I.getFighterFace(assister.data)`（默认 50×50）；`KyoUtils.drawDisplay`（BITMAP 把 `facemc` 烤成 Bitmap）；`GameUI.BITMAP_UI`。

## SWF 槽（`qbar_mc`）

| 实例 | 类 | 用途 |
|---|---|---|
| `barmc` | `qbar_barmc` | `bar.bar1..bar4` + `txtmc`（气格数） |
| `fzqibar` | `qbar_fzqi_mc` | 辅助气，`barmc` 用 `scrollRect` 裁高度 |
| `facemc` | `qbar_facemc` | `ct` 里塞辅助脸 |
| `readymc` | MovieClip | fzqi 满条时 `mc.play()` |

帧脚本：帧 1 `stop`；帧 15 / 38 `stop`+`COMPLETE`（fadin_fin / fadout_fin）。

气格：`qbar_barmcgroup.bar1..4`。`qi/100` 映射到 0–3；`bar1`=0–100，`bar2`=100–200，`bar3`=200–300，`bar4` 在 ≥300 时 visible。`txtmc` 帧 = `int(process)+1`（1..4）。

## 命名备注

- `destory` / `fadIn` / `fadOut`：原拼写。
- `readymc` 不是 `readymc` 拼错成 ready-mc 以外的词，SWF 实例名就是 `readymc`。
- `_orgPose`：构造时 `_ui.x/y`，`moveResume` 的目标。`setPosAndScale` **不**改它，TOP 模式挪走后 AUTO 的 `moveResume` 仍回 SWF 原位。
- `_tweenSpd=0.5`：每逻辑帧走完一半剩余位移。`moveTo` 本包无调用。
- `_moveType`：0=回原位，1=去指定点。与 `_moveFin` 一起防重入。
- BITMAP 构造即 `gotoAndStop("fadin_fin"); visible=false`。`fadIn` 只 `visible=true`，无淡入。
- `setCacheBitmap`：非 BITMAP 才把 `facemc.cacheAsBitmap` 打开（淡入完成/瞬显）或关掉（动画中）。BITMAP 直接 return。
- `InsBar.setProcess` 在 process 从 >2 掉到 ≤2 时**不**把 `bar3.scaleX` 收回；`bar3.visible=false` 所以看不见。?
- `FighterMain.qiMax=300` 是 const；UI 用 `qi/100` 封顶 3，与之一致。`fzqiMax=100`，这里写死 `/100`。
- 脸 `setFighter` 每次 `ct.addChild` **不**清旧孩子。`resetFight` 再 `initlize` 会叠一张。BITMAP 则重 `drawDisplay`，旧脸还在 `facemc` 子树里一起被烤进去。?

## 逐行说明

### 字段 / 构造（L17–59）

`_bar=new InsBar(_ui.barmc)`，`_fzBar=new InsFzBar(_ui.fzqibar)`，`_fzReadyMc=_ui.readymc`。记下 `_orgPose`。听 `"complete"`。BITMAP：停在 `fadin_fin` 并隐藏。

### `destory`（L61–75）

卸 COMPLETE，`gotoAndStop("destory")`，`_ui=null`。有 `_faceBp` 则 `bitmapData.dispose()`。`_fighter=null`。不 destory Ins*。

### `uiPlayComplete`（L77–88）

淡入完成：`visible=true` + `setCacheBitmap(true)`。淡出完成：`visible=false`。BITMAP 不播 MC，不依赖这条。

### `setFighter`（L90–117）

`param1`=出战 `FighterMain`（读 qi/fzqi），`param2`=该组 `Assister`。

- `param2 && param2.data`：`AssetManager.getFighterFace`（`faceUrl`，默认 50×50）塞进 `_ui.facemc.ct`。没图就算了。
- BITMAP：`KyoUtils.drawDisplay(_ui.facemc)` → `_faceBp`，按 `facemc` 的 x/y 放到 `_ui` 上；try `removeChild(facemc)`；再 `addChild(readymc)`（保证 ready 在脸 Bitmap 之上）。第二次 `setFighter` 会 **再** draw 一张 `_faceBp` 而不 dispose 旧的。?

无辅助时 BITMAP 仍 draw 空 `facemc`。

### `setCacheBitmap`（L119–126）

`BITMAP_UI` return。否则 `facemc.cacheAsBitmap=param1`。淡入动画中 false，停住 true。

### `setDirect`（L128–132）

`_bar.setDirect` 翻气数字 `txtmc`。`_fzReadyMc.mc.scaleX` 按符号 ±1。fz 条、脸不在这里翻——P2 的 `fzqi2` SWF 已镜像。`_fzReadyMc.mc` 若 null 会 NPE；SWF 有 `mc`。

### `render`（L134–165）

1. `_qiRate = qi/100`，`>3` 钳成 3。
2. 读当前 `_bar.getProcess()`，差的绝对值 <0.01 则贴死，否则 `process += delta*0.4`（与 EnergyBar 同系数）。
3. `_fzBar.setProcess(fzqi/100)`——**无 lerp**，瞬时裁 scrollRect。
4. `fz` 满（`>=1`）与 `readymc.visible` 不同才改 visible：满则 `mc.play()`，否则 `mc.gotoAndStop(1)`。避免每帧 `play()` 重开。

`_fighter` 空则 NPE。`qi` 负会让 bar1.scaleX 负（可见性 `>0` 为 false，条藏）。

### `renderAnimate`（L167–180）

与 `FightBar.renderAnimate` 同构：`_isRenderAnimate` 闸，标签 `fadin_fin`/`fadout_fin` 关闸，否则 `nextFrame()`。BITMAP 从不置闸。

### `fadIn`（L182–205）

已显示 return。`_isFadIn=true`，`visible=true`。BITMAP 立刻 return（已在 fadin_fin）。否则 `param1` 真：关 cache、`"fadin"`、开动画；假：`"fadin_fin"` + 开 cache。

`FightUI.fadIn` 在 TOP 模式强制 `param1=false`。

### `fadOut`（L207–229）

未显示 return。`_isFadIn=false`。BITMAP：`visible=false` return。否则带动画则 `"fadout"`+关 cache；否则直接 `visible=false`。

KO 的 `playKO2`/`playTimeOver` 默认 `param1=true`，BITMAP 下就是藏。

### `moveTo`（L231–246）

目标 `(x,y,scale)`。若已在 type 1 且 `_moveFin` → return（到过就不再跟，即使目标变了也不追——zoom 来回穿 1.5 时第一次到位后卡住）。切到 type 1 时清 `_moveFin`。然后 `moving`。本包无调用。?

### `moveResume`（L248–263）

回 `_orgPose`、scale 1。type 0 + 已完成则 return。否则切 type 0 再 `moving`。

### `moving`（L265–278）

三轴都够近（|dx|<2、|dy|<2、|dScale|<0.2）则贴死并 `_moveFin=true`。**然后仍然**再跑一遍 `+= delta * 0.5`——贴死的那帧会被 0.5 插值拉开？贴死之后 `delta=0`，加 0 无害。未到位时每帧走一半。`scaleY` 跟 `scaleX`。

### `setPosAndScale`（L280–286）

瞬移，不改 `_orgPose` / `_moveType` / `_moveFin`。TOP 模式 `fadIn` 用。之后若有人 `moveResume` 会 tween 回底边原位。

---

### 脚本级 `InsBar`（L293–348）—— 气 0–300 四格

构造即 `setProcess(0)`。

#### `getProcess` / `ui`

返回缓存 `_process`；`ui` 给外部（本文件没人读 `ui`）。

#### `setProcess`（L317–342）

写 `_process`。可见性：

- `bar1.visible = process>0`
- `bar2.visible = process>1`
- `bar3.visible = process>2`
- `bar4.visible = process>=3`（满 300 亮第 4 格，scale 不管）

宽度：

- `>2`：bar1=bar2=`scaleX=1`，bar3=`process-2`（反编译 `_temp_2` 连续赋值）。
- `>1`：bar1=1，bar2=`process-1`（**不**改 bar3）。
- else：bar1=`process`（**不**改 bar2/bar3）。

`txtmc.gotoAndStop(int(process)+1)`：0→1，1.x→2，2.x→3，3→4。`int(2.0)+1=3`，刚进第三格数字就跳 3。

#### `setDirect`（L344–347）

`txtmc.scaleX` ±1。

---

### 脚本级 `InsFzBar`（L350–388）—— 辅助气竖条

#### 构造（L361–370）

`_loc2_ = barmc.getBounds(barmc)` **算了不用**。`_scroll = Rectangle(0,0,width,height)`，`_height=scroll.height`。然后 `barmc.scaleY=-1`，`barmc.y=barmc.height`：竖直翻转，让 `scrollRect` 从「视觉底部」往上长。?

`getBounds` 丢弃可能是曾经用 bounds 当 scroll 原点，后改成 (0,0,width,height)。?

#### `setProcess`（L382–387）

`_process=param1`（期望 0–1）。`_scroll.height = param1 * _height`，赋回 `barmc.scrollRect`。`fzqi>100` 会超高；负 height 在 Flash 里行为未定义。正常 `renderFzQi` 把 fzqi 卡在 100。
