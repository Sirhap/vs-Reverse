# `itachi_fla.MainTimeline` — 宇智波·鼬 根时间轴

一句话目的：宇智波·鼬 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/itachi/scripts/itachi_fla/MainTimeline.as`（329 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`itachi startFrame=1`；文件 `assets/fighter/itachi.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

数值：speed=10 / jump=16 / heavy=4 / 拳防。必杀脸键名 `鼬1`←`bsface1`、`鼬2`←`bsface2`。语音：`$fighter_ctrler.defineHurtSound(snd_hurt1,snd_hurt2);`；`$fighter_ctrler.defineHurtFlySound(snd_hurt2);`；`$fighter_ctrler.defineDieSound(snd_die);`。动作 MC 类名 `卡卡西_1`。`defenseType` 拳防。

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
| L64 | `tz` | 跳重 | 120 | 6 KAN_HEAVY 重砍 | 5 | 0 | 0 | 1 | false |
| L73 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L82 | `tk2` | 跳轻 2 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L91 | `tk3` | 跳轻 3 | 30 | 1 KAN 砍 | 3 | 3 | 500 | 0 | false |
| L100 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 1 | 0 | 300 | 0 | false |
| L109 | `k2` | 普攻 2 | 40 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L118 | `k3` | 普攻 3 | 80 | 3 DA_HEAVY 重打 | 3 | 0 | 400 | 0 | false |
| L127 | `k4` | 普攻 4 | 100 | 6 KAN_HEAVY 重砍 | -1 | -7 | 500 | 0 | false |
| L136 | `kj1` | 空中技 1 / 下攻 | 130 | 7 FIRE 火 | 10 | -2 | 0 | 1 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 30 | 1 KAN 砍 | 2 | -5 | 300 | 0 | false |
| L154 | `kj21` | 空中技 2 中段 | 70 | 6 KAN_HEAVY 重砍 | 5 | -4 | 0 | 1 | false |
| L163 | `zh1` | 招 1 | 70 | 6 KAN_HEAVY 重砍 | 7 | 0 | 0 | 1 | false |
| L172 | `zh2` | 招 2 | 30 | 1 KAN 砍 | 3 | -5 | 500 | 0 | false |
| L181 | `zh21` | 招 2 段1 | 50 | 3 DA_HEAVY 重打 | 2 | -5 | 500 | 0 | false |
| L190 | `kj2` | 空中技 2 / 上攻 | 120 | 6 KAN_HEAVY 重砍 | 0 | 10 | 0 | 1 | true |
| L199 | `zh3` | 招 3 | 60 | 6 KAN_HEAVY 重砍 | 3 | -3 | 500 | 0 | false |
| L208 | `zh32` | 招 3 段2 | 60 | 7 FIRE 火 | 10 | 10 | 500 | 1 | false |
| L217 | `bs1` | 必杀前段/多段 | 30 | 2 DA 打 | 0 | 0 | 500 | 0 | false |
| L226 | `bs` | 必杀 | 300 | 7 FIRE 火 | 10 | -10 | 0 | 1 | false |
| L235 | `sbs` | 上必杀 | 250 | 7 FIRE 火 | 20 | -10 | 0 | 1 | false |
| L244 | `cbs1` | 超必杀前段/多段 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `cbs2` | 超必杀前段/多段 | 60 | 1 KAN 砍 | 0 | 0 | 1000 | 0 | false |
| L262 | `cbs3` | 超必杀前段/多段 | 10 | 1 KAN 砍 | 0 | 0 | 1000 | 0 | false |
| L271 | `cbs` | 超必杀 | 200 | 3 DA_HEAVY 重打 | 0 | 10 | 0 | 1 | false |
| L280 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L289 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L298 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L307 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | -10 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L316: `$fighter_ctrler.defineBishaFace("鼬1",bsface1);` — 登记必杀脸 BitmapData
- L317: `$fighter_ctrler.defineBishaFace("鼬2",bsface2);` — 登记必杀脸 BitmapData
- L318: `$fighter_ctrler.defineHurtSound(snd_hurt1,snd_hurt2);` — 受击语音
- L319: `$fighter_ctrler.defineHurtFlySound(snd_hurt2);` — 击飞语音
- L320: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L321: `$fighter_ctrler.speed = 10;` — 走速
- L322: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L323: `$fighter_ctrler.heavy = 4;` — 重量
- L324: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L325: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
