# `(无名包).XG_mfdj` — 轻法命中 / 钢体法火花

一句话目的：轻法/忍术/鬼道（hitType 4）命中火花；钢体受法复用。

源文件：`decompiled/other/effect/scripts/XG_mfdj.as`（15 行）

## 如何挂上引擎

两份 VO，同 `className=XG_mfdj`，各烘焙一次：

| id | 声 | freeze | 旗 |
|----|----|--------|----|
| `hit_4` MAGIC | `snd_hit2`（和轻拳同一声） | 50 | add，`randRotate` |
| `steel_hit_mfdj` | `snd_hit11` | 400 | add，白闪，`randRotate`，`isSteelHit` |

轻拳火花是 [`XG_qdj`](XG_qdj.md)，剪辑不同、声相同。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化两次（hit_4 与 steel_hit_mfdj 各一份 VO），各画成 11 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 690**（FFDec `symbol690`），**12 帧** @30fps，约 8 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_mfdj extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol690")]`：FFDec 把 sprite 690 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_mfdj()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
