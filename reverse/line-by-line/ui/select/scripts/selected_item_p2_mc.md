# `selected_item_p2_mc` — P2 已选 / 出战条

一句话目的：右侧脸条皮肤。子件同样是 [`ctmc`](ctmc.md)。工厂 / 出战组用本 Class；`SelectedFighterUI` 的 `else` 分支（不是 `selected_item_p1_mc`）走左对齐字和靠右角标。

源文件：`decompiled/ui/select/scripts/selected_item_p2_mc.as`（16 行）

## 如何挂上引擎

1. [`SelectUIFactory.createSelecter(2)`](../../../engine/game/bvn/ui/select/SelectUIFactory.md)：`getItemClass(..., "selected_item_p2_mc")` → [`SelectedFighterGroup`](../../../engine/game/bvn/ui/select/SelectedFighterGroup.md)。组 x = `GAME_SIZE.x-265` = 535，y=520。
2. [`SelectIndexUI.buildItems`](../../../engine/game/bvn/ui/select/SelectIndexUI.md)：`Class = selected_item_p2_mc` 交给 P2 [`SelectIndexUIGroup`](../../../engine/game/bvn/ui/select/SelectIndexUIGroup.md)。

[`SelectedFighterUI`](../../../engine/game/bvn/ui/select/SelectedFighterUI.md) 非 P1：

| 点 | P2 |
|---|---|
| 中文名 | 14 白 **left**，`x=10`，`width = ui.width-10`，`y = ui.height-25` |
| `seltwzmc` 出战序号 | `x = 252 - width`（靠右），`y = -5` |
| `seltwzmc` 辅助 | **写死 `x=176`**（和人物公式不同，辅助条更窄或角标位不同） |
| `setFighter` | 同样 `getChildByName("ct") as ctmc`；截断问题两边一样 |

`createSelecter(0)` 也会走 P2 链接名（工厂 `param1==1` 才是 P1）。本包只传 1/2。

SWF：`select`，链接名 `selected_item_p2_mc`，`symbol="symbol84"`。镜像见 [`selected_item_p1_mc`](selected_item_p1_mc.md)。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class selected_item_p2_mc extends MovieClip`。[Embed] `symbol="symbol84"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `ct` | `ctmc` | 与 P1 同结构。脸应进 `ct.ct` |

### 构造 `selected_item_p2_mc()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`。
