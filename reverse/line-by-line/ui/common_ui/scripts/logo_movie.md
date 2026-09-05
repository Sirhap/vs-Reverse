# `logo_movie` — 片头 Logo（F1 停 / F66 COMPLETE）

一句话目的：启动后第一屏片头 MC。F1 `stop`；播到 F66 `stop` 并派 `Event.COMPLETE`。[`LogoState`](../../../engine/game/bvn/state/LogoState.md) `gotoAndPlay(2)` 跳过停帧，听 `complete` 后 `goMenu()`。

源文件：`decompiled/ui/common_ui/scripts/logo_movie.as`（26 行）

## 如何挂上引擎

无名包导出。SWF char 26，`[Embed(symbol="symbol26")]`。链接名 `"logo_movie"`。

[`LogoState.build`](../../../engine/game/bvn/state/LogoState.md)：

1. `ResUtils.I.createDisplayObject(ResUtils.I.common_ui, "logo_movie")` → `_ui`（顺带按 `soundVolume` 写 Sprite 音量；本剪辑无帧音效）。
2. `_ui.addEventListener("complete", playComplete)`（字面量 `"complete"`，即 `Event.COMPLETE`）。
3. `_ui.gotoAndPlay(2)`：跳过 F1 的 `stop`，从 F2 播到 F66。

`display` 返回这份 MC，`KyoStageCtrl.goStage` addChild。`playComplete` 卸监听后 `MainGame.I.goMenu()`。`destory` 只再卸一次监听，不 `stop` 时间轴。

入口：`MainGame.goLogo()`（`bleachvsnaruto_2.initBackHandler` 在 `GameLoadingState` 成功且 `GameUtils.isInTop` 之后；通关 [`CongratulateState`](../../../engine/game/bvn/state/CongratulateState.md) BACK、[`GameOverState`](../../../engine/game/bvn/state/GameOverState.md) BACK 也会 `goLogo`）。`goLogo` 顺带 `setFPS(30)`，与本 SWF 30fps 对齐。约 65 帧 ≈ 2.2s。

## 时间轴（SWF，66 帧）

无帧标签。F1 已放置的对象会一直留到 F66 才 `RemoveObject`，所以 `gotoAndPlay(2)` 不会丢掉画面。

| 帧 | 内容 |
|----|------|
| F1 | depth1：小矢量放大当底（scale ≈ 4.46×5.94，xy ≈ 33.5, 32.6）。depth2：353×226 Logo 图（xy ≈ 233, 182，接近 800×600 居中）。帧脚本 `stop` |
| F2–F20 | depth2 连续 `PlaceFlagHasColorTransform`（淡入） |
| F21–F45 | 停住画面（无新 Place） |
| F46–F65 | depth2 再跑一段 Cxform（淡出）? |
| F66 | 卸 depth1/2；`stop` + `Event.COMPLETE` |

Logo 位图：Lossless2 353×226（char 18 → shape 19）。

## 逐行说明

无名包。`public dynamic class logo_movie extends MovieClip`。无公开字段。

### `logo_movie()`（L10–14）

- L12: `super();`
- L13: `addFrameScript(0, this.frame1, 65, this.frame66);` — 下标 0 = **F1**，下标 65 = **F66**。

### `frame1`（时间轴 F1，L16–19）

- L18: `stop();` — 实例化后停在片头第一帧。引擎必须 `gotoAndPlay(2)` 才会动。

### `frame66`（时间轴 F66，L21–25）

- L23: `stop();`
- L24: `dispatchEvent(new Event(Event.COMPLETE));` — `LogoState.playComplete` 的唯一信号。之后画面已 Remove，舞台上这份 MC 要等 `goMenu` → `destory` 才从显示列表拿掉。
