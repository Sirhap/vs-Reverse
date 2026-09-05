# `Bullet` — 飞行弹（直接实现 `IGameSprite`，不继承 `BaseGameSprite`）

一句话目的：时间轴 `FIRE_BULLET` 生成的独立精灵。自己管坐标/速度/朝向/寿命，无重力通道、无阻尼 Point。攻击盒与身体盒是同一块 `_bulletArea`。打人给 **owner 角色** 加气；弹打弹改速度或扣 hp。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/Bullet.as`（549 行）

## Callers / callees

- **创建**：仅 `FighterEventCtrl.fireBullet`：`new Bullet(params.mc, params)` → `onRemove=removeBullet` → `setHitVO(params.hitVO)` → `addGameSprite(发射者 team.id)`。事件来自 `FighterMcCtrler.fire`、`FighterAttackerCtrler`、`AssisiterCtrler`。
- **主循环**：`GameMainLogicCtrler` 当普通 `IGameSprite`：`fixGameSpritePosition`（可穿左右、不可穿底）、**不** `applayG`（不是 Base）、`render`/`renderAnimate`、`checkHit` 用 `getCurrentHits`/`getBodyArea`/`hit`/`beHit`。`checkBodyHit` 要求 Base，子弹不参与挤身。
- **AI**：`FighterAILogic` 对 `Bullet.isAttacking()` 当威胁。
- **Callees**：`GameLogic.isTouchBottomFloor` / `isOutRange` / `hitTarget`；`EffectCtrl.shake`；`MCUtils.hasFrameLabel`；`KyoUtils.setMcVolume`；`HitVO.clone`；owner `FighterMain.getMC`/`addQi`。

## 命名备注

- **不是** `BaseGameSprite`：没有 `_velocity`/`applayG`/`loseHp`/`delayCall`。`x/y` 直接读写 `mc.x/y`。
- `isAttacking()` 是 **方法**（辅助/攻击体是字段）。返回 `_hitAble`。
- `holdFrame=-1`：无限寿命，除非 MC 标签 `remove` 或播到倒数第 2 帧。
- `hitTimes=-1`：无限穿透；`>0` 每打中一次减，到 0 `doHit`。
- `destory` 忽略 `param1`，总拆 MC。
- `getIsTouchSide` 恒 false、`setIsTouchSide` 空：贴边逻辑对子弹无效，但 `hit` 里仍问 **目标** 是否贴边。

## 与战斗循环的合同

```
getCurrentHits() → [_hitVO]（_hitAble 且有盒）
getBodyArea()/getArea() → 同一世界矩形（可被其它弹/招打掉）
hit(hitVO, target)：
  target 是 Bullet → 只改自己 speed 为 hitSpeed，不 doHit
  否则扣 hitTimes、owner 加气、按 hitSpeed 改自己速度
