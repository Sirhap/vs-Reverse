# Bleach vs Naruto 3.3 分析报告

样本：`/workspace/bvn-3.3/main.swf`（FWS14，69 431 196 字节，SHA-256 `5ddf9410af93872c2b988af81e2580d466cc0f87d5e885198687f129cc00ba3e`）。依据 SWF 标签清单、内嵌 ZIP、JPEXS 反编译（`decompiled/`，894 个 `.as`），以及 `index.html` / `main.js` / `ruffle.js`。未再做完整反编译。

ABC 常量里游戏版本是 `V3.3` / `2019.3.32`。工作区里 `decompiled/main/scripts/net/play5d/game/bvn/MainGame.as` 与 `MenuState.as` 已被改成 `"V3.3-MOD"`，那是本地脚本补丁，不是原包字符串。

---

## 1. 这是什么游戏、引擎与作者包名

这是一款 Flash / ActionScript 3 的 2D 对战格斗游戏，舞台 **800×600**，菜单 30 fps、对战默认 60 fps。题材是《死神》对《火影》，另有《浪客剑心》（`kenshin` / `shishio`）和钢铁侠（辅助 `stake`）等 crossover。

引擎包名是 **`net.play5d.game.bvn`**，底层工具包 **`net.play5d.kyo`**。制作组字幕在 `CreditsState.getCreditsText()`：

> 设计、美术、研发、特效、人物制作：**剑jian**

`GameInterfaceManager.getCreadits()` 再追加：

> 游戏出品：**5dplay**  
> 发布支持：**GreenHD**

4399 渠道痕迹仍编在包里：`Ctrler4399`、`_4399_function_score_id`、`SubmitScoreBtn`、`logo4399`。HTML 包装（`main.js` 4.8.1）把这份 SWF 当 H5 游戏投到 Ruffle。

游戏模式在 `GameMode`：

| 常量 | 值 | 含义 |
|------|---:|------|
| `TEAM_ACRADE` | 10 | 小队闯关 |
| `TEAM_VS_PEOPLE` | 11 | 小队 2P |
| `TEAM_VS_CPU` | 12 | 小队打电脑 |
| `SINGLE_ACRADE` | 20 | 单人闯关 |
| `SINGLE_VS_PEOPLE` | 21 | 单人 2P |
| `SINGLE_VS_CPU` | 22 | 单人打电脑 |
| `SURVIVOR` | 30 | 生存 |
| `TRAINING` | 40 | 练习（不判死） |

3.3 相对前一版的增量写在 `bleachvsnaruto.buildGame()` 的 `UPDATE_INFO`：碎蜂、半虚一护、卡卡西·神威、佩恩重制、白哉辅助、夜一重制、音量设置、一护虚化变身（S+WJ）。

---

## 2. SWF 外壳结构（GreenHD、ZIP 资源、Ruffle 加载）

`main.swf` 不是时间轴动画片。它是 **3 帧 AS3 壳**，图形、角色、地图几乎全在二进制块里。

### 2.1 文件头与标签

| 字段 | 值 |
|------|----|
| 签名 | `FWS`（未压缩） |
| 版本 | 14 |
| FileLength | 69 431 196（与磁盘一致） |
| 舞台 | 800×600 twips RECT |
| 帧率 | 30 |
| 时间轴帧 | 3 |
| 标签数 | 38，End 贴在 EOF |

没有 DefineShape / DefineSprite / PlaceObject。标签直方图见 `extracted/full/INVENTORY.md`：4 个 DoABC、9 个 DefineBinaryData、8 个 DefineSound、3 个 DefineBitsJPEG2。

### 2.2 三帧时间轴

| 帧 | 标签 | 内容 |
|---:|------|------|
| 1 | `BleachVSNaruto` | 文档类 `BleachVSNaruto`（`BleachVSNaruto.as`）：`ǵ.ɐ.Ȱ(this,Ǵ)`，把舞台交给 GreenHD |
| 2 | `FB` | GreenHD 加载器 ABC + 128×128 PNG |
| 3 | `FC` | GreenHD 宿主 ABC + **游戏 ABC** + ZIP + 8 个 UI SWF + KO/菜单 MP3 |

文档类只负责把 MovieClip 交给壳。真正的游戏根对象是 **`bleachvsnaruto`**（`bleachvsnaruto_2.as`），由 GreenHD 在校验通过后 `addChild` 到舞台。

