# `FighterMC` — 角色时间轴播放器 + 攻击/受击盒缓存 + 击飞状态机

一句话目的：包一层角色 SWF 的主 MC。`goFrame` 切帧标签；`renderAnimate` 进主时间轴、推进子 MC、扫描 `bdmn`/`atm*` 盒。击飞/倒地动画是独立 4 态机，写 `FighterMain.actionState` 并派 `HURT_DOWN`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterMC.as`（591 行）

## Callers / callees

- **创建**：仅 `FighterCtrler.initMc(mc)`：`new FighterMC()` → `initlize(mc, fighter, mcCtrler)`。SWF 时间轴在定义完 hit 后调 `$fighter_ctrler.initMc(this)`。
- **FighterMcCtrler 调用**：`goFrame`、`stopRenderMainAnimate`、`checkFrame`、`getChildByName`、`renderAnimate`、`getCurrentFrameCount`、`playHurtFly`、`playHurtDown`、`stopHurtFly`。
- **FighterCtrler 调用**：`getCurrentHitArea`、`getCurrentBodyArea`、`getHitRange`；万解 `initMc` 时 `goFrame("开场")`。
- **FighterMain**：`getMC()` 给子弹/攻击体对齐发射点；`hasWankai`/`die` 转 `checkFrame`/`playHurtDown`。
- **Callees**：`McAreaCacher`（body/hit/hit_check 三份）；`FighterHitModel.getHitVOByDisplayName`；`MCUtils.hasFrameLabel`；`FighterEventDispatcher`（`HURT_DOWN`）；`FighterHitRange.getALL`；`McCtrler.effectCtrler.shake/hitFloor`、`touchFloor`。

## 命名备注

- `initlize` / `destory`：原拼写。
- `_mc`：角色动作 MC（SWF 里交给 `initMc` 的那个），**不是** `FighterMain._mainMc` 根。`x/y` 是这层相对根的偏移，子弹发射要加上。
- 子件约定：`bdmn` = 身体盒；名字含 `atm` = 攻击盒（hitModel 按 displayName 查 HitVO）；`AImain` = AI 射程样板，跳过动画推进。
- `_hurtFlyState`：0 无，1 飞，2 落地，3 弹，4 倒地起身倒数。`switch(state-1)` 所以 case 0 = 态 1。
- `x` setter 写成 `_mc.x = x`（读 getter）而不是 `param1`，赋值无效（bug）。

## McCtrler 怎么驱动本类

```
idle / doAttack / doBisha / sayIntro / ...
    → goFrame(帧标签, isPlay, playFrame, delayObj)
renderAnimate（动画 tick）
    → _mc.renderAnimate() → nextFrame + 扫盒 + 击飞机
