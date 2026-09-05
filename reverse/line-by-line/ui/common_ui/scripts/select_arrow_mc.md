# `select_arrow_mc` — 公共选中箭头（循环闪）

一句话目的：设置列表 / 游戏结束页左边那枚箭头。类体空；SWF 14 帧对 34×37 箭头做 Cxform 循环，没有 `stop`，实例化后自己闪。

源文件：`decompiled/ui/common_ui/scripts/select_arrow_mc.as`（14 行）

## 如何挂上引擎

无名包导出。SWF char 8，`[Embed(symbol="symbol8")]`。链接名 `"select_arrow_mc"`。

两处 `ResUtils.I.createDisplayObject(ResUtils.I.common_ui, "select_arrow_mc")`：

1. [`SetBtnGroup.initArrow`](../../../engine/game/bvn/ui/SetBtnGroup.md)（L435–439）：`addChild` 后 `setArrowIndex`。箭头放到 `btn.x - 10`、`btn.y + 15`。设置页、暂停 [`PauseDialog`](../../../engine/game/bvn/ui/PauseDialog.md)、通关 BACK、制作组 BACK 都走 Group。
2. [`GameOverState.initArrow`](../../../engine/game/bvn/state/GameOverState.md)（L128–142）：加到 `stg_gameover_mc` 上，对齐 `btn_yes` / `btn_no` / `btn_back`。

引擎不 `gotoAndStop`、不听 COMPLETE：时间轴自己 loop。`destory` 时从显示列表拿掉即停。

**不是**选人箭头。选人用的是 `select` / `loading` SWF 里的 `select_arrow_mc_1` / `select_arrow_mc_2`（[`SelectIndexUI`](../../../engine/game/bvn/ui/select/SelectIndexUI.md)）。链接名不同，不要混。

## 导出 / 尺寸

14 帧，无标签、无帧脚本。F1 放置 shape 7（位图 Lossless2 34×37，包围盒约 34×37）于 `(-12, 1)`。F2–F14 只改 ColorTransform（`PlaceFlagMove | HasColorTransform`），坐标不变，播完回到 F1 循环。30fps 下一圈约 0.47s。

## 逐行说明

无名包。`public dynamic class select_arrow_mc extends MovieClip`。无字段。

### `select_arrow_mc()`（L9–12）

- L11: `super();` — 空。无 `addFrameScript`，因此不会停，14 帧闪烁一直转。
