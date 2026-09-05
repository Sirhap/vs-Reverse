# `jiraiya_fla.MainTimeline` — 自来也 根时间轴

一句话目的：自来也 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/jiraiya/scripts/jiraiya_fla/MainTimeline.as`（347 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`jiraiya startFrame=1`；文件 `assets/fighter/jiraiya.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

数值：speed=10 / jump=15 / heavy=4 / 拳防。必杀脸键名 `自来也1`←`bsface1`、`自来也2`←`bsface2`。语音：`$fighter_ctrler.defineHurtSound(snd_hurt1);`；`$fighter_ctrler.defineHurtFlySound(snd_hurt1);`；`$fighter_ctrler.defineDieSound(snd_hurt1);`。动作 MC 类名 `自来也全动作_1`。`defenseType` 拳防。

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
- L34: `addFrameScript(0,frame1,1,frame2);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- L55: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–344）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 4 | 10 | 700 | 0 | false |
| L73 | `tk1` | 跳轻 1 | 30 | 2 DA 打 | -1 | 3 | 300 | 0 | false |
| L82 | `tz` | 跳重 | 150 | 3 DA_HEAVY 重打 | 8 | -5 | 400 | 1 | false |
| L91 | `k1` | 普攻 1 | 20 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L100 | `k2` | 普攻 2 | 30 | 2 DA 打 | 1 | 0 | 400 | 0 | false |
| L109 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 4 | 0 | 600 | 0 | false |
| L118 | `k4` | 普攻 4 | 50 | 5 MAGIC_HEAVY 重法 | 3 | -7 | 700 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 10 | 2 DA 打 | 8 | 0 | 400 | 0 | false |
| L136 | `kj12` | 空中技 1 收段 | 100 | 3 DA_HEAVY 重打 | 5 | -5 | 500 | 0 | false |
| L145 | `kj22` | 空中技 2 收段 | 10 | 1 KAN 砍 | 5 | 0 | 400 | 0 | false |
| L154 | `kj2` | 空中技 2 / 上攻 | 100 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L163 | `kj21` | 空中技 2 中段 | 80 | 6 KAN_HEAVY 重砍 | 5 | -8 | 500 | 0 | false |
| L172 | `zh1` | 招 1 | 150 | 7 FIRE 火 | 10 | 0 | 0 | 1 | false |
| L181 | `zh2` | 招 2 | 30 | 4 MAGIC 忍术/鬼道 | 2 | 0 | 500 | 0 | true |
| L190 | `zh3` | 招 3 | 50 | 2 DA 打 | 1 | -3 | 500 | 0 | false |
| L199 | `zh31` | 招 3 段1 | 50 | 2 DA 打 | 0 | -5 | 500 | 0 | false |
| L208 | `zh32` | 招 3 段2 | 100 | 3 DA_HEAVY 重打 | 0 | 20 | 0 | 1 | false |
| L217 | `bs1` | 必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 1000 | 0 | false |
| L226 | `bs2` | 必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 0 | 1 | false |
| L235 | `bs` | 必杀 | 100 | 7 FIRE 火 | 5 | 0 | 1000 | 0 | false |
| L244 | `sbs` | 上必杀 | 30 | 4 MAGIC 忍术/鬼道 | 1 | 0 | 200 | 0 | false |
| L253 | `sbs2` | 上必杀前段/多段 | 80 | 5 MAGIC_HEAVY 重法 | 15 | -2 | 0 | 1 | false |
| L262 | `cbs1` | 超必杀前段/多段 | 100 | 7 FIRE 火 | 5 | -5 | 0 | 1 | true |
| L271 | `cbs` | 超必杀 | 30 | 4 MAGIC 忍术/鬼道 | 3 | -0.5 | 1000 | 0 | false |
| L280 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L289 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L298 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L307 | `sh22` | 抓 2 伤害段 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 400 | 0 | false |
| L316 | `sh24` | 抓 24 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 400 | 0 | false |
| L325 | `sh23` | 抓 23 | 30 | 4 MAGIC 忍术/鬼道 | 15 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L334: `$fighter_ctrler.defineBishaFace("自来也1",bsface1);` — 登记必杀脸 BitmapData
- L335: `$fighter_ctrler.defineBishaFace("自来也2",bsface2);` — 登记必杀脸 BitmapData
- L336: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L337: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L338: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L339: `$fighter_ctrler.speed = 10;` — 走速
- L340: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L341: `$fighter_ctrler.heavy = 4;` — 重量
- L342: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L343: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
