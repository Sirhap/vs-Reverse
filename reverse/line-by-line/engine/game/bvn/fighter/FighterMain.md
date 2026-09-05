# `FighterMain` — 可操作角色本体（HP/气/能量/受击合同）

一句话目的：`BaseGameSprite` 的角色子类。持有 `FighterCtrler`（再挂 `FighterMcCtrler` / 特效 / hit 模型）、`FighterVO` 数据、气/能量/辅助气、钢体、目标队。`GameMainLogicCtrler.checkHit` 对角色走这里的 `getCurrentHits` / `getBodyArea` / `hit` / `beHit`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterMain.as`（628 行）

## Callers / callees

- **创建**：`GameLoader.loadFighter` `new FighterMain(mc)`，写入 `data=FighterVO`。`LoadingState` 放进 `GameRunFighterGroup.fighter1/2/3`。
- **入场**：`GameCtrl.addFighter`：P1 总是 `FighterKeyCtrl`；P2 在 VS CPU / 闯关（`isAcrade`）时 `FighterAICtrl`，否则键控 `"P2"`。然后 `initlize()` → `setActionCtrl` → `addGameSprite`（写 `team` 和 `targetTeams = 其它队`）。换人 `nextFighter` 再走同一路径。
- **主循环**：`GameMainLogicCtrler.renderGameSprite` → 基类重力后 `render` / `renderAnimate`。对撞走覆盖的 `getBodyArea`/`getCurrentHits`/`hit`/`beHit`。
- **时间轴脑不在本文件**：`FighterMcCtrler`（2234 行）经 `_fighterCtrl.getMcCtrl()` 调本类的 `jump`/`addQi`/`useQi`/`useEnergy`/`hasEnergy`/`loseHp`（经 `beHit` 链）/`replaceSkill`/`energyExplode`/`clearHurtHits`/`currentHurtDamage`/`hurtBreakHit`/`getLastHurtHitVO`/`actionState`/`isSteelBody` 等。
- **其它调用**：
  - `GameStartCtrl.sayIntro`；`GameEndCtrl.win`；`GameOverState.lose`；`GameState.idle`。
  - `GameLogic.resetFighterHP` 读 `customHpMax`；`hitTarget` 要求双方都是本类且目标 state 21/22。
  - `Assister`/`Bullet`/`FighterAttacker.hit` 给 **owner 角色** `addQi`。
  - `TrainingCtrler` 读写 `hp`/`qi`/`fzqi`/`actionState`。
  - `FightUI` / `QiBar` 读 `qi`/`fzqi`/`actionState`。
  - `SpecialEffectView`/`SteelHitEffect`/`BuffEffectView`：`changeColor`/`resumeColor`。
  - `FighterAILogicBase.targetInRange`：`getHitRange`。
- **Callees**：`FighterCtrler`、`FighterBuffCtrler`、`FighterMC`（经 McCtrl）、`HitVO`、`GameLogic.hitTarget`、`FighterActionState.isAttacking/isHurting`。

## 命名备注

- `initlize` / `destory`：原拼写。
- `fzqi`：辅助气（fuzhu qi），满 100 才能 `ADD_ASSISTER`。
- `energyOverLoad`：能量透支后慢回，过 30 解除。
- `defenseType`：`FighterDefenseType.SWOARD=0` / `HAND=1`，本文件只存，判定在 McCtrler。
- `qiMax`/`fzqiMax` 是 `const`，`qi` 钳位写死 `300` 而不是读 `qiMax`。
- `hasWankai` / `die` / `relive`：本包 **无调用点**（SWF/插件 API?）。

## 与战斗循环的合同

```
GameMainLogicCtrler.checkHit
  A.getCurrentHits() → HitVO[]（含 explode 窗）
  B.getBodyArea()    → 受击盒（转 Mc 的 bdmn）
  B.beHit(hitVO, rect) → McCtrler.beHit → loseHp / 切受击动画
  A.hit(hitVO, B)      → addQi + GameLogic.hitTarget
checkBodyHit
  双方 getBodyArea() 挤开（基类 move）
