# `FighterEventCtrl` — 招式事件桥到 `GameCtrl`

一句话目的：把 `FighterEventDispatcher` 上的子弹/攻击体/辅助/连击/死亡事件接到 `GameCtrl` 的精灵表、HUD 连击和 `gameEnd`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/FighterEventCtrl.as`（186 行）

## Callers / callees

- **Callers**：仅 `GameCtrl.initlize` `new`+`initlize()`；`destory` 时 `destory()`；`GameCtrl.getAttacker` 转调 `getAttacker`。
- **Dispatchers（事件源）**：
  - `FIRE_BULLET`：`FighterMcCtrler.fire`、`FighterAttackerCtrler`、`AssisiterCtrler`。
  - `ADD_ATTACKER`：`FighterMcCtrler.addAttacker`、`AssisiterCtrler`。
  - `ADD_ASSISTER`：`FighterMcCtrler`。
  - `HIT_TARGET`：`GameLogic.hitTarget`（双方都是 `FighterMain` 且目标 state 21/22）。
  - `HURT_RESUME`：`FighterMcCtrler` 受击结束。
  - `HURT_DOWN`：`FighterMC` 倒地。
  - `DIE`：`FighterMcCtrler` 死亡动画。
- **Callees**：`GameCtrl.add/removeGameSprite`、`getEnemyTeam`、`gameEnd`、`gameState.gameUI`；`GameLogic.addHits/addScoreByHitTarget/getHitsObjByTargetId/clearHitsByTargetId`；`Bullet`/`FighterAttacker`/`Assister`；`EffectCtrl.assisterEffect`。

## 命名备注

- `initlize` / `destory`：原拼写。
- 事件名是字符串字面量，与 `FighterEvent` 常量同文（`FIRE_BULLET` 等）。
- `_attackers` 只收 `FighterAttacker`，子弹/辅助不进这个数组。
- `AssisiterCtrler` 类名本身少一个 s，本文件不出现该类名。

## 逐行说明

### 字段 / 构造（L20–25）

`_attackers:Array = []`。构造空。

### `initlize`（L27–37）

`removeAllListeners()` 后再绑 7 个。`GameCtrl.initlize` 每场重建 ctrl，避免上一场监听残留。未听 `DO_ACTION`。

### `destory`（L39–42）

再 `removeAllListeners()`。不清 `_attackers`（随 ctrl 一起丢）。

### `fireBullet`（L44–55）

`params` 无或无 `mc` → return。`new Bullet(mc, params)`，`onRemove=removeBullet`，`setHitVO(params.hitVO)`，按 **发射者** `fighter.team.id` `addGameSprite`。子弹因此进该队 `TeamVO.children`，会对**对方队**做 `checkHit`/`checkBodyHit`。

### `removeBullet`（L57–60）

`Bullet.onRemove` 回调 → `GameCtrl.removeGameSprite`。

### `addAttacker`（L62–75）

同样要 `params.mc`。`new FighterAttacker(mc, params)` → `onRemove=removeAttacker` → `setOwner(fighter)` → `init()` → `_attackers.push` → `addGameSprite(owner.team.id)`。`FighterMcCtrler.getAttacker(name)` 靠这张表按 name+team 找回。

### `addAssister`（L77–90）

不 new：从 `gameRunData` 对应组的 `fuzhu`（`LoadingState` 已加载）取出。

1. owner = 事件 `fighter as FighterMain`。
2. team 1 → `p1FighterGroup.fuzhu`，否则 P2。
3. `setOwner`、`direct=owner.direct`、`x = owner.x - 30*direct`（出现在背后）、`y=owner.y`。
4. `onRemove=removeAssister`，`addGameSprite`，`EffectCtrl.assisterEffect`，`goFight()`。

无 null 护栏：组里没 `fuzhu` 会 NPE（?）。

### `removeAssister` / `removeAttacker`（L92–105）

都 `removeGameSprite`。攻击体额外 `_attackers.splice`（找不到 index 则不管）。

### `getAttacker`（L107–117）

线性扫 `_attackers`，`name==param1 && team.id==param2`。没有返回 null。角色时间轴 `getAttacker("flymc")` 等依赖这个。

### `onHitTarget`（L119–126）

`addHits(fighter as FighterMain, params.target)`。街机且 **P1 队** 才 `GameLogic.addScoreByHitTarget(params.hitvo)`（注意字段小写 `hitvo`，与 `GameLogic.hitTarget` 写入一致）。P2/CPU 打人不加分。

### `onHurtResume` / `onHurtDown`（L128–136）

都 `removeHits(fighter.id)`：受击结束或倒地清**以自己为 target** 的连击。连击挂在攻击者 id 上、target 是受击者 id。

### `addHits`（L138–155）

- 目标 id：仅 `BaseGameSprite` 才取 `.id`，否则 null（仍可计数）。
- `uiID`：`team.id-1` switch，1→1、2→2，默认已是 1。
- `GameLogic.addHits(attackerId, targetId, uiID)` 返回新 hits。
- `>1` 才 `showHits(hits, uiID)`（第一下不弹连击 UI）。

### `removeHits`（L157–165）

`getHitsObjByTargetId` 有则 `hideHits(uiID)`，再 `clearHitsByTargetId`。按 **受击者** id 清，不是攻击者。

### `onDie`（L167–184）

败者 = `param1.fighter as FighterMain`。`getEnemyTeam` 扫 `children`，**第一个** `FighterMain` 当胜者（同队子弹/Attacker 不是 `FighterMain`，一般就是对面当前角色）。然后 `GameCtrl.I.gameEnd(winner, loser)`。练习模式 `GameLogic.checkFighterDie` 恒 false，正常不会派 `DIE`。
