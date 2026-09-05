# `winmc` — 一侧两盏胜场灯

一句话目的：单挑 KO 后点亮的两颗灯。`w1`/`w2` 各播 `in_bleach` 或 `in_naruto`。P1/P2 各一颗本 MC。

源文件：`decompiled/ui/fight/scripts/winmc.as`（20 行）

## 如何挂上引擎

[`hpbar_mc.win_p1` / `win_p2`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) 构造：

```
_winUI1 = new WinUI(_ui.win_p1, 1)
_winUI2 = new WinUI(_ui.win_p2, 2)
```

[`WinUI.show`](../../../engine/game/bvn/ui/WinUI.md)`(FighterVO, wins)`：

| `wins` | team 1（`win_p1`） | team 2（`win_p2`） |
|---|---|---|
| 1 | `w1` | `w2` |
| 2 | `w2` | `w1` |

P2 对调：SWF 里 `win_p2` 已镜像，视觉从右往左点亮。? `wins==0` 或非 1/2 不播。`comicType` 0 → `gotoAndPlay("in_bleach")`，1 → `"in_naruto"`。其它 comicType 拿到 MC 但不 play。

上游：仅 [`FightUI.renderEnd`](../../../engine/game/bvn/ui/fight/FightUI.md) 在 `isSingleMode` 调 `showWins`。组队/生存/练习不亮。无 `destory`；下一场复用同一 FightBar，旧灯停在结束帧。?

`w1`/`w2` 声明 `MovieClip`。嵌套动画类见 [`fight_fla.winmc_bleach_22`](fight_fla/winmc_bleach_22.md)（F1/F20/F40 `stop`）。标签字符串不在本 AS。

BITMAP：整块 `winmc` 抬到 `ui_fight`，在底图之上。时间轴自己 `play`，FightBar 不 render。

## 逐行说明

- **L5** `symbol="symbol124"`。
- **L6** `public dynamic class winmc extends MovieClip`。
- **L9 `w1`**：`MovieClip`。P1 第一胜 / P2 第二胜。
- **L11 `w2`**：`MovieClip`。P1 第二胜 / P2 第一胜。
- **L13–16 构造**：只 `super()`。无帧脚本。灯动画全在子 MC。
