# `selected_item_p1_mc` — P1 已选 / 出战条

一句话目的：左侧脸条皮肤。子件 `ct` 类型是 [`ctmc`](ctmc.md)。选人底部叠图和加载屏出战顺序都 `new` 本类；[`SelectedFighterUI`](../../../engine/game/bvn/ui/select/SelectedFighterUI.md) 用 `ui is selected_item_p1_mc` 决定右对齐字和角标 x。

源文件：`decompiled/ui/select/scripts/selected_item_p1_mc.as`（16 行）

## 如何挂上引擎

两处拿 Class：

1. [`SelectUIFactory.createSelecter(1)`](../../../engine/game/bvn/ui/select/SelectUIFactory.md)：`getItemClass(ResUtils.I.select, "selected_item_p1_mc")` → [`SelectedFighterGroup`](../../../engine/game/bvn/ui/select/SelectedFighterGroup.md) `new _uiClass()`。组坐标 `(10, GAME_SIZE.y-80)` = `(10, 520)`。
2. [`SelectIndexUI.buildItems`](../../../engine/game/bvn/ui/select/SelectIndexUI.md)：直接 `Class = selected_item_p1_mc`，[`SelectIndexUIGroup.build`](../../../engine/game/bvn/ui/select/SelectIndexUIGroup.md) 每人 `new SelectedFighterUI(new param1())`。出战顺序 **不用** `SelectedFighterGroup`。

`SelectedFighterUI` 对 P1 分支：

| 点 | P1（`is selected_item_p1_mc`） |
|---|---|
| 中文名 | 14 白 **right**，`width = ui.width-10`，无 x（靠右对齐），`y = ui.height-25` |
| `seltwzmc` 出战序号 | `x = -8`，`y = -5`，`gotoAndStop(1/2/3)` |
| `seltwzmc` 辅助角标 | 同样 `x = -8`，`gotoAndStop(4)` |
| `setFighter` | `ui.getChildByName("ct") as ctmc`（即本字段 `ct`）。dump 在取到后截断，脸图可能不会 `addChild` 到 `ct.ct`，见 SelectedFighterUI.md |

选人底部不 `mouseEnabled`；出战顺序人物条才开鼠标。

SWF：`select`，链接名 `selected_item_p1_mc`，`symbol="symbol87"`。镜像见 [`selected_item_p2_mc`](selected_item_p2_mc.md)。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class selected_item_p1_mc extends MovieClip`。[Embed] `symbol="symbol87"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `ct` | `ctmc` | 实例名也是 `"ct"`。嵌套再有 `ctmc.ct` 才是真正脸槽。类型写死为本 SWF 的 `ctmc`，不是普通 `MovieClip` |

### 构造 `selected_item_p1_mc()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`。静态条。
