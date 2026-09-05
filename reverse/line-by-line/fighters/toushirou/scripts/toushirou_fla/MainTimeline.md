# `toushirou_fla.MainTimeline` — 日番谷·东狮郎 根时间轴

一句话目的：日番谷·东狮郎 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/toushirou/scripts/toushirou_fla/MainTimeline.as`（529 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`toushirou` startFrame=1（日番谷·东狮郎）；`toushirou_wanjie` startFrame=2（日番谷·东狮郎 卍解）；文件 `assets/fighter/toushirou.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2，sf=2 → F3。

F2：speed=8 / jump=16 / heavy=2 / 斩防。必杀脸：`日番谷1`←`bsface1`、`日番谷2`←`bsface2`、`日番谷3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt2)`；`defineDieSound(snd_hurt2)`。
F3：speed=10 / jump=18 / heavy=4 / 斩防。必杀脸：`日番谷1`←`bsface1`、`日番谷2`←`bsface2`、`日番谷3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt2)`；`defineDieSound(snd_hurt2)`。

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
- L34: `addFrameScript(0, frame1, 1, frame2, 2, frame3);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–300）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 1 KAN 砍 | 5 | 0 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 8 ICE 冰 | 5 | 5 | 500 | 1 | false |
| L82 | `tz1` | 跳重 段1 | 100 | 8 ICE 冰 | 5 | 5 | 500 | 1 | false |
| L91 | `tz2` | 跳重 段2 | 100 | 8 ICE 冰 | 5 | 5 | 0 | 1 | false |
| L100 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 2 | 0 | 300 | 0 | false |
| L109 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L118 | `k3` | 普攻 3 | 70 | 6 KAN_HEAVY 重砍 | 5 | -5 | 400 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 100 | 5 MAGIC_HEAVY 重法 | 8 | -4 | 0 | 1 | false |
| L136 | `kj21` | 空中技 21 | 50 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 70 | 8 ICE 冰 | 5 | 0 | 0 | 1 | false |
| L154 | `zh1` | 招 1 | 25 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 200 | 0 | false |
| L163 | `zh12` | 招 12 | 25 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 200 | 1 | false |
| L172 | `zh2` | 招 2 | 50 | 8 ICE 冰 | 2 | 0 | 1000 | 0 | true |
| L181 | `zh3` | 招 3 | 40 | 4 MAGIC 忍术/鬼道 | 6 | -7 | 500 | 0 | false |
| L190 | `bs` | 必杀 | 50 | 4 MAGIC 忍术/鬼道 | 15 | 0 | 400 | 0 | false |
| L199 | `bs2` | 必杀前段/多段 | 100 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L208 | `sbs1` | 上必杀前段/多段 | 50 | 6 KAN_HEAVY 重砍 | 10 | -3 | 500 | 0 | false |
| L217 | `sbs2` | 上必杀前段/多段 | 50 | 1 KAN 砍 | 10 | -3 | 500 | 0 | false |
| L226 | `sbs` | 上必杀 | 50 | 1 KAN 砍 | 10 | -3 | 0 | 1 | false |
| L235 | `cbs1` | 超必杀前段/多段 | 10 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L244 | `cbs` | 超必杀 | 300 | 5 MAGIC_HEAVY 重法 | 0 | -10 | 0 | 1 | true |
| L253 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L262 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L271 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L289: `$fighter_ctrler.defineBishaFace("日番谷1", bsface1);` — 登记必杀脸 BitmapData
- L290: `$fighter_ctrler.defineBishaFace("日番谷2", bsface2);` — 登记必杀脸 BitmapData
- L291: `$fighter_ctrler.defineBishaFace("日番谷3", bsface3);` — 登记必杀脸 BitmapData
- L292: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L293: `$fighter_ctrler.defineHurtFlySound(snd_hurt2);` — 击飞语音
- L294: `$fighter_ctrler.defineDieSound(snd_hurt2);` — 死亡语音
- L295: `$fighter_ctrler.speed = 8;` — 走速
- L296: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L297: `$fighter_ctrler.heavy = 2;` — 重量
- L298: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L299: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L302–526）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L308 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 0 | 3 | 400 | 0 | false |
| L317 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 10 | 10 | 0 | 1 | false |
| L326 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L335 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L344 | `k3` | 普攻 3 | 50 | 6 KAN_HEAVY 重砍 | 7 | -7 | 500 | 0 | false |
| L353 | `kj1` | 空中技 1 / 下攻 | 80 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | true |
| L362 | `kj21` | 空中技 21 | 50 | 6 KAN_HEAVY 重砍 | 5 | -10 | 600 | 0 | false |
| L371 | `kj2` | 空中技 2 / 上攻 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 10 | 0 | 1 | false |
| L380 | `zh1` | 招 1 | 80 | 6 KAN_HEAVY 重砍 | 0 | -6 | 300 | 1 | false |
| L389 | `zh21` | 招 21 | 30 | 6 KAN_HEAVY 重砍 | 10 | -3 | 500 | 0 | false |
| L398 | `zh22` | 招 22 | 30 | 1 KAN 砍 | 10 | -3 | 500 | 0 | false |
| L407 | `zh2` | 招 2 | 30 | 1 KAN 砍 | 10 | -3 | 0 | 1 | false |
| L416 | `zh3` | 招 3 | 40 | 4 MAGIC 忍术/鬼道 | 5 | -7 | 500 | 0 | false |
| L425 | `bs` | 必杀 | 50 | 8 ICE 冰 | 0 | 0 | 1000 | 0 | true |
| L434 | `bs1` | 必杀前段/多段 | 200 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L443 | `sbs` | 上必杀 | 320 | 6 KAN_HEAVY 重砍 | 3 | -8 | 0 | 1 | false |
| L452 | `cbs1` | 超必杀前段/多段 | 10 | 4 MAGIC 忍术/鬼道 | 0 | 10 | 0 | 0 | false |
| L461 | `cbs` | 超必杀 | 400 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L470 | `cbs3` | 超必杀前段/多段 | 10 | 4 MAGIC 忍术/鬼道 | 0 | -1 | 5000 | 0 | false |
| L479 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L488 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 1000 | 0 | false |
| L497 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L506 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L304: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L515: `$fighter_ctrler.defineBishaFace("日番谷1", bsface1);` — 登记必杀脸 BitmapData
- L516: `$fighter_ctrler.defineBishaFace("日番谷2", bsface2);` — 登记必杀脸 BitmapData
- L517: `$fighter_ctrler.defineBishaFace("日番谷3", bsface3);` — 登记必杀脸 BitmapData
- L518: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L519: `$fighter_ctrler.defineHurtFlySound(snd_hurt2);` — 击飞语音
- L520: `$fighter_ctrler.defineDieSound(snd_hurt2);` — 死亡语音
- L521: `$fighter_ctrler.speed = 10;` — 走速
- L522: `$fighter_ctrler.jumpPower = 18;` — 跳跃初速
- L523: `$fighter_ctrler.heavy = 4;` — 重量
- L524: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L525: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
