# 04 地图、UI 八 SWF、config XML

权威源：`extracted/assets/config/*.xml`、`decompiled/maps/`、`decompiled/ui/`、`decompiled/other/effect/`、`extracted/full/INVENTORY.md`。引擎解析见 [`01-engine.md`](01-engine.md)。角色对照见 [`03-fighters.md`](03-fighters.md)。

## 地图（14 个 SWF + random）

`map.xml` 根 `map_config`。`GameData.loadConfig` → `MapModel.initByXML`。`GameLoader.loadMap` → `new MapMain(sprite)`。

`decompiled/maps/` 14 个目录 **全部 0 个 .as**：地图 SWF 只有显示对象，没有 DoABC。FFDec 成功导出空 `scripts/` 是预期，不是失败（`decompiled/maps/README.md`）。

### XML 全表

| id | 中文名 | file | 预览 img | bgm |
|---|---|---|---|---|
| `random` | 随机场景 | — | `assets/map/random.png` | — |
| `xianshi` | 现世 | `assets/map/xianshi.swf` | `assets/map/xianshi.png` | `assets/bgm/city.mp3` |
| `liuhunjie` | 流魂街 | `assets/map/liuhunjie.swf` | `assets/map/liuhunjie.png` | `assets/bgm/village.mp3` |
| `jingyantin` | 静涎亭 | `assets/map/jingyantin.swf` | `assets/map/jingyantin.png` | `assets/bgm/wind.mp3` |
| `shuangji` | 双极 | `assets/map/shuangji.swf` | `assets/map/shuangji.png` | `assets/bgm/wind.mp3` |
| `shihunjietongdao` | 尸魂界通道 | `assets/map/shihunjietongdao.swf` | `assets/map/shihunjietongdao.png` | `assets/bgm/shandong.mp3` |
| `jianchang` | 斩魂刀冢 | `assets/map/jianchang.swf` | `assets/map/jianchang.png` | `assets/bgm/wind.mp3` |
| `zoulang` | 十三番队 | `assets/map/zoulang.swf` | `assets/map/zoulang.png` | `assets/bgm/village.mp3` |
| `muyecun` | 木叶村 | `assets/map/muyecun.swf` | `assets/map/muyecun.png` | `assets/bgm/village.mp3` |
| `wenquan` | 温泉 | `assets/map/wenquan.swf` | `assets/map/wenquan.png` | `assets/bgm/water.mp3` |
| `pubu` | 火影瀑布 | `assets/map/pubu.swf` | `assets/map/pubu.png` | `assets/bgm/pubu.mp3` |
| `louding` | 楼顶 | `assets/map/louding.swf` | `assets/map/louding.png` | `assets/bgm/wind.mp3` |
| `yuzhibocun` | 宇智波村 | `assets/map/yuzhibocun.swf` | `assets/map/yuzhibocun.png` | `assets/bgm/village.mp3` |
| `senlin` | 森林 | `assets/map/senlin.swf` | `assets/map/senlin.png` | `assets/bgm/wind.mp3` |
| `wuyingcun` | 水影村 | `assets/map/wuyingcun.swf` | `assets/map/wuyingcun.png` | `assets/bgm/village.mp3` |

反编译目录一一对应：`decompiled/maps/<id>/`（`random` 无 SWF）。

### 实例名约定（`MapMain.initlize`）

路径：`decompiled/main/scripts/net/play5d/game/bvn/map/MapMain.as`。根 MC 上按 **实例名** 取子对象：

| 实例名 | 类型 | 用途 |
|---|---|---|
| `line_left` | DisplayObject | 左边界 x → `left` |
| `line_right` | DisplayObject | 右边界 x → `right` |
| `line_bottom` | DisplayObject | 地图底 y → `bottom` |
| `line_player_bottom` | DisplayObject | 角色落地 y → `playerBottom` |
| `p1` | DisplayObject | 1P 出生点 |
| `p2` | DisplayObject | 2P 出生点 |
| `map` | MovieClip | 中景层 `mapLayer`（随镜头） |
| `front` | Sprite | 前景，记录 `_defaultFrontPos` |
| `front_fix` | Sprite | 固定前景 |
| `bg` | DisplayObject | 绘成 `Bitmap` 背景 |
| `floor` | Sprite | 子对象逐个变成 `FloorVO`（xFrom/xTo/y） |
| `logo4399` | 任意（在层内） | `MAP_LOGO_STATE != 1` 时 `visible=false` |