beHit(hitVO)：被弹打扣对方 hpMax，被招打扣 power；hp<=0 则 doHit
allowCrossMapXY=true / Bottom=false
```

`TeamVO.getAliveChildren`：非 Base → **总是**算活的，可能进 `FighterMain.getTargets`（order 2）。

## 逐行说明

### 字段（L20–70）

运动：

- `speed=(5,0)`：每逻辑帧位移（再乘 `_speedPlus`）。
- `addSpeed=(0,0)`：加速度。params 里 `x.add` **先 ×2** 再存。
- `maxSpeed=(999,999)` / `minSpeed=(-999,-999)`：分量钳制。朝左时 x 钳在 `[-max, -min]`。
- `hitSpeed=(NaN,NaN)`：打中后改用的速度；NaN = 不改。

寿命 / 战斗：

- `holdFrame=-1`：逻辑帧寿命。`params.hold` 非 -1 则 `hold * FPS_GAME`。
- `hitTimes=-1`：剩余可命中次数。
- `hp`/`hpMax=100`：被打掉血。`params.hp` 同时写两者。
- `onRemove` / `mc` / `owner`。
- `_area`：声明后只在 destory 清空，从未赋值（死字段）。`getArea` 用 `_bulletArea`。
- `_orgScale` / `_orgRotate`：构造时 MC 的 scale/rotation，`direct` setter 用来翻。
- `_team`：`addGameSprite` 写入。
- `_isHit`：进了 hit 动画后 `render` 不再飞。
- `_isTimeout`：寿命到且有 `"timeout"` 标签，切过去，不再减 hold。
- `_bulletArea`：相对发射瞬间的本地盒。
- `_hitVO`：clone 后 `owner=this`（判定源是弹，不是角色）。
- `_loopFrame`：`"loop"` 标签跳回 `"loop_start"` 或 1。
- `_hitAble=true`：`hit_over` 或 `doHit` 后 false。
- `_speedPlus=GameConfig.SPEED_PLUS`：慢动作 `setSpeedRate` 刷新。
- `_destoryed` / `_direct` / `_currentRect` 复用。

### 构造（L72–160）

`param1`=弹 MC（通常从角色/辅助/攻击体时间轴 `getChild` 出来），`param2`=发射参数（Event 的 params 整包传入，含 x/y/hold/hits/hp，以及稍后 `setHitVO` 用的 hitVO）。

记下 scale、rotation。`param2.x` 若是 Number → `speed.x`；若是对象：`start`/`add*2`/`max`/`min`/`hit`。y 同理。`hold==-1` 保持无限，否则 `* FPS_GAME`。`hits`→`hitTimes`，`hp`→`hp` 与 `hpMax`。

**此时还没放进世界**——`setHitVO` 才对齐 owner 并设朝向。

### `x` / `y` / `team`（L162–190）

直接代理 `mc` 与 `_team`。无独立 `_x/_y`。

### `isAttacking`（L192–195）

返回 `_hitAble`。AI 用。

### `setSpeedRate` / `setVolume`（L197–205）

慢动作倍率；音量走 `KyoUtils.setMcVolume`（基类是改 `soundTransform`）。

### `direct`（L207–224）

存 `_direct`。副作用：

- `mc.scaleX = orgScale.x * direct`
- `mc.rotation = orgRotate * direct`
- **`mc.x *= _direct`**（本地 x 按朝向翻）
- `speed.x *= param1`、`addSpeed.x *= param1`、`hitSpeed.x` 非 NaN 也乘

`setHitVO` 只调一次。若再设一次会把速度再乘一次（翻两次回正? 不，两次 -1 才回正）。朝右 `direct=1` 乘 x 不变。

### `setHitVO`（L226–257）

`param1` 原 HitVO（角色 hitModel 里的模板）。`owner = param1.owner`（角色/辅助/攻击体）。clone 后 **`_hitVO.owner = this`**，判定源变成弹。

攻击盒：优先子件 `"main"` 的 `getBounds(owner.getDisplay())`，否则整 MC bounds；再减去 `mc.x/y` 变成相对弹本地。然后 `direct = owner.direct`（翻 scale/rotation/mc.x/速度），`mc.x/y += owner.x/y`。owner 是 `FighterMain` 再加 `getMC().x/y`，并从 `_bulletArea` 减掉 MC 偏移（盒相对角色根，要改成相对弹）。

调用序必须在 `addGameSprite` 前——EventCtrl 如此。无 `hitVO` 会 NPE（? EventCtrl 不检查）。

### `destory` / `isDestoryed`（L259–283）

闩 `_destoryed`，`mc.stopAllMovieClips()` 后 null，清空速度/owner/盒。`param1` 未用。`removeGameSprite` 会调接口 `destory`。

### `renderAnimate`（L285–317）

`mc.nextFrame()`，看 `currentLabel`：

| 标签 | 行为 |
|---|---|
| `"loop"` | 首次解析 `_loopFrame`=`loop_start` 或 `1`，`gotoAndStop` 回去 |
| `"remove"` | `removeSelf` |
| `"hit_over"` | `_hitAble=false`（还飞，不再打人） |
| 其它 | 若 `currentFrame==totalFrames-1` → `removeSelf` |

与辅助一样在倒数第 2 帧自毁，给最后一帧显示。`doHit` 切 `"hit"` 后若该段播到末尾也会 remove。

### `render`（L319–383）

`_isHit` 则 return（撞了播 hit 动画，不再飞）。否则：

1. `mc += speed * _speedPlus`
2. `speed += addSpeed * _speedPlus`
3. 按朝向钳 x：右 `[min,max]`，左 `[-max, -min]`（注意 minSpeed 默认 -999，朝左时 `speed.x > -minSpeed.x` → `> 999` 才钳，等于几乎不钳下限? 朝左 min 限制是 `speed.x > -(-999)=999`，即 x 不能大于 999。朝左的「最小速度」语义别扭，依赖 params 显式给 min）。
4. y 直接对 `maxSpeed.y`/`minSpeed.y`。
5. `holdFrame!=-1 && !_isTimeout`：减 1，到 0 时无 `"timeout"` 标签则 remove；有则切 timeout、`_isTimeout=true`。
6. `GameLogic.isTouchBottomFloor(this)`：`hit(_hitVO, null)` + 震屏 `(0,1,200)` return。`hitTimes==-1` 时 **不** `doHit`，下帧还会再撞地板再震（?）。
7. `isOutRange` → `removeSelf`（穿出地图）。`allowCrossMapXY` true 所以左右不在 fixPosition 卡住，靠这条删除。

### `getDisplay`（L385–388）

返回 `mc`。`GameState` addChild。

### `removeSelf`（L390–396）私有

只调 `onRemove(this)`。真正从队伍/显示列表摘掉由 EventCtrl `removeGameSprite` 负责。

### `doHit`（L398–413）私有

未 `_isHit` 则 `try gotoAndStop("hit")`，缺标签 catch `trace("Bullet", e)`。然后 `_isHit=true`、`_hitAble=false`。之后 `render` 停飞，`renderAnimate` 继续播 hit 段直到 remove。

### `hit`（L415–469）—— 打中别人 / 撞地板

`param1` 是自己的 HitVO，`param2` 是目标（地板路径为 null）。

1. 目标是 `Bullet`：若 hitSpeed 分量非 NaN，把 **自己** speed 改成 hitSpeed，**return**（弹碰弹不当命中消耗，也不加气）。对方会走自己的 `beHit`。
2. `hitTimes!=-1`：`--` 后 `<=0` → `doHit()`。
3. 有目标且 owner 是 `FighterMain`：`addQi(power*0.1)`，`GameLogic.hitTarget(hitVO, owner, target)`。注意这里 `param1.owner` 已是子弹，`isBisha` 仍看 id。
4. 有目标：`hitSpeed` 都是 0 则 return（停在原地继续? 不改速度）。若目标是 Base 且 **贴边**：把 NaN 的 hitSpeed 填成当前 speed，再各 ×0.5（绝对值 <1 则 0）——贴墙反弹弱化。最后非 NaN 的 hitSpeed 写入 speed。

地板 `param2=null`：只走 1（否）、2（可能 doHit）、3（跳过）、4（跳过）。

### `beHit`（L471–485）

攻击者 `param1.owner` 是 Bullet：`hp -= 那发 hpMax`（用对方最大弹血，不是剩余）。否则 `hp -= param1.power`（注意不是 `getDamage()`，不吃 powerRate）。`hp<=0` → `doHit`。不派事件、不加气。

### `getCurrentHits`（L487–495）

无 VO / 无盒 / 不能打 → null。否则 `_hitVO.currentArea = getCurrentRect(_bulletArea)`，返回单元素数组。`checkHit` 用。

### `getArea` / `getBodyArea`（L497–513）

都是 `_bulletArea` 转世界。无盒 null。身体=攻击盒 → 弹可以互打。`MapMain` 遮罩也用 `getArea`。

### `getCurrentRect`（L515–527）私有

复用 `_currentRect`：`x = local.x*_direct + mc.x`，朝左 `-width`；`y = local.y + mc.y`。与 Assister 相同。

### `allowCrossMapXY` / `allowCrossMapBottom`（L529–537）

true / false。左右可出界（出界后 `isOutRange` 删），底边仍被 `fixGameSpritePosition` 和 `isTouchBottomFloor` 管。

### `getIsTouchSide` / `setIsTouchSide`（L539–546）

恒 false；setter 空。`fixGameSpritePosition` 写进来被丢。`hit` 里问的是 **对手** 的贴边。
