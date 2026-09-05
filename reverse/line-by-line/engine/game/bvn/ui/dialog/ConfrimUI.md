# `ConfrimUI` — YES/NO 确认框

一句话目的：与 `AlertUI` 同骨架的双钮确认。只由 `GameUI.confrim` 创建。YES/NO 分别走 `yesBack` / `noBack`（包装里会 `closeConfrim` 并派 `close_confrim`）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/dialog/ConfrimUI.as`（127 行）

## Callers / callees

- **Callers**：只 `GameUI`。
  - `confrim`：`closeConfrim` 后 `new ConfrimUI()`，`setMsg`，`yesBack`/`noBack` 设成先调业务再关框再派 `["close_confrim", true|false]`，`root.addChild`，派 `["show_confrim"]`。
  - `closeConfrim`：`removeChild` + `destory`。`PauseDialog.hide`、选人/加载 `destory`、再按 back 关掉已开框，都走这里。
  - 业务文案一律 `"BACK TITLE?"` / `"返回到主菜单？"`：
    - `SelectFighterStage` / `LoadingState`：yes → `MainGame.I.goMenu`。
    - `WinnerState.btn_exit`：同上。
    - `PauseDialog` GAME TITLE：yes → `["back_title"]` + `goMenu`；no → 恢复暂停键 + `["back_title_cancel"]`。
- **Callees**：`Box(GAME_SIZE.x, 300, 0, 0.8)`；`BitmapFontText(font1)`；`UIUtils.formatText`；`SetBtnGroup` YES/NO 横排；`TweenLite` 0.2s 滑入；`GameUI.SHOW_CN_TEXT`。

`showingDialog()` 为真时：`PauseDialog` 忽略三项 SELECT；`MenuBtnGroup` / `SelectIndexUIGroup` / 选人/加载 back 逻辑改关框而不是再弹一个。

## 命名备注

类名、`GameUI.confrim`、`_confrimUI`、`closeConfrim`、`destory`、`sndConfrim`（`SoundCtrl`，本类不调）全部保留错误拼写 Confirm。`SetBtn` 的 `optoinKey` 与本框无关。

与 `AlertUI` 的差异：Box 高 300（不是 400）；中文 TF 高 100、无 `leading`；两钮 YES/NO；`setMsg` **有** `_cnTxt` 空守卫。

## 逐行说明

### 字段 / 构造（L18–32）

`_enTxt` / `_cnTxt` / `_btnGroup` / `yesBack` / `noBack`。构造 `build()`。

### `destory`（L34–47）

同 Alert：dispose 位图字，卸 SELECT，`SetBtnGroup.destory`。不碰 `_cnTxt`。

### `build`（L49–96）私有

1. 全屏黑 0.3 遮罩。
2. `Box(800, 300, 黑, 0.8)` 垂直居中。
3. `_enTxt` y=18 挂上 Box。
4. `SHOW_CN_TEXT`：中文 TF，白 20 居中，`y = en + height + 80`，宽 800 高 100，禁鼠标。
5. `SetBtnGroup`：`startX/startY=0`，`direct=0`，`gap=200`。数据 YES「是」+ NO「否」，`setBtnData(..., 1)` → 箭头默认落在 **NO**（index 1）。听 SELECT。
6. 组 x 居中 +30，y = Box.height-80。
7. Box 从 `GAME_SIZE.y` Tween 0.2s 回到居中 y。

默认选 NO：回标题必须明确移到 YES 再确认，避免误触直接 `goMenu`。

### `selectHandler`（L98–114）私有

`switch(selectedLabel)`：`"YES"` → `yesBack()`；`"NO"` → `noBack()`。空回调则什么都不做（框会留着）。`GameUI.confrim` 总是两边都赋值（至少会 `closeConfrim`）。

本类 **不**自己关；关框是 back 里的 `closeConfrim`。若调用方 yes 里 `goMenu` 拆舞台，随后 `closeConfrim` 的 `removeChild` 进 catch，仍 `destory`。

### `setMsg`（L116–124）

英文空则 `""`，按位图宽水平居中。`if(_cnTxt)` 再写中文（`SHOW_CN_TEXT==false` 安全）。与 Alert 这点不同。
