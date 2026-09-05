# `naruto_fla.MainTimeline` — 漩涡·鸣人（F2）/ 一尾（F3）/ 四尾（F4） 根时间轴

一句话目的：漩涡·鸣人（F2）/ 一尾（F3）/ 四尾（F4） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/naruto/scripts/naruto_fla/MainTimeline.as`（790 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler） → `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`naruto` sf=1；`naruto_yw` sf=2；`naruto_sw` sf=3；文件 `assets/fighter/naruto.swf`；comic_type 1 火影。同一 SWF 三形态。引擎 gotoAndStop(startFrame+1)：1→F2 常时；2→F3 一尾；3→F4 四尾。

F2 `startWanKai("鸣人3")` + `doWanKai()` 切一尾；F3 `startWanKai("鸣人4")` + `doWanKai()` 切四尾。三形态都登记脸 `鸣人1..6`。拳防。

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
- L34: `addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–359）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`鸣人全动作_1`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 3 | 8 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 80 | 3 DA_HEAVY 重打 | 10 | 10 | 400 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 600 | 0 | false |
| L100 | `k3` | 普攻 3 | 40 | 2 DA 打 | 5 | 0 | 600 | 0 | false |
| L109 | `k4` | 普攻 4 | 50 | 3 DA_HEAVY 重打 | 5 | -7 | 500 | 0 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 100 | 5 MAGIC_HEAVY 重法 | 8 | -1 | 0 | 1 | true |
| L127 | `kj2` | 空中技 2 / 上攻 | 10 | 2 DA 打 | 3 | 0 | 200 | 0 | false |
| L136 | `kj22` | 空中技 kj22 中段/收段 | 20 | 2 DA 打 | 5 | 0 | 400 | 0 | false |
| L145 | `kj23` | 空中技 kj23 中段/收段 | 20 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L154 | `kj24` | 空中技 kj24 中段/收段 | 40 | 3 DA_HEAVY 重打 | 5 | 0 | 400 | 0 | false |
| L163 | `kj25` | 空中技 kj25 中段/收段 | 40 | 3 DA_HEAVY 重打 | 4 | -7 | 500 | 0 | false |
| L172 | `zh1` | 招 1 | 20 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L181 | `zh2` | 招 2 | 20 | 1 KAN 砍 | 5 | 0 | 300 | 0 | false |
| L190 | `zh3` | 招 3 | 30 | 1 KAN 砍 | 10 | -7 | 500 | 0 | false |
| L199 | `zh32` | 招 zh32 | 60 | 3 DA_HEAVY 重打 | 8 | 0 | 0 | 1 | false |
| L208 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L217 | `sh12` | 抓伤害段 sh12 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L226 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L235 | `sh21` | 抓伤害段 sh21 | 20 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L244 | `sh22` | 抓伤害段 sh22 | 20 | 4 MAGIC 忍术/鬼道 | -10 | 0 | 1000 | 1 | false |
| L253 | `bs1` | 必杀 bs1 | 10 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 1000 | 0 | false |
| L262 | `bs3` | 必杀 bs3 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 800 | 0 | false |
| L271 | `bs` | 必杀 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | true |
| L280 | `sbs` | 上必杀 | 30 | 2 DA 打 | 0 | 2 | 800 | 0 | false |
| L290 | `sbs2` | 上必杀 sbs2 | 30 | 1 KAN 砍 | 10 | 0 | 0 | 1 | false |
| L300 | `cbs1` | 超必杀 cbs1 | 10 | 1 KAN 砍 | 0 | 0 | 1000 | 0 | false |
| L309 | `cbs2` | 超必杀 cbs2 | 10 | 6 KAN_HEAVY 重砍 | 0 | -6 | 1000 | 0 | false |
| L318 | `cbs3` | 超必杀 cbs3 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 10 | 1000 | 0 | true |
| L327 | `cbs4` | 超必杀 cbs4 | 50 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 800 | 0 | false |
| L336 | `cbs` | 超必杀 | 100 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

额外字段：`sbs` 额外字段：`checkDirect`=false；`sbs2` 额外字段：`checkDirect`=false

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L345: `$fighter_ctrler.defineBishaFace("鸣人1",bsface1);` — 登记必杀脸 BitmapData
- L346: `$fighter_ctrler.defineBishaFace("鸣人2",bsface2);` — 登记必杀脸 BitmapData
- L347: `$fighter_ctrler.defineBishaFace("鸣人3",bsface3);` — 登记必杀脸 BitmapData
- L348: `$fighter_ctrler.defineBishaFace("鸣人4",bsface4);` — 登记必杀脸 BitmapData
- L349: `$fighter_ctrler.defineBishaFace("鸣人5",bsface5);` — 登记必杀脸 BitmapData
- L350: `$fighter_ctrler.defineBishaFace("鸣人6",bsface6);` — 登记必杀脸 BitmapData
- L351: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L352: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L353: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L354: `$fighter_ctrler.speed = 8;` — 走速
- L355: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L356: `$fighter_ctrler.heavy = 3;` — 重量
- L357: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L358: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L361–561）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`鸣人九尾全动作_19`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L367 | `tk` | 跳轻/跳踢 | 60 | 2 DA 打 | 3 | 6 | 300 | 0 | false |
| L376 | `tz` | 跳重 | 80 | 3 DA_HEAVY 重打 | 3 | 5 | 400 | 0 | false |
| L385 | `k1` | 普攻 1 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L394 | `k2` | 普攻 2 | 60 | 3 DA_HEAVY 重打 | 3 | 0 | 400 | 0 | false |
| L403 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 2 | -7 | 500 | 0 | false |
| L412 | `kj1` | 空中技 1 / 下攻 | 200 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L421 | `kj2` | 空中技 2 / 上攻 | 10 | 11 CATCH 抓 | 0 | 0 | 800 | 0 | true |
| L430 | `kj21` | 空中技 kj21 中段/收段 | 190 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |
| L439 | `zh1` | 招 1 | 20 | 1 KAN 砍 | 2 | 0 | 500 | 0 | false |
| L448 | `zh11` | 招 zh11 | 20 | 2 DA 打 | -4 | 0 | 500 | 0 | false |
| L457 | `zh2` | 招 2 | 60 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L466 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L475 | `sh12` | 抓伤害段 sh12 | 50 | 6 KAN_HEAVY 重砍 | 5 | -3 | 1000 | 0 | false |
| L484 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L493 | `sh22` | 抓伤害段 sh22 | 150 | 3 DA_HEAVY 重打 | 10 | 0 | 1000 | 1 | false |
| L502 | `zh3` | 招 3 | 20 | 1 KAN 砍 | 0 | -5 | 500 | 0 | false |
| L511 | `bs1` | 必杀 bs1 | 30 | 4 MAGIC 忍术/鬼道 | 6 | 0 | 800 | 0 | false |
| L520 | `bs2` | 必杀 bs2 | 130 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L529 | `sbs` | 上必杀 | 350 | 3 DA_HEAVY 重打 | 15 | -15 | 0 | 1 | false |
| L538 | `cbs` | 超必杀 | 500 | 5 MAGIC_HEAVY 重法 | 50 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L363: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L547: `$fighter_ctrler.defineBishaFace("鸣人1",bsface1);` — 登记必杀脸 BitmapData
- L548: `$fighter_ctrler.defineBishaFace("鸣人2",bsface2);` — 登记必杀脸 BitmapData
- L549: `$fighter_ctrler.defineBishaFace("鸣人3",bsface3);` — 登记必杀脸 BitmapData
- L550: `$fighter_ctrler.defineBishaFace("鸣人4",bsface4);` — 登记必杀脸 BitmapData
- L551: `$fighter_ctrler.defineBishaFace("鸣人5",bsface5);` — 登记必杀脸 BitmapData
- L552: `$fighter_ctrler.defineBishaFace("鸣人6",bsface6);` — 登记必杀脸 BitmapData
- L553: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L554: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L555: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L556: `$fighter_ctrler.speed = 10;` — 走速
- L557: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L558: `$fighter_ctrler.heavy = 4;` — 重量
- L559: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L560: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame4`（时间轴 F4，L563–787）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`四尾全动作_30`。

