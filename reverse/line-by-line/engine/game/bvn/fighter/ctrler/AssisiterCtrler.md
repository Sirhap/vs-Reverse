# `fighter.ctrler.AssisiterCtrler` — 助战 SWF 时间轴门面

一句话目的：助战角色 SWF 的 `$assisterCtrler`。时间轴用它登记 HitVO、位移、开火/出攻击体、落地切帧、打中检测，再经 `FighterEventDispatcher` 交给 `FighterEventCtrl`。类名相对实体 `Assister` 拼错（多了一个 i）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/AssisiterCtrler.as`（355 行）

## Callers / callees

- **装配**：`Assister` 构造：SWF 必须有 `setAssistCtrler`，否则 throw。`new AssisiterCtrler()` → `initAssister(this)` → `_mainMc.setAssistCtrler(_ctrler)`。助战 SWF 存成 `$assisterCtrler`（注意：入口名 Assist、字段 Assister、类名 Assisiter，三套拼写）。
- **每帧**：`Assister.render` → `render()`。`Assister.renderAnimate` 播到 `totalFrames-1` 自动 `finish(true)`。
- **SWF 高频 API**（`decompiled/fighters/fz/*/scripts/*_fla/MainTimeline.as`）：`defineAction`、`effect.bisha/endBisha/shine/dash/slowDown`、`move`/`damping`/`moveToTarget`/`setDirectToTarget`、`justHit`、`setHitTarget`、`fire`、`addAttacker`、`checkHitOwner`、`endAct`、`finish`、`setApplyG`。夜一/sai 经 `getOwner().getBuffCtrl()` 给主人上 buff。
- **Callees**：`Assister`、`FighterHitModel`、`FighterEffectCtrl`、`EffectCtrl.assisterEffect`、`FighterEventDispatcher`（`FIRE_BULLET` / `ADD_ATTACKER`）、主人 `FighterMain.getCurrentTarget/getCtrler`。

## 命名备注

- `AssisiterCtrler`：相对 `Assister` 多一个 i。全工程只此拼写。
- `destory`：原拼写。
- `hitTargetChecker` / `hitTargetAction`：无下划线的包级字段，SWF `setHitTarget` 写入。
- 助战 `gotoAndPlay` 实际是 `Assister.gotoAndPlay` → `_mainMc.gotoAndStop` + 开 `renderAnimate` 逐帧 `nextFrame()`，不是 Flash 原生 play。

## 逐行说明

### 字段 / 构造（L16–33）

- `hitModel`：公开。`initAssister` 才 new。SWF `defineAction` 直接写这里。
- `_effectCtrl`：助战自己的 `FighterEffectCtrl`（与主人不是同一实例）。getter `effect` 暴露给 SWF。
- `_assister`：所属 `Assister`。
- `_touchFloor` / `_touchFloorFrame`：落地沿检测。空中把 `_touchFloor` 打回 false，落地边沿切一次帧。
- `hitTargetAction` / `hitTargetChecker`：`setHitTarget` 的「检测 MC 名 → 命中后跳转标签」。
- 构造空，真正装配在 `initAssister`。

### `effect` getter（L35–38）

返回 `_effectCtrl`。SWF 写 `$assisterCtrler.effect.bisha(false)` 等。未 `initAssister` 则 null。

### `destory`（L40–53）

有则 destory `_effectCtrl`、`hitModel`，再 `_assister=null`。不还原落地/hitTarget 字段（随对象一起丢）。`Assister.destory(true)` 才调；`finish` → `removeSelf` 默认 `destory(false)` **不会**走到这里。

### `getTarget`（L55–63）

主人 as `FighterMain` 的 `getCurrentTarget()`。主人不是 `FighterMain` 或没有当前目标 → null。白哉助战用 `getTarget().getCtrler()` 改对手重力。

### `getOwner` / `getSelf`（L65–73）

主人精灵 / 助战自己。SWF 经常 `getOwner().addHp`、`getOwner().getBuffCtrl()`、`getOwner().getCtrler()`。

### `setApplyG`（L75–78）

`param1` 是否受重力。雨写 `setApplyG(false)` 做浮空弹幕。

### `finish`（L80–89）

`param1` 默认 true：播 `EffectCtrl.assisterEffect`（与出场同一套闪光）。然后 `isAttacking=false`、`removeSelf()`（`isAlive=false` + `onRemove` 卸场）、`gotoAndStop(1)` 停在片头。`Assister.renderAnimate` 播完自动 `finish(true)`。SWF 也可提前 `finish()` / `finish(false)`（false 不播收招特效）。

### `defineAction`（L91–94）

`param1` HitVO id，`param2` 字面量（power/hitType/hitx/…）。转 `hitModel.addHitVO`。助战习惯 id=`"atm1"` 等。

### `owner_mc_ctrler` / `owner_fighter_ctrler`（L96–114）

主人 `FighterMain.getCtrler().getMcCtrl()` / `getCtrler()`。主人不是 `FighterMain` → null。白哉助战用前者 `getAttacker("lzgl")`。

### `initAssister`（L116–121）

`param1`=`Assister`：new `FighterHitModel(param1)`（HitVO.owner 是助战）、存引用、new `FighterEffectCtrl(param1)`。只应调一次。

### `endAct`（L123–126）

只清 `isAttacking`。不卸场。时间轴攻击段结束、人还留着播收招时用。`GameMainLogicCtrler` 用 `isAttacking` 决定助战要不要参与 hit 检测。

### `render`（L128–145）

每逻辑帧：

1. `renderCheckTargetHit()`。
2. 空中：`_touchFloor=false` 后 return（不处理落地）。
3. 刚落地（`!_touchFloor`）：置 true；若有 `_touchFloorFrame` 则 `gotoAndPlay` 并清空。一次性边沿。

### `moveToTarget`（L147–171）

`param1` x 偏移（Object，null 则不动 x），`param2` y 偏移，`param3` 默认 true=结束后朝向目标。

主人必须是活着的 `FighterMain` 且有 `getCurrentTarget()`，否则 return。x：`target.x + Number(param1) * assister.direct`（相对**自己当前朝向**，不是目标朝向）。y：`target.y + Number(param2)`，不乘朝向。`param3`：`x < target.x ? 1 : -1`。

与 `FighterCtrler.moveToTarget` 不同：没有贴边修正。

### `setDirectToTarget`（L173–181）

按 `getTarget()` 左右翻转。无目标 return。

### `move` / `damping`（L183–191）

`param1` x 速度（乘 `direct`），`param2` y。阻尼不乘朝向。转 `Assister.setVelocity/setDamping`。

### `stop` / `gotoAndPlay` / `gotoAndStop`（L193–206）

转 `Assister`：`stop` 停主时间轴逐帧；`gotoAndPlay` 跳标签后继续逐帧；`gotoAndStop` 跳了就停。`param1` 是帧标签 String。

### `setTouchFloor`（L208–211）

`param1` 落地后要播的标签。`render` 落地边沿消费一次并置 null。再落地不会自动重播，除非再 set。

### `justHit`（L213–224）

`param1` HitVO.id，`param2` 命中后可选跳转标签，`param3` 默认 false=是否连防御中的 `defenseHit` 也算。命中则可选 `gotoAndPlay(param2)` 并 return true。鼬助战：`justHit("atm1","攻击2",false)`。

### `isJustHit`（L226–249）私有

取主人当前目标，必须是 `FighterMain`。先比 `hurtHit.id`，没有再（`param2` 真时）比 `defenseHit.id`。目标空/不是角色/两边 HitVO 都对不上 → false。

**无**主人 null 护栏：主人不是 `FighterMain` 时 `_loc5_.getCurrentTarget()` NPE。? 本包主人总是 `FighterMain`。

### `setHitTarget`（L251–255）

`param1` 检测 MC 名（`getHitCheckRect`），`param2` 相交后 `gotoAndPlay` 的标签。**不**自动清空，重叠期间每逻辑帧都会再 `gotoAndPlay`。

### `removeSelf`（L257–260）

转 `Assister.removeSelf`：`isAttacking=false`、`isAlive=false`、调 `onRemove`（`FighterEventCtrl.removeAssister` → `removeGameSprite`）。

### `fire`（L262–284）

`param1` 子弹 MC 子件名，`param2` 附加参数（可空）。

按名 `getChildByName` 取 MC：

- 有：补 `params.mc`、`params.hitVO = hitModel.getHitVO(mcName)`（**精确 id**，不剥 `atm` 前缀），`dispatchEvent(assister, "FIRE_BULLET", params)`。
- 无：`setAnimateFrameOut` 1 动画帧后原参数重入。子件还没生成时等一帧。

闭包用命名局部 `mcName/params`，反编译保留的 AS3 写法。hitVO 缺失仍 dispatch（Bullet 侧再处理）。?

### `addAttacker`（L286–308）

同结构，事件 `"ADD_ATTACKER"`。HitVO 走 `getHitVOByDisplayName`（先精确，失败且名字含 `atm` 则剥掉 `atm` 再查）。sai/我爱罗/乱菊助战用 `addAttacker("atmmc", {x:..., y:...})`。

### `checkHitOwner`（L310–323）

`param1` 检测 MC 名。助战 `getHitCheckRect` 与主人 `getArea()`（整件包围盒，**不是** `getBodyArea`）相交。纲手助战每帧用 `"main"` 给主人 `addHp(5)`。缺任一侧矩形 → false。

### `renderCheckTargetHit`（L325–352）私有

无 `hitTargetChecker` 则 return。取检测矩形、`_assister.getTargets()`（主人敌队活体）。逐个 `getBodyArea` 相交则 `gotoAndPlay(hitTargetAction)`。不 break，多人重叠会连续跳转同一标签。
