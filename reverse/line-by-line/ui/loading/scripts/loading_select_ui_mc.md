# `(无名包).loading_select_ui_mc` — 战前加载的选人/进度层

一句话目的：[`loading_fight_mc`](./loading_fight_mc.md) 上名为 `sltui` 的一层。自带 [`loadingbar_mc`](./loadingbar_mc.md)；引擎再把 [`SelectIndexUI`](../../../engine/game/bvn/ui/select/SelectIndexUI.md) `addChild` 进来排出场顺序。无时间轴脚本。

源文件：`decompiled/ui/loading/scripts/loading_select_ui_mc.as`（17 行）

## 如何挂上引擎

不单独 `createDisplayObject`。随 [`loading_fight_mc`](./loading_fight_mc.md) 实例化，[`LoadingState`](../../../engine/game/bvn/state/LoadingState.md) L119 取 `_ui.sltui` 存成 `_sltUI:loading_select_ui_mc`。

| 引擎 | 路径 | 作用 |
|------|------|------|
| `build` | `_sltUI.addChild(_selectIndexUI)` | 出战顺序 UI（左右 `SelectIndexUIGroup`） |
| `loadProcess` | `_sltUI.bar.bar.scaleX` | 当前这项加载进度 0..1 |
| `updateMsg` | `_sltUI.bar.txt.text` | 「正在加载角色：…(i/N)」 |
| `loadFin` | `TweenLite.to(_sltUI, 1, {y:80})` | 队列空后整层上移 1s，再等 2s 才 `_loadFin=true` |

`bar` 与封面加载条是同一导出类 [`loadingbar_mc`](./loadingbar_mc.md)，两套舞台实例。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(..., symbol="symbol99")]`。
- **L6**：`public dynamic class loading_select_ui_mc extends MovieClip`。
- **L9**：`public var bar:loadingbar_mc;` —— 本层进度条。`SelectIndexUI` 不走这个字段，是额外 addChild 的 Sprite。
- **L11–14 构造**：`super()`。无 `addFrameScript`。
