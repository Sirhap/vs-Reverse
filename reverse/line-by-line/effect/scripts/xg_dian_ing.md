# `(无名包).xg_dian_ing` — 感电持续环绕

一句话目的：电属性命中后挂在受击者身上的持续特效。`isSpecial` → `SpecialEffectView`。带 `loop`/`finish` 标签。

源文件：`decompiled/other/effect/scripts/xg_dian_ing.as`（15 行）

## 如何挂上引擎

[`EffectModel.initSpeicalEffect`](../../engine/game/bvn/data/EffectModel.md)（原拼写）id `shock_ing`：`xg_dian_ing`，add，`isSpecial`，`targetColorOffset=[50,-75,255]` 偏蓝紫。

由 hitType 9 的 `specialEffectId` 触发 → [`EffectCtrl.doSpecialEffect`](../../engine/game/bvn/ctrl/EffectCtrl.md) → [`SpecialEffectView`](../../engine/game/bvn/views/effects/SpecialEffectView.md)：跟随 fighter，上色；`actionState` 落到 0/23/24（站立/倒地/弹起）则 `gotoAndPlay("finish")` + `resumeColor`。

### 时间轴标签

| 标签 | MC 帧 | 运行时 |
|------|-------|--------|
| `loop` | F6 | [`EffectView.renderFrameLabel`](../../engine/game/bvn/views/effects/EffectView.md) 看到 `"loop"` → `gotoAndPlay(1)`（位图下标 1，不是开头 0）。? 与 1-based 帧号错一位 |
| `finish` | F7 | 基类忽略；`SpecialEffectView` 显式 `gotoAndPlay("finish")`。key 是 MC 帧号 7，赋给 0-based `_curFrame`，可能错一位/越界。? |

21 帧。烘焙跳过最后一帧 → 缓存 20。无 `loopPlay`（对比 buff）：持续段靠 `"loop"` 标签或片子够长；没有可靠 loop 时可能播完 autoRemove，角色还带着染色。?

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 20 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 131**（FFDec `symbol131`），**21 帧** @30fps，约 13 次 Place。有标签：

| 帧 | 标签 |
|----|------|
| F6 | `loop` |
| F7 | `finish` |

运行时无帧脚本。

遗留更长变体 [`xg_dian_ing2`](xg_dian_ing2.md) 同样有 loop/finish，但表用的是本类。

## 逐行说明

无名包。`public dynamic class xg_dian_ing extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol131")]`：FFDec 把 sprite 131 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_dian_ing()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
