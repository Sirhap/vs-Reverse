# `obito_fla.MainTimeline` — 宇智波·带土（F2）/ 真面目（F3） 根时间轴

一句话目的：宇智波·带土（F2）/ 真面目（F3） 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/obito/scripts/obito_fla/MainTimeline.as`（739 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler） → `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`obito` sf=1；`obito_s2` sf=2；文件 `assets/fighter/obito.swf`；comic_type 1 火影。同一 SWF 两形态。引擎 gotoAndStop(startFrame+1)：1→F2 面具；2→F3 真面目。

F2 动作类名误作 `樱_1`；F3 误作 `鸣人全动作_14`。**无** `snd_*`。F2 `startWanKai()` + `doWanKai()` 切真面目。拳防。F2 AI 面有多余 `absmian`、缺 `sbsmian`/`kbsmian`。

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
- L34: `addFrameScript(0,frame1,1,frame2,2,frame3);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–333）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`樱_1`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 50 | 1 KAN 砍 | -1 | -2 | 500 | 0 | false |
| L73 | `tk1` | 跳轻段 tk1 | 50 | 6 KAN_HEAVY 重砍 | 5 | 10 | 600 | 1 | false |
| L82 | `k1` | 普攻 1 | 20 | 2 DA 打 | 1 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 30 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L100 | `k3` | 普攻 3 | 40 | 3 DA_HEAVY 重打 | 2 | 0 | 300 | 0 | false |
| L109 | `k4` | 普攻 4 | 40 | 6 KAN_HEAVY 重砍 | 4 | 0 | 400 | 0 | false |
| L118 | `k5` | 普攻 5 | 60 | 3 DA_HEAVY 重打 | 10 | 0 | 0 | 1 | false |
| L127 | `kj1` | 空中技 1 / 下攻 | 50 | 1 KAN 砍 | 3 | 0 | 600 | 0 | false |
| L136 | `kj12` | 空中技 kj12 中段/收段 | 60 | 6 KAN_HEAVY 重砍 | 15 | 0 | 0 | 1 | false |
| L145 | `kj2` | 空中技 2 / 上攻 | 30 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L154 | `zh1` | 招 1 | 30 | 1 KAN 砍 | 0 | -3 | 500 | 0 | false |
| L163 | `zh2` | 招 2 | 130 | 5 MAGIC_HEAVY 重法 | 15 | -3 | 0 | 1 | false |
| L172 | `zh3` | 招 3 | 5 | 2 DA 打 | 0 | -1 | 1000 | 0 | true |
| L181 | `zh31` | 招 zh31 | 13 | 1 KAN 砍 | 0 | -1 | 1000 | 0 | true |
| L190 | `zh32` | 招 zh32 | 13 | 1 KAN 砍 | 5 | -1 | 1000 | 1 | true |
| L199 | `bs` | 必杀 | 20 | 4 MAGIC 忍术/鬼道 | 2 | 0 | 800 | 0 | false |
| L208 | `bs1` | 必杀 bs1 | 30 | 7 FIRE 火 | 5 | 0 | 0 | 1 | false |
| L217 | `sbs` | 上必杀 | 0 | 10 STONE 石化 | 0 | 0 | 1000 | 0 | true |
| L226 | `sbs1` | 上必杀 sbs1 | 30 | 6 KAN_HEAVY 重砍 | 0 | -1 | 1000 | 0 | true |
| L235 | `sbs2` | 上必杀 sbs2 | 10 | 2 DA 打 | 0 | -1 | 1000 | 0 | true |
| L244 | `sbs3` | 上必杀 sbs3 | 90 | 7 FIRE 火 | 18 | -2 | 0 | 1 | true |
| L253 | `sbs4` | 上必杀 sbs4 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L262 | `cbs1` | 超必杀 cbs1 | 100 | 5 MAGIC_HEAVY 重法 | 20 | 0 | 1000 | 0 | false |
| L271 | `cbs` | 超必杀 | 150 | 5 MAGIC_HEAVY 重法 | 20 | -10 | 0 | 1 | true |
| L280 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L289 | `sh12` | 抓伤害段 sh12 | 50 | 0 ? 非表内 | -7 | 2 | 1000 | 0 | false |
| L298 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L307 | `sh22` | 抓伤害段 sh22 | 50 | 6 KAN_HEAVY 重砍 | 0 | 0 | 500 | 0 | false |
| L316 | `sh23` | 抓伤害段 sh23 | 50 | 3 DA_HEAVY 重打 | 15 | -5 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L325: `$fighter_ctrler.defineBishaFace("带土1",bsface1);` — 登记必杀脸 BitmapData
- L326: `$fighter_ctrler.defineBishaFace("带土2",bsface2);` — 登记必杀脸 BitmapData
- L327: `$fighter_ctrler.defineBishaFace("带土3",bsface3);` — 登记必杀脸 BitmapData
- L328: `$fighter_ctrler.speed = 12;` — 走速
- L329: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L330: `$fighter_ctrler.heavy = 3;` — 重量
- L331: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L332: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC

### `frame3`（时间轴 F3，L335–736）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

本帧 `initMc(this.mc)` 的动作 MC 类：`鸣人全动作_14`。

### F3 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L341 | `tk` | 跳轻/跳踢 | 30 | 2 DA 打 | 2 | -3 | 300 | 0 | false |
| L350 | `tk1` | 跳轻段 tk1 | 50 | 3 DA_HEAVY 重打 | 4 | -3 | 300 | 0 | false |
| L359 | `tk3` | 跳轻段 tk3 | 600 | 3 DA_HEAVY 重打 | 10 | -20 | 300 | 1 | true |
| L368 | `tk4` | 跳轻段 tk4 | 0 | 2 DA 打 | 0 | 0 | 30000 | 0 | true |
| L377 | `tz` | 跳重 | 50 | 7 FIRE 火 | 3 | 5 | 400 | 1 | false |
| L386 | `tz1` | 跳重段 tz1 | 16 | 2 DA 打 | -1 | 1 | 400 | 0 | false |
| L395 | `tz2` | 跳重段 tz2 | 30 | 7 FIRE 火 | 8 | 10 | 400 | 1 | true |
| L404 | `k1` | 普攻 1 | 20 | 2 DA 打 | 2 | 0 | 300 | 0 | false |
| L413 | `k2` | 普攻 2 | 20 | 2 DA 打 | 3 | 0 | 300 | 0 | false |
| L422 | `k3` | 普攻 3 | 50 | 3 DA_HEAVY 重打 | 8 | 0 | 400 | 0 | false |
| L431 | `k4` | 普攻 4 | 50 | 3 DA_HEAVY 重打 | 4 | 0 | 400 | 0 | false |
| L440 | `k5` | 普攻 5 | 80 | 5 MAGIC_HEAVY 重法 | 12 | 0 | 0 | 1 | false |
| L449 | `kj1` | 空中技 1 / 下攻 | 80 | 6 KAN_HEAVY 重砍 | 3 | 0 | 500 | 0 | false |
| L458 | `kj12` | 空中技 kj12 中段/收段 | 80 | 6 KAN_HEAVY 重砍 | 10 | -3 | 0 | 1 | false |
| L467 | `kj2` | 空中技 2 / 上攻 | 40 | 1 KAN 砍 | 0 | -8 | 500 | 0 | false |
| L476 | `kj13` | 空中技 kj13 中段/收段 | 30 | 10 STONE 石化 | 0 | 0 | 40000 | 0 | false |
| L485 | `kj14` | 空中技 kj14 中段/收段 | 850 | 5 MAGIC_HEAVY 重法 | 20 | -20 | 400 | 1 | true |
| L494 | `zh1` | 招 1 | 20 | 0 ? 非表内 | -15 | 0 | 500 | 0 | false |
| L503 | `zh11` | 招 zh11 | 50 | 7 FIRE 火 | 6 | -3 | 500 | 1 | false |
| L512 | `zh12` | 招 zh12 | 20 | 2 DA 打 | 0 | 0 | 5000 | 0 | true |
| L521 | `zh13` | 招 zh13 | 30 | 4 MAGIC 忍术/鬼道 | 0 | -5 | 5000 | 0 | false |
| L530 | `zh14` | 招 zh14 | 620 | 5 MAGIC_HEAVY 重法 | 2 | -50 | 500 | 1 | false |
| L539 | `zh2` | 招 2 | 50 | 5 MAGIC_HEAVY 重法 | 50 | 0 | 300 | 1 | true |
| L548 | `zh21` | 招 zh21 | 0 | 0 ? 非表内 | 33 | 0 | 3000 | 0 | false |
| L557 | `zh22` | 招 zh22 | 0 | 0 ? 非表内 | 10 | 0 | 30000 | 0 | false |
| L566 | `zh23` | 招 zh23 | 0 | 0 ? 非表内 | -33 | 0 | 3000 | 0 | false |
| L575 | `zh3` | 招 3 | 100 | 7 FIRE 火 | 3 | -9 | 700 | 0 | false |
| L584 | `zh33` | 招 zh33 | 90 | 7 FIRE 火 | 10 | -8 | 0 | 1 | false |
| L593 | `bs` | 必杀 | 80 | 5 MAGIC_HEAVY 重法 | 15 | 15 | 0 | 1 | false |
| L602 | `bs1` | 必杀 bs1 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 4000 | 0 | false |
| L611 | `sbs1` | 上必杀 sbs1 | 5 | 2 DA 打 | 0 | 0 | 5000 | 0 | false |
| L620 | `sbs` | 上必杀 | 200 | 5 MAGIC_HEAVY 重法 | 10 | -10 | 0 | 1 | false |
| L629 | `bs2` | 必杀 bs2 | 30 | 2 DA 打 | 3 | -3 | 4000 | 0 | false |
| L638 | `bs3` | 必杀 bs3 | 50 | 3 DA_HEAVY 重打 | 7 | 7 | 4000 | 0 | false |
| L647 | `bs4` | 必杀 bs4 | 60 | 6 KAN_HEAVY 重砍 | 5 | -5 | 4000 | 0 | false |
| L656 | `cbs2` | 超必杀 cbs2 | 10 | 4 MAGIC 忍术/鬼道 | 5 | 0 | 3000 | 0 | false |
| L665 | `cbs1` | 超必杀 cbs1 | 150 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 3000 | 0 | false |
| L674 | `cbs` | 超必杀 | 400 | 5 MAGIC_HEAVY 重法 | 30 | -10 | 0 | 1 | true |
| L683 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L692 | `sh12` | 抓伤害段 sh12 | 50 | 0 ? 非表内 | -8 | 0 | 1000 | 0 | false |
| L701 | `sh2` | 抓 2（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L710 | `sh22` | 抓伤害段 sh22 | 70 | 3 DA_HEAVY 重打 | 8 | 0 | 500 | 0 | false |
| L719 | `sh23` | 抓伤害段 sh23 | 80 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L337: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L728: `$fighter_ctrler.defineBishaFace("带土1",bsface1);` — 登记必杀脸 BitmapData
- L729: `$fighter_ctrler.defineBishaFace("带土2",bsface2);` — 登记必杀脸 BitmapData
- L730: `$fighter_ctrler.defineBishaFace("带土3",bsface3);` — 登记必杀脸 BitmapData
- L731: `$fighter_ctrler.speed = 13;` — 走速
- L732: `$fighter_ctrler.jumpPower = 16;` — 跳跃初速
- L733: `$fighter_ctrler.heavy = 3;` — 重量
- L734: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L735: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
