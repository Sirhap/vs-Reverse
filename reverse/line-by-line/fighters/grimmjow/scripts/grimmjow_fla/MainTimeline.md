# `grimmjow_fla.MainTimeline` — 葛力姆乔·贾卡杰克 根时间轴

一句话目的：葛力姆乔·贾卡杰克 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/grimmjow/scripts/grimmjow_fla/MainTimeline.as`（281 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler，若源里写了）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`grimmjow startFrame=1`；文件 `assets/fighter/grimmjow.swf`；comic_type 0 死神。引擎 gotoAndStop(startFrame+1)，1 → 时间轴 F2。

本类 **没有** `defineAction` 别名，形态帧直接 `$fighter_ctrler.defineAction`。**未写** `defenseType` → 默认 0 斩防。speed=12。必杀脸 `葛力姆乔1..3`。受击 `snd_hurt4,snd_hurt3`，击飞 `snd_hurt1,snd_hurt2`，死亡 `snd_die`。动作 MC 类名误作 `一护全动作_1`（一护 FLA 模板残留）。有空必 `kbs`/`kbs1`，无上必；AI 面有 `kbsmian`、缺 `sbsmian`。

HitVO 字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用

### 函数

#### `MainTimeline()`（L29–33）

- L31: `super();`
- L32: `addFrameScript(0, this.frame1, 1, this.frame2);`

#### `setFighterCtrler(param1:*)`（L35–38）

- L37: `$fighter_ctrler = param1;`

#### `setFighterMcCtrler(param1:*)`（L40–43）

- L42: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L45–48）

- L47: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L50–53）

- L52: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L55–278）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L61 | `tk` | 跳轻/跳踢 | 40 | 3 DA_HEAVY 重打 | 2 | -5 | 400 | 0 | false |
| L70 | `tz` | 跳重 | 70 | 3 DA_HEAVY 重打 | 5 | 15 | 300 | 1 | false |
| L79 | `k1` | 普攻 1 | 30 | 2 DA 打 | 1 | 0 | 300 | 0 | false |
| L88 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L97 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 6 | 0 | 400 | 0 | false |
| L106 | `k4` | 普攻 4 | 70 | 6 KAN_HEAVY 重砍 | 6 | -8 | 500 | 0 | false |
| L115 | `kj1` | 空中技 1 / 下攻 | 15 | 1 KAN 砍 | 1 | 0 | 300 | 0 | false |
| L124 | `kj2` | 空中技 2 / 上攻 | 120 | 6 KAN_HEAVY 重砍 | 2 | -5 | 0 | 1 | false |
| L133 | `zh1` | 招 1 | 120 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L142 | `zh2` | 招 2 | 100 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | true |
| L151 | `zh31` | 招 3 分支/击飞 | 20 | 2 DA 打 | 0 | 0 | 500 | 0 | false |
| L160 | `zh3` | 招 3 | 80 | 6 KAN_HEAVY 重砍 | 5 | 15 | 0 | 1 | false |
| L169 | `sh1` | 抓 1（hitType 11） | 10 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L178 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 6 | 0 | 1000 | 0 | false |
| L187 | `sh2` | 抓 2 | 10 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L196 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 5 | 10 | 0 | 1 | false |
| L205 | `bs` | 必杀 | 300 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | false |
| L214 | `kbs` | 空必杀 | 20 | 1 KAN 砍 | 8 | 8 | 500 | 0 | false |
| L223 | `kbs1` | 空必杀变体 | 200 | 5 MAGIC_HEAVY 重法 | 8 | -4 | 0 | 1 | false |
| L232 | `cbs1` | 超必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 0 | 20 | 1000 | 0 | false |
| L241 | `cbs` | 超必杀 | 150 | 5 MAGIC_HEAVY 重法 | 0 | 0 | 1000 | 0 | false |
| L250 | `cbs2` | 超必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 0 | -1 | 1000 | 0 | false |
| L259 | `cbs3` | 超必杀前段/多段 | 30 | 4 MAGIC 忍术/鬼道 | 10 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L57: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L268: `$fighter_ctrler.defineBishaFace("葛力姆乔1", bsface1);` — 登记必杀脸 BitmapData
- L269: `$fighter_ctrler.defineBishaFace("葛力姆乔2", bsface2);` — 登记必杀脸 BitmapData
- L270: `$fighter_ctrler.defineBishaFace("葛力姆乔3", bsface3);` — 登记必杀脸 BitmapData
- L271: `$fighter_ctrler.defineHurtSound(snd_hurt4, snd_hurt3);` — 受击语音
- L272: `$fighter_ctrler.defineHurtFlySound(snd_hurt1, snd_hurt2);` — 击飞语音
- L273: `$fighter_ctrler.defineDieSound(snd_die);` — 死亡语音
- L274: `$fighter_ctrler.speed = 12;` — 走速
- L275: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L276: `$fighter_ctrler.heavy = 3;` — 重量
- L277: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
