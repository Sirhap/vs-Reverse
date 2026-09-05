# `sasuke_fla.MainTimeline` — 宇智波·佐助 根时间轴

一句话目的：宇智波·佐助 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/sasuke/scripts/sasuke_fla/MainTimeline.as`（493 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`sasuke` startFrame=1（宇智波·佐助）；`sasuke_zy` startFrame=2（宇智波·佐助 咒怨）；文件 `assets/fighter/sasuke.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2，sf=2 → F3。

F2：speed=8 / jump=15 / heavy=3 / 斩防。必杀脸：`佐助1`←`bsface1`、`佐助2`←`bsface2`、`佐助3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。
F3：speed=10 / jump=15 / heavy=3 / 拳防。必杀脸：`佐助1`←`bsface1`、`佐助2`←`bsface2`、`佐助3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用
| L23 | `$fighter_ctrler` | `*` | 引擎注入
| L25 | `$mc_ctrler` | `*` | 引擎注入
| L27 | `$effect_ctrler` | `*` | 引擎注入
| L29 | `defineAction` | `Function` | setFighterCtrler 写成 ctrler.defineAction

### 函数

#### `MainTimeline()`（L31–35）

- L33: `super();`
- L34: `addFrameScript(0, frame1, 1, frame2, 2, frame3);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–291）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 2 DA 打 | 3 | 3 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 50 | 1 KAN 砍 | 1 | 10 | 600 | 0 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 6 | 0 | 500 | 0 | false |
| L100 | `k3` | 普攻 3 | 80 | 6 KAN_HEAVY 重砍 | 8 | 0 | 500 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 110 | 9 ELECTRIC 雷 | 6 | 0 | 0 | 1 | false |
| L118 | `kj21` | 空中技 21 | 30 | 1 KAN 砍 | 1 | 0 | 400 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 80 | 9 ELECTRIC 雷 | 10 | 0 | 0 | 1 | false |
| L136 | `zh1` | 招 1 | 40 | 2 DA 打 | 3 | -3 | 400 | 0 | false |
| L145 | `zh12` | 招 12 | 70 | 3 DA_HEAVY 重打 | 5 | -5 | 0 | 1 | false |
| L154 | `zh2` | 招 2 | 70 | 9 ELECTRIC 雷 | 7 | -7 | 500 | 0 | true |
| L163 | `zh3` | 招 3 | 50 | 3 DA_HEAVY 重打 | 7 | -7 | 700 | 0 | false |
| L172 | `zh31` | 招 31 | 60 | 3 DA_HEAVY 重打 | 10 | -5 | 0 | 1 | false |
| L181 | `bs` | 必杀 | 300 | 9 ELECTRIC 雷 | 15 | 0 | 0 | 1 | false |
| L190 | `sbs` | 上必杀 | 250 | 9 ELECTRIC 雷 | 10 | -10 | 0 | 1 | false |
| L199 | `sbs2` | 上必杀前段/多段 | 250 | 9 ELECTRIC 雷 | 10 | -10 | 0 | 1 | true |
| L208 | `cbs1` | 超必杀前段/多段 | 100 | 9 ELECTRIC 雷 | 10 | -9 | 800 | 0 | true |
| L217 | `cbs2` | 超必杀前段/多段 | 30 | 1 KAN 砍 | 1 | -4 | 1000 | 0 | false |
| L226 | `cbs3` | 超必杀前段/多段 | 55 | 6 KAN_HEAVY 重砍 | 3 | 0 | 1000 | 0 | false |
| L235 | `cbs` | 超必杀 | 280 | 7 FIRE 火 | 30 | 20 | 0 | 1 | false |
| L244 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L262 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L271 | `sh22` | 抓 2 伤害段 | 150 | 9 ELECTRIC 雷 | 0 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L280: `$fighter_ctrler.defineBishaFace("佐助1", bsface1);` — 登记必杀脸 BitmapData
- L281: `$fighter_ctrler.defineBishaFace("佐助2", bsface2);` — 登记必杀脸 BitmapData
- L282: `$fighter_ctrler.defineBishaFace("佐助3", bsface3);` — 登记必杀脸 BitmapData
- L283: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L284: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L285: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L286: `$fighter_ctrler.speed = 8;` — 走速
- L287: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L288: `$fighter_ctrler.heavy = 3;` — 重量
- L289: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L290: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L293–490）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L299 | `tk` | 跳轻/跳踢 | 20 | 1 KAN 砍 | 5 | 3 | 100 | 0 | false |
| L308 | `tz` | 跳重 | 140 | 7 FIRE 火 | 10 | 5 | 0 | 1 | false |
| L317 | `k1` | 普攻 1 | 30 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L326 | `k2` | 普攻 2 | 40 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L335 | `k3` | 普攻 3 | 70 | 3 DA_HEAVY 重打 | 8 | -6 | 600 | 0 | false |
| L344 | `kj2` | 空中技 2 / 上攻 | 100 | 9 ELECTRIC 雷 | 10 | -5 | 0 | 1 | false |
| L353 | `kj1` | 空中技 1 / 下攻 | 80 | 5 MAGIC_HEAVY 重法 | -10 | 0 | 600 | 0 | false |
| L362 | `zh1` | 招 1 | 20 | 1 KAN 砍 | 5 | 0 | 400 | 0 | false |
| L371 | `zh2` | 招 2 | 160 | 9 ELECTRIC 雷 | 10 | -5 | 0 | 1 | true |
| L380 | `zh3` | 招 3 | 100 | 6 KAN_HEAVY 重砍 | -8 | -7 | 600 | 0 | false |
| L389 | `bs1` | 必杀前段/多段 | 60 | 9 ELECTRIC 雷 | 10 | 0 | 1000 | 0 | false |
| L398 | `bs` | 必杀 | 30 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 1000 | 0 | false |
| L407 | `bs2` | 必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 1000 | 1 | false |
| L416 | `sbs` | 上必杀 | 280 | 7 FIRE 火 | 10 | -8 | 0 | 1 | false |
| L425 | `cbs1` | 超必杀前段/多段 | 200 | 9 ELECTRIC 雷 | 0 | 0 | 500 | 0 | true |
| L434 | `cbs` | 超必杀 | 300 | 5 MAGIC_HEAVY 重法 | 15 | -10 | 500 | 1 | true |
| L443 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L452 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | -3 | 1000 | 0 | false |
| L461 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L470 | `sh22` | 抓 2 伤害段 | 150 | 9 ELECTRIC 雷 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L295: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L479: `$fighter_ctrler.defineBishaFace("佐助1", bsface1);` — 登记必杀脸 BitmapData
- L480: `$fighter_ctrler.defineBishaFace("佐助2", bsface2);` — 登记必杀脸 BitmapData
- L481: `$fighter_ctrler.defineBishaFace("佐助3", bsface3);` — 登记必杀脸 BitmapData
- L482: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L483: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L484: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L485: `$fighter_ctrler.speed = 10;` — 走速
- L486: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L487: `$fighter_ctrler.heavy = 3;` — 重量
- L488: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L489: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
