# `neji_fla.MainTimeline` — 日向·宁次 根时间轴

一句话目的：日向·宁次 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/neji/scripts/neji_fla/MainTimeline.as`（302 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler） → `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`neji` sf=1；文件 `assets/fighter/neji.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

动作类名误作 `一护全动作_1`（一护 FLA 模板残留）。拳防。受击三轨 `snd_hurt1,2,3`，击飞 `snd_hurtfly1,2`，死亡 `snd_die,snd_die2`。

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

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–299）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`一护全动作_1`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L73 | `tz` | 跳重 | 110 | 3 DA_HEAVY 重打 | 3 | 12 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 20 | 2 DA 打 | 2 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 1 | 0 | 500 | 0 | false |
| L109 | `k4` | 普攻 4 | 60 | 2 DA 打 | 5 | -7 | 500 | 0 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 50 | 3 DA_HEAVY 重打 | 3 | 0 | 500 | 0 | false |
| L127 | `kj11` | 空中技 kj11 中段/收段 | 8 | 2 DA 打 | 0 | 0 | 500 | 0 | false |
| L136 | `kj12` | 空中技 kj12 中段/收段 | 50 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 30 | 2 DA 打 | 0 | 0 | 400 | 0 | false |
| L154 | `zh1` | 招 1 | 50 | 6 KAN_HEAVY 重砍 | 2 | 0 | 500 | 0 | false |
| L163 | `zh2` | 招 2 | 90 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | true |
| L172 | `zh3` | 招 3 | 90 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L181 | `bs1` | 必杀 bs1 | 30 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 500 | 0 | false |
| L190 | `bs` | 必杀 | 150 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L199 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L208 | `cbs` | 超必杀 | 10 | 2 DA 打 | 2.5 | 0 | 800 | 0 | false |
| L217 | `cbs2` | 超必杀 cbs2 | 10 | 2 DA 打 | 1.5 | 0 | 800 | 0 | false |
| L226 | `cbs3` | 超必杀 cbs3 | 10 | 2 DA 打 | 6 | 0 | 800 | 0 | false |
| L235 | `cbs1` | 超必杀 cbs1 | 80 | 3 DA_HEAVY 重打 | 20 | 0 | 0 | 1 | false |
| L244 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `sh12` | 抓伤害段 sh12 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L262 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L271 | `sh21` | 抓伤害段 sh21 | 20 | 2 DA 打 | 0 | 0 | 1000 | 0 | false |
| L280 | `sh22` | 抓伤害段 sh22 | 100 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L289: `$fighter_ctrler.defineBishaFace("宁次1",bsface1);` — 登记必杀脸 BitmapData
- L290: `$fighter_ctrler.defineBishaFace("宁次2",bsface2);` — 登记必杀脸 BitmapData
- L291: `$fighter_ctrler.defineHurtSound(snd_hurt1,snd_hurt2,snd_hurt3);` — 受击语音
- L292: `$fighter_ctrler.defineHurtFlySound(snd_hurtfly1,snd_hurtfly2);` — 击飞语音
- L293: `$fighter_ctrler.defineDieSound(snd_die,snd_die2);` — 死亡语音
- L294: `$fighter_ctrler.speed = 8;` — 走速
- L295: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L296: `$fighter_ctrler.heavy = 3;` — 重量
- L297: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L298: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
