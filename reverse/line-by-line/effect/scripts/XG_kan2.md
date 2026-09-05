# `(无名包).XG_kan2` — 轻斩命中 / 钢体斩火花

一句话目的：轻斩（hitType 1）命中火花；钢体受斩复用同一剪辑、另一份 VO。

源文件：`decompiled/other/effect/scripts/XG_kan2.as`（15 行）

## 如何挂上引擎

两份 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md) 都 `className=XG_kan2`，`cacheEffects` **各烘焙一次**：

| id | 用途 | 声 | freeze | 其它 |
|----|------|----|--------|------|
| `hit_1` | 普通轻斩 | `snd_kan1` | 50ms | add，`randRotate` |
| `steel_hit_kan` | 钢体挨斩 | `snd_hit11` | 400ms | add，白闪 0.2，`randRotate`，`isSteelHit`，**无 shake** |

普通路径 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md)；钢体 [`SteelHitEffect`](../../engine/game/bvn/views/effects/SteelHitEffect.md)（`setTarget` 改色，freeze 结束 `resumeColor`）。

遗留 [`XG_kan`](XG_kan.md) 不用。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化两次（hit_1 与 steel_hit_kan 各一份 VO），各画成 9 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 519**（FFDec `symbol519`），**10 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_kan2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol519")]`：FFDec 把 sprite 519 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_kan2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
