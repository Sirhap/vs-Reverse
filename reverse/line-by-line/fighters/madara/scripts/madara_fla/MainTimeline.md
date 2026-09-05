# `madara_fla.MainTimeline` — 宇智波·斑 根时间轴

一句话目的：宇智波·斑 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/madara/scripts/madara_fla/MainTimeline.as`（356 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`madara startFrame=1`；文件 `assets/fighter/madara.swf`；comic_type 1 火影。 引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

F2：speed=14 / jump=16 / heavy=4 / 拳防。 必杀脸："斑1",bsface1；"斑2",bsface2。 语音：`defineHurtSound(snd_hurt1,snd_hurt2)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_die)`。

动作 MC 类名误作 `鸣人全动作_1`。 动作类名是鸣人 FLA 模板残留。AI 面 **有** `kbsmian`（本批少见）。

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

### `frame2`（时间轴 F2，L58–353）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 50 | 6 KAN_HEAVY 重砍 | 5 | 5 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 7 FIRE 火 | 5 | 5 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 2 DA 打 | 5 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 40 | 2 DA 打 | 2 | -2 | 400 | 0 | false |
| L109 | `k4` | 普攻 4 | 60 | 3 DA_HEAVY 重打 | 6 | -8 | 500 | 0 | false |
| L118 | `k5` | 普攻 5 | 80 | 5 MAGIC_HEAVY 重法 | 5 | 10 | 0 | 1 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 80 | 6 KAN_HEAVY 重砍 | 1 | 0 | 500 | 0 | false |
| L136 | `kj12` | 空中技 1 段2 | 80 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L145 | `kj13` | 空中技 1 段3 | 20 | 4 MAGIC 忍术/鬼道 | 7 | 0 | 300 | 0 | false |
| L154 | `kj2` | 空中技 2 / 上攻 | 50 | 3 DA_HEAVY 重打 | -7 | -7 | 500 | 0 | false |
| L163 | `kj22` | 空中技 2 段2 | 70 | 3 DA_HEAVY 重打 | 8 | 8 | 1000 | 0 | false |
| L172 | `zh12` | 招 1 段2 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 800 | 0 | false |
| L181 | `zh1` | 招 1 | 60 | 7 FIRE 火 | 8 | 0 | 300 | 1 | false |
| L190 | `zh2` | 招 2 | 80 | 5 MAGIC_HEAVY 重法 | 0 | 7 | 500 | 0 | true |
| L199 | `zh22` | 招 2 段2 | 50 | 7 FIRE 火 | 5 | -5 | 0 | 1 | false |
| L208 | `zh3` | 招 3 | 150 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L217 | `sh1` | 抓 1（hitType 11） | 10 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L226 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L235 | `sh2` | 抓 2（hitType 11） | 10 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | -10 | -5 | 1000 | 1 | false |
| L253 | `bs1` | 必杀前段/多段 1 | 20 | 4 MAGIC 忍术/鬼道 | 3 | 0 | 1000 | 0 | false |
| L262 | `bs` | 必杀 | 20 | 7 FIRE 火 | 5 | -5 | 0 | 1 | true |
| L271 | `sbs` | 上必杀 | 100 | 6 KAN_HEAVY 重砍 | 5 | -5 | 1000 | 0 | false |
| L280 | `sbs1` | 上必杀前段 1 | 80 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L289 | `sbs2` | 上必杀前段 2 | 80 | 6 KAN_HEAVY 重砍 | 3 | -10 | 1000 | 0 | false |
| L298 | `sbs3` | 上必杀前段 3 | 100 | 5 MAGIC_HEAVY 重法 | 5 | 20 | 0 | 1 | false |
| L307 | `cbs` | 超必杀 | 300 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 1000 | 0 | true |
| L316 | `cbs2` | 超必杀前段/多段 2 | 100 | 7 FIRE 火 | 5 | -5 | 1000 | 0 | false |
| L325 | `cbs3` | 超必杀前段/多段 3 | 100 | 7 FIRE 火 | 10 | -10 | 0 | 1 | false |
| L334 | `kbs` | 空必杀 | 300 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L343: `$fighter_ctrler.defineBishaFace("斑1",bsface1);` — 登记必杀脸 BitmapData
- L344: `$fighter_ctrler.defineBishaFace("斑2",bsface2);` — 登记必杀脸 BitmapData
- L345: `$fighter_ctrler.defineHurtSound(snd_hurt1,snd_hurt2);` — 受击语音
- L346: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L347: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L348: `$fighter_ctrler.speed = 14;` — 走速
- L349: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L350: `$fighter_ctrler.heavy = 4;` — 重量
- L351: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L352: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
