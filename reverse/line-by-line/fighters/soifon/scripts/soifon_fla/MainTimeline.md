# `soifon_fla.MainTimeline` — 碎蜂 根时间轴

一句话目的：碎蜂 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/soifon/scripts/soifon_fla/MainTimeline.as`（303 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`soifon` startFrame=1（碎蜂）；文件 `assets/fighter/soifon.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=12 / jump=16 / heavy=1 / 斩防。必杀脸：`碎蜂1`←`bsface1`、`碎蜂2`←`bsface2`、`碎蜂3`←`bsface3`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt2)`；`defineDieSound(snd_hurt3)`。

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

### `frame2`（时间轴 F2，L58–300）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 3 DA_HEAVY 重打 | 3 | 6 | 500 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 6 KAN_HEAVY 重砍 | 5 | 10 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 400 | 0 | false |
| L109 | `k4` | 普攻 4 | 70 | 3 DA_HEAVY 重打 | 5 | 0 | 0 | 1 | false |
| L118 | `kj1` | 空中技 1 / 下攻 | 20 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 5 | -3 | 400 | 0 | false |
| L136 | `zh1` | 招 1 | 80 | 6 KAN_HEAVY 重砍 | 3 | 0 | 0 | 1 | false |
| L145 | `zh2` | 招 2 | 120 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | true |
| L154 | `zh3` | 招 3 | 130 | 6 KAN_HEAVY 重砍 | 10 | -8 | 0 | 1 | false |
| L163 | `sh10` | 抓 10 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L172 | `sh1` | 抓 1（hitType 11） | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L181 | `sh20` | 抓 20 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L190 | `sh2` | 抓 2（hitType 11） | 150 | 6 KAN_HEAVY 重砍 | -6 | -8 | 0 | 1 | false |
| L199 | `bs` | 必杀 | 100 | 6 KAN_HEAVY 重砍 | 0 | 0 | 800 | 0 | false |
| L208 | `bs2` | 必杀前段/多段 | 700 | 5 MAGIC_HEAVY 重法 | 0 | -10 | 0 | 1 | true |
| L217 | `sbs1` | 上必杀前段/多段 | 20 | 2 DA 打 | 5 | 0 | 500 | 0 | false |
| L226 | `sbs2` | 上必杀前段/多段 | 30 | 6 KAN_HEAVY 重砍 | 6 | -6 | 500 | 0 | false |
| L235 | `sbs3` | 上必杀前段/多段 | 9 | 1 KAN 砍 | 1 | -1 | 500 | 0 | false |
| L244 | `sbs` | 上必杀 | 100 | 3 DA_HEAVY 重打 | 2 | 15 | 0 | 1 | false |
| L253 | `cbs` | 超必杀 | 500 | 7 FIRE 火 | 25 | -8 | 0 | 1 | true |
| L262 | `kbs` | 空必杀 | 50 | 9 ELECTRIC 雷 | 5 | 5 | 1000 | 0 | false |
| L271 | `kbs2` | 空必杀 2 | 20 | 1 KAN 砍 | 0 | -1 | 500 | 0 | false |
| L280 | `kbs3` | 空必杀 3 | 20 | 1 KAN 砍 | 0 | -2 | 500 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L289: `$fighter_ctrler.defineBishaFace("碎蜂1", bsface1);` — 登记必杀脸 BitmapData
- L290: `$fighter_ctrler.defineBishaFace("碎蜂2", bsface2);` — 登记必杀脸 BitmapData
- L291: `$fighter_ctrler.defineBishaFace("碎蜂3", bsface3);` — 登记必杀脸 BitmapData
- L292: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L293: `$fighter_ctrler.defineHurtFlySound(snd_hurt2);` — 击飞语音
- L294: `$fighter_ctrler.defineDieSound(snd_hurt3);` — 死亡语音
- L295: `$fighter_ctrler.speed = 12;` — 走速
- L296: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L297: `$fighter_ctrler.heavy = 1;` — 重量
- L298: `$fighter_ctrler.defenseType = 0;` — 0=斩防 / 1=拳防
- L299: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
