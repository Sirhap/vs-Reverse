# `(无名包).xg_fire_ing` — 燃烧持续环绕

一句话目的：火属性命中后挂在受击者身上。角色被染成全黑。`loop`/`finish` 标签。

源文件：`decompiled/other/effect/scripts/xg_fire_ing.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `fire_ing`：`xg_fire_ing`，add，`isSpecial`，`targetColorOffset=[-255,-255,-255]`。hitType 7 的 `specialEffectId`。

### 时间轴标签

| 标签 | MC 帧 | 运行时 |
|------|-------|--------|
| `loop` | F12 | `renderFrameLabel` → `gotoAndPlay(1)` |
| `finish` | F13 | `SpecialEffectView` 在 idle/倒地/弹起时跳到这里，停止跟随并 `resumeColor` |

25 帧 → 缓存 24。被打 21 / 击飞 22 **不**结束，火跟到落地或回 idle。死亡 30 不在 case 里，可能跟尸体到播完。?

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 24 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 73**（FFDec `symbol73`），**25 帧** @30fps，约 12 次 Place。有标签：

| 帧 | 标签 |
|----|------|
| F12 | `loop` |
| F13 | `finish` |

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_fire_ing extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol73")]`：FFDec 把 sprite 73 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_fire_ing()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
