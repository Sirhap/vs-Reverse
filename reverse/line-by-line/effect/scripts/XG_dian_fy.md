# `(无名包).XG_dian_fy` — 电属性防御火花

一句话目的：挡住电属性（hitType 9）时的防御火花。朝向跟攻击者。

源文件：`decompiled/other/effect/scripts/XG_dian_fy.as`（15 行）

## 如何挂上引擎

[`EffectModel.initDefenseEffect`](../../engine/game/bvn/data/EffectModel.md) `defense_9`：`XG_dian_fy`，`snd_defx`，freeze 400ms，`blendMode=add`，`followDirect=true`，电色闪 `0x8288D2` alpha 0.2，shake pow 6 / 400ms。

[`EffectCtrl.doDefenseEffect`](../../engine/game/bvn/ctrl/EffectCtrl.md)：角色 `defenseType==0` 用原始 hitType；`==1` 只把斩系 1→2、6→3，**电仍是 9**。无 `specialEffectId`：防住不挂 [`xg_dian_ing`](xg_dian_ing.md)。

未知防御类型回落 `defense_5`（[`XG_mffyx`](XG_mffyx.md)），不是本类。

运行时 **不**再 `new` 本 MC：只在 `EffectModel.initlize` → `cacheBitmapData` 时实例化一次，画成 15 张位图（**最后一帧不烘**，见 [`EffectVO`](../../engine/game/bvn/data/EffectVO.md)）。之后 [`EffectView`](../../engine/game/bvn/views/effects/EffectView.md) 只播 Bitmap。

SWF：`assets/effect.swf` DefineSprite **char 828**（FFDec `symbol828`），**16 帧** @30fps，约 8 次 Place。无帧标签、无 `addFrameScript`。

运行时无帧脚本。

## 逐行说明

无名包。`public dynamic class XG_dian_fy extends MovieClip`。

- **L5** `[Embed(source="/_assets/assets.swf", symbol="symbol828")]`：FFDec 把 sprite 828 链到本类。真正运行不走 Flex Embed，靠 ZIP 里整份 `effect.swf` 的 SymbolClass。
- **L6** 类名必须与 `EffectVO.className` / `AssetManager.getClass` 逐字相同（大小写敏感）。
- **L9–12 `XG_dian_fy()`**：`super()`。无字段、无 `stop`、无标签脚本。时间轴默认从 F1 播到尾；烘焙时 `gotoAndStop(1)` 再 `nextFrame` 扫。

无其它函数。
