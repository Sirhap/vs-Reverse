# `gaara_fla.MainTimeline` — 我爱罗 根时间轴

一句话目的：我爱罗 角色 SWF 根时间轴：注入三个 ctrler，在形态帧 `defineAction` 灌 HitVO，登记必杀脸/语音，写 speed/jump/heavy/defenseType，最后 `initMc(this.mc)`。

源文件：`decompiled/fighters/gaara/scripts/gaara_fla/MainTimeline.as`（293 行）

## 如何挂上引擎

可玩角色 SWF 文档类。[`FighterMain.initlize`](../../../../engine/game/bvn/fighter/FighterMain.md)：`new FighterCtrler` → `_mainMc.setFighterCtrler`（本类把 `defineAction` 别名到 ctrler，若源里写了）→ `initFighter` 再 `setEffectCtrler` / `setFighterMcCtrler` → `gotoAndStop(data.startFrame+1)` 跑形态帧。缺 `setFighterCtrler` 会 throw。

门面见 [`FighterCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterCtrler.md)；动作帧里 `parent.$mc_ctrler` 是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)。内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

XML：`gaara startFrame=1`；文件 `assets/fighter/gaara.swf`；comic_type 1 火影。引擎 gotoAndStop(startFrame+1)，1 → 时间轴 F2。

`defenseType=1` 拳防。speed=8 偏慢，heavy=4。必杀脸键名 `我爱罗1`/`我爱罗2`。受击/击飞/死亡共用 `snd_hurt1`。动作 MC 类名 `Timeline_1`。攻击体 `zzzz`（砂缚棺）、`bsmc`（超必）。AI 类名是 `AI_2` 不是 `AI面*`，缺 `kbsmian`（本角色无空必 HitVO）。

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
- L34: `addFrameScript(0, this.frame1, 1, this.frame2);`

#### `setFighterCtrler(param1:*)`（L37–41）

- L39: `$fighter_ctrler = param1;`
- L40: `defineAction = $fighter_ctrler.defineAction;`

#### `setFighterMcCtrler(param1:*)`（L43–46）

- L45: `$mc_ctrler = param1;`

#### `setEffectCtrler(param1:*)`（L48–51）

- L50: `$effect_ctrler = param1;`

### `frame1`（时间轴 F1，L53–56）

- L55: `stop();` — 停时间轴

### `frame2`（时间轴 F2，L58–290）

ctrler 空则 return（`initlize` 先注入再 goto）。随后批量 `defineAction`，再脸/声/数值/`initMc`。

### F2 HitVO

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L64 | `tk` | 跳轻/跳踢 | 40 | 2 DA 打 | 3 | 3 | 400 | 0 | false |
| L73 | `tz` | 跳重 | 100 | 5 MAGIC_HEAVY 重法 | 2 | 6 | 0 | 1 | false |
| L82 | `k1` | 普攻 1 | 30 | 2 DA 打 | 1 | 0 | 300 | 0 | false |
| L91 | `k2` | 普攻 2 | 40 | 2 DA 打 | 1 | -2 | 400 | 0 | false |
| L100 | `k3` | 普攻 3 | 80 | 3 DA_HEAVY 重打 | 10 | 0 | 600 | 0 | false |
| L109 | `kj1` | 空中技 1 / 下攻 | 150 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 500 | 1 | false |
| L118 | `kj2` | 空中技 2 / 上攻 | 150 | 5 MAGIC_HEAVY 重法 | 8 | -7 | 500 | 1 | true |
| L127 | `zh1` | 招 1 | 100 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |
| L136 | `zh2` | 招 2 | 20 | 2 DA 打 | 5 | 0 | 500 | 0 | false |
| L145 | `zh3` | 招 3 | 80 | 3 DA_HEAVY 重打 | 0 | -6 | 700 | 0 | false |
| L154 | `bs1` | 必杀前段/多段 | 10 | 2 DA 打 | 0 | 0 | 800 | 0 | false |
| L163 | `bs` | 必杀 | 330 | 5 MAGIC_HEAVY 重法 | 10 | -5 | 0 | 1 | false |
| L172 | `sbs1` | 上必杀前段/多段 | 10 | 2 DA 打 | 0 | 0 | 800 | 0 | false |
| L181 | `sbs2` | 上必杀前段/多段 | 50 | 3 DA_HEAVY 重打 | 0 | 3 | 800 | 0 | false |
| L190 | `sbs3` | 上必杀前段/多段 | 10 | 2 DA 打 | 0 | 0 | 800 | 0 | false |
| L199 | `sbs` | 上必杀 | 250 | 5 MAGIC_HEAVY 重法 | 0 | 10 | 0 | 1 | false |
| L208 | `cbs` | 超必杀 | 200 | 5 MAGIC_HEAVY 重法 | 5 | -5 | 0 | 1 | false |
| L217 | `cbs3` | 超必杀前段/多段 | 150 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 0 | 1 | true |
| L226 | `cbs2` | 超必杀前段/多段 | 30 | 2 DA 打 | 0 | -1 | 1000 | 0 | false |
| L235 | `cbs1` | 超必杀前段/多段 | 50 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | true |
| L244 | `sh1` | 抓 1（hitType 11） | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L253 | `sh12` | 抓 1 伤害段 | 50 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L262 | `sh2` | 抓 2 | 0 | 11 CATCH 抓 | 0 | 0 | 1000 | 0 | true |
| L271 | `sh22` | 抓 2 伤害段 | 150 | 3 DA_HEAVY 重打 | 15 | -6 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`。字段见 [`HitVO`](../../../../engine/game/bvn/fighter/models/HitVO.md)。

**本帧其它调用**

- L60: `if(!$fighter_ctrler) return;` — 未注入则整帧跳过。
- L280: `$fighter_ctrler.defineBishaFace("我爱罗1", bsface1);` — 登记必杀脸 BitmapData
- L281: `$fighter_ctrler.defineBishaFace("我爱罗2", bsface2);` — 登记必杀脸 BitmapData
- L282: `$fighter_ctrler.defineHurtSound(snd_hurt1);` — 受击语音
- L283: `$fighter_ctrler.defineHurtFlySound(snd_hurt1);` — 击飞语音
- L284: `$fighter_ctrler.defineDieSound(snd_hurt1);` — 死亡语音
- L285: `$fighter_ctrler.speed = 8;` — 走速
- L286: `$fighter_ctrler.jumpPower = 15;` — 跳跃初速
- L287: `$fighter_ctrler.heavy = 4;` — 重量
- L288: `$fighter_ctrler.defenseType = 1;` — 0=斩防 / 1=拳防
- L289: `$fighter_ctrler.initMc(mc);` — 把内部动作 MC 交给 FighterMC
