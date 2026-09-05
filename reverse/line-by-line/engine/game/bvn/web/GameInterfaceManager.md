# `GameInterfaceManager` — 网页包的 `IGameInterface`

一句话目的：`bleachvsnaruto.initlize` 赋给 `GameInterface.instance`。存档、菜单插 RANK、键盘输入、制作组文案、4399 more/rank/score。localhost 才听 `5d_message`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/web/GameInterfaceManager.as`（174 行）

## Callers / callees

- **Callers**：`bleachvsnaruto.initlize` `GameInterface.instance = new GameInterfaceManager()`。之后引擎只经 `GameInterface.instance`：
  - `MenuBtnGroup.build` → `getGameMenu`（空则回落 `getDefaultMenu`）
  - `SetBtnGroup.initMainBtns` → `getSettingMenu`（本实现 null → 用内置按键菜单）
  - `GameInputer.initInput` → `getGameInput("MENU"|"P1"|"P2")`；`updateConfig` → `updateInputConfig`
  - `GameData.saveData/loadData` → `saveGame` / `loadGame`
  - `ConfigVO` 构造 → `getConfigExtend`；`applyConfig` → `applyConfig`
  - `MenuState.build` → `initTitleUI`
  - `GameCtrl` 开战 → `afterBuildGame`
  - `CreditsState` → `getCreadits`
  - `MainGame.moreGames/submitScore/showRank`；`WinnerState` 也直接 `moreGames`
- **Callees**：`LocalConnection.domain`、`KyoSharedObject`、`GameKeyInput`、`GameInterface.getDefaultMenu`、`Ctrler4399.showRank`、`GameLogic.setGameMode`、`bleachvsnaruto.serviceHold` / `STAGE`、`MainGame.I.stage` DataEvent。

## 命名备注

保留 **`getCreadits`**（Credits 少 e），接口 `IGameInterface` 同样拼错。

`5d_message` 是 play5d 本地包装页协议，不是 4399 官方。壳侧 `LocalConnection` 是另一条（`com.green` overlay），不要混。

`getFighterCtrl` **不在** `IGameInterface` 里，是本类多出来的方法，本包无人调。

## 逐行说明

### 构造（L24–31）

```
new LocalConnection().domain == String.fromCharCode(108,111,99,97,108,104,111,115,116)
```

即 `"localhost"`（charCode 拆开避免明文）。匹配则 `bleachvsnaruto.STAGE.addEventListener("5d_message", messageHandler)`。

浏览器里 HTTP 的 127.0.0.1 **不是** 字符串 `localhost`，这条不挂。独立播放器 / `file:` / 部分 Ruffle 本地才是 `localhost`。`new LocalConnection()` 只为读 domain，不 connect。

### `initTitleUI`（L33–36）

空。`MenuState` 仍会把 `stg_title` 传进来。渠道可在此改标题层（加 Logo/广告）。

### `moreGames`（L37–45）

有 `serviceHold` → `showGameList()`。无论有无 Hold，都向 `MainGame.I.stage` 派 `DataEvent("5d_message", JSON.stringify(["more_games"]))`。本地包装页可听这条打开外链。

### `submitScore`（L47–54）

`serviceHold.showRefer(param1)`。无 Hold 空操作。`MainGame.submitScore` 传入 `GameData.I.score`。结束按钮不走这里。

### `showRank`（L56–63）

`serviceHold.showSort()`。菜单 RANK 走的是 `Ctrler4399.showRank`，不是本方法；效果相同。

### `saveGame` / `loadGame`（L65–79）

`KyoSharedObject.save/load("bvn3_save")`。save 会 `trace("saveData", JSON.stringify)`；load 有数据才 trace。`GameData` 还要求对象 `id == "bvn3.01"`，否则当没存档。Ruffle 的 SharedObject 路径依实现，可能每次空。

### `getFighterCtrl`（L81–84）

恒 `null`。给扩展手柄/录像用的 `IFighterActionCtrl` 洞，网页包不用。

### `getGameMenu`（L86–96）

`getDefaultMenu()` 默认树：小队 / 单人 / OPTION / TRAINING / CREDITS / MORE GAMES。

```
slice(0,4)  → TEAM, SINGLE, OPTION, TRAINING
push RANK   → func = Ctrler4399.showRank，cn「排行榜」
concat(splice(4)) → CREDITS, MORE GAMES
```

`splice(4)` 会改 `_loc2_` 原数组，但 `getDefaultMenu` 每次 new，无副作用。RANK 插在练习和制作组之间。

### `getSettingMenu`（L98–101）

`null` → `SetBtnGroup` 用内置 P1/P2 按键 + 画质等。

### `getGameInput`（L103–108）

**忽略** `param1`（`GameInputType.MENU/P1/P2`）。每次 `new Vector` + `push(new GameKeyInput())`。三路都是键盘，靠 `KeyConfigVO` 不同键位区分 P1/P2。没有摇杆实现。

### `getConfigExtend`（L110–113）

`null`。`ConfigVO.extendConfig` 因此为空，设置页无扩展项。

### `afterBuildGame`（L115–118）

空。`GameCtrl` 建完战斗仍会调。

### `messageHandler`（L119–128）

`JSON.parse(event.data)`，`trace("receive message", _loc2_[0])`。仅当 `_loc2_[0] == "games_inited"` 才给 STAGE 加 `keyUp` → `keyHandler`。

`games_inited` 由 `bleachvsnaruto.etHandler` 在 `isInTop` 通过后派到 `MainGame.I.stage`。本监听挂在 `bleachvsnaruto.STAGE`（同一 stage），所以能收到。

其它 payload（`go_menu_stage`、`more_games`、`game_resume`、`select_fighter`）这里只 trace，给外部包装。

### `keyHandler`（L130–140）

只在 localhost + 已 `games_inited` 后生效：

| 组合 | 键码 | 行为 |
|------|------|------|
| Ctrl+F8 | 119 | `GameLogic.setGameMode(1)` → `salect.xml` + `winner_stg_mc2` + `SelectIndexUI.SHOW_MODE=1`（旧 3.2 格子） |
| Ctrl+F9 | 120 | `setGameMode(0)` → `select.xml` + `winner_stg_mc` + `SHOW_MODE=0`（3.3 默认） |

不 `preventDefault`。两条 `if` 独立，可连按。

### `updateInputConfig`（L142–145）

`false` → `GameInputer.updateConfig` 继续用 `key_menu/key_p1/key_p2`。

### `applyConfig`（L147–149）

空。`ConfigVO.applyConfig` 自己改 FPS/画质后再调这里给渠道挂钩。

### `getCreadits`（L151–170）

在传入 HTML 后追加：

- `游戏出品：5dplay<br/>`
- `发布支持：GreenHD<br/>`

黄字（`0xFFFF00`）微软雅黑 20px、leading 15、multiline、`autoSize=left`，放在 `(50,30)` 的 Sprite 里返回。`CreditsState` 若收到 null 会走 `getDefaultCredits`；本实现总是返回 Sprite。
