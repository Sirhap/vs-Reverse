# `(无名包).XG_bdj` — 遗留「绊打击」火花（未登记）

一句话目的：effect.swf 导出的短命中剪辑。`EffectModel` **没有**用这个 `className`。像早期普攻火花，被 `XG_qdj` / `XG_kan2` 取代。

源文件：`decompiled/other/effect/scripts/XG_bdj.as`（15 行）

## 如何挂上引擎

[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 仍能按名 `new` 本类，但 [`EffectModel.initEffects`](../../engine/game/bvn/data/EffectModel.md) / `initHitEffect` 从未写入 `_effect`。`doEffectById` / `getHitEffect` 都走不到。启动 `cacheEffects` 也不烘焙本剪辑。

命名：`bdj` ≈ 绊打击。9 帧、每帧都有 Place，比现行轻拳 `XG_qdj`（12 帧）更短。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 894**（FFDec `symbol894`），**9 帧** @30fps，约 9 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

同类遗留：[`XG_kan`](XG_kan.md)、[`XG_kanx`](XG_kanx.md)、[`XG_qdjx2`](XG_qdjx2.md)、[`XG_ice2`](XG_ice2.md)、[`XG_xdash`](XG_xdash.md)。

## 逐行说明

无名包。`public dynamic class XG_bdj extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol894")]`：FFDec 把 sprite 894 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_bdj()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
