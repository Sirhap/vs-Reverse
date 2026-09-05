# `orochimaru_fla.MainTimeline` — 大蛇丸 根时间轴

一句话目的：大蛇丸 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/orochimaru/scripts/orochimaru_fla/MainTimeline.as`（311 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`orochimaru` startFrame=1（大蛇丸）；文件 `assets/fighter/orochimaru.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=10 / jump=15 / heavy=3 / 拳防。必杀脸：`大蛇丸1`←`bsface1`、`大蛇丸2`←`bsface2`。语音：`defineHurtSound(snd_hurt1,snd_hurt2)`；`defineHurtFlySound(snd_hurt3)`；`defineDieSound(snd_die)`。
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

### `frame2`（时间轴 F2，L58–308）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L73 | `tk2` | 跳轻 段2 | 60 | 3 DA_HEAVY 重打 | 0 | 10 | 500 | 1 | false |
| L82 | `tz` | 跳重 | 100 | 3 DA_HEAVY 重打 | 10 | 10 | 0 | 1 | false |
| L91 | `k1` | 普攻 1 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L100 | `k4` | 普攻 4 | 20 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L109 | `k2` | 普攻 2 | 60 | 6 KAN_HEAVY 重砍 | 1 | 0 | 400 | 0 | false |
| L118 | `k3` | 普攻 3 | 60 | 3 DA_HEAVY 重打 | 2 | -5 | 500 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 30 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L136 | `kj11` | 空中技 11 | 40 | 6 KAN_HEAVY 重砍 | -3 | 0 | 400 | 0 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 120 | 6 KAN_HEAVY 重砍 | 0 | -6 | 500 | 0 | false |
| L154 | `zh1` | 招 1 | 140 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |
| L163 | `zh2` | 招 2 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 800 | 0 | true |
| L172 | `zh3` | 招 3 | 100 | 5 MAGIC_HEAVY 重法 | 7 | -5 | 500 | 0 | false |
| L181 | `bs` | 必杀 | 300 | 6 KAN_HEAVY 重砍 | 15 | 0 | 0 | 1 | false |
| L190 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 5 | -15 | 0 | 1 | false |
| L199 | `cbs` | 超必杀 | 300 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L208 | `cbs1` | 超必杀前段/多段 | 80 | 6 KAN_HEAVY 重砍 | 5 | 3 | 800 | 0 | false |
| L217 | `cbs2` | 超必杀前段/多段 | 40 | 1 KAN 砍 | 5 | 0 | 800 | 0 | false |
| L226 | `cbs3` | 超必杀前段/多段 | 60 | 6 KAN_HEAVY 重砍 | 3 | 0 | 800 | 0 | false |
| L235 | `cbs4` | 超必杀前段/多段 | 10 | 1 KAN 砍 | 0 | -1 | 800 | 0 | true |
| L244 | `cbs41` | 超必杀前段/多段 | 10 | 1 KAN 砍 | 0 | -5 | 800 | 0 | true |
| L253 | `cbs5` | 超必杀前段/多段 | 70 | 6 KAN_HEAVY 重砍 | 6 | 0 | 800 | 0 | false |
| L262 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L271 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L280 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L289 | `sh22` | 抓 2 伤害段 | 150 | 0 ? 未知 | -10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L298: `$fighter_ctrler.defineBishaFace("大蛇丸1", bsface1);` — 登记必杀脸 BitmapData
- L299: `$fighter_ctrler.defineBishaFace("大蛇丸2", bsface2);` — 登记必杀脸 BitmapData
- L300: `$fighter_ctrler.defineHurtSound(snd_hurt1, snd_hurt2);` — 受击语音
- L301: `$fighter_ctrler.defineHurtFlySound(snd_hurt3);` — 击飞语音
- L302: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L303: `$fighter_ctrler.speed = 10;` — 走速
- L304: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L305: `$fighter_ctrler.heavy = 3;` — 重量
- L306: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L307: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
