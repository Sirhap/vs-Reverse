# `sasuke_xz_old_fla.Timeline_11` — 空元件 `Timeline_11`

一句话目的：库元件 `Timeline_11`：无 ctrler 回调，末帧 `stop()`。多半是特效/刀光/循环动画。

源文件：`decompiled/fighters/sasuke_xz_old/scripts/sasuke_xz_old_fla/Timeline_11.as`（34 行）

## 如何挂上引擎

不直接挂钩 `$fighter_ctrler`。作为动作 MC 的子时间轴，由 `FighterMC.renderChildren` 自动 `nextFrame`（名字不是 `AImain`/`bdmn`/`atm*` 才会推进）。标签 `stop` 会停（本文件用脚本 `stop()`，效果相同）。名字含 `atm` 的实例会被 `renderChildren` 跳过，当判定盒。

## 逐行说明

- **Embed** `source="/_assets/assets.swf", symbol="symbol574"`。
- **构造** L22–26：`addFrameScript(57, frame58);`
- **`frame58`（时间轴 F58，L28–31）**：`stop();` — 停时间轴
