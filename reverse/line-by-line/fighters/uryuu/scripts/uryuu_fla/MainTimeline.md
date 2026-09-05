# `uryuu_fla.MainTimeline` — 石田·雨龙 根时间轴

一句话目的：石田·雨龙 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/uryuu/scripts/uryuu_fla/MainTimeline.as`（286 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`uryuu` startFrame=1（石田·雨龙）；文件 `assets/fighter/uryuu.swf`；comic_type 0 死神。引擎 `gotoAndStop(startFrame+1)`，因此 sf=1 → 时间轴 F2。

F2：speed=10 / jump=15 / heavy=2 / 拳防。必杀脸：`石田1`←`bsface1`、`石田2`←`bsface2`、`石田3`←`bsface3`。语音：`defineHurtSound(snd_hurt1,snd_hurt2)`；`defineHurtFlySound(snd_hurtfly)`；`defineDieSound(snd_die)`。

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

### `frame2`（时间轴 F2，L58–283）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 20 | 4 MAGIC 忍术/鬼道 | 4 | 2 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 80 | 5 MAGIC_HEAVY 重法 | 8 | 5 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 4 MAGIC 忍术/鬼道 | 4 | 0 | 500 | 0 | false |
| L91 | `k2` | 普攻 2 | 40 | 4 MAGIC 忍术/鬼道 | 6 | 0 | 700 | 0 | false |
| L100 | `k3` | 普攻 3 | 30 | 4 MAGIC 忍术/鬼道 | 7 | 0 | 500 | 0 | false |
| L109 | `k31` | 普攻 31 | 30 | 4 MAGIC 忍术/鬼道 | 7 | 0 | 500 | 0 | false |
| L118 | `k32` | 普攻 32 | 30 | 4 MAGIC 忍术/鬼道 | 7 | 0 | 500 | 0 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 130 | 5 MAGIC_HEAVY 重法 | 8 | -2 | 0 | 1 | false |
| L136 | `kj2` | 空中技 2 / 上攻 | 80 | 3 DA_HEAVY 重打 | 10 | -8 | 600 | 0 | false |
| L145 | `zh1` | 招 1 | 130 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L154 | `zh21` | 招 21 | 50 | 6 KAN_HEAVY 重砍 | 0 | 20 | 500 | 0 | false |
| L163 | `zh2` | 招 2 | 100 | 5 MAGIC_HEAVY 重法 | 0 | -8 | 1000 | 0 | true |
| L172 | `zh3` | 招 3 | 150 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L181 | `bs` | 必杀 | 300 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 0 | 1 | false |
| L190 | `sbs` | 上必杀 | 280 | 5 MAGIC_HEAVY 重法 | 10 | 10 | 0 | 1 | false |
| L199 | `cbs` | 超必杀 | 60 | 5 MAGIC_HEAVY 重法 | 10 | -15 | 0 | 1 | true |
| L208 | `cbs1` | 超必杀前段/多段 | 130 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 1000 | 0 | false |
| L217 | `cbs2` | 超必杀前段/多段 | 60 | 4 MAGIC 忍术/鬼道 | 0 | -3 | 1000 | 0 | true |
| L226 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L235 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L244 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `sh22` | 抓 2 伤害段 | 20 | 2 DA 打 | -3 | -6 | 1000 | 0 | false |
| L262 | `sh23` | 抓 23 | 150 | 5 MAGIC_HEAVY 重法 | 0 | -15 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L271: `$fighter_ctrler.defineBishaFace("石田1", bsface1);` — 登记必杀脸 BitmapData
- L272: `$fighter_ctrler.defineBishaFace("石田2", bsface2);` — 登记必杀脸 BitmapData
- L273: `$fighter_ctrler.defineBishaFace("石田3", bsface3);` — 登记必杀脸 BitmapData
- L274: `$fighter_ctrler.defineHurtSound(snd_hurt1, snd_hurt2);` — 受击语音
- L275: `$fighter_ctrler.defineHurtFlySound(snd_hurtfly);` — 击飞语音
- L276: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L277: `$fighter_ctrler.speed = 10;` — 走速
- L278: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L279: `$fighter_ctrler.heavy = 2;` — 重量
- L280: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L281: `$fighter_ctrler.energy = 150;`
- L282: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
