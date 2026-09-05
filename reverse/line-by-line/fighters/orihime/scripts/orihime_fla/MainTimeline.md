# `orihime_fla.MainTimeline` — 井上·织姬 根时间轴

一句话目的：井上·织姬 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/orihime/scripts/orihime_fla/MainTimeline.as`（284 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler） → `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`orihime` sf=1；文件 `assets/fighter/orihime.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

本批最轻（heavy 1）也最慢（speed 6.5）。招/必杀多帧 `$fighter_ctrler.addHp(recoveryBisha)`（每帧 +3）。拳防。

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

### `frame2`（时间轴 F2，L58–281）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`织姬全动作_1`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 40 | 2 DA 打 | 4 | 0 | 500 | 0 | false |
| L100 | `k3` | 普攻 3 | 70 | 5 MAGIC_HEAVY 重法 | 0 | -5 | 500 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 30 | 2 DA 打 | 3 | 0 | 400 | 0 | false |
| L118 | `kj12` | 空中技 kj12 中段/收段 | 70 | 3 DA_HEAVY 重打 | 5 | 0 | 500 | 0 | false |
| L127 | `kj2` | 空中技 2 / 上攻 | 10 | 2 DA 打 | 1 | 0 | 300 | 0 | false |
| L136 | `zh1` | 招 1 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L145 | `zh2` | 招 2 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 300 | 1 | true |
| L154 | `zh22` | 招 zh22 | 150 | 5 MAGIC_HEAVY 重法 | 5 | 0 | 300 | 1 | false |
| L163 | `zh3` | 招 3 | 80 | 5 MAGIC_HEAVY 重法 | 7 | -7 | 0 | 1 | false |
| L172 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L181 | `sh12` | 抓伤害段 sh12 | 50 | 3 DA_HEAVY 重打 | 2 | 0 | 1000 | 0 | false |
| L190 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L199 | `sh21` | 抓伤害段 sh21 | 150 | 5 MAGIC_HEAVY 重法 | 0 | -10 | 0 | 1 | false |
| L208 | `bs` | 必杀 | 270 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |
| L217 | `sbs` | 上必杀 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L226 | `cbs1` | 超必杀 cbs1 | 50 | 3 DA_HEAVY 重打 | 2 | 0 | 1000 | 0 | false |
| L235 | `cbs2` | 超必杀 cbs2 | 30 | 4 MAGIC 忍术/鬼道 | 2 | 0 | 1000 | 0 | false |
| L244 | `cbs3` | 超必杀 cbs3 | 50 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 1000 | 0 | true |
| L253 | `cbs5` | 超必杀 cbs5 | 15 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L262 | `cbs` | 超必杀 | 15 | 4 MAGIC 忍术/鬼道 | 10 | 0 | 1000 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L271: `$fighter_ctrler.defineBishaFace("织姬1",bsface1);` — 登记必杀脸 BitmapData
- L272: `$fighter_ctrler.defineBishaFace("织姬2",bsface2);` — 登记必杀脸 BitmapData
- L273: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L274: `$fighter_ctrler.defineHurtFlySound(snd_hurt2);` — 击飞语音
- L275: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L276: `$fighter_ctrler.speed = 6.5;` — 走速
- L277: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L278: `$fighter_ctrler.heavy = 1;` — 重量
- L279: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L280: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
