# `(无名包).winner_stg_mc2` — Arcade 胜利页变体（旧格子）

一句话目的：和 [`winner_stg_mc`](./winner_stg_mc.md) **同一套字段、同一套 F92 脚本**，换一版舞台排版。给旧 `salect.xml` 选人表用。AS 逐行等价，只是 Embed 元件号不同。

源文件：`decompiled/ui/loading/scripts/winner_stg_mc2.as`（48 行）

## 如何挂上引擎

不单独写死类名。[`WinnerState.build`](../../../engine/game/bvn/state/WinnerState.md) 始终：

```
_ui = ResUtils.I.createDisplayObject(ResUtils.I.loading, ResUtils.WINNER);
```

[`GameLogic.setGameMode(1)`](../../../engine/game/bvn/ctrl/GameLogic.md) L393–397 把 `ResUtils.WINNER` 改成 `"winner_stg_mc2"`，并：

- `GameData.I.loadSelect("assets/config/salect.xml")`（旧格子，`top="50"`）
- `SelectIndexUI.SHOW_MODE = 1`（出战顺序紧排 / 0.85 缩放）

`setGameMode(0)` 恢复 `"winner_stg_mc"` + `select.xml` + `SHOW_MODE=0`。

热键：[`GameInterfaceManager.keyHandler`](../../../engine/game/bvn/web/GameInterfaceManager.md) 仅 localhost + 已 `games_inited` 后 Ctrl+F8（119）→ 模式 1，Ctrl+F9（120）→ 模式 0。胜利 MC 名立刻改，**下一张** WinnerState 才生效。

字段 / `btns` 子按钮 / `"destory"` 标签 / COMPLETE 时序与 [`winner_stg_mc`](./winner_stg_mc.md) 相同：`scoremc`、`f0`/`f1`/`f2`、`txtmc`、`btns.btn_more` / `btn_cont` / `btn_exit`。差异只在 FLA 布局（脸槽、按钮、分数位置跟旧选人格对齐），ABC 脚本复制粘贴。

## 逐行说明

- **L1–16**：无名包。flash.* 通配。与 `winner_stg_mc` 相同。
- **L18**：`[Embed(..., symbol="symbol69")]` —— 元件 69，默认胜利页是 symbol70。
- **L19**：`public dynamic class winner_stg_mc2 extends MovieClip`。
- **L22–32 字段**：`btns`、`f0`、`f1`、`f2`、`scoremc`、`txtmc`，类型与默认页一致。`btns` 子级同样未 typed：`btn_more` / `btn_cont` / `btn_exit`。
- **L34–38 构造**：`addFrameScript(91, this.frame92)`。**addFrameScript 91 = F92**。
- **L40–45 `frame92`**：`stop()` + `Event.COMPLETE` + `this.txtmc.gotoAndPlay(2)`。与默认页逐语句相同。
