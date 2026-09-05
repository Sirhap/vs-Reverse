# `SelectUIFactory` — 选人光标 + 底部已选条

一句话目的：静态工厂。按玩家 1/2 `new SelecterItemUI`，灌 `inputType` / `SelectVO`，再配一条 `SelectedFighterGroup`（底部已选头像）。`SelectFighterStage._p1SelectedGroup/_p2SelectedGroup` 是死字段；真正的条是这里赋给 `SelecterItemUI.group` 的那条。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectUIFactory.as`（31 行）

## Callers / callees

- **Callers**：只 `SelectFighterStage.initSelecterP1` / `initSelecterP2`（L382 / L392）`createSelecter(1|2)`。之后舞台再写 `isSelectAssist`、`selectTimesCount`（小队人物 3，否则 1），`addChild` 光标 `ui` 和 `group`。
- **Callees**：`SelecterItemUI`、`SelectedFighterGroup`、`GameData.I.p1Select/p2Select`、`ResUtils.I.getItemClass(ResUtils.I.select, "selected_item_p1_mc"|"selected_item_p2_mc")`、`GameConfig.GAME_SIZE`（800×600）。
- **不经过本工厂**：出战顺序 UI 自己 `new SelectedFighterUI(new selected_item_p*_mc())`，不用 `SelectedFighterGroup`。

## 命名备注

| 符号 | 含义 |
|---|---|
| `createSelecter` | **Selecter** 不是 Selector。类名 `SelecterItemUI` 同样少一个 t。 |
| `param1==1` | P1，否则一律当 P2（`createSelecter(0)` 也会走 P2 分支）。本包只传 1/2。 |

SWF：`selected_item_p1_mc` / `selected_item_p2_mc`（`select` SWF）。组持有的是 **Class**，`addFighter` 时 `new _uiClass()`。

## 逐行说明

### 包与 import（L1–6）

无显示基类。纯静态。

### 空构造（L11–14）

外部不 `new`。AS3 仍会生成。

### `createSelecter`（L16–29）

`param1:int=1`。

1. `new SelecterItemUI(param1)`：内部取 `select_item_mc`，`mc` 停在帧 1（P1）或 2（P2），光标自己 `mouseEnabled=false`。
2. `inputType = param1==1 ? "P1" : "P2"`。VsCPU 稍后在 `nextStep` 把 P2 的改成 `"P1"`，工厂先按玩家号写。
3. `selectVO = p1Select / p2Select`。`initFighter` 已 `new SelectVO()`。街机辅助阶段 P2 光标不建，不经过这里。
4. 链接名 P1 `"selected_item_p1_mc"` / P2 `"selected_item_p2_mc"`。`getItemClass` 取 Class（不是实例）。
5. `new SelectedFighterGroup(_loc3_)`。坐标：P1 `(10, GAME_SIZE.y-80)` = `(10, 520)`；P2 `(GAME_SIZE.x-265, 520)` = `(535, 520)`。
6. `addFighter(null)`：先丢一张空卡片当「当前预览」槽。之后 `moveToSelectFighter` → `group.updateFighter` 往这张填脸。小队确认未满员时 `SelecterItemUI.select` 再 `addFighter(currentFighter)` 叠下一张。
7. `_loc2_.group = _loc4_`。返回光标。

工厂 **不** `addChild`。舞台 `initSelecterP*` 把 `slt.ui` 和 `slt.group` 挂到 `_ui`。

`selectTimes` 仍是 0，`selectTimesCount` 仍是类默认 1，舞台下一行才改成 3。`isSelectAssist` 默认 false，舞台按 `_selectState==1` 写。
