# `naruto_xr_fla.MainTimeline` — 漩涡·鸣人 仙人（F2）/ 黄金（F3） 根时间轴

一句话目的：漩涡·鸣人 仙人（F2）/ 黄金（F3） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/naruto_xr/scripts/naruto_xr_fla/MainTimeline.as`（693 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler） → `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`naruto_xianren` sf=1；`naruto_gold` sf=2；文件 `assets/fighter/naruto_xr.swf`；comic_type 1 火影。同一 SWF 两形态。引擎 gotoAndStop(startFrame+1)：1→F2 仙人；2→F3 黄金。

F2 脸 `鸣人1/2/5`；F3 脸 `金鸣1/2`。**无** `snd_*`，不调 `defineHurtSound*`。F2 `startWanKai()`（无脸键）+ `doWanKai()` 切黄金。拳防。

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

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–351）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`鸣人全动作_1`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 2 | 2 | 300 | 0 | false |
| L73 | `tz1` | 跳重段 tz1 | 20 | 4 MAGIC 忍术/鬼道 | 5 | 5 | 500 | 0 | false |
| L82 | `tz2` | 跳重段 tz2 | 30 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 500 | 0 | false |
| L91 | `tz` | 跳重 | 40 | 5 MAGIC_HEAVY 重法 | 6 | 6 | 0 | 1 | false |
| L100 | `k1` | 普攻 1 | 30 | 2 DA 打 | 1 | 0 | 250 | 0 | false |
| L109 | `k2` | 普攻 2 | 20 | 2 DA 打 | 4 | 0 | 400 | 0 | false |
| L118 | `k3` | 普攻 3 | 40 | 3 DA_HEAVY 重打 | 2 | 0 | 500 | 0 | false |
| L127 | `k4` | 普攻 4 | 60 | 3 DA_HEAVY 重打 | 5 | -6 | 700 | 0 | false |
| L136 | `kj1` | 空中技 1 / 下攻 | 20 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L145 | `kj12` | 空中技 kj12 中段/收段 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 500 | 0 | false |
| L154 | `kj21` | 空中技 kj21 中段/收段 | 40 | 1 KAN 砍 | 2 | 0 | 500 | 0 | false |
| L163 | `kj2` | 空中技 2 / 上攻 | 40 | 1 KAN 砍 | 3 | -8 | 600 | 0 | false |
| L172 | `zh1` | 招 1 | 90 | 3 DA_HEAVY 重打 | 5 | -8 | 500 | 0 | false |
| L181 | `zh2` | 招 2 | 60 | 3 DA_HEAVY 重打 | 10 | 0 | 700 | 0 | true |
| L190 | `zh21` | 招 zh21 | 60 | 3 DA_HEAVY 重打 | 10 | -3 | 0 | 1 | false |
| L199 | `zh3` | 招 3 | 15 | 4 MAGIC 忍术/鬼道 | 5 | -10 | 500 | 0 | false |
| L208 | `zh31` | 招 zh31 | 15 | 4 MAGIC 忍术/鬼道 | 3 | -3 | 600 | 0 | false |
| L217 | `zh33` | 招 zh33 | 15 | 4 MAGIC 忍术/鬼道 | 3 | -4 | 800 | 0 | false |
| L226 | `zh32` | 招 zh32 | 80 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L235 | `bs` | 必杀 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L244 | `bs1` | 必杀 bs1 | 60 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L253 | `sbs` | 上必杀 | 260 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L262 | `kbs1` | 空必杀 kbs1 | 30 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L271 | `kbs2` | 空必杀 kbs2 | 50 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L280 | `kbs` | 空必杀 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 10 | 0 | 1 | true |
| L289 | `cbs1` | 超必杀 cbs1 | 70 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L298 | `cbs` | 超必杀 | 100 | 5 MAGIC_HEAVY 重法 | 20 | -15 | 0 | 1 | true |
| L307 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L316 | `sh12` | 抓伤害段 sh12 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L325 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L334 | `sh22` | 抓伤害段 sh22 | 150 | 3 DA_HEAVY 重打 | -10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L343: `$fighter_ctrler.defineBishaFace("鸣人1",bsface1);` — 登记必杀脸 BitmapData
- L344: `$fighter_ctrler.defineBishaFace("鸣人2",bsface2);` — 登记必杀脸 BitmapData
- L345: `$fighter_ctrler.defineBishaFace("鸣人5",bsface5);` — 登记必杀脸 BitmapData
- L346: `$fighter_ctrler.speed = 9;` — 走速
- L347: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L348: `$fighter_ctrler.heavy = 3;` — 重量
- L349: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L350: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L353–690）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`鸣人全动作副本_16`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L359 | `tk` | 跳轻/跳踢 | 50 | 2 DA 打 | 2 | 2 | 500 | 0 | false |
| L368 | `tk2` | 跳轻段 tk2 | 40 | 2 DA 打 | 0 | 8 | 500 | 0 | false |
| L377 | `tz1` | 跳重段 tz1 | 10 | 1 KAN 砍 | 1 | 20 | 300 | 0 | false |
| L386 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L395 | `k1` | 普攻 1 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L404 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L413 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 2 | 0 | 500 | 0 | false |
| L422 | `k4` | 普攻 4 | 30 | 2 DA 打 | 5 | 0 | 600 | 0 | false |
| L431 | `k5` | 普攻 5 | 60 | 3 DA_HEAVY 重打 | 8 | -10 | 0 | 1 | false |
| L440 | `kj1` | 空中技 1 / 下攻 | 100 | 3 DA_HEAVY 重打 | 8 | -10 | 700 | 0 | false |
| L449 | `kj12` | 空中技 kj12 中段/收段 | 30 | 2 DA 打 | 5 | -3 | 500 | 0 | false |
| L458 | `kj13` | 空中技 kj13 中段/收段 | 50 | 3 DA_HEAVY 重打 | 10 | -5 | 0 | 1 | false |
| L467 | `kj2` | 空中技 2 / 上攻 | 20 | 2 DA 打 | 1 | -1 | 700 | 0 | false |
| L476 | `kj21` | 空中技 kj21 中段/收段 | 20 | 2 DA 打 | 3 | -6 | 700 | 0 | false |
| L485 | `kj23` | 空中技 kj23 中段/收段 | 30 | 4 MAGIC 忍术/鬼道 | 2 | 0 | 500 | 0 | false |
| L494 | `kj22` | 空中技 kj22 中段/收段 | 50 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L503 | `zh11` | 招 zh11 | 10 | 1 KAN 砍 | 10 | 0 | 600 | 0 | false |
| L512 | `zh1` | 招 1 | 20 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L521 | `zh12` | 招 zh12 | 30 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L530 | `zh2` | 招 2 | 100 | 3 DA_HEAVY 重打 | 5 | 0 | 0 | 1 | false |
| L539 | `zh21` | 招 zh21 | 50 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L548 | `zh22` | 招 zh22 | 50 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L557 | `zh3` | 招 3 | 100 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |
| L566 | `zh31` | 招 zh31 | 20 | 4 MAGIC 忍术/鬼道 | 2 | 0 | 500 | 0 | false |
| L575 | `bs` | 必杀 | 10 | 1 KAN 砍 | 10 | 0 | 500 | 0 | false |
| L584 | `bs1` | 必杀 bs1 | 15 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L593 | `bs2` | 必杀 bs2 | 20 | 5 MAGIC_HEAVY 重法 | 20 | -15 | 0 | 1 | false |
| L602 | `sbs` | 上必杀 | 300 | 5 MAGIC_HEAVY 重法 | 15 | -10 | 0 | 1 | false |
| L611 | `kbs1` | 空必杀 kbs1 | 10 | 2 DA 打 | 0 | 20 | 0 | 0 | false |
| L620 | `kbs` | 空必杀 | 280 | 3 DA_HEAVY 重打 | 0 | 10 | 0 | 1 | false |
| L629 | `cbs1` | 超必杀 cbs1 | 150 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 1000 | 0 | false |
| L638 | `cbs` | 超必杀 | 200 | 5 MAGIC_HEAVY 重法 | 30 | -20 | 0 | 1 | true |
| L647 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L656 | `sh12` | 抓伤害段 sh12 | 50 | 0 ? 非表内 | -7 | 0 | 1000 | 0 | false |
| L665 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L674 | `sh22` | 抓伤害段 sh22 | 150 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L355: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L683: `$fighter_ctrler.defineBishaFace("金鸣1",bsface3);` — 登记必杀脸 BitmapData
- L684: `$fighter_ctrler.defineBishaFace("金鸣2",bsface4);` — 登记必杀脸 BitmapData
- L685: `$fighter_ctrler.speed = 12;` — 走速
- L686: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L687: `$fighter_ctrler.heavy = 3;` — 重量
- L688: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L689: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
