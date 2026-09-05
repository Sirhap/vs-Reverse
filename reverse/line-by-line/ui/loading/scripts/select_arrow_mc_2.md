# `(无名包).select_arrow_mc_2` — P2 出战顺序箭头（空 MC）

一句话目的：战前出战顺序 UI 里 P2 那侧的光标箭头。AS 空壳。本批导出在 loading.swf；引擎向 `select` 按名取。

源文件：`decompiled/ui/loading/scripts/select_arrow_mc_2.as`（15 行）

## 如何挂上引擎

[`SelectIndexUI.initP2Group`](../../../engine/game/bvn/ui/select/SelectIndexUI.md) L158–159：

```
var _loc3_:DisplayObject = ResUtils.I.createDisplayObject(ResUtils.I.select, "select_arrow_mc_2");
_p2Group.initArrow(_loc3_, new Point(260, 30));
```

偏移 `(260, 30)`：P2 卡片朝右，箭头在条右侧。P1 对称件 [`select_arrow_mc_1`](./select_arrow_mc_1.md) 偏移 `(-10, 30)`。

`initP2Group` 在模式 10（P2 `autoSelect`）、11（键 `"P2"`）、12（P1 完后再键 `"P1"`）都会建。default 模式不进这里。

**库名对不上**：同 `_1`——类在 loading.swf，[`ResUtils.createDisplayObject`](../../../engine/game/bvn/utils/ResUtils.md)`(ResUtils.I.select, "select_arrow_mc_2")`。当前域 `getDefinition` 仍能拿到。本批 select.swf 目录无此文件。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(..., symbol="symbol73")]`。
- **L6**：`public dynamic class select_arrow_mc_2 extends MovieClip`。无字段。
- **L9–12 构造**：`super()`。无 `addFrameScript`。
