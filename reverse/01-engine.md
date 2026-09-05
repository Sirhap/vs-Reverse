# 01 引擎 — net.play5d.game.bvn 与 net.play5d.kyo

权威源：`decompiled/main/scripts/net/play5d/`（181 个 `game.bvn` + 23 个 `kyo` = 204；`SUMMARY.md` 记 `net.play5d` 181 是只计 `game/bvn` 目录）。
文档类 `bleachvsnaruto`（`bleachvsnaruto_2.as`）在壳把控制权交给应用后创建 `MainGame`。

总索引：[`../BVN-FULL-REVERSE.md`](../BVN-FULL-REVERSE.md)。壳：[`02-greenhd.md`](02-greenhd.md)。

## 启动到开打（引擎侧）

```
bleachvsnaruto.initlize
  GameInterface.instance = GameInterfaceManager
  Ctrler4399.init()
  AssetManager.setAssetLoader(ZipAssetLoader)
  ZipCtrler.init() 解析嵌入 assets_zip
  MainGame.initlize
    ResUtils.initalize  → 8 个 UI SWF Class
    GameRender / GameInputer / GameData.loadData / config.applyConfig
    KyoStageCtrl.goStage(GameLoadingState)
      loadPreLoad(preload.xml) → loadConfig:
        fighter.xml → assist.xml → select.xml → map.xml → mission.xml
    goLogo → goMenu → goSelect → LoadingState.load SWF → goGame
      GameCtrl.startGame → GameState.initFight
```

`MainGame.VERSION = "V3.3-MOD"`，`VERSION_DATE = "2019.3.32"`（反编译现场值；`decompiled/SUMMARY.md` 曾记 `V3.3`，以当前 `.as` 为准）。

## net.play5d.game.bvn

### `net.play5d.game.bvn`（4 个文件）

#### `Debugger`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/Debugger.as`
- 行数：115
- 职责：调试开关 DRAW_AREA/SAFE_MODE/HIDE_MAP 等，log/errorMsg/showFPS。
- 常量：`DRAW_AREA`, `SAFE_MODE`, `DEBUG_ENABLED`, `HIDE_MAP`, `HIDE_HITEFFECT`
- 关键方法：`log`, `errorMsg`, `initDebug`, `addChild`, `showFPS`, `runScriect`

#### `GameConfig`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/GameConfig.as`
- 行数：160
- 职责：物理与帧率常量：重力 G=12、GAME_SIZE=800x600、FPS_GAME 默认 60、FPS_UI/ANIMATE=30。MAP_LOGO_STATE 控制地图 logo4399。
- 常量：`G`, `G_ADD`, `G_ON_FLOOR`, `FPS_UI`, `FPS_ANIMATE`, `BULLET_HOLD_FRAME_PLUS`, `JUMP_DELAY_FRAME`, `JUMP_DELAY_FRAME_AIR`, `JUMP_DAMPING`, `HURT_JUMP_FRAME`, `HURT_GAP_FRAME`, `BREAK_DEF_GAP_FRAME`, `BREAK_DEF_DOWN_GAP_FRAME`, `BREAK_DEF_HOLD_FRAME`, `DEFENSE_GAP_FRAME`, `DEFENSE_DAMPING_X`, `DEFENSE_GAP_FRAME_DOWN`, `DEFENSE_LOSE_HP_RATE`, `DEFENSE_HOLD_FRAME_MIN`, `DEFENSE_HOLD_FRAME_MAX`, `DEFENSE_HOLD_FRAME_DOWN`, `HURT_DAMPING_X`, `HURT_DAMPING_Y`, `HURT_Y_ADD_INAIR`, `HURT_Y_ADD`, `STEEL_HURT_GAP_FRAME`, `STEEL_HURT_DOWN_GAP_FRAME`, `STEEL_HURT_HP_PERCENT`, `STEEL_SUPER_HURT_HP_PERCENT`, `HURT_FLY_DAMPING_X`
- 关键方法：`setGameFps`, `get SPEED_PLUS_DEFAULT`

#### `GameQuailty`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/GameQuailty.as`
- 行数：23
- 职责：画质枚举 LOW/MEDIUM/HIGH/HIGHER/BEST（类名拼写 Quailty 原样保留）。
- 常量：`LOW`, `MEDIUM`, `HIGH`, `HIGHER`, `BEST`

#### `MainGame`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/MainGame.as`
- 行数：223
- 职责：游戏外观门面。initlize 启动渲染/输入/存档/舞台控制器；goLogo/goMenu/goSelect/goGame 等切状态。VERSION 当前为 V3.3-MOD。
- 常量：`VERSION`, `VERSION_DATE`
- 关键方法：`get root`, `get stage`, `initlize`, `getFPS`, `setFPS`, `goLogo`, `goMenu`, `goHowToPlay`, `goSelect`, `loadGame`, `goGame`, `goOption`, `goContinue`, `goGameOver`, `goWinner`, `goCredits`, `moreGames`, `goCongratulations`, `submitScore`, `showRank`

### `net.play5d.game.bvn.ctrl`（8 个文件）

#### `AssetLoader`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/AssetLoader.as`
- 行数：168
- 职责：默认 URL 资源加载器（loadXML/SWF/Bitmap/Sound）。正式包被 ZipAssetLoader 替换。
- 关键方法：`loadXML`, `loadSwf`, `loadBitmap`, `loadSound`, `dispose`, `needPreLoad`, `loadPreLoad`

#### `AssetManager`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/AssetManager.as`
- 行数：440
- 职责：资源中枢单例。loadBasic 拉 effect.swf/字体/预载音效；getFighterFace* 缓存脸图；setAssetLoader 注入 ZIP 实现。
- 关键方法：`get I`, `getFont`, `setAssetLoader`, `loadBasic`, `getEffect`, `getSound`, `getFighterFace`, `getFighterFaceBig`, `getFighterFaceBar`, `getFighterFaceWin`, `getMapPic`, `loadXML`, `loadSWF`, `loadSound`, `loadBitmap`, `disposeAsset`, `needPreLoad`, `loadPreLoad`

#### `EffectCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/EffectCtrl.as`
- 行数：1019
- 职责：全局特效：受击/防御/必杀黑屏/震动/残影/慢动作/鬼步/替换术。
- 关键方法：`get I`, `destory`, `initlize`, `render`, `doHitEffect`, `doDefenseEffect`, `doSteelHitEffect`, `doEffectById`, `assisterEffect`, `doEffectVO`, `doSpecialEffect`, `doBuffEffect`, `freeze`, `shine`, `startShake`, `endShake`, `shake`, `startShadow`, `endShadow`, `bisha`, `endBisha`, `wanKai`, `endWanKai`, `jumpEffect`, `jumpAirEffect`, `touchFloorEffect`, `hitFloorEffect`, `slowDown`

#### `GameLoader`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameLoader.as`
- 行数：184
- 职责：按 id 从 Model 取 VO，loadSWF 后包装为 FighterMain/Assister/MapMain。
- 关键方法：`loadFighter`, `loadAssister`, `loadMap`, `dispose`

#### `GameLogic`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameLogic.as`
- 行数：409
- 职责：出界、连击计数、死亡判定、加分、闯关攻击倍率、可选角色过滤。
- 关键方法：`initGameLogic`, `clear`, `isInAir`, `isTouchBottomFloor`, `isOutRange`, `addHits`, `clearHits`, `getHitsObj`, `getHitsObjByTargetId`, `clearHitsByTargetId`, `checkFighterDie`, `hitTarget`, `addScoreByHitTarget`, `addScoreByKO`, `addScoreByPassMission`, `loseScoreByContinue`, `fixGameSpritePosition`, `resetFighterHP`, `setMessionEnemyAttack`, `canSelectFighter`, `canSelectAssist`, `setGameMode`

#### `GameRender`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameRender.as`
- 行数：83
- 职责：Stage ENTER_FRAME 分发；add/remove 回调。
- 关键方法：`initlize`, `add`, `remove`

