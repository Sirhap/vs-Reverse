# `IStageFadEffect` — 图层淡入淡出接口

一句话目的：给 `KyoStageCtrl.addLayer` / `removeLayer` 的可选转场。`fadIn` / `fadOut` 做完必须调回调。本 SWF **零实现、零调用**。

源文件：`decompiled/main/scripts/net/play5d/kyo/stage/effect/IStageFadEffect.as`（14 行）

## Callers / callees

- **Callers**：仅 `KyoStageCtrl.addLayer` / `removeLayer` 的参数类型。那两条 API 本包也没人调。
- **实现**：本 `decompiled/main` **无** class `implements IStageFadEffect`。游戏转场走的是 Batch C 的 `TransUI` / `QuickTransUI`（`StateCtrl`），不经过本接口。
- **Callees**：`Istage`。

## 命名备注

`Fad` / `fadIn` / `fadOut`：fade 的原拼写。与 `FightUI.fadIn`、`TransUI` 时间轴标签 `fadin`/`fadout` 一致。

## 逐行说明

### `fadIn`（L8）

`param1` = 刚 `addChild` 完的图层。`param2` 完成回调。`KyoStageCtrl` 的 `effectBack` 在回调里才 `layer.afterBuild()`。实现必须保证最终调到 `param2`，否则 `afterBuild` 永不跑。

### `fadOut`（L10）

`param1` 仍在显示列表。`KyoStageCtrl.effectFin` 在回调里才 `removeChild` + `destory`。实现必须调回调，否则图层泄漏。
