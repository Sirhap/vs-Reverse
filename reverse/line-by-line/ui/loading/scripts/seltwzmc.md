# `(无名包).seltwzmc` — 出战序号 / 辅助角标（空 MC）

一句话目的：贴在已选人物条上的角标。时间轴 F1/F2/F3 = 出战 1/2/3，F4 = 辅助。AS 空壳，引擎 `gotoAndStop` 切帧。本批导出在 loading.swf；引擎向 `select` 按名取。

源文件：`decompiled/ui/loading/scripts/seltwzmc.as`（15 行）

## 如何挂上引擎

[`SelectedFighterUI`](../../../engine/game/bvn/ui/select/SelectedFighterUI.md)：

| 方法 | 调用 | 帧 | 坐标 |
|------|------|----|------|
| `setFighterIndex(param1)` L137–148 | `createDisplayObject(ResUtils.I.select, "seltwzmc")` → `gotoAndStop(param1)` | 1 / 2 / 3 | P1 `x=-8`；P2 `x=252 - width`；`y=-5` |
| `setAssister()` L154–165 | 同上，`gotoAndStop(4)` | 4 | P1 `x=-8`；P2 `x=176`；`y=-5` |

`setFighterIndex` 后 `mouseEnabled(false)`，避免再点已编号的人。`SelectIndexUIGroup` 用这个序号排序 `getOrder()`。

**库名对不上**：类在 `ui/loading/`。引擎第一参 `ResUtils.I.select`。本批 `decompiled/ui/select/` 无 `seltwzmc`（select.swf 可能另有同名导出，本批未见）。[`ResUtils`](../../../engine/game/bvn/utils/ResUtils.md) 当前域 `getDefinition("seltwzmc")` 仍然命中 loading 登记的那份。

名字 `seltwzmc`：select 文字 MC 的缩写。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(..., symbol="symbol85")]`。
- **L6**：`public dynamic class seltwzmc extends MovieClip`。无 public 字段。帧上的数字图形是时间轴内容，不是 TextField。
- **L9–12 构造**：`super()`。无 `addFrameScript`。切帧全靠外部 `gotoAndStop(1|2|3|4)`。
