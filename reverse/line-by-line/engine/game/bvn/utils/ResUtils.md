# `ResUtils` — 8 个嵌入 UI SWF 的单例工厂

一句话目的：`MainGame.initlize` 第一步。把 8 个 `[Embed]` UI SWF Class `loadBytes` 进当前 `ApplicationDomain`，之后按链接名 `createDisplayObject` / `createBitmapData`。角色/地图 SWF 不走这里，走 ZIP。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/ResUtils.as`（232 行，含脚本级 `InsSwf`）

## Callers / callees

- **Callers（`initalize`）**：仅 `MainGame.initlize`（L102）`ResUtils.I.initalize(resInitBack, initFail)`。成功后才 `GameRender` / `GameInputer` / `GameData.loadData` / `GameLoadingState`。
- **Callers（`createDisplayObject` / `createBitmapData` / `getItemClass`）**：几乎所有 State / UI：

| 字段 | 链接名常量或字面量 | 调用方 |
|------|-------------------|--------|
| `title` | `TITLE`=`stg_title` | `MenuState` |
| `select` | `SELECT`=`stg_select`；`select_item_mc` / `slt_item_mc` / `seltwzmc` / `select_map_*` / `select_arrow_mc_*` | `SelectFighterStage`、`SelecterItemUI`、`SelectFighterItem`、`SelectedFighterUI`、`MapSelectUI`、`SelectIndexUI`、`SelectUIFactory` |
| `setting` | `SETTING`=`stg_set_ui`；`txt_arrow_mc` / `keyset_mc` / `key_set_dialog_mc` | `SettingState`、`SetBtn`、`SetCtrlBtnUI`、`SetBtnDialog` |
| `gameover` | `GAME_OVER`=`stg_gameover_mc` | `GameOverState` |
| `loading` | `loading_cover_mc`；`WINNER`=`winner_stg_mc`；`loading_fight_mc` | `GameLoadingState`、`WinnerState`、`LoadingState` |
| `howtoplay` | `movie_howtoplay` | `HowToPlayState` |
| `fight` | `ui_fight` / `player_pos_p1/p2` / `time_txtmc` / `hits_num_mc` / `txtmc_score` | `FightUI`、`FightTimeUI`、`HitsUI`、`FightScoreUI` |
| `common_ui` | `CONGRATULATIONS`=`mc_congratulations`；`logo_movie` / `mc_wzbtn` / `cover_bgimg` / `mc_win_all` / `select_arrow_mc` / `trans_mc` | `LogoState`、`MenuBtn`、`CongratulateState`、`CreditsState`、`GameOverState`、`SetBtnGroup`、`TransUI` |

- **`ResUtils.WINNER` 会被改**：`GameLogic.setGameMode(1)` → `"winner_stg_mc2"`（旧格子 `salect.xml`）；`0` → `"winner_stg_mc"`。localhost Ctrl+F8/F9。
- **Callees**：`flash.utils.describeType`、`Loader.loadBytes`、`ApplicationDomain.currentDomain`、`GameData.I.config.soundVolume`。

## 命名备注

保留 **`initalize`**（少 z，与 `MainGame`/`KeyBoarder`/`GameKeyInput`/`EffectCtrl` 同一错法）。

两层资源不要混：

```
ZIP (ZipCtrler / ZipAssetLoader)  →  fighter / map / XML / BGM / effect.swf
ResUtils 8 UI SWF                 →  菜单、选人、HUD、logo、gameover
```

`InsSwf` 是 **脚本级（package 外）** 类，不是 `ResUtils` 的 inner class 语法，但只本文件可见。

## 8 个 SWF Class 字段（L27–41）

`describeType(this).variable` 只扫 **实例 public 变量**，即下面 8 个。静态 `SETTING` 等字符串不是 Class，不会被 load。

| 字段 | 嵌入 Class（FFDec `$` 哈希；含 `-` 的用 `§` 包起来） |
|------|------|
| `common_ui` | `common_ui_swf$a3bf7921c1ba01403bf4dfe7a7fe5c9e1164926403` |
| `fight` | `fight_swf$9ccdf9d2a37e1fb6b6f0df6717a547941873914523` |
| `gameover` | `gameover_swf$284eb874265c7eb53b81fbe601ecf04c-712060857` |
| `howtoplay` | `howtoplay_swf$d10d084cfcec7c2d33e8c028a67fd274-539314070` |
| `loading` | `loading_swf$7f39eada5ad885643203a9108b753eb3-531490057` |
| `select` | `select_swf$f2bee00124a9f488c4c58f35b18af2d9-2023338167` |
| `setting` | `setting_swf$4adf08ab3774d57fd0d989297cc4a7d7-103244389` |
| `title` | `title_swf$528f79a0143139adcd9aaf069b4879b7-1105035181` |

全部是 main.swf 里 CWS15 嵌套 SWF（DefineBinaryData）。链接名见 `reverse/04-maps-ui-xml.md`。

静态字符串（L15–25）：`SETTING` `stg_set_ui`、`CONGRATULATIONS` `mc_congratulations`、`WINNER` `winner_stg_mc`、`TITLE` `stg_title`、`GAME_OVER` `stg_gameover_mc`、`SELECT` `stg_select`。

## 逐行说明

### 单例 `I`（L58–65）

懒创建 `_i`。

### `initalize`（L67–99）—— 启动闸

`param1` 成功、`param2` 失败。

1. `_initing` 真 → `throw "正在初始化过程中，不能再次初始化！"`。
2. `_inited` 真 → 若有 callback 立刻调并 return（可重入，不再 load）。
3. **先** `_inited = true` **再** `_initing = true`。失败抛错时 `_inited` 已真、`_initing` 可能仍真，状态会脏。?
4. `new Dictionary()` 当 `_swfPool`；记下两个 callback。
5. `describeType(this)` 遍历 `.variable`：
   - `_loc8_` = 字段名（`common_ui` 等）
   - `_loc3_` = `this[_loc8_]`（Class）
   - `new InsSwf(_loc3_)`，挂 `ready=swfReadyBack`、`error=swfErrorBack`
   - `_swfPool[Class] = InsSwf`

8 个 Loader 并行 `loadBytes`。没有进度回调。`MainGame` 的 loading 条要等这批完成才出现（`resInitBack` 才 `goStage(GameLoadingState)`）。

### `swfReadyBack`（L101–111）

任一 `InsSwf` complete 就进来。扫池：还有 `!isReady` 则 return。全好才 `finish()`。

### `swfErrorBack`（L113–119）

只调 `_initError()`，**丢掉** `param1` 错误字符串。不把失败的 `isReady` 置位，也不清 `_initing`。若 `InsSwf` 构造里 `throw`，本回调会先跑再把 `initalize` 炸掉。

### `finish`（L121–129）

`_initing = false`（`_inited` 已在开始时为 true）。调 `_initBack` 后置 null。`_initError` 不清。

### `createDisplayObject`（L131–150）

`getItemClass(swfClass, linkageName)` → `new`。若是 `Sprite`：拷 `soundTransform`，`volume = GameData.I.config.soundVolume` 写回（UI 里嵌的帧音效跟全局音量）。否则原样返回（可能是 Bitmap / 其它）。找不到 Class 时函数无 `return`，得 `undefined`。

### `createBitmapData`（L152–160）

`new Cls(width, height)`，即 `BitmapData` 导出类的标准构造。失败 Class 空 → `null`。`CongratulateState` / `CreditsState` 用 `common_ui` 的 `"cover_bgimg"` 铺 800×600。

### `getItemClass`（L162–174）

`_swfPool` 空 → `throw "未进行初始化！"`。该 SWF Class 不在池 → `throw "swf is undefined!"`。否则 `InsSwf.getClass(name)` → `_domain.getDefinition`。

---

## 脚本级 `InsSwf`（L185–231）

一个嵌入 SWF Class 的 Loader 包装。

### 字段

`_swf` 嵌入实例；`_domain` complete 后才有；`isReady`；`ready`/`error` 回调。

### 构造（L198–213）

1. `new param1()` 得到嵌入资源对象。
2. `_swf.movieClipData` 当 `ByteArray`（Flex/Flash `[Embed]` SWF 的典型属性）。没有 → `error("未发现swf的movieClipData!")` **并且** `throw`。
3. `Loader` + `contentLoaderInfo.complete`（weak ref `true`）。
4. `LoaderContext(false, ApplicationDomain.currentDomain)`：`checkPolicyFile=false`，**并入当前域**（UI 类名可直接当 AS 类型用，如 `mc_congratulations`）。
5. `allowCodeImport = true`（loadBytes 带 ABC 必需，否则 Flash 抛 SecurityError）。
6. `loadBytes(_loc2_, ctx)`。

无 `ioError` 监听。损坏的嵌套 SWF 会挂死 `_initing`。?

### `getClass`（L215–218）

`_domain.getDefinition(param1) as Class`。缺定义抛 `ReferenceError`（不 catch）。

### `loadComplete`（L220–230）

记下 `applicationDomain`，`isReady=true`，调 `ready(this)` 后置 null。
