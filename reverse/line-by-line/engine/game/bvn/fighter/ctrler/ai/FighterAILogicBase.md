# `fighter.ctrler.ai.FighterAILogicBase` — CPU 决策基类

一句话目的：每动画帧刷新目标/连招标志，按 `AILevel` 掷骰，查距离与 `AImain` 招式面，并给子类 `FighterAILogic` 提供破防/击倒缓存与连招优先级仲裁。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogicBase.as`（238 行）

## Callers / callees

- **子类**：仅 `FighterAILogic`。
- **构造**：`FighterAICtrl.initlize` → `new FighterAILogic(AILevel, fighter)` → `super(AILevel, fighter)`。`AILevel` 来自 `FighterAICtrl.AILevel` ← `GameCtrl.addFighter` 写 `MessionModel.I.AI_LEVEL` ← `MessionModel.initMession` 抄 `GameData.I.config.AI_level`（`ConfigVO`，设置 COM LEVEL 1–6）。
- **每帧**：`FighterAICtrl.renderAnimate` 调 `FighterAILogic.render` → `super.render()`。`FighterAICtrl.render()` 是空的，AI **只在动画帧** 想招。
- **Callees**：`FighterMain.getCurrentTarget/getCtrler/getHitRange`、`FighterMcCtrler.getAction`、`FighterHitModel.getHitVOLike`、`HitVO.isBreakDef/hurtType`、`IGameSprite.getBodyArea`。
- `mergeRateObject`、`targetInDistance`：**本仓库无调用**（死代码）。

## 命名备注

- `destory`：原拼写。
- `defult`：子类 rate map 的默认键，缺 `a`（default）。基类用 `param1.defult` 读同一键。
- `_isConting`：连招中（combo-ing），`actionState` 10/11/12/13。
- `_contOrder`：本帧候选招的 `{id, order}` 表，**不是**字符串数组。
- `AILevel` 0 与 1 共用第一档阈值；设置项没有 0（VERY EASY=1 … HELL=6）。

## 决策骰子

`getAIResult(r0, r2, r3, r4, r5, r6)`：`Math.random()*10` 与对应档比较，`<` 则 true。阈值 10 ≈ 100%，1 ≈ 10%。

| 设置 `AI_level` | switch | 用第几个参数 |
|---|---|---|
| （未用）0 / VERY EASY 1 | case 0,1 | r0 |
| EASY 2 | 2 | r2 |
| NORMAL 3 | 3 | r3 |
| HARD 4 | 4 | r4 |
| VERY HARD 5 | 5 | r5 |
| HELL 6+ | default | r6 |

`getAIByFighterState(map)` 看的是 **目标** `_targetFighter.actionState`，不是自己。缺键则 `map.defult`。目标不是 `FighterMain` 时 state=-1，必走 default。

`FighterActionState` 对照（子类 rate 表常用）：`0 NORNAL`、`10 ATTACK_ING`、`11 SKILL_ING`、`12 BISHA_ING`、`13 BISHA_SUPER_ING`、`14 JUMP_ING`、`16 HURT_ACT_ING`、`20 DEFENCE_ING`、`21 HURT_ING`、`22 HURT_FLYING`、`23 HURT_DOWN`、`40 FREEZE`。

## 逐行说明

### 字段 / 构造（L13–36）

- `AILevel`、`_fighter`：构造写入。
- `_fighterAction`：`render` 里懒取一次 `McCtrl.getAction()`。
- `_target` / `_targetFighter`：每帧 `getCurrentTarget()`。
- `_breakActCache` / `_hitDownActCache`：按招式 id 前缀记是否破防/击倒。
- `_contOrder = []`。
- 构造：`AILevel = param1`，`_fighter = param2`。

### `destory`（L38–46）

清空 fighter/action/target 与两份 cache。**不清** `_contOrder`。`FighterAICtrl.destory` 调用。

### `addContOrder`（L48–62）

签名：`addContOrder(id:String, order:int)`。

本意：同 id 已在表里则改 `order`，否则 `push({id, order})`。

实现：`_contOrder.indexOf(id)` 在 **对象数组** 里找字符串，恒 `-1`，因此 **每次都 push**。同 id 两笔时，`updateContOrder` 可能把后一条的 `this[id]=false` 覆盖前一条（当前子类同一帧不会对同一 id 调两次）。

### `updateConting`（L64–67）

`_isConting` = 自己 `actionState` ∈ {10 攻击中, 11 技能中, 12 必杀中, 13 超必杀中}。即 `FighterActionState.isAttacking`。

### `render`（L69–80）

1. `_target = _fighter.getCurrentTarget()`，`_targetFighter = as FighterMain`。
2. `updateConting()`。
3. 若还没有 `_fighterAction`，从 `getMcCtrl().getAction()` 取（`FighterAction` 的「这一招现在能不能出」开关）。
4. `updateActionAI()`（子类覆盖）。
5. `updateContOrder()`。

子类 `FighterAILogic.render` 先 `super.render()`，再跑移动/跳/防御等，所以 **走位不进连招仲裁**。

### `updateContOrder`（L82–99）

空表 return。`sortOn("order", 2)`：`Array.DESCENDING=2`，**没有** `NUMERIC=16`，按字符串降序。现有 order 10/100/110/150/200/210/300 碰巧与数值序一致。

下标 0（最高优先）保留为 true；`i=1..n-1` 把 `this[id] = false` 清掉落选招。然后 `_contOrder = []`。

`this[id]` 依赖子类把招式名做成 **public 字段**（`attack`/`skill1`/`bisha`…）。基类自己没有这些字段。

### `updateActionAI`（L101–104）

空。子类覆盖。

### `getAIByFighterState`（L105–112）

`defult` 数组 + 可选 `[actionState]` 覆盖。取 6 元数组喂 `getAIResult`。目标非角色时 `_loc4_=-1`。

无护栏：`defult` 缺失或长度不足会在读 `_loc3_[5]` 时炸（?）。

### `getAIResult`（L114–133）

见上表。`Math.random()*10` 每调用独立，同一帧多次判定互相独立。

### `getTargetDistance`（L135–140）

`Point(abs(dx), abs(dy))`。世界坐标，不看朝向。

### `targetInDistance`（L142–146）

`dx<=param2 && dy<=param3`。子类未用。

### `targetInRange`（L148–161）

`param1` = `FighterHitRange` 名（`kanmian`/`kj1mian`/`bsmian`…）。目标 `getBodyArea()` 与自己 `getHitRange(name)`（`FighterMC` 从 `AImain` 帧 2 的子 MC `getBounds`）求交，非空则 true。任一方矩形 null → false。

### `mergeRateObject`（L163–184）

把 `param2` 的键并进 `param1`：新键直接拷；已有键则按下标取 **较大** 阈值。内层 `while` 的 `_loc3_` **在 for-in 外初始化且不重置**，第二键起下标可能已经走完，合并残缺。无调用方。

### `isBreakAct`（L186–203）

`param1` 是 hit id 前缀（`kj1`/`bs`/`zh1`…）。有 cache 则返回。否则 `hitModel.getHitVOLike(prefix)`（id **包含** 该串的全部 HitVO），任一 `isBreakDef` → cache true。全无则 false。

### `isHitDownAct`（L205–222）

结构同 break，但条件 `hurtType == 1`（击飞/倒地）。

**bug**：命中与否都写 `_breakActCache`，**从不写** `_hitDownActCache`。因此：

- `_hitDownActCache` 永远空，每帧重扫 HitVO。
- 调用后 `_breakActCache[id]` 被改成「是否击倒」，`isBreakAct` 之后再读就是错的。

子类 `getSkillAI` 先 `isBreakAct` 再 `isHitDownAct`，**同一帧** break 判定仍正确；**下一帧** `isBreakAct` 读到的是击倒结果。

### `targetCanBeHit`（L224–235）

无 `_target` → false。是 `FighterMain` → `isAllowBeHit`。否则有 `getBodyArea()` 即可（子弹/Attacker 当靶）。
