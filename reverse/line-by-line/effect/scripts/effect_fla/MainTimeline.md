# `effect_fla.MainTimeline` — effect.swf 文档类（F1 停）

一句话目的：`assets/effect.swf` 的文档类。根时间轴 8 帧、30fps；F1 `stop`。引擎从不 `new` 本类，只把整份 SWF `addSwf` 进 `KyoClassLoader`，按 **链接名** `getClass`。

源文件：`decompiled/other/effect/scripts/effect_fla/MainTimeline.as`（20 行）

## 如何挂上引擎

[`AssetManager.loadBasic`](../../../engine/game/bvn/ctrl/AssetManager.md) 拉 ZIP 内 `assets/effect.swf`，完成后 [`KyoClassLoader.addSwf`](../../../engine/kyo/loader/KyoClassLoader.md)（id `"assets/effect.swf"`）。之后：

- `getEffect(className)` → `getClass(name, "assets/effect.swf")` → `new`
- [`MainGame.loadGameBack`](../../../engine/game/bvn/MainGame.md) → [`EffectModel.I.initlize`](../../../engine/game/bvn/data/EffectModel.md) 对表里每个 `className` `cacheBitmapData`

Loader 的 `content` 才是本 `MainTimeline`。引擎只留 domain，不把 content 加到舞台。F1 `stop` 防止这份 content 在内存里空转 8 帧循环。

根时间轴 8 帧、无场景标签、无导出实例。真正用的是 SymbolClass 里那 88 个链接（57 个 MC + 31 个 Sound；本类是 char 0）。

对照：UI 的 `common_ui_fla.MainTimeline` 同样 F1 停、同样只灌域。

ABC 调试路径习惯与 UI 相同（FLA 在 `…/fla/`）。本文件无 `[Embed]`——它就是这份 SWF 自己。

## 逐行说明

FLA 文档包 `effect_fla`。`public dynamic class MainTimeline extends MovieClip`。无公开字段。

### `MainTimeline()`（L9–13）

- **L11** `super();`
- **L12** `addFrameScript(0, this.frame1);` — 0-based 0 = 时间轴 **F1**。

### `frame1`（时间轴 F1，L15–18）

- **L17** `stop();` — 文档停在空白。F2–F8 空，到不了。

无其它函数。
