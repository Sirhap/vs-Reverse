# `sasuke_xz_old_fla.MainTimeline` — 宇智波·佐助 须佐能乎（旧档） 根时间轴

一句话目的：宇智波·佐助 须佐能乎（旧档） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/sasuke_xz_old/scripts/sasuke_xz_old_fla/MainTimeline.as`（374 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：**不在** 现行 `fighter.xml`（包内遗留 `assets/fighter/sasuke_xz_old.swf`，与 `sasuke_xz` 同构旧档）。选人表不会加载本 SWF，但文档类仍是可玩角色骨架。comic_type 按须佐能乎同款 1 火影。引擎若强行 `new FighterMain(mc)` 仍 `gotoAndStop(startFrame+1)`；本时间轴只有 F1 `stop` + F2 灌招。

F2：speed=12 / jump=17 / heavy=3 / 拳防。必杀脸：`须佐助1`←`bsface1`、`须佐助2`←`bsface2`。语音：`defineHurtSound(snd_hurt1)`；`defineHurtFlySound(snd_hurt1)`；`defineDieSound(snd_hurt1)`。
遗留 SWF，不在现行 `fighter.xml`；动作 MC 类名 `Timeline_1`。必杀脸键与现行须佐能乎同为 `须佐助1/2`，但动作里还有一次 `bisha(..., "佐助1")`（? 该键未 `defineBishaFace`）。

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

### `frame2`（时间轴 F2，L58–371）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 8 | -5 | 400 | 0 | false |
| L73 | `tk2` | 跳轻 段2 | 40 | 3 DA_HEAVY 重打 | 4 | 10 | 500 | 0 | false |
| L82 | `tk1` | 跳轻 段1 | 100 | 3 DA_HEAVY 重打 | 10 | -3 | 0 | 1 | false |
| L91 | `tz` | 跳重 | 150 | 9 ELECTRIC 雷 | 5 | 0 | 0 | 1 | false |
| L100 | `k1` | 普攻 1 | 20 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L109 | `k2` | 普攻 2 | 20 | 1 KAN 砍 | 4 | 0 | 400 | 0 | false |
| L118 | `k3` | 普攻 3 | 50 | 9 ELECTRIC 雷 | 6 | -2 | 500 | 0 | false |
| L127 | `k4` | 普攻 4 | 60 | 9 ELECTRIC 雷 | 4 | 2 | 400 | 0 | false |
| L136 | `k5` | 普攻 5 | 80 | 9 ELECTRIC 雷 | 8 | -4 | 700 | 1 | false |
| L145 | `kj1` | 空中技 1 / 下攻 | 70 | 3 DA_HEAVY 重打 | 10 | 0 | 700 | 0 | false |
| L154 | `kj12` | 空中技 12 | 30 | 1 KAN 砍 | 5 | 0 | 400 | 0 | false |
| L163 | `kj13` | 空中技 13 | 100 | 9 ELECTRIC 雷 | 10 | 0 | 0 | 1 | false |
| L172 | `kj21` | 空中技 21 | 30 | 2 DA 打 | 3 | -1 | 400 | 0 | false |
| L181 | `kj22` | 空中技 22 | 30 | 2 DA 打 | 4 | -1 | 400 | 0 | false |
| L190 | `kj2` | 空中技 2 / 上攻 | 50 | 3 DA_HEAVY 重打 | 8 | -10 | 800 | 0 | false |
| L199 | `zh1` | 招 1 | 150 | 9 ELECTRIC 雷 | 15 | 0 | 0 | 1 | false |
| L208 | `zh2` | 招 2 | 10 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L217 | `zh21` | 招 21 | 60 | -1 ? | 0 | 0 | 1000 | 0 | false |
| L226 | `zh22` | 招 22 | 10 | -1 ? | 10 | -10 | 0 | 1 | false |
| L235 | `zh3` | 招 3 | 150 | 9 ELECTRIC 雷 | 10 | -10 | 0 | 1 | false |
| L244 | `bs2` | 必杀前段/多段 | 25 | 2 DA 打 | 0 | 0 | 500 | 0 | false |
| L253 | `bs` | 必杀 | 50 | 7 FIRE 火 | 10 | -10 | 0 | 1 | false |
| L262 | `sbs` | 上必杀 | 300 | 7 FIRE 火 | 20 | 0 | 0 | 1 | false |
| L271 | `kbs` | 空必杀 | 50 | 4 MAGIC 忍术/鬼道 | 8 | 4 | 600 | 0 | false |
| L280 | `kbs2` | 空必杀 2 | 150 | 7 FIRE 火 | 15 | 0 | 0 | 1 | false |
| L289 | `cbs3` | 超必杀前段/多段 | 30 | 6 KAN_HEAVY 重砍 | 60 | 0 | 1000 | 0 | false |
| L298 | `cbs1` | 超必杀前段/多段 | 30 | 1 KAN 砍 | 60 | 0 | 1000 | 0 | false |
| L307 | `cbs2` | 超必杀前段/多段 | 50 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L316 | `cbs` | 超必杀 | 100 | 7 FIRE 火 | 30 | -20 | 0 | 1 | true |
| L325 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L334 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | -5 | 1000 | 0 | false |
| L343 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L352 | `sh22` | 抓 2 伤害段 | 150 | 9 ELECTRIC 雷 | 10 | -10 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler){return;}` — 未注入则整帧跳过
- L361: `$fighter_ctrler.defineBishaFace("须佐助1", bsface1);` — 登记必杀脸 BitmapData
- L362: `$fighter_ctrler.defineBishaFace("须佐助2", bsface2);` — 登记必杀脸 BitmapData
- L363: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L364: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L365: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L366: `$fighter_ctrler.speed = 12;` — 走速
- L367: `$fighter_ctrler.jumpPower = 17;` — 跳跃初速
- L368: `$fighter_ctrler.heavy = 3;` — 重量
- L369: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L370: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
