# `(无名包).snd_ghost_step` — 鬼步火花声

一句话目的：`ghost_step` VO 自带的一声。与主 SWF 的 `snd_ghost_jump` 不是同一个。

源文件：`decompiled/other/effect/scripts/snd_ghost_step.as`（15 行）

## 如何挂上引擎

[`XG_ghost_step`](XG_ghost_step.md) `EffectView.start` 播本类；[`EffectCtrl.ghostStep`](../../engine/game/bvn/ctrl/EffectCtrl.md) 另外 `playSwcSound(snd_ghost_jump)`（main 嵌入）。走路循环反复 start 就会反复本声。

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

运行时每次 `EffectView.start` 都 `new` 一份再 `Sound.play(0,0,transform)`，不循环、不 stop、不进对象池。

SWF DefineSound **char 21**：MP3（fmt=2），22050 Hz，16-bit mono，724 ms（15968 samples / 22050 Hz），payload 3330 B。

## 逐行说明

无名包。`public dynamic class snd_ghost_step extends Sound`。

- **L5** `[Embed(source="/_assets/21_snd_ghost_step.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_ghost_step()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
