# `common_ui_fla.wzimg_bgimg_5` — 主菜单钮高亮条（`mc_wzbtn.bg`）

一句话目的：主菜单按钮里那条 388×75 高亮底图。两帧：F1 普通、F2 展开/子项。F1 `stop`。引擎从不按这个名字 `createDisplayObject`，只作为 `mc_wzbtn` 的实例名 `bg` 出现。

源文件：`decompiled/ui/common_ui/scripts/common_ui_fla/wzimg_bgimg_5.as`（20 行）

## 如何挂上引擎

SWF char 13，`[Embed(symbol="symbol13")]`，链接名 `common_ui_fla.wzimg_bgimg_5`。父剪辑 [`mc_wzbtn`](../mc_wzbtn.md)（char 14 / symbol14）在自己的 F1 把本元件 `PlaceObject` 到 depth 1，**实例名 `bg`**，偏移 `(0, -5)`。

[`MenuBtn`](../../../../engine/game/bvn/ui/MenuBtn.md) 只 `createDisplayObject(common_ui, "mc_wzbtn")`，然后当 `ui.bg` 用：

| 引擎动作 | 对本元件 |
|----------|----------|
| 构造 | `mouseEnabled = mouseChildren = false`，`visible = false`（默认不高亮） |
| `hover` | `visible = true`，从 `scaleX=0.01` tween 回原值（仍停 F1） |
| `normal` | `visible = false`（`_isOpen` 则 return） |
| `openChild` | `gotoAndStop(2)` |
| `closeChild` | `gotoAndStop(1)` |
| `childMode` | `scaleY=0.75` `scaleX=0.9` 且 `gotoAndStop(2)`（子项默认用展开帧） |

约定：帧 1 普通高亮 / 帧 2 展开或子项。见 MenuBtn 文档「`mc_wzbtn` 约定」。

## 逐行说明

包 `common_ui_fla`。`public dynamic class wzimg_bgimg_5 extends MovieClip`。无公开字段。时间轴 **2 帧**，无标签。

SWF 画：

- F1：shape 10，位图 388×75（Lossless2 char 9），包围盒约 388×75，锚在水平中心。
- F2：shape 12，另一张 388×75（Lossless2 char 11）。`PlaceFlagHasCharacter` 换图，坐标不改。

两张都是菜单条皮肤；F2 偏「展开/子项」态（具体像素差看图）。?

### `wzimg_bgimg_5()`（L9–12）

- L11: `super();`
- L12: `addFrameScript(0, this.frame1);` — 下标 0 = **F1**。

### `frame1`（时间轴 F1，L14–17）

- L16: `stop();` — 默认停 F1。没有引擎 `gotoAndStop(2)` 就不会自己走到展开帧。无 `Event.COMPLETE`。