#### `SoundCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/SoundCtrl.as`
- 行数：265
- 职责：BGM/音效音量、战斗 BGM 加载、选人确认音。
- 关键方法：`get I`, `setSoundVolumn`, `setBgmVolumn`, `playAssetSound`, `playEffectSound`, `playAssetSoundRandom`, `playSwcSound`, `BGM`, `pauseBGM`, `resumeBGM`, `loadFightBGM`, `playFightBGM`, `unloadFightBGM`, `sndSelect`, `sndConfrim`

#### `StateCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/StateCtrl.as`
- 行数：150
- 职责：转场：transIn/transOut/quickTrans。
- 关键方法：`get I`, `transIn`, `transOut`, `quickTrans`, `clearTrans`

### `net.play5d.game.bvn.ctrl.game_ctrls`（6 个文件）

#### `FighterEventCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/FighterEventCtrl.as`
- 行数：188
- 职责：把 FighterEvent 转成 GameCtrl 行为（子弹、辅助、攻击者）。
- 关键方法：`initlize`, `destory`, `getAttacker`

#### `GameCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameCtrl.as`
- 行数：757
- 职责：对局主控：startGame/startNextRound/pause/gameEnd/slow、精灵增删、敌队查询。
- 关键方法：`get I`, `getAttacker`, `setRenderHit`, `initlize`, `destory`, `getEnemyTeam`, `addGameSprite`, `removeGameSprite`, `startGame`, `doStartGame`, `startNextRound`, `fightFinish`, `pause`, `resume`, `gameEnd`, `doGameEnd`, `drawGame`, `slow`, `slowResume`

#### `GameEndCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameEndCtrl.as`
- 行数：162
- 职责：回合结束演出与 skip。
- 关键方法：`initlize`, `drawGame`, `destory`, `render`, `skip`

#### `GameMainLogicCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameMainLogicCtrler.as`
- 行数：390
- 职责：每帧物理/碰撞/动画节奏，setSpeedPlus。
- 关键方法：`initlize`, `setSpeedPlus`, `destory`, `render`, `renderAnimate`, `renderPause`

#### `GameStartCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameStartCtrl.as`
- 行数：206
- 职责：开场 1v1 / 下一回合倒计时。
- 关键方法：`destory`, `render`, `start1v1`, `startNextRound`, `skip`

#### `TrainingCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/TrainingCtrler.as`
- 行数：109
- 职责：练习模式：锁血、重置。
- 关键方法：`initlize`, `destory`, `render`

### `net.play5d.game.bvn.data`（24 个文件）

#### `AssisterModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/AssisterModel.as`
- 行数：64
- 职责：assist.xml → 辅助 VO 表。
- 关键方法：`get I`, `getAllAssisters`, `getAssisters`, `getAssister`, `initByXML`

#### `BitmapDataCacheVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/BitmapDataCacheVO.as`
- 行数：21
- 职责：位图缓存条目。

#### `ConfigVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/ConfigVO.as`
- 行数：184
- 职责：画质/AI/键位/音量；toSaveObj/readSaveObj/applyConfig。
- 关键方法：`setDefaultConfig`, `toSaveObj`, `readSaveObj`, `getValueByKey`, `setValueByKey`, `applyConfig`

#### `EffectModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/EffectModel.as`
- 行数：411
- 职责：effect.swf 里按 id/HitType 取 EffectVO。
- 关键方法：`get I`, `initlize`, `getEffect`, `getHitEffect`, `getDefenseEffect`

#### `EffectVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/EffectVO.as`
- 行数：116
- 职责：特效描述与 bitmap 缓存。
- 关键方法：`clone`, `cacheBitmapData`

#### `FighterModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/FighterModel.as`
- 行数：64
- 职责：fighter.xml → 可玩 VO 表。
- 关键方法：`get I`, `getAllFighters`, `getFighters`, `getFighter`, `initByXML`

#### `FighterVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/FighterVO.as`
- 行数：86
- 职责：id/name/comicType/fileUrl/startFrame/脸图/bgm/台词。initByXML。
- 关键方法：`initByXML`, `getRandSay`, `clone`

#### `GameData`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/GameData.as`
- 行数：151
- 职责：单例运行时数据。loadConfig 顺序拉 fighter→assist→select→map→mission XML；saveData id=bvn3.01。
- 关键方法：`get I`, `loadConfig`, `saveData`, `loadData`, `loadSelect`, `setSelectData`

#### `GameMode`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/GameMode.as`
- 行数：67
- 职责：TEAM/SINGLE × ACRADE/VS_PEOPLE/VS_CPU、SURVIVOR、TRAINING。
- 常量：`TEAM_ACRADE`, `TEAM_VS_PEOPLE`, `TEAM_VS_CPU`, `SINGLE_ACRADE`, `SINGLE_VS_PEOPLE`, `SINGLE_VS_CPU`, `SURVIVOR`, `TRAINING`
- 关键方法：`getTeams`, `isTeamMode`, `isSingleMode`, `isVsPeople`, `isVsCPU`, `isAcrade`

#### `GameRunDataVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/GameRunDataVO.as`
- 行数：106
- 职责：回合、胜场、是否允许掉血。
- 关键方法：`getWins`, `reset`, `clear`, `nextRound`, `setAllowLoseHP`

#### `GameRunFighterGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/GameRunFighterGroup.as`
- 行数：103
- 职责：一队当前/候补角色。
- 关键方法：`getFighterDatas`, `getNextFighter`, `destoryFighters`, `removeCurrentFighter`

#### `HitType`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/HitType.as`
- 行数：42
- 职责：KAN/DA/MAGIC/FIRE/ICE/ELECTRIC/STONE/CATCH 及 HEAVY 变体。
- 常量：`KAN`, `KAN_HEAVY`, `DA`, `DA_HEAVY`, `MAGIC`, `MAGIC_HEAVY`, `FIRE`, `ICE`, `ELECTRIC`, `STONE`, `CATCH`
- 关键方法：`isHeavy`

#### `KeyConfigVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/KeyConfigVO.as`
- 行数：79
- 职责：P1/P2 键位序列化。
- 关键方法：`setKeys`, `toSaveObj`, `readSaveObj`, `clone`

#### `MapModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/MapModel.as`
- 行数：52
- 职责：map.xml → MapVO。
- 关键方法：`get I`, `getMap`, `getAllMaps`, `initByXML`

#### `MapVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/MapVO.as`
- 行数：32
- 职责：地图 id/name/file/img/bgm。
- 关键方法：`initByXML`

#### `MessionModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionModel.as`
- 行数：115
- 职责：mission.xml（根标签 mession）。闯关进度。
- 关键方法：`get I`, `initByXML`, `getMession`, `getCurrentMessionStage`, `initMession`, `reset`, `messionComplete`, `missionAllComplete`

#### `MessionStageVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionStageVO.as`
- 行数：50
- 职责：一关的 fighter/assister/map 与倍率。
- 关键方法：`getFighters`

#### `MessionVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/MessionVO.as`
- 行数：44
- 职责：一套 design（comicType+gameMode）。
- 关键方法：`initByXML`

#### `SelectCharListConfigVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectCharListConfigVO.as`
- 行数：19
- 职责：选人网格配置容器。

#### `SelectCharListItemVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectCharListItemVO.as`
- 行数：27
- 职责：格子 id + offset。

#### `SelectStageConfigVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectStageConfigVO.as`
- 行数：115
- 职责：select.xml 的 layout/char_list/assist_list。
- 关键方法：`setByXML`

#### `SelectVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/SelectVO.as`
- 行数：54
- 职责：P1/P2 已选角色与辅助。
- 关键方法：`getSelectFighters`, `isSelected`, `toString`

#### `TeamMap`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/TeamMap.as`
- 行数：64
- 职责：teamId → TeamVO。
- 关键方法：`clear`, `getTeam`, `getOtherTeams`, `add`, `remove`