### 2.3 GreenHD 壳

包名 `com.green.*`、`ƃ.FB`、`ɕ.ȑ`。字符串里有 `http://www.greenhd.net/ns/greenload`、LocalConnection `_app_to_manager` / `_manager_to_app`。帧标签 `FB`/`FC` 是壳的引导帧，不是游戏场景。

壳做三件事：

1. 反加壳：`labelXML.shell` →「不允许加壳运行 / No running in a loader.」
2. 体积校验：见第 7 节。失败走 `ȑ.§͸§()` → `FB.showError()`，页面变成「APP ERROR! / 程序发生错误：重要数据被破坏」。
3. 通过后把游戏 DisplayObject 加到舞台，并经 LocalConnection 转发 4399 的 moregames / rank / score。

### 2.4 内嵌资源（DefineBinaryData）

| 符号 ID | SymbolClass 名 | 内容 |
|--------:|----------------|------|
| 222 | `assets_zip$1de7dd7d…` | ZIP，65 699 574 字节，407 个 `assets/` 条目 |
| 225–229, 2210, 2211, 2215 | `*_swf$…ByteArray` | 8 个 **CWS15** UI 影片（800×600） |
| 2219 | `movelist_jpg$…` | 出招表 JPEG，与 ZIP 内 `assets/movelist.jpg` 字节相同 |

内层内容是 **SWF15 + zlib（CWS）**，外壳是 **SWF14 + FWS**。Ruffle 必须同时吃这两种。Flex 风格的 `$md5-int` 后缀是 embed 哈希，不是加密。

ZIP 目录（`extracted/full/zips/bin_222/`）：

| 前缀 | 数量 | 用途 |
|------|-----:|------|
| `face/` | 258 PNG | 头像：默认 / `_b` 大图 / `_m` 血条 / `_w` 胜利 |
| `fighter/` | 41 可玩 + 35 `fz/` 辅助 | CWS15 角色 SWF |
| `map/` | 14 SWF + 缩略图 | 场景 |
| `bgm/` | 21 MP3 | 角色/场景/UI 音乐 |
| `config/` | 8 XML | 目录 |
| `effect.swf` | 1 | 共用特效，约 5.2 MB |
| `font/` | png + xml | 点阵字 87 字形 |

### 2.5 HTML / Ruffle

```
index.html
  ├─ local-runtime-guard.js   iframe 进度 + CSP/广告锁
  └─ main.js  (wrapper 4.8.1)
       ├─ 有 Flash 插件 → <object movie=main.swf>
       └─ 否则加载 ruffle.js 0.3.0 → XMLHttpRequest arraybuffer
            └─ player.load({ data, allowNetworking:"all", splashScreen:false })
```

`app.size["main.swf"] = 69431196`，`app.flashframe = 2`：包装层等到时间轴离开第 1 帧（进入 `FB`/`FC`）才摘掉 LOADING。角色/地图 **不会** 再走 HTTP，全在这一份 69.4 MB 里。

---

## 3. 运行时流程：MainGame → Loading → Menu → Select → Fight

状态机是 `KyoStageCtrl.goStage()`（`net.play5d.kyo.stage.KyoStageCtrl`）。`MainGame` 是门面，每个 `goXxx()` 换一个 `Istage` 并设帧率。

### 3.1 启动链

```
BleachVSNaruto (文档类)
  → GreenHD ȑ 校验体积 / 反加壳
  → addChild(bleachvsnaruto)
       initlize():
         GameInterface.instance = GameInterfaceManager
         Ctrler4399.init()
         AssetManager.I.setAssetLoader(new ZipAssetLoader())
         MainGame.initlize(this, stage)
           ResUtils.I.initalize()          // loadBytes 8 个 UI SWF
           GameRender / GameInputer / GameData.loadData()
           stageCtrl.goStage(GameLoadingState)
             ZIP 预载 → XML 目录 → 基础资源
           initBack → enterFrame 等到 isInTop
           MainGame.goLogo()
```

`GameLoadingState`（`loading_cover_mc`，来自 `loading_swf`）和稍后进对战的 `LoadingState`（`loading_fight_mc`，来自 `fight_swf`）不是同一个类。

### 3.2 场景跳转

