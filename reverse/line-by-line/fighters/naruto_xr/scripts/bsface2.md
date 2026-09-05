# `(无名包).bsface2` — 必杀脸 BitmapData 170×121

一句话目的：必杀脸 `BitmapData` 导出类，尺寸 170×121。`MainTimeline` `defineBishaFace` 把本 Class 交给 `FighterEffectCtrl.setBishaFace`；`BishaFaceEffectView` 弹出。

源文件：`decompiled/fighters/naruto_xr/scripts/bsface2.as`（15 行）

## 如何挂上引擎

无名包导出。[`FighterCtrler.defineBishaFace`](../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md) 只存 Class，真正 `new` 在特效视图。本批 `naruto_xr` 的脸图：见同目录 `MainTimeline`。

## 逐行说明

- **Embed** `source="/_assets/4_bsface2.png"`。
- **类** `public dynamic class bsface2 extends BitmapData`。
- **构造** `(param1:int = 170, param2:int = 121)`：`super(param1,param2)`，默认 170×121。无其它逻辑。
