# `mc_win_all` — 通关长图（无脚本，纯美术）

一句话目的：全关卡通关祝贺页里，祝贺条播完后从屏下滚上来的静态长图。时间轴 1 帧，类体空，无帧脚本。

源文件：`decompiled/ui/common_ui/scripts/mc_win_all.as`（14 行）

## 如何挂上引擎

无名包导出。SWF char 20，`[Embed(symbol="symbol20")]`。链接名 `"mc_win_all"`。

仅 [`CongratulateState.playComplete`](../../../engine/game/bvn/state/CongratulateState.md)：

```
createDisplayObject(common_ui, "mc_win_all")
y = GAME_SIZE.y        // 先整个放在 600px 屏下
_ui.addChild(...)
```

随后 `GameRender` 每帧 `_ui.y -= 1` 往上推，滚过「FINAL SCORE」和 BACK（[`SetBtnGroup`](../../../engine/game/bvn/ui/SetBtnGroup.md)）。分数文本的 y = `win_all.y + win_all.height + 100`，所以本 MC 的高度（含内部 y≈841 的图）直接决定名单有多长。

引擎不 `gotoAndPlay`、不听 COMPLETE：没有可播的时间轴。

## 导出 / 尺寸

1 帧。F1 三层，无实例名：

| depth | 内容 | 位置 |
|-------|------|------|
| 1 | `DefineText` char 16，字体 微软雅黑，包围盒约 x 68–717、y 5–814 | `(2, 2)` |
| 2 | 353×226 图（与 `logo_movie` 同源位图 char 18） | `(317.8, 841.4)` |
| 3 | 同区域另一矢量/图，scale 0.461 | `(317.8, 841.8)` |

文本块竖向超过 800px，底下再叠角色图，所以这是一条要滚的「通关看板」，不是单屏贴图。具体字句未从 DefineText 解出。?

## 逐行说明

无名包。`public dynamic class mc_win_all extends MovieClip`。无字段。

### `mc_win_all()`（L9–12）

- L11: `super();` — 空构造。无 `addFrameScript`。时间轴停在唯一的 F1，循环与否无可见差别。