#### `TeamVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/data/TeamVO.as`
- 行数：66
- 职责：队伍成员与存活查询。
- 关键方法：`getAliveChildren`, `addChild`, `removeChild`

### `net.play5d.game.bvn.events`（2 个文件）

#### `GameEvent`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/events/GameEvent.as`
- 行数：62
- 职责：全局事件 SCORE_UPDATE/GAME_OVER/GAME_PASS_ALL/SELECT_FIGHTER_* 等。
- 常量：`SCORE_UPDATE`, `PAUSE_GAME`, `RESUME_GAME`, `LOAD_GAME_COMPLETE`, `GAME_START`, `ROUND_START`, `ROUND_END`, `GAME_END`, `GAME_OVER`, `GAME_PASS_ALL`, `SELECT_FIGHTER_STEP`, `SELECT_FIGHTER_FINISH`, `SELECT_FIGHTER_INDEX`
- 关键方法：`dispatchEvent`, `addEventListener`, `removeEventListener`

#### `SetBtnEvent`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/events/SetBtnEvent.as`
- 行数：38
- 职责：设置按钮 SELECT/OPTION_CHANGE/APPLY_SET/CANCEL_SET。
- 常量：`SELECT`, `OPTION_CHANGE`, `APPLY_SET`, `CANCEL_SET`
- 关键方法：`newEvent`

### `net.play5d.game.bvn.fighter`（9 个文件）

#### `Assister`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/Assister.as`
- 行数：359
- 职责：辅助实体：goFight、hit、render，忽略 bdmn/atm* 子剪辑自动循环。
- 关键方法：`get name`, `getOwner`, `setOwner`, `getCtrler`, `goFight`, `destory`, `stop`, `gotoAndPlay`, `gotoAndStop`, `getTargets`, `removeSelf`, `render`, `renderAnimate`, `getHitCheckRect`, `getCheckHitRect`, `hit`, `getCurrentHits`, `getCurrentTarget`

#### `Bullet`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/Bullet.as`
- 行数：550
- 职责：飞行道具，实现 IGameSprite。
- 关键方法：`get x`, `set x`, `get y`, `set y`, `get team`, `set team`, `isAttacking`, `setSpeedRate`, `setVolume`, `get direct`, `set direct`, `setHitVO`, `destory`, `isDestoryed`, `renderAnimate`, `render`, `getDisplay`, `hit`, `beHit`, `getCurrentHits`, `getArea`, `getBodyArea`, `allowCrossMapXY`, `allowCrossMapBottom`, `getIsTouchSide`, `setIsTouchSide`

#### `FighterAction`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterAction.as`
- 行数：178
- 职责：当前输入动作与 CD。
- 关键方法：`clear`, `clearState`, `clearAction`, `render`, `setCD`, `CDOK`

#### `FighterActionState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterActionState.as`
- 行数：76
- 职责：状态机枚举 NORNAL/ATTACK_ING/BISHA_ING/HURT_* /WAN_KAI_ING 等。
- 常量：`NORNAL`, `FREEZE`, `ATTACK_ING`, `SKILL_ING`, `BISHA_ING`, `BISHA_SUPER_ING`, `JUMP_ING`, `DASH_ING`, `HURT_ACT_ING`, `DEFENCE_ING`, `HURT_ING`, `HURT_FLYING`, `HURT_DOWN`, `HURT_DOWN_TAN`, `DEAD`, `WAN_KAI_ING`, `KAI_CHANG`, `WIN`, `LOSE`
- 关键方法：`isAllowWinState`, `isBishaIng`, `isAttacking`, `allowGhostStep`, `isHurting`

#### `FighterAttacker`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterAttacker.as`
- 行数：551
- 职责：从角色身上分裂出的攻击体。
- 关键方法：`getOwner`, `get name`, `getCtrler`, `destory`, `setOwner`, `init`, `renderAnimate`, `render`, `stopFollowTarget`, `moveToTarget`, `stop`, `gotoAndPlay`, `gotoAndStop`, `getTargets`, `removeSelf`, `getCurrentHits`, `getHitCheckRect`, `getCheckHitRect`, `hit`

#### `FighterDefenseType`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterDefenseType.as`
- 行数：17
- 职责：SWOARD/HAND 防御类型。
- 常量：`SWOARD`, `HAND`

#### `FighterHitRange`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterHitRange.as`
- 行数：42
- 职责：各招式距离标签 JUMP_ATTACK/SKILL1/BISHA_AIR 等。
- 常量：`JUMP_ATTACK`, `JUMP_SKILL`, `ATTACK`, `SKILL1`, `SKILL2`, `ZHAO1`, `ZHAO2`, `ZHAO3`, `BISHA`, `BISHA_AIR`, `BISHA_UP`, `BISHA_SUPER`
- 关键方法：`getALL`

#### `FighterMC`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterMC.as`
- 行数：592
- 职责：角色动作 MC 包装：goFrame、身体/攻击判定缓存、bdmn 身体盒、受伤击飞。
- 关键方法：`get currentFrameName`, `getCurrentFrame`, `getCurrentFrameCount`, `get x`, `set x`, `get y`, `set y`, `initlize`, `destory`, `getChildByName`, `renderAnimate`, `goFrame`, `stopRenderMainAnimate`, `resumeRenderMainAnimate`, `checkFrame`, `getCurrentHitSprite`, `getCurrentBodyArea`, `getCurrentHitArea`, `getCheckHitRect`, `playHurtFly`, `playHurtDown`, `stopHurtFly`, `getHitRange`

#### `FighterMain`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterMain.as`
- 行数：629
- 职责：可玩角色主体。initlize 注入 ctrler 并 gotoAndStop(startFrame+1)；hp/气/能量/换色/死亡。
- 关键方法：`get colorTransform`, `set colorTransform`, `changeColor`, `resumeColor`, `destory`, `set attackRate`, `currentHurtDamage`, `getLastHurtHitVO`, `hurtBreakHit`, `clearHurtHits`, `getCtrler`, `getBuffCtrl`, `getCurrentTarget`, `getTargets`, `getMC`, `setActionCtrl`, `initlize`, `renderAnimate`, `render`, `jump`, `getCurrentHits`, `getBodyArea`, `hit`, `beHit`, `hasEnergy`, `useEnergy`, `useQi`, `addQi`

### `net.play5d.game.bvn.fighter.ctrler`（10 个文件）

#### `AssisiterCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/AssisiterCtrler.as`
- 行数：356
- 职责：辅助控制器（类名少一个 t）。defineAction、bisha 特效、endAct、fire。
- 关键方法：`get effect`, `destory`, `getTarget`, `getOwner`, `getSelf`, `setApplyG`, `finish`, `defineAction`, `get owner_mc_ctrler`, `get owner_fighter_ctrler`, `initAssister`, `endAct`, `render`, `moveToTarget`, `setDirectToTarget`, `move`, `damping`, `stop`, `gotoAndPlay`, `gotoAndStop`, `setTouchFloor`, `justHit`, `setHitTarget`, `removeSelf`, `fire`, `addAttacker`, `checkHitOwner`

#### `FighterAICtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterAICtrl.as`
- 行数：211
- 职责：实现 IFighterActionCtrl 的 AI 输入。
- 关键方法：`initlize`, `destory`, `enabled`, `render`, `renderAnimate`, `moveLEFT`, `moveRIGHT`, `defense`, `attack`, `jump`, `jumpQuick`, `jumpDown`, `dash`, `dashJump`, `skill1`, `skill2`, `zhao1`, `zhao2`, `zhao3`, `catch1`, `catch2`, `bisha`, `bishaUP`, `bishaSUPER`, `assist`, `specailSkill`, `attackAIR`, `skillAIR`

