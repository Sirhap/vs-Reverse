# `title_fla.logomc_3` — 标题平台 Logo 层

一句话目的：挂在 [`stg_title.logo_mc`](../stg_title.md) 上的 1 帧 Logo 容器。三个子 Logo（5dplay / 论坛 / Android）默认整棵 `visible=false`。本包 `initTitleUI` 是空实现，三个都不亮。?

源文件：`decompiled/ui/title/scripts/title_fla/logomc_3.as`（27 行）

## 如何挂上引擎

不单独 `createDisplayObject`。SWF SymbolClass `(19, 'title_fla.logomc_3')`；[`stg_title`](../stg_title.md) F1 PlaceObject2 cid=19 实例名 `logo_mc`。所以 `stg_title.logo_mc` **就是** 本类实例（AS 字段类型写成 `MovieClip`）。

[`MenuState.build`](../../../../engine/game/bvn/state/MenuState.md) 在 `gotoAndStop(1)` 之后调 [`GameInterface.instance.initTitleUI(_ui)`](../../../../engine/game/bvn/interfaces/IGameInterface.md)。本包 [`GameInterfaceManager.initTitleUI`](../../../../engine/game/bvn/web/GameInterfaceManager.md) **空**。渠道包可在这里：

- `logo_mc.visible = true`
- 再只显示 `logo_5dplay` / `logo_5dplay_bbs` / `logo_android` 其中一个

没有渠道代码进仓库，三个子件是否互斥、默认显谁，**未验证**（标 `?`）。F1 脚本把 **整个** `logomc_3` 藏掉，子件自身没有再 `visible=false`。

SWF：`title_swf`（id 2215），`symbol="symbol19"`。Sprite id=19，1 帧。三个子 Sprite：cid 8 `logo_5dplay`、cid 11 `logo_5dplay_bbs`、cid 18 `logo_android`，都是 1 帧图。

## 字段

| L | 名字 | 类型 | 含义 |
|---|------|------|------|
| L9 | `logo_5dplay` | `MovieClip` | play5d / 5dplay 站 Logo |
| L11 | `logo_5dplay_bbs` | `MovieClip` | 5dplay 论坛 Logo |
| L13 | `logo_android` | `MovieClip` | Android 渠道 Logo |

引擎本包不读这些名字。`stg_title` 只暴露父级 `logo_mc`。

## 逐行说明

- **L1**：`package title_fla`。
- **L3**：`import flash.display.MovieClip;`。
- **L5**：`[Embed(source="/_assets/assets.swf", symbol="symbol19")]`。
- **L6**：`public dynamic class logomc_3 extends MovieClip`。
- **L9–13**：三个 Logo 子件，见上表。
- **L15–19 构造**：`super()`；`addFrameScript(0, this.frame1);`
  - **addFrameScript 0 = F1**
- **L21–24 `frame1`**：`visible = false;` —— 进场立刻整层隐藏。无 `stop()`（本来就 1 帧）。无 COMPLETE。

片头/菜单段 `logo_mc` 一直在 `stg_title` 上，只是看不见。渠道若要露出，必须在 `initTitleUI`（或之后）改 `visible`；本包不会。
