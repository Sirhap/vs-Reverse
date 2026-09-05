# `(无名包).winner_stg_mc` — Arcade 过关胜利页（默认）

一句话目的：闯关未通关时的胜利立绘时间轴。F1→F92 入场；F92 停、派 COMPLETE、让 `txtmc` 从 F2 播台词框。`ResUtils.WINNER` 默认就是这个链接名。变体见 [`winner_stg_mc2`](./winner_stg_mc2.md)。

源文件：`decompiled/ui/loading/scripts/winner_stg_mc.as`（48 行）

## 如何挂上引擎

[`WinnerState.build`](../../../engine/game/bvn/state/WinnerState.md) L180：

```
_ui = ResUtils.I.createDisplayObject(ResUtils.I.loading, ResUtils.WINNER);
```

[`ResUtils.WINNER`](../../../engine/game/bvn/utils/ResUtils.md) 默认 `"winner_stg_mc"`。[`GameLogic.setGameMode(0)`](../../../engine/game/bvn/ctrl/GameLogic.md) 写回这个名字（3.3 `select.xml`）。localhost Ctrl+F9。

入口：`GameCtrl.fightFinish` Arcade 且 P1 胜且未 `missionAllComplete` → `MainGame.goWinner`。全通关走祝贺页，不进这里。

引擎对字段 / 子件：

| 名字 | 类型（AS） | 引擎用法 |
|------|------------|----------|
| `scoremc` | `MovieClip` | `addChild(BitmapFontText "SCORE "+score)`，字图自身居中 |
| `f0` / `f1` / `f2` | `MovieClip` | `addChildAt(faceWin, 0)` 垫底；没脸则 `visible=false`。f0 是当场 winner，f1/f2 其余队员 |
| `txtmc` | `MovieClip` | F92 本类 `gotoAndPlay(2)`。`WinnerState.initText` 听它的 `"complete"`，再 addChild 台词 `TextField`（SimHei 18 黑字，`|` 换行） |
| `btns` | `MovieClip` | **子按钮未在本 AS 声明**。引擎 `_ui.getChildByName("btns")`，再动态点： |

`btns` 里三个按钮（FLA 实例名，无类型字段）：

| 实例名 | click | mouseOver |
|--------|-------|-----------|
| `btn_more` | `GameInterface.instance.moreGames()`（不离页） | `sndSelect` |
| `btn_cont` | `goNext()` → `messionComplete` + `loadGame` | 同上 |
| `btn_exit` | `GameUI.confrim("BACK TITLE?","返回到主菜单？", goMenu)` | 同上 |

绑定发生在本 MC 的 F92 `Event.COMPLETE` → `onUIPlayComplete`（同时派壳 `["winner_show"]`）。键盘 MENU select = Continue。

`WinnerState.destory`：`_ui.gotoAndStop("destory")` 再置 null。**`"destory"` 是时间轴标签**（拼写贯穿），本 AS 无对应 `addFrameScript`。用来停嵌套动画/音效。不摘 `btns` 监听。派 `["winner_end"]`。

## 逐行说明

- **L1–16**：无名包。FFDec 灌的 flash.* 通配；实际用 `MovieClip`、`Event`。
- **L18**：`[Embed(..., symbol="symbol70")]`。
- **L19**：`public dynamic class winner_stg_mc extends MovieClip`。`dynamic` 让 `btns.btn_more` 这类未声明子件能点。
- **L22**：`public var btns:MovieClip;` —— 按钮层。子级 `btn_more` / `btn_cont` / `btn_exit` **没有** typed 字段。
- **L24–28**：`f0` / `f1` / `f2`：三张胜利脸槽。
- **L30**：`scoremc`：分数容器，舞台上应是空定位点。
- **L32**：`txtmc`：台词框动画。自身另有 COMPLETE（本文件不见其脚本）。
- **L34–38 构造**：`super()`；`addFrameScript(91, this.frame92)`。**addFrameScript 91 = F92**。
- **L40–45 `frame92`**：
  1. `stop();` —— 锁在入场末帧，三个按钮可见。
  2. `dispatchEvent(new Event(Event.COMPLETE));` —— `WinnerState.onUIPlayComplete`。
  3. `this.txtmc.gotoAndPlay(2);` —— 台词框从第 2 帧播；播完再派 complete 给 `initText` 灌字。

无其它帧脚本。入场 91 帧（约 3s @30fps）全是 FLA 补间/音效。
