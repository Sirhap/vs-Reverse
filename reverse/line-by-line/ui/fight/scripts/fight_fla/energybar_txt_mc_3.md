# `fight_fla.energybar_txt_mc_3` — 体力条文字（死神/火影两帧）

一句话目的：`energy_bar.txtmc` 的运行时类型。外层两帧切漫画风；内层 `mc` 给 InsTxt 做正常/闪/overload。

源文件：`decompiled/ui/fight/scripts/fight_fla/energybar_txt_mc_3.as`（23 行）

## 如何挂上引擎

[`energy_bar.txtmc`](../energy_bar.md) 声明 `MovieClip`。[`EnergyBar`](../../../../engine/game/bvn/ui/fight/EnergyBar.md) `new InsTxt(_ui.txtmc)`，多处读 **`txtmc.mc`**。本类正好有 `public var mc`，F1 `stop`，对得上。引擎不按本类名 `getItemClass`。?

`InsTxt.setType(comicType)` 切的是**外层本 MC**：

| `comicType` | `gotoAndStop` | 含义 |
|---|---|---|
| 0 | 帧 1 | 死神 |
| 1 | 帧 2 | 火影 |
| 其它 | 不切 | ? |

`setDirect`：`txtmc.scaleX = ±1`（P2 -1）。闪/overload 改的是 **内层 `mc`** 的帧 1/2，不是外层。缺 `mc` 则只改旗、不切帧。

切类型后内层 `mc` 可能被时间轴换实例；下一帧 `renderFlash` 读当前 `_mc.mc`。

## 逐行说明

- **L1** `package fight_fla`。
- **L5** `symbol="symbol90"`。
- **L6** `public dynamic class energybar_txt_mc_3 extends MovieClip`。
- **L9 `mc`**：`MovieClip`。InsTxt 闪/overload 的目标。`normal`/`overLoad` → `mc.gotoAndStop(1|2)`；`flash` 每 3 逻辑帧 1↔2。
- **L11–15 构造**：`addFrameScript(0, frame1)` → **F1**。
- **L17–20 `frame1`**：`stop()`。默认停帧 1（死神）。`setType(1)` 才会到帧 2。无第二帧脚本——帧 2 的 `stop` 靠 SWF 标签或外层 `gotoAndStop` 钉住。?
