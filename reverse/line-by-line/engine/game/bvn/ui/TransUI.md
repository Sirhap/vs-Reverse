# `TransUI` — `trans_mc` 淡入淡出遮罩

一句话目的：`common_ui` 的 `trans_mc`。`StateCtrl.transIn/transOut` 复用同一实例：`fadIn` 播到 `"stop"` 盖住画面，`fadOut` 揭开。自己挂 `GameRender` 按 30fps 对齐 `nextFrame`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/TransUI.as`（105 行）

## Callers / callees

- **Callers**：只 `StateCtrl`。
  - `addTransUI`：无则 `new TransUI()`，`root.addChild(_transUI.ui)`。
  - `transIn` → `fadIn(back 或 removeSelf)`。
  - `transOut` → `fadOut(...)`。
  - `removeTrainsUI`：try `removeChild(_transUI.ui)`，**保留实例**（不 `destory`）。`clearTrans` 只走这条。
- **Callees**：`ResUtils.I.createDisplayObject(common_ui, "trans_mc")`；`GameRender.add/remove(render)`；`MainGame.I.getFPS()` 算动画间隔。

`trans_mc`（`decompiled/ui/common_ui/scripts/trans_mc.as`）：时间轴帧脚本 1 / 26 / 61 各 `stop`，26/61 再 `Event.COMPLETE`。本类 **不听** COMPLETE，只看 `currentFrameLabel == "stop"` 并自己 `nextFrame`。标签 `fadin` / `fadout` / `stop` 在 SWF 里。

## 命名备注

`fadIn` / `fadOut` / `destory` 保留。SWF 标签是 `fadin`/`fadout`（无 e）。`StateCtrl.removeTrainsUI` trains ≠ trans。

`StateCtrl.clearTrans` 中途卸 display **不** `stopRender`：MC 不在舞台仍会 `nextFrame` 直到 `"stop"`，可能触发旧 `_fadInBack`。见 `StateCtrl.md`。本包 `destory` 无人调用（`removeTrainsUI` 复用实例）。

## 逐行说明

### 字段 / 构造（L10–26）

- `ui:trans_mc`：公开，`StateCtrl` 加/卸的是它不是 `TransUI` 实例（本类 **不是** DisplayObject）。
- `_renderAnimateGap` / `_renderAnimateFrame`：与 `GameUI` 同公式，但用 `MainGame.I.getFPS()` 不是 `GameConfig.FPS_GAME`。菜单 30fps → gap=0 每帧进；战斗 60fps → gap=1 隔帧进。转场时 `setFPS` 通常已是目标态帧率。
- `_fadInBack` / `_fadOutBack`：互斥，`fadIn` 清 Out，反之亦然。
- `_rendering` 默认 true，真正开关在 `startRender`/`stopRender`。
- 构造：`createDisplayObject` 建 `trans_mc`（顺带按 `soundVolume` 写 Sprite 音量）。

### `destory`（L28–31）

只 `GameRender.remove(render)`。不卸 `ui`、不回调、不清 `_rendering`。本包无调用。

### `startRender`（L33–39）私有

`gap = ceil(getFPS()/30)-1`，帧计数归零，`_rendering=true`，`GameRender.add(render)`。每次 fadIn/fadOut 都重加（`GameRender.add` 同回调应是替换/忽略重复，? 以 `GameRender` 实现为准）。

### `stopRender`（L41–45）私有

`_rendering=false` 且 `GameRender.remove`。只在撞到 `"stop"` 且两个 back 都空时调用。正常 fadIn 到 stop 会调 `_fadInBack` 然后 **return，不停 render** —— 停在 `"stop"` 帧继续每帧进 `render`，但 `renderAnimate` 一上来又是 `"stop"` 且 back 已 null，于是第二次才 `stopRender`。等于多跑一帧空转。

### `render`（L47–65）私有

`!_rendering` return。gap>0 则计数满才 `renderAnimate`，否则每 tick 一次。`GameRender` 按舞台帧率滴答。

### `renderAnimate`（L67–87）私有

1. `ui.currentFrameLabel == "stop"`：
   - `_fadInBack` 非空：调用并置空，return（**先不** `stopRender`）。
   - 否则 `_fadOutBack` 非空：同样。
   - 否则 `stopRender`。
2. 不是 stop：`ui.nextFrame()`。时间轴上的 `stop()` 帧脚本碰到也会停播放头，但本类不用 `play()`，只靠 `nextFrame` 推进，帧脚本的 stop 不影响下一 tick 再 next。

`fadin` 段播到标了 `"stop"` 的满屏遮罩帧；`fadout` 段播到另一处 `"stop"`（通常是透明/结束）。具体帧号以 SWF 为准；AS 侧只认 label。

### `fadIn`（L89–95）

清 `_fadOutBack`，存 `_fadInBack=param1`，`ui.gotoAndStop("fadin")`，`startRender()`。`StateCtrl.transIn` 默认不卸 UI，callback 里 `goStage`，遮罩停在 stop 盖住切态。

### `fadOut`（L97–103）

对称：清 In back，`gotoAndStop("fadout")`，`startRender()`。`StateCtrl.transOut` 默认播完 `removeTrainsUI`。
