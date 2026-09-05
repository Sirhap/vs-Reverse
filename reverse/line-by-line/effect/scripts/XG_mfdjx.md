# `(无名包).XG_mfdjx` — 重法命中 / 破防火花

一句话目的：重法（hitType 5）命中火花；破防 `break_def` **复用同一剪辑**、另一份 VO（freeze 更长、震的是 x 不是 pow）。

源文件：`decompiled/other/effect/scripts/XG_mfdjx.as`（15 行）

## 如何挂上引擎

两份 VO：

| id | 声 | freeze | shake | 其它 |
|----|----|--------|-------|------|
| `hit_5` MAGIC_HEAVY | `snd_mfdjx` | 400 | `pow:6, time:400` → 抄到 y | add，`randRotate`，白闪 0.2 |
| `break_def` | `snd_mfdjx` | **500** | **`x:6, time:400`**（不是 pow） | add，**无** randRotate / shine |

`FighterMcCtrler` 破防 `doEffectById("break_def")`。爆气判定 hitType 也是 5，命中火花走 `hit_5` 这份，不是 break_def。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化两次（hit_5 与 break_def 各一份 VO），各画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 679**（FFDec `symbol679`），**17 帧** @30fps，约 9 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_mfdjx extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol679")]`：FFDec 把 sprite 679 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_mfdjx()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
