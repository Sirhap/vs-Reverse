# `(无名包).snd_hurt_ogihci_1` — 白一护受击语音 Sound

一句话目的：白一护受击/击飞/死亡语音 `Sound` 导出。类名 `ogihci` 是 ichigo 倒写。内虚形态 `defineHurtSound(null)`，Fly/Die 用本 Class。

源文件：`decompiled/fighters/ichigo_zero/scripts/snd_hurt_ogihci_1.as`（15 行）

## 如何挂上引擎

[`FighterCtrler.defineHurtSound`](../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md) 把 rest Class 存进 voice 0；Fly=1、Die=2。McCtrler 受击时按类型随机播。本文件 `ichigo_zero/snd_hurt_ogihci_1`。

## 逐行说明

- **Embed** `source="/_assets/1_snd_hurt_ogihci_1.mp3"`。
- **类** `public dynamic class snd_hurt_ogihci_1 extends Sound`。
- **构造** 空 `super()`。无循环、无音量。
