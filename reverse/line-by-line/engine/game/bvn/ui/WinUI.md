# `WinUI` — 回合胜场标记（bleach / naruto 入场）

一句话目的：血条上 `win_p1` / `win_p2`（`winmc`）的包装。单挑 KO 后按胜场数播 `w1`/`w2` 的 `in_bleach` 或 `in_naruto`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/WinUI.as`（55 行）

## Callers / callees

- **Callers**：只 `FightBar`。
  - 构造：`_winUI1 = new WinUI(_ui.win_p1, 1)`，`_winUI2 = new WinUI(_ui.win_p2, 2)`。
  - `showWin(fighter, wins)`：`wins` 不在 0–2 则 return；`fighter.team.id==1` → `_winUI1` 否则 `_winUI2`；再 `_loc3_.show(fighter.data, wins)`。
  - 上游：`FightUI.showWins` → `FightBar.showWin`。`FightUI.renderEnd` 在单挑 `GameMode.isSingleMode()` 且胜者特写时调 `showWins(winner, gameRunData.getWins(winner))`。组队/练习不亮这颗标记。
- **Callees**：`winmc`（fight SWF，`w1`/`w2` 两个子 MC）；`FighterVO.comicType`（XML `@comic_type`：0 死神 / 1 火影）。

`getter ui` 本包无读取。

## 命名备注

无 `destory`。`winmc` 动态类，时间轴标签 `in_bleach` / `in_naruto` 在 SWF。`param2 - 1` 的 switch 只处理 wins=1 或 2；wins=0 时 `switch(-1)` 无匹配，后面 `_loc3_` 仍 null 则 return。`FightBar` 已拒 `>2`，两局先胜的第二颗就是封顶。

P2 的 `w1`/`w2` **对调**（见 `show`）：P2 的 `win_p2` 在 SWF 里镜像，视觉从右往左点亮，所以第一胜播 `w2`、第二胜播 `w1`。? 以 fight SWF 布局为准，代码意图是「第一颗 / 第二颗」。

## 逐行说明

### 字段 / 构造（L10–19）

`(winmc, team)`。存 `_ui`、`_team`（1=P1，2=P2）。不播动画。

### `ui` getter（L21–24）

返回 `_ui` 当 `DisplayObject`。本包无调用。

### `show`（L26–53）

`(FighterVO, wins)`。无 VO 则 return。

1. `switch(wins - 1)`：
   - **0（第 1 胜）**：`_team==1` ? `_ui.w1` : `_ui.w2`。
   - **1（第 2 胜）**：`_team==1` ? `_ui.w2` : `_ui.w1`。
2. 子 MC 空则 return（SWF 缺元件）。
3. `param1.comicType`：
   - `0`：`gotoAndPlay("in_bleach")`。
   - `1`：`gotoAndPlay("in_naruto")`。
   - 其它：不播（`?` 表里只有 0/1）。

不 `stop` 旧动画、不重置另一颗。第一胜留下 w1 的结束帧，第二胜再播另一颗。换人/下一场 `FightUI` 复用同一 `FightBar`，? 标记是否清零取决于 `hpbar_mc` 时间轴/`FightBar` 其它逻辑，本类不管。
