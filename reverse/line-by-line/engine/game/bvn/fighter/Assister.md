# `Assister` — 辅助出场体（fuzhu）

一句话目的：`BaseGameSprite` 子类。加载阶段 `new` 一次挂在 `GameRunFighterGroup.fuzhu`；对局按 assist 从队伍背后放出，播完主时间轴就 `removeSelf`。能打人（`getCurrentHits`），**没有** `getBodyArea`/`beHit` 覆盖 → 不受击、不挤身。`isAlive` 构造起就是 false，不进锁敌表。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/Assister.as`（358 行）

## Callers / callees

- **创建**：`GameLoader.loadAssister` `new Assister(mc)` + `data=FighterVO`。`LoadingState` 写入 `p1/p2FighterGroup.fuzhu`。
- **出场**：`FighterMcCtrler.renderAssist`：站立或防御且 `assist()` 且 `fzqi>=100` → 清 fzqi、派 `ADD_ASSISTER`。`FighterEventCtrl.addAssister` **不 new**：取出 `fuzhu`，`setOwner`、`direct=owner.direct`、`x=owner.x-30*direct`（背后）、`y=owner.y`、`onRemove=removeAssister`、`addGameSprite(owner.team.id)`、`EffectCtrl.assisterEffect`、`goFight()`。
- **退场**：`removeSelf` / `AssisiterCtrler.finish` → `onRemove` → `GameCtrl.removeGameSprite`。同一实例可再次出场（只 `gotoAndStop(1)`，不 destory）。
- **Ctrler**：构造要求 SWF `setAssistCtrler`。`AssisiterCtrler` 提供时间轴 API（`move`/`gotoAndPlay`/`setHitTarget`/`finish`），并可 `FIRE_BULLET`/`ADD_ATTACKER`。
- **AI**：`FighterAILogic` 扫敌队 children，`Assister.isAttacking` 当威胁。
- **Callees**：`AssisiterCtrler`、`McAreaCacher`、`FighterHitModel.getHitVO`（按子件 **name**，与角色的 `getHitVOByDisplayName` 不同）、`GameLogic.hitTarget`、owner `FighterMain.addQi`。

## 命名备注

- 类名 `Assister`；控制器类是 `AssisiterCtrler`（少一个 s）。数据侧字段 `fuzhu`。
- `onRemove`：与 Bullet/Attacker 同一约定，由 EventCtrl 注入。
- `isAttacking`：`goFight` true；`removeSelf`/`finish`/`endAct` false。AI 只看这个，不看 isAlive。
- `_mcOrgPoint`：声明后从未赋值，destory 才 null（死字段）。
- **不覆盖** `getBodyArea`/`beHit`/`getArea`：身体盒基类 stub=null → `checkHit` 打不中辅助，`checkBodyHit` 不挤。显示盒仍用构造时 MC bounds。

## 与战斗循环的合同

```
checkHit:  本类 getCurrentHits() 可打对方 FighterMain
           getBodyArea()=null → 自己不会 beHit
