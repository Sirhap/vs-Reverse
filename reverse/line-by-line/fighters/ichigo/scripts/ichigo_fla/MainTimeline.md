# `ichigo_fla.MainTimeline` — 黑崎·一护（F2）/ 卍解（F3）/ 半虚（F4）/ 虚化（F5） 根时间轴

一句话目的：黑崎·一护（F2）/ 卍解（F3）/ 半虚（F4）/ 虚化（F5） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/ichigo/scripts/ichigo_fla/MainTimeline.as`（914 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler，若源里写了）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`ichigo sf=1；ichigo_wanjie sf=2；ichigo_xuhua_half sf=3；ichigo_xuhua sf=4`；文件 `assets/fighter/ichigo.swf`；comic_type 0 死神。引擎 gotoAndStop(startFrame+1)：1→F2 始解；2→F3 卍解；3→F4 半虚；4→F5 虚化。

同一 SWF 四形态。本类 **没有** `defineAction` 别名。**未写** `defenseType` → 默认 0 斩防。F2 脸键写成 **`一户1`/`一户2`/`一户万解`/`一户万解1`**（户≠护，FLA 原拼）。F3 复用同一套脸键。F4 半虚脸 `半虚1..4`（bsface4/8/9/10）。F5 虚化脸 `虚护1..3`。`doWanKai()` 根时间轴 nextFrame；`doWanKai(4)`/`doWanKai(5)` 是 `gotoAndStop` 到 F4/F5。动作 MC：F2 `一护全动作_1`、F3 `一护万解全动作_15`、F4 `一护全动作_30`、F5 `一护虚化全动作_60`。三份 AI 面；`AI面_2`/`AI面副本_16` 缺 `kbsmian`，`AI面_31` 有。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用

### 函数

#### `MainTimeline()`（L29–33）

- L31: `super();`
- L32: `addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 3, this.frame4, 4, this.frame5);`

#### `setFighterCtrler(param1:*)`（L35–38）

- L37: `$fighter_ctrler = param1;`

#### `setFighterMcCtrler(param1:*)`（L40–43）

- L42: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L45–48）

- L47: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L50–53）

- L52: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L55–243）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L61 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 2 | 6 | 350 | 0 | false |
| L70 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 5 | 5 | 300 | 1 | false |
| L79 | `k1` | 普攻 1 | 40 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L88 | `k2` | 普攻 2 | 50 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L97 | `k3` | 普攻 3 | 70 | 6 KAN_HEAVY 重砍 | 7 | -7 | 600 | 0 | false |
| L106 | `kj1` | 空中技 1 / 下攻 | 80 | 3 DA_HEAVY 重打 | 8 | 0 | 0 | 1 | true |
| L115 | `kj21` | 空中技 2 中段/收段 | 20 | 1 KAN 砍 | 1 | 0 | 100 | 0 | false |
| L124 | `kj2` | 空中技 2 / 上攻 | 60 | 4 MAGIC 忍术/鬼道 | 1 | -10 | 500 | 0 | false |
| L133 | `zh1` | 招 1 | 80 | 5 MAGIC_HEAVY 重法 | 3 | 0 | 300 | 1 | false |
| L142 | `zh2` | 招 2 | 80 | 6 KAN_HEAVY 重砍 | 8 | -3 | 600 | 0 | false |
| L151 | `zh3` | 招 3 | 80 | 5 MAGIC_HEAVY 重法 | 5 | -5 | 300 | 1 | false |
| L160 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L169 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L178 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L187 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |
| L196 | `bs1` | 必杀前段/多段 | 80 | 5 MAGIC_HEAVY 重法 | 5 | 0 | 1000 | 0 | false |
| L205 | `bs` | 必杀 | 240 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L214 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 3 | -8 | 0 | 1 | false |
| L223 | `cbs` | 超必杀 | 450 | 5 MAGIC_HEAVY 重法 | 40 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L57: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L232: `$fighter_ctrler.defineBishaFace("一户1", bsface1);` — 登记必杀脸 BitmapData
- L233: `$fighter_ctrler.defineBishaFace("一户2", bsface2);` — 登记必杀脸 BitmapData
- L234: `$fighter_ctrler.defineBishaFace("一户万解", bsface3);` — 登记必杀脸 BitmapData
- L235: `$fighter_ctrler.defineBishaFace("一户万解1", bsface4);` — 登记必杀脸 BitmapData
- L236: `$fighter_ctrler.defineHurtSound(snd_hurt2, snd_hurt1);` — 受击语音
- L237: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L238: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L239: `$fighter_ctrler.speed = 6;` — 走速
- L240: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L241: `$fighter_ctrler.heavy = 3;` — 重量
- L242: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L245–433）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L251 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 2 | 6 | 350 | 0 | false |
| L260 | `tz` | 跳重 | 110 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |
| L269 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L278 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L287 | `k3` | 普攻 3 | 40 | 1 KAN 砍 | 7 | -7 | 500 | 0 | false |
| L296 | `kj1` | 空中技 1 / 下攻 | 80 | 5 MAGIC_HEAVY 重法 | -2 | 0 | 600 | 0 | true |
| L305 | `kj21` | 空中技 2 中段/收段 | 20 | 4 MAGIC 忍术/鬼道 | 1 | -14 | 350 | 0 | false |
| L314 | `kj2` | 空中技 2 / 上攻 | 70 | 6 KAN_HEAVY 重砍 | 1 | 15 | 500 | 0 | false |
| L323 | `zh1` | 招 1 | 50 | 6 KAN_HEAVY 重砍 | 2 | 0 | 500 | 0 | false |
| L332 | `zh2` | 招 2 | 80 | 6 KAN_HEAVY 重砍 | 5 | 0 | 0 | 1 | false |
| L341 | `zh3` | 招 3 | 80 | 6 KAN_HEAVY 重砍 | 4 | -4 | 0 | 1 | false |
| L350 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L359 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L368 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L377 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 3 | 0 | 0 | 1 | false |
| L386 | `bs` | 必杀 | 300 | 5 MAGIC_HEAVY 重法 | 25 | 0 | 0 | 1 | false |
| L395 | `sbs` | 上必杀 | 20 | 1 KAN 砍 | 0 | -0.5 | 500 | 0 | false |
| L404 | `sbs2` | 上必杀前段/多段 | 20 | 1 KAN 砍 | 0 | -5 | 0 | 1 | false |
| L413 | `cbs` | 超必杀 | 600 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L247: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L422: `$fighter_ctrler.defineBishaFace("一户1", bsface1);` — 登记必杀脸 BitmapData
- L423: `$fighter_ctrler.defineBishaFace("一户2", bsface2);` — 登记必杀脸 BitmapData
- L424: `$fighter_ctrler.defineBishaFace("一户万解", bsface3);` — 登记必杀脸 BitmapData
- L425: `$fighter_ctrler.defineBishaFace("一户万解1", bsface4);` — 登记必杀脸 BitmapData
- L426: `$fighter_ctrler.defineHurtSound(snd_hurt2);` — 受击语音
- L427: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L428: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L429: `$fighter_ctrler.speed = 12;` — 走速
- L430: `$fighter_ctrler.jumpPower = 17;` — 跳跃初速
- L431: `$fighter_ctrler.heavy = 3;` — 重量
- L432: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame4`（时间轴 F4，L435–677）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F4 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L441 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 2 | 6 | 350 | 0 | false |
| L450 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 5 | -8 | 0 | 1 | false |
| L459 | `tz2` | tz2 | 80 | 5 MAGIC_HEAVY 重法 | 5 | 8 | 0 | 1 | false |
| L468 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L477 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L486 | `k3` | 普攻 3 | 50 | 5 MAGIC_HEAVY 重法 | -2 | 0 | 500 | 0 | false |
| L495 | `k4` | 普攻 4 | 50 | 6 KAN_HEAVY 重砍 | 6 | -6 | 600 | 0 | false |
| L504 | `kj1` | 空中技 1 / 下攻 | 120 | 5 MAGIC_HEAVY 重法 | 8 | -5 | 0 | 1 | true |
| L513 | `kj12` | 空中技 1 中段/收段 | 120 | 5 MAGIC_HEAVY 重法 | 8 | -5 | 0 | 1 | false |
| L522 | `kj21` | 空中技 2 中段/收段 | 30 | 1 KAN 砍 | 1 | -5 | 250 | 0 | false |
| L531 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 2 | -6 | 500 | 0 | false |
| L540 | `zh1` | 招 1 | 40 | 5 MAGIC_HEAVY 重法 | 7 | 0 | 500 | 0 | false |
| L549 | `zh12` | 招 1 分支/击飞 | 40 | 5 MAGIC_HEAVY 重法 | 8 | 0 | 0 | 1 | false |
| L558 | `zh2` | 招 2 | 120 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L567 | `zh3` | 招 3 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L576 | `zh31` | 招 3 分支/击飞 | 10 | 1 KAN 砍 | 12 | 0 | 300 | 0 | false |
| L585 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L594 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L603 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L612 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | -6 | -7 | 0 | 1 | false |
| L621 | `bs` | 必杀 | 280 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L630 | `sbs1` | 上必杀前段/多段 | 50 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | false |
| L639 | `sbs` | 上必杀 | 200 | 5 MAGIC_HEAVY 重法 | 6 | -15 | 0 | 1 | false |
| L648 | `kbs` | 空必杀 | 250 | 5 MAGIC_HEAVY 重法 | 8 | 8 | 0 | 1 | false |
| L657 | `cbs` | 超必杀 | 450 | 5 MAGIC_HEAVY 重法 | 40 | -6 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L437: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L666: `$fighter_ctrler.defineBishaFace("半虚1", bsface4);` — 登记必杀脸 BitmapData
- L667: `$fighter_ctrler.defineBishaFace("半虚2", bsface8);` — 登记必杀脸 BitmapData
- L668: `$fighter_ctrler.defineBishaFace("半虚3", bsface9);` — 登记必杀脸 BitmapData
- L669: `$fighter_ctrler.defineBishaFace("半虚4", bsface10);` — 登记必杀脸 BitmapData
- L670: `$fighter_ctrler.defineHurtSound(snd_hurt2);` — 受击语音
- L671: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L672: `$fighter_ctrler.defineDieSound(snd_hurt2);` — 死亡语音
- L673: `$fighter_ctrler.speed = 12;` — 走速
- L674: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L675: `$fighter_ctrler.heavy = 3;` — 重量
- L676: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame5`（时间轴 F5，L679–911）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F5 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L685 | `tk` | 跳轻/跳踢 | 50 | 1 KAN 砍 | 5 | 5 | 500 | 0 | false |
| L694 | `tz` | 跳重 | 20 | 1 KAN 砍 | 5 | 5 | 500 | 0 | false |
| L703 | `tz1` | tz1 | 70 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L712 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 5 | 0 | 250 | 0 | false |
| L721 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 7 | 0 | 300 | 0 | false |
| L730 | `k3` | 普攻 3 | 30 | 1 KAN 砍 | 5 | 0 | 300 | 0 | false |
| L739 | `k4` | 普攻 4 | 80 | 6 KAN_HEAVY 重砍 | 6 | 0 | 500 | 0 | false |
| L748 | `k5` | 普攻 5 | 60 | 1 KAN 砍 | 7 | -7 | 600 | 0 | false |
| L757 | `kj1` | 空中技 1 / 下攻 | 90 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | true |
| L766 | `kj21` | 空中技 2 中段/收段 | 110 | 5 MAGIC_HEAVY 重法 | 12 | 8 | 0 | 1 | false |
| L775 | `kj2` | 空中技 2 / 上攻 | 50 | 6 KAN_HEAVY 重砍 | 15 | -8 | 700 | 0 | false |
| L784 | `zh1` | 招 1 | 50 | 1 KAN 砍 | 2 | 0 | 500 | 0 | false |
| L793 | `zh12` | 招 1 分支/击飞 | 50 | 6 KAN_HEAVY 重砍 | 4 | 0 | 600 | 0 | false |
| L802 | `zh2` | 招 2 | 100 | 6 KAN_HEAVY 重砍 | 5 | -10 | 800 | 0 | false |
| L811 | `zh3` | 招 3 | 100 | 5 MAGIC_HEAVY 重法 | 12 | -8 | 0 | 1 | false |
| L820 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L829 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 10 | 0 | 1000 | 0 | false |
| L838 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L847 | `sh22` | 抓 2 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 10 | -7 | 1000 | 0 | false |
| L856 | `sh23` | 抓变体 | 120 | 5 MAGIC_HEAVY 重法 | 10 | 8 | 0 | 1 | false |
| L865 | `bs` | 必杀 | 300 | 5 MAGIC_HEAVY 重法 | 25 | 0 | 0 | 1 | false |
| L874 | `sbs` | 上必杀 | 300 | 5 MAGIC_HEAVY 重法 | 20 | -10 | 0 | 1 | true |
| L883 | `cbs` | 超必杀 | 500 | 5 MAGIC_HEAVY 重法 | 30 | -20 | 0 | 1 | false |
| L892 | `cbs1` | 超必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 7 | -7 | 1000 | 0 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L681: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L901: `$fighter_ctrler.defineBishaFace("虚护1", bsface5);` — 登记必杀脸 BitmapData
- L902: `$fighter_ctrler.defineBishaFace("虚护2", bsface6);` — 登记必杀脸 BitmapData
- L903: `$fighter_ctrler.defineBishaFace("虚护3", bsface7);` — 登记必杀脸 BitmapData
- L904: `$fighter_ctrler.defineHurtSound(snd_hurt2);` — 受击语音
- L905: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L906: `$fighter_ctrler.defineDieSound(snd_hurt2);` — 死亡语音
- L907: `$fighter_ctrler.speed = 14;` — 走速
- L908: `$fighter_ctrler.jumpPower = 19;` — 跳跃初速
- L909: `$fighter_ctrler.heavy = 4;` — 重量
- L910: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
