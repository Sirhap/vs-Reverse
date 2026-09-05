# `killerbee_fla.MainTimeline` — 奇拉比 根时间轴

一句话目的：奇拉比 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/killerbee/scripts/killerbee_fla/MainTimeline.as`（299 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`killerbee startFrame=1`；文件 `assets/fighter/killerbee.swf`；comic_type 1 火影。 引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

F2：speed=11 / jump=16 / heavy=5 / 拳防。 必杀脸："奇拉比1",bsface1；"奇拉比2",bsface2。 本帧未调 `defineHurtSound*`。

动作 MC 类名 `八尾人柱力全动作_1`。 本角色 **没有** `snd_*`，也不调 `defineHurtSound*`。

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

### `frame2`（时间轴 F2，L58–296）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 3 DA_HEAVY 重打 | 4 | 10 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 30 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L82 | `tz1` | 跳重 段1 | 30 | 1 KAN 砍 | 8 | 0 | 0 | 1 | false |
| L91 | `k1` | 普攻 1 | 20 | 2 DA 打 | 3 | 0 | 200 | 0 | false |
| L100 | `k2` | 普攻 2 | 30 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L109 | `k3` | 普攻 3 | 40 | 1 KAN 砍 | 4 | 0 | 500 | 0 | false |
| L118 | `k4` | 普攻 4 | 80 | 6 KAN_HEAVY 重砍 | 1 | -6 | 600 | 1 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 30 | 1 KAN 砍 | 5 | 0 | 500 | 0 | false |
| L136 | `kj21` | 空中技 2 段1 | 60 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L145 | `kj22` | 空中技 2 段2 | 60 | 1 KAN 砍 | 10 | -8 | 500 | 0 | false |
| L154 | `kj2` | 空中技 2 / 上攻 | 80 | 6 KAN_HEAVY 重砍 | 15 | -7 | 0 | 1 | false |
| L163 | `zh1` | 招 1 | 40 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 700 | 0 | false |
| L172 | `zh2` | 招 2 | 180 | 9 ELECTRIC 雷 | 10 | 0 | 0 | 1 | true |
| L181 | `zh3` | 招 3 | 140 | 6 KAN_HEAVY 重砍 | 6 | -6 | 0 | 1 | false |
| L190 | `bs1` | 必杀前段/多段 1 | 80 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L199 | `bs2` | 必杀前段/多段 2 | 30 | 2 DA 打 | 3 | 0 | 1000 | 0 | false |
| L208 | `bs3` | 必杀前段/多段 3 | 80 | 3 DA_HEAVY 重打 | 4 | 0 | 1000 | 0 | false |
| L217 | `bs` | 必杀 | 80 | 3 DA_HEAVY 重打 | 3 | 10 | 0 | 1 | false |
| L226 | `sbs` | 上必杀 | 280 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L235 | `cbs1` | 超必杀前段/多段 1 | 35 | 4 MAGIC 忍术/鬼道 | 5 | -0.2 | 1000 | 0 | false |
| L244 | `cbs` | 超必杀 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | true |
| L253 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L262 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L271 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L280 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | 20 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L289: `$fighter_ctrler.defineBishaFace("奇拉比1",bsface1);` — 登记必杀脸 BitmapData
- L290: `$fighter_ctrler.defineBishaFace("奇拉比2",bsface2);` — 登记必杀脸 BitmapData
- L291: `$fighter_ctrler.speed = 11;` — 走速
- L292: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L293: `$fighter_ctrler.heavy = 5;` — 重量
- L294: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L295: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