| 方法 | 状态类 | fps | 做什么 |
|------|--------|----:|--------|
| `goLogo()` | `LogoState` | 30 | `common_ui` 的 `logo_movie`，播完 `goMenu()` |
| `goMenu()` | `MenuState` | 30 | 标题 `stg_title`，任意键弹出按钮 |
| `goHowToPlay()` | `HowToPlayState` | 30 | 闯关前操作说明 |
| `goSelect()` | `SelectFighterStage` | 30 | 选人 → 选辅助 → 选地图 |
| `loadGame()` | `LoadingState` | 30 | 从 ZIP 拉本局角色/地图/BGM |
| `goGame()` | `GameState` | `GameConfig.FPS_GAME`（默认 60） | `GameCtrl.startGame()` |
| `goOption()` | `SettingState` | 30 | 设置 |
| `goContinue()` / `goGameOver()` | `GameOverState` | 30 | 续关 / 结束 |
| `goWinner()` | `WinnerState` | 30 | 胜利立绘 |
| `goCongratulations()` | `CongratulateState` | 30 | 通关 |
| `goCredits()` | `CreditsState` | 30 | 制作组 |

`goMenu()` 会发 `DataEvent("5d_message", … "go_menu_stage")`，并 `resetDefault()` 恢复自动结束回合、自动开局、选人自动完成。

### 3.3 选人到开打

`SelectFighterStage` 三步：`SELECT_STATE_FIGHTER(0)` → `ASSIST(1)` → `MAP(2)`。格子来自 `select.xml`（`SelectStageConfigVO`）。选完 `MainGame.loadGame()`。

`LoadingState.build()` 排队：

1. P1/P2 各最多 3 名 `GameLoader.loadFighter`
2. 两侧辅助 `loadAssister`
3. 地图 `loadMap`
4. 角色/地图 BGM `SoundCtrl.loadFightBGM`

同时用 `SelectIndexUI` 排出场顺序。加载完且顺序定好后 `StateCtrl.I.transIn(MainGame.I.goGame)`。

`GameCtrl.doStartGame()`：组队、`addFighter`（P1 键鼠 / P2 键鼠或 `FighterAICtrl`）、`GameState.initFight` 摆站位、`GameMainLogicCtrler` 进主循环。练习模式立刻可操作；其它模式先走 `GameStartCtrl.start1v1` 开场动画。

---

## 4. 资源怎么加载（ZipAssetLoader、角色/地图 SWF、XML）

### 4.1 两套 Loader

`AssetManager` 默认 `AssetLoader`（`URLRequest` 拉 `assets/…`，适合未打包的开发树）。网页包在 `bleachvsnaruto.initlize()` 换成 `ZipAssetLoader`。

```
ZipAssetLoader  →  ZipCtrler.I
                     _embedZip = assets_zip$1de7dd7d…
                     FZip.loadBytesStep(_zipBytes, 20)
                     getXML / getLoader(loadBytes) / getSound
```

`needPreLoad() == true`，所以 `GameLoadingState` 先 `AssetManager.loadPreLoad()` 解 ZIP，再读 XML。

### 4.2 UI SWF（不走 ZIP）

`ResUtils` 把 8 个嵌套 SWF 的 ByteArray 类反射出来，`InsSwf` 对 `movieClipData` 做 `Loader.loadBytes(..., allowCodeImport=true)`，进当前 `ApplicationDomain`。之后 `createDisplayObject(ResUtils.I.title, "stg_title")` 这类调用都从这些域取类。

| `ResUtils` 字段 | 库名 | 典型导出 |
|-----------------|------|----------|
| `title` | `title_swf` | `stg_title` |
| `loading` | `loading_swf` | `loading_cover_mc` |
| `select` | `select_swf` | `stg_select` |
| `fight` | `fight_swf` | `ui_fight`, `loading_fight_mc` |
| `setting` | `setting_swf` | `stg_set_ui` |
| `howtoplay` | `howtoplay_swf` | `movie_howtoplay` |
| `gameover` | `gameover_swf` | `stg_gameover_mc` |
| `common_ui` | `common_ui_swf` | `logo_movie`, `cover_bgimg` |

### 4.3 XML 目录链

`GameData.loadConfig()`：

