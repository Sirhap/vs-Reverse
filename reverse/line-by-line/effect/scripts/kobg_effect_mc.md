# `(无名包).kobg_effect_mc` — KO 背景闪光

一句话目的：有人在必杀中被 KO 时垫到 GameState 最底的短循环背景。5 帧，靠 `holdFrame` 撑满约 2 秒。

源文件：`decompiled/other/effect/scripts/kobg_effect_mc.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `kobg`：裸 VO，无声、无 add。

[`FightUI.playKO`](../../engine/game/bvn/ui/fight/FightUI.md) 若任一方 `actionState` 12/13（必杀/超必）→ [`EffectCtrl.BGEffect("kobg", 2)`](../../engine/game/bvn/ctrl/EffectCtrl.md)：

1. `addEffect` 在 (0,0)
2. `holdFrame = 2 * 30 = 60` 动画拍（后置 `--` 实际 61 拍 ≈ 2s@30fps）
3. 再挂 remove 回调恢复地图；立刻 `getMap().setVisible(false)`
4. `addChildAt(display, 0)` 到 **GameState**（不是 `_playerLayer`）

[`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 播到缓存末帧会绕回 0 直到 hold 到期。烘焙跳过最后一帧：5 帧 MC → 缓存 4 张循环。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 4 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 712**（FFDec `symbol712`），**5 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class kobg_effect_mc extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol712")]`：FFDec 把 sprite 712 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `kobg_effect_mc()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
