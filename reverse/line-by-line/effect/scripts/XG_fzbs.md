# `(无名包).XG_fzbs` — 遗留辅助必杀火花（未登记）

一句话目的：导出名像「辅助必杀」。`EffectModel` 未登记。配对音 [`snd_fzbs`](snd_fzbs.md) 同样未引用。

源文件：`decompiled/other/effect/scripts/XG_fzbs.as`（15 行）

## 如何挂上引擎

助战进场只用 `fz_bleach` / `fz_naruto`。助战时间轴若 `$assisterCtrler.effect.bisha` 走的是全局 `XG_bs`/`XG_cbs`，不是本类。

10 帧短剪辑。启动不烘焙。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 787**（FFDec `symbol787`），**10 帧** @30fps，约 5 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_fzbs extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol787")]`：FFDec 把 sprite 787 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_fzbs()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