```
fighter.xml  → FighterModel
assist.xml   → AssisterModel
select.xml   → config.select_config
map.xml      → MapModel
mission.xml  → MessionModel   // 类名沿用 misspelling
```

`GameLogic.setGameMode(1)` 会改读 **`salect.xml`**（旧格子，`top="50"`），并切 `winner_stg_mc2`。默认 3.3 格子是 `select.xml`（`top="100"`，51 格含碎蜂/神威/半虚）。localhost 下 Ctrl+F8 / Ctrl+F9 可切换（`GameInterfaceManager.keyHandler`）。

`AssetManager.loadBasic()` 顺序：`preload.xml` 的 BGM+脚步 → `assets/effect.swf` → `font/font1.xml` → 全部 face/map 缩略图。

### 4.4 角色 SWF 怎么变成 FighterMain

`FighterVO.fileUrl` 来自 XML，例如：

```xml
<fighter id="ichigo_wanjie" name="黑崎·一护 卍解" comic_type="0">
  <file url="assets/fighter/ichigo.swf" startFrame="2" />
  <face url="assets/face/ichigo_wj.png" … />
</fighter>
```

同一份 SWF 用 `startFrame` 切皮肤（一护 1–4 段共用 `ichigo.swf`）。`GameLoader.loadFighter`：

1. `ZipCtrler.getLoader(url)` → `loadBytes`
2. `new FighterMain(content as MovieClip)`
3. `FighterMain.initlize()` 要求时间轴实现 **`setFighterCtrler`**，否则抛「SWF未定义setFighterCtrler()」
4. `_mainMc.gotoAndStop(data.startFrame + 1)`

角色时间轴（例 `decompiled/fighters/naruto/scripts/naruto_fla/MainTimeline.as`）在对应帧里 `defineAction("tk", {power, hitType, hitx, hity, hurtTime, …})`，引擎侧 `FighterCtrler.defineAction` → `FighterHitModel.addHitVO`。

地图 SWF **没有 AS3 脚本**（`decompiled/maps/*/scripts` 为空）。`MapMain.initlize()` 靠实例名：`p1`/`p2` 出生点，`line_left/right/bottom`、`line_player_bottom` 边界，`map` / `front` / `front_fix` / `bg` 图层。

### 4.5 资源尺寸约定（美术接入）

引擎把 PNG 拉到固定像素，改图时按这个比：

| 用途 | 代码默认 | 路径模式 |
|------|----------|----------|
| 选人头像 | 50×50 | `face/<id>.png` |
| 大横条 | 245×62 | `*_b.png` |
| 血条脸 | 102×64 | `*_m.png` |
| 胜利立绘 | 300×250 | `*_w.png` |
| 地图缩略 | 450×240 | `map/<id>.png` |
| 点阵字 | `font1.png` + `font1.xml` | `charGap=-8` |

角色是时间轴剪辑，不是骨骼。命中靠子剪辑名字（见下节），不是独立碰撞文件。

---

## 5. 战斗核心（FighterMain、输入、命中）

### 5.1 对象与数值

`FighterMain` 继承 `BaseGameSprite`：

| 字段 | 默认 | 说明 |
|------|------|------|
| `hp` / `hpMax` | `GameConfig.FIGHTER_HP_MAX = 1000` | 设置里可乘 `fighterHP` |
| `qi` / `qiMax` | 0 / 300 | 必杀槽 |
| `energy` | 100 | 体力，过载后慢回 |
| `fzqi` | 100 | 辅助槽，每帧 `+0.2` |
| `speed` / `jumpPower` | 6 / 15 | |
| `isSteelBody` | false | 钢身，受伤系数 0.65 / 0.3 |

重力 `G=12`，`SPEED_PLUS = 30/FPS_GAME`，所以 60 fps 下位移按半帧缩放，动画仍按 30 fps 逻辑帧（`GameCtrl._renderAnimateGap`）。

`FighterActionState`：待机 0，攻击 10–13，防御 20，受伤 21–24，死亡 30，卍解 50，开场/胜负 60–62。练习模式 `GameLogic.checkFighterDie` 恒为 false。

### 5.2 输入

`GameInputer` 三套：`MENU` / `P1` / `P2`，默认都是 `GameKeyInput`（键盘）。`justDown`：0 按住、1 当下按下、2 约 0.1s 缓冲（`JUST_DOWN_DELAY`）。

