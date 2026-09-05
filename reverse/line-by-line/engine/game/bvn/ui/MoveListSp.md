# `MoveListSp` — 出招表全屏图

一句话目的：暂停菜单「MOVE LIST」弹出的全屏 JPG + 底部 BACK。`PauseDialog` 懒创建，BACK 经 `onBackSelect` 回到暂停三项。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/MoveListSp.as`（71 行）

## Callers / callees

- **Callers**：只 `PauseDialog`。
  - `showMoveList`：无实例则 `new MoveListSp()`，`onBackSelect = hideMoveList`，`addChild`，再 `show()`。
  - `hideMoveList`：`hide()`。
  - `PauseDialog.destory`：`_moveList.destory()`。
- **Callees**：嵌入 JPG 类 `_picClass`（反编译混淆名 `movelist_jpg$…`）；`SetBtnGroup`（单钮 BACK）；`GameConfig.GAME_SIZE` 拉伸到 800×600；`flash.utils.setTimeout`。

## 命名备注

`destory` 保留。`onSelect` 参数类型写成 `Event` 而不是 `SetBtnEvent`，`SetBtnGroup` 再派发的仍是 `SetBtnEvent`（extends Event），不读 `selectedLabel`（只有 BACK 一钮）。

## 逐行说明

### 字段 / 构造（L12–36）

- `_picClass`：嵌入出招表位图。`new _picClass()` 得到 `Bitmap`。
- `_pic`：拉到 `GAME_SIZE`（800×600），`addChild` 垫底。
- `_btns`：`new SetBtnGroup()`，`setBtnData([{label:"BACK", cn:"返回"}])`（第二实参默认 0，箭头落在唯一钮）。听 `"SELECT"`。坐标 (250, GAME_SIZE.y-130)。
- `onBackSelect`：构造时 null，`PauseDialog` 赋值。

### `destory`（L38–46）

有 `_btns` 则卸 SELECT、`destory()` 置空。**不** `bitmapData.dispose`、不卸 `_pic`。随 `PauseDialog` 一起被拆。

### `show`（L48–55）

`visible=true`。`setTimeout` 100ms 后 `_btns.keyEnable=true`。延迟是为了躲开刚按 MOVE LIST 的那次 SELECT/确认键，避免出招表一开就被同一帧 BACK 关掉。

### `hide`（L57–61）

立刻 `keyEnable=false`，`visible=false`。实例留在 `PauseDialog` 里，下次 MOVE LIST 复用，不再 `new`。

### `onSelect`（L63–69）私有

任意 SELECT（只可能是 BACK）且 `onBackSelect != null` 则调用。`PauseDialog.hideMoveList`：`hide()` + 恢复暂停三项 `keyEnable` + 派 `["move_list_cancel"]`。
