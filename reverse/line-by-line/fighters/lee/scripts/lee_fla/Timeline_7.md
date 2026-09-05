# `lee_fla.Timeline_7` — 空元件 `Timeline_7`

一句话目的：库元件 `Timeline_7`：无 ctrler 回调，无帧脚本。多半是特效/刀光/循环动画。

源文件：`decompiled/fighters/lee/scripts/lee_fla/Timeline_7.as`（15 行）

## 如何挂上引擎

不直接挂钩 `$fighter_ctrler`。作为动作 MC 的子时间轴，由 [`FighterMC.renderChildren`](../../../../engine/game/bvn/fighter/FighterMC.md) 自动 `nextFrame`（名字不是 `AImain`/`bdmn`/`atm*` 才会推进）。标签 `stop` 会停（本文件用脚本 `stop()`，效果相同）。名字含 `atm` 的实例会被 `renderChildren` 跳过，当判定盒。

## 逐行说明

- **Embed** `source="/_assets/assets.swf", symbol="symbol28"`。
- **构造** L9–12：空 `super()`。无 `addFrameScript`。
