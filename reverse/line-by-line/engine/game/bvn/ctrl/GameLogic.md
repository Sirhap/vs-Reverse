# `GameLogic` — 对局规则：落地、出界、连击、分数、血量、选人过滤

一句话目的：无状态规则库。绑定当前 `MapMain`/`GameCamera` 后，给物理循环判空中/贴地/出界/夹边；给战斗事件记连击和加分；给开局按闯关关卡重置 HP/攻击倍率；给选人表过滤可选项。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameLogic.as`（409 行）

## Callers / callees

- **Callers**：
  - `GameCtrl.doStartGame`：`initGameLogic(map, camera)`；`destory`：`clear()`；P1 KO 且闯关：`addScoreByKO`。
  - `GameMainLogicCtrler.renderGameSprite`：每精灵 `fixGameSpritePosition` + `isInAir`（落地则 `applayG(12)` 前先判空中）。
  - `EffectCtrl.render`：对 `_justRenderTargets` 再 `fixGameSpritePosition`。
  - `FighterEventCtrl`：`addHits` / `getHitsObjByTargetId` / `clearHitsByTargetId` / `addScoreByHitTarget`。
  - `FighterMain`/`Bullet`/`Assister`/`FighterAttacker`：`hitTarget`。
  - `Bullet`：`isTouchBottomFloor`（落地炸）、`isOutRange`（删弹）。
  - `FighterMcCtrler`：`checkFighterDie`、`isTouchBottomFloor`。
  - `GameState.initFight`/`resetFight`：`resetFighterHP`；闯关敌方再 `setMessionEnemyAttack`。
  - `MessionModel.messionComplete`：`addScoreByPassMission`。
  - `GameOverState` 续关：`loseScoreByContinue`。
  - `SelectFighterStage` 随机池：`canSelectFighter` / `canSelectAssist`。
  - `GameInterfaceManager.keyHandler`：Ctrl+F8/`119` → `setGameMode(1)`，Ctrl+F9/`120` → `setGameMode(0)`。
- **Callees**：`GameConfig.SPEED_PLUS`/`SPEED_PLUS_DEFAULT`、`MapMain`（`playerBottom`/`left`/`right`/`bottom`/`getFloorHitTest`）、`FloorVO.hitTest`、`GameCamera.getZoom`/`getScreenRect`/`autoZoomMin`、`GameMode`（`currentMode`/`isAcrade`）、`GameData.I`（`score`/`config`）、`MessionModel`、`FighterEventDispatcher`、`GameEvent`、`GameCtrl.I.gameRunData`、`ResUtils.WINNER`、`SelectIndexUI.SHOW_MODE`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `Mession*` | 原拼写，mission |
| `isAcrade` | 原拼写，arcade。`GameMode.TEAM_ACRADE=10` / `SINGLE_ACRADE=20` / `SURVIVOR=30` |
| `TRAINING = 40` | `checkFighterDie` 在此模式永不 true |
| `_hitsObj` | 以 **攻击者** `BaseGameSprite.id`（UUID）为 key |
| `uiID` | 1=P1 连击 UI，2=P2 |
| `sh1`/`sh2` | HitVO.id，疑似超必/特殊 hit，额外 +500 |
| `hurtType == 1` | 击飞类，额外 +200 |
| `salect.xml` | `setGameMode(1)` 的文件名，select 的故意/历史拼写 |
| `keyInputMode` | 0=现代（分数 ×1），非 0=经典（×0.8）。默认 1 |

## 逐行说明

### 静态字段（L28–34）

- `_map` / `_camera`：`initGameLogic` 写入。未 init 时 `isInAir`/`isTouchBottomFloor`/`isOutRange`/`fixGameSpritePosition` 会 NPE 或提前 false。
- `_floorContact: Dictionary`：key = `BaseGameSprite` 实例，value = 当前踩着的 `FloorVO`。用 Dictionary 才能以对象为键。
- `_hitsObj: Object`：连击表。`clear()` **不**清这两张表。

### 空构造（L36–39）

全静态。

### `initGameLogic`（L41–45）

记下本局地图和相机。`GameCtrl` 在 `gameState.initFight` 之后调用。不重置 hits/floor。换图再 init 会换 `_map`，旧 `_floorContact` 里的 FloorVO 属于上一张图 —— 正常路径 `destory` 会 `clear()` 但 Dictionary 仍可能残留精灵引用直到下次覆盖。

### `clear`（L47–51）

只 `_map=_camera=null`。**不清** `_hitsObj`、`_floorContact`。连击 UI 依赖 `FighterEventCtrl` 在 HURT_RESUME/DOWN 时自己 `clearHitsByTargetId`。Dictionary 里的精灵 key 在对局 destory 后可能泄漏到下一局（新精灵是新实例，旧 key 变垃圾）。

### `isInAir`（L53–97）—— 落地判定

给 `BaseGameSprite`（角色/辅助/攻击体等）。返回 true = 空中（调用方会 `applayG`）。

步骤：

1. `_map==null`：`trace("error:map is null!")`，返回 **false**（当成在地上，不再加重力）。
2. `getVecY() < 0`（上升）：`isTouchBottom = false`，true（空中）。跳起不会贴地。
3. `y > playerBottom - 12`：贴近/越过地图角色底线。把 `y` **吸附**到 `playerBottom`，`isTouchBottom=true`，返回 false。12 是像素容差，与 SPEED_PLUS 无关。
4. 否则 `isTouchBottom=false`。
5. 若 `getVecY() >= 5 * SPEED_PLUS`（下落够快）：直接 true，**不测地板**。防止高速坠落穿板时被中间平台「粘住」？实际上是：下落太快本帧不认平台，要等减速。60fps 时 `SPEED_PLUS=0.5`，阈值 2.5。
6. 平台厚度 `_loc4_ = 10 * SPEED_PLUS_DEFAULT`（与当前加速无关，跟默认帧率比）。60fps → 5px。
7. 若 Dictionary 里已有该精灵的 `FloorVO`：再 `hitTest(x,y,thickness)`。仍命中：`y = floor.y`，false。未命中：delete 记录，true（刚走下平台）。
8. 否则 `_map.getFloorHitTest(x,y,thickness)` 扫全部平台。命中：吸附 `y`，写入 Dictionary，false。
9. 都没有：true。

`FloorVO.hitTest`：`y` 在 `[floor.y - t, floor.y + t]` 且 `x` 在 `(xFrom, xTo)`（开区间）。

### `isTouchBottomFloor`（L99–107）

`y > playerBottom`（**没有** -12 容差，也 **不吸附**）。地图空则 false。

`Bullet` 用来「碰到角色底线就当击中地面」：`hit(hitVO, null)` + 震屏。`FighterMcCtrler` 用来判断倒地是否真到底。

与 `isInAir` 的 `isTouchBottom` 字段不是一回事：本函数不写该字段。

### `isOutRange`（L109–117）

`x > right+20 || x < left-20 || y > bottom+20`。**没有上界**。地图空则 false。

子弹出左右/底外 20px 删除。角色一般被 `fixGameSpritePosition` 夹在 left+10 / right-10，走不到这里，除非 `allowCrossMapXY()`。

### `addHits`（L119–132）

`(attackerKey, targetID, uiID) → 当前连击数`。

首次：建 `{hits:0, targetID, uiID}`。然后总是覆盖 `targetID`，`hits++`，返回新 hits。

`FighterEventCtrl.addHits` 传入：

- key = `FighterMain.id`（`UUID.create()`，不是 fighter.xml 的角色 id）
- targetID = 被击者 `BaseGameSprite.id` 或 null
- uiID = team.id==1 → 1，否则 2

hits>1 才 `showHits`。同一攻击者连续打不同人会改 `targetID` 但 **连击数累加不重置**。

### `clearHits`（L134–139）

把该 key 的 hits 置 0、targetID/uiID 置 null。**不 delete**。

本包 **零外部调用**。真正清连击走 `clearHitsByTargetId`。若 key 不存在会 NPE。

### `getHitsObj`（L141–144）

按攻击者 key 取整包。可能 undefined。

### `getHitsObjByTargetId`（L146–156）

扫描 values，第一个 `targetID==param` 的条目。多人同时被同一逻辑「当作目标」时只返回一个。用于受击结束时按 **被击者** 找该隐藏哪边的连击 UI。

### `clearHitsByTargetId`（L158–167）

`for-in` 键，匹配 `targetID` 则 `delete`。`FighterEventCtrl` 在 `HURT_RESUME` / `HURT_DOWN` 时调用（参数是 `fighter.id`）。先 `hideHits(uiID)` 再 delete。

### `checkFighterDie`（L169–176）

`GameMode.currentMode == 40`（TRAINING）→ 永远 false（练习模式不死）。否则 `hp <= 0`。

`FighterMcCtrler` 多处：仅当 `isAlive && checkFighterDie` 才切死亡。TrainingCtrler 另有锁血。

### `hitTarget`（L178–200）

把一次「打中」广播成 `HIT_TARGET` 事件，供连击/加分。

门：

1. attacker 或 target 空 → return。
2. 双方都必须是 `FighterMain`（子弹/辅助打中角色时，调用方传入的 attacker 是 **owner 角色**，见 `Bullet`/`Assister`/`FighterAttacker`）。
3. **target.actionState 必须是 21 或 22**（`HURT_ING` / `HURT_FLYING`）。防御、硬直、倒地、普通站立都不发事件。

碰撞顺序是 `beHit` 然后 `hit`（`GameMainLogicCtrler.checkHit`）。`beHit` 里 `McCtrl.beHit` 会把状态切到 21/22，所以 **成功击中的第一下也能过这道门**；防住/钢身则状态不是 21/22，不计连击。

payload：`{target, hitvo}`。`FighterEventDispatcher.dispatchEvent(attacker, "HIT_TARGET", payload)`。

### `addScoreByHitTarget`（L202–234）

只在 `GameMode.isAcrade() && attacker.team.id==1` 时由 `FighterEventCtrl.onHitTarget` 调用（P1 闯关才加分）。

基础分 = `hitvo.power`，再叠：

| 条件 | 加成 |
|------|------|
| `isBisha()`（id 含 `bs`/`sbs`/`cbs`/`kbs`） | power **再 ×2**（即 2×power，不是 +2） |
| `id == "sh1"` 或 `"sh2"` | +500 |
| `isBreakDef` | +200 |
| `hurtType == 1` | +200 |
| 连击数 `< 4` | + hits×50 |
| 连击数 `≥ 4` | + hits×100 |

连击数来自 `getHitsObj(1)`。key 是字面量 **1**，而 `addHits` 的 key 是攻击者 UUID。`Object[1]` 不会命中 UUID。**本包连击加分项恒为 0**（`_loc3_` undefined → hits=0）。`?` 像是想取 P1（uiID=1）的连击，但 API 按攻击者 id 索引。

最后 `addScore(_loc5_)` + `GameEvent("SCORE_UPDATE")`。

### `addScoreByKO`（L236–251）

P1 队伍赢且对方 `hp<=0` 且闯关。读 `p1FighterGroup.currentFighter`：

- `lastHitVO.isBisha()` → 先 +2000（超必 KO）。
- 满血（`hp == hpMax`）→ +20000，否则 +3000。

然后 `SCORE_UPDATE`。满血判定在扣血之后：能满血 KO 只有「这一击不掉自己血」的情况（例如对方自杀？）或 `hp` 已被重置。更常见是「Perfect」意图 —— 若当前血已因对打下降，走 3000。`?` 若 lastHitVO 空，`isBisha()` 短路不加点。

### `addScoreByPassMission`（L253–263）

`MessionModel.messionComplete` 且 `isAcrade`。

- `currentMode==10`（TEAM_ACRADE）**并且** 当前出战仍是 `fighter1`（第一个角色没换过）→ +15000。
- 否则 +5000。

无 `SCORE_UPDATE`（与 KO/Hit 不同）。UI 可能下一帧别的事件才刷。

### `addScore`（L265–269）私有

`keyInputMode==0` 系数 1，否则 0.8。写入 `GameData.I.score`（累加，允许非整数因为 0.8）。

默认 `keyInputMode=1`（经典键位），所以出厂分数是 80%。设置里改成「现代」才满额。

### `loseScoreByContinue`（L271–277）

`-10000`，下限 0。`GameOverState` 选 Continue 时。无 `SCORE_UPDATE`。

### `fixGameSpritePosition`（L280–335）—— 夹边

每帧每个 `IGameSprite`。

**水平**（`allowCrossMapXY()==false`，默认角色 false，攻击体可被设 true）：

- 初值：`left+10` … `right-10`。
- 若是 `FighterMain` 且 `getVecX()!=0` 且 **相机 zoom == autoZoomMin**（拉到最远，默认 1）：再用相机 `_noTweenRect` 收紧：
  - `screenLeft = rect.x / zoom + 10`
  - `screenRight = screenLeft + rect.width - 10`
  - 地图左界若比画面左界更左，改用画面左界（不让人走出镜头）；右同理。
  - zoom==1 时 `/ zoom` 是恒等。只在「镜头已经拉满还在走」时把人锁在可见区，避免走去地图边缘而镜头不再跟。
- `x` 钳到 `[leftBound, rightBound]`。碰到任一侧 `setIsTouchSide(true)`，否则 false。贴边用于推人/墙跳类逻辑。

**垂直底**（`allowCrossMapBottom()==false`）：`y > map.bottom` 则吸附。**不处理顶部**。不写 `isTouchBottom`（那是 `isInAir` 的职责）。

`_map`/`_camera` 为空会 NPE。`clear()` 后若仍有残留 `render` 会炸；`GameCtrl.destory` 先 `GameRender.remove` 再 `clear`，正常安全。

### `resetFighterHP`（L337–354）

开局/换人。倍率 `_loc2_` 默认 1；若 `isAcrade()` 且有当前 `MessionStageVO`，乘 `hpRate`（关卡 XML `@hpRate`，缺省 1）。

- `customHpMax > 0`（`FighterCtrler` 可写入）：`hp = hpMax = customHpMax * fighterHP * hpRate`
- 否则底数 **1000**（`GameConfig.FIGHTER_HP_MAX`）× `config.fighterHP` × hpRate

`isAlive = true`。不改 qi、不改 attackRate。

`GameState.initFight` 对 P1/P2 都调用；闯关时 P2 再 `setMessionEnemyAttack`。`resetFight`（下一回合）只 resetHP，**不再**设 attackRate（沿用）。

### `setMessionEnemyAttack`（L356–363）

当前关卡 `attackRate` 写入 `fighter.attackRate`。无关卡 VO 则不动。只在闯关 `initFight` 给 **P2** 调。

### `canSelectFighter` / `canSelectAssist`（L365–389）

查 `GameData.I.config.select_config.charList` / `assistList` 的 `list`（`SelectCharListItemVO`），`fighterID == param` 即 true。

选人 XML 没列的角色不能进随机池（`SelectFighterStage` 过滤 `random` 项时）。格子上若硬编了未列出的 id，随机会跳过。线性扫描，列表很小。

### `setGameMode`（L391–405）

`GameInterfaceManager` 热键：Ctrl+F8 → 1，Ctrl+F9 → 0。不是 `GameMode.currentMode`（那是 10/20/40 那套对局模式）。

| param | select XML | `ResUtils.WINNER` | `SelectIndexUI.SHOW_MODE` |
|-------|------------|-------------------|---------------------------|
| 1 | `assets/config/salect.xml` | `"winner_stg_mc2"` | 1 |
| 其它 | `assets/config/select.xml` | `"winner_stg_mc"` | 0 |

`loadSelect` 异步，失败只 `trace("loadSelect error!")`。胜利画面 MC 名立刻改，下一张 WinnerState 才生效。SHOW_MODE 影响选人后的出战顺序 UI。

这是「选人表皮肤/布局」开关，不是街机/对战开关。
