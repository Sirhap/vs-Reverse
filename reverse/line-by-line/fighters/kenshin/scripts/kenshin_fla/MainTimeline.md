# `kenshin_fla.MainTimeline` — 绯村·剑心（F2）/ 绯村·剑心 拔刀斋（F3） 根时间轴

一句话目的：绯村·剑心（F2）/ 绯村·剑心 拔刀斋（F3） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/kenshin/scripts/kenshin_fla/MainTimeline.as`（580 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`kenshin startFrame=1；kenshin_bdz startFrame=2`；文件 `assets/fighter/kenshin.swf`；comic_type 0 死神。 引擎 `gotoAndStop(startFrame+1)`，1→F2；2→F3。

F2：speed=12 / jump=17 / heavy=2 / 斩防。 本帧未调 `defineHurtSound*`。 F3：speed=14 / jump=18 / heavy=2 / 斩防。 本帧未调 `defineHurtSound*`。

F2 动作 MC `全动作_1`（含 `doWanKai()`）；F3 拔刀斋动作 MC `全动作_15`。 两形态共用一个 SWF：F2 浪人动作 MC 是 `全动作_1`（内含 `startWanKai()` + `doWanKai()` 切到 F3）；F3 拔刀斋动作 MC 是 `全动作_15`（`endWanKai()`）。两帧都 **没有** `defineBishaFace` / `defineHurtSound`（本角色无 `bsface*` / `snd_*` 导出）。引擎 `gotoAndStop(startFrame+1)`，1→F2 浪人；2→F3 拔刀斋。

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
- L34: `addFrameScript(0,frame1,1,frame2,2,frame3);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- L55: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–258）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 1 | 7 | 300 | 0 | false |
| L73 | `tz` | 跳重 | 80 | 7 FIRE 火 | 10 | 5 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 8 | -8 | 600 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 50 | 1 KAN 砍 | -1 | 0 | 500 | 0 | false |
| L118 | `kj21` | 空中技 2 段1 | 100 | 6 KAN_HEAVY 重砍 | 2 | 0 | 500 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 80 | 3 DA_HEAVY 重打 | 1 | 0 | 500 | 0 | true |
| L136 | `zh1` | 招 1 | 40 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 300 | 0 | false |
| L145 | `zh2` | 招 2 | 15 | 1 KAN 砍 | 3 | 0 | 600 | 0 | false |
| L154 | `zh3` | 招 3 | 110 | 6 KAN_HEAVY 重砍 | 0 | -10 | 800 | 0 | false |
| L163 | `bs` | 必杀 | 60 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L172 | `bs1` | 必杀前段/多段 1 | 60 | 6 KAN_HEAVY 重砍 | 0 | -5 | 500 | 1 | false |
| L181 | `sbs` | 上必杀 | 400 | 6 KAN_HEAVY 重砍 | 0 | 0 | 0 | 1 | false |
| L190 | `cbs1` | 超必杀前段/多段 1 | 300 | 6 KAN_HEAVY 重砍 | -3 | 0 | 1000 | 0 | false |
| L199 | `cbs2` | 超必杀前段/多段 2 | 10 | 2 DA 打 | -1 | 0 | 1000 | 0 | false |
| L208 | `cbs` | 超必杀 | 400 | 5 MAGIC_HEAVY 重法 | 20 | -10 | 0 | 1 | false |
| L217 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L226 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L235 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L253: `$fighter_ctrler.speed = 12;` — 走速
- L254: `$fighter_ctrler.jumpPower = 17;` — 跳跃初速
- L255: `$fighter_ctrler.heavy = 2;` — 重量
- L256: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L257: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L260–577）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L266 | `tk` | 跳轻/跳踢 | 20 | 1 KAN 砍 | 10 | 6 | 300 | 0 | false |
| L275 | `tk2` | 跳轻 段2 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L284 | `tz` | 跳重 | 170 | 6 KAN_HEAVY 重砍 | 5 | 0 | 0 | 1 | false |
| L293 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L302 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L311 | `k3` | 普攻 3 | 30 | 3 DA_HEAVY 重打 | 5 | 0 | 600 | 0 | false |
| L320 | `k4` | 普攻 4 | 60 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L329 | `k5` | 普攻 5 | 100 | 6 KAN_HEAVY 重砍 | 10 | -5 | 500 | 1 | false |
| L338 | `kj1` | 空中技 1 / 下攻 | 60 | 6 KAN_HEAVY 重砍 | 4 | 0 | 500 | 0 | false |
| L347 | `kj12` | 空中技 1 段2 | 100 | 6 KAN_HEAVY 重砍 | 15 | -10 | 0 | 1 | false |
| L356 | `kj2` | 空中技 2 / 上攻 | 100 | 6 KAN_HEAVY 重砍 | 0 | 0 | 500 | 0 | false |
| L365 | `zh1` | 招 1 | 150 | 6 KAN_HEAVY 重砍 | 2 | 0 | 0 | 1 | false |
| L374 | `zh21` | 招 2 段1 | 80 | 6 KAN_HEAVY 重砍 | 0 | 0 | 500 | 0 | false |
| L383 | `zh2` | 招 2 | 80 | 7 FIRE 火 | 5 | 0 | 600 | 0 | true |
| L392 | `zh31` | 招 3 段1 | 30 | 1 KAN 砍 | 6 | -6 | 700 | 0 | false |
| L401 | `zh3` | 招 3 | 100 | 7 FIRE 火 | 10 | -10 | 0 | 1 | false |
| L410 | `bs` | 必杀 | 60 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L419 | `bs1` | 必杀前段/多段 1 | 60 | 6 KAN_HEAVY 重砍 | 0 | -5 | 0 | 1 | false |
| L428 | `sbs` | 上必杀 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L437 | `sbs1` | 上必杀前段 1 | 20 | 1 KAN 砍 | 2 | 0 | 0 | 1 | false |
| L446 | `kbs1` | 空必杀段 1 | 10 | 1 KAN 砍 | 0 | 10 | 300 | 0 | false |
| L455 | `kbs2` | 空必杀段 2 | 100 | 3 DA_HEAVY 重打 | 5 | 0 | 800 | 0 | false |
| L464 | `kbs3` | 空必杀段 3 | 100 | 7 FIRE 火 | 7 | -7 | 800 | 0 | false |
| L473 | `kbs4` | 空必杀段 4 | 50 | 6 KAN_HEAVY 重砍 | 3 | 0 | 400 | 0 | false |
| L482 | `kbs` | 空必杀 | 120 | 9 ELECTRIC 雷 | 10 | -10 | 0 | 1 | false |
| L491 | `cbs1` | 超必杀前段/多段 1 | 100 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L500 | `cbs2` | 超必杀前段/多段 2 | 10 | 2 DA 打 | -1 | 0 | 1000 | 0 | false |
| L509 | `cbs` | 超必杀 | 300 | 6 KAN_HEAVY 重砍 | 5 | -5 | 1000 | 0 | true |
| L518 | `cbs3` | 超必杀前段/多段 3 | 250 | 5 MAGIC_HEAVY 重法 | 20 | -15 | 0 | 1 | false |
| L527 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L536 | `sh12` | 抓 1 伤害段 | 50 | 1 KAN 砍 | 1 | 0 | 500 | 0 | false |
| L545 | `sh13` | 抓 1 伤害段 3 | 100 | 3 DA_HEAVY 重打 | 20 | 0 | 0 | 1 | false |
| L554 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L563 | `sh22` | 抓 2 伤害段 | 50 | 0 ? | -8 | 0 | 1000 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L262: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L572: `$fighter_ctrler.speed = 14;` — 走速
- L573: `$fighter_ctrler.jumpPower = 18;` — 跳跃初速
- L574: `$fighter_ctrler.heavy = 2;` — 重量
- L575: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L576: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