#### `FighterAttackerCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterAttackerCtrler.as`
- 行数：226
- 职责：攻击体控制器。
- 关键方法：`get owner_mc_ctrler`, `get owner_fighter_ctrler`, `destory`, `endAct`, `render`, `stopFollowTarget`, `moveToTarget`, `move`, `damping`, `stop`, `gotoAndPlay`, `gotoAndStop`, `setTouchFloor`, `justHit`, `setHitTarget`, `setCrossMap`, `removeSelf`, `fire`

#### `FighterBuffCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterBuffCtrler.as`
- 行数：119
- 职责：攻速防 buff：speedUp/attackUp/defenseUp 及 Down。
- 关键方法：`destory`, `speedUp`, `attackUp`, `defenseUp`, `speedDown`, `attackDown`, `defenseDown`, `render`

#### `FighterCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterCtrler.as`
- 行数：546
- 职责：角色总控。defineAction/defineBishaFace/defineHurtSound、hp/energy/qi、initMc、doWanKai。
- 关键方法：`destory`, `getEffectCtrl`, `getVoiceCtrl`, `get hp`, `set hp`, `get energy`, `set energy`, `get speed`, `set speed`, `get jumpPower`, `set jumpPower`, `get heavy`, `set heavy`, `get defenseType`, `set defenseType`, `addHp`, `addHpPercent`, `loseHp`, `loseHpPercent`, `get self`, `get target`, `getTargetSP`, `getTargetState`, `setTargetVelocity`, `setTargetDamping`, `targetInRange`, `justHit`, `getMcCtrl`

#### `FighterEffectCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterEffectCtrl.as`
- 行数：226
- 职责：角色侧特效转发到 EffectCtrl（bisha/wanKai/ghostStep/glow）。
- 关键方法：`destory`, `setBishaFace`, `shine`, `shake`, `startShake`, `endShake`, `shadow`, `endShadow`, `dash`, `bisha`, `endBisha`, `startWanKai`, `endWanKai`, `walk`, `jump`, `jumpAir`, `touchFloor`, `hitFloor`, `slowDown`, `energyExplode`, `replaceSkill`, `ghostStep`, `endGhostStep`, `startGlow`, `endGlow`

#### `FighterKeyCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterKeyCtrl.as`
- 行数：211
- 职责：键盘实现的 IFighterActionCtrl。
- 关键方法：`initlize`, `render`, `renderAnimate`, `destory`, `enabled`, `moveLEFT`, `moveRIGHT`, `defense`, `attack`, `jump`, `jumpQuick`, `jumpDown`, `dash`, `dashJump`, `skill1`, `skill2`, `zhao1`, `zhao2`, `zhao3`, `catch1`, `catch2`, `bisha`, `bishaUP`, `bishaSUPER`, `assist`, `specailSkill`, `attackAIR`, `skillAIR`

#### `FighterMcCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterMcCtrler.as`
- 行数：2235
- 职责：最大类（2235 行）。把输入映射到 idle/dash/setAttack/setBisha/setWankai 等 MC 指令。
- 关键方法：`destory`, `getAction`, `getFighterMc`, `getCurAction`, `setActionCtrler`, `setMc`, `setSteelBody`, `addQi`, `idle`, `loop`, `stop`, `dash`, `dashStop`, `setAllAct`, `setAirAllAct`, `setAirMove`, `setMove`, `setMoveLeft`, `setMoveRight`, `setDefense`, `setJump`, `setJumpQuick`, `setJumpDown`, `setDash`, `setAttack`, `setSkill1`, `setSkill2`, `setZhao1`

#### `FighterVoice`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterVoice.as`
- 行数：19
- 职责：HURT/HURT_FLY/DIE 语音槽。
- 常量：`HURT`, `HURT_FLY`, `DIE`

#### `FighterVoiceCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterVoiceCtrler.as`
- 行数：72
- 职责：setVoice/playVoice。
- 关键方法：`destory`, `setVoice`, `playVoice`

### `net.play5d.game.bvn.fighter.ctrler.ai`（2 个文件）

#### `FighterAILogic`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogic.as`
- 行数：583
- 职责：具体 AI 决策：updateActionAI/updateBisha。
- 关键方法：`render`, `updateActionAI`, `updateBisha`

#### `FighterAILogicBase`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogicBase.as`
- 行数：239
- 职责：距离、连招、break/hitdown 判定基类。
- 关键方法：`destory`, `addContOrder`, `updateConting`, `render`, `updateActionAI`, `getAIByFighterState`, `getAIResult`, `getTargetDistance`, `targetInDistance`, `targetInRange`, `mergeRateObject`, `isBreakAct`, `isHitDownAct`, `targetCanBeHit`

### `net.play5d.game.bvn.fighter.events`（2 个文件）

#### `FighterEvent`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/events/FighterEvent.as`
- 行数：36
- 职责：FIRE_BULLET/ADD_ATTACKER/HIT_TARGET/DIE/DO_ACTION。
- 常量：`FIRE_BULLET`, `ADD_ATTACKER`, `ADD_ASSISTER`, `HIT_TARGET`, `HURT_RESUME`, `HURT_DOWN`, `DIE`, `DO_ACTION`

#### `FighterEventDispatcher`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/events/FighterEventDispatcher.as`
- 行数：54
- 职责：角色事件总线。
- 关键方法：`hasEventListener`, `addEventListener`, `removeEventListener`, `removeAllListeners`, `dispatchEvent`

### `net.play5d.game.bvn.fighter.models`（2 个文件）

#### `FighterHitModel`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/models/FighterHitModel.as`
- 行数：80
- 职责：招式名 → HitVO。
- 关键方法：`destory`, `clear`, `getHitVO`, `getHitVOLike`, `getHitVOByDisplayName`, `addHitVO`, `setPowerRate`

#### `HitVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/models/HitVO.as`
- 行数：80
- 职责：伤害/必杀/抓取；clone/getDamage。
- 关键方法：`clone`, `isBisha`, `isCatch`, `getDamage`

### `net.play5d.game.bvn.fighter.utils`（1 个文件）

#### `McAreaCacher`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/utils/McAreaCacher.as`
- 行数：77
- 职责：按帧或 DisplayObject 缓存判定矩形。
- 关键方法：`destory`, `areaFrameDefined`, `getAreaByFrame`, `cacheAreaByFrame`, `getAreaByDisplay`, `cacheAreaByDisplay`

### `net.play5d.game.bvn.fighter.vos`（2 个文件）

#### `FighterBuffVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/vos/FighterBuffVO.as`
- 行数：46
- 职责：buff 持续。
- 关键方法：`setHold`, `render`

#### `MoveTargetParamVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/fighter/vos/MoveTargetParamVO.as`
- 行数：68
- 职责：吸引/位移目标参数。
- 关键方法：`setTarget`, `clear`

### `net.play5d.game.bvn.input`（4 个文件）

#### `GameInputType`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/input/GameInputType.as`
- 行数：19
- 职责：MENU/P1/P2。
- 常量：`MENU`, `P1`, `P2`

#### `GameInputer`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/input/GameInputer.as`
- 行数：338
- 职责：统一输入：方向/攻击/跳/冲/技能/万解；listenKeys。
- 关键方法：`initlize`, `initInput`, `setInput`, `updateConfig`, `focus`, `listenKeys`, `unListenKeys`, `render`, `anyKey`, `back`, `select`, `up`, `down`, `left`, `right`, `attack`, `jump`, `dash`, `skill`, `superSkill`, `special`, `wankai`, `clearInput`

#### `GameKeyInput`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/input/GameKeyInput.as`
- 行数：156
- 职责：键盘 IGameInput。
- 关键方法：`initlize`, `get enabled`, `set enabled`, `setConfig`, `focus`, `anyKey`, `back`, `select`, `up`, `down`, `left`, `right`, `attack`, `jump`, `dash`, `skill`, `superSkill`, `special`, `wankai`, `clear`

#### `IGameInput`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/input/IGameInput.as`
- 行数：50
- 职责：输入接口。
- 关键方法：`initlize`, `get/set enabled`, `setConfig`, `focus`, `anyKey`, `back`, `select`, `up`, `down`, `left`, `right`, `attack`, `jump`, `dash`, `skill`, `superSkill`, `special`, `wankai`, `clear`

