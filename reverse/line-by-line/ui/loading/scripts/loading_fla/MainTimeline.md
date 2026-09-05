# `loading_fla.MainTimeline` — loading.swf 文档类

一句话目的：loading.swf 根时间轴。F1 `stop()`。引擎从不 `new MainTimeline()` 当显示对象；只把 SWF 当类库 `loadBytes`。

源文件：`decompiled/ui/loading/scripts/loading_fla/MainTimeline.as`（33 行）

## 如何挂上引擎

[`ResUtils.InsSwf`](../../../../engine/game/bvn/utils/ResUtils.md) 构造：`new loading_swf$…()` 取 `movieClipData`，`Loader.loadBytes` 进 `ApplicationDomain.currentDomain`。Loader 的 **content** 会是本类实例（文档类），构造里 `addFrameScript` 后 F1 `stop`。引擎从不 `addChild` 这个 Loader，也不读 content——只要域里的导出类（`loading_cover_mc`、`winner_stg_mc` 等）。

本类无 `[Embed]`（文档类不是链接元件）。无 public 子件字段。

## 逐行说明

- **L1**：`package loading_fla`。
- **L3–16**：FFDec 灌的 flash.* 通配 import，本文件只用到 `MovieClip`。
- **L18**：`public dynamic class MainTimeline extends MovieClip`。
- **L21–24 构造**：`super()`；`addFrameScript(0, this.frame1)`。**addFrameScript 0 = F1**。
- **L26–30 `frame1`**：`stop();` —— 根轴停在封面/空帧，避免文档类自己播完整时间轴。导出元件各有自己的时间轴，不受这句影响。