`ConfigVO.setDefaultConfig`：

| | 方向 | 攻/跳/冲 | 技能/必杀/辅助 |
|--|------|----------|----------------|
| P1 / 菜单 | WASD | J K L | U I O |
| P2 | 方向键 | 小键盘 1 2 3 | 4 5 6 |

ESC（27）= `back`。`keyInputMode==1` 为 CLASSIC（无 justDown 缓冲）。

`FighterKeyCtrl` 把键映射成招式：

| 方法 | 键 |
|------|----|
| `attack` | 攻，且不按上/下/跳 |
| `skill1` / `skill2` | 下+攻 / 上+攻 |
| `zhao1/2/3` | 技能 / 下+技能 / 上+技能 |
| `bisha` / `bishaUP` / `bishaSUPER` | 必杀 / 上+必杀 / 下+必杀 |
| `assist` | 辅助键 |
| `waiKai` | 卍解（S+WJ 等组合在后续方法） |
| `catch1/2` | 方向+攻/技能 |

CPU 走 `FighterAICtrl`，等级来自 `MessionModel.I.AI_LEVEL`（设置里 1–6）。

### 5.3 命中

每逻辑动画帧，`GameMainLogicCtrler.renderMainLogic()`：

1. 全部 `IGameSprite.render()`，动画帧再 `renderAnimate()`
2. 不同队伍两两 `checkBodyHit`（体积推挤）和 `checkHit`

`checkHit`：

```
hitsA = A.getCurrentHits()     // HitVO + currentArea
bodyB = B.getBodyArea()        // 子剪辑 "bdmn"
若 Rectangle.intersection 非空：
    B.beHit(hitVO, hitRect)
    A.hit(hitVO, B)
```

角色 SWF 约定：

- **`bdmn`**：身体盒（`FighterMC.findBodyArea`）
- **`atm*`**：攻击盒；`FighterHitModel.getHitVOByDisplayName` 会去掉 `atm` 前缀去查 `defineAction` 的 id
- 帧标签：招式名、落地、受击等（`FighterMC.checkFrame`）

`HitVO`：`power`、`hitType`（`HitType`：砍/打/魔法/火/冰/电/石/抓）、`isBreakDef`、击退 `hitx/hity`、`hurtTime`、`hurtType`（0 普通 / 1 击飞）。必杀 id 含 `bs`/`sbs`/`cbs`/`kbs`。

伤害：`getDamage() = power * powerRate`。命中方加气 `power * 0.17`（必杀为 0），上限 15；挨打方 `power * 0.08`，上限 20。防御仍掉 `DEFENSE_LOSE_HP_RATE=0.05` 的血。钢身再乘 0.65 / 0.3。

`FighterMain.beHit` → `FighterMcCtrler.beHit`：受击硬直、击飞、倒地、破防；`_beHitGap` 4–10 帧防连段穿透。

子弹 `Bullet`、辅助 `Assister`、从者 `FighterAttacker` 同样实现 `hit`/`beHit`，进同一套队伍对打。

### 5.4 一局结构

`GameCtrl` 持有 `GameStartCtrl`（开场）、`GameMainLogicCtrler`（循环）、`GameEndCtrl`（KO）、`FighterEventCtrl`（招式事件）、`TrainingCtrler`。HUD 是 `FightUI`（`ui_fight`）：血条 `FightBar`、气条 `QiBar`、连击 `HitsUI`、暂停 `PauseDialog`。地图 BGM 与角色 BGM 按 `bgmRate` 混。

---

## 6. UI / 菜单

菜单文案在 `GameInterface.getDefaultMenu()`，网页包 `GameInterfaceManager.getGameMenu()` 在第四项后插入 **RANK**。

主菜单（`MenuBtnGroup`，挂在 `stg_title` 的 `btnct`）：

```
TEAM PLAY
  TEAM ACRADE / TEAM VS PEOPLE / TEAM VS CPU
SINGLE PLAY
  SINGLE ACRADE / SINGLE VS PEOPLE / SINGLE VS CPU
OPTION
TRAINING
CREDITS
MORE GAMES
(+ RANK)
```

