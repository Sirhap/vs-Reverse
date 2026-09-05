# `(无名包).snd_fzbs` — 遗留辅助必杀声（未引用）

一句话目的：配对未登记的 [`XG_fzbs`](XG_fzbs.md)。没有任何 `EffectVO.sound` 写这个 id。

源文件：`decompiled/other/effect/scripts/snd_fzbs.as`（15 行）

## 如何挂上引擎

[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 仍能 `getEffect` 到本类，但引擎从不调。

声音和 MC 走同一条 [`AssetManager.getEffect(className)`](../../engine/game/bvn/ctrl/AssetManager.md)：从 `"assets/effect.swf"` `getClass` 再 `new`。[`SoundCtrl.playEffectSound`](../../engine/game/bvn/ctrl/SoundCtrl.md) 把返回值当 `Sound`。`playAssetSound` 走另一套 `sounds/` 加载器，**不**进本库。

**本表未引用**：没有任何 `EffectVO.sound` 写本 id。`playEffectSound` 仍能 `getEffect` 到。

SWF DefineSound **char 5**：MP3（fmt=2），22050 Hz，16-bit mono，914 ms（20160 samples / 22050 Hz），payload 4559 B。

## 逐行说明

无名包。`public dynamic class snd_fzbs extends Sound`。

- **L5** `[Embed(source="/_assets/5_snd_fzbs.mp3")]`：FFDec 拆出的 MP3。运行时是 SWF 里的 DefineSound，不是单独文件。
- **L6** 类名 = `EffectVO.sound` 字符串。
- **L9–12 `snd_fzbs()`**：`super()`。无循环点、无音量。音量靠 `SoundCtrl._sndTransform`。

无其它函数。
