# `ui_fight` — 战斗 HUD 根 MC

一句话目的：`ResUtils.I.fight` 的主导出。时间轴上排好顶栏血条、两侧气条、连击数字和开场/KO 片；引擎 `FightUI` 再往上加屏外标记和暂停框。

源文件：`decompiled/ui/fight/scripts/ui_fight.as`（26 行）

## 如何挂上引擎

[`ResUtils`](../../../engine/game/bvn/utils/ResUtils.md) 字段 `fight`（嵌入 `fight_swf$…`）。[`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md) 构造 L64：

```
ResUtils.I.createDisplayObject(ResUtils.I.fight, "ui_fight")
```

返回本类实例，赋给 `FightUI.ui`，`GameState` 把它 `addChild` 到镜头层外面（屏幕 800×600）。**不**走 `ResUtils` 常量表。

构造后立刻拆子件：

| 实例 | 类型 | 引擎包装 |
|---|---|---|
| `hpbarmc` | [`hpbar_mc`](hpbar_mc.md) | [`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) |
| `fzqi1` / `fzqi2` | `qbar_mc` | [`QiBar`](../../../engine/game/bvn/ui/fight/QiBar.md)×2；P2 `setDirect(-1)` |
| `hits1` / `hits2` | `hits_mc` | [`HitsUI`](../../../engine/game/bvn/ui/fight/HitsUI.md)×2 |
| `startKOmc` | `MovieClip` | 运行时是 `fight_fla.game_start_mc_44`。`showStart` / `showEnd` `gotoAndStop` 标签，[`FightUI.renderStartAndKO`](../../../engine/game/bvn/ui/fight/FightUI.md) `nextFrame()` |

另：`createDisplayObject("player_pos_p1"|"player_pos_p2")` 后 `ui.addChild`——**不是**本类字段，见 [`player_pos_p1`](player_pos_p1.md) / [`player_pos_p2`](player_pos_p2.md)。`PauseDialog` 也是代码加的。

BITMAP 路径下 `FightBar` 会把 `hpbarmc` 从本 MC 摘掉，HP/体力/计时数字抬到本根下。`destory` 时 `ui.removeChildren()` + `stopAllMovieClips()`。

## 逐行说明

- **L1–3** 无名包。`import flash.display.MovieClip`。
- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol195")]`。FFDec 从 fight SWF 抽的链接。
- **L6** `public dynamic class ui_fight extends MovieClip`。动态类：时间轴实例名靠运行时绑定。
- **L9–10 `fzqi1` / `fzqi2`**：`qbar_mc`。底侧气条 + 辅助气 + 辅助脸。P1 左、P2 右。
- **L13–14 `hits1` / `hits2`**：`hits_mc`。屏幕固定位连击数字，不跟角色。
- **L17 `hpbarmc`**：[`hpbar_mc`](hpbar_mc.md)。整条顶栏（脸 / HP / 体力 / 计时 / 胜场灯 / 分数）。
- **L19 `startKOmc`**：声明成 `MovieClip`，不是导出类名。SWF 里挂的是 `fight_fla.game_start_mc_44`（`$round` / `$perfect` / `$winnerX`）。`FightUI.clearStartAndEnd` → `gotoAndStop(1)`。
- **L21–24 构造**：只 `super()`。无帧脚本、无 `stop`。时间轴默认停在 SWF 第 1 帧（布局帧）。
- **没有** `player_pos_*`、`txt_mc`、暂停框字段。
