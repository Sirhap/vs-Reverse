# `slt_item_mc` — 选人网格一格

一句话目的：`select.xml` 一格的脸框。子件 `ct` 塞 50×50 脸图。逻辑在 [`SelectFighterItem`](../../../engine/game/bvn/ui/select/SelectFighterItem.md)，本类只是皮。

源文件：`decompiled/ui/select/scripts/slt_item_mc.as`（16 行）

## 如何挂上引擎

`SelectFighterItem.ui` 字段初始化就 `createDisplayObject(ResUtils.I.select, "slt_item_mc")`。舞台 [`SelectFighterStage.addFighterItem`](../../../engine/game/bvn/state/SelectFighterStage.md) 成功才 `_ui.addChild(item.ui)`，字典键 `"x,y"`。

引擎用法：

| 调用 | 效果 |
|---|---|
| `AssetManager.I.getFighterFace(vo)` → `ui.ct.addChild` | 默认 50×50。无图则空框仍占格 |
| `ui.mouseChildren = false` | 点到框本身，不点穿脸 Bitmap |
| `ui.buttonMode = true` | 手型 |
| 舞台听 `ui` 的 `"mouseOver"` / `"click"`（或 `"touchTap"`） | `SelectFighterItem.addEventListener` 把事件转成 `(type, item)` |

空 id / 缺 VO 根本不 `new`，不进 `_itemObj`。辅助阶段脸走 `AssisterModel` 的 `faceUrl`。

SWF：`select`，链接名 `slt_item_mc`，`symbol="symbol79"`。与光标 [`select_item_mc`](select_item_mc.md) 不是同一个。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class slt_item_mc extends MovieClip`。[Embed] `symbol="symbol79"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `ct` | `MovieClip` | 脸容器。`SelectFighterItem` 构造把 `getFighterFace` 丢进来。引擎声明了 `faceSize=(50,50)` 但从未读，尺寸是 `getFighterFace` 默认 |

### 构造 `slt_item_mc()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`。静态框。