### F4 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L569 | `tk` | 跳轻/跳踢 | 40 | 3 DA_HEAVY 重打 | 3 | 6 | 300 | 0 | false |
| L578 | `tz` | 跳重 | 80 | 3 DA_HEAVY 重打 | 3 | 5 | 400 | 0 | false |
| L587 | `k1` | 普攻 1 | 25 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L596 | `k2` | 普攻 2 | 50 | 3 DA_HEAVY 重打 | 10 | 0 | 600 | 0 | false |
| L605 | `k3` | 普攻 3 | 80 | 6 KAN_HEAVY 重砍 | -7 | -7 | 600 | 0 | false |
| L614 | `kj1` | 空中技 1 / 下攻 | 120 | 3 DA_HEAVY 重打 | 0 | -10 | 0 | 1 | false |
| L623 | `kj12` | 空中技 kj12 中段/收段 | 120 | 3 DA_HEAVY 重打 | 0 | -10 | 0 | 1 | false |
| L632 | `kj2` | 空中技 2 / 上攻 | 100 | 5 MAGIC_HEAVY 重法 | 8 | -5 | 300 | 1 | false |
| L641 | `zh1` | 招 1 | 60 | 3 DA_HEAVY 重打 | 7 | -3 | 0 | 1 | false |
| L650 | `zh2` | 招 2 | 110 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L659 | `zh3` | 招 3 | 20 | 1 KAN 砍 | -2 | -5 | 500 | 0 | false |
| L668 | `zh32` | 招 zh32 | 30 | 1 KAN 砍 | 2 | -6 | 500 | 0 | false |
| L677 | `zh33` | 招 zh33 | 30 | 1 KAN 砍 | 5 | -8 | 500 | 1 | false |
| L686 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L695 | `sh12` | 抓伤害段 sh12 | 50 | 6 KAN_HEAVY 重砍 | 5 | -3 | 1000 | 0 | false |
| L704 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L713 | `sh22` | 抓伤害段 sh22 | 150 | 3 DA_HEAVY 重打 | 10 | 0 | 1000 | 1 | false |
| L722 | `bs` | 必杀 | 60 | 3 DA_HEAVY 重打 | 5 | 0 | 500 | 0 | false |
| L731 | `bs1` | 必杀 bs1 | 230 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L740 | `sbs` | 上必杀 | 350 | 3 DA_HEAVY 重打 | 10 | -15 | 0 | 1 | false |
| L749 | `cbs` | 超必杀 | 350 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L758 | `cbs2` | 超必杀 cbs2 | 100 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 1000 | 0 | false |
| L767 | `cbs3` | 超必杀 cbs3 | 300 | 5 MAGIC_HEAVY 重法 | 20 | -20 | 1000 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L565: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L776: `$fighter_ctrler.defineBishaFace("鸣人1",bsface1);` — 登记必杀脸 BitmapData
- L777: `$fighter_ctrler.defineBishaFace("鸣人2",bsface2);` — 登记必杀脸 BitmapData
- L778: `$fighter_ctrler.defineBishaFace("鸣人3",bsface3);` — 登记必杀脸 BitmapData
- L779: `$fighter_ctrler.defineBishaFace("鸣人4",bsface4);` — 登记必杀脸 BitmapData
- L780: `$fighter_ctrler.defineBishaFace("鸣人5",bsface5);` — 登记必杀脸 BitmapData
- L781: `$fighter_ctrler.defineBishaFace("鸣人6",bsface6);` — 登记必杀脸 BitmapData
- L782: `$fighter_ctrler.speed = 10;` — 走速
- L783: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L784: `$fighter_ctrler.heavy = 5;` — 重量
- L785: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L786: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
