# `sakura_fla.MainTimeline` — 春野·樱 根时间轴

一句话目的：春野·樱 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/sakura/scripts/sakura_fla/MainTimeline.as`（335 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`sakura` startFrame=1（春野·樱）；文件 `assets/fighter/sakura.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=6 / jump=15 / heavy=2 / 拳防。必杀脸：`樱1`←`bsface1`、`樱2`←`bsface1`。语音：本形态 **未** `defineHurtSound*`（库里也可能没有 `snd_*`）。? 受击无声。

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

### `frame2`（时间轴 F2，L58–332）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 2 DA 打 | 4 | 8 | 500 | 0 | false |
| L73 | `tz1` | 跳重 段1 | 10 | 2 DA 打 | 6 | 8 | 500 | 0 | false |
| L82 | `tz` | 跳重 | 100 | 3 DA_HEAVY 重打 | 10 | -5 | 500 | 1 | false |
| L91 | `k1` | 普攻 1 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L100 | `k2` | 普攻 2 | 40 | 2 DA 打 | 5 | 0 | 400 | 0 | false |
| L109 | `k3` | 普攻 3 | 60 | 3 DA_HEAVY 重打 | 5 | 0 | 600 | 0 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 30 | 2 DA 打 | 10 | 0 | 500 | 0 | true |
| L127 | `kj11` | 空中技 11 | 80 | 3 DA_HEAVY 重打 | 9 | -3 | 0 | 1 | false |
| L136 | `kj21` | 空中技 21 | 30 | 2 DA 打 | 6 | -1 | 400 | 0 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 60 | 3 DA_HEAVY 重打 | 4 | -5 | 500 | 0 | false |
| L154 | `zh1` | 招 1 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L163 | `zh12` | 招 12 | 30 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L172 | `zh2` | 招 2 | 60 | 3 DA_HEAVY 重打 | 7 | -8 | 700 | 0 | false |
| L181 | `zh3` | 招 3 | 130 | 6 KAN_HEAVY 重砍 | 5 | -5 | 500 | 1 | false |
| L190 | `zh31` | 招 31 | 130 | 6 KAN_HEAVY 重砍 | 5 | -5 | 500 | 1 | false |
| L199 | `zh32` | 招 32 | 130 | 6 KAN_HEAVY 重砍 | 5 | -5 | 500 | 1 | false |
| L208 | `bs` | 必杀 | 200 | 5 MAGIC_HEAVY 重法 | 10 | -4 | 0 | 1 | true |
| L217 | `bs1` | 必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L226 | `sbs2` | 上必杀前段/多段 | 10 | 2 DA 打 | 0 | 10 | 500 | 0 | false |
| L235 | `sbs` | 上必杀 | 200 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L244 | `kbs2` | 空必杀 2 | 10 | 2 DA 打 | 0 | 10 | 500 | 0 | false |
| L253 | `kbs` | 空必杀 | 250 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L262 | `cbs1` | 超必杀前段/多段 | 30 | 2 DA 打 | 0 | -0.1 | 1000 | 0 | false |
| L271 | `cbs2` | 超必杀前段/多段 | 50 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | true |
| L280 | `cbs` | 超必杀 | 100 | 3 DA_HEAVY 重打 | 20 | -2 | 0 | 1 | false |
| L289 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L298 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L307 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L316 | `sh22` | 抓 2 伤害段 | 150 | 3 DA_HEAVY 重打 | 10 | 10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L325: `$fighter_ctrler.defineBishaFace("樱1", bsface1);` — 登记必杀脸 BitmapData
- L326: `$fighter_ctrler.defineBishaFace("樱2", bsface1);` — 登记必杀脸 BitmapData
- L327: `$fighter_ctrler.speed = 6;` — 走速
- L328: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L329: `$fighter_ctrler.heavy = 2;` — 重量
- L330: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L331: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