竖直对齐：用 `GAME_SIZE.y - bottom` 把落地线挪到屏幕底。`getFloorHitTest(x,y,height)` 遍历 `FloorVO.hitTest`。缺某个名字则对应字段保持 0/null，不会抛错。

改地图碰撞：改 SWF 里这些实例的位置，不必写 AS。

## UI 八个 CWS15 导出类

`main.swf` DefineBinaryData 里 8 个嵌套 SWF，全部签名 **CWS（zlib）Flash 15**。`ResUtils` 把它们当 Class 嵌入，`initalize()` 实例化后 `createDisplayObject(swf, linkageName)`。

| BinaryData id | 符号（截断） | 导出体积 | 反编译目录 | `.as` | `ResUtils` 字段 | 主导出类 |
|---|---|---|---|---|---|---|
| 225 | `common_ui_swf$…` | 218198 | `decompiled/ui/common_ui/` | 8 | `common_ui` | `logo_movie`、`mc_congratulations`、`mc_win_all`、`mc_wzbtn`、`select_arrow_mc`、`trans_mc` |
| 226 | `fight_swf$…` | 258845 | `decompiled/ui/fight/` | 33 | `fight` | `ui_fight`、`hpbar_mc`、`qbar_mc`、`energy_bar`、`hits_mc`、`time_mc`、`score_mc`、`winmc`、`bsface_mc`、`player_pos_p1/p2` |
| 227 | `gameover_swf$…` | 245798 | `decompiled/ui/gameover/` | 1 | `gameover` | `stg_gameover_mc` |
| 228 | `howtoplay_swf$…` | 237336 | `decompiled/ui/howtoplay/` | 3 | `howtoplay` | `movie_howtoplay` |
| 229 | `loading_swf$…` | 613114 | `decompiled/ui/loading/` | 12 | `loading` | `loading_cover_mc`、`loading_fight_mc`、`loading_select_ui_mc`、`winner_stg_mc`、`loadingbar_mc` |
| 2210 | `select_swf$…` | 382308 | `decompiled/ui/select/` | 8 | `select` | `stg_select`、`select_item_mc`、`select_map_mc`、`slt_item_mc`、`selected_item_p1_mc`、`selected_item_p2_mc`、`ctmc` |
| 2211 | `setting_swf$…` | 203190 | `decompiled/ui/setting/` | 5 | `setting` | `stg_set_ui`、`key_set_dialog_mc`、`keyset_mc`、`txt_arrow_mc` |
| 2215 | `title_swf$…` | 499256 | `decompiled/ui/title/` | 3 | `title` | `stg_title`、`stg_test`、`title_fla/logomc_3` |

`ResUtils` 常量字符串（linkage 名）：

| 常量 | 值 | 使用状态 |
|---|---|---|
| `TITLE` | `stg_title` | `LogoState` / 标题 |
| `SELECT` | `stg_select` | `SelectFighterStage` |
| `SETTING` | `stg_set_ui` | `SettingState` |
| `GAME_OVER` | `stg_gameover_mc` | `GameOverState` |
| `WINNER` | `winner_stg_mc` | `WinnerState` |
| `CONGRATULATIONS` | `mc_congratulations` | `CongratulateState` |

`stg_title`（`decompiled/ui/title/scripts/stg_title.as`）：`btnct`、`logo_mc`；帧 50 / 75 `stop` 并 `Event.COMPLETE`。

战斗 HUD 由 `FightUI` 从 `fight` SWF 取 `ui_fight` 等，不走 `ResUtils` 常量表。

### UI 目录文件一览

**common_ui（8）**：`common_ui_fla/MainTimeline.as`、`wzimg_bgimg_5.as`、`logo_movie.as`、`mc_congratulations.as`、`mc_win_all.as`、`mc_wzbtn.as`、`select_arrow_mc.as`、`trans_mc.as`

