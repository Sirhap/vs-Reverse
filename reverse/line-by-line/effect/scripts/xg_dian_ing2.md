# `(无名包).xg_dian_ing2` — 遗留感电持续（未登记）

一句话目的：23 帧感电环绕，标签 `F8:loop` / `F9:finish`。现行 `shock_ing` 用 [`xg_dian_ing`](xg_dian_ing.md)（21 帧，loop 在 F6）。

源文件：`decompiled/other/effect/scripts/xg_dian_ing2.as`（15 行）

## 如何挂上引擎

`initSpeicalEffect` 只写 `xg_dian_ing`。本类不烘焙。标签布局与正式三条 special 同一套（先 loop 再 finish 紧挨着），像旧版电环。

**本表未登记**：`EffectModel` 从不 `getEffect` 本 `className`。启动不烘焙。仍导出，[`AssetManager.getEffect`](../../engine/game/bvn/ctrl/AssetManager.md) 能 `new`。

SWF：`assets/effect.swf` DefineSprite **char 104**（FFDec `symbol104`），**23 帧** @30fps，约 15 次 Place。有标签：

| 帧 | 标签 |
|----|------|
| F8 | `loop` |
| F9 | `finish` |

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class xg_dian_ing2 extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol104")]`：FFDec 把 sprite 104 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `xg_dian_ing2()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
