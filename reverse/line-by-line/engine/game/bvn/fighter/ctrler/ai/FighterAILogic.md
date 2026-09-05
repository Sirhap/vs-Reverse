# `fighter.ctrler.ai.FighterAILogic` — CPU 招式/走位决策

一句话目的：每动画帧给 `FighterAICtrl` 填一套与 `IFighterActionCtrl` 同名的布尔，决定靠近、跳、冲、防、普攻、技能、必杀、抓、助战、爆气、鬼步。难度骰子与目标 `actionState` 查表见基类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogic.as`（582 行）

## Callers / callees

- **唯一调用**：`FighterAICtrl`。`initlize` `new FighterAILogic(AILevel, fighter)`；`renderAnimate` → `render()`；各 `moveLEFT/attack/bisha/…` 直接读对应 public 字段。
- **难度**：`ConfigVO.AI_level`（设置 COM LEVEL 1–6）→ `GameData.I.config` → `MessionModel.AI_LEVEL` → `GameCtrl.addFighter` 赋给 `FighterAICtrl.AILevel`。VS CPU / 街机 P2 才走本类；练习 P2 是键控。
- **Callees**：基类 `getAIByFighterState/getAIResult/getTargetDistance/targetInRange/targetCanBeHit/isBreakAct/isHitDownAct/addContOrder`；`FighterAction` 开关；`FighterMain.getTargets/energy/qi/hp/direct/actionState`；`Bullet.isAttacking`、`FighterAttacker.isAttacking`、`Assister.isAttacking`。
- **不实现**：`jumpQuick`、`waiKai*`（`FighterAICtrl` 恒 false）。`specailSkill` 接口读的是本类 `specialSkill`。`ghostJumpDown` 读 `ghostJumpDowm`。

## 命名备注

- `defult`：缺 `a` 的 default 键，与基类一致。
- `ghostJumpDowm`：Down 拼成 Dowm。
- `downJump`：字段名像「下跳」，但 `FighterAICtrl.dashJump()` 读它（受击落地起身），真正下平台是 `jumpDown`。
- `_catchMoveKeep`：抓接近距离 15，普通接近 `_moveKeep=40`。
- 招式面字符串与 `FighterHitRange` 相同：`kanmian/tkanmian/kj1mian/kj2mian/zh1mian/zh2mian/zh3mian/tzmian/bsmian/sbsmian/cbsmian/kbsmian`。hit id 前缀 `kj1/kj2/zh1/zh2/zh3/tz/bs/sbs/cbs/kbs` 给 `getHitVOLike`。
- `_defenseFrame`：**声明从未使用**。

## 决策树（每动画帧）

`render` = `super.render()`（目标 + `updateActionAI` + 连招仲裁）再跑走位/跳/受击起身/防御/爆气/鬼步。

`updateActionAI` 顺序：冲 → 普攻 → 六技能 → 四必杀 → 抓 → 助战。这些布尔经 `_contOrder` **只留 order 最高的一条**（连招中才 `addContOrder`）。

走位/跳/防御/爆气/鬼步 **不进** 仲裁，可与进攻同时 true，由 `FighterMcCtrler` 按当前 MC 状态选谁生效。

**进攻门槛（共性）**：`_fighterAction.xxx` 为 true（MC 允许出这招）+ `targetCanBeHit` + `targetInRange(对应面)` + 按目标 state 掷骰。必杀额外 `qi >= 阈值`。

**连招 order（降序留一条）**：`砍1` 续斩 200；空中必杀 210；超必杀 200；抓1 150；抓2 110；非击倒技能 110；必杀/上必杀 100；击倒技能/普攻 10。非连招时普攻 order 300 但只有 `_isConting` 才登记，故非连招多招可同时 true。

**粘滞（?）**：`specialSkill`、`ghostStep` 早退路径不置 false，一旦变 true 可能一直保持到对象销毁。`ghostJump`/`ghostJumpDowm` 同样。

## 逐行说明

### 字段（L14–76）

走位：`moveLeft/moveRight/jump/jumpDown/dash/downJump/defense`。

常量：`_moveKeep=40`、`_catchMoveKeep=15`、`_dashKeep=200`、`_jumpKeep=50`。

进攻：`attack/attackAIR/skillAIR/bishaAIR/skill1/skill2/zhao1/zhao2/zhao3/catch1/catch2/bisha/bishaUP/bishaSUPER/assist/specialSkill/ghostStep/ghostJump/ghostJumpDowm`。

计时：`_moveFrame`（接近决策冷却）、`_defenseFrame`（未用）。

### 构造（L78–81）

`super(AILevel, fighter)`。

### `render`（L83–97）

`super.render()`。无 `_fighter` 或无 `_target` 则后面全跳（本帧进攻已在 super 里算过）。然后：`updateMoveAI` → `updateJumpAI` → `updateJumpDownAI` → `updateHurtAI` → `updateDefenseAI` → `updateSpecialSkill` → `updateGhostStep`。

### `updateActionAI`（L99–107）

`updateDashAI` → `updateAttackAI` → `updateSkill` → `updateBisha` → `updateCache`（抓）→ `updateAssist`。在基类 `updateContOrder` 之前。

### `updateHurtAI`（L109–117）

先 `downJump=false`。rate：`defult [0,0,0.2,1,3,5]`（高难度更常起身）；目标 11/12/13 全 0。结果写入 `downJump` → `FighterAICtrl.dashJump` → `McCtrler.renderHurtFlying` 里 `doHurtDownJump`（落地 20 帧窗）。看的是 **目标** state，自己倒地时若对方在放技能则不起身。

### `updateMoveAI`（L119–189）

先清左右。

**自己在防御（state 20）**：`getAIResult(1,2,4,5,6,8)` 成功则向目标 x±1 走（贴身）。然后 **return**，不做后面的接近逻辑。

**否则**：`_moveFrame < FPS_GAME`（默认 60 帧）则强制 `_loc3_=true` 并累加；到期后按目标 state 掷骰，成功则 `_moveFrame=0` 重新数。rate：`defult [3,5,7,8,9,10]`（高难几乎每秒都走）；目标 10 攻 `[2,4,5,3,1,0]` 高难反而不追；11 `[2,4,3,2,0,0]`；12/13 必杀 `[2,1,0,0,0,0]`。

`_loc3_` 真：与目标 x 差超过 keep（抓中 15 否则 40）则朝目标走。

若最终左右都 false：把 `_moveFrame` 拉满（立刻重新掷），若 **朝向与目标相同**（同向，即目标在背后）则朝目标 x 走——转身贴人。

### `updateJumpAI`（L191–214）

三分支：

1. **连招中**：`defult [1,2,3,2,1,0]`（中档最多）；目标 21 受击 `[0,1,2,3,3,4]`（高难追击打浮空）。成功则 `addContOrder("jump",10)`。基类 `this["jump"]=false` 能清这个字段，但 jump 在仲裁 **之后** 才赋值，本帧 order 登记对 jump **无效**（? 残留）。
2. **自己 y > 目标 y + 50**（自己在下方）：`defult [2,3,4,5,6,6]` 积极上跳；对方 12/13 必杀时压到 `[2,1,0,0,0,0]`。
3. **否则** 几乎不跳：`[0.01,0,…]`，必杀中 `[0.02,0,…]`。

### `updateJumpDownAI`（L216–230）

自己比目标高超过 50：与「在下方就跳」对称的高难下跳率 `[2,3,4,5,6,6]`，对方必杀时降低。否则极低。→ `jumpDown`（下平台）。

### `updateDashAI`（L232–264）

`dx = getTargetDistance.x`；`dir = 目标在右 ? 1 : -1`。

- **energy < 40**（冲不动）：仅当 `dx > 200` 且自己朝向目标，`defult` 极低、目标 10/11 略升、12/13 为 0；近距离几乎不冲。
- **energy≥40 且 dx>200 且自己朝向 ≠ 目标朝向**（面对面、够远）：`defult [0.5,1,2,5,7,9]` 高难猛冲；对方在攻击/技能时压低；必杀中 0。
- **否则**：接近不冲，高难也接近 0。

### `updateDefenseAI`（L266–342）

**已在防御**：用高保持率续防 `defult` 全 10；目标 40 冻结降到 `[5,4,3,2,1]`；idle 0 很快松手；目标 21/22/23 受击/倒地强制 0。续上则 return。

**否则** 看目标距离：`defult` 全 0（idle 不防）。目标 10 攻击：近（dx&dy<100）`[0.5,1,3,5,7,9]`，远则高难回落 `[0.5,1,3,2,1,0]`。目标 11 技能全档积极 `[1,3,5,7,9,10]`。12/13 必杀 `[2,4,6,8,10,10]`。成功 return。

**再扫** `_fighter.getTargets()` 里 **非主目标** 的威胁：

- `Bullet.isAttacking()`：近（200×150）`getAIResult(2,4,5,7,9,10)`，远 `(2,4,5,5,2,1)`。
- `FighterAttacker.isAttacking`：`(2,4,5,7,9,10)`，不看距离。
- `Assister.isAttacking`：`(2,4,6,8,10,10)`。

任一成功即 return。主目标的子弹不走这分支（`!= _target`）。

### `updateAttackAI`（L344–393）

先 `attack=attackAIR=false`。MC 不允许 `attack` 且不允许 `attackAIR` 则 return。目标不可打 return。

rate：连招中 `defult [1,2,3,6,9,10]` 否则 `[0.5,1,4,6,8,10]`。目标 20 防御降；16 受击反击动作更低；10 对方也在打接近 0；11/12/13 全 0（不普攻换必杀）。

骰失败 return。

**连招中**：`attack=true`；`attackAIR = 自己 y < 目标 y`（自己在上才空砍）。当前动作名 `"砍1"` 则 order=200（续光斩），否则 10。

**非连招**：`attack = targetInRange("kanmian")`；`attackAIR = tkanmian 且自己在上`。order=300（不登记，因为 `addContOrder` 仍在 `if(_isConting)` 外的 attack 分支里——非连招也会 `addContOrder`！看代码：`if(attack) addContOrder("attack", _loc3_)` **不**包在 `_isConting` 里。非连招 order=300，会把同帧技能/必杀/抓全部清掉。高难非连招一旦砍中面，其它招全灭）。

### `updateSkill`（L395–403）

六个：`skill1/kj1/kj1mian`、`skill2/kj2/kj2mian`、`zhao1/zh1/zh1mian`、`zhao2/zh2/zh2mian`、`zhao3/zh3/zh3mian`、`skillAIR/tz/tzmian`。皆 `FighterAction` 开且 `getSkillAI(..., 10)`。无 `zhaoAIR`。

### `getSkillAI`（L405–431）

`param1` 字段名（登记 order 用）、`param2` hit 前缀、`param3` 招式面、`param4` 基础 order。

若 `isBreakAct(prefix)`（该前缀 HitVO 有破防）：连招中高难几乎必出 `[0.1,0.2,0.5,3,6,10]`，非连招高难反而降；对方防御 20 时连招更想破防。

非破防：连招中低档接近 0、高档到 10；对方防御时 `[0,0,1,1,0,0]` 只中档碰一下。

共用：目标 16 `[0.5,1,0.5,0,0,0]`；10 对方攻击时高难才 `[0,0,0,1,1,2]`；11/12/13 为 0。

最终 AND `targetCanBeHit` AND `targetInRange(面)`。连招成功则 `addContOrder(id, isHitDownAct ? 10 : 110)`——**非击倒技能优先续连，击倒技让路**。

### `updateBisha`（L433–439）

**public**（基类其它 update 都是 private）。四招：`bisha/bs/bsmian` qi100 order100；`bishaUP/sbs/sbsmian` qi100 order100；`bishaSUPER/cbs/cbsmian` qi300 order200；`bishaAIR/kbs/kbsmian` qi100 order210。

### `getBishaAI`（L441–472）

`param4` = 气力门槛，`param5` = 连招 order。`qi < param4` 则结果保持 false，仍可能走后面的 `if(_loc6_)`（不会）。

破防必杀：连招高难积极；对方防御时非连招也很高 `[0.1,0.2,1,6,8,10]`。

非破防：连招高难 `[0,0,0.5,4,8,10]`；另加目标 21 受击、14 跳跃的追打表。

16/10 压低；11/12/13 几乎 0（`[0,0,0.1,0,0,0]`）。AND 可打 AND 在面内。连招成功 `addContOrder(id, param5)`。

### `updateCache`（L474–504）

函数名 Cache，实际是 **抓**（catch）。先 `catch1=catch2=false`。

目标已是 21/22/23（受击/击飞/倒地）直接 return——不抓硬直中的人。

`dx<50`：`defult [0,0.5,1,3,2,1]`，对方防御 20 时高难几乎必抓 `[1,2,4,5,7,10]`。远则 default 高难为 0，防御中仍中等。

`catch1` 与 `catch2` **各掷一次独立骰**（同一张表）。都要 `targetCanBeHit`。不看招式面、不看 `_fighterAction.catch*`。连招中 order 150 / 110。

### `updateSpecialSkill`（L506–524）

仅当 **自己** `actionState==21`（受击中）：hp > 60% max 或 qi<150 则 return（**不把 specialSkill 置 false**）。否则 `defult [0,0,0,0,0.1,0.2]`，目标 11 技能时翻倍。→ `FighterAICtrl.specailSkill`（爆气等）。非受击帧不更新该字段。

### `updateAssist`（L526–534）

`defult` 很低 `[0,0.02,0.05,0.05,0,0]`（HELL 反而是 0）；对方防御 20 高难到 0.5；对方 12/13 必杀为 0。进连招仲裁，order 未登记，若本帧有其它 order 项会被清掉。

### `updateGhostStep`（L536–579）

距离 >80 或 qi<200 或自己不是 10/11（攻击/技能中）则 **return，不清 ghost 三字段**。

`ghostStep`：`defult` 全 0，仅目标 21 受击 `[0,0,0,0,0.1,0.2]`。

`ghostJump`：目标相对 y 在 `(-100, -80)`（目标在上方约一跳）时建了 `_loc4_` 表，但调用 `getAIByFighterState(_loc1_)`——**用的是 ghostStep 那张表不是 `_loc4_`**（?）。否则 `ghostJump=false`。

`ghostJumpDowm`：条件 `_target.y - _fighter.y < 80 && > 100`。一个数不能同时 <80 且 >100，**恒 false 分支**，`ghostJumpDowm` 永远被置 false（? 多半想写成 `>80 && <100`）。`FighterAICtrl.ghostJumpDown` 因此 CPU 永不下鬼步。