doHurt hurtType=1 → playHurtFly
倒地 / 死亡补动画 → playHurtDown
受身起身 → stopHurtFly
```

## 逐行说明

### 字段（L17–60）

- `_mcCtrler` / `_fighter` / `_fighterDisplay`：`initlize` 注入。盒的 `getBounds` 相对 `_fighterDisplay`（角色根显示对象）。
- `_renderMainAnimate` / `_renderMainAnimateFrame`：主时间轴是否 `nextFrame`。`goFrame(..., false)` 停在标签；`true` 且 `playFrame>0` 播这么多帧后自动停。
- `_curFrameName` / `_curMainFrameCount` / `_curFrameCount`：当前标签、主轴已播帧、自上次 `goFrame` 起的动画 tick（含子逻辑）。
- `_undefinedFrames`：`checkFrame` 找不到的标签缓存，避免每帧 `hasFrameLabel`。
- `_hurtFlyFrame` / `_hurtDownFrame` / `_hurtFlyState` / `_hurtYMin` / `_isHeavyDownAttack`：击飞机。
- 三份 `McAreaCacher`：`body` / `hit` / `hit_check`。
- `_hitRangeInited` / `_hitRangeObj`：AI 射程懒初始化。
- `_goFrameDelay`：`{name|call, delay, isPlay, playFrame}`，`renderAnimate` 倒数后切下一帧或回调。
- `_hitx` / `_hity`：击飞初速，落地震屏用。

### 构造（L62–65）

空。真正初始化在 `initlize`。

### `currentFrameName` / `getCurrentFrame` / `getCurrentFrameCount`（L67–80）

标签名、MC 当前帧号、自 `goFrame` 起的 tick。`McCtrler` 用 Count==2 做跳中切帧。

### `x` / `y`（L82–100）

读写 `_mc.x/y`。**setter x**：`_mc.x = x` 等于赋成当前值，`param1` 丢弃（bug）。`y` setter 正确。外部主要读（子弹/攻击体偏移）；写入少，故未必踩到。

### `initlize`（L102–109）

`param1`=动作 MC，`param2`=角色，`param3`=McCtrler。存 display=`param2.getDisplay()`，并 `param3.setMc(this)` 回挂。拼写 `initlize`。

### `destory`（L111–131）

三份 cache `destory`，清空 fighter/display/undefined 列表。**不** stop/null `_mc`（根 `FighterMain.destory` 会 `stopAllMovieClips`）。

### `getChildByName`（L133–136）

转 `_mc`。时间轴脚本要找子件（跟随 MC、特效锚点）走 McCtrler 再进这里。

### `renderAnimate`（L138–175）

每动画 tick：

1. 若 `_renderMainAnimate`：`playFrame` 倒数到 0 则关掉播放；`_curMainFrameCount++`；`_mc.nextFrame()`。`playFrame==0` 且仍 true 会一直 next（循环到 SWF 末尾）。
2. `renderChildren()`：子 MC 自行进帧。
3. `findBodyArea()` / `findHitArea()`：按当前帧缓存盒。
4. `_hurtFlyState!=0` → `renderHurtFly()`。
5. `_curFrameCount++`。
6. `_goFrameDelay.delay-- <=0`：有 `call` 则调，否则 `goFrame(name, isPlay, playFrame)`；然后清空 delay。

### `renderChildren`（L177–213）私有

扫 `_mc` 子级 MovieClip。跳过名字 `AImain`、`bdmn`、含 `atm`（这些由盒缓存管，不播动画）。`totalFrames>=2` 且当前帧标签不是 `"stop"`：到末帧回 1，否则 `nextFrame`。标签 `"stop"` 停住。特效/披风等循环靠这个。

### `goFrame`（L215–241）

`param1` 帧标签，`param2` 是否播放（默认 true），`param3` 播多少帧（0=一直播直到下次 goFrame），`param4` 延迟对象。

重置 count；按 param2 设 `_renderMainAnimate`/`_renderMainAnimateFrame`。`param4` 需有 `name` 或 `call` 且 `delay>0` 才收下，缺省 `isPlay=true`、`playFrame=0`。然后 `_mc.gotoAndStop(param1)`（**Stop** 不是 Play，播放靠每 tick `nextFrame`），立刻 `renderChildren()` 一拍对齐子件。

### `stopRenderMainAnimate` / `resumeRenderMainAnimate`（L243–251）

只拨 `_renderMainAnimate`。`McCtrler.stop()` 用 stop。resume 本包少见。

### `checkFrame`（L253–266）

已记入 `_undefinedFrames` → false。`MCUtils.hasFrameLabel` 真则 true；否则 push 进表并 `trace("未找到帧："+name)` 返回 false。`setAttack("砍1")` 等在角色没这标签时静默禁招。`hasWankai` 走这条。

### `getCurrentHitSprite`（L268–283）

当前子级里名字含 `atm` 的 DisplayObject 列表。本包未见调用（? 调试/插件）。

### `getCurrentBodyArea`（L285–293）

`_bodyAreaCache.getAreaByFrame(currentFrame).area`，没有则 null。`FighterCtrler.getBodyArea` 再转世界。

### `getCurrentHitArea`（L295–298）

当前帧的 hit 数组（元素 `{area, hitVO, name}`）或 null。`FighterCtrler.getCurrentHits` 遍历写 `HitVO.currentArea`。

### `getCheckHitRect`（L300–315）

按子件名取 display；cache 命中返回 `area`；否则 `getBounds(_fighterDisplay)` 写入 cache。给 `hitTargetChecker` 这类「打中检测盒」（不是 atm 攻击盒）。

### `findBodyArea`（L317–344）私有

cache 已 `areaFrameDefined` 或 `getAreaByFrame != null` 则 return（null 也会被 defined 记下来）。找子件 `"bdmn"`：按 display 缓存，没有则 `getBounds(fighterDisplay)` 再 `cacheAreaByDisplay`。最后 `cacheAreaByFrame(frame, loc1)`——**没 bdmn 时 loc1 仍可能 null**，等于这帧无身体盒（无敌帧常见）。

### `findHitArea`（L346–394）私有

同样的帧缓存闸。扫所有子级，`hitModel.getHitVOByDisplayName(name)` 有 VO 才当攻击盒。display 级 cache 没有则 `getBounds` + `cacheAreaByDisplay(..., {hitVO})`。数组空则存 null。一帧多个 atm 可多 HitVO。

### `playHurtFly`（L396–430）

`param1`=vx，`param2`=vy，`param3` 默认 true=先播「被打」再 delay 1 切「击飞」；false 直接「击飞」停住（`McCtrler.hurtFly` 手动路径）。

vx≠0 则 `direct = vx>0 ? -1 : 1`（脸朝速度反方向，被打飞向右则面朝左）。`vy>5`：重击落地，`_hurtFlyFrame=0`、`_isHeavyDownAttack=true`；否则飞 15 帧才允许落地切帧。`setVelocity(vx,vy)` + `setDamping(0, 0.5)`。state=1，记录 `_hurtYMin=fighter.y` 和初速。

### `playHurtDown`（L432–441）

`goFrame("击飞_弹", false)`，2 帧后 `playHurtDown2`。震屏 `(0,2)` + `hitFloor(1)`，`setDamping(2)`（只设 x 阻尼，y 默认 0）。`FighterMain.die` 与 McCtrler 死亡落地走这里。

### `playHurtDown2`（L443–451）私有

切 `"击飞_倒"`，倒地倒数 15，state=4，`McCtrler.touchFloor()`，`actionState=23`，派 `"HURT_DOWN"`（`FighterEventCtrl` 清连击）。

### `stopHurtFly`（L453–456）

state=0，击飞机停。倒地受身 `doHurtDownJump` 先停再 `doAction("起身")`。

### `renderHurtFly`（L458–560）私有

开头两次把 `_loc1_/_loc2_` 赋 `NaN`（无意义）。`switch(state-1)`：

**case 0（态 1 飞行）**：`--_hurtFlyFrame<=0` 且 **不在空中** → `"击飞_落"`、state=2。飞行中跟踪最低 y 到 `_hurtYMin`。重击 `_hurtFlyFrame` 初始 0，一落地就进态 2。

**case 1（态 2 落地）**：要 `_curFrameCount>=2` 才继续（给「击飞_落」两帧）。

- 重击：直接 `"击飞_倒"`，state=23，派 `HURT_DOWN`，阻尼 4，state=4，倒地倒数 30。震幅 = `clamp((y-hurtYMin)/25 * (1+hity*0.1), 2, 5)`，`hitFloor(2)`。
- 普通：`"击飞_弹"`，`setVecY(-clamp((y-min)/25, 3, 8))` 弹起，state=3，`actionState=24`。震幅另钳到 `[0.5,3]`（与弹速用同一个 `_loc2_` 先当弹速再当震幅，震幅上限 3）。`hitFloor(0)`。

**case 2（态 3 弹起）**：count<2 return；仍在空中 return；落地 → `"击飞_倒"`，阻尼 2，倒地 15，state=4，轻震 + `hitFloor(1)`，state=23，派 `HURT_DOWN`。

**case 3（态 4 倒地）**：`!isAlive` → state=0、`actionState=30`（死亡躺着，不再起身）。否则 `--_hurtDownFrame<=0` → `"击飞_起"` **播放**，state=0。起身动画播完靠时间轴 `idle()`。

### `getHitRange`（L562–570）

首次 `initHitRange`。返回 `_hitRangeObj[param1]`，没有则 undefined。`FighterCtrler` 再转世界。

### `initHitRange`（L572–588）私有

取子件 `"AImain"` 当 MovieClip，`gotoAndStop(2)`（样板帧），对 `FighterHitRange.getALL()` 每个名字 `getChildByName` → `getBounds(fighterDisplay)` 存表。然后 AImain 回帧 1 并 `visible=false`。无 AImain 会 NPE（? 角色 SWF 约定必有）。
