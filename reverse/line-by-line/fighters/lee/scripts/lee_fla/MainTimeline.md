# `lee_fla.MainTimeline` — 李·洛克（F2）/ 李·洛克 杜门（F3） 根时间轴

一句话目的：李·洛克（F2）/ 李·洛克 杜门（F3） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/lee/scripts/lee_fla/MainTimeline.as`（643 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`lee startFrame=1；lee_dm startFrame=2`；文件 `assets/fighter/lee.swf`；comic_type 1 火影。 引擎 `gotoAndStop(startFrame+1)`，1→F2；2→F3。

F2：speed=10 / jump=15 / heavy=3 / 拳防。 必杀脸："小李1",bsface1；"小李2",bsface2。 语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。 F3：speed=12 / jump=15 / heavy=3 / 拳防。 必杀脸："小李1",bsface1。 语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。

F2 动作 MC 误名 `樱_1`；F3 杜门动作 MC `小李杜门_10`。 两形态共用一个 SWF：F2 常时动作 MC 是误名的 `樱_1`（内含 `startWanKai("小李2")` + `doWanKai()` 切到 F3）；F3 杜门动作 MC 是 `小李杜门_10`（`endWanKai()`）。引擎 `gotoAndStop(startFrame+1)`，1→F2 常时；2→F3 杜门。F3 只登记脸 `小李1`，不再登记 `小李2`。

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

### `frame2`（时间轴 F2，L58–317）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 3 | 5 | 600 | 0 | false |
| L73 | `tz` | 跳重 | 70 | 3 DA_HEAVY 重打 | 10 | 10 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L91 | `k2` | 普攻 2 | 20 | 2 DA 打 | 5 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 30 | 2 DA 打 | 6 | 0 | 800 | 0 | false |
| L109 | `k4` | 普攻 4 | 50 | 3 DA_HEAVY 重打 | 5 | -7 | 600 | 0 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 50 | 3 DA_HEAVY 重打 | 10 | 0 | 400 | 0 | false |
| L127 | `kj11` | 空中技 1 段1 | 50 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 80 | 3 DA_HEAVY 重打 | 7 | -8 | 0 | 1 | false |
| L145 | `zh1` | 招 1 | 70 | 5 MAGIC_HEAVY 重法 | 3 | -8 | 800 | 0 | false |
| L154 | `zh11` | 招 1 段1 | 80 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |
| L163 | `zh2` | 招 2 | 100 | 3 DA_HEAVY 重打 | 0 | 10 | 0 | 1 | false |
| L172 | `zh21` | 招 2 段1 | 20 | 2 DA 打 | 8 | 3 | 800 | 0 | false |
| L181 | `zh3` | 招 3 | 80 | 5 MAGIC_HEAVY 重法 | 7 | -7 | 800 | 0 | true |
| L190 | `bs` | 必杀 | 80 | 3 DA_HEAVY 重打 | 3 | -20 | 3000 | 0 | false |
| L199 | `bs1` | 必杀前段/多段 1 | 300 | 5 MAGIC_HEAVY 重法 | 5 | -5 | 0 | 1 | true |
| L208 | `kbs1` | 空必杀段 1 | 20 | 2 DA 打 | 0 | 20 | 500 | 0 | false |
| L217 | `kbs` | 空必杀 | 200 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L226 | `cbs` | 超必杀 | 150 | 3 DA_HEAVY 重打 | 15 | 10 | 0 | 1 | true |
| L235 | `cbs1` | 超必杀前段/多段 1 | 40 | 3 DA_HEAVY 重打 | 10 | 0 | 1000 | 0 | false |
| L244 | `cbs2` | 超必杀前段/多段 2 | 40 | 3 DA_HEAVY 重打 | 10 | -10 | 1000 | 0 | false |
| L253 | `cbs3` | 超必杀前段/多段 3 | 40 | 3 DA_HEAVY 重打 | -10 | 0 | 1000 | 0 | false |
| L262 | `cbs4` | 超必杀前段/多段 4 | 40 | 3 DA_HEAVY 重打 | -10 | -10 | 1000 | 0 | true |
| L271 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L289 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L298 | `sh22` | 抓 2 伤害段 | 160 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L307: `$fighter_ctrler.defineBishaFace("小李1",bsface1);` — 登记必杀脸 BitmapData
- L308: `$fighter_ctrler.defineBishaFace("小李2",bsface2);` — 登记必杀脸 BitmapData
- L309: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L310: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L311: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L312: `$fighter_ctrler.speed = 10;` — 走速
- L313: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L314: `$fighter_ctrler.heavy = 3;` — 重量
- L315: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L316: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L319–640）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L325 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 3 | 8 | 300 | 0 | false |
| L334 | `tz` | 跳重 | 80 | 3 DA_HEAVY 重打 | 10 | 10 | 400 | 1 | false |
| L343 | `k1` | 普攻 1 | 20 | 2 DA 打 | 1 | 0 | 300 | 0 | false |
| L352 | `k2` | 普攻 2 | 20 | 2 DA 打 | 2 | 0 | 200 | 0 | false |
| L361 | `k3` | 普攻 3 | 30 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L370 | `k4` | 普攻 4 | 20 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L379 | `k5` | 普攻 5 | 40 | 3 DA_HEAVY 重打 | 5 | 0 | 400 | 0 | false |
| L388 | `k6` | 普攻 6 | 50 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L397 | `kj1` | 空中技 1 / 下攻 | 40 | 3 DA_HEAVY 重打 | 3 | 0 | 500 | 0 | false |
| L406 | `kj12` | 空中技 1 段2 | 40 | 3 DA_HEAVY 重打 | 3 | 0 | 500 | 0 | false |
| L415 | `kj13` | 空中技 1 段3 | 40 | 5 MAGIC_HEAVY 重法 | 5 | -7 | 600 | 0 | false |
| L424 | `kj2` | 空中技 2 / 上攻 | 30 | 2 DA 打 | 0 | -10 | 500 | 0 | false |
| L433 | `kj21` | 空中技 2 段1 | 80 | 3 DA_HEAVY 重打 | 5 | -7 | 500 | 0 | false |
| L442 | `zh1` | 招 1 | 80 | 5 MAGIC_HEAVY 重法 | 5 | 0 | 500 | 0 | false |
| L451 | `zh2` | 招 2 | 140 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | true |
| L460 | `zh3` | 招 3 | 110 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L469 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L478 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L487 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L496 | `sh22` | 抓 2 伤害段 | 160 | 0 ? | -10 | -5 | 0 | 1 | false |
| L505 | `bs1` | 必杀前段/多段 1 | 50 | 3 DA_HEAVY 重打 | 0 | -10 | 1000 | 0 | false |
| L514 | `bs2` | 必杀前段/多段 2 | 10 | 2 DA 打 | 0 | 0 | 1000 | 0 | false |
| L523 | `bs3` | 必杀前段/多段 3 | 0 | 0 ? | 0 | 0 | 1000 | 0 | false |
| L532 | `bs4` | 必杀前段/多段 4 | 0 | 0 ? | 0 | -10 | 1000 | 0 | false |
| L541 | `bs` | 必杀 | 140 | 5 MAGIC_HEAVY 重法 | 0 | 20 | 1000 | 1 | false |
| L550 | `sbs1` | 上必杀前段 1 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 1000 | 0 | false |
| L559 | `sbs` | 上必杀 | 150 | 7 FIRE 火 | 3 | -8 | 1000 | 1 | false |
| L568 | `kbs1` | 空必杀段 1 | 10 | 4 MAGIC 忍术/鬼道 | 5 | 2 | 1000 | 0 | false |
| L577 | `kbs2` | 空必杀段 2 | 10 | 4 MAGIC 忍术/鬼道 | 3 | 0 | 1000 | 0 | false |
| L586 | `kbs` | 空必杀 | 150 | 7 FIRE 火 | 10 | -8 | 0 | 1 | false |
| L595 | `cbs1` | 超必杀前段/多段 1 | 50 | 5 MAGIC_HEAVY 重法 | 3 | 0 | 1000 | 0 | false |
| L604 | `cbs2` | 超必杀前段/多段 2 | 20 | 2 DA 打 | 4 | 0 | 1000 | 0 | false |
| L613 | `cbs3` | 超必杀前段/多段 3 | 20 | 2 DA 打 | 5 | 0 | 1000 | 0 | false |
| L622 | `cbs` | 超必杀 | 50 | 7 FIRE 火 | 20 | 0 | 1000 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L321: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L631: `$fighter_ctrler.defineBishaFace("小李1",bsface1);` — 登记必杀脸 BitmapData
- L632: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L633: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L634: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L635: `$fighter_ctrler.speed = 12;` — 走速
- L636: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L637: `$fighter_ctrler.heavy = 3;` — 重量
- L638: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L639: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
