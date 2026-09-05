# `aizen_fla.MainTimeline` — 蓝染·惣右介 根时间轴

一句话目的：蓝染·惣右介 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/aizen/scripts/aizen_fla/MainTimeline.as`（356 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`aizen`；文件 `assets/fighter/aizen.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

`defenseType=0` 斩防。speed=13 偏快。必杀脸键名 `蓝染1`/`蓝染2`。受击/击飞/死亡共用 `snd_hurt1`。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用
| L29 | `defineAction` | `Function` | `setFighterCtrler` 写成 ctrler.defineAction

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

### `frame2`（时间轴 F2，L58–353）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 50 | 6 KAN_HEAVY 重砍 | 6 | 6 | 600 | 0 | false |
| L73 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 1 KAN 砍 | 3 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 50 | 6 KAN_HEAVY 重砍 | 4 | 0 | 600 | 0 | false |
| L109 | `k4` | 普攻 4 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 400 | 0 | false |
| L118 | `k5` | 普攻 5 | 30 | 1 KAN 砍 | 3 | -5 | 600 | 0 | false |
| L127 | `k52` | 普攻 5 击飞段 | 30 | 1 KAN 砍 | 3 | -5 | 600 | 1 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 120 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | true |
| L145 | `kj21` | 空中技 2 中段 | 40 | 6 KAN_HEAVY 重砍 | 1 | 0 | 600 | 0 | false |
| L154 | `kj22` | 空中技 2 收段 | 50 | 6 KAN_HEAVY 重砍 | 7 | 0 | 0 | 1 | false |
| L163 | `kj1` | 空中技 1 / 下攻 | 100 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L172 | `kj12` | 空中技 1 收段 | 110 | 6 KAN_HEAVY 重砍 | 7 | 0 | 0 | 1 | false |
| L181 | `zh1` | 招 1 | 100 | 9 ELECTRIC 雷 | 15 | 0 | 0 | 1 | false |
| L190 | `zh2` | 招 2 | 110 | 5 MAGIC_HEAVY 重法 | 30 | -5 | 0 | 1 | true |
| L199 | `zh3` | 招 3 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 700 | 1 | false |
| L208 | `zh31` | 招 3 分支 | 100 | 5 MAGIC_HEAVY 重法 | 20 | -3 | 0 | 1 | false |
| L217 | `bs1` | 必杀前段/多段 | 20 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L226 | `bs` | 必杀 | 80 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L235 | `sbs` | 上必杀 | 150 | 5 MAGIC_HEAVY 重法 | 0 | -15 | 0 | 1 | false |
| L244 | `sbs1` | 上必杀前段 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L253 | `sbs2` | 上必杀 2 | 30 | 1 KAN 砍 | 4 | -4 | 500 | 0 | false |
| L262 | `sbs3` | 上必杀 3 | 30 | 1 KAN 砍 | 4 | 4 | 500 | 0 | false |
| L271 | `sbs4` | 上必杀 4 | 50 | 6 KAN_HEAVY 重砍 | 2 | 0 | 1000 | 0 | false |
| L280 | `kbs` | 空必杀 | 200 | 5 MAGIC_HEAVY 重法 | 15 | 5 | 0 | 1 | false |
| L289 | `cbs` | 超必杀 | 20 | 4 MAGIC 忍术/鬼道 | 1 | -0.1 | 500 | 0 | false |
| L298 | `cbs2` | 超必杀 2 | 40 | 5 MAGIC_HEAVY 重法 | 2 | -10 | 0 | 1 | true |
| L307 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L316 | `sh12` | 抓 1 伤害段 | 50 | 6 KAN_HEAVY 重砍 | -7 | 1 | 1000 | 0 | false |
| L325 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L334 | `sh22` | 抓 2 伤害段 | 150 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L343: `$fighter_ctrler.defineBishaFace("蓝染1",bsface1);` — 登记必杀脸 BitmapData
- L344: `$fighter_ctrler.defineBishaFace("蓝染2",bsface2);` — 登记必杀脸 BitmapData
- L345: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L346: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L347: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L348: `$fighter_ctrler.speed = 13;` — 走速
- L349: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L350: `$fighter_ctrler.heavy = 3;` — 重量
- L351: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L352: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