checkBodyHit: body 空，跳过
TeamVO.getAliveChildren: isAlive 恒 false → FighterMain.getTargets 不含辅助
```

`hit()` 把连击/加气算在 **owner 角色** 上。

## 逐行说明

### 字段（L19–37）

- `onRemove` / `data` / `isAttacking`。
- `_hitAreaCache` / `_hitCheckAreaCache`：与角色相同的帧/display 缓存。
- `_rectCache`：`getCurrentRect` 按 key 复用 Rectangle。
- `_owner`：放出者，应为 `FighterMain`。
- `_isRenderMainAnimate`：`stop`/`gotoAndStop` 关，`gotoAndPlay`/`goFight` 开。
- `_ctrler:AssisiterCtrler`。

### 构造（L39–51）

`super(mc)` 后 **`isAlive=false`**（此后从未改回 true）。SWF 有 `setAssistCtrler`：`new AssisiterCtrler` → `initAssister(this)`（建 hitModel + EffectCtrl）→ `_mainMc.setAssistCtrler(_ctrler)`。否则 `throw "初始化失败，SWF未定义setAssistCtrler()"`。加载期就跑，SWF 第一帧必须把接口挂上。

### `name` / `getOwner` / `setOwner` / `getCtrler`（L53–71）

`name` = `_mainMc.name`（`FighterEventCtrl.getAttacker` 同类按名找；辅助不进 `_attackers` 表）。owner 读写。ctrler 给攻击体 `setOwner(Assister)` 时借 effect/hitModel。

### `goFight`（L73–77）

`gotoAndPlay(2)`（跳过定义帧），`isAttacking=true`。EventCtrl 放进场景后立刻调。

### `destory`（L79–105）

`param1==false` return（与 FighterMain 相同，不 super）。true：两 cache、ctrler destory，清 data/rect/org/owner，`super.destory(true)`。对局退场 **不** destory，只 `removeSelf`；整场结束随 GameCtrl 拆精灵。

### `stop` / `gotoAndPlay` / `gotoAndStop`（L107–122）

都是 `gotoAndStop` 切帧（播放靠 `renderAnimate` 的 `nextFrame`，与 FighterMC 同一套路）。`stop` 只关 `_isRenderMainAnimate`。Ctrler 时间轴 API 转调这些。

### `getTargets`（L124–131）

`if(!_owner is FighterMain)`：AS3 里 `!` 优先于 `is`，等价 `(!_owner) is FighterMain`，恒 false（? 空指针护栏失效）。随后 `(_owner as FighterMain).getTargets()`。owner 空会 NPE。

### `removeSelf`（L133–141）

`isAttacking=false`、`isAlive=false`，调 `onRemove(this)`。不 destory、不停 MC。`AssisiterCtrler.finish` 还会 `gotoAndStop(1)` 复位。

### `render`（L143–147）

`super.render()`（速度）+ `_ctrler.render()`（落地切帧、`hitTargetChecker` 对目标 body 做相交）。

### `renderAnimate`（L149–163）

关播放则整段 return（**连 super 的动画 delay 也不跑**）。否则 super、`renderChildren`、`mc.nextFrame()`、`findHitArea`。`currentFrame == totalFrames-1`（倒数第 2 帧）→ `_ctrler.finish(true)`：再播一次出场特效、关 attacking、removeSelf、停在第 1 帧。时间轴也可提前 `finish`。

### `renderChildren`（L165–199）私有

与 `FighterMC` 同结构，但跳过名单只有 `bdmn` 和含 `atm`（没有 `AImain`）。`"stop"` 标签停，末帧回 1。

### `getHitCheckRect` / `getCheckHitRect`（L201–226）

按子件名取本地盒（相对 `_mainMc`，注意 **不是** fighterDisplay），再 `getCurrentRect(..., "hit_check")` 变世界。Ctrler `setHitTarget` 用 checker 名对敌 body 做取消判定。

### `getCurrentRect`（L228–253）私有

`param2` 作 cache key；null 则每次 new。`x = local.x * direct + _x`，朝左再 `-width`；`y = local.y + _y`。与 Bullet/Attacker/FighterCtrler 同一套朝向翻转。

### `findHitArea`（L255–303）私有

帧缓存闸同 FighterMC。`_ctrler.hitModel.getHitVO(_loc2_.name)`——按 **name** 不是 `getHitVOByDisplayName`（辅助 hit 定义键约定不同）。命中则 cache display 盒（相对 `_mainMc`）。

### `hit`（L305–312）

不 `super.hit`（不改 z-order）。目标与 owner 都在且 owner 是 `FighterMain`：owner `addQi(power*0.15)`，`GameLogic.hitTarget(hitVO, owner, target)`（连击记在角色上）。辅助自身不加气。

### `getCurrentHits`（L314–346）

当前帧 cache 数组转 `HitVO[]`，`currentArea=getCurrentRect(area, "hit"+i)`。无盒/空 cache 返回 null。`_loc3_=name` 取出未用。

### `getCurrentTarget`（L348–355）

owner 是 FighterMain 则转 `getCurrentTarget()`，否则 null。攻击体 `getTarget()` 在 owner 是辅助时走这条。