### `net.play5d.game.bvn.interfaces`（9 个文件）

#### `BaseGameSprite`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/BaseGameSprite.as`
- 行数：621
- 职责：IGameSprite 默认实现：坐标、速度、朝向、队伍、体积。
- 关键方法：`get attackRate`, `set attackRate`, `get defenseRate`, `set defenseRate`, `get mc`, `get x`, `set x`, `get y`, `set y`, `get scale`, `set scale`, `get direct`, `set direct`, `get team`, `set team`, `updatePosition`, `setVolume`, `isDestoryed`, `destory`, `renderAnimate`, `render`, `getDisplay`, `move`, `setSpeedRate`, `getVelocity`, `getVecX`, `getVecY`, `setVecX`

#### `GameInterface`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/GameInterface.as`
- 行数：58
- 职责：平台适配入口。instance 指向 GameInterfaceManager；getDefaultMenu 主菜单树。
- 关键方法：`getDefaultMenu`

#### `IAssetLoader`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IAssetLoader.as`
- 行数：22
- 职责：XML/SWF/位图/声音加载接口。ZipAssetLoader / AssetLoader 实现。
- 关键方法：`loadXML`, `loadSwf`, `loadSound`, `loadBitmap`, `dispose`, `needPreLoad`, `loadPreLoad`

#### `IExtendConfig`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IExtendConfig.as`
- 行数：12
- 职责：扩展配置接口。
- 关键方法：`toSaveObj`, `readSaveObj`

#### `IFighterActionCtrl`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IFighterActionCtrl.as`
- 行数：78
- 职责：角色动作输入接口（键控/AI 共用）。FighterKeyCtrl 与 FighterAICtrl 实现。
- 关键方法：`initlize`, `render`, `renderAnimate`, `destory`, `enabled`, `moveLEFT`, `moveRIGHT`, `defense`, `attack`, `jump`, `jumpQuick`, `jumpDown`, `dash`, `dashJump`, `skill1`, `skill2`, `zhao1`, `zhao2`, `zhao3`, `catch1`, `catch2`, `bisha`, `bishaUP`, `bishaSUPER`, `assist`, `specailSkill`, `attackAIR`, `skillAIR`, `bishaAIR`, `waiKai`, `waiKaiW`, `waiKaiS`, `ghostStep`, `ghostJump`, `ghostJumpDown`

#### `IGameInterface`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IGameInterface.as`
- 行数：41
- 职责：平台钩子。GameInterfaceManager 实现。
- 关键方法：`initTitleUI`, `moreGames`, `showRank`, `submitScore`, `saveGame`, `loadGame`, `getGameInput`, `getGameMenu`, `getSettingMenu`, `updateInputConfig`, `getConfigExtend`, `afterBuildGame`, `applyConfig`, `getCreadits`

#### `IGameSprite`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IGameSprite.as`
- 行数：61
- 职责：战场精灵接口。BaseGameSprite / FighterMain / Bullet / Assister 实现。
- 关键方法：`destory`, `isDestoryed`, `render`, `renderAnimate`, `getDisplay`, `get/set direct`, `get/set x`, `get/set y`, `get/set team`, `hit`, `beHit`, `getArea`, `getBodyArea`, `getCurrentHits`, `allowCrossMapXY`, `allowCrossMapBottom`, `getIsTouchSide`, `setIsTouchSide`, `setSpeedRate`, `setVolume`

#### `IInnerSetUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IInnerSetUI.as`
- 行数：19
- 职责：内层设置页。
- 关键方法：`fadIn`, `fadOut`, `getUI`, `destory`

#### `ILoger`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/ILoger.as`
- 行数：10
- 职责：日志接口。
- 关键方法：`log`

### `net.play5d.game.bvn.map`（2 个文件）

#### `FloorVO`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/map/FloorVO.as`
- 行数：29
- 职责：地板线段 xFrom/xTo/y 与 hitTest。
- 关键方法：`toString`, `hitTest`

#### `MapMain`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/map/MapMain.as`
- 行数：363
- 职责：地图实例名解析：line_* / p1 p2 / map front front_fix bg / floor / logo4399。
- 关键方法：`destory`, `setVisible`, `initlize`, `getStageSize`, `getMapBottomDistance`, `getFloorHitTest`, `render`

### `net.play5d.game.bvn.state`（13 个文件）

#### `CongratulateState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/CongratulateState.as`
- 行数：135
- 职责：全通关祝贺。
- 关键方法：`get display`, `get innerUI`, `build`, `getBtnY`, `afterBuild`, `destory`

#### `CreditsState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/CreditsState.as`
- 行数：107
- 职责：制作组。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

#### `GameCamera`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/GameCamera.as`
- 行数：335
- 职责：战斗镜头缩放与跟随。
- 关键方法：`getScreenRect`, `updateNow`, `setStageBounds`, `setStageSizeFromDisplay`, `getZoom`, `setZoom`, `focus`, `move`, `moveCenter`, `render`, `setX`, `setY`

#### `GameLoadingState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/GameLoadingState.as`
- 行数：126
- 职责：启动加载：preload.xml → GameData.loadConfig。
- 关键方法：`get display`, `build`, `loadGame`, `afterBuild`, `destory`

#### `GameOverState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/GameOverState.as`
- 行数：314
- 职责：继续/游戏结束。
- 关键方法：`showContinue`, `showGameOver`, `get display`, `build`, `afterBuild`, `destory`

#### `GameState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/GameState.as`
- 行数：340
- 职责：战斗舞台：gameLayer、精灵列表、initFight、camera。
- 关键方法：`get gameLayer`, `getMap`, `setVisibleByClass`, `get display`, `getGameSpriteGlobalPosition`, `getGameSprites`, `addGameSprite`, `addGameSpriteAt`, `removeGameSprite`, `build`, `initFight`, `resetFight`, `cameraFocusOne`, `cameraResume`, `render`, `drawGameRect`, `clearDrawGameRect`, `afterBuild`, `destory`

#### `HowToPlayState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/HowToPlayState.as`
- 行数：105
- 职责：操作说明。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

#### `LoadingState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/LoadingState.as`
- 行数：399
- 职责：选人后加载角色/地图 SWF。
- 关键方法：`get display`, `p1SelectFinish`, `p2SelectFinish`, `selectFinish`, `getSort`, `setOrder`, `build`, `gotoGame`, `afterBuild`, `destory`

#### `LogoState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/LogoState.as`
- 行数：48
- 职责：Logo 页。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

#### `MenuState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/MenuState.as`
- 行数：144
- 职责：主菜单。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

#### `SelectFighterStage`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/SelectFighterStage.as`
- 行数：918
- 职责：选人（AUTO_FINISH）。
- 关键方法：`get display`, `build`, `get p1SelectFinish`, `get p2SelectFinish`, `setSelect`, `nextStep`, `goLoadGame`, `afterBuild`, `destory`

#### `SettingState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/SettingState.as`
- 行数：179
- 职责：设置。
- 关键方法：`get display`, `build`, `goInnerSetPage`, `afterBuild`, `destory`

#### `WinnerState`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/state/WinnerState.as`
- 行数：291
- 职责：胜利结算。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

### `net.play5d.game.bvn.ui`（16 个文件）

#### `GameUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/GameUI.as`
- 行数：225
- 职责：战斗 UI 门面：对话框、FightUI 生命周期。
- 关键方法：`showingDialog`, `confrim`, `alert`, `closeAlert`, `closeConfrim`, `getUI`, `getUIDisplay`, `initFight`, `render`, `fadIn`, `fadOut`, `destory`

#### `IGameUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/IGameUI.as`
- 行数：38
- 职责：战斗 UI 接口。FightUI 实现。
- 关键方法：`setVolume`, `destory`, `fadIn`, `fadOut`, `getUI`, `render`, `renderAnimate`, `showHits`, `hideHits`, `showStart`, `showEnd`, `clearStartAndEnd`, `pause`, `resume`