标题先停在第 1 帧，`afterBuild` 播第 2 帧，500 ms 后任意键/`click` 进 `"menu"` 帧并 `MenuBtnGroup.fadIn`。版本字画在右下（原包 `V3.3`）。首次运行弹 `GameUI.alert("UPDATE", UPDATE_INFO)`。

选人 UI：`SelectFighterItem` 网格 + `SelecterItemUI` 光标 + `SelectedFighterGroup` 已选三人 + `MapSelectUI`。支持键鼠和 `TOUCH_MODE`。

设置（`SetBtnGroup.initMainBtns`）：P1/P2 键位、COM 1–6、操作模式 NORMAL/CLASSIC、生命 50%–500%、时间 30/60/90/∞、音效、BGM、画质 low/medium/high/best。APPLY 写 `KyoSharedObject.save("bvn3_save")`，存档 id 仍是 **`bvn3.01`**。

操作说明 `HowToPlayState` 把当前 P1 键名填进 `movie_howtoplay` 的 `txt_up` 等文本框。

对战 HUD、暂停、KO、出招表（`MoveListSp` 用那张 800×600 JPEG）都从 `fight_swf` 取类。

---

## 7. 完整性校验（APP ERROR）对修改的影响

### 7.1 触发文案

`decompiled/main/scripts/ɕ/ȑ.as`：

```xml
<appError en="APP ERROR!" zh-CN="程序发生错误：重要数据被破坏" …/>
<shell   en="No running in a loader." zh-CN="不允许加壳运行" …/>
```

`§͸§()` → `FB.showError()` → `show_html(get_error_html(…))`，游戏 DisplayObject 被 `removeChild`。

### 7.2 实际比的是长度，不是内容哈希

两处：

**A. 加载后** `§ͦ§()`：

```
ǵ.ɐ.bytesTotal == timeline.loaderInfo.bytes.length  → 通过
否则 APP ERROR
```

`bytesTotal` 来自下载/声明长度，`loaderInfo.bytes.length` 是进 AVM 的字节数。两者不一致（截断、另包一层 Loader）会炸。

**B. 加到舞台后** `§͵§()`：

```actionscript
if (!ǵ.ɐ.Ɉ && _loc1_.loaderInfo.bytes.length != parseInt("0x" + "#04236f9c".slice(1)))
{
    ȑ.§͸§();
    §͝§.parent.removeChild(§͝§);
}
```

`"#04236f9c".slice(1)` → `0x04236f9c` = **69 431 196**，正好是 SWF `FileLength`。用字符串拼接是为了避开直接搜十六进制。标志 `Ɉ` 为真时跳过这条。

另外：若 `ǵ.ɐ.Ʌ` 且 `!FB.serviceHold.ˢ && isReady`，显示「不允许加壳运行」。

ZIP 内文件还有 **deng.fzip 的 CRC32**（`ChecksumUtil.CRC32`）。那是 ZIP 条目校验，和 APP ERROR 不是同一条路；改 ZIP 内容却不改 local header CRC，会在 `ZipCtrler.init` / `getLoader` 阶段失败，表现为加载条报错而不是 APP ERROR 黄页。

### 7.3 改包时会发生什么

| 改动 | 结果 |
|------|------|
| ABC 字符串等长替换（`V3.3` → 同长度） | 体积不变，B 通过 |
| 给 AS 加代码、ZIP 换更大 SWF、插入文件 | FileLength 变，B 触发 APP ERROR |
| 只改 ZIP 里某 PNG 且保持压缩后总长 | 有机会过 B，但仍需 ZIP CRC 合法 |
| 外层再套一层 Loader | A 或 shell 文案 |
| 改 `main.swf` 头上的 FileLength 却不改 `#04236f9c` | 仍 APP ERROR |
| 补丁把比较改成恒真，或把常量改成新体积 | 可过壳 |

工作区 `rebuild-mod.sh` 用 FFDec `-importScript` 把 `decompiled/main/scripts` 灌回 SWF。只要导出体积 ≠ 69 431 196，不改壳常量就会 APP ERROR。`MainGame.VERSION = "V3.3-MOD"` 已经比原串长 4 字节，单独这一处就会牵动 ABC 长度。

没有对角色 SWF 或 XML 的二次签名。过了壳之后，ZIP 内资源只信路径和 CRC。

---

## 8. 结论与可改点