**fight（33）**：`ui_fight.as`、`hpbar_*`、`qbar_*`、`energy_bar*`、`hits_*`、`time_*`、`score_mc`、`txt_mc`、`winmc`、`bsface_mc`、`player_pos_p1.as`、`player_pos_p2.as`、以及 `fight_fla/` 下 `game_start_mc_44`、`round_num_mc_45`、`winmc_bleach_22` 等元件类。

**gameover（1）**：`stg_gameover_mc.as`

**howtoplay（3）**：`movie_howtoplay.as`、`howtoplay_fla/arrow020321_6.as`、`元件48_11.as`

**loading（12）**：`loading_cover_mc.as`、`loading_fight_mc.as`、`loading_select_ui_mc.as`、`loadingbar_mc.as`、`winner_stg_mc.as`、`winner_stg_mc2.as`、`cover_bgimg.as`、`seltwzmc.as`、`select_arrow_mc_1/2.as`、`loading_fla/MainTimeline.as`、`元件8_17.as`

**select（8）**：`stg_select.as`、`select_item_mc.as`、`select_map_mc.as`、`select_map_txt_mc.as`、`selected_item_p1_mc.as`、`selected_item_p2_mc.as`、`slt_item_mc.as`、`ctmc.as`

**setting（5）**：`stg_set_ui.as`、`key_set_dialog_mc.as`、`keyset_mc.as`、`txt_arrow_mc.as`、`setting_fla/元件1_13.as`

**title（3）**：`stg_title.as`、`stg_test.as`、`title_fla/logomc_3.as`

## config XML 字段

路径：`extracted/assets/config/`（ZIP 内 `assets/config/` 的拷贝）。`GameData.loadConfig` **只读** `fighter.xml` → `assist.xml` → `select.xml` → `map.xml` → `mission.xml`。`preload.xml` 由 `AssetManager.loadPreLoad` 在此之前读取。`salect.xml` **不被** `loadConfig` 引用。

### fighter.xml（根 `fighter_config`）

`<fighter>` 59 条。字段：

| 位置 | 属性/子元 | 引擎字段 |
|---|---|---|
| `@id` | 选人/闯关引用的 id | `FighterVO.id` |
| `@name` | 中文名 | `name` |
| `@comic_type` | `0` 死神 / `1` 火影 / `-1` 随机 | `comicType` |
| `file/@url` | SWF 路径 | `fileUrl` |
| `file/@startFrame` | 皮肤索引（引擎 `gotoAndStop(startFrame+1)`） | `startFrame` |
| `face/@url` | 选人小脸 | `faceUrl` |
| `face/@big_url` | 大脸 | `faceBigUrl` |
| `face/@bar_url` | 血条头 | `faceBarUrl` |
| `face/@win_url` | 胜利图 | `faceWinUrl` |
| `contact/friend` `enemy` | 逗号分隔（本包多为空） | `contactFriends` / `contactEnemys` |
| `says/say_item` | 开场台词，`\|` 可分行 | `says[]`，`getRandSay()` |
| `bgm/@url` | 角色 BGM | `bgm` |
| `bgm/@rate` | 百分数，引擎 `/100` | `bgmRate` |

随机三项无 `file`。完整 id 表见 [`03-fighters.md`](03-fighters.md)。

### assist.xml（根 `assist_config`）

同样 `<fighter>` 37 条。无 `startFrame` / `bar_url` / `win_url` / `says` / `bgm`。`AssisterModel.initByXML` 仍走 `FighterVO.initByXML`，缺的字段为 0/空。

注意 id：`garra`→`fz/gaara.swf`，`halibel`→`fz/harribel.swf`。

### select.xml（根 `select_config`）— **实际使用**

| 节点 | 字段 | 含义 |
|---|---|---|
| `stage_setting/layout` | `x y width height left right top bottom` | 选人舞台：800×600，`top=100` `bottom=10` |
| `char_list/row` | 可选 `@offset` | 一行 10 个格子 |
| `row/item` | 文本 = fighter id；`@offset` 像素微调 | 空 item = 空格子 |
| `assist_list` | 结构同 char_list | 辅助网格 |

`SelectStageConfigVO.setByXML` 解析。网格里出现的 id 必须在 `fighter.xml` / `assist.xml` 存在，否则选中后 `GameLoader` 报「角色ID错误」。

