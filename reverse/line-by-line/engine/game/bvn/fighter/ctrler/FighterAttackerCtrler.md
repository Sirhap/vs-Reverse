# `fighter.ctrler.FighterAttackerCtrler` — 攻击体 SWF 时间轴门面

一句话目的：独立攻击体（手里剑、斩击波、分身等）的 `$attacker_ctrler`。位移/落地/打中检测与 `AssisiterCtrler` 几乎同构；`fire` 借用**主人**的 `hitModel` 克隆 HitVO，owner 改成攻击体自己。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterAttackerCtrler.as`（225 行）

## Callers / callees

- **装配**：`FighterAttacker` 构造 `new FighterAttackerCtrler(this)`；若 MC 有 `setAttackerCtrler` 则注入（SWF 存 `$attacker_ctrler`）。没有该方法也不 throw，攻击体仍能被引擎驱动，只是时间轴调不到本类。
- **主人绑定**：`FighterAttacker.setOwner`：主人是 `FighterMain` → `effect = owner.getCtrler().getEffectCtrl()`；是 `Assister` → `effect = owner.getCtrler().effect`。**共用主人特效实例**，不是自己 new。
- **每帧**：`FighterAttacker.render` → `render()`。
- **取回**：`FighterMcCtrler.getAttacker(name)` → `GameCtrl.getAttacker` → `getCtrler()`。角色时间轴常 `getAttacker("flymc")` 再 `gotoAndPlay`。
- **SWF API**（`decompiled/fighters/*/scripts/*_fla/*.as`）：`move`/`damping`/`stop`/`removeSelf`/`endAct`/`setHitTarget`/`setTouchFloor`/`setCrossMap`/`moveToTarget`/`stopFollowTarget`/`justHit`/`fire`/`effect.shake`。卡卡西幻术用 `justHit` + `owner_fighter_ctrler.getTargetSP()`。
- **Callees**：`FighterAttacker`、主人 `FighterCtrler.justHit` / `AssisiterCtrler.justHit`、`FighterEventDispatcher.FIRE_BULLET`。

## 命名备注

- `destory`：原拼写。
- `ownerMc`：公开字段，**本包从未赋值**（只在 destory 置 null）。SWF/引擎都走 getter `owner_mc_ctrler`。死字段。?
- 无 `defineAction` / 无自己的 `hitModel`：伤害表在主人身上。
- 无 `addAttacker`：攻击体不再套娃出攻击体（要的话走主人 `FighterMcCtrler.addAttacker`）。

## 逐行说明

### 字段 / 构造（L15–33）

- `effect`：公开，`setOwner` 才灌。SWF `$attacker_ctrler.effect.shake(0,3)`。
- `ownerMc`：死字段。
- `_attacker`：所属 `FighterAttacker`。
- `_touchFloor` / `_touchFloorFrame`、`hitTargetAction` / `hitTargetChecker`：同助战。
- 构造 `param1`=`FighterAttacker`，只存引用。

### `owner_mc_ctrler` / `owner_fighter_ctrler`（L35–53）

主人 as `FighterMain` 的 `getMcCtrl()` / `getCtrler()`。助战当主人时两 getter 都 null（`as FighterMain` 失败）。十刃招 1 用 `owner_mc_ctrler.getAttacker("tu")` 链式操控另一攻击体。

### `destory`（L55–60）

三引用置 null。**不** destory `effect`（那是主人的）。`FighterAttacker.destory` 调用。

### `endAct`（L62–65）

`isAttacking=false`。不卸场。时间轴攻击段结束用。

### `render`（L67–84）

同助战：先 `renderCheckTargetHit`；空中清落地标志；刚落地且有帧标签则 `gotoAndPlay` 一次。

### `renderCheckTargetHit`（L86–113）私有

同 `AssisiterCtrler`：`hitTargetChecker` 矩形 vs `getTargets()` 每人 `getBodyArea`，相交 `gotoAndPlay(hitTargetAction)`。不自动清空 checker。

### `stopFollowTarget`（L115–118）

转 `_attacker.stopFollowTarget()`。我爱罗 Timeline_7 用。攻击体构造 params 可开 `followTarget`，此方法关掉。

### `moveToTarget`（L120–123）

`param1` x、`param2` y，默认 `NaN`。转 `_attacker.moveToTarget`（攻击体自己实现贴目标；NaN 表示该轴不改）。与助战/角色的 Object+朝向版本不同。香磷 `moveToTarget(0)` 只传 x。

### `move` / `damping` / `stop` / `gotoAndPlay` / `gotoAndStop` / `setTouchFloor`（L125–153）

与助战同语义。`move` 的 x 乘 `direct`。

### `justHit`（L155–167）

只一个 `param1`（HitVO.id），**没有**跳转标签、也**不**看 `defenseHit`。

- 主人 `FighterMain` → `owner.getCtrler().justHit(param1)`（第二参默认 false）。
- 主人 `Assister` → `owner.getCtrler().justHit(param1)`（助战版本第二参标签默认 null，第三参 false）。
- 其它 → false。

卡卡西 `justHit("cbs1")` 后取 `owner_fighter_ctrler.getTargetSP()`。

### `setHitTarget`（L169–173）

同助战：checker 名 + 命中跳转标签。

### `setCrossMap`（L175–178）

`param1` 真：`isAllowCrossX = isAllowCrossBottom = true`（可出左右边界和底边）。假则两边都关。香磷/十刃刀光 `setCrossMap(true)`。

### `removeSelf`（L180–183）

转 `_attacker.removeSelf()` → `onRemove` → `FighterEventCtrl.removeAttacker`。

### `fire`（L185–222）

`param1` 子弹 MC 名，`param2` 附加参数。

1. 无 `owner_fighter_ctrler` 或无 `hitModel` → `trace("hitModel error!")` return。助战当主人时 getter 为 null，**助战攻击体不能 fire**。?
2. `getChildByName` 取 MC。
3. 有 MC：从**主人** `hitModel.getHitVOByDisplayName(mcName)`；没有 → `trace("hitVO error!")` return（**不再重试**）。
4. `hv.clone()`，`hv.owner = _attacker`（判定归属攻击体，不是主人），塞进 params，`FIRE_BULLET`。
5. 无 MC：1 动画帧后原参数重入。

痛 `fire("zh1atm", {x:..., y:...})` 从攻击体再射子弹。
