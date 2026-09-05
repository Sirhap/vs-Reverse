# `txt_mc` — 带 TextField 的字 MC（引擎未挂？）

一句话目的：一个 `txt:TextField` 的导出 MovieClip。fight SWF 里有链接名，但引擎 **从不** `createDisplayObject("txt_mc")`。

源文件：`decompiled/ui/fight/scripts/txt_mc.as`（17 行）

## 如何挂上引擎

[`ResUtils.I.fight`](../../../engine/game/bvn/utils/ResUtils.md) 的 `getItemClass` 调用方只有：

- `"ui_fight"` / `"player_pos_p1"` / `"player_pos_p2"` → [`FightUI`](../../../engine/game/bvn/ui/fight/FightUI.md)
- `"time_txtmc"` → [`FightTimeUI`](../../../engine/game/bvn/ui/fight/FightTimeUI.md)
- `"txtmc_score"` → [`FightScoreUI`](../../../engine/game/bvn/ui/fight/FightScoreUI.md)
- `"hits_num_mc"` → [`HitsUI`](../../../engine/game/bvn/ui/fight/HitsUI.md)

**没有** `"txt_mc"`。体力字走 [`energybar_txt_mc_3`](fight_fla/energybar_txt_mc_3.md)（位图字 MC，不是 TextField）。选人地图字是 `select` SWF 的 `select_map_txt_mc`，不是本类。

可能：时间轴嵌在某个 HUD 装饰里当静态字；或作者留下的未用导出。`?` 未扫 SWF 实例树，不能证明完全没被嵌套引用。即便嵌着，引擎 AS 也不读 `txt`。

## 逐行说明

- **L5** `symbol="symbol3"`（fight SWF 很小的号，像早期/共用元件）。
- **L6** `public dynamic class txt_mc extends MovieClip`。
- **L10 `txt`**：`flash.text.TextField`。唯一公开槽。本 AS 不写文本。
- **L12–15 构造**：只 `super()`。无帧脚本。
