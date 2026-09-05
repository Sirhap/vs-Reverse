# `interfaces.IGameInterface` — 渠道/平台适配钩子

一句话目的：把 4399 排行、存档、菜单裁剪、制作组页、输入设备从核心逻辑里抽出去。本包唯一实现 `web.GameInterfaceManager`，由 `GameInterface.instance` 持有。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IGameInterface.as`（40 行）

## Callers / callees

- **Implementor**：`GameInterfaceManager`。`bleachvsnaruto_2` 赋给 `GameInterface.instance`。
- **GIM 本包行为摘要**（实现细节不在本文件）：`initTitleUI` 空；`moreGames` → Hold.showGameList + `5d_message`；`submitScore` → Hold.showRefer；`showRank` → Hold.showSort；`saveGame/loadGame` → `KyoSharedObject` `"bvn3_save"`；`getGameInput` 忽略 type，总 `new GameKeyInput()`；`getGameMenu` = 默认树插入 RANK；`getSettingMenu` null（设置页用内置列表）；`updateInputConfig` false；`getConfigExtend` null；`afterBuildGame` 空；`applyConfig` 空；`getCreadits` 拼 5dplay/GreenHD HTML。
- **Callees 类型**：`DisplayObject`、`Sprite`、`ConfigVO`、`IGameInput`、`IExtendConfig`。

## 命名备注

`getCreadits` 拼写错误（Credits），`CreditsState` 与 GIM 均沿用。

## 逐行说明

### 标题 / 渠道页（L11–17）

- `initTitleUI(DisplayObject)`：标题 MC 建好后。本包空。其它渠道可挂 logo/广告。
- `moreGames()`：主菜单 MORE GAMES、Winner 页。4399 游戏列表。
- `showRank()`：`MainGame.showRank`；菜单 RANK 的 `func` 直接调 `Ctrler4399.showRank`，不一定走本方法。
- `submitScore(int)`：`MainGame.submitScore` 传 `GameData.I.score`。

### 存档（L19–21）

- `saveGame(Object)`：`GameData.saveData` 传入 `{id:"bvn3.01", config:ConfigVO.toSaveObj()}`。
- `loadGame():Object`：`GameData.loadData` 要求 `id=="bvn3.01"` 才 `config.readSaveObj`。null 或 id 不符则用默认键位。

### 输入 / 菜单（L23–29）

- `getGameInput(String):Vector.<IGameInput>`：参数 `"MENU"|"P1"|"P2"`。null 时 `GameInputer` 自己 new 键盘。本包 GIM 不返回 null，但 **不区分 type**（三通道三个独立键盘实例，配置后才分化）。
- `getGameMenu():Array`：主菜单。null → `GameInterface.getDefaultMenu()`。
- `getSettingMenu():Array`：设置页按钮。null → `SetBtnGroup` 内置 P1/P2 KEY SET、画质、音量等。
- `updateInputConfig():Boolean`：true = 「我已经把输入配置写进 IGameInput，`GameInputer` 别再用 `key_menu/p1/p2`」。本包 false。

### 扩展 / 建局（L31–35）

- `getConfigExtend():IExtendConfig`：本包 null。
- `afterBuildGame()`：`GameCtrl.buildGame` 末尾，角色已入场。本包空。
- `applyConfig(ConfigVO)`：`ConfigVO.applyConfig` 设完画质/FPS 后。本包空（音量在 ConfigVO 里直接 `SoundCtrl`）。

### `getCreadits`（L37）

`(htmlPrefix):Sprite`。`CreditsState` 先拼制作人员 HTML，再交给平台追加出品方。返回 null 则 `CreditsState.getDefaultCredits`。本包 GIM 追加「游戏出品：5dplay」「发布支持：GreenHD」，黄字微软雅黑 TextField。
