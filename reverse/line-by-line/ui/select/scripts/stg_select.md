# `stg_select` — 选人舞台根 MC

一句话目的：`select` SWF 文档/根导出。选人、选辅助、选地图都挂在这棵树上。自身只有背景 `bg`；格子、光标、底条、地图层全是引擎 `addChild` 上去的。

源文件：`decompiled/ui/select/scripts/stg_select.as`（16 行）

## 如何挂上引擎

[`ResUtils.SELECT`](../../../engine/game/bvn/utils/ResUtils.md) = `"stg_select"`。[`SelectFighterStage.build`](../../../engine/game/bvn/state/SelectFighterStage.md) `createDisplayObject(ResUtils.I.select, ResUtils.SELECT)` 得到 `_ui`，`Istage.display` 返回它。

子件由代码往 `_ui` 上叠，**不是**时间轴预摆：

| 谁 | 链到哪 |
|---|---|
| [`SelectFighterItem`](../../../engine/game/bvn/ui/select/SelectFighterItem.md) | `_ui.addChild(item.ui)` → [`slt_item_mc`](slt_item_mc.md) |
| [`SelecterItemUI`](../../../engine/game/bvn/ui/select/SelecterItemUI.md) | `_ui.addChild(slt.ui)` → [`select_item_mc`](select_item_mc.md) |
| [`SelectedFighterGroup`](../../../engine/game/bvn/ui/select/SelectedFighterGroup.md) | `_ui.addChild(slt.group)`，P1 `(10,520)` / P2 `(535,520)` |
| [`MapSelectUI`](../../../engine/game/bvn/ui/select/MapSelectUI.md) | `_ui.addChild(mapSelectUI)`（Vs / 训练最后一步） |

空构造。无 `addFrameScript`。`bg` 引擎从不读写，只当背景图层。

SWF：`select_swf`（DefineBinaryData id 2210），链接名 `stg_select`，`symbol="symbol75"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class stg_select extends MovieClip`。[Embed] `source="/_assets/assets.swf", symbol="symbol75"`。`dynamic` 是时间轴导出类惯例，引擎不往上挂动态字段。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `bg` | `MovieClip` | 舞台底图。`SelectFighterStage` 全文不碰 `_ui.bg` |

### 构造 `stg_select()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`、无 `stop()`。时间轴若有多帧会自己播；本导出当静态底板用。格子弹出 / 淡出全是 `TweenLite` 改子件，不驱动本 MC。
