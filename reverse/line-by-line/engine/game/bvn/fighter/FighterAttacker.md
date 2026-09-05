# `FighterAttacker` — 角色/辅助放出的独立攻击体

一句话目的：`BaseGameSprite` 子类。时间轴 `ADD_ATTACKER` 把子 MC 变成场景精灵（分身、剑气实体、跟随火球等）。可 `moveToTarget`/`followTarget` 贴目标，播完主轴 `removeSelf`。能打人；**不覆盖** `getBodyArea`/`beHit` → 不受击、不挤身。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterAttacker.as`（550 行）

## Callers / callees

- **创建**：`FighterEventCtrl.addAttacker`：`new FighterAttacker(params.mc, params)` → `onRemove=removeAttacker` → `setOwner(fighter)` → `init()` → `_attackers.push` → `addGameSprite(owner.team.id)`。事件来自 `FighterMcCtrler.addAttacker`、`AssisiterCtrler`。
- **找回**：`FighterMcCtrler.getAttacker(name)` → `GameCtrl.getAttacker(name, teamId)` 扫 EventCtrl 表（`name==mc.name && team.id`）。
- **Ctrler**：构造总是 `new FighterAttackerCtrler(this)`；SWF 若有 `setAttackerCtrler` 则挂上（**没有也不 throw**，与 Assister/FighterMain 不同）。
- **AI**：`FighterAILogic` 看 `isAttacking`。
- **Callees**：`FighterAttackerCtrler`（落地切帧、hitTarget 检测、时间轴 move/goto）；owner 的 `FighterMC` 偏移；`getHitModel()` 从角色或辅助借 `FighterHitModel`；`GameLogic.hitTarget`；owner 角色 `addQi`。

## 命名备注

- 与 `Assister` 平行：同样的 `gotoAndPlay`=`gotoAndStop`+开 animate、同样的盒缓存/朝向翻转、同样在 `totalFrames-1` 自毁。
- `isAttacking`：**仅** `init()` 在 `moveToTargetX||Y` 为 true 时置 true。无 moveToTarget 的攻击体一直 false（? AI 当它不存在）。`endAct`/`Ctrler.endAct` 会关。
- `destory` **忽略** `param1`，总 `super.destory(true)`。
- `rangeX/rangeY` 是 `Point(min,max)`，来自 params `x.range` 数组。
- `getOwnerFighter`：owner 是辅助时再 `assister.getOwner()` 才到角色。

## 与战斗循环的合同

```
checkHit: getCurrentHits() 可打对方
          getBodyArea()=null → 自己不会 beHit，不挤身
isAlive 默认 true → 进 getAliveChildren，但 body 空所以 getCurrentTarget order=5
hit() 加气：owner 是 Assister 用 0.15，否则 0.13；连击记在角色上
```

## McCtrler / 时间轴怎么驱动

```
addAttacker(mcName, params)
  → EventCtrl new + setOwner + init（放坐标）
