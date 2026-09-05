# `(无名包).wksound` — 万解语音 Sound

一句话目的：万解语音 `Sound` 导出。一护系时间轴 `startWanKai` 或动作 MC `new wksound().play()`。

源文件：`decompiled/fighters/ichigo/scripts/wksound.as`（15 行）

## 如何挂上引擎

无名包导出。本 SWF 导出了 `wksound`，但动作 MC **没有** `new wksound()`；万解走 `$effect_ctrler.startWanKai("一户万解")`。? 可能只是库残留或给 FLA 音轨，和 `ichigo_zero` 白一护开场那份不是同一个文件。

## 逐行说明

- **Embed** `source="/_assets/1_wksound.mp3"`。
- **类** `public dynamic class wksound extends Sound`。
- **构造** 空 `super()`。无循环、无音量。
