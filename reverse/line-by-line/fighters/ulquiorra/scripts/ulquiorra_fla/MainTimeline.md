# `ulquiorra_fla.MainTimeline` — 乌尔奇奥拉 根时间轴

一句话目的：乌尔奇奥拉 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/ulquiorra/scripts/ulquiorra_fla/MainTimeline.as`（510 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`ulquiorra` startFrame=1（乌尔奇奥拉）；`ulquiorra_guiren` startFrame=2（乌尔奇奥拉 归刃）；文件 `assets/fighter/ulquiorra.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2，sf=2 → F3。

F2：speed=12 / jump=15 / heavy=2 / 拳防。必杀脸：`小乌1`←`bsface1`。语音：本形态 **未** `defineHurtSound*`（库里也可能没有 `snd_*`）。? 受击无声。
F3：speed=14 / jump=16 / heavy=2 / 斩防。必杀脸：`小乌1`←`bsface1`。语音：本形态 **未** `defineHurtSound*`（库里也可能没有 `snd_*`）。? 受击无声。
动作 MC 类名误作 `一护虚化全动作_1` / `一护虚化全动作副本_9`（一护 FLA 模板残留）。切归刃 `startWanKai("一户万解")`（「护」写成「户」）。

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

### `frame2`（时间轴 F2，L58–268）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 70 | 6 KAN_HEAVY 重砍 | 3 | 1 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 130 | 5 MAGIC_HEAVY 重法 | 5 | 10 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 5 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 5 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 70 | 3 DA_HEAVY 重打 | 8 | 0 | 700 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 80 | 1 KAN 砍 | 10 | -5 | 600 | 0 | false |
| L118 | `kj12` | 空中技 12 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 100 | 6 KAN_HEAVY 重砍 | 8 | -10 | 600 | 0 | false |
| L136 | `zh1` | 招 1 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L145 | `zh2` | 招 2 | 40 | 4 MAGIC 忍术/鬼道 | 5 | -7 | 800 | 0 | true |
| L154 | `zh3` | 招 3 | 120 | 5 MAGIC_HEAVY 重法 | 10 | -8 | 0 | 1 | false |
| L163 | `bs` | 必杀 | 280 | 5 MAGIC_HEAVY 重法 | 25 | 0 | 0 | 1 | false |
| L172 | `sbs` | 上必杀 | 10 | 1 KAN 砍 | 13 | -13 | 500 | 0 | false |
| L181 | `sbs1` | 上必杀前段/多段 | 200 | 5 MAGIC_HEAVY 重法 | 20 | 5 | 0 | 1 | false |
| L190 | `kbs` | 空必杀 | 10 | 1 KAN 砍 | 13 | 13 | 500 | 0 | false |
| L199 | `kbs1` | 空必杀 1 | 250 | 5 MAGIC_HEAVY 重法 | 20 | 5 | 0 | 1 | false |
| L208 | `cbs1` | 超必杀前段/多段 | 150 | 5 MAGIC_HEAVY 重法 | 30 | -10 | 0 | 1 | true |
| L217 | `cbs` | 超必杀 | 50 | 4 MAGIC 忍术/鬼道 | 10 | -0.1 | 1000 | 0 | false |
| L226 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L235 | `sh12` | 抓 1 伤害段 | 50 | 0 ? 未知 | -7 | 0 | 1000 | 0 | false |
| L244 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L262: `$fighter_ctrler.defineBishaFace("小乌1", bsface1);` — 登记必杀脸 BitmapData
- L263: `$fighter_ctrler.speed = 12;` — 走速
- L264: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L265: `$fighter_ctrler.heavy = 2;` — 重量
- L266: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L267: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L270–507）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L276 | `tk` | 跳轻/跳踢 | 80 | 5 MAGIC_HEAVY 重法 | 6 | 0 | 500 | 0 | false |
| L285 | `tz` | 跳重 | 120 | 5 MAGIC_HEAVY 重法 | 10 | 7 | 0 | 1 | false |
| L294 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 4 | 0 | 300 | 0 | false |
| L303 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L312 | `k3` | 普攻 3 | 60 | 6 KAN_HEAVY 重砍 | 5 | 0 | 500 | 0 | false |
| L321 | `k4` | 普攻 4 | 100 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L330 | `kj1` | 空中技 1 / 下攻 | 160 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | true |
| L339 | `kj21` | 空中技 21 | 40 | 1 KAN 砍 | 0 | -18 | 600 | 0 | false |
| L348 | `kj22` | 空中技 22 | 30 | 1 KAN 砍 | 0 | -1 | 500 | 0 | false |
| L357 | `kj2` | 空中技 2 / 上攻 | 130 | 7 FIRE 火 | 10 | 10 | 0 | 1 | false |
| L366 | `zh1` | 招 1 | 150 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L375 | `zh2` | 招 2 | 100 | 6 KAN_HEAVY 重砍 | 10 | -10 | 700 | 0 | false |
| L384 | `zh3` | 招 3 | 160 | 6 KAN_HEAVY 重砍 | 10 | -7 | 0 | 1 | false |
| L393 | `bs1` | 必杀前段/多段 | 40 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 500 | 0 | false |
| L402 | `bs` | 必杀 | 50 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L411 | `sbs` | 上必杀 | 260 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | false |
| L420 | `cbs1` | 超必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 0 | 0 | 1000 | 0 | false |
| L429 | `cbs2` | 超必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 0 | -1 | 1000 | 0 | false |
| L438 | `cbs` | 超必杀 | 300 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L447 | `kbs1` | 空必杀 1 | 20 | 2 DA 打 | 0 | 10 | 400 | 0 | false |
| L456 | `kbs` | 空必杀 | 250 | 5 MAGIC_HEAVY 重法 | 15 | 10 | 0 | 1 | false |
| L465 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L474 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | -7 | 0 | 1000 | 0 | false |
| L483 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L492 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 2 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L272: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L501: `$fighter_ctrler.defineBishaFace("小乌1", bsface1);` — 登记必杀脸 BitmapData
- L502: `$fighter_ctrler.speed = 14;` — 走速
- L503: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L504: `$fighter_ctrler.heavy = 2;` — 重量
- L505: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L506: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
