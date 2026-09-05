# `(无名包).snd_dash` — 死神辅助出场声（名义冲刺）

一句话目的：导出名像冲刺，实际绑在死神辅助出场 [`XG_fz_bleach_mc`](XG_fz_bleach_mc.md)。

源文件：`decompiled/other/effect/scripts/snd_dash.as`（15 行）

## 如何挂上引擎

`fz_bleach` VO.`sound`。地面/空中 dash **不用**本类，用 [`snd_dash_air`](snd_dash_air.md)。样本数与 `snd_dash_air` 同为 17952，像同一条音两份导出。?

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

运行时每次 `EffectView.start` 都 `new` 一份再 `Sound.play(0,0,transform)`，不循环、不 stop、不进对象池。

SWF DefineSound **char 20**：MP3（fmt=2），22050 Hz，16-bit mono，814 ms（17952 samples / 22050 Hz），payload 3746 B。

## 逐行说明

无名包。`public dynamic class snd_dash extends Sound`。

- **L5** `[Embed(source="/_assets/20_snd_dash.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_dash()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
