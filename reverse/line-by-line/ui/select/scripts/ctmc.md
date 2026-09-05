# `ctmc` — 已选条脸容器

一句话目的：嵌在 [`selected_item_p1_mc`](selected_item_p1_mc.md) / [`selected_item_p2_mc`](selected_item_p2_mc.md) 里、实例名 `"ct"` 的容器。自身还有子 `ct:MovieClip`。引擎 `getChildByName("ct") as ctmc` 取到本类。

源文件：`decompiled/ui/select/scripts/ctmc.as`（16 行）

## 如何挂上引擎

[`SelectedFighterUI.setFighter`](../../../engine/game/bvn/ui/select/SelectedFighterUI.md)：

```
_loc2_ = ui.getChildByName("ct") as ctmc;
```

可见字节码在此结束。残留：字段 `_face`、局部 `_loc3_`、取了 `ctmc` 却不用。典型写法应是往 `ct.ct` 里 `addChild(getFighterFaceBig)`（默认 245×62 大横条）并替换旧 `_face`。当前 dump **脸图不会出现在已选条 / 出战条上**，只剩底图 + 名字（若 `SHOW_CN_TEXT`）。以 dump 为准，补全标问号。

选人格子的脸走 [`slt_item_mc.ct`](slt_item_mc.md)（普通 `MovieClip`），**不**经本类。

SWF：`select`，链接名 `ctmc`，`symbol="symbol81"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class ctmc extends MovieClip`。[Embed] `symbol="symbol81"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `ct` | `MovieClip` | 内层脸槽。外层已是 `ctmc`，再套一层 `ct`。引擎 dump 没写到 `addChild` |

### 构造 `ctmc()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`。
