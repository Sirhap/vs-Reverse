# `BaseGameSprite` — `IGameSprite` 默认实现：坐标、速度、重力、朝向、队伍

一句话目的：战斗场景里所有「有 MC、会移动、会受击」实体的基类。实现 `IGameSprite` 的坐标/朝向/队伍/销毁/渲染/音量/越界标志，并额外提供双通道速度+阻尼、重力、HP、帧回调。子弹 `Bullet`、滤镜 `BitmapFilterView` **不**继承本类，各自直接实现接口。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/BaseGameSprite.as`（620 行）

## Callers / callees

- **直接子类**（后批再注，此处只列）：`FighterMain`、`Assister`、`FighterAttacker`。三者都 `extends BaseGameSprite`，覆盖 `destory` / `render` / `renderAnimate` / `hit` / `getCurrentHits`；`FighterMain` 还覆盖 `attackRate` setter、`getBodyArea`、`getArea`、`beHit`。
- **同接口其它实现**：`Bullet`、`BitmapFilterView` —— 不是子类。
- **Callers**：
  - `GameMainLogicCtrler.renderGameSprite`：`fixGameSpritePosition` → `GameLogic.isInAir` → `applayG(12)` → `setInAir` → `render` / `renderAnimate`。
  - `GameMainLogicCtrler.checkBodyHit`：`heavy`、`isCross`、`getIsTouchSide`、`getBodyArea`（基类 stub 返回 null，实战走子类）。
  - `GameLogic.isInAir` / `fixGameSpritePosition` / `isTouchBottomFloor` / `isOutRange`：读 `x/y`、`getVecY`、`allowCrossMap*`、`setIsTouchSide`。
  - `GameState.addGameSprite*`：`getDisplay`、`setVolume`。
  - `TeamVO.getAliveChildren`：`isAlive`。
  - `EffectCtrl`：`justRender*` 向量、必杀/替身/爆气/残影都以本类为 target。
  - `FighterEventDispatcher` / `FighterEvent.fighter`：事件主体类型是本类。
  - `GameOverState.addChar`：失败角色 `renderSelf()` 脱离主循环单独跑。
  - `FighterCtrler` / `FighterMcCtrler` / `MoveTargetParamVO`：写 `setVelocity` / `setDamping` / `setVecY` / `setVec2` / `isApplyG` / `isAllowBeHit` / `isCross`。
- **Callees**：`GameConfig`（`SPEED_PLUS`、`SPEED_PLUS_DEFAULT`）、`GameRender.add/remove`、`KyoUtils.num_wake`、`UUID.create`、`Debugger.log`、`MovieClip.getBounds` / `soundTransform` / `stopAllMovieClips`。重力常量 `GameConfig.G=12` 由调用方传入 `applayG`，本类不直接读 `G`。
- **接口**：`IGameSprite` 全部方法都有实现；`getBodyArea` / `getCurrentHits` / `beHit` 是空 stub。

## 命名备注

- `destory` / `_destoryed` / `isDestoryed`：全工程拼写，保留。
- `applayG`：apply 拼错，保留。
- `_speedPlus`：当前逻辑帧速度倍率，默认 `GameConfig.SPEED_PLUS`（`30/FPS_GAME`，60fps 时 0.5）。
- `_g`：下落加速度累加器，**不是** `GameConfig.G` 本身。
- `_velocity` / `_damping`：主速度通道；`_velocity2` / `_damping2`：次通道（击飞/推人 `setVec2`）。
- `_frameFuncs`：逻辑 `render()` 路径的延迟回调（`delayCall`）；`_frameAnimateFuncs`：动画 `renderAnimate()` 路径（`setAnimateFrameOut`）。
- `direct`：`1` 朝右、`-1` 朝左，乘到 `scaleX`。
- `isCross`：身体穿人，body 重叠检测跳过。
- `heavy`：质量，默认 2；`checkBodyHit` 用双方 heavy 比分摊位移。
- `isAllowCrossX` / `isAllowCrossBottom`：经 `allowCrossMapXY` / `allowCrossMapBottom` 暴露给 `GameLogic.fixGameSpritePosition`。

## 逐行说明

### 字段（L21–86）

公开状态：

- `isInAir`：由 `setInAir` 写入；落地时顺带把 `_g` 置 `4`（= `GameConfig.G_ON_FLOOR`）。
- `isTouchBottom`：基类不写，`GameLogic.isInAir` 在 `y > playerBottom-12` 时置 true 并钳 `y = playerBottom`。
- `isAllowBeHit = true`：`GameMainLogicCtrler.checkHit` 任一方 false 则不判击中。
- `isCross = false`：true 时双方 body 相交不推挤。
- `isAlive = true`：`destory` 置 false；`TeamVO` 只收活着的 `BaseGameSprite`。
- `isAllowLoseHP = true`：`GameRunDataVO` 训练/过场可关；`loseHp` 直接 return。
- `isApplyG = true`：false 时 `applayG` 把 `_g` 清 0 且不下落（飞行技、被抓）。
- `heavy = 2`：推挤质量。
- `hp` / `hpMax = 1000`（= `GameConfig.FIGHTER_HP_MAX`）；`GameLogic.resetFighterHP` 会按关卡/配置重写。
- `defense = 0`：`loseHp` 里从伤害里**减去**的固定值。
- `isAllowCrossX` / `isAllowCrossBottom`：默认不可穿左右/底边。

私有/保护：

- `_attackRate` / `_defenseRate`：默认 1。本类 `loseHp` 只用 defenseRate；attackRate 由 `FighterMain` setter 转发到 `hitModel.setPowerRate`。Arcade 敌方经 `GameLogic.setMessionEnemyAttack` 写入。
- `id = UUID.create()`：构造即生成；`FighterEventCtrl` 用它当 hit 来源 id。
- `_x` / `_y`：逻辑坐标。MC 实际位置只在 `render` / `updatePosition` 同步。
- `_g`：当前下落速度累加，初始 0。
- `_mainMc`：显示体。
- `_isTouchSide`：贴左右墙。贴墙时 `checkBodyHit` 把位移全推给另一边。
- `_area`：构造时 `_mainMc.getBounds(_mainMc)` 的本地包围盒；`getArea` 平移到世界。
- `_direct = 1`、`_scale = 1`。
- `_team:TeamVO`。
- `_speedPlus = GameConfig.SPEED_PLUS`（类加载时取值；之后靠 `setSpeedRate` 刷新）。
- `_dampingRate = 1`：`setSpeedRate` 时改成 `param / SPEED_PLUS_DEFAULT`，让阻尼跟帧率倍率走。
- `_velocity` / `_damping`、`_velocity2` / `_damping2`：两组 `Point`。
- `_destoryed`：销毁闩。

### 构造（L89–96）

`BaseGameSprite(MovieClip)`：`super()`（EventDispatcher），存 `_mainMc`。MC 非空则 `_area = getBounds(self)`（本地空间，含矢量边）。MC 为空则 `_area` 保持 null，`getArea` 返回 null。子类 `FighterMain(mc)` 会 `super(mc)`。

### `attackRate` / `defenseRate` 存取（L99–117）

纯字段。`FighterMain.set attackRate` 覆盖后会 `super.attackRate =` 再同步 hit 模型。`FighterBuffCtrler.defenseUp` 写 `"defenseRate"` buff（后批）。本类 `loseHp` 读 getter。

### `mc`（L119–122）

返回 `_mainMc`。`GameOverState` 把失败角色的 `mc` addChild 到结算层。

### `x` / `y`（L124–142）

只读写 `_x/_y`，**不**立刻改 MC。每逻辑帧 `render()` 末尾 `_mainMc.x/y = _x/_y`。需要立刻对齐时调 `updatePosition()`（开局 `GameState.initFight` 放人后调用）。

### `scale`（L144–153）

存 `_scale`，并 `_mainMc.scaleX = scaleY = param`。随后若只改 `direct`，`scaleY` 保持本次值、`scaleX` 变成 `direct * _scale`。未调过 `scale` 时 `_scale=1`，`scaleY` 仍是 MC 默认。

### `direct`（L155–164）

存 `_direct`，`_mainMc.scaleX = _direct * _scale`。不碰 `scaleY`。P1 开局 `direct=1`，P2 `direct=-1`。

### `team`（L166–174）

`TeamVO` 引用。同队不互击（由 `GameMainLogicCtrler` 用 team 判断，本类不管）。

### `updatePosition`（L176–180）

`_mainMc.x/y = _x/_y`。不跑速度、不跑重力。开局/换人/重置用。

### `setVolume`（L182–194）—— `IGameSprite`

MC 存在则取出 `soundTransform`，改 `volume` 写回。`GameState.addGameSprite*` 用 `GameData.I.config.soundVolume`。MC 内嵌音效用。`soundTransform` 为 null 则跳过。

### `isDestoryed`（L196–199）

返回 `_destoryed`。`GameMainLogicCtrler.setSpeedRate` / `renderGameSprite` 用它跳过已销毁对象。

### `destory`（L201–222）—— `IGameSprite`

1. `_destoryed = true`，`isAlive = false`，`isAllowBeHit = false`。
2. `stopRenderSelf()`：从 `GameRender` 摘掉独立帧。
3. `param1` 默认 true：若有 MC，`try stopAllMovieClips()`（老播放器可能无此 API，catch `trace`），然后 `_mainMc = null`。
4. `param1=false` 时只闩状态、保留 MC（子类/过场可能还要显示）。

子类 `FighterMain.destory` 先清 ctrl/target 再 `super.destory`。拼写是 `destory` 不是 destroy。

### `renderAnimate`（L224–231）—— `IGameSprite`

已销毁则 return。否则只跑 `renderAnimateFrameOut()`（动画通道倒计时）。**基类不播 MC 帧**；`FighterMain` 覆盖后走动作 MC。`GameMainLogicCtrler` 在逻辑 `render()` 之后、且本 tick 允许动画时才调。

### `render`（L233–243）—— `IGameSprite`

已销毁则 return。顺序：

1. `renderVelocity()`：两通道速度积分进 `_x/_y`。
2. `renderFrameOut()`：逻辑通道倒计时。
3. 同步 `_mainMc.x/y`。

**不**在这里应用重力——重力由 `GameMainLogicCtrler` 在 `render()` **之前**调 `applayG`。`FighterMain.render` 覆盖后会 `super.render()` 再跑战斗机逻辑。

### `getDisplay`（L245–248）—— `IGameSprite`

返回 `_mainMc`。`GameState` 把它 addChild 到 `_playerLayer`。`hit()` 用它做同级 z-order 交换。

### `move`（L250–260）

`param1/param2` 为 0 则对应轴不动（避免无意义加法）。非 0 则 `_x += dx * _speedPlus`、`_y += dy * _speedPlus`。所有位移（速度积分、重力、推挤 `checkBodyHit` 的 `ba.move`）都走这里，因此 **全局 `SPEED_PLUS` 一次缩放所有运动**。

### `setSpeedRate`（L262–266）—— `IGameSprite`

`_speedPlus = param1`；`_dampingRate = param1 / GameConfig.SPEED_PLUS_DEFAULT`。`GameMainLogicCtrler.setSpeedPlus` 在慢放/加速时对队伍里每个未销毁 sprite 调用。`SPEED_PLUS_DEFAULT = 30/FPS_GAME`，与 `setGameFps` 联动。

### 主速度通道（L268–304）

- `getVelocity()`：返回 `_velocity` **引用**（调用方可直接改 `.x/.y`）。
- `getVecX` / `getVecY` / `setVecX` / `setVecY`：分量。
- `setVelocity(x,y)`：覆盖 `_velocity`，并 `setDamping(0,0)` 清主阻尼（新速度不继承旧刹车）。
- `addVelocity`：累加，不动阻尼。

`GameLogic.isInAir`：`getVecY() < 0` 一律视为空中（上升中不落地）；`getVecY() >= 5*SPEED_PLUS` 也视为空中（下落太快不粘地板）。

### `setVec2` / `getVec2`（L306–317）

次通道。`_velocity2 = (p1, p2)`；`_damping2.x = p3 * SPEED_PLUS_DEFAULT * 6`，y 同理 `* 6`。比主通道 `setDamping` 的 `* 2` 更狠，短促冲击（`FighterMcCtrler` 击飞/抓取位移）。`GameOverState` 对结算角色 `setVec2(0,0)` 停次通道。

### 主阻尼（L319–349）

- getter/setter 分量是**已缩放后**的存储值。
- `setDamping(dx, dy)`：写入 `param * SPEED_PLUS_DEFAULT * 2`。
- `addDamping`：按**原始存储单位**累加，不再乘系数。

`renderVelocity` 实际刹车量 = 存储值 `* _dampingRate`。60fps 且未慢放时 `_dampingRate=1`，`setDamping(1,0)` → 每帧 `num_wake` 减 `0.5*2=1`。

### `renderVelocity`（L351–391）私有

对 x/y、通道 1/2 各做：

1. 若该分量 ≠ 0，累加到本帧位移 `_loc1_` / `_loc2_`。
2. 若对应阻尼 > 0，`KyoUtils.num_wake(v, damping * _dampingRate)`：朝 0 收，越过 0 则钳 0。阻尼 ≤ 0 **不减速**（可恒速）。

最后 `_loc1_|_loc2_` 非 0 则 `move(_loc1_,_loc2_)`。两通道位移**相加**（击飞叠走路）。`num_wake` 对正数减、负数加。

### `applayG`（L393–416）

`param1` 是下落速度上限。调用点写死 `applayG(12)`，即 `GameConfig.G`。

1. `!isApplyG`：`_g = 0` return（浮空技）。
2. `_velocity.y < 0`（主通道仍在上升）：`_g = 0` return。**起跳上升段不叠加重力**；上升靠 `setVelocity` + 阻尼结束，vy 回到 ≥0 后才开始落。
3. 若 `_g < param1`：每帧 `_g += 1.2 * GameConfig.SPEED_PLUS`（`1.2` = `GameConfig.G_ADD`），超过上限则钳到 `param1`。
4. `move(0, _g)`：即 `_y += _g * _speedPlus`。

与 `GameConfig` 对照：

| 常量 | 值 | 本类用法 |
|---|---|---|
| `G` | 12 | 调用方传入的 cap，本类不读静态字段 |
| `G_ADD` | 1.2 | 硬编码 `1.2 * SPEED_PLUS` 做加速 |
| `G_ON_FLOOR` | 4 | `setInAir(false)` 把 `_g` 置 4，走下平台时已有初速 |

60fps、`SPEED_PLUS=0.5`：约 20 帧从 0 加速到 12，终端 `_y` 每逻辑帧 +6。30fps 则 `G_ADD` 每帧 +1.2，终端每帧 +12。重力**只在判定为空中之后**由 `GameMainLogicCtrler` 调用；落地帧不 `applayG`。

### `setInAir`（L418–425）

`param1==false`（落地）先 `_g = 4`，再 `isInAir = param1`。落地残留 4 而不是 0，下一步再离地会立刻有一点下落。空中路径不改 `_g`。由 `GameMainLogicCtrler` 每帧根据 `GameLogic.isInAir` 的返回值设置。

### `hit`（L427–450）—— `IGameSprite`

基类**不做伤害**。若双方 `getDisplay()` 都存在且 **同一个 parent**：比较 childIndex，攻击者在目标下面则对调，让攻击者画在上面。`FighterMain.hit` 覆盖后先处理打击再 `super.hit`。`param1:HitVO` 基类未用。

### `beHit`（L452–454）—— stub

空。`FighterMain` 覆盖做受击。

### `getCurrentHits`（L456–459）—— stub

`return null`。子类返回当前帧 HitVO 列表。`null` 表示无攻击框。

### `getArea`（L461–471）—— `IGameSprite`

`_area` 空则 null。否则 clone，`x/y += _x/_y`，得到世界 AABB。这是 **MC 显示包围盒**，不是受击体。`MapMain.checkHitGameSprite`（前景半透明）用它。`FighterMain` 覆盖：无 `_area` 时改用 `getBodyArea()`。

### `getBodyArea`（L473–476）—— stub

`return null`。`GameMainLogicCtrler.checkBodyHit` / `checkHit` 对 null 直接跳过，所以**纯基类实例不会互相推挤或受击**。`FighterMain` 转给 `FighterCtrler.getBodyArea()`。

### `allowCrossMapXY` / `allowCrossMapBottom`（L478–486）—— `IGameSprite`

分别返回 `isAllowCrossX` / `isAllowCrossBottom`。`GameLogic.fixGameSpritePosition`：false 时钳在 `map.left+10 .. map.right-10`（战斗机还可能被镜头进一步收），底边钳 `map.bottom`。子弹等可改 flag 穿出。

### `getIsTouchSide` / `setIsTouchSide`（L488–496）—— `IGameSprite`

读写 `_isTouchSide`。由 `fixGameSpritePosition` 在贴左右边时置 true。`Bullet` 撞墙、`FighterMcCtrler` 贴墙技、`checkBodyHit` 推挤都读它。

### `addHp`（L498–505）

`hp += param`，超过 `hpMax` 钳回。不检查 `isAllowLoseHP`。

### `loseHp`（L507–532）

1. `!isAllowLoseHP` return。
2. 倍率 `_loc3_ = 2 - defenseRate`，再钳到 `[0.1, 1]`。默认 `defenseRate=1` → 倍率 1。`defenseRate≤1` 全部变成 1（`2-x` 先算再钳上限 1）。`defenseRate>1` 才减伤，≥1.9 时保底 0.1。
3. 实伤 = `param1 * 倍率 - defense`。`defense` 是固定减伤；结果 `< 0` 则本击无效（不扣）。
4. `hp -= 实伤`，低于 0 置 0。不在这里设 `isAlive`；死亡由 `GameLogic.checkFighterDie`（`hp<=0`）处理。

### `delayCall`（L534–540）

把 `{func, frame}` 推进 `_frameFuncs`。每逻辑 `render()` 减 1，`<1` 时调用并 splice。本包 **没有任何调用点**（搜索仅定义），API 留着给脚本/子类。与 `setAnimateFrameOut` 分属逻辑/动画两路。

### `renderSelf` / `renderSelfEnterFrame` / `stopRenderSelf`（L542–567）

`GameRender.add(renderSelfEnterFrame, this)`：以 **this 为 key** 挂独立 enterFrame。回调里 `try { render(); renderAnimate(); }`，错则 `Debugger.log("BaseGameSprite.renderSelfEnterFrame", e)`。已销毁则 return。

用途：脱离 `GameMainLogicCtrler` 主循环仍要播的场合——已见 `GameOverState` 把 continue 失败者拉到结算 MC 上自己跑。`destory` 必 `stopRenderSelf`。`GameRender.remove` 用同一 function+key。

### `setAnimateFrameOut`（L569–575）

同 `delayCall` 结构，队列是 `_frameAnimateFuncs`，在 `renderAnimate` 里走。`FighterMcCtrler` / `AssisiterCtrler` / `FighterAttackerCtrler` 用来做「N 动画帧后切动作」。

### `renderAnimateFrameOut` / `renderFrameOut`（L577–617）

结构相同：空队列 return；否则 while 下标遍历，`frame--`，`<1` 则 `func()` 并 `splice(i,1)`，然后 **仍然 `i++`**。splice 后下一元素顶上来却被跳过——连续两帧同时到期时，第二个会晚一帧。标 `?` 是否故意；更像是无 `else i++` 的常见坑。`func()` 若再 `delayCall`/`setAnimateFrameOut`，新项加在末尾，本轮不会跑。

`renderFrameOut` 挂在逻辑 `render()`；`renderAnimateFrameOut` 挂在动画 `renderAnimate()`。主循环里动画可能隔帧（`_renderAnimate`），两队列时间基准不同。
