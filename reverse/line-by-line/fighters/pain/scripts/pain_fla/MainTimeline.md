# `pain_fla.MainTimeline` — 佩恩 根时间轴

一句话目的：佩恩 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/pain/scripts/pain_fla/MainTimeline.as`（321 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`pain` startFrame=1（佩恩）；文件 `assets/fighter/pain.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=10 / jump=15 / heavy=3 / 拳防。必杀脸：`佩恩1`←`bsface1`、`佩恩2`←`bsface2`、`佩恩3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。

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
- L34: `addFrameScript(0, frame1, 1, frame2);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–318）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tz` | 跳重 | 90 | 5 MAGIC_HEAVY 重法 | 7 | 7 | 0 | 1 | false |
| L73 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 3 | -2 | 400 | 0 | false |
| L82 | `tk2` | 跳轻 段2 | 30 | 6 KAN_HEAVY 重砍 | 3 | 0 | 400 | 0 | false |
| L91 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 4 | 0 | 300 | 0 | false |
| L100 | `k2` | 普攻 2 | 30 | 2 DA 打 | 4 | 0 | 400 | 0 | false |
| L109 | `k3` | 普攻 3 | 40 | 2 DA 打 | 4 | -4 | 500 | 0 | false |
| L118 | `k4` | 普攻 4 | 60 | 5 MAGIC_HEAVY 重法 | 6 | 0 | 800 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 90 | 6 KAN_HEAVY 重砍 | 6 | 0 | 600 | 0 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 70 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 600 | 0 | true |
| L145 | `zh1` | 招 1 | 30 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L154 | `zh12` | 招 12 | 30 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L163 | `zh13` | 招 13 | 40 | 7 FIRE 火 | 5 | 0 | 0 | 1 | false |
| L172 | `zh2` | 招 2 | 100 | 3 DA_HEAVY 重打 | 5 | 0 | 600 | 0 | false |
| L181 | `zh3` | 招 3 | 90 | 3 DA_HEAVY 重打 | 10 | -10 | 0 | 1 | false |
| L190 | `bs` | 必杀 | 260 | 5 MAGIC_HEAVY 重法 | 18 | 0 | 0 | 1 | false |
| L199 | `sbs` | 上必杀 | 50 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L208 | `sbs1` | 上必杀前段/多段 | 30 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | false |
| L217 | `sbs2` | 上必杀前段/多段 | 30 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L226 | `sbs3` | 上必杀前段/多段 | 50 | 5 MAGIC_HEAVY 重法 | 4 | 0 | 1000 | 0 | false |
| L235 | `sbs4` | 上必杀前段/多段 | 40 | 7 FIRE 火 | 5 | 0 | 1000 | 0 | false |
| L244 | `sbs5` | 上必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L253 | `cbs1` | 超必杀前段/多段 | 20 | 2 DA 打 | 0 | 0 | 1000 | 0 | true |
| L262 | `cbs` | 超必杀 | 250 | 7 FIRE 火 | 20 | 10 | 0 | 1 | false |
| L271 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L289 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L298 | `sh22` | 抓 2 伤害段 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L307: `$fighter_ctrler.defineBishaFace("佩恩1", bsface1);` — 登记必杀脸 BitmapData
- L308: `$fighter_ctrler.defineBishaFace("佩恩2", bsface2);` — 登记必杀脸 BitmapData
- L309: `$fighter_ctrler.defineBishaFace("佩恩3", bsface3);` — 登记必杀脸 BitmapData
- L310: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L311: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L312: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L313: `$fighter_ctrler.speed = 10;` — 走速
- L314: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L315: `$fighter_ctrler.heavy = 3;` — 重量
- L316: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L317: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