时间轴 $attacker_ctrler.move / gotoAndPlay / stopFollowTarget / removeSelf
render: super + ctrler.render + followTarget
renderAnimate: nextFrame + findHitArea + 末帧 remove
```

## 逐行说明

### 字段（L18–50）

- `onRemove` / `isAttacking`。
- `_ctrler` / `_owner`。
- `moveToTargetX/Y`：`init` 时把坐标一次性吸到目标附近。
- `followTargetX/Y`：每逻辑帧贴目标。`stopFollowTarget` 关。
- `rangeX`/`rangeY`：吸过去时相对 owner 的距离钳制。
- `_startX/_startY`：默认 MC 原始 x/y；params 可改成绝对偏移。
- 两份 `McAreaCacher`、`_rectCache`、`_mcOrgPoint`（构造记录 MC 原坐标）。
- `_isRenderMainAnimate=true`。

### 构造（L52–112）

`param1`=攻击体 MC，`param2`=可选参数对象（Event params）。

记下 `_mcOrgPoint=(mc.x, mc.y)`，`_startX/Y` 同，并把基类 `_x/_y` 设成这个（本地偏移，`init` 再加 owner）。`new FighterAttackerCtrler(this)`；有 `setAttackerCtrler` 才挂 SWF。

`param2.x`：

- Number：`_startX = x + org.x`（额外加 MC 原位）。
- 对象：`moveToTarget`/`followTarget` 布尔；`offset` 覆盖 `_startX`；`range` 数组 → `Point(range[0], range[1])`。

y 同理。`applyG==true` 才 `isApplyG=true`（默认基类 true；显式 false 可浮空）。未传 applyG 保持基类默认（受重力）。

### `getOwner` / `name` / `getCtrler`（L114–127）

`name`=`_mainMc.name`，EventCtrl 按这个字符串找回。

### `destory`（L129–150）

两 cache、ctrler destory，清 rect/owner/org，**总是** `super.destory(true)`（不像 Assister 尊重 `param1==false`）。

### `setOwner`（L152–164）

存 owner，`direct = owner.direct`。owner 是 `FighterMain` → ctrler.effect = 角色 EffectCtrl；是 `Assister` → 辅助的 effect。必须在 `init` 前调（EventCtrl 如此）。

### `init`（L166–250）

无 owner return。朝右 `_x = owner.x + _startX`，朝左 `owner.x - _startX`；`_y += owner.y`（构造已把 `_y=_startY`）。owner 是角色再加 `getMC().x/y`（与子弹对齐同一套）。

**若两个 moveToTarget 都 false：直接 return，此时 `isAttacking` 仍 false。**

否则 `getTarget()`（角色/辅助的当前锁敌）：

- **X**：`target.x + _startX*direct`。有 `rangeX` 时，相对 **owner.x** 的距离 `_loc3_` 钳到 `[rangeX.x, rangeX.y]`，朝左用 `owner.x - range`。
- **Y**：`target.y + _startY`。有 `rangeY` 时，差值相对 **owner.y**，但钳回去写的是 **`target.y + rangeY.*`**（不是 owner.y）（? 与 X 不对称）。

最后 `isAttacking=true`。无目标则不改坐标，但仍会置 attacking（只要 move 标志开着）。

### `renderAnimate`（L252–265）

关播放则 return（含 super delay）。否则 super、`mc.nextFrame()`、`findHitArea`。`currentFrame==totalFrames-1` → `removeSelf()`（**不**像辅助那样 `finish` 再播特效）。

### `render`（L267–272）

`super.render()` + `_ctrler.render()`（落地帧、hit check）+ `renderFollowTarget()`。

### `stopFollowTarget` / `renderFollowTarget`（L274–299）

两 follow 标志都关则跳过。有目标：`_x = target.x + _startX*direct`，`_y = target.y + _startY`。**不再**走 range 钳。跟随是瞬移坐标，不是速度。

### `moveToTarget`（L301–316）

运行时再吸一次。`param1/param2` NaN 则该轴不动。`_x = target.x + p1*direct`，`_y = target.y + p2`。Ctrler 同名方法转调。与 `init` 的 range 无关。

### `stop` / `gotoAndPlay` / `gotoAndStop`（L318–333）

同 Assister：Play/Stop 都是 `gotoAndStop` 切标签，靠 animate 的 nextFrame 播。`gotoAndPlay` 的参是 **String**（辅助是 Object，可接帧号）。

### `getTargets` / `getTarget`（L335–359）

`getTargets` 公开：owner 是角色/辅助则转他们的 `getTargets()`。`getTarget` 私有：转 `getCurrentTarget()`。锁敌失败则跟随/moveTo 空操作。

### `removeSelf`（L361–367）

只 `onRemove(this)`。不像辅助那样关 `isAttacking`/`isAlive`（摘出队伍后下一帧不再 render；表里 EventCtrl 会 splice）。

### `getCurrentHits`（L369–401）

与 Assister 同：当前帧 hit 数组 → 填 `currentArea`。无覆盖 `beHit`。`_loc3_=name` 未用。

### `getHitCheckRect` / `getCheckHitRect`（L403–428）

按子件名，盒相对 `_mainMc`，再转世界。Ctrler `renderCheckTargetHit` 用 checker 盒对 `getTargets()` 的 body 做相交，命中则 `gotoAndPlay(hitTargetAction)`。

### `getCurrentRect`（L430–455）私有

与 Assister 相同的 direct 翻转 + `_rectCache[key]`。

### `getHitModel`（L457–468）私有

角色 → `getCtrler().hitModel`；辅助 → `getCtrler().hitModel`。其它 owner `throw "不支持的owner类型!"`。`findHitArea` 每新帧调一次。

### `findHitArea`（L470–522）私有

cache 闸同前。`getHitVOByDisplayName(child.name)`——与 **角色** 同一 API（辅助本体用 `getHitVO`）。无 model 则 return。空数组存 null。

### `getOwnerFighter`（L524–535）私有

角色直接返回；辅助再 `getOwner() as FighterMain`；否则 null。`hit` 加气目标。

### `hit`（L537–547）

不 `super.hit`。有目标且解析到角色：倍率 `_owner is Assister ? 0.15 : 0.13`（辅助放出的攻击体与辅助本体打人同 0.15；角色直放 0.13，介于子弹 0.1 与辅助 0.15 之间）。`addQi(power*倍率)` + `GameLogic.hitTarget(hitVO, 角色, target)`。
