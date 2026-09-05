# `kenpachi_fla.MainTimeline` — 更木·剑八 根时间轴

一句话目的：更木·剑八 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/kenpachi/scripts/kenpachi_fla/MainTimeline.as`（329 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`kenpachi startFrame=1`；文件 `assets/fighter/kenpachi.swf`；comic_type 0 死神。 引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

F2：speed=10 / jump=16 / heavy=5 / 斩防。 必杀脸："剑八1",bsface1；"剑八2",bsface2。 语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。

动作 MC 类名 `剑八全动作_1`。

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

### `frame2`（时间轴 F2，L58–326）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 70 | 6 KAN_HEAVY 重砍 | 0 | 15 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 130 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L82 | `tz1` | 跳重 段1 | 20 | 4 MAGIC 忍术/鬼道 | 0 | 30 | 300 | 0 | false |
| L91 | `k1` | 普攻 1 | 40 | 1 KAN 砍 | 3 | 0 | 200 | 0 | false |
| L100 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 4 | 0 | 300 | 0 | false |
| L109 | `k3` | 普攻 3 | 70 | 6 KAN_HEAVY 重砍 | 4 | -6 | 500 | 0 | false |
| L118 | `kj11` | 空中技 1 段1 | 40 | 1 KAN 砍 | 6 | 0 | 400 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 60 | 7 FIRE 火 | 10 | 0 | 0 | 1 | true |
| L136 | `kj2` | 空中技 2 / 上攻 | 70 | 6 KAN_HEAVY 重砍 | 1 | 0 | 500 | 0 | false |
| L145 | `kj21` | 空中技 2 段1 | 70 | 6 KAN_HEAVY 重砍 | 5 | -8 | 500 | 0 | false |
| L154 | `zh1` | 招 1 | 120 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 500 | 1 | false |
| L163 | `zh2` | 招 2 | 200 | 9 ELECTRIC 雷 | 10 | -5 | 500 | 1 | true |
| L172 | `zh3` | 招 3 | 130 | 9 ELECTRIC 雷 | 12 | -6 | 0 | 1 | false |
| L181 | `bs1` | 必杀前段/多段 1 | 100 | 6 KAN_HEAVY 重砍 | 20 | 0 | 1000 | 0 | false |
| L190 | `bs` | 必杀 | 100 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L199 | `sbs1` | 上必杀前段 1 | 20 | 1 KAN 砍 | 1 | -1 | 300 | 0 | false |
| L208 | `sbs` | 上必杀 | 40 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L217 | `cbs1` | 超必杀前段/多段 1 | 40 | 6 KAN_HEAVY 重砍 | 6 | 0 | 1000 | 0 | false |
| L226 | `cbs2` | 超必杀前段/多段 2 | 20 | 1 KAN 砍 | 4 | 0 | 2000 | 0 | false |
| L235 | `cbs3` | 超必杀前段/多段 3 | 40 | 6 KAN_HEAVY 重砍 | 2 | -4 | 1000 | 0 | false |
| L244 | `cbs4` | 超必杀前段/多段 4 | 10 | 1 KAN 砍 | 1 | -0.2 | 1000 | 0 | true |
| L253 | `cbs5` | 超必杀前段/多段 5 | 20 | 2 DA 打 | 3 | -3 | 1000 | 0 | false |
| L262 | `cbs` | 超必杀 | 60 | 7 FIRE 火 | 15 | -15 | 0 | 1 | false |
| L271 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L289 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L298 | `sh22` | 抓 2 伤害段 | 30 | 1 KAN 砍 | 0 | 0 | 1000 | 0 | false |
| L307 | `sh23` | 抓 2 伤害段 3 | 100 | 5 MAGIC_HEAVY 重法 | 15 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L316: `$fighter_ctrler.defineBishaFace("剑八1",bsface1);` — 登记必杀脸 BitmapData
- L317: `$fighter_ctrler.defineBishaFace("剑八2",bsface2);` — 登记必杀脸 BitmapData
- L318: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L319: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L320: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L321: `$fighter_ctrler.speed = 10;` — 走速
- L322: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L323: `$fighter_ctrler.heavy = 5;` — 重量
- L324: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L325: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