这是 **GreenHD 壳 + 5DPLAY 引擎 + 内嵌 ZIP 资源包** 的网页格斗游戏。逻辑全在 AS3，资源按 XML 目录从 ZIP `loadBytes`。Ruffle 只负责把这一份 SWF 跑起来。

### 可改、且相对干净的面

1. **过壳**  
   改 `ɕ/ȑ.as` 里那次 `parseInt("0x" + "#04236f9c".slice(1))`：写成新 `FileLength`，或直接删掉比较。同时改 SWF 头 4 字节 FileLength。只改一边不够。

2. **目录 XML**（`extracted/assets/config/`）  
   - `fighter.xml` / `assist.xml`：加号、改名、换 `startFrame`、换立绘路径  
   - `select.xml`：7×10 格子；漏写 id 会空格  
   - `map.xml` / `mission.xml`：场景、闯关倍率  
   改完要重打 ZIP，并处理 ZIP CRC 与外壳体积。

3. **角色手感**  
   各 `fighters/<id>/scripts/*_fla/MainTimeline.as` 的 `defineAction`（`power`、`hurtTime`、`isBreakDef`）。不改引擎也能调伤害。时间轴上 `atm*` / `bdmn` 决定盒子。

4. **引擎常数**（`GameConfig.as`）  
   重力、气槽倍率、钢身系数、HP 上限、FPS。`FighterMain.hit/beHit` 里写死的 0.17 / 0.08 加气也在这里一侧。

5. **菜单与设置**  
   `GameInterface.getDefaultMenu()`、`GameInterfaceManager.getGameMenu()`（可去掉 4399 RANK/MORE GAMES）、`SetBtnGroup` 选项、`MenuState` 版本字。

6. **UI 影片**  
   8 个 CWS15。改标题/选人/HUD 要保导出类名：`stg_title`、`stg_select`、`ui_fight` 等，否则 `ResUtils.createDisplayObject` 会炸。

7. **存档**  
   `bvn3_save` / id `bvn3.01`。改键位、AI、音量、画质不必动 SWF。

### 不建议当第一刀的面

- GreenHD 混淆标识符（`ɕ.ȑ`、`ǵ.ɐ`）：只为过壳时动体积比较，不要重写加载器。  
- 角色 SWF 时间轴图形：能改，但是 Flash 影片剪辑工程，不是独立 sprite sheet。  
- 地图 SWF：无脚本，靠实例名；改图可以，改名 `p1`/`map`/`line_*` 会让 `MapMain` 拿不到边界。  
- `effect.swf`：5.2 MB 共用特效，和 `AssetManager.getEffect(className)` 绑死。

### 建议的改包顺序

```
1. 补丁 ȑ.as 体积检查（或等长 NOP）
2. 改 XML / 角色 defineAction / 菜单文案
3. 重打 assets ZIP，写回 DefineBinaryData id 222
4. 重算 SWF FileLength，写回文件头 并 写回壳里的 0x04236f9c
5. 用 Ruffle 走到 Logo → Menu → Select → 开打，确认不是 APP ERROR
```

同体积、只改 ZIP 内已有文件内容时，第 1/4 步可以省，但仍要 ZIP CRC 正确。

---

## 附录：关键路径

| 角色 | 路径 |
|------|------|
| 文档类 | `decompiled/main/scripts/BleachVSNaruto.as` |
| 游戏根 | `decompiled/main/scripts/bleachvsnaruto_2.as` |
| 门面 | `…/net/play5d/game/bvn/MainGame.as` |
| 壳 / APP ERROR | `decompiled/main/scripts/ɕ/ȑ.as`、`ƃ/FB.as` |
| ZIP | `…/web/ZipCtrler.as`、`ZipAssetLoader.as` |
| 资源管理 | `…/ctrl/AssetManager.as`、`utils/ResUtils.as` |
| 状态 | `…/state/{Logo,Menu,SelectFighter,Loading,Game}State.as` |
| 战斗 | `…/fighter/FighterMain.as`、`ctrl/game_ctrls/GameMainLogicCtrler.as` |
| 输入 | `…/input/GameInputer.as`、`fighter/ctrler/FighterKeyCtrl.as` |
| 目录 XML | `extracted/assets/config/*.xml` |
| 已解压 ZIP | `extracted/full/zips/bin_222/assets/` |
| 标签清单 | `extracted/full/INVENTORY.md` |
