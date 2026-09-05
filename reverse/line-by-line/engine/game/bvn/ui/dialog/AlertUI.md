# `AlertUI` — 单钮 OK 提示框

一句话目的：全屏半透明 + 居中黑条，英文位图标题 + 可选中文 + `SetBtnGroup`「OK」。只由 `GameUI.alert` 创建，OK 走 `closeBack`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/dialog/AlertUI.as`（113 行）

## Callers / callees

- **Callers**：只 `GameUI`。
  - `alert`：`closeAlert` 后 `new AlertUI()`，`setMsg(en, cn)`，`closeBack = closeBack` 闭包（调调用方 close → `closeAlert` → `["close_alert"]`），`root.addChild`。
  - `closeAlert`：`removeChild` + `destory`。
  - 业务入口：`MenuState.afterBuild` `GameUI.alert("UPDATE", UPDATE_INFO)`（首次运行更新说明）。本包无其它 `alert`。
- **Callees**：`Box`（宽 `GAME_SIZE.x`、高 400、黑 0.8）；`BitmapFontText(font1)`；`UIUtils.formatText`；`SetBtnGroup`（横排 OK）；`TweenLite` 0.2s 从屏幕底滑入；`GameUI.SHOW_CN_TEXT`；`AssetManager.getFont("font1")`。

`MenuBtnGroup.render` / `SelectIndexUIGroup` 等见 `GameUI.showingDialog()` 为真就停键，更新弹窗期间菜单不走。

## 命名备注

`destory` 保留。按钮 label `"OK"` / cn `"知道了"`。与 `ConfrimUI` 同骨架，差别：一条钮、Box 更高（400 vs 300）、中文区 `leading:10` 且 height 300（长更新文案）、`closeBack` 而不是 yes/no。

`setMsg` **不**判断 `_cnTxt` 是否存在。`SHOW_CN_TEXT==false` 时构造不建 `_cnTxt`，再 `setMsg` 会 NPE。本包 `SHOW_CN_TEXT` 恒 true，壳若关掉必须先改这里。`ConfrimUI.setMsg` 有 `if(_cnTxt)` 守卫。

## 逐行说明

### 字段 / 构造（L18–30）

`_enTxt` / `_cnTxt` / `_btnGroup` / `closeBack`。构造立刻 `build()`。

### `destory`（L32–45）

`_enTxt.dispose()`；卸 SELECT、`SetBtnGroup.destory`。不 destory `_cnTxt`（普通 TextField）。`GameUI.closeAlert` 已从 root 卸掉本 Sprite。

### `build`（L47–92）私有

1. 全屏 `Sprite` 黑 0.3，挡点击。
2. `Box(GAME_SIZE.x, 400, 0, 0.8)`，垂直居中。内容都挂在 Box 上。
3. `_enTxt = BitmapFontText(font1)`，`y=18`。此时 text 空，宽度 0；`setMsg` 再水平居中。
4. `SHOW_CN_TEXT`：建 `TextField`，`UIUtils.formatText` 居中白 20px `leading:10`，`y = enTxt.y + enTxt.height + 80`（enTxt 此时高度是空字高度），宽 800、高 300、禁鼠标。
5. `SetBtnGroup`：`startX/startY=0`，`direct=0`（横排），`gap=200`。数据 `[{label:"OK", cn:"知道了"}]`，`setBtnData(..., 1)` —— 只有一钮，箭头 index 1 会被 `setArrowIndex` 折成 0。听 SELECT。
6. 组坐标：`x = (GAME_SIZE.x - width)/2 + 30`（+30 给左侧箭头留空），`y = Box.height - 80`。
7. 记下居中 y，把 Box 放到 `GAME_SIZE.y`（屏外下方），`TweenLite.to(..., 0.2, {y:居中})`。

`_temp_4` 是反编译对 `startX/startY` 连续赋值的别名。

### `selectHandler`（L94–104）私有

`selectedLabel === "OK"` 且 `closeBack != null` 则调用。其它 label 忽略。不自己 `removeChild`；`closeBack` 里 `GameUI.closeAlert` 拆实例。

### `setMsg`（L106–111）

`(en=null, cn=null)`。英文空则 `""`。按当前位图宽水平居中。中文直接 `_cnTxt.text = cn ? cn : ""`，无 null 守卫。`MenuState` 传 `"UPDATE"` + 长 `UPDATE_INFO`。
