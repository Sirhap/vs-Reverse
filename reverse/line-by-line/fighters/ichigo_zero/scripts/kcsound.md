# `(无名包).kcsound` — 开场语音 Sound

一句话目的：开场语音 `Sound` 导出。白一护 `白一护全动作_11` 在 `parent.wanKai==false` 时 `new kcsound().play()`。

源文件：`decompiled/fighters/ichigo_zero/scripts/kcsound.as`（15 行）

## 如何挂上引擎

无名包导出。引擎 ctrler **不** 经 `defineHurtSound` 登记；动作 MC 自己 `new` 并 `play()`。本文件 `ichigo_zero/kcsound`。

## 逐行说明

- **Embed** `source="/_assets/2_kcsound.mp3"`。
- **类** `public dynamic class kcsound extends Sound`。
- **构造** 空 `super()`。无循环、无音量。
