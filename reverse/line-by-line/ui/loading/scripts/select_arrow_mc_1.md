# `(无名包).select_arrow_mc_1` — P1 出战顺序箭头（空 MC）

一句话目的：战前出战顺序 UI 里 P1 那侧的光标箭头。AS 空壳，图形全在 FLA。本批导出在 loading.swf；引擎向 `select` 按名取。

源文件：`decompiled/ui/loading/scripts/select_arrow_mc_1.as`（15 行）

## 如何挂上引擎

[`SelectIndexUI.initP1Group`](../../../engine/game/bvn/ui/select/SelectIndexUI.md) L138–139：

```
var arrow:DisplayObject = ResUtils.I.createDisplayObject(ResUtils.I.select, "select_arrow_mc_1");
_p1Group.initArrow(arrow, new Point(-10, 30));
```

偏移 `(-10, 30)`：相对第一张人物条，箭头在左侧。P2 对称件是 [`select_arrow_mc_2`](./select_arrow_mc_2.md)（偏移 `(260, 30)`）。

只在组队模式 10/11/12 建箭头；单挑 / 生存 / 训练 `initSelect` default 两边直接 `isFinish`，不 `createDisplayObject`。

**库名对不上**：反编译在 `ui/loading/`。引擎第一参 `ResUtils.I.select`。本批 `decompiled/ui/select/` **没有** `select_arrow_mc_1`（select.swf 也可能另有同名导出，本批未见）。能取到是因为 [`ResUtils`](../../../engine/game/bvn/utils/ResUtils.md) 八 SWF 并入 `ApplicationDomain.currentDomain`，`getDefinition` 按链接名。

不要和 `common_ui` 的 `select_arrow_mc`（无 `_1`）搞混：那是设置页 / GameOver 菜单箭头。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(..., symbol="symbol76")]`。
- **L6**：`public dynamic class select_arrow_mc_1 extends MovieClip`。无 public 字段。
- **L9–12 构造**：`super()`。无 `addFrameScript`。空逻辑类，显示靠时间轴图形。
