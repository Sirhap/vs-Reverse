# `qbar_mc` — 气条根 MC（气 0–300 + 辅助气 + 辅助脸）

一句话目的：底侧气条容器。主条 `barmc` 画 `FighterMain.qi`（0–300 三格 + 满条 `bar4`），侧条 `fzqibar` 画 `fzqi`（0–100），`facemc` 塞**辅助**脸，满辅助气播 `readymc`。时间轴 `fadin` / `fadout`，完成帧派 `Event.COMPLETE`。

源文件：`decompiled/ui/fight/scripts/qbar_mc.as`（41 行）

## 如何挂上引擎

本类是 [`ui_fight.fzqi1` / `fzqi2`](ui_fight.md)，**不是** `createDisplayObject` 单独取。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 构造 `new QiBar(ui.fzqi1)` / `new QiBar(ui.fzqi2)`；P2 `setDirect(-1)`。

[`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md) 槽位：

| 实例 | 类型 | 包装 |
|---|---|---|
| `barmc` | [`qbar_barmc`](qbar_barmc.md) | 脚本级 `InsBar`：`bar.bar1..bar4` + `txtmc` |
| `facemc` | [`qbar_facemc`](qbar_facemc.md) | `ct` 里 `AssetManager.getFighterFace(assister.data)`（50×50）。**不是**出战角色 |
| `fzqibar` | [`qbar_fzqi_mc`](qbar_fzqi_mc.md) | 脚本级 `InsFzBar`：`barmc.scrollRect` 裁高度 |
| `readymc` | `MovieClip` | fzqi 满条 `visible=true` 且 `mc.play()`；不满 `mc.gotoAndStop(1)`。P2 `mc.scaleX=-1` |

`QiBar` 用的**标签名**（AS 里没有，在 SWF 时间轴）：`"fadin"` / `"fadin_fin"` / `"fadout"` / `"fadout_fin"` / `"destory"`。拼写 `destory` / `fadin` 与引擎一致。

`GameUI.BITMAP_UI`（默认 true）：构造即 `gotoAndStop("fadin_fin"); visible=false`。`fadIn` 只 `visible=true`，不播 MC。`destory`：卸 `"complete"`，`gotoAndStop("destory")`。

`FightUI.fadIn` 在 `QI_BAR_MODE==TOP` 时强制 `fadIn(false)` 再 `setPosAndScale(120|675, 60, 0.8)`。KO / 超时 `playKO2` / `playTimeOver` 调气条 `fadOut()`。

## 逐行说明

### 头 / Embed（L1–6）

无名包。`MovieClip` + `flash.events.Event`。`symbol="symbol78"`。`public dynamic class qbar_mc extends MovieClip`。

### 公开实例（L10–16）

- **L10 `barmc`**：[`qbar_barmc`](qbar_barmc.md)。气格外壳。
- **L12 `facemc`**：[`qbar_facemc`](qbar_facemc.md)。辅助脸坑。
- **L14 `fzqibar`**：[`qbar_fzqi_mc`](qbar_fzqi_mc.md)。辅助气竖条。
- **L16 `readymc`**：声明 `MovieClip`。内层要有 `mc`（[`QiBar.setDirect`](../../../engine/game/bvn/ui/fight/QiBar.md) / `render` 直接读）。候选运行时类型见 [`元件12_10`](fight_fla/元件12_10.md)。?

无其它公开字段。血条在 [`hpbar_mc`](hpbar_mc.md)，连击在 [`hits_mc`](hits_mc.md)。

### 构造（L18–22）

`super()` 后 `addFrameScript(0, frame1, 14, frame15, 37, frame38)`。

`addFrameScript N` = 时间轴 **F{N+1}**：

| 脚本下标 | 时间轴 | 函数 |
|---|---|---|
| 0 | **F1** | `frame1` |
| 14 | **F15** | `frame15` |
| 37 | **F38** | `frame38` |

标签帧号以 SWF 为准，AS 只钉这三帧。对照 `QiBar`：F15 一带是 `fadin_fin`，F38 一带是 `fadout_fin`。`"fadin"` / `"fadout"` / `"destory"` 的具体帧 ?（不在本 AS）。`destory` 很可能就是 F1。?

`QiBar.fadIn(true)` / `fadOut(true)` 是 `gotoAndStop("fadin"|"fadout")` 再靠 `renderAnimate` **`nextFrame()`**，不是 `play()`。BITMAP 不进这条。

### `frame1`（L24–27）—— F1

`stop()`。默认停在起始。BITMAP 马上 `gotoAndStop("fadin_fin")` 离开这里。`destory` 的 `gotoAndStop("destory")` 多半回到本帧。?

### `frame15`（L29–33）—— F15

`stop()` + `dispatchEvent(new Event(Event.COMPLETE))`。淡入走完。`QiBar.uiPlayComplete`：`_isFadIn` 则 `visible=true` + `setCacheBitmap(true)`。`renderAnimate` 见标签 `fadin_fin` 关闸。

### `frame38`（L35–39）—— F38

同样 `stop` + `COMPLETE`。淡出走完。`uiPlayComplete` 因 `_isFadIn==false` 把 `visible=false`。对应 `fadout_fin`。

`fadOut(false)` 不播这段，直接 `visible=false`。BITMAP 的 fadIn/fadOut 只改 `visible`，这两条脚本基本不再触发。