#### `KeyMapping`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/KeyMapping.as`
- 行数：73
- 职责：键位显示映射。
- 关键方法：`setKey`

#### `MenuBtn`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/MenuBtn.as`
- 行数：204
- 职责：主菜单按钮含子菜单。
- 关键方法：`addEventListener`, `removeAllEventListener`, `isHover`, `hover`, `normal`, `select`, `openChild`, `closeChild`, `dispose`, `childMode`

#### `MenuBtnGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/MenuBtnGroup.as`
- 行数：525
- 职责：菜单按钮组。
- 关键方法：`destory`, `fadIn`, `build`, `mouseHandler`, `touchHandler`, `selectBtn`

#### `MoveListSp`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/MoveListSp.as`
- 行数：73
- 职责：出招表（movelist_jpg）。
- 关键方法：`destory`, `show`, `hide`

#### `PauseDialog`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/PauseDialog.as`
- 行数：127
- 职责：暂停框。
- 关键方法：`destory`, `isShowing`, `show`, `hide`

#### `QuickTransUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/QuickTransUI.as`
- 行数：58
- 职责：快切转场。
- 关键方法：`fadInAndOut`, `fadIn`, `fadOut`

#### `SetBtn`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtn.as`
- 行数：203
- 职责：设置项按钮。
- 关键方法：`get label`, `destory`, `hover`, `hoverOut`, `select`, `setOption`, `getOption`, `nextOption`, `prevOption`, `setOptionByValue`

#### `SetBtnDialog`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnDialog.as`
- 行数：57
- 职责：设置对话框。
- 关键方法：`show`, `hide`

#### `SetBtnGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnGroup.as`
- 行数：590
- 职责：设置列表。
- 关键方法：`initScroll`, `initMainSet`, `initKeySet`, `setBtnData`, `destory`, `setArrowIndex`

#### `SetBtnLine`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetBtnLine.as`
- 行数：60
- 职责：设置分隔线。
- 关键方法：`show`, `hide`

#### `SetCtrlBtnUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetCtrlBtnUI.as`
- 行数：258
- 职责：键位设置控件。
- 关键方法：`destory`, `getUI`, `setKey`, `fadIn`, `fadOut`

#### `TransUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/TransUI.as`
- 行数：107
- 职责：淡入淡出转场。
- 关键方法：`destory`, `fadIn`, `fadOut`

#### `UIUtils`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/UIUtils.as`
- 行数：43
- 职责：文本格式化。
- 关键方法：`formatText`

#### `WinUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/WinUI.as`
- 行数：57
- 职责：胜利 UI。
- 关键方法：`get ui`, `show`

### `net.play5d.game.bvn.ui.dialog`（2 个文件）

#### `AlertUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/dialog/AlertUI.as`
- 行数：115
- 职责：提示框。
- 关键方法：`destory`, `setMsg`

#### `ConfrimUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/dialog/ConfrimUI.as`
- 行数：128
- 职责：确认框（类名少 i）。
- 关键方法：`destory`, `setMsg`

### `net.play5d.game.bvn.ui.fight`（11 个文件）

#### `EnergyBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/EnergyBar.as`
- 行数：260
- 职责：能量条。
- 关键方法：`get ui`, `destory`, `setFighter`, `setDirect`, `render`, `InsBar`, `render`, `normal`, `flash`, `overLoad`, `InsTxt`, `setDirect`, `setType`, `render`, `normal`, `flash`, `overLoad`

#### `InsBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/EnergyBar.as`
- 行数：260
- 职责：内部辅助类，见同文件主类。
- 关键方法：`EnergyBar`, `get ui`, `destory`, `setFighter`, `setDirect`, `render`, `render`, `normal`, `flash`, `overLoad`, `InsTxt`, `setDirect`, `setType`, `render`, `normal`, `flash`, `overLoad`

#### `InsTxt`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/EnergyBar.as`
- 行数：260
- 职责：内部辅助类，见同文件主类。
- 关键方法：`EnergyBar`, `get ui`, `destory`, `setFighter`, `setDirect`, `render`, `InsBar`, `render`, `normal`, `flash`, `overLoad`, `setDirect`, `setType`, `render`, `normal`, `flash`, `overLoad`

#### `FightBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightBar.as`
- 行数：371
- 职责：战斗顶栏（HP/胜场/分数）。
- 关键方法：`get ui`, `destory`, `initScore`, `setScore`, `showWin`, `setFighter`, `render`, `fadIn`, `fadOut`, `renderAnimate`

#### `FightFaceGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightFaceGroup.as`
- 行数：65
- 职责：头像组。
- 关键方法：`get ui`, `setFighter`, `setDirect`

#### `FightFaceUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightFaceUI.as`
- 行数：39
- 职责：单个头像。
- 关键方法：`setData`, `setDirect`

#### `FightQiBarMode`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightQiBarMode.as`
- 行数：19
- 职责：气条模式常量。
- 常量：`AUTO`, `TOP`, `BOTTOM`

#### `FightScoreUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightScoreUI.as`
- 行数：29
- 职责：分数。
- 关键方法：`setScore`

#### `FightTimeUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightTimeUI.as`
- 行数：58
- 职责：计时。
- 关键方法：`get timeUI`, `render`

#### `FightUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightUI.as`
- 行数：580
- 职责：战斗 HUD 总控（580 行）。
- 关键方法：`initlize`, `setVolume`, `showWins`, `destory`, `getUI`, `render`, `renderAnimate`, `fadIn`, `fadOut`, `showHits`, `hideHits`, `showStart`, `showEnd`, `clearStartAndEnd`, `pause`, `resume`

#### `FighterHpBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FighterHpBar.as`
- 行数：114
- 职责：血条。
- 关键方法：`get ui`, `destory`, `setFighter`, `render`

#### `HitsUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/HitsUI.as`
- 行数：78
- 职责：连击数。
- 关键方法：`destory`, `show`, `hide`

#### `QiBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/QiBar.as`
- 行数：389
- 职责：气条 + 辅助气 InsFzBar。
- 关键方法：`destory`, `setFighter`, `setDirect`, `render`, `renderAnimate`, `fadIn`, `fadOut`, `moveTo`, `moveResume`, `setPosAndScale`, `InsBar`, `get ui`, `getProcess`, `setProcess`, `setDirect`, `InsFzBar`, `get ui`, `getProcess`, `setProcess`

#### `InsBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/QiBar.as`
- 行数：389
- 职责：内部辅助类，见同文件主类。
- 关键方法：`QiBar`, `destory`, `setFighter`, `setDirect`, `render`, `renderAnimate`, `fadIn`, `fadOut`, `moveTo`, `moveResume`, `setPosAndScale`, `get ui`, `getProcess`, `setProcess`, `setDirect`, `InsFzBar`, `get ui`, `getProcess`, `setProcess`

#### `InsFzBar`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/QiBar.as`
- 行数：389
- 职责：内部辅助类，见同文件主类。
- 关键方法：`QiBar`, `destory`, `setFighter`, `setDirect`, `render`, `renderAnimate`, `fadIn`, `fadOut`, `moveTo`, `moveResume`, `setPosAndScale`, `InsBar`, `get ui`, `getProcess`, `setProcess`, `setDirect`, `get ui`, `getProcess`, `setProcess`

### `net.play5d.game.bvn.ui.select`（8 个文件）

#### `MapSelectUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/MapSelectUI.as`
- 行数：221
- 职责：地图选择。
- 关键方法：`addMouseEvents`, `destory`, `select`, `prev`, `next`

#### `SelectFighterItem`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectFighterItem.as`
- 行数：86
- 职责：选人格子。
- 关键方法：`addEventListener`, `removeAllEventListener`, `destory`

