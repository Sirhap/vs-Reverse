# `kakashi_sw_fla.MainTimeline` — 旗木·卡卡西 神威 根时间轴

一句话目的：旗木·卡卡西 神威 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/kakashi_sw/scripts/kakashi_sw_fla/MainTimeline.as`（420 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`kakashi_sw startFrame=1`；文件 `assets/fighter/kakashi_sw.swf`；comic_type 1 火影。引擎 `gotoAndStop(startFrame+1)`，1 → 时间轴 F2。

数值：speed=12 / jump=16 / heavy=3 / 拳防。本形态 **未** `defineBishaFace`（库里也可能没有 `bsface*`）。语音：`defineHurtSound()` / `Fly` / `Die` **无参**（库里仍导出了 `snd_*`，但没把 Class 交给 voice ctrler，? 受击无声）。动作 MC 类名 `人物全动作_1`。`defenseType` 拳防。

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
| L31 | `yh` | `*` | 运行时缓存/标志

### 函数

#### `MainTimeline()`（L33–37）

- L35: `super();`
- L36: `addFrameScript(0,frame1,1,frame2);`

#### `setFighterCtrler(param1:*)`（L39–43）

- L41: `$fighter_ctrler = param1;`
- L42: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L45–48）

- L47: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L50–53）

- L52: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L55–58）

- L57: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L60–417）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L66 | `tk` | 跳轻/跳踢 | 20 | 1 KAN 砍 | 1 | 0 | 400 | 0 | false |
| L75 | `tk2` | 跳轻 2 | 30 | 3 DA_HEAVY 重打 | -4 | -7 | 400 | 0 | false |
| L84 | `tk3` | 跳轻 3 | 60 | 3 DA_HEAVY 重打 | 5 | -9 | 400 | 1 | false |
| L93 | `tz` | 跳重 | 40 | 1 KAN 砍 | 2 | 2 | 400 | 0 | false |
| L102 | `tz2` | 跳重 段2 | 40 | 6 KAN_HEAVY 重砍 | 4 | 4 | 300 | 1 | false |
| L111 | `k1` | 普攻 1 | 40 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L120 | `k2` | 普攻 2 | 40 | 1 KAN 砍 | 2 | 0 | 400 | 0 | false |
| L129 | `k22` | 普攻 2 段2/击飞 | 40 | 2 DA 打 | 2 | -1 | 400 | 0 | false |
| L138 | `k3` | 普攻 3 | 40 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L147 | `k4` | 普攻 4 | 50 | 3 DA_HEAVY 重打 | 3 | -3 | 400 | 0 | false |
| L156 | `k5` | 普攻 5 | 50 | 3 DA_HEAVY 重打 | 5 | -15 | 900 | 0 | true |
| L165 | `kj9` | 空中技 9 | 80 | 4 MAGIC 忍术/鬼道 | 8 | 0 | 0 | 0 | true |
| L174 | `kj99` | 空中技 9 段9 | 80 | 5 MAGIC_HEAVY 重法 | 8 | 0 | 0 | 1 | true |
| L183 | `kj1` | 空中技 1 / 下攻 | 60 | 9 ELECTRIC 雷 | 0 | 0 | 600 | 0 | false |
| L192 | `kj12` | 空中技 1 收段 | 40 | 3 DA_HEAVY 重打 | 0 | -3 | 800 | 0 | false |
| L201 | `kj6` | 空中技 6 | 20 | 8 ICE 冰 | 1 | 0 | 100 | 1 | false |
| L210 | `kj2` | 空中技 2 / 上攻 | 50 | 6 KAN_HEAVY 重砍 | 0 | 7 | 800 | 1 | false |
| L219 | `kj26` | 空中技 2 段6 | 70 | 5 MAGIC_HEAVY 重法 | 5 | -5 | 500 | 1 | false |
| L228 | `kj27` | 空中技 2 段7 | 0 | 0 | 0 | 0 | 500 | 0 | false |
| L237 | `zh1` | 招 1 | 40 | 1 KAN 砍 | 3 | 0 | 400 | 0 | false |
| L246 | `zh12` | 招 1 段2 | 40 | 6 KAN_HEAVY 重砍 | 3 | 0 | 300 | 1 | false |
| L255 | `zh2` | 招 2 | 50 | 11 CATCH 抓 | 0 | 0 | 900 | 0 | true |
| L264 | `zh3` | 招 3 | 40 | 3 DA_HEAVY 重打 | 3 | 0 | 400 | 0 | false |
| L273 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L282 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L291 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L300 | `sh22` | 抓 2 伤害段 | 150 | 6 KAN_HEAVY 重砍 | -1 | -8 | 0 | 1 | false |
| L309 | `bs` | 必杀 | 250 | 9 ELECTRIC 雷 | 0 | -10 | 300 | 1 | false |
| L318 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L327 | `sbs0` | 上必杀前段/多段 | 10 | 11 CATCH 抓 | 0 | 0 | 2000 | 0 | true |
| L336 | `sui` | 水遁（? 查克拉性质 id） | 250 | 8 ICE 冰 | 5 | -5 | 0 | 1 | false |
| L345 | `tu` | 土遁（? 查克拉性质 id） | 180 | 5 MAGIC_HEAVY 重法 | 5 | -10 | 0 | 1 | false |
| L354 | `huo` | 火遁（? 查克拉性质 id） | 300 | 7 FIRE 火 | 5 | 5 | 0 | 1 | false |
| L363 | `cbs1` | 超必杀前段/多段 | 100 | 6 KAN_HEAVY 重砍 | 0 | 0 | 1000 | 0 | false |
| L372 | `cbs2` | 超必杀前段/多段 | 10 | 1 KAN 砍 | 3 | 0 | 1000 | 0 | true |
| L381 | `cbs3` | 超必杀前段/多段 | 10 | 1 KAN 砍 | -3 | 0 | 1000 | 0 | true |
| L390 | `cbs4` | 超必杀前段/多段 | 300 | 9 ELECTRIC 雷 | 10 | 0 | 1000 | 1 | true |
| L399 | `leiqiebaozha` | 雷切爆炸（? 独立 id） | 300 | 9 ELECTRIC 雷 | 0 | 0 | 5 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L62: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L408: `$fighter_ctrler.defineHurtSound();` — 受击语音
- L409: `$fighter_ctrler.defineHurtFlySound();` — 击飞语音
- L410: `$fighter_ctrler.defineDieSound();` — 死亡语音
- L411: `$fighter_ctrler.speed = 12;` — 走速
- L412: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L413: `$fighter_ctrler.heavy = 3;` — 重量
- L414: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L415: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
- L416: `yh = 0;` — 记下引用/标志
