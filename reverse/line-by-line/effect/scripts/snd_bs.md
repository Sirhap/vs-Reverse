# `(无名包).snd_bs` — 必杀火花声

一句话目的：普通必杀火花 [`XG_bs`](XG_bs.md) 的一声。

源文件：`decompiled/other/effect/scripts/snd_bs.as`（15 行）

## 如何挂上引擎

`bisha` VO.`sound`。超必用 [`snd_cbs`](snd_cbs.md)。黑底/特写无独立声。

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

运行时每次 `EffectView.start` 都 `new` 一份再 `Sound.play(0,0,transform)`，不循环、不 stop、不进对象池。

SWF DefineSound **char 8**：MP3（fmt=2），11025 Hz，16-bit mono，1202 ms（13248 samples / 11025 Hz），payload 2401 B。

## 逐行说明

无名包。`public dynamic class snd_bs extends Sound`。

- **L5** `[Embed(source="/_assets/8_snd_bs.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_bs()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
