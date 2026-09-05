# `ichigo_white2_fla.Timeline_4` — 空元件 `Timeline_4`

一句话目的：库元件 `Timeline_4`：无判定盒、无 ctrler 回调，末帧 `stop()`。多半是特效/刀光/循环动画。

源文件：`decompiled/fighters/fz/ichigo_white2/scripts/ichigo_white2_fla/Timeline_4.as`（34 行）

## 如何挂上引擎

不直接挂钩 `$fighter_ctrler`。作为动作 MC 的子时间轴，由 `FighterMC.renderChildren` 自动 `nextFrame`（名字不是 `AImain`/`bdmn`/`atm*` 才会推进）。标签 `stop` 会停（本文件用脚本 `stop()`，效果相同）。

## 逐行说明

- **Embed** `source="/_assets/assets.swf", symbol="symbol41"`。
- **构造** L22–26：`addFrameScript` 注册末帧。
- **`frame9`（时间轴 F9，L28–31）**：`stop()`。
