# `FighterMcCtrler` — 角色时间轴 / 动作状态机

一句话目的：角色的「动作脑」。每逻辑帧按 `FighterAction` 开关 + `IFighterActionCtrl` 布尔值决定切哪段 MC 帧；角色 SWF 时间轴再回调本类改速度、出子弹、开钢身、抓人位移。`FighterMain.beHit` 也落到这里分防御 / 钢身 / 硬直 / 击飞。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterMcCtrler.as`（2234 行）

没有 `setFighter`：角色在构造函数写入 `_fighter`，之后只 `setMc` / `setActionCtrler`。

## Callers / callees

**装配链**

```
FighterMain.initlize
  → new FighterCtrler + mc.setFighterCtrler
  → FighterCtrler.initFighter
       new FighterMcCtrler(fighter)
       effectCtrler 接到同一 FighterEffectCtrl
       mc.setFighterMcCtrler(_fighterMcCtrl)   // SWF 存成 $mc_ctrler
  → FighterCtrler.initMc(innerMc)
       new FighterMC.initlize(mc, fighter, mcCtrl)  // 内部 setMc + idle
GameCtrl.addFighter
  → FighterMain.setActionCtrl(KeyCtrl 或 AICtrl)
       → FighterCtrler.setActionCtrl
            → setActionCtrler
