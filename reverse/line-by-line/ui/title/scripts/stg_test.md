# `stg_test` — title.swf 遗留空舞台

一句话目的：`title` SWF 里多导出的空 `MovieClip`。引擎全文不引用 `"stg_test"`。FLA 测试舞台残留。

源文件：`decompiled/ui/title/scripts/stg_test.as`（15 行）

## 如何挂上引擎

**没有。** [`ResUtils.TITLE`](../../../engine/game/bvn/utils/ResUtils.md) 只等于 `"stg_title"`。[`MenuState`](../../../engine/game/bvn/state/MenuState.md) 只 `createDisplayObject(title, TITLE)`。全仓库 `.as` 无 `stg_test` 字符串（除本文件与索引）。

SWF：`title_swf`（id 2215）SymbolClass `(66, 'stg_test')`，`symbol="symbol66"`。Sprite id=66，**1 帧**。时间轴上放了一个未命名子件（cid 65），无实例名、无脚本、无标签。

对比正式舞台 [`stg_title`](stg_title.md)（90 帧、`btnct` / `logo_mc`、F50/F75 COMPLETE）。

## 逐行说明

- **L1–3**：无名包。`import flash.display.MovieClip;`。
- **L5**：`[Embed(source="/_assets/assets.swf", symbol="symbol66")]`。
- **L6**：`public dynamic class stg_test extends MovieClip`。
- **L9–12 构造**：只 `super();`。无字段、无 `addFrameScript`、无 `stop()`。
