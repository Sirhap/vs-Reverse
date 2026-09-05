# `GameData` — 全局存档与选人状态单例

一句话目的：进程内唯一的玩家数据。持有 `config`、双方 `SelectVO`、当前地图、街机分数和胜者 id。启动 `loadData` 只恢复设置；`loadConfig` 串行拉五张 XML 配表。分数和选人**不写存档**。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/GameData.as`（150 行）

## Callers / callees

- **Callers**：
  - `MainGame.initlize`：`loadData()` 再 `config.applyConfig()`。通关 `submitScore(score)`。
  - `GameLoadingState.loadPreloadBack`：`loadConfig(loadConfigBack, loadConfigFail)`。
  - `SettingState` APPLY：`saveData()`。
  - `SelectFighterStage`：读写 `p1Select`/`p2Select`、读 `config.select_config`。
  - `LoadingState`：用双方 SelectVO 排队加载角色/辅助，用地图 id `selectMap`。
  - `MapSelectUI.select`：写 `selectMap`。
  - `MessionModel`：街机把敌方/地图写进 `p2Select`/`selectMap`；`reset` 清 `score`。
  - `GameCtrl.fightFinish` 街机下一关：`winnerId = p1 当前角色 data.id`。
  - `WinnerState`：`winnerId` 取脸、`score` 上屏。
  - `CongratulateState` / `GameOverState` / `FightUI` / `Ctrler4399`：读 `score`。
  - `GameLogic`：加减分、HP 倍率、`loadSelect("salect.xml"|"select.xml")`。
  - `MenuState`：`isFristRun` 弹更新说明。
  - `GameInputer` / `GameState` / `MapMain` / 若干 UI：经 `config` 读音量/画质/键位。
- **Callees**：`ConfigVO`、`AssetManager.loadXML`、`FighterModel`/`AssisterModel`/`MapModel`/`MessionModel`、`GameInterface.saveGame`/`loadGame`、`Debugger.log`。

## 命名备注

- `isFristRun`：first 的原拼写。只活在内存，存档不带。
- `SAVE_ID = "bvn3.01"`：存档对象里的版本字段，不是游戏 3.3。SharedObject 槽名是壳里的 `"bvn3_save"`。
- `fuzhu` 在 `SelectVO` 上，本文件不出现。
- `loadMession*`：mission 的原拼写。失败回调文案和地图失败串串了。

## 逐行说明

### 字段（L10–26）

- `_i`：懒单例。
- `config`：构造即 `new ConfigVO()`（此时已套默认键位）。
- `p1Select` / `p2Select`：`SelectVO`，选人阶段才 `new`。街机 `initMession` 会 `p2Select ||= new SelectVO()` 后覆写敌方。
- `selectMap`：地图 id 字符串。VS 来自选地图 UI；街机来自当前 `MessionStageVO.map`。
- `score = 0`：街机分。`GameLogic.addScore*` 改它；`MessionModel.reset` 清零。不进存档。
- `winnerId`：街机过关进 `WinnerState` 时写入的 P1 当前角色 id，结算脸图用。
- `isFristRun = true`：本次进程第一次进主菜单。`MenuState` 弹 `UPDATE_INFO` 后置 false。
- `SAVE_ID`：私有 const `"bvn3.01"`。`saveData`/`loadData` 都写死字面量，不读这个字段名（编译期内联）。

### 构造 / `I`（L28–40）

空构造。`I` 首次访问 `new GameData()`。

### `loadConfig`（L42–112）

`param1` = 成功回调（无参），`param2` = 失败回调（一条中文原因，可空）。`GameLoadingState` 传入。

五段串行，全走 `AssetManager.I.loadXML`。成功回调在 `AssetLoader` 里是 `new XML(text)`，在 `ZipAssetLoader` 里直接是 ZIP 里的 XML。

| 顺序 | URL | 成功 | 失败 log / fail() |
|------|-----|------|-------------------|
| 1 | `assets/config/fighter.xml` | `FighterModel.I.initByXML` | 「读取人物数据出错」 |
| 2 | `assets/config/assist.xml` | `AssisterModel.I.initByXML` | 「读取辅助角色数据出错」 |
| 3 | `assets/config/select.xml` | `config.select_config.setByXML` | 「读取选人场景数据出错」 |
| 4 | `assets/config/map.xml` | `MapModel.I.initByXML` | 「读取地图场景数据出错」 |
| 5 | `assets/config/mission.xml` | `MessionModel.I.initByXML(new XML(param1))` | Debugger「读取头卡数据出错」；**fail 却传「读取地图场景数据出错」**（复制粘贴） |

`loadMessionBack` 参数被反编译成 `String`，再 `new XML(param1)`。实际 loader 给的已是 XML，`new XML(xml)` 仍可用。

任一段失败：`Debugger.log` 中文，若 `fail != null` 再调。不继续后续 XML。全部成功才 `back()`。`GameLoadingState` 成功后再 `AssetManager.loadBasic`（音效/effect.swf/字体/脸图）。

### `saveData`（L114–120）

`{id:"bvn3.01", config: config.toSaveObj()}` → `GameInterface.instance.saveGame`。网页实现 `KyoSharedObject.save("bvn3_save", obj)`。只存设置，不含 score/选人/关卡进度。

### `loadData`（L122–130）

`MainGame.initlize` 在 `loadConfig` **之前**调用（配表还没来）。`loadGame()` 空或 `id != "bvn3.01"` 直接 return，保留构造默认。否则 `config.readSaveObj(_loc1_.config)`。**不** `applyConfig`——调用方下一步才 apply。旧版存档会被丢弃。

### `loadSelect`（L132–142）

`param1` = XML URL。成功闭包 `setSelectData`；失败只 `trace("loadSelect error!")`，不走 `Debugger`、不抛。`GameLogic.setGameMode(1)` 拉 `assets/config/salect.xml`（文件名原拼写），否则拉回 `select.xml`。覆盖当前 `select_config`，给隐藏选人表用。

### `setSelectData`（L144–147）

`config.select_config.setByXML(param1)`。`loadConfig` 第三段和 `loadSelect` 都汇到这里。
