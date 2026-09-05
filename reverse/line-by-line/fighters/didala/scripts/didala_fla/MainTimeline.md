# `didala_fla.MainTimeline` — 迪达拉 根时间轴

一句话目的：迪达拉 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/didala/scripts/didala_fla/MainTimeline.as`（284 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`didala`；文件 `assets/fighter/didala.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

`defenseType=1` 拳防。大量 hitType 7 FIRE。动作 MC 类名 `Timeline_1`。comic_type=1（火影侧）。

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

### `frame2`（时间轴 F2，L58–281）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 2 DA 打 | 0 | 12 | 350 | 0 | false |
| L73 | `tz` | 跳重 | 160 | 7 FIRE 火 | 6 | 0 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 20 | 2 DA 打 | 4 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 400 | 0 | false |
| L109 | `k4` | 普攻 4 | 50 | 3 DA_HEAVY 重打 | 3 | -7 | 500 | 0 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 80 | 3 DA_HEAVY 重打 | 2 | -8 | 600 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 6 | 0 | 500 | 0 | false |
| L136 | `kj21` | 空中技 2 中段 | 30 | 1 KAN 砍 | -3 | 0 | 500 | 0 | false |
| L145 | `zh1` | 招 1 | 100 | 7 FIRE 火 | 8 | 0 | 0 | 1 | false |
| L154 | `zh2` | 招 2 | 150 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | true |
| L163 | `zh21` | 招 2 分支 | 20 | 2 DA 打 | 10 | 0 | 500 | 0 | false |
| L172 | `zh3` | 招 3 | 140 | 7 FIRE 火 | 8 | -8 | 0 | 1 | false |
| L181 | `bs2` | 必杀变体 | 100 | 7 FIRE 火 | 12 | 0 | 0 | 1 | false |
| L190 | `bs` | 必杀 | 20 | 2 DA 打 | 12 | 0 | 500 | 0 | false |
| L199 | `sbs1` | 上必杀前段 | 10 | 2 DA 打 | 8 | -3 | 800 | 0 | false |
| L208 | `sbs` | 上必杀 | 200 | 7 FIRE 火 | 15 | -15 | 0 | 1 | false |
| L217 | `cbs1` | 超必杀前段 | 120 | 7 FIRE 火 | 0 | 0 | 1000 | 0 | false |
| L226 | `cbs` | 超必杀 | 140 | 7 FIRE 火 | 20 | -10 | 0 | 1 | false |
| L235 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L253 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L262 | `sh22` | 抓 2 伤害段 | 150 | 7 FIRE 火 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L271: `$fighter_ctrler.defineBishaFace("迪达拉1",bsface1);` — 登记必杀脸 BitmapData
- L272: `$fighter_ctrler.defineBishaFace("迪达拉2",bsface2);` — 登记必杀脸 BitmapData
- L273: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L274: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L275: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L276: `$fighter_ctrler.speed = 10;` — 走速
- L277: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L278: `$fighter_ctrler.heavy = 3;` — 重量
- L279: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L280: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
