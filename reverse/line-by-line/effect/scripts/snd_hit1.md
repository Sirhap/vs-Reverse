# `(无名包).snd_hit1` — 遗留轻击声（未引用）

一句话目的：短命中音。现行轻拳/轻法用 [`snd_hit2`](snd_hit2.md)，轻斩用 [`snd_kan1`](snd_kan1.md)。

源文件：`decompiled/other/effect/scripts/snd_hit1.as`（15 行）

## 如何挂上引擎

无 VO 绑定。样本数与 [`snd_hit_cache`](snd_hit_cache.md) 同为 5344，像同一条音两份导出。?

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

**本表未引用**：没有任何 `EffectVO.sound` 写本 id。`playEffectSound` 仍能 `getEffect` 到。

SWF DefineSound **char 23**：MP3（fmt=2），22050 Hz，16-bit mono，242 ms（5344 samples / 22050 Hz），payload 1458 B。

## 逐行说明

无名包。`public dynamic class snd_hit1 extends Sound`。

- **L5** `[Embed(source="/_assets/23_snd_hit1.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_hit1()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
