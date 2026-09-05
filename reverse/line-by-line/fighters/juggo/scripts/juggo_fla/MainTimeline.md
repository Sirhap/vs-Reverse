# `juggo_fla.MainTimeline` — 天秤·重吾 根时间轴

一句话目的：天秤·重吾 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/juggo/scripts/juggo_fla/MainTimeline.as`（311 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`juggo startFrame=1`；文件 `assets/fighter/juggo.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

数值：speed=7 / jump=14 / heavy=5 / 拳防。必杀脸键名 `重吾1`←`bsface1`、`重吾2`←`bsface2`。语音：`$fighter_ctrler.defineHurtSound(snd_hurt1);`；`$fighter_ctrler.defineHurtFlySound(snd_hurt1);`；`$fighter_ctrler.defineDieSound(snd_hurt1);`。动作 MC 类名 `迪达拉全动作_XIN_1`。`defenseType` 拳防。

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

### `frame2`（时间轴 F2，L58–308）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 2 | 0 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 3 DA_HEAVY 重打 | 5 | 15 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 40 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 40 | 2 DA 打 | 6 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 80 | 3 DA_HEAVY 重打 | 3 | -8 | 500 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 100 | 3 DA_HEAVY 重打 | 10 | 0 | 600 | 0 | false |
| L118 | `kj2` | 空中技 2 / 上攻 | 20 | 11 CATCH 抓 | 0 | 0 | 500 | 0 | true |
| L127 | `kj21` | 空中技 2 中段 | 50 | 0 | -15 | 0 | 0 | 1 | false |
| L136 | `zh1` | 招 1 | 50 | 4 MAGIC 忍术/鬼道 | 8 | 0 | 500 | 0 | false |
| L145 | `zh11` | 招 1 段1 | 50 | 7 FIRE 火 | 8 | 0 | 500 | 1 | false |
| L154 | `zh21` | 招 2 段1 | 10 | 2 DA 打 | 0 | 0 | 300 | 0 | false |
| L163 | `zh2` | 招 2 | 50 | 3 DA_HEAVY 重打 | 0 | 0 | 600 | 0 | true |
| L172 | `zh22` | 招 2 段2 | 120 | 7 FIRE 火 | 20 | 0 | 0 | 1 | true |
| L181 | `zh3` | 招 3 | 100 | 3 DA_HEAVY 重打 | 10 | -10 | 500 | 0 | false |
| L190 | `zh32` | 招 3 段2 | 80 | 0 | -15 | 10 | 0 | 1 | false |
| L199 | `bs1` | 必杀前段/多段 | 50 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 2000 | 0 | false |
| L208 | `bs` | 必杀 | 150 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L217 | `sbs1` | 上必杀前段/多段 | 100 | 3 DA_HEAVY 重打 | 2 | -2 | 2000 | 0 | false |
| L226 | `sbs` | 上必杀 | 200 | 5 MAGIC_HEAVY 重法 | 20 | -2 | 0 | 1 | false |
| L235 | `cbs1` | 超必杀前段/多段 | 50 | 11 CATCH 抓 | 0 | 0 | 3000 | 0 | true |
| L244 | `cbs2` | 超必杀前段/多段 | 50 | 0 | 0 | 0 | 3000 | 0 | false |
| L253 | `cbs` | 超必杀 | 150 | 3 DA_HEAVY 重打 | 10 | -5 | 0 | 1 | true |
| L262 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L271 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L280 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L289 | `sh22` | 抓 2 伤害段 | 160 | 3 DA_HEAVY 重打 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L298: `$fighter_ctrler.defineBishaFace("重吾1",bsface1);` — 登记必杀脸 BitmapData
- L299: `$fighter_ctrler.defineBishaFace("重吾2",bsface2);` — 登记必杀脸 BitmapData
- L300: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L301: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L302: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L303: `$fighter_ctrler.speed = 7;` — 走速
- L304: `$fighter_ctrler.jumpPower = 14;` — 跳跃初速
- L305: `$fighter_ctrler.heavy = 5;` — 重量
- L306: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L307: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
