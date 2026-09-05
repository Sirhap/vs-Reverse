# `fighter.ctrler.FighterEffectCtrl` — 角色/助战侧 VFX 转发

一句话目的：SWF 时间轴的 `$effect_ctrler`。把 shine/shake/残影/必杀特写/万解/鬼步/光晕转给单例 `EffectCtrl`，并记住本目标正在 shake/shadow/glow/ghost，避免 end 时误关别人的。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterEffectCtrl.as`（225 行）

## Callers / callees

- **装配**：
  - `FighterCtrler.initFighter`：`new FighterEffectCtrl(fighter)`，`mc.setEffectCtrler` → SWF `$effect_ctrler`。
  - `AssisiterCtrler.initAssister`：助战自己 new 一份，经 `effect` getter 给 `$assisterCtrler.effect`。
  - `FighterAttacker.setOwner`：攻击体**不** new，共用主人那份（角色或助战）。
- **SWF**（`parent.$effect_ctrler` / `$assisterCtrler.effect`）：`walk`/`dash`/`shine`/`shadow`/`endShadow`/`slowDown`/`bisha`/`endBisha`/`startWanKai`/`startShake`/`energyExplode`/`replaceSkill`/`ghostStep` 等。一护万解 `startShake(0,3)`、鼬 `bisha(false,"鼬1")`。
- **引擎**：`FighterMcCtrler` 走/跳/落地/受击落地/鬼步也会调本类；`FighterCtrler.defineBishaFace` → `setBishaFace`。
- **Callees**：`EffectCtrl`（shine/shake/startShake/endShake/startShadow/endShadow/doEffectById/bisha/endBisha/wanKai/endWanKai/jumpEffect/jumpAirEffect/touchFloorEffect/hitFloorEffect/slowDown/energyExplode/replaceSkill/ghostStep/endGhostStep/startFilter/endFilter）、`SoundCtrl.playAssetSoundRandom`、`Debugger.errorMsg`。

## 命名备注

- `destory`：原拼写。
- `_isShakeIng` / `_isShadowIng` / `_isGlowIng`：Ing 后缀。end* 用它们避免把全局 shake/别人的残影关掉。
- `endShadow` **不清** `_isShadowIng`，重复 end 会再调一次 `EffectCtrl.endShadow`（幂等）。
- `shake` 的 x 振幅只参与 `Math.max`，真正传给 `EffectCtrl` 的 x 恒 0。时长 SWF 传**秒**，这里 `*1000` 变 ms。
- 必杀脸是 SWF 导出的 **BitmapData 子类**，`new Class()` 当 BitmapData。

## 逐行说明

### 字段 / 构造（L17–36）

- `_target`：`BaseGameSprite`（角色/助战/理论上攻击体共用主人时仍指向主人）。
- `_targetDisplay`：`getDisplay()`，残影/跳尘用显示对象坐标。
- `_inGhostStep`：`walk()` 时改播 `ghost_step` 而不是脚步声。
- `_faceObj`：`名字 → BitmapData Class`。`defineBishaFace("鼬1", bsface1)`。
- `_isShakeIng` / `_isShadowIng` / `_isGlowIng`：本实例是否开过对应效果。
- 构造 `param1`=`BaseGameSprite`，立刻取 display。

### `destory`（L38–43）

三引用置 null。**不** `endShake/endShadow/endGlow/endGhostStep`。若时间轴没成对 end，全局震动/残影/滤镜可能残留到该 display 被拆。?

### `setBishaFace`（L45–48）

`param1` 名字，`param2` Class。覆盖同名。

### `getFace`（L50–66）私有

空名 → null。未登记 → `Debugger.errorMsg("未定义必杀特写:"+name)` return null（不 throw）。`new Class()` 当 BitmapData，包进 smoothing Bitmap。每次 bisha 都 **new 一份** BitmapData，不缓存。

### `shine`（L68–72）

`param1` 颜色默认白 `0xFFFFFF`。白用 alpha 0.3，其它 0.2。转 `EffectCtrl.shine`。SWF 常 `shine(0)` 黑闪、`shine(16776960)` 黄。

### `shake`（L74–78）

`param1` x 默认 0，`param2` y 默认 3，`param3` 秒默认 0。`Math.max(x,y)*2` 当 Y 振幅，X 传 0。时长 `*1000`；`EffectCtrl.shake` 对 `<=0` 收成 500ms，所以 SWF `shake(0,3)` 实际抖 0.5 秒。

### `startShake` / `endShake`（L80–93）

常驻振幅。`start` 记 `_isShakeIng`。`end` 仅自己开过才 `EffectCtrl.endShake`（全局只有一套常驻震动，防误关）。一护万解时间轴 `startShake(0,3)`，须有对应 `endShake`；本包不少片段只 start 不 end。?

### `shadow` / `endShadow`（L95–107）

`param1/2/3` = r/g/b offset，默认 0（黑残影）。鬼步用 `(0,0,255)` 蓝。`endShadow` 不清 `_isShadowIng`。

### `dash`（L109–119）

空中 `dash_air`，地面 `dash`。坐标用逻辑 x/y + `direct`。

### `bisha` / `endBisha`（L121–130）

`param1` 是否超必（镜头 zoom 3.5 + `bisha_super`），`param2` 脸名可空。`getFace` 失败则无特写仍开黑底。`endBisha` 无条件转 EffectCtrl（多人同时必杀时 EffectCtrl 内部看 just-render 表）。

### `startWanKai` / `endWanKai`（L132–144）

万解镜头：有脸名才 `getFace`。`endWanKai` **额外**要求 `(_target as FighterMain).actionState == 50` 才真正 `EffectCtrl.endWanKai`。`doWanKai` 会把 state 置 50。目标不是 `FighterMain` 则 as 得 null，读 `actionState` NPE。助战不该调这对。

### `walk`（L146–156）

鬼步中：`ghost_step` 特效。否则 `step1/2/3` 随机脚步。`FighterMcCtrler` 走路循环调。

### `jump` / `jumpAir` / `touchFloor`（L158–171）

转 `jumpEffect` / `jumpAirEffect` / `touchFloorEffect`，坐标用 **display** x/y（不是逻辑 `_x/_y`，通常已在 render 末尾对齐）。

### `hitFloor`（L173–176）

`param1` 强度：0 普通 / 1 轻 / 2 重+烟。受击落地 `FighterMcCtrler` 调。

### `slowDown`（L178–181）

`param1` 秒。固定 rate=1.5，时长 `*1000` ms。覆盖式，不叠。

### `energyExplode` / `replaceSkill`（L183–191）

爆气 / 替身。转 `EffectCtrl` 对应演出（pause + 黑底 + `explodeSp`/`replaceSp`）。时间轴爆气/替身帧调。

### `ghostStep` / `endGhostStep`（L193–205）

开：`_inGhostStep=true`，蓝残影，`EffectCtrl.ghostStep`（just-render + pause + 黑底 + `snd_ghost_jump`）。关：清标志、`endShadow`、`endGhostStep`。

### `startGlow` / `endGlow`（L207–222）

`param1` 颜色默认白。`GlowFilter(color, 1, 20, 20, 2, 1, inner=false, knockout=true)`，经 `startFilter` 挂 `BitmapFilterView`。`endGlow` 无论有没有 start 都把 `_isGlowIng` 打回 false；只在 true 时 `endFilter`。