#### `SelectIndexUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectIndexUI.as`
- 行数：194
- 职责：出战顺序。
- 关键方法：`getP1Order`, `getP2Order`, `setP1Order`, `setP2Order`, `p1Finish`, `p2Finish`, `isFinish`, `destory`

#### `SelectIndexUIGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectIndexUIGroup.as`
- 行数：378
- 职责：出战顺序组。
- 关键方法：`getOrder`, `setFighterScale`, `setOrder`, `destory`, `build`, `initArrow`, `selectIndex`, `setKey`, `autoSelect`

#### `SelectUIFactory`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectUIFactory.as`
- 行数：33
- 职责：createSelecter。
- 关键方法：`createSelecter`

#### `SelectedFighterGroup`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectedFighterGroup.as`
- 行数：80
- 职责：已选角色展示组。
- 关键方法：`destory`, `addFighter`, `updateFighter`

#### `SelectedFighterUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectedFighterUI.as`
- 行数：170
- 职责：已选角色卡片。
- 关键方法：`mouseEnabled`, `destory`, `setFighter`, `getFighter`, `getFighterIndex`, `setFighterIndex`, `setAssister`

#### `SelecterItemUI`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelecterItemUI.as`
- 行数：226
- 职责：光标/选择器。
- 关键方法：`selectFinish`, `getCurrentSelectes`, `setCurrentSelect`, `isSelected`, `select`, `moveTo`, `destory`, `removeSelecter`, `removeGroup`

### `net.play5d.game.bvn.utils`（7 个文件）

#### `BitmapAssetLoader`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/BitmapAssetLoader.as`
- 行数：125
- 职责：队列加载位图。
- 关键方法：`getBitmap`, `loadQueue`

#### `EffectManager`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/EffectManager.as`
- 行数：135
- 职责：HitVO → 特效视图。
- 关键方法：`destory`, `getEffectVOByHitVO`, `getEffectView`, `getShine`

#### `GameLoger`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/GameLoger.as`
- 行数：34
- 职责：日志门面（类名 Loger）。
- 关键方法：`setLoger`, `log`

#### `GameUtils`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/GameUtils.as`
- 行数：51
- 职责：isInTop 等。
- 关键方法：`isInTop`

#### `KeyBoarder`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/KeyBoarder.as`
- 行数：82
- 职责：键盘监听与焦点。
- 关键方法：`initlize`, `focus`, `listen`, `unListen`

#### `MCUtils`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/MCUtils.as`
- 行数：58
- 职责：帧标签、色相。
- 关键方法：`hasFrameLabel`, `setHUE`

#### `ResUtils`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/ResUtils.as`
- 行数：232
- 职责：把 8 个嵌入 UI SWF Class 实例化；createDisplayObject(stg_title 等)。
- 关键方法：`get I`, `initalize`, `createDisplayObject`, `createBitmapData`, `getItemClass`, `InsSwf`, `getClass`

#### `InsSwf`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/utils/ResUtils.as`
- 行数：232
- 职责：ResUtils 内部已加载 SWF 包装。
- 关键方法：`ResUtils`, `get I`, `initalize`, `createDisplayObject`, `createBitmapData`, `getItemClass`, `getClass`

### `net.play5d.game.bvn.views.effects`（9 个文件）

#### `BishaFaceEffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BishaFaceEffectView.as`
- 行数：52
- 职责：必杀大脸。
- 关键方法：`setFace`, `fadIn`, `destory`

#### `BitmapFilterView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BitmapFilterView.as`
- 行数：224
- 职责：滤镜精灵。
- 关键方法：`setVolume`, `update`, `renderAnimate`, `render`, `isDestoryed`, `getDisplay`, `get direct`, `set direct`, `get x`, `set x`, `get y`, `set y`, `get team`, `set team`, `hit`, `beHit`, `getArea`, `getBodyArea`, `getCurrentHits`, `allowCrossMapXY`, `allowCrossMapBottom`, `getIsTouchSide`, `setIsTouchSide`, `setSpeedRate`, `destory`

#### `BlackBackView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BlackBackView.as`
- 行数：97
- 职责：必杀黑底。
- 关键方法：`destory`, `renderAnimate`, `fadIn`, `fadOut`, `showBishaFace`

#### `BuffEffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BuffEffectView.as`
- 行数：64
- 职责：buff 图标。
- 关键方法：`setBuff`, `setTarget`, `render`

#### `EffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/EffectView.as`
- 行数：243
- 职责：通用特效视图。
- 关键方法：`setTarget`, `setPos`, `start`, `destory`, `gotoAndPlay`, `render`, `renderAnimate`, `remove`, `addRemoveBack`

#### `ShadowEffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/ShadowEffectView.as`
- 行数：148
- 职责：残影。
- 关键方法：`destory`, `render`

#### `ShineEffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/ShineEffectView.as`
- 行数：148
- 职责：闪白。
- 关键方法：`destory`, `init`, `render`, `removeSelf`

#### `SpecialEffectView`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/SpecialEffectView.as`
- 行数：74
- 职责：特殊特效。
- 关键方法：`setTarget`, `start`, `render`

#### `SteelHitEffect`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/SteelHitEffect.as`
- 行数：49
- 职责：刚体受击。
- 关键方法：`setTarget`

### `net.play5d.game.bvn.web`（5 个文件）

#### `Ctrler4399`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/web/Ctrler4399.as`
- 行数：73
- 职责：GAME_OVER/GAME_PASS_ALL 插提交分按钮；showRank/submitScore 调 serviceHold。
- 关键方法：`init`, `showRank`, `submitScore`

#### `GameInterfaceManager`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/web/GameInterfaceManager.as`
- 行数：174
- 职责：IGameInterface 实现。localhost LocalConnection 监听 5d_message；存档 KyoSharedObject bvn3_save；菜单插入 RANK。
- 关键方法：`initTitleUI`, `moreGames`, `submitScore`, `showRank`, `saveGame`, `loadGame`, `getFighterCtrl`, `getGameMenu`, `getSettingMenu`, `getGameInput`, `getConfigExtend`, `afterBuildGame`, `updateInputConfig`, `applyConfig`, `getCreadits`

#### `SubmitScoreBtn`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/web/SubmitScoreBtn.as`
- 行数：64
- 职责：提交分数按钮。

#### `ZipAssetLoader`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/web/ZipAssetLoader.as`
- 行数：142
- 职责：从嵌入 ZIP 读 XML/SWF/位图/声音。
- 关键方法：`loadXML`, `loadSwf`, `loadBitmap`, `loadSound`, `dispose`, `needPreLoad`, `loadPreLoad`

#### `ZipCtrler`

- 路径：`decompiled/main/scripts/net/play5d/game/bvn/web/ZipCtrler.as`
- 行数：137
- 职责：FZip 解析 DefineBinaryData id=222；getLoader/getText/getXML/getSound。
- 关键方法：`get I`, `init`, `getLoader`, `removeFile`, `getText`, `getSound`, `getXML`

## net.play5d.kyo

play5d 自研工具包，被引擎大量引用（舞台状态机、加载器、位图字体、SharedObject）。

### `net.play5d.kyo`（1 个文件）

#### `KyoSharedObject`

- 路径：`decompiled/main/scripts/net/play5d/kyo/KyoSharedObject.as`
- 行数：42
- 职责：SharedObject 封装 load/save/deletee。
- 关键方法：`load`, `save`, `deletee`

### `net.play5d.kyo.display`（2 个文件）

#### `BitmapText`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/BitmapText.as`
- 行数：198
- 职责：位图/文本混合。
- 关键方法：`set width`, `set height`, `get textfield`, `get font`, `set font`, `get fontSize`, `set fontSize`, `get color`, `set color`, `get align`, `set align`, `get text`, `set text`, `setTextFormat`, `get defaultTextFormat`, `set defaultTextFormat`, `get textWidth`, `set textWidth`, `get textHeight`, `set textHeight`, `update`, `destory`

