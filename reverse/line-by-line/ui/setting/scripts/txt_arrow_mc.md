# `txt_arrow_mc` — 设置行左右三角

一句话目的：有 options 的 [`SetBtn`](../../../engine/game/bvn/ui/SetBtn.md) 左右拨档箭头。每行两枚：左 `prevArrow`，右 `nextArrow`（`scaleX = -1` 水平翻转）。无脚本。

源文件：`decompiled/ui/setting/scripts/txt_arrow_mc.as`（14 行）

## 如何挂上引擎

只 `SetBtn.setOption`：

```
_prevArrow = createDisplayObject(ResUtils.I.setting, "txt_arrow_mc");
_nextArrow = createDisplayObject(ResUtils.I.setting, "txt_arrow_mc");
_prevArrow.name = "prevArrow";
_nextArrow.name = "nextArrow";
_nextArrow.scaleX = -1;
两者 y = 17;
```

排 x（`updateOption`）：

```
prev.x  = label.width + 50
txt.x   = prev + 10
next.x  = txt.x + txt.width + 10
```

[`SetBtnGroup.mouseHandler`](../../../engine/game/bvn/ui/SetBtnGroup.md) 点穿看 `e.target.name`：`"prevArrow"` / `"nextArrow"` 才 `prevOption` / `nextOption`。键盘竖排左右键也走这两条。无 options 的行（APPLY / KEY SET / BACK）永不 `new` 本类。

`SetBtn.destory` **不**丢箭头。触摸第二次点同一行走 `nextOption`（只能往后拨）。

SWF：`setting`，链接名 `txt_arrow_mc`，`symbol="symbol3"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class txt_arrow_mc extends MovieClip`。[Embed] `symbol="symbol3"`。

### 无字段

三角图在时间轴。朝向靠实例 `scaleX`。

### 构造 `txt_arrow_mc()`（L9–12）

- L11: `super();`
- 无 `addFrameScript`。
