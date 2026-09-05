# `(无名包).snd_defx` — 重防/属性防格挡声

一句话目的：重拳防、重法防、火/冰/电防都用这一声。

源文件：`decompiled/other/effect/scripts/snd_defx.as`（15 行）

## 如何挂上引擎

`defense_3/5/7/8/9`。重斩防用专门的 [`snd_fykanx`](snd_fykanx.md)。

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

运行时每次 `EffectView.start` 都 `new` 一份再 `Sound.play(0,0,transform)`，不循环、不 stop、不进对象池。

SWF DefineSound **char 26**：MP3（fmt=2），22050 Hz，16-bit mono，673 ms（14842 samples / 22050 Hz），payload 3018 B。

## 逐行说明

无名包。`public dynamic class snd_defx extends Sound`。

- **L5** `[Embed(source="/_assets/26_snd_defx.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_defx()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