#### `MCNumber`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/MCNumber.as`
- 行数：77
- 职责：影片剪辑数字。
- 关键方法：`get number`, `set number`, `createNum`

### `net.play5d.kyo.display.bitmap`（3 个文件）

#### `BitmapFont`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFont.as`
- 行数：163
- 职责：位图字体。
- 关键方法：`translate`, `InsCharVO`, `clone`

#### `InsCharVO`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFont.as`
- 行数：163
- 职责：内部辅助类，见同文件主类。
- 关键方法：`BitmapFont`, `translate`, `clone`

#### `BitmapFontLoader`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFontLoader.as`
- 行数：135
- 职责：加载 font1.xml。
- 关键方法：`clear`, `loadFonts`, `loadFont`, `addFont`, `getFont`

#### `BitmapFontText`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/bitmap/BitmapFontText.as`
- 行数：66
- 职责：位图字体文本。
- 关键方法：`get text`, `set text`, `colorTransform`, `dispose`

### `net.play5d.kyo.display.shapes`（1 个文件）

#### `Box`

- 路径：`decompiled/main/scripts/net/play5d/kyo/display/shapes/Box.as`
- 行数：19
- 职责：调试矩形。

### `net.play5d.kyo.input`（2 个文件）

#### `KyoKeyCode`

- 路径：`decompiled/main/scripts/net/play5d/kyo/input/KyoKeyCode.as`
- 行数：142
- 职责：键码常量表。
- 常量：`N0`, `N1`, `N2`, `N3`, `N4`, `N5`, `N6`, `N7`, `N8`, `N9`, `Num0`, `Num1`, `Num2`, `Num3`, `Num4`, `Num5`, `Num6`, `Num7`, `Num8`, `Num9`, `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, `J`
- 关键方法：`code2name`

#### `KyoKeyVO`

- 路径：`decompiled/main/scripts/net/play5d/kyo/input/KyoKeyVO.as`
- 行数：31
- 职责：键位 VO。
- 关键方法：`toString`, `clone`

### `net.play5d.kyo.loader`（4 个文件）

#### `BitmapLoader`

- 路径：`decompiled/main/scripts/net/play5d/kyo/loader/BitmapLoader.as`
- 行数：60
- 职责：单张位图。
- 关键方法：`load`

#### `KyoClassLoader`

- 路径：`decompiled/main/scripts/net/play5d/kyo/loader/KyoClassLoader.as`
- 行数：169
- 职责：SWF 类加载。
- 关键方法：`getClass`, `get loadedAmount`, `load`, `addSwf`

#### `KyoSoundLoader`

- 路径：`decompiled/main/scripts/net/play5d/kyo/loader/KyoSoundLoader.as`
- 行数：166
- 职责：声音表。
- 关键方法：`unload`, `loadSounds`, `getSound`, `addSound`, `loadPath`

#### `KyoURLoader`

- 路径：`decompiled/main/scripts/net/play5d/kyo/loader/KyoURLoader.as`
- 行数：163
- 职责：URL 文本加载。
- 常量：`TYPE_UNICODE`, `TYPE_UNICODE_BIG_ENDIAN`, `TYPE_UTF8`, `TYPE_ANSI`
- 关键方法：`load`, `post`, `getFileType`

### `net.play5d.kyo.sound`（1 个文件）

#### `KyoBGSounder`

- 路径：`decompiled/main/scripts/net/play5d/kyo/sound/KyoBGSounder.as`
- 行数：144
- 职责：循环 BGM。
- 关键方法：`get I`, `get volume`, `set volume`, `play`, `stop`, `pause`, `resume`, `toogle`

### `net.play5d.kyo.stage`（2 个文件）

#### `Istage`

- 路径：`decompiled/main/scripts/net/play5d/kyo/stage/Istage.as`
- 行数：18
- 职责：舞台状态接口。Logo/Menu/Select/Game 等 State 均实现。
- 关键方法：`get display`, `build`, `afterBuild`, `destory`

#### `KyoStageCtrl`

- 路径：`decompiled/main/scripts/net/play5d/kyo/stage/KyoStageCtrl.as`
- 行数：257
- 职责：goStage 切换 Istage。
- 关键方法：`get currentStage`, `goStage`, `addLayer`, `hasLayer`, `get noneLayer`, `removeLayer`, `removeAllLayer`, `clean`

### `net.play5d.kyo.stage.effect`（1 个文件）

#### `IStageFadEffect`

- 路径：`decompiled/main/scripts/net/play5d/kyo/stage/effect/IStageFadEffect.as`
- 行数：14
- 职责：转场效果接口。
- 关键方法：`fadIn`, `fadOut`

### `net.play5d.kyo.stage.events`（1 个文件）

#### `KyoStageEvent`

- 路径：`decompiled/main/scripts/net/play5d/kyo/stage/events/KyoStageEvent.as`
- 行数：21
- 职责：CHANGE_STATE。
- 常量：`CHANGE_STATE`

### `net.play5d.kyo.utils`（5 个文件）

#### `KyoMath`

- 路径：`decompiled/main/scripts/net/play5d/kyo/utils/KyoMath.as`
- 行数：104
- 职责：角度、距离、范围。
- 关键方法：`fixRange`, `inRange`, `decimal`, `average`, `sum`, `getAngleByPoints`, `getDistanceByPoints`, `getPointByRadians`, `asRadians`, `velocityFromAngle`

#### `KyoRandom`

- 路径：`decompiled/main/scripts/net/play5d/kyo/utils/KyoRandom.as`
- 行数：175
- 职责：加权随机。
- 关键方法：`getRandomInArray`, `getRandomSomeInArray`, `getRandomOne`, `between`, `getRandomByRate`, `getRandomByRateLite`, `getRandomInts`, `arraySortRandom`, `getRandomColor`

#### `KyoUtils`

- 路径：`decompiled/main/scripts/net/play5d/kyo/utils/KyoUtils.as`
- 行数：1105
- 职责：显示对象/数组/绘图工具（1105 行）。
- 关键方法：`array_findOneByPortal`, `array_removeByPortal`, `array_findAllByPortal`, `array_hasItem`, `array_push_notHas`, `array_pushAt`, `array_removeItem`, `array_deleteSames`, `array_countItem`, `sprite_removeAllChildren`, `array_fixID`, `array_getSamePortalItems`, `array_groupByPortal`, `getBitmapDatasByMC`, `drawDisplay`, `drawBitmapFilter`, `drawInverted`, `translateMC`, `transparent`, `getToChildPoint`, `moveDisplay`, `addZeroBeforNumber`, `getPostfix`, `removeAllChildren`, `removeChildByName`, `number2CN`, `appendTextAutoLine`, `appendTextBottom`

#### `UUID`

- 路径：`decompiled/main/scripts/net/play5d/kyo/utils/UUID.as`
- 行数：151
- 职责：UUID.create。
- 关键方法：`create`

#### `(包级函数)`

- 路径：`decompiled/main/scripts/net/play5d/kyo/utils/setFrameOut.as`
- 行数：33
- 职责：见方法列表。
- 关键方法：`setFrameOut`

## 同 SWF 内非 play5d 依赖（引擎会用到）

| 包 | 路径 | 用途 |
|---|---|---|
| `deng.fzip` | `decompiled/main/scripts/deng/fzip/` | `ZipCtrler` 解析嵌入 ZIP |
| `com.greensock` | `decompiled/main/scripts/com/greensock/` | TweenLite，4399 按钮飞入 |
| `com.adobe.utils.StringUtil` | `decompiled/main/scripts/com/adobe/utils/` | 字符串工具 |
| `fl.motion` | `decompiled/main/scripts/fl/motion/` | ColorMatrix |
| 嵌入 SymbolClass | `decompiled/main/scripts/*.as`（`common_ui_swf$…`、`snd_*`、`LOADING_bvn`） | UI SWF / 音效 / Logo PNG |

混淆壳包不在本册，见 [`02-greenhd.md`](02-greenhd.md)。
