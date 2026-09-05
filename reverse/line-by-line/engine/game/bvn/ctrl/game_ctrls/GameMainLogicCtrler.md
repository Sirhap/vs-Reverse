# `GameMainLogicCtrler` — 每帧物理 / 对撞 / 动画

一句话目的：对局里每个 `IGameSprite` 的位置修正、重力、`render`/`renderAnimate`，以及跨队身体挤开和攻击判定。`setSpeedPlus` 把慢放倍率写到所有精灵。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameMainLogicCtrler.as`（389 行）

## Callers / callees

- **Callers**：只 `GameCtrl`。
  - `buildGame` → `new` + `initlize(gameState, _teamMap, map)`。
  - `render` → `_mainLogicCtrl.render()`（每物理帧）。
  - `renderAnimate` → `_mainLogicCtrl.renderAnimate()`（按 gap 抽帧，先于 `render`）。
  - `setRenderHit` 写公开字段 `renderHit`。
  - `slow` / `slowResume` → `setSpeedPlus`。
  - `destory` → 空 `destory()`。
- **Callees**：`GameLogic.fixGameSpritePosition` / `isInAir`；`IGameSprite.render/renderAnimate/getBodyArea/getCurrentHits/beHit/hit/setSpeedRate`；`BaseGameSprite.applayG/setInAir/getVecX/move/isCross/isAllowBeHit/heavy`；`Debugger.log`。

## 命名备注

- `initlize` / `destory`：原拼写。`destory` 空。
- 重力调用的是 `applayG`（引擎拼写，非 applyG），常量 `GameConfig.G=12`。
- `_leftSide` / `_rightSide`：`initlize` 写成 `map.left+10` / `map.right-10`，**本文件从未读取**。贴边实际在 `GameLogic.fixGameSpritePosition`。
- `renderPause` 空 stub；暂停逻辑在 `GameCtrl.renderPause`。
- `renderHit`：false 时跳过身体挤开和攻击判定（必杀镜头）。精灵 `render` 仍跑。

## 与 `GameCtrl` 的帧时序

`GameCtrl.render` 先 `checkRenderAnimate()`（可能 `renderAnimate()` 把 `_renderAnimate=true`），再 `_mainLogicCtrl.render()` → `renderMainLogic`：先全员物理，再跨队对撞；**攻击判定 `checkHit` 仅当 `_renderAnimate`**。函数末尾清回 false。因此 60fps 下位移每帧、攻击盒约 30fps。

## 逐行说明

### 字段 / 构造（L18–33）

`renderHit=true`。`_gameState`、`_leftSide/_rightSide`、`_teamMap`、`_renderAnimate`。构造空。

### `initlize`（L35–41）

存 `GameState`、`TeamMap`。边距 `map.left+10`、`map.right-10`（死字段，与 `GameLogic` 贴边公式同值）。

### `setSpeedPlus`（L43–69）

`GameConfig.SPEED_PLUS = param1`。双层 while 扫 `_teamMap.teams[*].children`，未 destory 的 `setSpeedRate(param1)`。`BaseGameSprite` 会改 `_speedPlus` 和 damping。`slow(n)` 传 `SPEED_PLUS_DEFAULT/n`（默认 `30/FPS_GAME`）。不扫 `gameState.getGameSprites()` 里未入队的（例如 team=0 特效）。

### `destory`（L71–73）

空。`GameCtrl` 仍会调然后 null 引用。

### `render`（L75–78）

直接 `renderMainLogic()`。

### `renderMainLogic`（L80–141）

1. `getGameSprites()` 全员 `renderGameSprite`（位置、重力、`render`、条件 `renderAnimate`）。用显示列表长度，中途增删（子弹）可能影响遍历（? 视 `getGameSprites` 是否拷贝）。
2. 队伍双重循环：`i` 队 vs `j>i` 队，每个未 destory 的 child 对做 `checkBodyHit`；若 `_renderAnimate` 再 `checkHit`。同队不对撞。`GameMode.getTeams` 只有两队。
3. `_renderAnimate = false`。

### `renderAnimate`（L143–146）

只置 `_renderAnimate=true`，不立刻播动画。必须紧跟一次 `render()` 才消费。

### `checkBodyHit`（L148–274）—— 身体挤开

闭包 `getVec(overlap)`：

- `ratio = clamp(bb.heavy/ba.heavy*0.5, 0.1, 0.9)`。
- A 分到 `overlap*ratio`，B 分到 `overlap*(1-ratio)`。A 更重 → ratio 更小 → A 被推得少。
- 双方都 `getIsTouchSide()`：两人都拿 **满** overlap（可能对挤）。
- 仅 A 贴边：A=0，B=满；仅 B 贴边相反。

闸：`!renderHit` / 不是 `BaseGameSprite` / `isCross` / `getBodyArea` 空 / intersection 空 → return。

`vecA/vecB = getVecX()`。

- **A 在 B 左侧**：若 A 左走且比 B 更快向左，或 B 右走且比 A 更快向右 → return（已经在分离）。`bodyHit.width>2` 才用 `overVec=getVec(5*SPEED_PLUS)` 把 A 左推、B 右推。
- **A 在 B 右侧**：对称。

然后无论左右：若 `vecA!=0`，按 `getVec(vecA)` 把速度分量转给对方（A 退自己的 A 分量、B 吃 B 分量）；`vecB` 同理。这是速度交换式挤开，叠在 overlap 推开之上。`overVec` 惰性一次。

### `renderGameSprite`（L276–303）

try/catch，异常 `Debugger.log("GameMainLogicCtrler.renderGameSprite", e)` 不中断其它精灵。

1. `GameLogic.fixGameSpritePosition`（贴地图左右、必要时贴镜头边）。
2. `BaseGameSprite`：`isInAir` → 真则 `applayG(12)`，`setInAir`。`isInAir` 会把落地 y 钉到地板/`playerBottom`。
3. `param1.render()`（AI/输入/速度积分，每物理帧）。
4. `_renderAnimate && !isDestoryed()` → `renderAnimate()`（MC 进帧）。

### `checkHit`（L305–343）

`!renderHit` return。取双方 `getCurrentHits()`（`HitVO` 数组）。

身体盒：`BaseGameSprite && !isAllowBeHit` 则当 null（无敌/死亡等不能挨打，但仍能打人）。

`getHitObj(hitsA, bodyB)` 有则 `B.beHit(hitVO, hitRect)` + `A.hit(hitVO, B)`。对称再判 B→A。同一动画帧可互打。

### `getHitObj`（L345–382）

`body` 或 `hits` 空 → null。按数组顺序取第一个 `currentArea` 与 body 相交且非 empty 的 `HitVO`，返回 `{hitVO, hitRect}`。多盒只取先命中的。

### `renderPause`（L384–387）

空。`GameCtrl` 未调用。
