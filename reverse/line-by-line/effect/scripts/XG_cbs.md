# `(无名包).XG_cbs` — 超必/万解火花

一句话目的：超必杀与万解共用的 add 火花。镜头 zoom 3.5 时播在 `(x, y-50)`。

源文件：`decompiled/other/effect/scripts/XG_cbs.as`（15 行）

## 如何挂上引擎

[`EffectModel`](../../engine/game/bvn/data/EffectModel.md) id `bisha_super`：`XG_cbs` + `snd_cbs` + `blendMode=add`。

两条入口都到 [`EffectCtrl`](../../engine/game/bvn/ctrl/EffectCtrl.md)：

- `$effect_ctrler.bisha(true, face?)` → `bisha(..., super=true)` → `cameraFocusOne` zoom 3.5 + 本剪辑
- `$effect_ctrler.startWanKai(face?)` → `wanKai`：永远当超必，同样本剪辑

普通必杀 `bisha(false)` 用 [`XG_bs`](XG_bs.md)，不用本类。时间轴长度与 `XG_bs` 同为 17 帧（FLA 里超必/必杀像同一套放大）。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 16 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 841**（FFDec `symbol841`），**17 帧** @30fps，约 6 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_cbs extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol841")]`：FFDec 把 sprite 841 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_cbs()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
