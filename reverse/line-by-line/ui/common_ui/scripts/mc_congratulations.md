# `mc_congratulations` — 通关祝贺条动画（F50 COMPLETE）

一句话目的：全关卡通关页片头。约 50 帧把 750×93「祝贺」条砸进画面，F3 打一记 MP3，F50 `stop` 并派 `Event.COMPLETE`。[`CongratulateState`](../../../engine/game/bvn/state/CongratulateState.md) 听完再滚出 `mc_win_all`。

源文件：`decompiled/ui/common_ui/scripts/mc_congratulations.as`（21 行）

## 如何挂上引擎

无名包导出。SWF char 25，`[Embed(symbol="symbol25")]`。链接名 `"mc_congratulations"`，引擎常量 [`ResUtils.CONGRATULATIONS`](../../../engine/game/bvn/utils/ResUtils.md)。

`CongratulateState.build`：

1. 根 Sprite + `cover_bgimg` 底图（底图类在 `loading` SWF，因共用 `currentDomain` 才能从 `common_ui` 这个 Class 参数取到）。
2. `createDisplayObject(common_ui, ResUtils.CONGRATULATIONS)`，addChild 到滚动层 `_ui`。
3. `addEventListener("complete", playComplete, false, 0, true)`（弱引用）。
4. `gotoAndPlay(2)`。
5. BGM `"congratulation"`（ZIP 音，不是本 MC 的帧音）。

本类 **没有 F1 `stop`**。`new` 之后时间轴会自己从 F1 往前走；引擎立刻 `gotoAndPlay(2)`，等于只跳过第一帧。`createDisplayObject` 会把 `soundTransform.volume` 写成 `GameData.I.config.soundVolume`，F3 的 `StartSound` 跟全局音量。

`playComplete` 里才 `createDisplayObject(..., "mc_win_all")` 并开始上滚。见 [`mc_win_all`](mc_win_all.md)。

## 时间轴（SWF，50 帧）

无帧标签。主图形 Lossless2 750×93（char 21 → shape 22）。

| 帧 | 内容 |
|----|------|
| F1–F10 | 条从左侧大缩放飞入：scale 3.29→1.0，x -820→40，y 153→260 |
| F3 | `StartSound`：DefineSound 23，MP3，~11kHz 单声道，21182 samples ≈ 1.9s |
| F10–F20 | 第二份同图在 depth2 轻微放大/左移（「砸实」余震） |
| F21 | 卸 depth2 |
| F22–F40 | depth2 换 shape 24（约 139×105 闪光块）从 x≈-91 扫到 x≈819；depth3 再压一条祝贺图 |
| F41 | 卸 depth2/3，留下 F10 定位好的主条 |
| F42–F49 | 静止 |
| F50 | `stop` + `Event.COMPLETE` |

## 逐行说明

无名包。`public dynamic class mc_congratulations extends MovieClip`。无公开字段。

### `mc_congratulations()`（L10–14）

- L12: `super();`
- L13: `addFrameScript(49, this.frame50);` — 下标 49 = 时间轴 **F50**。没有给 F1 挂脚本。

### `frame50`（时间轴 F50，L16–20）

- L18: `stop();`
- L19: `dispatchEvent(new Event(Event.COMPLETE));` — `CongratulateState.playComplete` 入口。祝贺条停在屏上，后面的名单/分数/BACK 是引擎往同一 `_ui` 里加的，不是本 MC 的后续帧。