```

子弹/攻击体/辅助打中角色同样走 `FighterMain.beHit`；角色打中他们走各自 `hit`（给 owner 加气）。

## 逐行说明

### 字段（L19–81）

资源：

- `qi` / `qiMax=300`：必杀气。`useQi`/`addQi`；`render` 再钳 `[0,300]`。
- `energy` / `energyMax=100` / `energyOverLoad`：冲刺/防御/钢体消耗。`hasEnergy`/`useEnergy`。
- `customHpMax`：0 表示用默认；`GameLogic.resetFighterHP` 优先它。`FighterCtrler.hp` setter 会把 `hp/hpMax/customHpMax` 一起写。
- `fzqi` / `fzqiMax=100`：辅助槽。`McCtrler.renderAssist` 满 100 且按 assist 则清 0 派 `ADD_ASSISTER`。
- `speed=6` / `jumpPower=15`：走速（McCtrler 冲刺 `speed*n`）、跳跃初速（本类 `jump()`）。
- `isSteelBody` / `isSuperSteelBody`：`McCtrler.setSteelBody` 写。超钢体 = 钢体且第二参 true（爆气）。
- `data:FighterVO`：加载时赋。`initlize` 用 `data.startFrame`；受身 `data.comicType==1` 走替身而非爆气。
- `airHitTimes=1` / `jumpTimes=2`：模板次数。`idle` 拷到 `FighterAction`。
- `actionState=0`：见 `FighterActionState`。本类只读 20/21/22/30 和谓词。
- `defenseType=0`：SWF/`FighterCtrler` 写入。
- `lastHitVO`：最近一次 **自己打出** 的 HitVO（`hit()`）。
- `_buffCtrler`：`initlize` 建。
- `_currentHurts`：本段受击（state 21/22）累计的 HitVO，给受身判定。
- `hurtHit` / `defenseHit`：当前被打/防住的 HitVO。`FighterCtrler.justHit`、辅助 `justHit` 读。
- `targetTeams`：`addGameSprite` 写成其它队。`getTargets` 扫这些队的活孩子。
- `_currentTarget`：锁敌缓存。
- `_fighterCtrl`：总控。
- `_energyAddGap`：用能量后暂停回能的动画帧。
- `_explodeHitVO` / `_explodeHitFrame` / `_explodeSteelFrame`：爆气攻击盒与钢体窗。
- `_replaceSkillFrame`：替身无敌剩余动画帧。
- `_speedBack`：声明后 **从未读写**（死字段）。
- `_colorTransform`：同角色染色基底（P2 镜像绿偏）。

### 构造（L83–87）

`super(mc)` 后立刻 `_area = null`。基类本来用 MC `getBounds` 当显示盒；角色改走 `getBodyArea`（`bdmn`）。`getArea` 第一次调用才缓存。

### `colorTransform` 存取 / `changeColor` / `resumeColor`（L89–108）

- setter：存并立刻写 `_mainMc.transform.colorTransform`；`null` → 新的空 CT。`GameCtrl.buildGame` 同角色镜像给 P2 绿偏。
- `changeColor`：只改 MC，**不**动 `_colorTransform`（特效临时染色）。
- `resumeColor`：回到基底或空 CT。`SpecialEffectView` / `SteelHitEffect` / `BuffEffectView` 成对调用。

### `destory`（L110–135）

`param1==false` **整函数 return**，连 `super.destory` 都不走（与基类「false 只闩状态留 MC」不同）。本包未见 `destory(false)`。

`param1==true`：`_fighterCtrl.destory()`、MC `filters=null` + `gotoAndStop(1)`、buff destory、清空 target/hurts，再 `super.destory(true)`。

### `attackRate` setter（L137–144）

`super.attackRate =` 后，若已有 `hitModel` 则 `setPowerRate`。Arcade 敌方 `GameLogic.setMessionEnemyAttack` 走这里，让 HitVO `powerRate` 跟倍率走。须在 `initlize` 之后写才有效。

### 受击累计（L146–184）

- `currentHurtDamage`：`_currentHurts` 各 `getDamage()` 之和。无表返回 0。`McCtrler.renderHurtBreak`：`>210` 不能受身；`doHurtDownJump`：`>240` 不能倒地起身。
- `getLastHurtHitVO`：最后一记。受身若 `isBisha()` 则拒绝。
- `hurtBreakHit`：任一 `isBreakDef` 则 true → 受身拒绝。
- `clearHurtHits`：置 null。`idle` 时清。

`beHit` 只在 `actionState==21||22` 时 push，所以倒地 23/24 不再累。

### `getCtrler` / `getBuffCtrl`（L186–194）

给时间轴、AI、攻击体拿总控/buff。

### `getCurrentTarget`（L196–244）

缓存 `_currentTarget` 仍是活着的 `BaseGameSprite` 则直接返回（**不**重新挑最近的）。死了或非 Base 才重选：

`getTargets()` 展平敌队活孩子，按 `order` 排序（`sortOn(..., 16)` = NUMERIC）：

| order | 条件 |
|---|---|
| 0 | 活着的 `FighterMain`（优先锁人） |
| 1 | 其它活着的 `BaseGameSprite`（攻击体 `isAlive` 默认 true） |
| 2 | 其余（`Bullet` 不是 Base，走这里） |
| 5 | `getBodyArea()==null`（攻击体/无盒者垫底） |

同 order 不比距离，取排序后第一个。辅助 `isAlive=false` 不进 `getAliveChildren`。

### `getTargets`（L246–260）

无 `targetTeams` 返回 null。否则 `concat` 各队 `getAliveChildren()`。Bullet 不是 Base → 永远算「活」；Assister `isAlive=false` 被滤掉。

### `getMC`（L262–273）

`_fighterCtrl.getMcCtrl().getFighterMc()`，任一层空则 null。`Bullet.setHitVO` / `FighterAttacker.init` 用 MC 的 x/y 做发射点偏移。

### `setActionCtrl`（L275–282）

已有 `_fighterCtrl` 才转发 `setActionCtrl` 并立刻 `param1.initlize()`。`GameCtrl.addFighter` 顺序是先 `initlize()`（建 Ctrler）再本方法，故安全。

### `initlize`（L284–296）

1. `new FighterCtrler()`。
2. SWF 必须有 `setFighterCtrler`，否则 `throw "初始化失败，SWF未定义setFighterCtrler()"`。
3. `_mainMc.setFighterCtrler(_fighterCtrl)` → `_fighterCtrl.initFighter(this)`（内部再要求 `setEffectCtrler` / `setFighterMcCtrler`，并由 SWF 稍后 `initMc` 建 `FighterMC`）。
4. `new FighterBuffCtrler(this)`。
5. `_mainMc.gotoAndStop(data ? data.startFrame+1 : 2)`：角色 SWF 第 1 帧常是加载/定义，从 startFrame+1 进战斗姿势。

### `renderAnimate`（L298–342）

`super`（动画通道 delay）后，已销毁 return。顺序：

1. `renderEnergy()` / `renderFzQi()`——回能挂在 **动画帧**（约 30fps），不是逻辑帧。
2. `_fighterCtrl.renderAnimate()` → McCtrler 进 MC 帧、受击硬直倒数。
3. 爆气窗 `_explodeHitFrame`：减 1；**==8** 时 `idle()` 且 `isAllowBeHit=false`（爆气盒还剩 8 帧）；`<=0` 清 VO、恢复可挨打。
4. `_explodeSteelFrame`：每帧强制 `setSteelBody(true,true)`（超钢），到 0 关掉。
5. `_replaceSkillFrame`：到 0 恢复可挨打。

### `render`（L344–383）

`super.render()`（速度积分 + 同步 MC 坐标）后：`_fighterCtrl.render()`（输入轮询/出招）、`_buffCtrler.render()`，再钳 `hp∈[0,hpMax]`、`qi∈[0,300]`、`fzqi∈[0,100]`。负 hp 在 `loseHp` 已钳，这里是双保险。

### `jump`（L385–390）

`_g=0`（清重力累加，上升段 `applayG` 见 vy<0 也会清）、`setVelocity(0, -jumpPower)`、`setDamping(0, 0.5)`。`McCtrler.renderJumpAnimate` 在起跳延迟结束时调用。不改 `isInAir`——下一逻辑帧 `GameLogic.isInAir` 因 vy<0 判空中。

### `getCurrentHits`（L392–399）

爆气 VO 存在且 `_explodeHitFrame < 8` → 只返回 `[_explodeHitVO]`（覆盖普攻盒）。否则 `_fighterCtrl.getCurrentHits()`（从 `FighterMC.getCurrentHitArea` 转世界坐标）。

### `getBodyArea`（L401–408）

无 ctrl 返回 null。否则 `_fighterCtrl.getBodyArea()` ← `FighterMC.getCurrentBodyArea()`（`bdmn`）再 `getCurrentRect`。`checkHit`/`checkBodyHit` 的受击/挤开盒。

### `hit`（L410–432）—— 打中别人

`super.hit`（同父节点则攻击者提到上层）。`lastHitVO = param1`。

气：仅目标是 `FighterMain` 时加。必杀 `isBisha()` → `power*0`（不加气）；否则 `power*0.17`，封顶 15。`addQi` 后再 `GameLogic.hitTarget(hitVO, this, target)`（双方都是角色且目标 21/22 才派 `HIT_TARGET` 连击）。

打子弹/辅助/攻击体不加这档气（他们自己的 `hit` 给 owner 加）。

### `beHit`（L434–456）—— 被打

`!isAllowBeHit` return（无敌、爆气前半、替身、冲刺部分）。`super.beHit` 空。然后 `McCtrler.beHit`（扣血、切被打/击飞、钢体/防御分流、可能派 `DIE`）。

自己也加气：`power*0.08` 封顶 20。state 21/22 时把这记 HitVO push 进 `_currentHurts`。

### `renderEnergy`（L458–488）私有

`_energyAddGap>0` 则减 1 return（用能量后约 24 动画帧不回）。未满 `energyMax`：

| 条件 | 每动画帧 |
|---|---|
| `energyOverLoad` | +0.6，超过 30 解除 overload |
| `actionState==20` 防御 | +0.8 |
| `isAttacking`（10–13） | +1.1 |
| 其它 | +2 |

### `renderFzQi`（L490–496）私有

`<100` 则 +0.2 / 动画帧。满 100 约 500 动画帧 ≈ 16.7s（30fps 动画）。

### `hasEnergy`（L498–512）

`energy >= param1` 即 true。`param2==true`（允许透支）：只要 **还没** overload 也 true（哪怕当前 energy 不够）。`McCtrler` 冲刺/防御 `hasEnergy(n, true)`。

### `useEnergy`（L514–523）

`energy -= param1`；`_energyAddGap = 0.8*30`（写死 30，不读 `FPS_GAME`）。`<0` 钳 0 并 `energyOverLoad=true`。

### `useQi`（L525–533）

不够返回 false **不扣**。够则扣并 true。必杀/万解/受身走这里。

### `addQi`（L535–542）

加完 >300 钳 300。`hit`/`beHit`/子弹/辅助/攻击体都汇到这。

### `sayIntro` / `win` / `idle` / `lose`（L544–562）

转 `McCtrler.sayIntro` / `doWin` / `idle` / `doLose`（切 开场/胜利/站立/失败 帧 + 写 actionState）。`GameStartCtrl` / `GameEndCtrl` / `GameState` / `GameOverState` 调。

### `getHitRange`（L564–567）

`_fighterCtrl.getHitRange` ← `FighterMC` 的 `AImain` 第 2 帧里按 `FighterHitRange` 名字取盒，再转世界。AI `targetInRange("kj1mian")` 等。

### `energyExplode`（L569–583）

`EffectCtrl.energyExplode`；立刻超钢体。`new HitVO`：区域 `(-100,-200,200,210)` 经 `getCurrentRect` 变世界盒；`power=50`、`hitx=15*direct`、`hitType=5`、`hurtType=1`（击飞）。窗 10 动画帧，钢体 60 帧，期间 `isAllowBeHit=false`。`getCurrentHits` 在后 8 帧吐这个 VO。火影受身（`comicType!=1`）走这条。

### `replaceSkill`（L585–595）

特效 `replaceSkill`；`move(250*direct)` 瞬移；`idle()`；无敌；**立刻** `super.render()` + `renderAnimate()` 把位移和站立帧套上；`setDirectToTarget` 转身；30 动画帧后恢复可挨打。死神受身（`comicType==1`）。

### `getArea`（L597–604）

`_area` 空则 `_area = getBodyArea()`（已是世界坐标），然后 **原样返回**，不再 `+x/y`。只缓存 **第一次** 的盒子，角色移动后可能过期（?）。`MapMain` 前景遮罩用。与基类「本地盒 + 平移」不同。

### `hasWankai`（L606–609）

`getFighterMc().checkFrame("万解")`。本包无调用；`McCtrler.setWankai` 自己 `checkFrame`。

### `die`（L611–619）

`hp=0`、`isAlive=false`。若当前不是受击四态且不是 30，补 `playHurtDown()`。正常死亡由 `McCtrler.doHurt` 在 `checkFighterDie` 时派 `DIE` 并置 `isAlive=false`，击飞状态机落地后把 state 改 30。本方法本包未见调用。

### `relive`（L621–625）

`isAlive=true` + `idle()`。不回血。本包未见调用（练习模式直接改 hp，不走死亡）。
