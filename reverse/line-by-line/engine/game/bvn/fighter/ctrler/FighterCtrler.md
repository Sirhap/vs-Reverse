# `fighter.ctrler.FighterCtrler` — 角色 SWF 的 `$fighter_ctrler`

一句话目的：角色时间轴看到的引擎门面。SWF `setFighterCtrler` 收到本对象，用它登记 HitVO/必杀脸/语音、写 speed/jumpPower/heavy/defenseType、`initMc` 挂动作 MC，招式帧里 `moveToTarget`/`justHit`/`doWanKai`。对内再持有 `FighterMcCtrler` / `FighterEffectCtrl` / `FighterVoiceCtrler` / `FighterHitModel`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterCtrler.as`（545 行）

## Callers / callees

- **装配**：`FighterMain.initlize`：`new FighterCtrler()` → `_mainMc.setFighterCtrler(_fighterCtrl)`（SWF `$fighter_ctrler = param1`，常把 `defineAction` 别名到时间轴）→ `initFighter(this)`（里面再 `setEffectCtrler` / `setFighterMcCtrler`）。缺 `setFighterCtrler` 在 `FighterMain` 就 throw。
- **动作输入**：`GameCtrl.addFighter` → `FighterMain.setActionCtrl` → `setActionCtrl` → `FighterMcCtrler.setActionCtrler`。
- **每帧**：`FighterMain.render` / `renderAnimate` 转发到 McCtrler。
- **判定**：`FighterMain.getCurrentHits/getBodyArea/getHitRange` 转本类；AI `FighterAILogicBase.targetInRange` 经 `FighterMain.getHitRange`。
- **SWF 时间轴 API**（`decompiled/fighters/*/scripts/*_fla/`，尤其 `MainTimeline.as` 与动作 MC）：

| 方法 | 谁用 |
|------|------|
| `defineAction` | 几乎每角色 frame2，登记 tk/k1/zh1/bs… |
| `defineBishaFace` | 必杀脸 BitmapData 类 |
| `defineHurtSound/Fly/Die` | 语音 Class；有的角色空调用 |
| `speed/jumpPower/heavy/defenseType` | 全员写；`energy=150` 仅石田 |
| `initMc(this.mc)` | 每个形态帧末尾，挂动作 MC |
| `doWanKai()` / `doWanKai(4)` | 一护/鸣人/佐助/白哉/露琪雅…切完全体 |
| `moveToTarget` / `moveOnce` | 招式瞬移、突进 |
| `setDirectToTarget` / `setCross` | 瞬移后朝向、穿人 |
| `justHit` / `targetInRange` | 连段条件、距离门 |
| `addHp` / `addHpPercent` / `loseHp` | 织姬回血、香磷%、小李自伤 |
| `target`（DisplayObject） | `target.visible = false` 藏对手 |
| `getTargetSP` / `getTargetState` | 卡卡西抓精灵；一护零 `==21` 被打 |
| `setTargetVelocity` / `setTargetDamping` | 我爱罗/攻击体改对手速度 |

- **Callees**：`FighterHitModel`、`FighterEffectCtrl`、`FighterMcCtrler`、`FighterVoiceCtrler`、`FighterMC.initlize`、`GameCtrl.I.gameState.getMap()`。

## 命名备注

- `destory` / `initlize`（FighterMC 侧）/ `wankai`：原拼写。`_doingWankai` 字段用 k。
- `defenseType`：0=斩防，1=拳防（`EffectCtrl` 取 defense_* 时把斩 hitType 映射成拳）。
- `energy` getter 返回的是 `energyMax` 不是当前气。setter 同时写 `energy` 与 `energyMax`。
- `hp` setter 同时写 `hp` / `hpMax` / `customHpMax`。getter 是当前血。
- 动作 MC 与根 SWF 是两层：根 `FighterMain.mc`（MainTimeline）被 `setFighterCtrler`；内部 `this.mc` 才是 `initMc` 包进 `FighterMC` 的那份。

## `$fighter_ctrler` 注入顺序

```
FighterMain.initlize
  new FighterCtrler
  mainMc.setFighterCtrler(ctrler)     → $fighter_ctrler
  ctrler.initFighter(this)
    new FighterHitModel / FighterVoiceCtrler
    mainMc.setEffectCtrler(effect)    → $effect_ctrler
    new FighterMcCtrler
    mainMc.setFighterMcCtrler(mcCtrl) → $mc_ctrler
  mainMc.gotoAndStop(startFrame+1)    → 形态帧跑 defineAction / initMc
```

`initMc` 里 `FighterMC.initlize(mc, fighter, mcCtrl)` 会 `setMc`。之后 `setActionCtrl` 才能接到 McCtrler。

## 逐行说明

### 字段 / 构造（L18–34）

- `hitModel`：公开。SWF 不直接碰，`defineAction` / `getCurrentHits` / 子弹 `getHitVOByDisplayName` 用。
- `_effectCtrl` / `_fighterMcCtrl` / `_voiceCtrl` / `_fighter`。
- `_rectCache`：`getCurrentRect` 按 key 复用 Rectangle，少 GC。
- `_doingWankai`：`doWanKai` 置 true，下一回 `initMc` 走「开场」而不是 idle。
- 构造空。

### `destory`（L36–64）

依次 destory effect / McCtrler（McCtrler 再 destory `IFighterActionCtrl`）/ voice / hitModel，清 `_rectCache`、`_fighter`。不单独 end 特效。

### `getEffectCtrl` / `getVoiceCtrl`（L66–74）

引擎用。攻击体 `setOwner` 取 effect；McCtrler 受击取 voice。

### 属性转发（L76–134）

| 存取 | 读 | 写 |
|------|----|----|
| `hp` | `_fighter.hp` | `hp = hpMax = customHpMax = param1`（三份一起改，当自定义血上限） |
| `energy` | **`energyMax`** | `energy = energyMax = param1` |
| `speed` | `FighterMain.speed` | 直写。buff 到期会写回 resumeValue |
| `jumpPower` | 跳速 | 直写 |
| `heavy` | 重量（击飞抗性） | 直写 |
| `defenseType` | 0 斩 / 1 拳 | 直写 |

SWF 几乎只写不读。`energy` getter 若被读到是上限。石田 `energy = 150` 把气条拉到 150。

### `addHp` / `addHpPercent` / `loseHp` / `loseHpPercent`（L136–154）

转 `FighterMain.addHp/loseHp`。Percent 乘 `hpMax`。织姬 `addHp(recoveryBisha)` 多帧；香磷 `addHpPercent(0.03)`；小李 `loseHp(100/200)` 杜门自伤（先 `hp > 300` 才扣）。

### `self` / `target`（L156–169）

自己 / 当前目标的 **DisplayObject**。无目标 null。SWF `target.visible = false` 藏对手影片（神威、小李）。这是显示对象不是精灵。

### `getTargetSP`（L171–179）

当前目标 `IGameSprite`。卡卡西抓到后读坐标。无目标 null。

### `getTargetState`（L181–189）

目标 as `FighterMain` 的 `actionState`。不是角色 → 0。一护零 `== 21`（被打）。21=hurt，22=hurtFly，50=万解中。

### `setTargetVelocity` / `setTargetDamping`（L191–207）

目标是 `BaseGameSprite` 才写。我爱罗 `setTargetVelocity(0,-3)`；攻击体经 `owner_fighter_ctrler.setTargetDamping(0,0)`。

### `targetInRange`（L209–238）

`param1` x 区间 `[min,max]`，`param2` y 区间，都可空（空则该轴恒 true）。无目标 false。

x：朝右 `target.x - self.x`，朝左反过来 → **正值=前方**。y：`target.y - self.y`，**不**随朝向翻转（上负下正取决于坐标系；本游戏 y 向下为正，正=目标更低）。

两边都落在闭区间才 true。李/葛力姆乔 `targetInRange([0,300])` 决定瞬移还是 `moveOnce` 前冲。

局部 `_loc8_ = this.target` 后又 `if(!target)` 再读一次 getter，结果应相同。

### `justHit`（L240–262）

`param1` HitVO.id，`param2` 默认 false=是否连 `defenseHit` 也算。目标须是 `FighterMain`：先比 `hurtHit.id`，没有再（param2）比 `defenseHit`。鸣人 `justHit("bs1")`、神威 `justHit("k5", false)`。

### `getMcCtrl`（L264–267）

返回 `_fighterMcCtrler`。助战/攻击体经 `owner_fighter_ctrler.getMcCtrl()` 调 `idle`/`getAttacker`/`gotoAndPlay`。

### `initFighter`（L269–288）

`param1`=`FighterMain`：

1. 存引用，`new FighterHitModel(_fighter)`，`new FighterVoiceCtrler()`。
2. SWF 必须有 `setEffectCtrler`，否则 throw `"初始化效果接口失败，SWF未定义setEffectCtrler()"`。
3. `new FighterEffectCtrl` → `setEffectCtrler`。
4. 必须有 `setFighterMcCtrler`，否则 throw `"…未定义setFighterMcCtrler()"`。
5. `new FighterMcCtrler`，把 `effectCtrler` 赋上，`setFighterMcCtrler`，return。

本包角色 SWF 三个 setter 都有。检查顺序是先 effect 后 Mc，所以缺 Mc 时 effect 已经注入。

### `renderAnimate` / `render`（L290–304）

有 McCtrler 才转。`FighterMain` 对应方法调用。McCtrler.render 里才 poll 键/AI。

### `setActionCtrl`（L306–316）

`param1`=`IFighterActionCtrl`。有 McCtrler 则 `setActionCtrler`，否则 `trace("设置ctrler失败！")`。须在 `initFighter` 之后；`addFighter` 顺序是 `initlize`（含 initFighter）再 `setActionCtrl`，OK。`FighterMain.setActionCtrl` 随后还 `param1.initlize()`。

### `defineAction`（L318–321）

`param1` id，`param2` HitVO 字面量。`hitModel.addHitVO`（owner=角色）。SWF 根时间轴几乎全部招式表。动作 MC 里的 atm 子件名靠 `getHitVOByDisplayName` 剥 `atm` 对上这个 id。

### `defineBishaFace`（L323–326）

`param1` 脸名，`param2` Class → `_effectCtrl.setBishaFace`。须在 `initFighter` 之后（effect 已有）。形态帧里写在 `initMc` 前。

### `defineHurtSound` / `defineHurtFlySound` / `defineDieSound`（L328–341）

`...rest` 当 Array 塞进 voice 槽 0/1/2。无参则空数组。

### `initMc`（L343–363）

`param1` 动作 `MovieClip`（SWF `this.mc`）。null → throw `"FighterCtrler.initMc Error :: mc is null!"`。

`new FighterMC().initlize(mc, fighter, _fighterMcCtrl)`（内部 `setMc`）。若 `_doingWankai`：`actionState=50`，`goFrame("开场")`，清标志。否则 `McCtrler.idle()`。

万解切形态：`doWanKai` 让根 SWF 进下一帧 → 该帧再 `defineAction` + `initMc` → 这里播新形态「开场」而不是站立。

### `getCurrentHits`（L365–401）

try `FighterMC.getCurrentHitArea()`，catch 只 trace。空/长度为 0 → null。否则对每条有 `hitVO` 的：`hitVO.currentArea = getCurrentRect(area, "hit"+index)`，推进数组。无名 HitVO 的子件跳过。`_loc8_` 声明后没赋 0，AS3 int 默认 0。

### `getBodyArea`（L403–419）

try `getCurrentBodyArea()`。null → null。否则 `getCurrentRect(..., "body")`（缓存同一 Rectangle）。

### `getHitCheckRect`（L421–429）

`param1` 检测子件名。`FighterMC.getCheckHitRect` 空则 null。缓存 key **写死** `"hit_check"`：连续查两个名字会覆盖同一 Rectangle。调用方须立刻用完。

### `getCurrentRect`（L431–456）

`param1` 本地矩形，`param2` 缓存 key（null 则每次 new，不进表）。

世界坐标：`x = local.x * direct + fighter.x`；朝左再 `- width`（把原点从右缘改回左缘）。`y = local.y + fighter.y`。宽高不翻转。

### `doWanKai`（L458–469）

`param1` 根 SWF 帧号，默认 0=`nextFrame()`，否则 `gotoAndStop(param1)`。先 `_doingWankai=true`。根时间轴下一形态帧会重新 `defineAction` + `initMc`。一护 `doWanKai()` 与 `doWanKai(4)`。

### `setDirectToTarget`（L471–479）

有当前目标才 `direct = x < target.x ? 1 : -1`。瞬移后常用。

### `moveOnce`（L481–485）

`param1` x 乘朝向，`param2` y。直接改 `fighter.x/y`，不是速度。李「够不着就 `moveOnce(300,0)` 前冲」。

### `moveToTarget`（L487–527）

`param1` x 偏移（Object，null 跳过），`param2` y 偏移，`param3` 默认 true=结束后朝向目标。无目标 return。

x：`target.x + offset * fighter.direct`。若 `offset > 0` 再 try 贴边：

- 目标 `x < offset`（贴左）：改成 `target.x + offset`（无视朝向，人放目标右侧）。
- 目标 `x > map.right - offset`（贴右）：`target.x - offset`。
- `getMap()` 失败吞掉。

y：`target.y + Number(param2)`。最后按 `param3` 朝向。SWF 常 `moveToTarget(-10, null, false)` 只改 x、不转身。

### `setCross`（L529–532）

`param1` → `fighter.isCross`。true 时可穿过对方身体（神威、虚化位移）。须成对 `true/false`。

### `getHitRange`（L534–542）

`param1` AI 范围盒名（`FighterMC` 从子件 `AImain` 帧 2 按 `FighterHitRange.getALL()` 取）。null → null。缓存 key `"hitRange_"+name`。AI 用它跟目标 `getBodyArea` 做相交，角色时间轴本包未见调用。