### salect.xml（根同样 `select_config`）— **未加载**

文件名是 `select` 的错拼。layout `top=50 bottom=50`；角色排列更旧（例如 `soifon`/`kakashi_sw` 在最后一行，缺少部分后期格）。保留作对照，改选人界面应改 `select.xml`。

### map.xml（根 `map_config`）

见上表。`random` 只有 `img`。`MapSelectUI` 用 `img` 做缩略图。

### mission.xml（根 **`mession`**，引擎类名同样拼错）

| 节点 | 属性 | 含义 |
|---|---|---|
| `design` | `comicType` 0/1；`gameMode` 0=TEAM 1=SINGLE | 四套闯关 |
| `stage` | `fighter` 逗号 id 列表 | 本关敌人 |
| | `assister` | 本关辅助 |
| | `map` | 地图 id |
| | `attackRate` `hpRate` 可选 | 敌人攻/血倍率 |

四套 `design`：

| comicType | gameMode | 路线 | 终关 |
|---|---|---|---|
| 0 死神 | 0 TEAM | 木叶→森林→楼顶→瀑布→宇智波村(鼬×2)×2 →温泉→水影村→森林(斑) | `madara` + `obito`，`attackRate=1.5 hpRate=2` |
| 0 | 1 SINGLE | 同地图角色，倍率较少 | `madara` |
| 1 火影 | 0 TEAM | 斩魂刀冢→现世→流魂街→十三番队→通道(虚化)×1.5 →双极→静涎亭→双极(蓝染) | `aizen` + `yin`，`hpRate=2` |
| 1 | 1 SINGLE | 同行 | `aizen` |

死神闯关打火影角色，火影闯关打死神角色。

### preload.xml（根 `preload`）

```
bgm/@path=assets/bgm
  loading.mp3, op.mp3, select.mp3, continue.mp3, back.mp3,
  congratulation.mp3, win.mp3, winloop.mp3
sound/@path=assets/sounds
  step1.mp3, step2.mp3, step3.mp3
```

`GameLoadingState.loadGame`：若 `AssetManager.needPreLoad()` 则先拉这些，再 `loadConfig`。

## effect.swf（89 个 .as）

路径：ZIP `assets/effect.swf` → `decompiled/other/effect/`。`AssetManager._effectSwfPath = "assets/effect.swf"`，`EffectModel` 按 HitType / 特效 id 取剪辑。

导出类前缀：

| 前缀 | 例子 | 用途 |
|---|---|---|
| `XG_*` | `XG_kan` `XG_bs` `XG_cbs` `XG_fire` `XG_ice` `XG_ghost_step` `XG_tishen` | 打击/必杀/属性/鬼步/替身 |
| `xg_buff_*` | `xg_buff_power` `xg_buff_speed` `xg_buff_defense` | buff 图标 |
| `XG_fz_*` | `XG_fz_bleach_mc` `XG_fz_naruto_mc` | 辅助出场 |
| `snd_*` | `snd_hit1` `snd_kan1` `snd_dash` `snd_luodi` | 嵌入音效文档类 |
| 其它 | `bisha_face_mc` `kobg_effect_mc` `effect_fla/MainTimeline` | 必杀脸、KO 背景 |

完整 89 条路径见 [`CLASS-INDEX.md`](CLASS-INDEX.md) `other / effect`。

## ZIP 内其它资源（非脚本）

`extracted/full/INVENTORY.md` / `zips/bin_222`：

- `assets/bgm/*.mp3` — 场景与系统 BGM
- `assets/face/*.png` — 脸图（含 `_b` `_m` `_w` 后缀）
- `assets/fighter/*.swf` 与 `fz/*.swf`
- `assets/map/*.swf` `*.png`
- `assets/font/font1.xml` — 位图字体
- `assets/sounds/sound.xml` + 步进音

主 SWF 另外嵌入：`snd_menu1/2/5`、`snd_ko`、`snd_ko_bs`、`snd_gameover`、`snd_ghost_jump`、`snd_over_hit`、`movelist_jpg`、`submitscore_png`、`bvn_png`（LOADING 图标）。
