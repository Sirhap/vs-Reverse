# `renji_fla.MainTimeline` — 阿散井·恋次 根时间轴

一句话目的：阿散井·恋次 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/renji/scripts/renji_fla/MainTimeline.as`（267 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`renji` startFrame=1（阿散井·恋次）；文件 `assets/fighter/renji.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=8 / jump=15 / heavy=3 / 斩防。必杀脸：`bsface1`←`bsface1`、`bsface2`←`bsface2`、`bsface3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。
动作 MC 类名误作 `一护全动作_1`（一护 FLA 模板残留）。

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

### `frame2`（时间轴 F2，L58–264）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 2 | 6 | 350 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 6 KAN_HEAVY 重砍 | 6 | 6 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 5 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 30 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 150 | 5 MAGIC_HEAVY 重法 | 8 | -2 | 0 | 1 | true |
| L118 | `kj2` | 空中技 2 / 上攻 | 50 | 1 KAN 砍 | 0 | -7 | 450 | 0 | false |
| L127 | `zh1` | 招 1 | 80 | 6 KAN_HEAVY 重砍 | 2 | 2 | 400 | 0 | false |
| L136 | `zh2` | 招 2 | 110 | 6 KAN_HEAVY 重砍 | 4 | -10 | 800 | 0 | false |
| L145 | `zh3` | 招 3 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L154 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L163 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 7 | 0 | 1000 | 0 | false |
| L172 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L181 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 5 | -8 | 0 | 1 | false |
| L190 | `bs` | 必杀 | 50 | 1 KAN 砍 | 10 | 0 | 1000 | 0 | false |
| L199 | `bs1` | 必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |
| L208 | `bs2` | 必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | -5 | 0 | 0 | 1 | false |
| L217 | `sbs1` | 上必杀前段/多段 | 30 | 1 KAN 砍 | 0 | 0 | 1000 | 0 | false |
| L226 | `sbs` | 上必杀 | 100 | 6 KAN_HEAVY 重砍 | 3 | -5 | 0 | 1 | false |
| L235 | `cbs` | 超必杀 | 30 | 1 KAN 砍 | 10 | 0 | 0 | 0 | false |
| L244 | `cbs2` | 超必杀前段/多段 | 300 | 5 MAGIC_HEAVY 重法 | 30 | 0 | 0 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L252: `$fighter_ctrler. $fighter_ctrler. $fighter_ctrler. $fighter_ctrler. $fighter_ctrler.defineBishaFace("bsface1", bsface1);` — 登记必杀脸 BitmapData
- L254: `$fighter_ctrler.defineBishaFace("bsface2", bsface2);` — 登记必杀脸 BitmapData
- L255: `$fighter_ctrler.defineBishaFace("bsface3", bsface3);` — 登记必杀脸 BitmapData
- L256: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L257: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L258: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L259: `$fighter_ctrler.speed = 8;` — 走速
- L260: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L261: `$fighter_ctrler.heavy = 3;` — 重量
- L262: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L263: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
