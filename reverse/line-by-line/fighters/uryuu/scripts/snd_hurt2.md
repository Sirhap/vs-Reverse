# `(无名包).snd_hurt2` — 受击语音 Sound

一句话目的：受击语音 `Sound` 导出。`MainTimeline` `defineHurtSound` / `defineHurtFlySound` / `defineDieSound` 把本 Class 交给 `FighterVoiceCtrler.setVoice`。

源文件：`decompiled/fighters/uryuu/scripts/snd_hurt2.as`（15 行）

## 如何挂上引擎

[`FighterCtrler.defineHurtSound`](../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md) 把 rest Class 存进 voice 0；Fly=1、Die=2。McCtrler 受击时按类型随机播。本文件 `uryuu/snd_hurt2`。

## 逐行说明

- **Embed** `source="/_assets/1_snd_hurt2.mp3"`。
- **类** `public dynamic class snd_hurt2 extends Sound`。
- **构造** 空 `super()`。无循环、无音量。
