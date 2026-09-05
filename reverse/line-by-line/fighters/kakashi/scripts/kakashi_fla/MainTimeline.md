# `kakashi_fla.MainTimeline` — 旗木·卡卡西 根时间轴

一句话目的：旗木·卡卡西 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/kakashi/scripts/kakashi_fla/MainTimeline.as`（318 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`kakashi startFrame=1`；文件 `assets/fighter/kakashi.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

数值：speed=10 / jump=16 / heavy=3 / 拳防。必杀脸键名 `卡卡西1`←`bsface1`、`卡卡西2`←`bsface2`、`卡卡西3`←`bsface3`。本形态 **未** `defineHurtSound*`（库里也可能没有 `snd_*`）。动作 MC 类名 `Timeline_1`。`defenseType` 拳防。

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

### `frame2`（时间轴 F2，L58–315）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 1 KAN 砍 | 5 | 4 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 50 | 6 KAN_HEAVY 重砍 | 4 | 4 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 20 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L100 | `k21` | 普攻 2 段1/击飞 | 20 | 2 DA 打 | 4 | -3 | 400 | 0 | false |
| L109 | `k3` | 普攻 3 | 60 | 3 DA_HEAVY 重打 | 7 | -7 | 500 | 0 | false |
| L118 | `zh2` | 招 2 | 80 | 6 KAN_HEAVY 重砍 | 0 | 0 | 800 | 0 | true |
| L127 | `kj1` | 空中技 1 / 下攻 | 80 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 40 | 2 DA 打 | 5 | 0 | 500 | 0 | false |
| L145 | `kj22` | 空中技 2 收段 | 80 | 3 DA_HEAVY 重打 | 10 | 0 | 500 | 1 | false |
| L154 | `zh1` | 招 1 | 30 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L163 | `zh12` | 招 1 段2 | 30 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L172 | `zh13` | 招 1 段3 | 30 | 1 KAN 砍 | 4 | 0 | 400 | 1 | false |
| L181 | `zh14` | 招 1 段4 | 30 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L190 | `zh31` | 招 3 段1 | 40 | 1 KAN 砍 | 4 | -2 | 700 | 0 | false |
| L199 | `zh32` | 招 3 段2 | 40 | 3 DA_HEAVY 重打 | 10 | -10 | 700 | 0 | false |
| L208 | `zh3` | 招 3 | 60 | 3 DA_HEAVY 重打 | 8 | -5 | 0 | 1 | false |
| L217 | `sbs` | 上必杀 | 30 | 4 MAGIC 忍术/鬼道 | 8 | 0 | 500 | 0 | false |
| L226 | `sbs2` | 上必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 8 | 0 | 500 | 1 | false |
| L235 | `bs` | 必杀 | 180 | 9 ELECTRIC 雷 | 10 | -5 | 500 | 1 | false |
| L244 | `bs1` | 必杀前段/多段 | 50 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 500 | 0 | false |
| L253 | `cbs1` | 超必杀前段/多段 | 10 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L262 | `cbs` | 超必杀 | 400 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L271 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L289 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L298 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | -10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L307: `$fighter_ctrler.defineBishaFace("卡卡西1",bsface1);` — 登记必杀脸 BitmapData
- L308: `$fighter_ctrler.defineBishaFace("卡卡西2",bsface2);` — 登记必杀脸 BitmapData
- L309: `$fighter_ctrler.defineBishaFace("卡卡西3",bsface3);` — 登记必杀脸 BitmapData
- L310: `$fighter_ctrler.speed = 10;` — 走速
- L311: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L312: `$fighter_ctrler.heavy = 3;` — 重量
- L313: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L314: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
