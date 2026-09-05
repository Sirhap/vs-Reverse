# `byakuya_fla.MainTimeline` — 朽木·白哉（F2）/ 朽木·白哉 卍解（F3） 根时间轴

一句话目的：朽木·白哉（F2）/ 朽木·白哉 卍解（F3） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/byakuya/scripts/byakuya_fla/MainTimeline.as`（460 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`byakuya startFrame=1；byakuya_wanjie startFrame=2`；文件 `assets/fighter/byakuya.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，1→F2 始解；2→F3 卍解。

两形态共用一个 SWF：F2 始解动作 MC 是误名的 `一护万解全动作_1`（内含 `doWanKai()` 切到 F3）；F3 卍解动作 MC 是 `sprite631_14`。两帧都 **没有** `defineHurtSound`（本角色无 `snd_*` 导出）。`defenseType=1` 拳防。卍解更高速（speed 13/jump 17 vs 10/15）。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用
| L29 | `defineAction` | `Function` | `setFighterCtrler` 写成 ctrler.defineAction

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

### `frame2`（时间轴 F2，L58–261）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 0 | 0 | 700 | 0 | false |
| L73 | `tz` | 跳重 | 70 | 6 KAN_HEAVY 重砍 | 5 | 5 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 200 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 50 | 6 KAN_HEAVY 重砍 | 7 | -7 | 600 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 60 | 6 KAN_HEAVY 重砍 | 8 | 0 | 300 | 0 | false |
| L118 | `kj21` | 空中技 2 中段 | 30 | 1 KAN 砍 | 1 | 0 | 300 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 50 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 600 | 0 | false |
| L136 | `zh1` | 招 1 | 40 | 4 MAGIC 忍术/鬼道 | 8 | 0 | 300 | 0 | false |
| L145 | `zh2` | 招 2 | 100 | 5 MAGIC_HEAVY 重法 | 12 | 0 | 0 | 1 | true |
| L154 | `zh3` | 招 3 | 30 | 1 KAN 砍 | 8 | -6 | 500 | 0 | false |
| L163 | `zh32` | 招 3 击飞 | 50 | 1 KAN 砍 | 8 | -6 | 500 | 1 | false |
| L172 | `bs` | 必杀 | 30 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L181 | `bs1` | 必杀前段/多段 | 80 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |
| L190 | `sbs1` | 上必杀前段 | 30 | 1 KAN 砍 | 0 | -1 | 500 | 0 | false |
| L199 | `sbs` | 上必杀 | 30 | 1 KAN 砍 | 5 | -10 | 0 | 1 | false |
| L208 | `cbs` | 超必杀 | 450 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | true |
| L217 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L226 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L235 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 0 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L253: `$fighter_ctrler.defineBishaFace("白哉1",bsface1);` — 登记必杀脸 BitmapData
- L254: `$fighter_ctrler.defineBishaFace("白哉2",bsface2);` — 登记必杀脸 BitmapData
- L255: `$fighter_ctrler.defineBishaFace("白哉3",bsface3);` — 登记必杀脸 BitmapData
- L256: `$fighter_ctrler.speed = 10;` — 走速
- L257: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L258: `$fighter_ctrler.heavy = 3;` — 重量
- L259: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L260: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L263–457）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L269 | `tk` | 跳轻/跳踢 | 120 | 9 ELECTRIC 雷 | 10 | 6 | 0 | 1 | false |
| L278 | `tz` | 跳重 | 20 | 1 KAN 砍 | 0 | 10 | 300 | 0 | false |
| L287 | `kj1` | 空中技 1 / 下攻 | 120 | 6 KAN_HEAVY 重砍 | 10 | -5 | 0 | 1 | false |
| L296 | `k1` | 普攻 1 | 20 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L305 | `k2` | 普攻 2 | 20 | 1 KAN 砍 | 3 | -5 | 500 | 0 | false |
| L314 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 5 | 6 | 600 | 0 | false |
| L323 | `kj2` | 空中技 2 / 上攻 | 20 | 1 KAN 砍 | 5 | -3 | 500 | 0 | false |
| L332 | `zh1` | 招 1 | 120 | 5 MAGIC_HEAVY 重法 | 5 | 0 | 0 | 1 | false |
| L341 | `zh3` | 招 3 | 150 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | false |
| L350 | `zh21` | 招 2 分支 | 80 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |
| L359 | `zh2` | 招 2 | 80 | 6 KAN_HEAVY 重砍 | 5 | -5 | 500 | 0 | true |
| L368 | `bs` | 必杀 | 40 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L377 | `bs1` | 必杀前段/多段 | 40 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 500 | 0 | false |
| L386 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 15 | -5 | 0 | 1 | true |
| L395 | `cbs1` | 超必杀前段 | 25 | 1 KAN 砍 | 0 | -2 | 0 | 1 | false |
| L404 | `cbs` | 超必杀 | 25 | 1 KAN 砍 | 0 | -2 | 500 | 0 | false |
| L413 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L422 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | -3 | 1000 | 0 | false |
| L431 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L440 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 8 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L265: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L449: `$fighter_ctrler.defineBishaFace("白哉1",bsface1);` — 登记必杀脸 BitmapData
- L450: `$fighter_ctrler.defineBishaFace("白哉2",bsface2);` — 登记必杀脸 BitmapData
- L451: `$fighter_ctrler.defineBishaFace("白哉3",bsface3);` — 登记必杀脸 BitmapData
- L452: `$fighter_ctrler.speed = 13;` — 走速
- L453: `$fighter_ctrler.jumpPower = 17;` — 跳跃初速
- L454: `$fighter_ctrler.heavy = 3;` — 重量
- L455: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L456: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
