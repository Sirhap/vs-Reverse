# `interfaces.IGameSprite` — 战场精灵契约

一句话目的：可被加入 `GameState._gameSprites` 的对象：坐标、朝向、队伍、受击/攻击盒、地图穿墙、速率与音量。主循环对每个精灵 `render` / `renderAnimate`，碰撞走 `getCurrentHits` × `getBodyArea`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IGameSprite.as`（60 行）

## Callers / callees

- **Implementors**：`BaseGameSprite`（`FighterMain` / `Assister` / `FighterAttacker` 继承它，本任务不注解 BaseGameSprite）；`Bullet` 直接实现；`BitmapFilterView` 直接实现（特效层，hit/beHit 空）。
- **容器**：`GameState.add/removeGameSprite`；`GameCtrl.addGameSprite` 同时挂 `TeamVO.children`；`TeamVO.children:Vector.<IGameSprite>`。
- **主循环**：`GameMainLogicCtrler` 扫精灵做 `checkHit` / `checkBodyHit` / `renderGameSprite`。`GameLogic.hitTarget/fixGameSpritePosition/isTouchBottomFloor/isOutRange`。`MapMain` 用地图盒测精灵。
- **战斗引用**：`FighterMain.getCurrentTarget/getTargets`、`HitVO.owner`、`FighterHitModel`、`EffectCtrl.doHitEffect*`、各类 `*EffectView.setTarget`。
- **Callees 类型**：`DisplayObject`、`Rectangle`、`TeamVO`、`HitVO`。

## 命名备注

`destory` / `isDestoryed` 全引擎同一错。`direct` 为 1（右）或 -1（左），不是角度。

## 逐行说明

### 生命周期 / 帧（L11–19）

- `destory(param1:Boolean=true)`：`param1` 是否释放显示对象。`BaseGameSprite` true 时停 MC 并丢掉 `_mainMc`。`GameCtrl.removeGameSprite` 第二参控制是否 destory。
- `isDestoryed()`：已 destory 则主循环应跳过/剔除。
- `render()`：逻辑帧（位移、重力、AI）。`renderAnimate()`：动画帧（MC nextFrame、帧脚本）。两者 FPS 可不同（`GameConfig` 逻辑 30/60 与动画）。
- `getDisplay()`：加入场景的 DisplayObject。碰撞换深度时 `hit` 用它。

### 朝向 / 坐标 / 队伍（L21–35）

- `direct` get/set：1 / -1。打击特效 `followDirect` 读 owner.direct。
- `x` / `y`：战场坐标，不一定等于 `display.x`（BaseGameSprite 用 `_x/_y` 再 `updatePosition`）。
- `team`：`TeamVO`。同队不互伤；`GameCtrl.getEnemyTeam` 按 team 取敌方。

### 攻击 / 受击（L37–45）

- `hit(HitVO, target)`：自己打中 target。BaseGameSprite 默认只做显示深度对调（攻击者盖到受击者之上）。FighterMain 覆盖加气、连击等。
- `beHit(HitVO, hitRect=null)`：被打。Base 空；FighterMain 扣血、硬直、击飞。`hitRect` 是相交盒，特效用。
- `getArea()`：粗包围盒（含偏移后的世界坐标）。
- `getBodyArea()`：受击身。Base 默认 null（无身体则不被打）。
- `getCurrentHits():Array`：当前攻击 HitVO+矩形。无攻击返回 null/空。`GameMainLogicCtrler.checkHit` 用。

### 地图约束（L47–53）

- `allowCrossMapXY()`：能否穿左右/地图墙。子弹、部分特效 true。
- `allowCrossMapBottom()`：能否掉出地板。
- `getIsTouchSide` / `setIsTouchSide`：贴边。贴边时 `checkBodyHit` 推挤系数变化（两人同时贴边不互相挤出屏幕）。

### 速率 / 音量（L55–57）

- `setSpeedRate(Number)`：全局减速/卡肉时乘到位移。Base 写 `_speedPlus`。
- `setVolume(Number)`：精灵自带音效音量。暂停/设置改音量时扫精灵。
