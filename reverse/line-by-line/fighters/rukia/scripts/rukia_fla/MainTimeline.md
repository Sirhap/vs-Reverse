# `rukia_fla.MainTimeline` — 朽木·露琪亚 根时间轴

一句话目的：朽木·露琪亚 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/rukia/scripts/rukia_fla/MainTimeline.as`（473 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`rukia` startFrame=1（朽木·露琪亚 义骸）；`rukia_shijie` startFrame=2（朽木·露琪亚 始解）；文件 `assets/fighter/rukia.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2，sf=2 → F3。

F2：speed=6 / jump=15 / heavy=1 / 拳防。必杀脸：`bsface1`←`bsface1`、`bsface2`←`bsface2`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。
F3：speed=9 / jump=15 / heavy=2 / 斩防。必杀脸：`bsface1`←`bsface1`、`bsface2`←`bsface2`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。

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

### `frame2`（时间轴 F2，L58–236）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 4 MAGIC 忍术/鬼道 | 3 | 6 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 120 | 5 MAGIC_HEAVY 重法 | 6 | 6 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 80 | 3 DA_HEAVY 重打 | 8 | 0 | 600 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 60 | 5 MAGIC_HEAVY 重法 | 4 | -5 | 500 | 0 | false |
| L118 | `kj2` | 空中技 2 / 上攻 | 60 | 4 MAGIC 忍术/鬼道 | 9 | -5 | 400 | 0 | false |
| L127 | `zh1` | 招 1 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L136 | `zh2` | 招 2 | 30 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L145 | `zh3` | 招 3 | 130 | 5 MAGIC_HEAVY 重法 | 6 | -6 | 300 | 1 | false |
| L154 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L163 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | -5 | 1000 | 0 | false |
| L172 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L181 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 1000 | 1 | false |
| L190 | `bs` | 必杀 | 280 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L199 | `sbs` | 上必杀 | 240 | 5 MAGIC_HEAVY 重法 | 15 | 10 | 0 | 1 | false |
| L208 | `cbs1` | 超必杀前段/多段 | 20 | 4 MAGIC 忍术/鬼道 | 1 | 0 | 0 | 0 | false |
| L217 | `cbs` | 超必杀 | 450 | 8 ICE 冰 | 3 | -15 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L226: `$fighter_ctrler.defineBishaFace("bsface1", bsface1);` — 登记必杀脸 BitmapData
- L227: `$fighter_ctrler.defineBishaFace("bsface2", bsface2);` — 登记必杀脸 BitmapData
- L228: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L229: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L230: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L231: `$fighter_ctrler.speed = 6;` — 走速
- L232: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L233: `$fighter_ctrler.heavy = 1;` — 重量
- L234: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L235: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L238–470）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L244 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 5 | 5 | 600 | 0 | false |
| L253 | `tz` | 跳重 | 80 | 7 FIRE 火 | 8 | 0 | 0 | 1 | false |
| L262 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L271 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 2 | -2 | 400 | 0 | false |
| L280 | `k3` | 普攻 3 | 40 | 1 KAN 砍 | 5 | 2 | 400 | 0 | false |
| L289 | `k4` | 普攻 4 | 60 | 8 ICE 冰 | 10 | 0 | 600 | 0 | false |
| L298 | `kj11` | 空中技 11 | 15 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 400 | 0 | false |
| L307 | `kj1` | 空中技 1 / 下攻 | 70 | 8 ICE 冰 | 0 | -5 | 600 | 0 | false |
| L316 | `kj2` | 空中技 2 / 上攻 | 20 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L325 | `kj21` | 空中技 21 | 60 | 8 ICE 冰 | 1 | -4 | 500 | 0 | false |
| L334 | `zh1` | 招 1 | 90 | 7 FIRE 火 | 5 | 0 | 0 | 1 | false |
| L343 | `zh2` | 招 2 | 50 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L352 | `zh3` | 招 3 | 40 | 1 KAN 砍 | 10 | -12 | 600 | 0 | false |
| L361 | `zh31` | 招 31 | 90 | 8 ICE 冰 | -10 | 15 | 0 | 1 | false |
| L370 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L379 | `sh12` | 抓 1 伤害段 | 50 | 8 ICE 冰 | 5 | 0 | 1000 | 0 | false |
| L388 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L397 | `sh21` | 抓 21 | 50 | 1 KAN 砍 | 5 | -5 | 1000 | 0 | false |
| L406 | `sh22` | 抓 2 伤害段 | 100 | 8 ICE 冰 | 10 | -10 | 1000 | 1 | false |
| L415 | `bs` | 必杀 | 280 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L424 | `sbs` | 上必杀 | 300 | 8 ICE 冰 | 10 | -10 | 0 | 1 | false |
| L433 | `cbs1` | 超必杀前段/多段 | 150 | 8 ICE 冰 | 10 | 0 | 1000 | 0 | false |
| L442 | `cbs` | 超必杀 | 100 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 1000 | 0 | false |
| L451 | `cbs2` | 超必杀前段/多段 | 100 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L240: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L460: `$fighter_ctrler.defineBishaFace("bsface1", bsface1);` — 登记必杀脸 BitmapData
- L461: `$fighter_ctrler.defineBishaFace("bsface2", bsface2);` — 登记必杀脸 BitmapData
- L462: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L463: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L464: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L465: `$fighter_ctrler.speed = 9;` — 走速
- L466: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L467: `$fighter_ctrler.heavy = 2;` — 重量
- L468: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L469: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