```

**引擎侧 callers（`decompiled/main`）**

| 调用方 | 方法 |
|---|---|
| `FighterCtrler.initFighter` | `new`、写 `effectCtrler` |
| `FighterCtrler.initMc` | `idle()`（非万解开场） |
| `FighterCtrler.render` / `renderAnimate` | 原样转发 |
| `FighterCtrler.setActionCtrl` | `setActionCtrler` |
| `FighterCtrler.destory` | `destory` |
| `FighterMC.initlize` | `setMc` |
| `FighterMC` 击飞落地 | `touchFloor`、`effectCtrler.shake/hitFloor` |
| `FighterMain.beHit` | `beHit` |
| `FighterMain.idle/sayIntro/win/lose` | `idle` / `sayIntro` / `doWin` / `doLose` |
| `FighterMain.energyExplode` / `renderAnimate` 爆气钢身窗 | `setSteelBody` |
| `FighterMain.getMC` / `hasWankai` | `getFighterMc` |
| `FighterAILogicBase` | `getAction` |
| `FighterAILogic` | `getCurAction` |
| `FighterAttackerCtrler.owner_mc_ctrler` / `AssisiterCtrler.owner_mc_ctrler` | 经 `getMcCtrl()` 拿到本类，时间轴再调 `getAttacker` 等 |
| `GameStartCtrl` | `FighterMain.sayIntro` / `idle` |
| `GameEndCtrl` | `FighterMain.win` |
| `GameOverState` | `idle` / `lose` |
| `GameState` | 开局 `idle` |

**SWF 时间轴 callers**

几乎所有 `decompiled/fighters/*/scripts/*_fla/*.as` 经 `parent.$mc_ctrler` 或 `this.$mc_ctrler` 调公开 API。典型：`idle`、`endAct`、`setAttack("砍2")`、`movePercent`、`dampingPercent`、`addQi`、`fire`、`addAttacker`、`setHitTarget`、`setHurtAction`、`setSteelBody`、`justHitToPlay`、`moveTarget`、`getAttacker`、`dash`/`dashStop`、`isApplyG`、`hurtFly`。助战 SWF 走 `owner_mc_ctrler.getAttacker("lzgl")` 一类。

**本类 callees**

- `FighterMC`：`goFrame` / `checkFrame` / `stopRenderMainAnimate` / `playHurtFly` / `playHurtDown` / `stopHurtFly` / `getChildByName` / `getCurrentFrameCount`
- `FighterAction`：开关字段、`clear` / `clearAction` / `clearState` / `render`（CD 倒计时，本类从不 `setCD`）
- `IFighterActionCtrl`：约 60 处 `xxx()` 边沿/按住
- `FighterMain`：速度、气、能量、HP、朝向、`jump()`、`hurtBreakHit`、`energyExplode` / `replaceSkill`
- `FighterEventDispatcher`：`FIRE_BULLET`、`ADD_ATTACKER`、`ADD_ASSISTER`、`DO_ACTION`、`DIE`、`HURT_RESUME`
- `FighterEventCtrl` 听上述除 `DO_ACTION` 外的事件（`DO_ACTION` 本包无监听）
- `GameCtrl.I.getAttacker`、`EffectCtrl.I.do*HitEffect`、`GameLogic.checkFighterDie` / `isTouchBottomFloor`
- `MoveTargetParamVO`、`HitVO`、`HitType.isHeavy`
- `FighterEffectCtrl`：残影、震动、落地尘、钢身 glow、鬼步

## 与 FighterMain / FighterMC / IFighterActionCtrl 的关系

```
IFighterActionCtrl          FighterAction（本类持有）
 (KeyCtrl / AICtrl)          本帧「允许出哪些招」= 帧标签名
        │                              │
        │ 每帧 xxx() 布尔               │ setAttack("砍1") 等写入
        ▼                              ▼
                 FighterMcCtrler
                 ├── _fighter : FighterMain   物理/资源/state 数字
                 ├── _mc      : FighterMC     真正 gotoAndStop 帧标签
                 └── effectCtrler             特效/残影/glow
```

- **FighterMain**：HP/气/能量、`actionState` 数字、`isAllowBeHit`/`isCross`/`isApplyG`、`isSteelBody`。逻辑 `render` → `FighterCtrler.render` → 本类 `render`；动画同路径 `renderAnimate`。受击入口 `FighterMain.beHit`（先闸 `isAllowBeHit`）再进本类。
- **FighterMC**：时间轴外壳。`goFrame(name, isPlay, playFrames, delayObj)` 停在标签；`isPlay=true` 且 `playFrames=0` 则每动画帧 `nextFrame` 直到下次切。子 MC 名叫 `atm*` 的是判定盒，本类 `fire`/`addAttacker`/`setHitTarget` 用 `getChildByName` 找它们。
- **IFighterActionCtrl**：只回答「这帧要不要出这招」。本类用 `_action.xxx` 非空 **且** `_actionCtrler.xxx()` 才 `doXxx`。开场/终场 `enabled()` 为 false，地面轮询会把卡在「走/防御」的人拉回 `idle`。
- **FighterCtrler**：对外门面。SWF 的 `$fighter_ctrler` 管 hit 定义、朝向、位移辅助；`$mc_ctrler` 才是本类。`getMcCtrl()` 给 AI / 攻击体 / 助战拿回来。

时间轴约定：动作段开头 `setXxx` 打开下一招窗口，段末 `endAct` 或 `idle`。`endAct` 只清招式开关、`actionState=40`（FREEZE），**不**回站立——要等人打完或时间轴自己 `idle()`。

## 状态机总览（FighterActionState 数字 + 地面/空中/受击分支）

数字来自 `FighterActionState`（本类只写字面量）：

| 值 | 常量 | 谁置位 | 本类 `render()` 分支 |
|----|------|--------|----------------------|
| 0 | `NORNAL` | `idle`、`dashStop`、`doMove` | 地面轮询 |
| 10 | `ATTACK_ING` | `doAttack` / `doAirAttack` | 地面时额外轮询空中招；空中走 `renderAirAction` |
| 11 | `SKILL_ING` | `doSkill` / `doCatch` / `doAirSkill` | 同上 `isAttacking` |
| 12 | `BISHA_ING` | `doBisha` / `doAirBisha` | 禁鬼步/胜利 |
| 13 | `BISHA_SUPER_ING` | `doBisha(..., true)` | 同上 |
| 14 | `JUMP_ING` | `doJump` / `doAirJump` | 空中；`renderJumpAnimate` 管起跳延迟 |
| 15 | `DASH_ING` | `doDash` / `doDashAir` | 瞬步中无敌、关重力 |
| 16 | `HURT_ACT_ING` | `setHurtAction` | 抓投等「挨打切指定动作」 |
| 20 | `DEFENCE_ING` | `doDefense` | `renderDefense`；`renderAssist` 允许 |
| 21 | `HURT_ING` | `doHurt` hurtType=0、`doBreakDefense` | **整段 `render()` 只跑 `renderHurt`**（受击爆气） |
| 22 | `HURT_FLYING` | `doHurt` hurtType=1、`hurtFly` | **只跑 `renderHurtFlying`**（倒地起身） |
| 23 | `HURT_DOWN` | `FighterMC` 击飞倒地 | 飞天分支里 `_hurtDownFrame` 仍可起身 |
| 24 | `HURT_DOWN_TAN` | `FighterMC` 击飞弹起 | 开始 20 帧起身窗 |
| 30 | `DEAD` | 本类不写；`FighterMain.die` 只判断 | — |
| 40 | `FREEZE` | `endAct` | 招式后摇，等时间轴 `idle`/`setXxx` |
| 50 | `WAN_KAI_ING` | `doWaiKaiAction` | 万解，禁鬼步/胜利 |
| 60 | `KAI_CHANG` | `sayIntro` | 开场；`enabled` 通常 false |
| 61 | `WIN` | `doWin` | `GameEndCtrl` |
| 62 | `LOSE` | `doLose` | `GameOverState` |

`render()` 优先级（短路 return）：

1. `_ghostStepIng` → 整段逻辑跳过（动画帧里 `renderGhostStep`）
2. 击飞 `isHurtFlying` → `renderHurtFlying`
3. 硬直 `isHurting` → `renderHurt`（只试受击爆发）
4. 防住硬直 `isDefenseHiting` → `renderDefense(false, true)`（只允许转向）
5. 有 `hitTarget` → `renderCheckTargetHit`（不 return）
6. `renderWanKaiCtrl` 成功 → return
7. `isInAir` **或**（正在空中动作且 `touchFloorBreakAct==false`）→ `renderAirAction`，否则 `renderFloorAction`

地面招式优先级（同一逻辑帧可连着 `if`，后写的会盖 `doAction`）：

`catch1 > catch2 > bishaSUPER > bishaUP > bisha > skill2 > skill1 > zhao3 > zhao2 > attack > zhao1 > defense > dash > moveL/R > jump > jumpDown`

然后：正在走 → `renderMoving`；正在防 → `renderDefense`；`allowGhostStep` → 鬼步/鬼跳；`isAttacking` 时再轮询空中三招（地面攻击可 cancel 进空中招）。

空中：先保证 `fall()`；空中砍/招/必杀 → 二段跳/`jumpQuick` → **正在攻击中**才允许地面招式（空中 cancel 成必杀等）→ 空中瞬步 → `airMove` 平移 → 鬼跳/鬼下落。

## 命名备注

- `destory`：全工程拼写，不是 destroy。
- `waiKai` / `setWankai`：万解。字段/输入是 `waiKai*`，方法名 `setWankai`/`doWaiKaiAction`/`renderWanKaiCtrl`/`checkDoWankai` 混用。
- `specailSkill`：`IFighterActionCtrl` 拼写（special）。受击爆发用它；助战用 `assist()`。键控是**同一颗 special 键**。
- `isDefenseHiting` / `renderDefensHiting`：hitting 少一个 t。
- `_ghostStepIng`：ing 不是 ing/ing 笔误，就是 Ing。
- `NORNAL`：`FighterActionState` 的 NORMAL 拼错，值仍是 0。
- 帧标签全中文：`站立` `走` `防御` `防御恢复` `跳` `起跳` `跳中` `落` `落地` `瞬步` `砍1` `砍技1` `招1` `摔1` `必杀` `上必杀` `超必杀` `跳砍` `跳招` `空中必杀` `万解`/`万解W`/`万解S` `被打` `击飞` `起身` `开场` `胜利` `失败`。
- `zhao*` = 技能键系；`skill*` = 攻击+方向；`bisha*` = 必杀；`catch*` = 摔。
- `hurtType`：`0` 硬直「被打」，`1` 击飞。
- `HitType`：`11` = `CATCH`。`isCatch()` = `hitType==11 && isBreakDef`。
- `comicType==1`：死神侧，受击爆发走 `replaceSkill`（替身闪）；否则火影侧 `energyExplode`（爆气）。
- 钢身：普通白光 `0xFFFFFF`，超级黄光 `0xFFFF00`。
- `_justHurtResume`：刚从受击 `idle` 回来，**一动画帧**内 `isAllowBeHit=false`，防落地帧被连打。
- `_justDefenseFrame`：`idle` 后 `0.1*FPS_GAME`（60fps≈6 逻辑帧）内再进防御，立刻 `_isDefense=true`（无防御启动真空）。
- `FighterAction.clearAction` **不清** `waiKaiW` / `waiKaiS`（只清 `waiKai`）。万解 W/S 开关一旦 `setWankai` 过，会残留到下次 `idle` 的 `setAllAct` 再写。

## 逐行说明

### 字段（L28–74）

公开：

- `effectCtrler`：`FighterCtrler.initFighter` 注入，与 `$effect_ctrler` 同一实例。

私有状态：

- `_actionCtrler`：键控/AI。
- `_mc`：`FighterMC`。
- `_fighter`：所属 `FighterMain`。
- `_action`：本帧可出招表 + 过程旗标（`isMoving/isHurting/...`）+ `airHitTimes`/`jumpTimes`。
- `_doingAction`：当前地面/通用动作帧名；`_doingAirAction`：仅空中 `doAction(..., true)` 时等于前者，否则 null。`getCurAction` 空中优先。
- `_isFalling`：已切「落」且未落地。`fall()` 闩，防重复切帧。
- `_jumpDelayFrame`：起跳前摇。地面跳=2 动画帧，空中跳=1。
- `_hurtHoldFrame` / `_defenseHoldFrame`：硬直/防住硬直剩余动画帧。
- `_beHitGap`：挨打后的无敌倒计时（动画帧）。`renderBeHitGap` 减到 0 才 `isAllowBeHit=true`。
- `_doActionFrame`：当前 `_doingAction` 已播的动画帧数。万解「砍1 前 2 帧可补」用。
- `_isTouchFloor`：本类自己的落地闩，**不等于** `!fighter.isInAir`。`fall`/`touchFloor`/`idle` 维护。击飞中落地只把此闩打 true，不立刻 `touchFloor()`。
- `_isDefense`：这一帧防御判定是否生效。与 `_action.isDefensing`（在防御姿势）分开。
- `_defenseFrameDelay`：防御启动/松开的动画帧延迟。
- `_moveTargetParam`：抓投把目标吸到 MC 点；`endAct`/`idle` 清掉。
- `_hurtDownFrame`：击飞着地后的起身窗计数。
- `_ghostStepIng` / `_ghostStepFrame` / `_ghostType`：鬼步中。type `0` 走、`1` 跳、`2` 下落。
- `_autoDirectFrame`：站立时每 5 动画帧朝向敌人一次。
- `_justDefenseFrame`：刚 idle 的防御优待窗。
- `_justHurtResume`：受击恢复的 1 帧无敌。

### 构造 `FighterMcCtrler(fighter)`（L76–80）

只存 `_fighter`。MC 要等 `FighterMC.initlize` → `setMc`；输入要等 `setActionCtrler`。`_action` 字段初始化已 `new`。

### `destory`（L82–98）

有则 `_actionCtrler.destory()`、`_mc.destory()`，全引用置 null（含 `effectCtrler`）。不派事件。由 `FighterCtrler.destory` 调用。

### `getAction`（L100–103）

返回 `_action` 引用。AI `FighterAILogicBase` 用来看当前允许的招（帧名非空即「这招现在能出」）。

### `getFighterMc`（L105–108）

`FighterMain.getMC()` / `hasWankai()` 用。

### `getCurAction`（L110–117）

`_doingAirAction != null` 则返回它，否则 `_doingAction`。AI 用当前招名做决策。idle 后两者都是 null。

### `setActionCtrler(actionCtrl)`（L119–122）

只赋值。`FighterMain.setActionCtrl` 会再 `actionCtrl.initlize()`（listenKeys 等），那步不在本类。

### `setMc(fighterMC)`（L124–128）

存 `_mc` 并立刻 `idle()`。`FighterCtrler.initMc` 里若正在万解开场会自己 `goFrame("开场")` 且再调一次 `idle` 被跳过——`initMc` 万解路径不走这里的第二次 idle（`FighterMC.initlize` 仍会 idle 一次，随后 `initMc` 再切开场）。

### `setSteelBody(enabled, superSteel=false)`（L130–142）

`fighter.isSteelBody = enabled`；`isSuperSteelBody = enabled && superSteel`。开：`startGlow(超钢黄 16776960 / 普通白 16777215)`。关：`endGlow`。时间轴、爆气、`idle`/`endAct`/`doHurt` 都会调。

### `addQi(value)`（L144–147）

转发 `FighterMain.addQi`（上限 300）。时间轴打中后加气。

---

### `idle(frameName="站立")`（L149–192）

回中立。时间轴段末、落地、受击恢复、鬼步结束、控制器禁用时走「走/防御」都会进这里。

1. 若当前 `isHurting(state)`（21–24）→ `_justHurtResume=true`（下一动画帧才允许挨打）。
2. `endAct()`：清招、state=40、关钢身。
3. `_doingAction/_doingAirAction=null`，再关一次钢身。
4. `_justDefenseFrame = 0.1 * FPS_GAME`（≈6 逻辑帧防御优待）。
5. 关残影/震动。
6. `_action.clearAction+clearState`。
7. `actionState=0`。
8. `isAllowBeHit = !_justHurtResume`；`isApplyG=true`；`isCross=false`。
9. 清 `hurtHit`/`defenseHit`/`clearHurtHits`（连段伤害记录，影响爆发判定）。
10. 显示体 visible=true（有的招会隐身）。
11. `_isDefense=false`，`_autoDirectFrame=0`。
12. 没贴地 → `fall()`（切「落」）。
13. 否则停速度；若帧名是「站立」：恢复 `jumpTimes/airHitTimes` 为角色默认值，`setAllAct()`，`goFrame("站立", false)` **停在第一帧**（站立靠子 MC 循环，主轴不 nextFrame）。其它帧名 `goFrame(name, true)` 循环播。

### `loop(frameName)`（L194–197）

`goFrame(name)` 默认 isPlay=true。时间轴「走」循环常用。

### `stop`（L199–202）

`_mc.stopRenderMainAnimate()`：主轴不再 nextFrame，停在当前帧。胜利/失败pose、某些特写。

### `dash(speedMul=3)`（L204–211）

时间轴瞬步帧调用，真正给速度：`vx = speed * speedMul * direct`，阻尼 0，`isCross=true`（穿人），`isAllowBeHit=false`，`_action.isDashing=true`。不切帧。

### `dashStop(dampingRate=0.5)`（L213–223）

`setDamping(|vx|*dampingRate)`，允许挨打，`actionState=0`，`clearAction`，`isDashing=false`，`isCross=false`。瞬步收招。

---

### 招式开关写入（L225–477）

时间轴在某段「允许出下一招」时调用。几乎都是：`checkFrame` 没有该标签则忽略（`FighterMC` 会把未知标签记入 `_undefinedFrames` 并 trace）。

#### `setAllAct`（L225–245）

站立全开：走、防、跳、下落、瞬步、砍、砍技1/2、招1/2/3、摔1/2、必杀/上/超、万解。

#### `setAirAllAct`（L247–254）

空中：瞬步、跳砍、跳招、空中必杀、`airMove=true`。

#### `setAirMove(on)`（L256–259）

只写 `_action.airMove`。空中 `renderAirAction` 据此 `doAirMove`。`move()` 在空中给了 x 速度会把它打 false（避免跟手动位移抢）。

#### `setMove`（L261–264）

只转调 `setMoveLeft` + `setMoveRight`。

#### `setMoveLeft`（L266–269） / `setMoveRight`（L271–275）

左右都写成帧名 `"走"`。没有 `checkFrame`（假定人人有走）。轮询时 `moveLEFT`/`moveRIGHT` 分别读这两个字段，但帧名相同。

#### `setDefense`（L276–279）

`_action.defense = "防御"`。无 checkFrame。

#### `setJump(frame="跳")`（L281–288）

`checkFrame` 失败则不写。`idle→setAllAct`、`fall`、跳到「跳中」后 delay 5 帧都会开。

#### `setJumpQuick(frame="跳")`（L290–297）

小跳开关，默认标签也是 `"跳"`（同一段）。`renderJumpAnimate` 在跳的第 2 动画帧才打开。经典模式键控 `jumpQuick()` 恒 false。

#### `setJumpDown(frame="落")`（L299–306）

下平台。`setDefenseAction` 防御中也会开。

#### `setDash(frame="瞬步")`（L308–315）

地面 `setAllAct` 与空中 `setAirAllAct` 都开。无帧的角色不能瞬步/鬼步前的 dash 检测仍可能按键，但 `_action.dash` 为空则 `doDash` 进不去。

#### `setAttack(frame="砍1")`（L317–324）

连段时间轴常 `setAttack("砍2")` 改下一刀。`touchFloor` 落地默认 delay 1 帧再 `setAttack`。

#### `setSkill1(frame="砍技1")`（L326–333）

下+攻。`setDefenseAction` 防御中重开（防中可出）。

#### `setSkill2(frame="砍技2")`（L335–342）

上+攻。走路 `setMoveAction` 会开。

#### `setZhao1(frame="招1")`（L344–351） / `setZhao2("招2")`（L353–360） / `setZhao3("招3")`（L362–369）

技能键 / 下+技能 / 上+技能。防御中只开 `zhao2`。走路开 zhao1/3 不开 zhao2。

#### `setCatch1(frame="摔1")`（L371–378） / `setCatch2("摔2")`（L380–387）

攻+左右 / 技能+左右。走路中可摔。`doCatch` 另有贴身 `allowCatch` 闸。

#### `setBisha(frame="必杀", qi=100)`（L389–397）

写帧名 + `bishaQi`。`clearAction` 把气耗重置回 100。

#### `setBishaUP(frame="上必杀", qi=100)`（L399–407）

上+必杀。气耗字段 `bishaUPQi`，clear 回 100。

#### `setBishaSUPER(frame="超必杀", qi=300)`（L409–417）

下+必杀。`bishaSUPERQi` 默认 300。防御中可开（防中超必）。

#### `setAttackAIR(frame="跳砍")`（L419–426）

空中普攻。地面 `isAttacking` 时也能轮询（cancel）。

#### `setSkillAIR(frame="跳招")`（L428–435）

空中技能。

#### `setBishaAIR(frame="空中必杀", qi=100)`（L437–445）

写 `bishaAIR` + `bishaAIRQi`。`clearAction` 把 `bishaAIRQi` 重置回 100。

#### `setTouchFloor(frame="落地", breakAct=true)`（L447–455）

落地切哪一帧；`breakAct=true` 表示落地**打断**当前空中动作（`render()` 用 `!touchFloorBreakAct` 决定是否继续空中轮询）。`fall()` 默认落地打断。有的跳招 `setTouchFloor("跳招3", true)` 落地接特定收招。

#### `setWankai`（L457–471）

分别 check `"万解"` / `"万解W"` / `"万解S"` 写入 `waiKai*`。`idle→setAllAct` 会调。没有的角色对应字段保持 null，`checkDoWankai` 再走「砍1 前 2 帧补默认标签」的兼容。

#### `setHitTarget(checkerName, actionName)`（L473–477）

`hitTargetChecker` = 角色 MC 里用于检测的子剪辑名（常 `*atm`）；`hitTarget` = 碰到敌人身体后切的帧。`renderCheckTargetHit` 每逻辑帧做矩形相交。抓投、必杀「靠近才出下一刀」。

#### `setHurtAction(frameName)`（L479–483）

`_action.hurtAction = frame`，`actionState=16`。之后 `beHit` **不再走普通受击**，直接 `doAction(hurtAction)`。抓投期间把对方锁进指定受击动作。

---

### 位移 API（L485–526）

时间轴每帧或某帧调用，改 `FighterMain` 主速度通道。

#### `move(vx=0, vy=0)`（L485–498）

双 0 → `stopMove`。空中且 `vx!=0` → 关 `airMove`（手动位移优先）。`vx *= direct` 后 `setVelocity`。这是**覆盖**速度，不是每帧叠加。

#### `movePercent(px=0, py=0)`（L500–503）

`move(speed*px, speed*py)`。`speed` 默认 6，所以 `movePercent(1,0)` ≈ 走路速度。

#### `stopMove`（L505–508）

速度清 0。不清阻尼。

#### `damping(dx=0, dy=0)`（L510–513）

`setDamping`（内部再 `* SPEED_PLUS_DEFAULT * 2`）。

#### `dampingPercent(px, py)`（L515–518）

按 `speed` 比例设阻尼。收招滑步常用 `dampingPercent(0.1, 0)`。

#### `endAct`（L520–526）

`clearAction`、`actionState=40`、清 `_moveTargetParam`、关钢身。时间轴招式后摇：判定结束、不再出下一招，直到 `idle` 或再 `setXxx`。**不**停 MC、不回站立。

---

### 子弹 / 攻击体 / 重力 / 切帧（L528–598）

#### `fire(mcName, params=null)`（L528–550）

从当前动作 MC `getChildByName(mcName)` 取子弹剪辑。找到：保证 `params` 对象，塞 `mc` + `hitModel.getHitVOByDisplayName(mcName)`，派 `FIRE_BULLET` → `FighterEventCtrl.fireBullet` `new Bullet`。找不到：`setAnimateFrameOut(fire 自己, 1)` 下一动画帧重试（子剪辑可能这帧才被时间轴 addChild）。

#### `addAttacker(mcName, params=null)`（L552–574）

同样模式，事件 `ADD_ATTACKER` → `new FighterAttacker`，进 `_attackers` 表。`params` 时间轴常带速度、朝向等。

#### `isApplyG(apply)`（L576–579）

写 `fighter.isApplyG`。飞行技、瞬步 `doDash` 里关。方法名像查询，实际是 setter。

#### `gotoAndPlay(frameName)`（L581–584）

`goFrame(name, true)` 循环播。不改 `_doingAction`、不 `doAction`、不派 `DO_ACTION`。必杀分镜跳转用。

#### `gotoAndStop(frameName)`（L586–589）

`goFrame(name, false)` 停在标签第一帧。

#### `hurtFly(hitx, hity)`（L591–598）

`playHurtFly(hitx*direct, hity, false)`：第三参 false = **直接**切「击飞」、不经过「被打」1 帧。`isHurtFlying=true`，`actionState=22`，清起身计数，`_isFalling=false`。时间轴强制击飞（自己的招把人打飞，或死亡硬直结束转击飞）。`renderHurtAnimate` 死亡落地也走这里。

---

### `moveMC(display, xParam=null, yParam=null)`（L600–633）

把某个 `DisplayObject`（通常是子弹/特效 MC）摆到角色或敌人相对位置。时间轴少见。

- `xParam` 是 Number：`display.x = fighter.x + xParam`（**没乘朝向**）。
- 否则若 `xParam.target != undefined` 且有当前目标：`display.x = target.x - fighter.x`；若 `Number(target)` 是 NaN 再 `+= Number(target)`。语义像「相对目标的本地 x」。`isNaN` 方向像反了（数字偏移反而**不加**）——? 可能本意 `!isNaN`。
- y 同理，但目标分支写成 `target.y - fighter.y + Number(yParam)`：`Number(object)` 是 NaN，y 先被写成 NaN，再按同样 `isNaN(target)` 决定加不加。**X 没有 `+ Number(xParam)`**。大概率 y 拷贝笔误，标 ?。

---

### `justHitToPlay(hitId, frameName, idleIfMiss=false, checkDefense=false)`（L635–645）

`FighterCtrler.justHit(hitId, checkDefense)`：看**当前目标**的 `hurtHit.id`（或 `checkDefense` 时 `defenseHit.id`）是否等于 `hitId`。刚打中 → `goFrame(frameName)`（不经 `doAction`）。否则若 `idleIfMiss` → `idle()`。连段「只有打中才出下一刀」，打空收招。

### `getAttacker(name)`（L647–655）

`GameCtrl.I.getAttacker(name, team.id)` 扫 `FighterEventCtrl._attackers`，命中返回 `FighterAttacker.getCtrler()`（`FighterAttackerCtrler`），否则 null。时间轴对已放出的分身/飞件 `gotoAndPlay("end")` 等。注意返回的是 **Attacker 的控制器**，不是本类。

### `moveTarget(param=null)`（L657–667）

`null`：`_moveTargetParam.clear()`（目标 `isApplyG=true`）并置 null，停止吸人。非 null：`new MoveTargetParamVO(param)`（`x/y/followmc/speed`），`setTarget(当前目标)`（并把目标速度清 0）。之后每逻辑帧 `renderMoveTarget`。抓投把敌人贴到角色某个子 MC。

---

### `render`（L669–719）—— 逻辑帧

`FighterMain.render` → `FighterCtrler.render` → 这里。60fps 每物理帧一次。**不**推进 MC。

1. 鬼步中 return（位移已在 start 时 `setVelocity`，基类 `renderVelocity` 仍会积分）。
2. `_justDefenseFrame` 递减。
3. `_action.render()`：招式 CD 倒计时（本类未 `setCD`，通常空转）。
4. 有吸人参数 → `renderMoveTarget`。
5. `_actionCtrler.render()`（键控空；AI 在此想招）。
6. 击飞 / 硬直 / 防住硬直 三分支 return（见状态机）。
7. `hitTarget` 检测（不打断后面）。
8. 万解轮询成功则 return。
9. 空中条件：`fighter.isInAir` **或**（`_doingAirAction && !touchFloorBreakAct`）。后者让空中招在贴地后仍按空中轮询，直到 `setTouchFloor(..., true)` 或 `idle`。
10. 否则 `renderFloorAction`。

### `renderHurtFlying`（L721–746）

击飞逻辑帧：贴地则 `_isTouchFloor=true`（不切落地动作，落地动画由 `FighterMC.renderHurtFly` 管）。死了不再处理起身。`actionState==24`（弹起）时把 `_hurtDownFrame` 置 1 开始计。计数 1…19 内若 `dashJump()`（冲，含按下）→ `doHurtDownJump` 起身。20 帧后窗关。倒地 state 23 时若 `_hurtDownFrame` 已在走，同样能起身。

### `renderAssist`（L748–762）

仅 `actionState` 为 0 或 20（站立/防御）。`assist()` 且 `fzqi>=100`：`fzqi=0`，派 `ADD_ASSISTER`。助战槽 `FighterMain.renderFzQi` 每动画帧 +0.2，满 100。

### `renderFloorAction`（L764–881）

1. 本类认为没贴地 → `touchFloor()`（补落地）。
2. 无控制器或 `!enabled()`：若当前帧是「走」或「防御」则 `idle()`（开场/暂停别走着）；return。
3. `renderAssist`。
4. 按优先级轮询摔→超必→上必→必杀→砍技2/1→招3/2→砍→招1→防御→瞬步→走→跳→下落。每个都是独立 `if`，同一帧多键会连续 `doXxx`，后执行的覆盖 MC。
5. 已在走 → `renderMoving`（按住转向/松手 idle）。
6. 已在防 → `renderDefense()`（转向换边防御）。
7. `allowGhostStep`（非 12/13/50）→ 鬼步 / 鬼跳。
8. `isAttacking`（10–13）→ 再轮询空中三招（地面攻击 cancel 进跳砍等）。

### `renderWanKaiCtrl`（L883–902）

控制器可用时：`waiKai` / `waiKaiW` / `waiKaiS` 边沿分别 `checkDoWankai(对应字段, "万解"/"万解W"/"万解S")`。成功返回 true，`render()` 不再走地面/空中。万解键优先于一切普通招。

### `checkDoWankai(actionFrame, defaultFrame)`（L904–920）

字段已有帧名 → `doWaiKaiAction` 成功。否则：当前正在 `"砍1"` 且 `_doActionFrame<2` → 用 **defaultFrame** 标签硬出（角色没单独万解帧时，轻砍起手两帧内仍可万解）。再否则 false。

### `renderAnimate`（L922–974）—— 动画帧

约 30fps（`GameCtrl` 抽帧）。顺序：

1. `_justHurtResume`：这帧把 `isAllowBeHit=true` 并清旗（受击 idle 的 1 帧无敌结束）。
2. `renderBeHitGap`：无敌间隙倒数。
3. `_mc.renderAnimate()`：主轴 nextFrame、子 MC、击飞状态机、延迟回调。
4. `_actionCtrler.renderAnimate()`（AI）。
5. 鬼步中 → `renderGhostStep` return（仍已播了 MC）。
6. 硬直 → `renderHurtAnimate`（硬直帧减完恢复/死亡）。
7. 防住硬直 → `renderDefensHiting`。
8. 跳跃中 → `renderJumpAnimate`。
9. 有 `_doingAction` → `_doActionFrame++`。
10. 防御姿势 → `renderDefenseAnimate`（松手切防御恢复）。
11. 当前帧名「站立」：每 6 次动画帧（`++_autoDirectFrame > 5`）`setDirectToTarget`。

### `renderAirAction`（L976–1062）

1. 非跳跃过程 → `fall()`（切「落」、开空中招）。
2. `_isTouchFloor=false`。
3. 无控制器/禁用 → return（仍保持下落姿势）。
4. 跳砍 / 跳招 / 空中必杀。
5. `jump` / `jumpQuick` → `doAirJump`（二段跳；小跳同一套，只是延迟 1 帧）。
6. **仅 `isAttacking`** 时轮询地面那套必杀/技能/砍（空中招 cancel 成超必等）。
7. 瞬步 → `doDashAir`。
8. `airMove` → `doAirMove`。
9. `ghostJump` / `ghostJumpDown`。空中没有 `ghostStep`（那是地面冲+下）。

### `renderMoveTarget`（L1064–1144）

无 target return。

有 `followMcName`：找子 MC，目标点 = `fighter.x + child.x*direct`、`fighter.y + child.y`。子 MC 还没出现则 return（这帧不吸）。

否则用 VO 的 `x/y`（NaN 则该轴不动）。

有 `speed` 且 **`speed.x > 0`** 才走逼近：x 超出 `target±speed.x` 则每帧挪 `speed.x`；y 超出则对 `BaseGameSprite` `setVecY(±speed.y)+setDampingY(1)`，否则直接改 `y`。`speed.x==0` 时 **y 也不走逼近**（整段跳过）。无 speed：直接把目标 x/y 赋成目标点（瞬移贴身）。

---

### 下落 / 落地 / 出招核心（L1146–1222）

#### `fall`（L1146–1167）

已在下落或 `_doingAction` 非空则 return（空中招下落不切「落」）。否则清状态/招，`setAirAllAct`+`setJump`，闩 `_isFalling`，清空中动作名，视为离地，关防御，`setVecX(0)`，`setTouchFloor("落地", true)`，`goFrame("落", false)` 停在落帧。

#### `touchFloor`（L1169–1197）—— public

`FighterMC` 击飞倒地也会调。死了 return。落地帧：`_action.touchFloor`，若正在 `_isFalling` 且没设过则默认 `"落地"`。仍 null 则 return（击飞过程中途触地但没设落地招）。`"落地"` 时 `doAction` 带 delay=1 的 `setAttack`（落地后 1 动画帧才允许砍，防落地立即出招）。其它落地帧无此回调。`effectCtrler.touchFloor()` 尘土。恢复 `airHitTimes/jumpTimes`。闩贴地、清下落。

#### `doAction(frameName, isAir=false, delayObj=null)`（L1199–1222）

所有主动招的汇合点。`frameName==null` return。关残影/震动，速度清 0，清 moving/defensing/dashing，记下 `_doingAction`，空中则 `_doingAirAction=同名` 否则 null，`clearAction`（关掉刚进来的那一招开关——要再 cancel 得时间轴重新 `setXxx`），清下落/防御，允许挨打、不穿人、开重力，`_doActionFrame=0`，`goFrame(name, true, 0, delayObj)` 循环播到时间轴自己停/切，派 `DO_ACTION`（本包无监听，可能给插件/调试）。

---

### 走路 / 防御 / 瞬步 / 跳（L1224–1497）

#### `setMoveAction`（L1224–1240）

走路中允许的 cancel：清招后 `isMoving=true`，开走、砍、招1/3、砍技2、跳、瞬步、必杀/上必、防御、摔。不开招2/砍技1/超必（那些要停步）。

#### `renderMoving`（L1242–1258）

按住左：朝向 -1，`move(speed)`；右对称。都没按 → `idle()`。每逻辑帧覆盖速度，所以走路是恒速。

#### `doMove(frameName, direct=1)`（L1260–1269）

已在走 return。`goFrame("走", true)` 循环，`actionState=0`，`setMoveAction`。**`direct` 未使用**——朝向在 `renderMoving` 里按键设。

#### `doAirMove`（L1272–1281）

按住左 `fighter.move(-speed)`，右 `move(+speed)`。这是 `BaseGameSprite.move`（本帧位移，不经 setVelocity），可与下落叠加。左右可同时（对消）。不改朝向。

#### `renderDefense(resetAction=true, forceDefense=false)`（L1283–1301）

防中转向：按左且当前不是朝左 → `direct=-1` 并 `setDefenseAction`；右对称。防住硬直分支用 `(false, true)`：不重置招表，强制 `_isDefense=true`。

#### `renderDefenseAnimate`（L1303–1332）

防住硬直中 return（别在硬直里松防）。`_defenseFrameDelay--` 仍 >0 则 return（启动 1 帧）。仍按着防御：保证 `_isDefense=true`。否则：delay 刚过 0 后还有约 5 帧宽限（`> -5`）；再松才 `isDefensing=false`，`goFrame("防御恢复", false, 0, {call:idle, delay:1})`。

#### `setDefenseAction(resetAction=true, forceDefense=false)`（L1334–1356）

`resetAction`：清招/状态，`isDefensing=true`，防御中可出砍技1、招2、超必、下落（下平台）。`forceDefense` 或 `_justDefenseFrame>0` → `_isDefense=true`，否则先 false（要等 animate 确认按住）。`_defenseFrameDelay=1`。`goFrame("防御", true, 3)`：**只播 3 动画帧**后停（防御姿势循环靠子 MC）。

#### `doDefense`（L1358–1367）

已在防 return。`actionState=20`，`dampingPercent(1,1)` 急刹，`setDefenseAction()`。

#### `doDash(frameName)`（L1369–1388）

`hasEnergy(20, true)`（能量不够但未 overload 也行）否则 return；`useEnergy(20)`。按左右立刻转身。`doAction`，`actionState=15`，无敌，`isApplyG(false)`。真正的冲量由时间轴调 `dash()`。

#### `doDashAir(frameName)`（L1390–1406）

`jumpTimes<1` 或能量 30 不够（允许 overload）return。耗 30，`doAction`，state 15，无敌，关重力，**`jumpTimes=0`**（空中瞬步耗光剩余跳）。

#### `doJump(frameName)`（L1408–1422）

`jumpTimes<=0` return。清招/状态，清 doing，`goFrame("起跳", false)`，`_jumpDelayFrame=2`，`isJumping=true`，`actionState=14`。**不立刻给速度**，等 `renderJumpAnimate`。参数帧名未用，起跳固定「起跳」。

#### `doJumpDown(frameName)`（L1424–1438）

已在底边 `isTouchBottom` return。`_action.clear()`（状态+招全清），`jumpTimes=0`，`setVecY(5)` + `setDamping(0,1)`，`y+=1` 强制离板，关防御，`goFrame(frameName, false)`，`setTouchFloor()` 默认落地打断。下平台。

#### `doAirJump(frameName)`（L1440–1453）

与地面跳类似但无「起跳」姿势，`_jumpDelayFrame=1`。参数帧名未用。

#### `renderJumpAnimate`（L1455–1497）—— public，仅本类 `renderAnimate` 调用

有 `_doingAction` return（空中出招后跳动画不再管）。延迟帧递减到 0：清 `_isFalling`，`jumpTimes--`，`goFrame("跳", false)`，`fighter.jump()`（`vy=-jumpPower`，y 阻尼 0.5，`_g=0`），`setAirAllAct`。已在空中播 `jumpAir` 尘，否则地面 `jump` 尘。延迟未完直接 return。

延迟完后：当前动作已播 2 帧 → `setJumpQuick()` 打开小跳。`vy > -jumpPower*0.35` 且帧名还不是「跳中」→ 切「跳中」，5 动画帧后 `setJump`（允许再跳）。`vy>=0`（过顶点）→ `isJumping=false`，`_isFalling=true`（下一逻辑帧 `renderAirAction` 会 `fall()`，但 `_doingAction` 空才会切「落」）。

---

### 出招 doXxx（L1499–1584）

#### `doAttack`（L1499–1503）

`doAction` + `actionState=10`。

#### `doSkill`（L1505–1509）

`doAction` + `11`。砍技和招都走这里。

#### `doCatch`（L1511–1519）

`allowCatch()` 失败则完全不出（不耗资源）。成功同 skill，state 11。

#### `doBisha(frameName, qiCost, isSuper=false)`（L1521–1529）

`useQi` 失败 return。先写 `actionState` 13 或 12，再 `doAction`（`doAction` 不改 state）。

#### `doWaiKaiAction(frameName)`（L1531–1544）

MC 无此帧或 `useQi(300)` 失败 return。`actionState=50`，`doAction`，**无敌**。万解固定 300 气。

#### `doAirAttack`（L1546–1557）

若当前没在做动作 **且** `airHitTimes<=0` return。已在动作中则可继续 cancel（不看次数）。`addDamping(0,3)` 空中砍顿一下，`airHitTimes--`，`jumpTimes=0`，`doAction(name, true)`，state 10。

#### `doAirSkill`（L1559–1569）

同样的次数闸。`airHitTimes=0`（一次跳招耗光）、`jumpTimes=0`，`doAction(..., true)`，state 11。

#### `doAirBisha`（L1571–1584）

同样次数闸 + `useQi`。state 12（没有空中超必独立 state），`airHitTimes=0`，`doAction(..., true)`。成功才清次数（气不够保留）。

---

### 受击（L1586–1809）

#### `beHit(hitVO, hitRect=null)`（L1586–1642）

`FighterMain.beHit` 已确认 `isAllowBeHit`。

1. 有 `hurtAction` → `doAction(hurtAction)` return（抓投脚本受击）。
2. 自己贴墙且 hit 有 `BaseGameSprite` 主人、双方 x 距 &lt; 100：把击退反推给攻击方 `setVec2(-hitx*owner.direct*1.4, 0, 0.3, 0)`，x 分量钳 ±20。墙边防「自己没处可退」。
3. `_isDefense`：
   - `isBreakDef && hitType==11`（抓破防）→ 当普通受击。
   - `checkDirect` 且主人存在且 `checkDefDirect`（打背）→ 普通受击。
   - 否则 `doDefenseHit`。
4. 否则若钢身且活着 → `doSteelHurt`。
5. 否则 `doHurt`。

#### `checkDefDirect(owner)`（L1644–1655）

自己在对方左侧超过 5px：双方都朝左 → true（背防）。右侧超过 5px：都朝右 → true。重叠带（±5）false。true 表示防错方向，当没防住。

#### `doSteelHurt(hitVO, hitRect)`（L1657–1726）

非超钢 且（`energyOverLoad` 或 `isBisha()` 或 `isCatch()`）→ 当普通 `doHurt`（钢身吃不住必杀/抓/过载）。

否则：记 `hurtHit`。超钢扣伤害 30%，普通钢 65%。若因此死亡：`DIE`、`isAlive=false`，再 `doHurt`（死了钢身不保）。

无敌间隙：`hurtType==1` 10 帧，否则 4。耗能：超钢 20% 伤害；破防 100%；普通 40%。`isAllowBeHit=false`。

超钢**无击退**。普通钢：`setVec2(hitx*owner.direct, hity, |hitx|*0.1, |hity|*0.1)`，破防时位移×2。

有矩形则 `EffectCtrl.doSteelHitEffect`。

#### `doHurt(hitVO, hitRect)`（L1728–1809）

关残影/震动。记 `hurtHit`。`loseHp(全额伤害)`。活着且 `checkFighterDie`（练习模式恒 false）→ `DIE` + `isAlive=false`。`_beHitGap=4`，无敌，开重力，关防御。击退：`hitx *= owner.direct`。空中若 `hity<=0` 再 -3；地面若 `hity<0` 再 -6 并 `_isTouchFloor=false`（上挑离地）。清状态、doing、钢身。

`hurtType==0`：`isHurting=true`，`_hurtHoldFrame = round(hurtTime/1000*30) + HURT_FRAME_OFFSET(3)`，最少 4。抓（hitType 11）`goFrame("被打", false)` 单帧；否则 `goFrame("被打", true, 7)` 播 7 帧。`actionState=21`，`setVelocity(hitx,hity)` + `setDamping(0.1, 0.5)`。活着且 `HitType.isHeavy`（6/3/5/7/8/9）→ 语音槽 0，50%（`playVoice` 第二参是概率）。

`hurtType==1`：`isHurtFlying=true`，state 22，起身计数 0，`playHurtFly(hitx,hity)`（默认经「被打」再「击飞」）。活着语音 1，死了语音 2。

有矩形 → `EffectCtrl.doHitEffect`。`_isFalling=false`。

两个 `if (hurtType==0)` / `if (hurtType==1)` 不是 else，正常互斥。

---

### 受击中的逻辑 / 爆发 / 恢复（L1811–1907）

#### `renderHurt`（L1811–1818）

死了不管。活着只 `renderHurtBreak`。硬直减帧在 animate。

#### `renderHurtBreak`（L1820–1860）

受击爆发（special 键）：

- `specailSkill()` 未按 return
- `hasEnergy(50)` 不够 return（**下面却 `useEnergy(100)`**，过载可扣到 0）
- `qi < 100` return
- 最后一击 `isBisha()` → 不能爆（必杀连中不可断）
- `hurtBreakHit()` 当前连段有破防 → 不能爆
- `currentHurtDamage() > 210` → 伤害太高不能爆
- `useQi(100)` + `useEnergy(100)`
- `comicType==1`（死神）`replaceSkill()`：瞬移 250*direct、idle、短暂无敌
- 否则 `energyExplode()`：超钢 60 动画帧 + 爆气判定
- 派 `HURT_RESUME`（清以自己为 target 的连击 UI）

`getLastHurtHitVO()` 在 `_currentHurts` 空时返回 null，`.isBisha()` 会 NPE。正常路径 `FighterMain.beHit` 在本类 `beHit` **之后**才 push 到 `_currentHurts`，所以第一次挨打的**同一逻辑帧**不会跑 `renderHurt`；下一帧已有记录。若 `clearHurtHits` 后仍 `isHurting` 则危险（? `idle` 会同时清状态）。

#### `renderHurtAnimate`（L1862–1886）

`_hurtHoldFrame--` 减到 &lt;=0：死了 → `clearState`，空中用当前 `vec2` `hurtFly`，否则 `playHurtDown`，语音 2。活着 → `hurtResume`。

#### `hurtResume`（L1888–1896）

地面但本类还以为在空中：强制 `_isTouchFloor=true`（避免 idle→fall）。`idle()` + `HURT_RESUME`。

#### `renderBeHitGap`（L1898–1907）

`_beHitGap>0` 则递减；到 0 时 `isAllowBeHit=true`。钢身/防御/普通挨打共用。

---

### 防御受击 / 破防（L1909–2028）

#### `doDefenseHit(hitVO, hitRect)`（L1909–1971）

仍掉 5% 伤害。因此死亡 → `DIE` 并转 `doHurt`。记 `defenseHit`（`justHit(..., true)` 看这个）。

耗能：破防 90；否则 `damage/5` 上限 50。能量不够（`hasEnergy(cost, false)` 不允许 overload）：仍 `useEnergy`（打到 0 并 overload）然后 `doBreakDefense` return。

够：耗能，`_beHitGap=4` 无敌。`hitx *= owner.direct`。`isDefenseHiting=true`。hurtType 0：`hold = hurtTime/1000 * FPS_GAME / 5` 钳到 5–10；hurtType 1：hold=10 且 gap=8。只给 x 速度 + `setDamping(1,0)`。`doDefenseEffect`（按 `defenseType`）。

#### `doBreakDefense(hitVO, hitRect)`（L1973–2016）

再掉 `damage/10`。gap：hurtType0=4，1=10。无敌。`energyOverLoad=false`（破防后允许立刻回能）。关 `_isDefense`。击退 x 先钳到 5–10 再乘主人朝向。清状态，`isHurting=true`，硬直 **42** 动画帧，`goFrame("被打", true, 7)`，state 21，`setVelocity(hitx)` + `setDamping(0.1)`。特效：防御火花 + `break_def` 在矩形中心。

#### `renderDefensHiting`（L2018–2028）

hold 减到 0 **且** `getVecX()==0` 才清 `isDefenseHiting`。滑步没停完会一直占着 `render()` 的防住分支（只能转向，不能出招）。

---

### 抓取检测（L2030–2102）

#### `renderCheckTargetHit`（L2030–2061）

无 checker 名 return。`FighterCtrler.getHitCheckRect(name)` 把子 MC 矩形转到世界。`getTargets()` 扫对方活着的精灵，只对 `FighterMain` 取 `getBodyArea`，相交则 `doAction(hitTarget)`。循环不 break，多名敌人可重复 `doAction`。时间轴需自己 `clearAction` 或切走以免每帧重入。

#### `allowCatch`（L2064–2102）

无当前目标 false。目标是 `FighterMain` 且 state==21（硬直）false——**不能抓硬直中的人**（击飞 22 反而可以）。双方 body 矩形缺失 false。必须面对目标（自己在左须朝右）。水平间隙（矩形不相交的缝）`< 2` 且 `|dy|<1`。贴身且几乎同一高度才摔。

---

### 倒地起身 / 开场胜负（L2104–2144）

#### `doHurtDownJump`（L2104–2126）

已在「起身」return。连段伤害 &gt;240 或能量 &lt;30 return。`stopHurtFly` 停 MC 击飞状态机，耗能 30，保留当前 `vecX`，`doAction("起身")`，无敌，速度设回 vx、阻尼 `vx*0.1`，`HURT_RESUME`。`renderHurtFlying` 的 dashJump 窗调用。

#### `sayIntro`（L2128–2132）

`actionState=60`，`goFrame("开场")`。`GameStartCtrl` 经 `FighterMain.sayIntro`。不 `doAction`，不开全招。

#### `doWin`（L2134–2138）

state 61，「胜利」。`GameEndCtrl` 要 `isAllowWinState`（非 12/13/50）才调 `win()`。

#### `doLose`（L2140–2144）

state 62，「失败」。`GameOverState` 失败角色。

---

### 鬼步（L2146–2231）

地面 `ghostStep`（冲+下）、`ghostJump`（冲+上）；空中 `ghostJump` / `ghostJumpDown`（冲+下）。三者都先 `startGhostStep`。

#### `doGhostStep`（L2146–2154）

成功：`move(8,0)`（vx=8*direct），循环「走」，`_ghostType=0`。

#### `doGhostJump`（L2156–2166）

成功：`move(0,-12)` + `damping(0,0.1)`，「跳」停帧，`jumpTimes--`，type=1。

#### `doGhostJumpDown`（L2168–2176）

成功：`move(0,15)`，「落」，type=2。

#### `startGhostStep`（L2178–2197）

`qi<60` 或 `hasEnergy(80, true)` 失败 → false。耗气 60、能 80。朝向敌人。`_ghostStepIng=true`，`_ghostStepFrame = 30*0.4 = 12` 动画帧。无敌 + 穿人。`effectCtrler.ghostStep()`（蓝残影 + 全局鬼步滤镜）。

#### `renderGhostStep`（L2199–2223）

帧减到 ≤0：type 1 保留当前 `vy`，`isJumping=false`，`endGhostStep` 后再 `setVelocity(0, vy)`、`setDamping(0, -vy/10)`（上升时 -(-12)/10=1.2 有阻尼；下落时负阻尼 → `renderVelocity` 因 damping≤0 不减速），`setAirMove(true)` return。其它 type 直接结束。type 2 期间若 `GameLogic.isTouchBottomFloor` 提前结束（别鬼步穿底）。

#### `endGhostStep`（L2225–2231）

清闩，`endGhostStep` 特效，再朝向敌人，`idle()`。

---

### 帧标签速查（时间轴 / 本类硬编码）

| 标签 | 谁切 | 备注 |
|------|------|------|
| 站立 | `idle` | 主轴停止，5 动画帧对一次方向 |
| 走 | `doMove` / 鬼步 / `loop` | |
| 防御 / 防御恢复 | `setDefenseAction` / 松防 | 防御只播 3 帧 |
| 起跳 / 跳 / 跳中 | 跳跃状态机 | |
| 落 / 落地 | `fall` / `touchFloor` | |
| 瞬步 | `doDash*`，时间轴再 `dash()` | |
| 砍1… / 砍技 / 招 / 摔 / 必杀 | `doAction` | 角色自定义连段名 |
| 跳砍 / 跳招 / 空中必杀 | 空中 `doAction(..., true)` | |
| 万解 / 万解W / 万解S | `doWaiKaiAction` | 300 气 |
| 被打 / 击飞 / 击飞_* | `doHurt` / `FighterMC` | |
| 起身 | `doHurtDownJump` | |
| 开场 / 胜利 / 失败 | intro/win/lose | |

### 事件一览

| 事件 | 何时 | 谁听 |
|------|------|------|
| `DO_ACTION` | 每次 `doAction` | 本包无 |
| `FIRE_BULLET` | `fire` | `FighterEventCtrl` → `Bullet` |
| `ADD_ATTACKER` | `addAttacker` | → `FighterAttacker` |
| `ADD_ASSISTER` | 助战键 + fzqi 满 | → 已加载的 `fuzhu` |
| `DIE` | 掉血后 `checkFighterDie` | → `gameEnd` |
| `HURT_RESUME` | 硬直结束 / 爆发 / 倒地起身 | 清连击数 |
| `HURT_DOWN` | **FighterMC** 倒地，非本类 | 清连击数 |
