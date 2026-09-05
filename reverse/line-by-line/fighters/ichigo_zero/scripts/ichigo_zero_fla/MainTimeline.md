# `ichigo_zero_fla.MainTimeline` — 黑崎·一护 零段（F2）/ 内虚（F3）/ 内虚 卍解（F4） 根时间轴

一句话目的：黑崎·一护 零段（F2）/ 内虚（F3）/ 内虚 卍解（F4） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/ichigo_zero/scripts/ichigo_zero_fla/MainTimeline.as`（748 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler，若源里写了）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`ichigo_zero sf=1；ichigo_neixu sf=2；ichigo_neixu_wanjie sf=3`；文件 `assets/fighter/ichigo_zero.swf`；comic_type 0 死神。引擎 gotoAndStop(startFrame+1)：1→F2 零段；2→F3 内虚；3→F4 内虚卍解。

根上有 `wanKai` 布尔（F1 置 false；零段动作 MC 万解前改 true）。F2 用 `defineAction` 别名；脸 `一护1`/`一护2`；hurt 用 `snd_hurt2,snd_hurt1`。F3/F4 白一护：`defineHurtSound(null)`，击飞/死亡 `snd_hurt_ogihci_1`（ichigo 倒写）。动作 MC：F2 `一护全动作_1`、F3 `白一护全动作_11`、F4 `一护万解全动作_29`。白一护开场按 `parent.wanKai` 播 `wksound` 或 `kcsound`。三份 AI 面都缺 `kbsmian`。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用
| L29 | `defineAction` | `Function` | `setFighterCtrler` 写成 ctrler.defineAction
| L31 | `wanKai` | `Boolean` | 零段是否已点万解；白一护开场读它选语音

### 函数

#### `MainTimeline()`（L33–37）

- L35: `super();`
- L36: `addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 3, this.frame4);`

#### `setFighterCtrler(param1:*)`（L39–43）

- L41: `$fighter_ctrler = param1;`
- L42: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L45–48）

- L47: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L50–53）

- L52: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L55–59）

- L57: `stop();` — 停时间轴
- L58: `wanKai = false;` — 记下是否走万解开场

### `frame2`（时间轴 F2，L61–230）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L67 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 2 | 5 | 400 | 0 | false |
| L76 | `k1` | 普攻 1 | 40 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L85 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L94 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 10 | 0 | 600 | 0 | false |
| L103 | `kj1` | 空中技 1 / 下攻 | 80 | 6 KAN_HEAVY 重砍 | 5 | 0 | 500 | 0 | false |
| L112 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 5 | -7 | 500 | 0 | true |
| L121 | `zh1` | 招 1 | 80 | 5 MAGIC_HEAVY 重法 | 3 | 0 | 0 | 1 | false |
| L130 | `zh2` | 招 2 | 80 | 5 MAGIC_HEAVY 重法 | 8 | -6 | 500 | 0 | false |
| L139 | `zh3` | 招 3 | 80 | 5 MAGIC_HEAVY 重法 | 3 | -3 | 0 | 1 | false |
| L148 | `bs1` | 必杀前段/多段 | 80 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 1000 | 0 | false |
| L157 | `bs2` | 必杀前段/多段 | 80 | 6 KAN_HEAVY 重砍 | 5 | -5 | 1000 | 0 | false |
| L166 | `bs` | 必杀 | 100 | 5 MAGIC_HEAVY 重法 | 15 | -5 | 0 | 1 | false |
| L175 | `sbs` | 上必杀 | 220 | 5 MAGIC_HEAVY 重法 | 10 | -8 | 0 | 1 | false |
| L184 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L193 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L202 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L211 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L63: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L220: `$fighter_ctrler.defineBishaFace("一护1", bsface1);` — 登记必杀脸 BitmapData
- L221: `$fighter_ctrler.defineBishaFace("一护2", bsface2);` — 登记必杀脸 BitmapData
- L222: `$fighter_ctrler.defineHurtSound(snd_hurt2, snd_hurt1);` — 受击语音
- L223: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L224: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L225: `$fighter_ctrler.speed = 7;` — 走速
- L226: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L227: `$fighter_ctrler.heavy = 3;` — 重量
- L228: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L229: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L232–474）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L238 | `tk` | 跳轻/跳踢 | 50 | 4 MAGIC 忍术/鬼道 | 3 | 5 | 500 | 0 | false |
| L247 | `tz` | 跳重 | 90 | 6 KAN_HEAVY 重砍 | 5 | 7 | 0 | 1 | false |
| L256 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L265 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L274 | `k3` | 普攻 3 | 80 | 6 KAN_HEAVY 重砍 | 5 | -7 | 600 | 0 | false |
| L283 | `kj1` | 空中技 1 / 下攻 | 30 | 6 KAN_HEAVY 重砍 | 4 | 0 | 500 | 0 | false |
| L292 | `kj12` | 空中技 1 中段/收段 | 30 | 1 KAN 砍 | -12 | 0 | 400 | 0 | false |
| L301 | `kj2` | 空中技 2 / 上攻 | 20 | 1 KAN 砍 | 0 | 0 | 200 | 0 | false |
| L310 | `kj22` | 空中技 2 中段/收段 | 20 | 1 KAN 砍 | 0 | -0.1 | 200 | 0 | false |
| L319 | `kj21` | 空中技 2 中段/收段 | 30 | 7 FIRE 火 | 3 | -10 | 0 | 1 | false |
| L328 | `zh1` | 招 1 | 40 | 6 KAN_HEAVY 重砍 | 3 | 0 | 400 | 0 | false |
| L337 | `zh12` | 招 1 分支/击飞 | 80 | 5 MAGIC_HEAVY 重法 | 7 | -3 | 0 | 1 | false |
| L346 | `zh13` | 招 1 分支/击飞 | 100 | 5 MAGIC_HEAVY 重法 | 6 | 0 | 0 | 1 | true |
| L355 | `zh2` | 招 2 | 20 | 4 MAGIC 忍术/鬼道 | 0 | -4 | 500 | 0 | false |
| L364 | `zh21` | 招 2 分支/击飞 | 50 | 5 MAGIC_HEAVY 重法 | 4 | -3 | 500 | 0 | false |
| L373 | `zh3` | 招 3 | 100 | 5 MAGIC_HEAVY 重法 | 6 | -6 | 0 | 1 | false |
| L382 | `bs` | 必杀 | 270 | 5 MAGIC_HEAVY 重法 | 15 | -5 | 0 | 1 | false |
| L391 | `sbs` | 上必杀 | 270 | 5 MAGIC_HEAVY 重法 | 2 | -10 | 0 | 1 | false |
| L400 | `cbs1` | 超必杀前段/多段 | 40 | 4 MAGIC 忍术/鬼道 | 1 | 0 | 500 | 0 | false |
| L409 | `cbs2` | 超必杀前段/多段 | 40 | 4 MAGIC 忍术/鬼道 | 1 | 0 | 500 | 0 | false |
| L418 | `cbs` | 超必杀 | 100 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | true |
| L427 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L436 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 4 | -3 | 1000 | 0 | false |
| L445 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L454 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 4 | -6 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L234: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L463: `$fighter_ctrler.defineBishaFace("白一护1", bsface3);` — 登记必杀脸 BitmapData
- L464: `$fighter_ctrler.defineBishaFace("白一护2", bsface4);` — 登记必杀脸 BitmapData
- L465: `$fighter_ctrler.defineBishaFace("白一护3", bsface6);` — 登记必杀脸 BitmapData
- L466: `$fighter_ctrler.defineHurtSound(null);` — 受击语音
- L467: `$fighter_ctrler.defineHurtFlySound(snd_hurt_ogihci_1);` — 击飞语音
- L468: `$fighter_ctrler.defineDieSound(snd_hurt_ogihci_1);` — 死亡语音
- L469: `$fighter_ctrler.speed = 9;` — 走速
- L470: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L471: `$fighter_ctrler.heavy = 3;` — 重量
- L472: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L473: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame4`（时间轴 F4，L476–745）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F4 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L482 | `tk` | 跳轻/跳踢 | 50 | 1 KAN 砍 | 7 | 6 | 400 | 0 | false |
| L491 | `tz` | 跳重 | 150 | 6 KAN_HEAVY 重砍 | 0 | 0 | 0 | 1 | false |
| L500 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L509 | `k2` | 普攻 2 | 50 | 1 KAN 砍 | 5 | -2 | 500 | 0 | false |
| L518 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 5 | 4 | 600 | 0 | false |
| L527 | `k4` | 普攻 4 | 60 | 6 KAN_HEAVY 重砍 | 8 | -8 | 600 | 0 | false |
| L536 | `kj1` | 空中技 1 / 下攻 | 150 | 6 KAN_HEAVY 重砍 | 15 | 0 | 0 | 1 | false |
| L545 | `kj12` | 空中技 1 中段/收段 | 150 | 6 KAN_HEAVY 重砍 | 3 | -5 | 800 | 0 | false |
| L554 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 8 | -8 | 500 | 0 | false |
| L563 | `kj21` | 空中技 2 中段/收段 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L572 | `zh1` | 招 1 | 150 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L581 | `zh2` | 招 2 | 200 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | true |
| L590 | `zh21` | 招 2 分支/击飞 | 10 | 2 DA 打 | 0 | 0 | 1000 | 0 | false |
| L599 | `zh3` | 招 3 | 50 | 1 KAN 砍 | 6 | -6 | 500 | 0 | false |
| L608 | `zh31` | 招 3 分支/击飞 | 100 | 5 MAGIC_HEAVY 重法 | -10 | 10 | 0 | 1 | true |
| L617 | `bs` | 必杀 | 320 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | false |
| L626 | `bs1` | 必杀前段/多段 | 20 | 1 KAN 砍 | 0.05 | -0.05 | 800 | 0 | false |
| L635 | `bs2` | 必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 15 | 0 | 0 | 1 | false |
| L644 | `sbs` | 上必杀 | 230 | 5 MAGIC_HEAVY 重法 | 20 | 10 | 0 | 1 | false |
| L653 | `sbs1` | 上必杀前段/多段 | 50 | 1 KAN 砍 | 10 | -5 | 1000 | 0 | false |
| L662 | `cbs1` | 超必杀前段/多段 | 80 | 6 KAN_HEAVY 重砍 | 2 | 0 | 2000 | 0 | false |
| L671 | `cbs2` | 超必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 10 | 0 | 2000 | 0 | false |
| L680 | `cbs3` | 超必杀前段/多段 | 50 | 2 DA 打 | 2 | 0 | 2000 | 0 | false |
| L689 | `cbs` | 超必杀 | 400 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | false |
| L698 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L707 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L716 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L725 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L478: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L734: `$fighter_ctrler.defineBishaFace("白一护1", bsface5);` — 登记必杀脸 BitmapData
- L735: `$fighter_ctrler.defineBishaFace("白一护2", bsface6);` — 登记必杀脸 BitmapData
- L736: `$fighter_ctrler.defineBishaFace("白一护3", bsface7);` — 登记必杀脸 BitmapData
- L737: `$fighter_ctrler.defineHurtSound(null);` — 受击语音
- L738: `$fighter_ctrler.defineHurtFlySound(snd_hurt_ogihci_1);` — 击飞语音
- L739: `$fighter_ctrler.defineDieSound(snd_hurt_ogihci_1);` — 死亡语音
- L740: `$fighter_ctrler.speed = 11;` — 走速
- L741: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L742: `$fighter_ctrler.heavy = 3;` — 重量
- L743: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L744: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
