# `(无名包).xg_ice_ing` — 冰冻持续环绕

一句话目的：冰属性命中后挂在受击者身上。角色加蓝。`loop`/`finish` 在很靠前的帧。

源文件：`decompiled/other/effect/scripts/xg_ice_ing.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `ice_ing`：`xg_ice_ing`，add，`isSpecial`，`targetColorOffset=[0,0,255]`。hitType 8。

### 时间轴标签

| 标签 | MC 帧 | 运行时 |
|------|-------|--------|
| `loop` | **F5** | 三条 special 里 loop 最早。`renderFrameLabel` → `gotoAndPlay(1)` |
| `finish` | **F6** | 倒地/idle 跳结束段 |

26 帧（special 里最长）→ 缓存 25。loop 在 F5 意味着循环体很短，前面 4 帧是入场。?

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 25 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 48**（FFDec `symbol48`），**26 帧** @30fps，约 12 次 Place。有标签：

| 帧 | 标签 |
|----|------|
| F5 | `loop` |
| F6 | `finish` |

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_ice_ing extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol48")]`：FFDec 把 sprite 48 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_ice_ing()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
