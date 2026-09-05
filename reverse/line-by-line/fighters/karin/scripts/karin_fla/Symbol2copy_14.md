# `karin_fla.Symbol2copy_14` — 空元件 `Symbol2copy_14`

一句话目的：库元件 `Symbol2copy_14`：无 ctrler 回调，末帧 `stop()`。含判定盒子件 `cbs1atm`。多半是特效/刀光/循环动画。

源文件：`decompiled/fighters/karin/scripts/karin_fla/Symbol2copy_14.as`（36 行）

## 如何挂上引擎

不直接挂钩 `$fighter_ctrler`。作为动作 MC 的子时间轴，由 `FighterMC.renderChildren` 自动 `nextFrame`（名字不是 `AImain`/`bdmn`/`atm*` 才会推进）。标签 `stop` 会停（本文件用脚本 `stop()`，效果相同）。名字含 `atm` 的实例会被 `renderChildren` 跳过，当判定盒。

## 逐行说明

- **Embed** `source="/_assets/assets.swf", symbol="symbol309"`。
- **构造** L24–28：`addFrameScript` 注册末帧。
- **`frame7`（时间轴 F7，L30–33）**：`stop();` — 停时间轴
