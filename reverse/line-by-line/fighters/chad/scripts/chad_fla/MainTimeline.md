# `chad_fla.MainTimeline` — 茶渡·泰虎 根时间轴

一句话目的：茶渡·泰虎 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/chad/scripts/chad_fla/MainTimeline.as`（265 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`chad`；文件 `assets/fighter/chad.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

`defenseType=1` 拳防。speed=6 很慢、heavy=5 偏重。动作 MC 类名 `一护万解全动作_1` 是一护模板残留，茶渡无万解。仅一张必杀脸 `茶渡`。

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

### `frame2`（时间轴 F2，L58–262）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 70 | 3 DA_HEAVY 重打 | 3 | 3 | 800 | 0 | false |
| L73 | `tz1` | 跳重前段 | 20 | 4 MAGIC 忍术/鬼道 | 10 | 10 | 400 | 0 | false |
| L82 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L91 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L100 | `k2` | 普攻 2 | 40 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L109 | `k3` | 普攻 3 | 20 | 2 DA 打 | 5 | 0 | 400 | 0 | false |
| L118 | `k4` | 普攻 4 | 60 | 3 DA_HEAVY 重打 | 10 | 0 | 500 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 100 | 3 DA_HEAVY 重打 | 1 | 0 | 500 | 0 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 80 | 5 MAGIC_HEAVY 重法 | 5 | -7 | 800 | 0 | false |
| L145 | `zh1` | 招 1 | 130 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 400 | 1 | false |
| L154 | `zh2` | 招 2 | 80 | 3 DA_HEAVY 重打 | 5 | -7 | 600 | 0 | true |
| L163 | `zh3` | 招 3 | 150 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L172 | `bs` | 必杀 | 290 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L181 | `sbs1` | 上必杀前段 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 1000 | 0 | false |
| L190 | `sbs` | 上必杀 | 120 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L199 | `cbs` | 超必杀 | 200 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | true |
| L208 | `cbs1` | 超必杀前段 | 350 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | true |
| L217 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L226 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L235 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh22` | 抓 2 伤害段 | 150 | 0 无（?） | -5 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L253: `$fighter_ctrler.defineBishaFace("茶渡",bsface1);` — 登记必杀脸 BitmapData
- L254: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L255: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L256: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L257: `$fighter_ctrler.speed = 6;` — 走速
- L258: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L259: `$fighter_ctrler.heavy = 5;` — 重量
- L260: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L261: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
