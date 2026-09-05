# `(无名包).snd_hurt1` — 受击语音 Sound

一句话目的：受击/击飞/死亡语音 `Sound` 导出。`MainTimeline` `defineHurtSound` / `defineHurtFlySound` / `defineDieSound` 把本 Class 交给 `FighterVoiceCtrler.setVoice`。

源文件：`decompiled/fighters/neji/scripts/snd_hurt1.as`（15 行）

## 如何挂上引擎

[`FighterCtrler.defineHurtSound`](../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md) 把 rest Class 存进 voice 0；Fly=1、Die=2。McCtrler 受击时按类型随机播。本文件 `neji/snd_hurt1`。

## 逐行说明

- **Embed** `source="/_assets/2_snd_hurt1.mp3"`。
- **类** `public dynamic class snd_hurt1 extends Sound`。
- **构造** 空 `super()`。无循环、无音量。
