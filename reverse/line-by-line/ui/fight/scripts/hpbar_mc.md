# `hpbar_mc` — 顶部血条带（整条 HUD）

一句话目的：战斗顶栏容器。左右各一套脸 / HP / 体力，正中计时，两侧胜场灯，街机分数。时间轴播 `fadin` / `fadout`，完成帧派 `Event.COMPLETE`。

源文件：`decompiled/ui/fight/scripts/hpbar_mc.as`（54 行）

## 如何挂上引擎

本类是 [`ui_fight.hpbarmc`](ui_fight.md)，**不是** `createDisplayObject` 单独取。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 构造 `new FightBar(ui.hpbarmc)`。

[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) 槽位：

| 实例 | 类型 | 包装 |
|---|---|---|
| `face1` / `face2` | [`hpbar_facegroup`](hpbar_facegroup.md) | [`FightFaceGroup`](../../../engine/game/bvn/ui/fight/FightFaceGroup.md)；P2 `setDirect(-1)`（最终空操作） |
| `bar1` / `bar2` | [`hpbar_barmc`](hpbar_barmc.md) | [`FighterHpBar`](../../../engine/game/bvn/ui/fight/FighterHpBar.md) |
| `energy1` / `energy2` | [`energy_bar`](energy_bar.md) | [`EnergyBar`](../../../engine/game/bvn/ui/fight/EnergyBar.md)（体力，不是气）；P2 `setDirect(-1)` |
| `timemc` | [`time_mc`](time_mc.md) | [`FightTimeUI`](../../../engine/game/bvn/ui/fight/FightTimeUI.md) |
| `win_p1` / `win_p2` | [`winmc`](winmc.md) | [`WinUI`](../../../engine/game/bvn/ui/WinUI.md)`(mc, 1|2)` |
| `scoremc` | [`score_mc`](score_mc.md) | 街机才 `new FightScoreUI`；非街机 `visible=false` |

`FightBar` 用的**标签名**（AS 里没有，在 SWF 时间轴）：`"fadin"` / `"fadin_fin"` / `"fadout"` / `"destory"`。`renderAnimate` 还认 `"fadout_fin"`。拼写 `destory` / `fadin` 与引擎一致。

`GameUI.BITMAP_UI`（默认 true）：`gotoAndStop("fadin_fin")` 后把本 MC 从 `ui_fight` 摘掉，装饰烤进 Bitmap；HP/体力/计时数字/灯/分数抬到 `ui_fight`。MC 淡入只在 flag 为 false 时播。

`FightBar` 构造听 `"complete"` → `uiPlayComplete`：`_isFadIn` 则 `visible=true`，否则 `false`。`destory`：卸监听，`gotoAndStop("destory")`。

## 逐行说明

### 头 / Embed（L1–6）

无名包。`MovieClip` + `flash.events.Event`。`symbol="symbol136"`。`public dynamic class hpbar_mc extends MovieClip`。

### 公开实例（L10–27）——全部文档

- **L10–11 `bar1` / `bar2`**：[`hpbar_barmc`](hpbar_barmc.md)。P1 左绿+红拖尾，P2 右（SWF 已朝左，引擎不翻 `scaleX`）。
- **L14–15 `energy1` / `energy2`**：[`energy_bar`](energy_bar.md)。出战角色体力。
- **L18–19 `face1` / `face2`**：[`hpbar_facegroup`](hpbar_facegroup.md)。三槽头像。BITMAP 脸留在本子树被烤进底图。
- **L22 `scoremc`**：[`score_mc`](score_mc.md)。街机分数容器。
- **L24 `timemc`**：[`time_mc`](time_mc.md)。正中倒计时 /「无限」。
- **L26–27 `win_p1` / `win_p2`**：[`winmc`](winmc.md)。单挑胜场灯。组队/生存不亮。

无其它公开字段。气条、连击、KO 片在 [`ui_fight`](ui_fight.md) 上，不在本 MC。

### 构造（L30–34）

`super()` 后 `addFrameScript(0, frame1, 24, frame25, 45, frame46)`。

`addFrameScript N` = 时间轴 **F{N+1}**：

| 脚本下标 | 时间轴 | 函数 |
|---|---|---|
| 0 | **F1** | `frame1` |
| 24 | **F25** | `frame25` |
| 45 | **F46** | `frame46` |

标签帧号以 SWF 为准，AS 只钉这三帧。对照 `FightBar`：F25 一带是 `fadin_fin`，F46 一带是 `fadout_fin`。`"fadin"` / `"fadout"` / `"destory"` 的具体帧 ?（不在本 AS）。

### `frame1`（L36–39）—— F1

`stop()`。默认停在起始。BITMAP 马上 `gotoAndStop("fadin_fin")` 离开这里。非 BITMAP 开场 `fadIn(true)` 才 `gotoAndStop("fadin")` 往前爬。

### `frame25`（L41–45）—— F25

`stop()` + `dispatchEvent(new Event(Event.COMPLETE))`。淡入走完。`FightBar.uiPlayComplete` 把整条 `visible=true`（已 `_isFadIn`）。`renderAnimate` 见标签 `fadin_fin` 会关 `_isRenderAnimate`，停在完成帧等这条 COMPLETE。

### `frame46`（L47–51）—— F46

同样 `stop` + `COMPLETE`。淡出走完。`uiPlayComplete` 因 `_isFadIn==false` 把 `visible=false`。对应 `fadout_fin`。

`fadOut(false)`（`GameEndCtrl` 终场）不播这段，直接 `visible=false`。BITMAP 的 fadIn/fadOut 只改 `_children.visible`，这两条脚本基本不再触发。
