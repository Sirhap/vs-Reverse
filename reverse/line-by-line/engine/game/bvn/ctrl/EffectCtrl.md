# `EffectCtrl` — 全局战斗 VFX 控制器

一句话目的：单例。命中/防御/钢体火花、闪光 overlay、镜头震动、残影、必杀黑底+特写、替身/爆气、慢动作、鬼步、滤镜光晕。`EffectVO`/`EffectModel` 是数据，`EffectManager` 是视图池。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/EffectCtrl.as`（1018 行）

## Callers / callees

- **Callers**
  - `GameState.build` → `initlize(this, _playerLayer)`；`GameState.destory` → `destory()`。
  - `GameCtrl.render`（未 `_isPauseGame` 时）每 tick 调 `render()`。注意 `pause()` 默认只关 `_isRenderGame`，**不**挡 `EffectCtrl.render`，所以 freeze/必杀/鬼步期间特效仍走。
  - `FighterMcCtrler`：`doHitEffect` / `doDefenseEffect` / `doSteelHitEffect` / `doEffectById("break_def")`。
  - `FighterEffectCtrl`：shine / shake / startShake / endShake / startShadow / endShadow / dash ids / bisha / wanKai / jump* / floor / slowDown / energyExplode / replaceSkill / ghostStep / startFilter。角色 SWF 经 `setEffectCtrler` 调这些。
  - `FighterBuffCtrler`：`doEffectById("buff_effect_*")` + `doBuffEffect("buff_*")`。
  - `FighterEventCtrl.addAssister` 与 `AssisiterCtrler.finish`：`assisterEffect`。
  - `FightUI.playKO` / `renderEnd`：关 `freezeEnabled`、`hit_end`、shine、`BGEffect("kobg")`、shake、`slowDown(2,0)` / `slowDownResume`。
  - `SteelHitEffect.setTarget`：`shine(16776960,0.3)`、`setOnFreezeOver`。
  - `Bullet` 触底：`shake(0,1,200)`。
  - `ConfigVO.applyConfig`：写 `EFFECT_SMOOTHING`（不写 SHAKE/SHADOW）。
  - `EffectView` 构造读 `EFFECT_SMOOTHING`。
- **Callees**
  - `EffectManager`：hitVO→EffectVO 克隆、EffectView 池、Shine 池。
  - `EffectModel.I`：`getEffect` / `getDefenseEffect`。
  - `GameCtrl.I`：`pause`/`resume`/`slow`/`slowResume`/`setRenderHit`/`addGameSprite`/`removeGameSprite`/`gameState.cameraFocusOne|cameraResume`。
  - `GameLogic.fixGameSpritePosition`：鬼步 just-render 后夹地图。
  - `SoundCtrl.I.playSwcSound(snd_ghost_jump)`：同包，无 import。
  - Views：`EffectView` / `SpecialEffectView` / `BuffEffectView` / `SteelHitEffect` / `ShineEffectView` / `ShadowEffectView` / `BlackBackView` / `BitmapFilterView`。
  - `GameConfig.FPS_GAME`（默认 60）、`FPS_SHINE_EFFECT`、`FPS_ANIMATE=30`。

## 符号对照 / 命名备注

- 拼写：`destory`、`initlize` 全工程如此，不是 destroy/initialize。
- `I`：懒汉单例。`destory()` **不**清 `_i`，下场 `initlize` 复用同一实例。
- `EFFECT_SMOOTHING`：Bitmap 特效平滑。`ConfigVO`：low/medium/high=false，higher/best=true。
- `SHADOW_ENABLED` / `SHAKE_ENABLED`：默认 true，本包无写入，等于死开关。
- `freezeEnabled`：KO 时 `FightUI` 置 false，挡住 `freeze()` 的 hit-stop，避免 KO 镜头再被定格覆盖。
- `shineMaxCount=3`：比较用 `>`，实际可叠 4 层才踢最旧。
- `_effectLayer`：即 `GameState._playerLayer`，角色/特效同一层。
- `_blackBack`：低分辨率黑 Bitmap 铺满 `GAME_SIZE`。`fadIn`/`renderAnimate` 是空 stub，黑底靠 `addChildAt(...,0)` 立刻出现。
- `_justRenderTargets`：`GameCtrl.pause` 后仍调 `BaseGameSprite.render()`（逻辑/位移）。
- `_justRenderAnimateTargets`：pause 后仍按动画 gap 调 `renderAnimate()`（MC 帧）。
- `freeze` 参数是 **毫秒**，内部 `ms/1000 * FPS_GAME`。
- `shake` 的 `param3` 也是 **毫秒**；衰减分母用 `* 30`（`FPS_ANIMATE`），因为震动在 `renderAnimate` 里 tick。`FightUI.shake(5,0,1.5)` 把 1.5 当 ms 传进来，衰减极快，像 bug（`FighterEffectCtrl.shake` 会 `* 1000`）。
- `slowDown` 的 rate 与 `GameCtrl.slow` 共用：`SPEED_PLUS = SPEED_PLUS_DEFAULT / rate`，动画 FPS = `30/rate`。rate 越大越慢。
- `HitType`：1=KAN 斩，6=KAN_HEAVY，2=DA 拳，3=DA_HEAVY，4=MAGIC，5=MAGIC_HEAVY，7=FIRE，8=ICE，9=ELECTRIC，10=STONE（无 hit 特效），11=CATCH。
- `defenseType`：角色 SWF 设。0=斩防（用 hitType 原样取 defense_*），1=拳防（把 1→2、6→3 再取）。
- `comicType==1`：火影 `fz_naruto`；否则死神 `fz_bleach`。
- 特效 id 对照（`EffectModel.initEffects`）：`bisha`/`bisha_super`、`dash`/`dash_air`、`jump`/`jump_air`、`touch_floor`、`hit_floor*`、`hit_end`、`break_def`、`fz_*`、`replaceSp`/`replaceSp2`、`explodeSp`/`explodeSp2`、`ghost_step`、`kobg`、`buff_*`、`steel_hit_*`、`fire_ing`/`ice_ing`/`shock_ing`。

## 逐行说明

### 静态/实例字段（L32–104）

- `EFFECT_SMOOTHING`：`EffectView` 构造时赋给 `display.smoothing`。
- `SHADOW_ENABLED` / `SHAKE_ENABLED`：`startShadow`/`endShadow`/`shake` 入口闸。
- `_i`：单例槽。
- `shineMaxCount`：闪光并发上限（见 `shine` 的 `>`）。
- `_gameStage`：当前 `GameState`，shake 写它的 `x/y`，必杀把 `_blackBack` 加到它底下。
- `_effectLayer`：特效 Display 的父级。
- `_manager`：`EffectManager`，按 EffectVO 缓存 View，按 HitVO 缓存克隆后的 EffectVO。
- `freezeEnabled`：false 时 `freeze()` 直接 return。`renderFreeze` 仍会在 enabled 时减帧。
- `_freezeFrame`：剩余 hit-stop 帧（游戏帧，不是动画帧）。
- `_effects`：活着的 `EffectView`。结束靠 `addRemoveBack(removeEffect)`。
- `_justRenderAnimateTargets` / `_justRenderTargets`：pause 豁免名单。
- `_shineEffects`：全屏闪光 Bitmap。
- `_shadowEffects`：`Dictionary[DisplayObject → ShadowEffectView]`。
- `_filterEffects`：**字段初始化**就 `new Vector`，`initlize`/`destory` 都不重置。
- `_blackBack`：必杀/替身/爆气/鬼步共用一块黑底。
- `_shakeHoldX/Y`：`startShake` 的常驻振幅，衰减不管它。
- `_shakePowX/Y`：`shake()` 脉冲振幅，按 `_shakeLose*` 衰减。
- `_shakeXDirect` / `_shakeYDirect`：±1，每动画帧翻转。
- `_shakeFrameX/Y`：偶帧才衰减 pow。
- `_shakeLoseX/Y`：每偶帧减多少，最少 1。
- `_renderAnimateGap`：`ceil(FPS_GAME/30)-1`。60fps → 1，即每 2 逻辑帧一拍动画。slowDown 会改。
- `_renderAnimateFrame`：gap 计数。
- `_renderAnimate`：声明了但本文件从未读写。?
- `_slowDownFrame`：慢动作剩余逻辑帧；0 表示不自动恢复（`slowDown(rate, 0)`）。
- `_replaceSkillFrame` / `_replaceSkillFrameHold` / `_replaceSkillPos`：替身演出。
- `_explodeSkillFrame` / `_explodeEffectPos`：爆气演出。
- `_onFreezeOver`：freeze 归零时同步回调。`SteelHitEffect` 用来 `resumeColor`。

### 空构造（L106–109）

真正装配在 `initlize`。`get I` 先 `new` 再等 `GameState.build`。

### `I` getter（L111–117）

`if(!_i) _i = new EffectCtrl()`。`destory` 后 `_i` 仍指向已掏空的实例。

### `destory`（L120–139）

- `_manager.destory()`：拆掉 view/shine 池。
- `_blackBack.destory()`。
- 把 `_effects`、just-render 两表、`_shineEffects`、`_shadowEffects`、`_gameStage`、`_effectLayer` 置 null。
- **不清**：`_i`、`_filterEffects`、`_onFreezeOver`、freeze/shake/slow/replace/explode 计数、`freezeEnabled`。下场 `initlize` 会重建 Vector/Dictionary/BlackBack，但 freeze 帧、震动、慢动作计数可能残留。?
- 活着的 `EffectView` 不逐个 `destory`（依赖 manager 池拆掉）。残影 `ShadowEffectView` 也不 `destory`，只丢 Dictionary。

### `initlize`（L141–153）

`param1`=`GameState`，`param2`=`_playerLayer`。

1. `new EffectManager()`。
2. 绑 stage/layer。
3. 新 Vector：`_effects`、`_justRenderAnimateTargets`、`_justRenderTargets`、`_shineEffects`。
4. `_shadowEffects = new Dictionary()`。
5. `new BlackBackView()`。
6. `_renderAnimateGap = ceil(FPS_GAME/30)-1`：把特效动画锁在 30fps 语义（`GameConfig.FPS_ANIMATE`）。

不重置 `_filterEffects`、shake、freeze、slowDown。

### `render`（L155–190）—— 主循环

`GameCtrl.render` 在 `_isPauseGame` 之后、`_isRenderGame` 之前调用。菜单暂停（`pause(true)`）整段不进；hit-stop/必杀的 `pause()` 仍进。

顺序：

1. `freezeEnabled` 则 `renderFreeze()`。
2. `renderSlowDown()`（与 freeze 无关，KO 飞天慢动作也走这里）。
3. `renderShine()`：闪光每逻辑帧 tick（内部自己再按 `FPS_SHINE_EFFECT` 抽帧）。
4. `_effects[i].render()`：基类空；`SpecialEffectView`/`BuffEffectView` 在这里跟随角色、看 buff/actionState。
5. `isRenderAnimate()` 真则 `renderAnimate()`。
6. `_replaceSkillFrameHold > 0` → `renderReplaceSkill()`（逻辑帧，1 秒 = `FPS_GAME`）。
7. `_explodeSkillFrame > 0` → `renderEnergyExplode()`。
8. `_justRenderTargets`：每人 `render()` + `GameLogic.fixGameSpritePosition`。鬼步位移靠这条， freeze 时别人停、自己还能走。

### `renderShine`（L192–203）

按下标扫 `_shineEffects`。`ShineEffectView.render` 可能 `removeSelf` → `removeShine` 从 Vector splice。一边遍历一边删，偶发跳过下一个。?

### `renderAnimate`（L205–235）

30fps 语义的一拍：

1. 每个 `EffectView.renderAnimate()`：播 bitmap 缓存帧，播完 `removeSelf` → `removeEffect`。
2. `_shadowEffects` 每个 `ShadowEffectView.render()`：隔帧拍残影、alpha 衰减。
3. `_justRenderAnimateTargets.renderAnimate()`：必杀/万解/鬼步角色的 MC 仍在走。
4. `_blackBack.renderAnimate()`：空函数。
5. `renderShakeX()` / `renderShakeY()`：镜头抖在动画拍上，所以 60fps 游戏里 1 秒大约 30 次翻转。

### `isRenderAnimate`（L237–249）

`_renderAnimateGap==0` 则每逻辑帧都动画（30fps 游戏）。否则 `_renderAnimateFrame++ >= gap` 才 true 并清零。60fps + gap=1 → 隔帧。slowDown 把 gap 拉大。

与 `GameCtrl` 自己的 `_renderAnimateGap` 平行，两边都按 30fps 语义，slow 时两边一起改。

### `renderFreeze`（L251–271）

`_freezeFrame>0` 则减 1。到 0：

1. 若有 `_onFreezeOver`，按下标全调，然后置 null。`SteelHitEffect` 在此 `resumeColor`。
2. `GameCtrl.I.resume()`：`_isRenderGame=true`，逻辑恢复。

**不**检查 `freezeEnabled`（外层 `render` 已检查）。freeze 期间新的 `freeze()` 会覆盖 `_freezeFrame`，不会累加。

### `renderShakeX`（L273–294）

`amp = _shakeHoldX + _shakePowX`。`amp>0` 才动：

- `_gameStage.x = amp * _shakeXDirect`。
- 若 `_shakePowX>0` 且 `_shakeFrameX` 为偶：`_shakePowX -= _shakeLoseX`；若减完 `< _shakeLoseX`，pow/frame/lose 全清、`x=0`、return（本拍不再翻转）。
- 否则 `_shakeFrameX++`，direct `*= -1`。

纯 `startShake`（pow=0）会一直按 Hold 振幅左右翻，直到 `endShake`。Hold 与脉冲叠加。

### `renderShakeY`（L296–317）

与 X 对称，写 `_gameStage.y`。顺序微差：Y 先翻 direct 再 `frame++`，X 相反。无功能影响。

衰减条件同样是偶帧。X/Y 独立，可只震一个轴。

### `doHitEffect`（L319–333）

`FighterMcCtrler.doHurt` 命中时。

1. `_manager.getEffectVOByHitVO(hitVO)`：按 `hitType` 取 `hit_N`，**clone** 后把 `shake.pow` 写到 `shake.y`，若 x=y=0 则 x=3。结果按 HitVO 实例缓存。
2. 无 VO 则 return（如 hitType 0/10）。
3. 位置：受击矩形中心。
4. 朝向默认 1；若 VO.`followDirect` 且 `hitVO.owner is IGameSprite`，用 owner.direct。普通 hit 特效 `randRotate` 居多，followDirect 较少。
5. `doEffectVO(vo, cx, cy, direct, target)`。`param3` 是受击者，给 `setTarget` / `specialEffectId`。

### `doDefenseEffect`（L335–372）

`param3`=`fighter.defenseType`。

1. 从 `hitVO.hitType` 起步。
2. `switch(defenseType) case 1`：斩→拳映射。`if hitType==1 → 2`；`if hitType==6 → 3`。两个 if 独立，不是 else-if，但对 1/6 互斥。defenseType≠1 不改。
3. `EffectModel.I.getDefenseEffect(type)`：缺则 fallback `defense_5`（重魔法防）。
4. 位置同样矩形中心。
5. 若 VO 有 `shake.pow`：把 **共享 EffectVO** 的 `shake.x=0`、`shake.y=pow`。与 hit 路径不同，**不 clone**，第一次防御会永久改模型。?
6. followDirect：防御 VO 大多 `followDirect:true`，朝向跟攻击者。
7. `param4` 默认 null；`FighterMcCtrler` 调用没传受击者，所以防御特效一般不 `setTarget`。

### `doSteelHitEffect`（L374–404）

钢体挨打。`hitType` 分三档视觉：

- `0`：直接 return。
- `1`/`6`（斩）：`steel_hit_kan`（`XG_kan2`）。
- `2`/`3`（拳）：`steel_hit_qdj`（`XG_qdj`）。
- default（魔法/火/冰/电/抓等）：`steel_hit_mfdj`。

三者都 `isSteelHit:true` → `EffectManager` 建 `SteelHitEffect`。受击者 `param3` 会 `setTarget`：钢体刷白、超钢体再黄闪 `0xFFFF00`，freeze 结束 `resumeColor`。

位置/朝向同 hit。

### `doEffectById`（L406–413）

按字符串从 `EffectModel` 取 VO，有则 `doEffectVO`。`param4` 朝向默认 1，`param5` 可选 target。

调用方 id：`dash`/`dash_air`、`ghost_step`、`break_def`、`hit_end`、`buff_effect_*`，以及本类内部的 jump/floor/bisha/replace/explode。

### `assisterEffect`（L415–425）

`comicType==1` → `fz_naruto`（`XG_fz_naruto_mc` + `snd_fz`），否则 `fz_bleach`（`XG_fz_bleach_mc` + `snd_dash`）。坐标助手脚底。无朝向、无 target。

出场（`FighterEventCtrl.addAssister`）和收招（`AssisiterCtrler.finish(true)`）各播一次。

### `doEffectVO`（L427–473）—— 特效 VO 的副作用总线

1. `addEffect` 得 `EffectView`，成功则 `_effectLayer.addChild(display)`。
2. `freeze>0` → `freeze(ms)`：pause 逻辑。
3. `shake` 对象：缺省 `time=0`（随后 `shake()` 把 ≤0 收成 500ms）、`x=0`、`y=0`。`Number(...)` 防 undefined。
4. `shine`：缺省 `color=16777215`（白）、`alpha=0.2`。
5. `slowDown`：缺省 `rate=1.5`、`time=1000`。
6. 若 `param5`：`_loc6_.setTarget`。**若 addEffect 失败 `_loc6_` 为 null 会 NPE**。?
7. 若 `specialEffectId` 且 target 是 `FighterMain`：再 `doSpecialEffect`（火/冰/电持续环绕）。

freeze/shake/shine/slowDown 不依赖 View 是否创建成功，数据驱动的世界效果仍会打出。

### `doSpecialEffect`（L475–484）

`getEffect(id)` → `addEffect` as `SpecialEffectView`（VO.`isSpecial`）。`setTarget` 上色（`targetColorOffset`），加到 `_effectLayer`。

`SpecialEffectView.render`：跟随 fighter；`actionState` 23/24/0（倒地/起身/idle?）跳 `"finish"` 并 `resumeColor`。

id：`fire_ing` / `ice_ing` / `shock_ing`，由 hitType 7/8/9 的 `specialEffectId` 进来。

### `doBuffEffect`（L486–496）

同样 `addEffect` as `BuffEffectView`（VO.`isBuff`，`loopPlay=true`）。`setTarget` + `setBuff`。buff `finished` 后 `resumeColor` 并 `remove`。

`FighterBuffCtrler` 先 `doEffectById("buff_effect_speed|power|defense")` 播一次性爆发，再 `doBuffEffect("buff_speed|power|defense")` 循环跟随。

### `addEffect`（L498–509）

`_manager.getEffectView(vo)`：同 VO 池里找 `!isActive` 的，否则按 `isSpecial`/`isBuff`/`isSteelHit` 分型 new。

失败（无 cache、无 class）return null。

`start(x,y,direct)`：播 `sound`、随机旋转、设 scaleX=direct。`addRemoveBack(removeEffect)`，push `_effects`。

同一 VO 可并发多个 View（池耗尽就 new）。

### `removeEffect`（L511–518）

`indexOf` + `splice`。View 自己 `removeSelf` 时回调。不 `destory`，回池等下次 `getEffectView`。

### `freeze`（L520–537）

hit-stop：

1. `!freezeEnabled` 或 `param1<1` return。
2. `_loc2_ = param1/1000 * FPS_GAME`。50ms@60fps=3 帧；400ms=24 帧。`<1` 帧则 return（极短 freeze 会被吃掉）。
3. **覆盖** `_freezeFrame`（连打只保留最后一次时长）。
4. `GameCtrl.I.pause()`：`_isRenderGame=false`，**不是**菜单暂停。`EffectCtrl.render` / `gameState.render` 仍跑，主逻辑与碰撞停。

KO 前 `FightUI` 关 `freezeEnabled`，避免 `hit_end` VO 若带 freeze 再 pause。`hit_end` 实际无 freeze 字段。

### `justRender` / `justRenderAnimate`（L539–553）

按引用去重 push。pause 豁免：ghostStep 两个都加；bisha/wanKai 只加 animate。

### `cancelJustRender` / `cancelJustRenderAnimate`（L555–573）

splice 掉该 sprite。返回 **整张表是否已空**。`endBisha`/`endWanKai`/`endGhostStep` 用这个当“最后一个退出演出的人”才 resume。两人同时必杀时，先结束的那个不会把世界解开。

### `shine`（L575–590）

全屏闪光：

1. `FPS_SHINE_EFFECT==0` 则关（本包 Config 最低 15，不会到 0，等于预留）。
2. `length > shineMaxCount`（3）时踢 `_shineEffects[0].removeSelf()`，腾出最旧。
3. `_manager.getShine()` 池化 `ShineEffectView`。
4. `init(color, alpha)`：`GAME_SIZE/10` 的实心 Bitmap 拉满屏。`color>8388607`（0x7FFFFF）用 `add`，否则 `darken` 且 alpha×0.8。
5. `onRemove=removeShine`，push，**`_gameStage.addChild`**（不是 `_effectLayer`），盖在角色之上、UI 之下（GameState 结构决定）。

`FighterEffectCtrl.shine`：白 `0.3`，其它色 `0.2`。`FightUI` KO 白 `0.5`。超钢体黄 `0xFFFF00`、`0.3`。

### `removeShine`（L592–599）

从 `_shineEffects` splice。View 已从 display list 摘掉。

### `startShake`（L601–605）

只写 `_shakeHoldX/Y`。不改 pow、不复位 stage。与脉冲叠加。`FighterEffectCtrl` 有 `_isShakeIng` 防重复 end。

### `endShake`（L607–613）

Hold 清零，stage x/y 立刻 0。**不**清 `_shakePow*`，若脉冲还在，下一拍 `renderShake` 又会把 stage 挪走。?

### `shake`（L615–663）

脉冲震动。`param1`=x 振幅（可负，符号变 direct），`param2`=y 默认 3，`param3`=时长 ms 默认 500。

1. `!SHAKE_ENABLED` 或 NaN return。
2. 非 0 轴：若当前 pow==0，取 abs 当 pow、符号当 direct；否则 **pow += abs/2**（连打增强，不改方向）。
3. `param3<=0` 收成 500。**1.5 不会被收**，所以 FightUI 的 1.5ms 是真的 1.5ms。
4. `lose = ceil(pow / (time/1000 * 30))`，最小 1。30 = 动画 FPS。500ms、pow=6 → lose=ceil(6/15)=1，约 15 次偶帧衰减。

`FighterEffectCtrl.shake` 只用 Y：`shake(0, max(x,y)*2, sec*1000)`。`doEffectVO` 可两轴。防御 VO 常 `pow=6, time=400`，经 `doDefenseEffect` 改成 x=0,y=6。

### `startShadow`（L665–684）

残影/afterimage。

1. `!SHADOW_ENABLED` return。
2. 若该 `DisplayObject` 已有 View：改 r/g/b，`stopShadow=false`（复活），return。
3. 否则 `new ShadowEffectView(display, r,g,b)`，`onRemove=removeShadow`，`container=_effectLayer`，Dictionary 登记。

`ShadowEffectView`：每隔 `_addBpGap+1` 帧 `KyoUtils.drawDisplay` 一张，alpha 从 0.8 每次 -0.1，插在 container 最底。r/g/b 作 ColorTransform offset。鬼步用 `(0,0,255)` 蓝。

### `endShadow`（L686–701）

`stopShadow=true`。View 不再拍新图，旧图淡完 `removeSelf` → `removeShadow`。Dictionary 空了才真正消失。`!_shadowEffects` 防 destory 后调用。

### `removeShadow`（L703–710）

`delete _shadowEffects[view.target]`。不 destory bitmap 向量以外的东西（View 自己已在淡出时 `removeBitmap`）。

### `bisha`（L712–734）—— 必杀黑底

`FighterEffectCtrl.bisha(isSuper, faceName)`。

1. `justRenderAnimate(fighter)`：只播动画，不跑 `render()` 物理。
2. `GameCtrl.pause()` + `setRenderHit(false)`：停逻辑与碰撞。
3. `_gameStage.addChildAt(_blackBack, 0)` + `fadIn()`（空）。黑底在 GameState 最底，地图/角色之上取决于谁先 add。`GameState` 里 map 与 `_gameLayer` 是它的 child；`_blackBack` 加到 GameState 自身 index 0，通常垫在最下，再靠 `getMap().setVisible(false)` 藏地图。
4. 若有特写 Display 且目标是 `FighterMain`：`showFace`。
5. `param2` 超必：`cameraFocusOne` zoom 3.5 + `bisha_super`（`XG_cbs`）；否则 `bisha`（`XG_bs`）。特效坐标 `(x, y-50)`。
6. 藏地图；`setVisibleByClass(BitmapFilterView, false)` 藏光晕，避免黑底上还亮着 glow。

### `endBisha`（L736–747）

`cancelJustRenderAnimate` 若表已空：

- `resume` + `cameraResume` + `setRenderHit(true)`
- `_blackBack.fadOut()`：拆特写、从 parent 摘掉
- 地图可见；`BitmapFilterView` 再可见

表非空（另一个人还在必杀）则什么都不做，黑底继续。

### `showFace`（L749–763）

比 x：自己 display.x > 对手 → face 槽 2，否则 1。无对手默认 1。`_blackBack.showBishaFace(slot, bmp)`：第一次 new `BishaFaceEffectView`（`bisha_face_mc`），y 随 camera zoom：`100 + 100/zoom`。槽 `facemc1/2`，脸图拉到 254×180。

### `wanKai`（L765–780）—— 万解/完全体，强制超必镜头

与 `bisha(super=true)` 几乎相同：justRenderAnimate、pause、关 hit、黑底、可选脸、`cameraFocusOne`、`bisha_super`、藏地图与 BitmapFilterView。无 `param2` 超必开关，永远当超必。

`FighterEffectCtrl.startWanKai` 只在有 face 名时才传 Display。

### `endWanKai`（L782–792）

同 `endBisha` 的 resume/camera/hit/黑底/地图，**不** `setVisibleByClass(BitmapFilterView, true)`。万解结束后 glow 可能仍 invisible，直到下次有人 `endBisha` 或场景重建。?

`FighterEffectCtrl.endWanKai` 还要求 `actionState==50` 才调这里。

### `jumpEffect` / `jumpAirEffect` / `touchFloorEffect`（L794–807）

薄封装：`jump` / `jump_air` / `touch_floor`。坐标用 `FighterEffectCtrl` 传来的 **display** x/y（不是 fighter 逻辑坐标）。

### `hitFloorEffect`（L809–823）

`param1` 落地强度：

- `0`：`hit_floor`
- `1`：`hit_floor_low`
- `2`：`hit_floor_heavy` **并且** `hit_floor_yan`（烟，`blendMode=lighten`）

来自 `FighterEffectCtrl.hitFloor`。

### `slowDown`（L825–836）

1. `GameCtrl.I.slow(rate)`：
   - 动画 FPS → `30/rate`
   - `SPEED_PLUS = SPEED_PLUS_DEFAULT / rate`（60fps 默认 0.5，rate=1.5 → ≈0.333）
   - `camera.tweenSpd = 2.5 * rate`（慢动作里镜头 tween 变慢? 实际乘大了，tween 更快。?）
2. 自己的 `_renderAnimateGap = ceil(FPS_GAME / (30/rate)) - 1`，与 GameCtrl 的动画抽帧对齐。
3. `param2==0`：`_slowDownFrame=0`，**永不** `slowDownResume`。`FightUI` KO 击飞用 `slowDown(2,0)`，落地再手动 resume。
4. 否则 `_slowDownFrame = ms/1000 * FPS_GAME`。

`FighterEffectCtrl.slowDown(sec)` 固定 rate=1.5、时长 `sec*1000`。VO 默认同样 1.5 / 1000。

覆盖式：新的 slowDown 改 gap 与剩余帧，不叠加。

### `renderSlowDown`（L838–848）

`_slowDownFrame>0` 则减；到 0 调 `slowDownResume`。`==0` 的“永久慢动作”不进这个 if。

在 `render()` 里、freeze 旁，所以 hit-stop 期间慢动作计时仍在走。

### `slowDownResume`（L850–856）

`GameCtrl.slowResume()`：动画 FPS 回 30，`SPEED_PLUS` 回 default，`camera.tweenSpd=2.5`。自己 gap 回 `ceil(FPS_GAME/30)-1`，`_slowDownFrame=0`。

`FightUI` 落地两条路径都调，即使没 slow 过也 harmless。

### `BGEffect`（L858–882）

全屏/背景演出。`FightUI` KO 若任一方 `actionState` 12 或 13（必杀中）则 `BGEffect("kobg", 2)`。

1. `getEffect(id)` 空则 return。
2. `addEffect(data, 0, 0, 1)`：原点。
3. `hold != -1` 则 `effect.holdFrame = hold * 30`。`EffectView` 在动画拍里减 `holdFrame`，30 ≈ 1 秒动画时间。hold=2 → 60 拍 ≈ 2 秒。**若 addEffect 失败，这里 NPE**。?
4. 再挂一个 remove 回调：恢复地图可见。然后立刻 `getMap().setVisible(false)`，`addChildAt(effect.display, 0)` 到 **GameState**（不是 `_effectLayer`）。

`addEffect` 已经 `addRemoveBack(removeEffect)`，这里再加一条。`kobg` 播完同时：从 `_effects` 移除 + 地图回来。

闭包用命名局部变量（`effect`/`id`/`hold`/`data`），是反编译保留的 AS3 闭包写法。

### `setOnFreezeOver`（L884–891）

懒建 `Vector.<Function>`，push。freeze 结束按插入序调完丢弃。无“取消”API。连打钢体可能叠多个 resumeColor。

### `replaceSkill`（L893–902）—— 替身

`FighterMain.replaceSkill` → `FighterEffectCtrl.replaceSkill`。角色侧立刻 `move(250*direct)`、idle、无敌 30 帧；VFX 侧：

1. `pause()`（逻辑停，角色那次 move 已发生在调用前）。
2. 黑底 `addChildAt`（无 fadIn）。
3. 藏地图。
4. `replaceSp`（`XG_tishen` + `snd_fz`）在**调用瞬间**的 x/y。
5. 记下 `_replaceSkillPos`。
6. `_replaceSkillFrame=0`，`_replaceSkillFrameHold=FPS_GAME`（1 秒逻辑帧）。

没有 justRender，角色在 pause 下不再 tick；位移已在 FighterMain 里做完。

### `endReplaceSkill`（L904–910）

`resume`、`fadOut` 黑底、地图回来、`_replaceSkillFrameHold=0`。下一拍 `render` 不再进 `renderReplaceSkill`。

### `renderReplaceSkill`（L912–923）

每逻辑帧 `frame++`。`frame==1`（第一次进来）播 `replaceSp2`（`XG_tishen2`，无声）在记下的 pos。`frame > hold` 则 `endReplaceSkill`。60fps 下第 61 拍结束，约 1s。

### `energyExplode`（L925–933）—— 爆气/霸体爆发

`FighterMain.energyExplode` 同时设超钢体、造 `HitVO`（power 50, hitType 5, hurtType 1, 10 帧判定）。

VFX：pause、黑底、藏地图、`explodeSp`（`XG_bsq` + `snd_baoqi1`）、记下 pos、`_explodeSkillFrame = 0.7 * FPS_GAME`（60fps → 42 帧 ≈ 0.7s）。

### `endEnergyExplode`（L935–942）

`explodeSp2`（`XG_baoqi` + `snd_baoqi`）在原 pos，resume，黑底 fadOut，地图回来，frame=0。

### `renderEnergyExplode`（L944–951）

每逻辑帧减；`<=0` 则 end。与 replace 相反：replace 是加到超过 hold，explode 是从 0.7s 倒数。

`render()` 用 `_explodeSkillFrame > 0` 判断，end 里置 0，不会再进。

### `ghostStep`（L953–962）—— 鬼步/时间暂停移动

`FighterEffectCtrl.ghostStep` 还会 `shadow(0,0,255)` 并设 `_inGhostStep`（之后 `walk()` 播 `ghost_step` 特效而不是脚步声）。

1. `justRender` **和** `justRenderAnimate`：pause 下仍跑物理+动画。
2. `pause()`。
3. 黑底 + `fadIn`。
4. 藏地图。
5. `SoundCtrl.I.playSwcSound(snd_ghost_jump)`：embed MP3，与 VO `ghost_step` 的 `snd_ghost_step` 不是同一个。

不关 `setRenderHit`。justRender 的 `fixGameSpritePosition` 防止鬼步穿出镜头/地图。

### `endGhostStep`（L964–974）

两个 cancel 都返回 true（两张表都空）才 resume、fadOut、地图回来。一人鬼步时两次 cancel 都会空。两人同时鬼步，先结束的只从自己那份摘掉，世界继续冻。

不恢复 shadow（`FighterEffectCtrl.endGhostStep` 自己 `endShadow`）。

### `startFilter`（L976–997）

光晕/滤镜精灵。`FighterEffectCtrl.startGlow`：`GlowFilter(color,1,20,20,2,1,false,true)` + offset `Point(20,20)`。

1. 扫 `_filterEffects`，同一 `target` 则 `update(filter, offset)`。
2. 否则 `new BitmapFilterView(sprite, filter, offset)`，`GameCtrl.I.addGameSprite(0, view, 0)`：team 0，**depth 0** 插入。再 push 向量。

`BitmapFilterView` 实现 `IGameSprite`：每逻辑帧重画目标带滤镜的 Bitmap。必杀时被 `setVisibleByClass` 藏。

### `endFilter`（L999–1015）

按下标找 `target==param1`：`removeGameSprite(view, true)`（destory=true）+ splice + break。只拆一个。找不到则 noop。

`FighterEffectCtrl.endGlow` 即使 `_isGlowIng` 也会把标志清掉。

`destory()` 不清这个向量，跨场可能留死引用。?

---

### 与 `GameCtrl.pause` 的关系（跨文件，读本文件必须知道）

`pause()` / `pause(false)`：只 `_isRenderGame=false`。`GameCtrl.render` 仍：`EffectCtrl.render()` → `gameState.render()` → 然后 return，跳过 `GameMainLogicCtrler`。

因此：

| 演出 | pause | justRender | justRenderAnimate | 关 hit | 黑底 | 藏地图 |
|---|---|---|---|---|---|---|
| freeze（hit-stop） | ✓ | — | — | — | — | — |
| bisha / wanKai | ✓ | — | ✓ | ✓ | ✓ | ✓ |
| replaceSkill | ✓ | — | — | — | ✓ | ✓ |
| energyExplode | ✓ | — | — | — | ✓ | ✓ |
| ghostStep | ✓ | ✓ | ✓ | — | ✓ | ✓ |
| slowDown | — | — | — | — | — | — |
| BGEffect kobg | — | — | — | — | — | ✓ |

菜单 `pause(true)` 设 `_isPauseGame`，连 `EffectCtrl.render` 都不进，闪光/震动/freeze 倒计时会卡住。

### 魔法数速查

| 值 | 含义 |
|---|---|
| 30 | `FPS_ANIMATE`。gap、shake 衰减、BGEffect hold、slow 目标动画帧率都围着它。 |
| `ceil(FPS_GAME/30)-1` | 60fps→1，隔帧播特效动画。 |
| 16777215 | `0xFFFFFF` 闪光默认白。 |
| 8388607 | Shine 里 add/darken 分界（`ShineEffectView`，不在本文件）。 |
| 0.2 | 闪光默认 alpha。 |
| 1.5 | slowDown 默认倍率。 |
| 1000 | slowDown 默认毫秒。 |
| 500 | shake 默认/非法时长。 |
| 3 | `shineMaxCount`；shake 默认 y pow。 |
| `y-50` | 必杀特效上移。 |
| 0.7 * FPS_GAME | 爆气黑底时长。 |
| FPS_GAME | 替身黑底时长（1 秒）。 |
| hold*30 | BGEffect 动画拍。 |
