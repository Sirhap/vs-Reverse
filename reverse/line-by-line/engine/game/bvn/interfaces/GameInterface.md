# `interfaces.GameInterface` — 平台钩子入口 + 默认主菜单树

一句话目的：静态 `instance:IGameInterface` 由 `bleachvsnaruto` 赋成 `GameInterfaceManager`。`getDefaultMenu` 给出 TEAM/SINGLE/OPTION/TRAINING/CREDITS/MORE GAMES 树；网页版在其上插 RANK。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/GameInterface.as`（57 行）

## Callers / callees

- **instance 赋值**：`bleachvsnaruto_2.initlize`（L64）`GameInterface.instance = new GameInterfaceManager()`。必须在 `GameData`/`ConfigVO` 用到 `instance` 之前。
- **读 instance**：`GameInputer.initInput/updateConfig`；`MenuBtnGroup.build` → `getGameMenu`；`SetBtnGroup.initMainBtns` → `getSettingMenu`；`GameCtrl.buildGame` → `afterBuildGame`；`ConfigVO` 构造/`applyConfig`；`GameData.saveData/loadData`；`MainGame.moreGames/submitScore/showRank`；`MenuState.build` → `initTitleUI`；`WinnerState` → `moreGames`；`CreditsState` → `getCreadits`。
- **getDefaultMenu**：`MenuBtnGroup` 在 `getGameMenu()` 为 null 时 fallback。`GameInterfaceManager.getGameMenu` 先取默认树，前 4 项后插入 RANK，再拼回 CREDITS/MORE GAMES。
- **Callees**：无其它类。`instance` 类型是 `IGameInterface`。

## 命名备注

菜单文案 `TEAM ACRADE` / `SINGLE ACRADE` 保留原拼写（Arcade）。`getCreadits` 的拼写错误在接口侧，本类不声明该方法。

## 逐行说明

### `instance`（L6）

`public static var instance:IGameInterface`。未赋值时任何 `.instance.xxx` NRE。本包启动路径：壳 addChild `bleachvsnaruto` → `addedToStage` → 赋值 GIM → `buildGame` → `MainGame.initlize`。

### 构造（L8–11）

空。不需要实例；`instance` 存的是 GIM，不是 `GameInterface`。

### `getDefaultMenu`（L13–54）

返回 `Array` of `{txt, cn, children?}`。`MenuBtnGroup.addMenuBtn` 用 `txt` 当英文 label、`cn` 当中文。有 `children` 则进子菜单。本包默认：

1. **TEAM PLAY / 小队模式**
   - TEAM ACRADE / 闯关
   - TEAM VS PEOPLE / 2P 对战
   - TEAM VS CPU / 对战电脑
2. **SINGLE PLAY / 单人模式** — 同上三项，前缀 SINGLE
3. **OPTION / 游戏设置** — 无 children，进 `SettingState`
4. **TRAINING / 练习模式**
5. **CREDITS / 制作组**
6. **MORE GAMES / 更多游戏** — `MainGame.moreGames` → GIM → 4399 `showGameList` + `"5d_message"` `more_games`

无 `func` 字段；网页 RANK 项的 `func:Ctrler4399.showRank` 是 GIM 后加的，不在此树。无 HOW TO PLAY；该项若存在是别处加的。?
