# `MenuState` — 主菜单（title SWF + MenuBtnGroup）

一句话目的：片头之后的主菜单。播 `title_swf` 的 `stg_title`，任意键/点击后淡入 `MenuBtnGroup`（菜单数据来自 `GameInterface.getGameMenu` / `getDefaultMenu`）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/MenuState.as`（143 行）

## Callers / callees

- **Callers**：`MainGame.goMenu()` → `goStage(new MenuState())` + `resetDefault()` + `setFPS(30)` + 派发 `5d_message` `["go_menu_stage"]`。来源：`LogoState.playComplete`、`SettingState` APPLY、`CreditsState` BACK、`LoadingState`/`SelectFighterStage`/`WinnerState` 的 `GameUI.confrim("BACK TITLE?")`、`PauseDialog`。
- **Callees**：`ResUtils`（`title` SWF，导出名 `ResUtils.TITLE` = `"stg_title"`）；`GameInterface.instance.initTitleUI`（本包 `GameInterfaceManager` 空实现）；`SoundCtrl.BGM("op")`；`GameInputer`；`GameRender.add/remove`；`MenuBtnGroup`（ui 包，不在本批）；`UIUtils.formatText`；`GameUI.alert`。
- **菜单出口（MenuBtnGroup.getFucByLabel，非本文件）**：闯关 `goHowToPlay` 或 `goSelect`；对战/练习 `goSelect`；`OPTION` → `goOption`；`CREDITS` → `goCredits`；`MORE GAMES` → `moreGames`。本包 `getGameMenu` 还插入 `RANK`。

## 命名备注

- 类 **extends Sprite** 却实现 `Istage.display` 返回 `_ui` 而不是 `this`。`goStage` 加到舞台的是 title MC，`MenuState` 实例本身不上屏。
- `destory` 拼写保留。`GameData.isFristRun`（Frist 不是 First）。
- 版本字面量 `"V3.3-REV"` 与 `MainGame.VERSION` 同文，此处硬编码。
- `stg_title` 时间轴：帧 50 / 帧 75 各 `stop` + `COMPLETE`；本类不听 complete，只 `gotoAndStop(1)` / `gotoAndPlay(2)` / `gotoAndPlay("menu")`。

## 逐行说明

### 字段 / 构造（L25–33）

- `_ui`：title 根 MC。
- `_btnGroup`：`showBtns` 才创建。
- `_versionTxt`：右下角版本。
- 构造只 `super()`。

### `display`（L35–38）

返回 `_ui`。

### `build`（L40–47）

1. `createDisplayObject(title, TITLE)` → `stg_title`。
2. `gotoAndStop(1)`（片头停在第一帧）。
3. `initTitleUI(_ui)`：平台钩子，本包空。
4. `GameInputer.enabled = false`：等 `afterBuild` 的 500ms 后再开。
5. `SoundCtrl.I.BGM(AssetManager.I.getSound("op"))`：主菜单 BGM。

### `afterBuild`（L49–83）

1. `gotoAndPlay(2)` 播 title 入场。
2. **500ms 后**：`buttonMode/useHandCursor`；`TOUCH_MODE` 听 `"touchTap"` 否则 `"click"` → `showBtns`；`GameRender.add(render)`；`GameInputer.focus()` + `enabled = true`。
3. 立即建版本 `TextField`：黑字 18px，`"V3.3-REV"`，贴在 `GAME_SIZE` 右下（-15, -10），`addChild` 到 `_ui`。
4. 若 `GameData.I.isFristRun && MainGame.UPDATE_INFO`：清 `isFristRun`，`GameUI.alert("UPDATE", UPDATE_INFO)`。`UPDATE_INFO` 由壳 `bleachvsnaruto_2.buildGame` 在首次默认配置时写入 3.3 更新说明。

### `render`（L85–91）

`GameInputer.anyKey(1)`（MENU 组 anyKey，参数 1 = 刚按下）→ `showBtns()`。与点击同一入口。

### `showBtns`（L93–123）

`... rest` 兼容 MouseEvent / TouchEvent / 无参。

1. 卸 click/touchTap；`GameRender.remove(render)`；关手型。
2. `_ui.gotoAndPlay("menu")`：切到菜单段。
3. `SoundCtrl.I.playSwcSound(snd_menu5)`：嵌入 `snd_menu5.mp3`。
4. `new MenuBtnGroup()`，先 `enabled=false`，坐标 (470, 100)。
5. 优先挂到 `_ui` 子级 `"btnct"`（`stg_title.btnct`）；没有则直接 `_ui.addChild`。
6. `_btnGroup.build()`：读 `GameInterface.instance.getGameMenu()`，空则 `GameInterface.getDefaultMenu()`（TEAM/SINGLE/OPTION/TRAINING/CREDITS/MORE GAMES）。
7. `fadIn(0.2, 0.04)` 逐钮弹出；400ms 后 `enabled = true`。

### `destory`（L125–140）

有 `_btnGroup` 则 try `parent.removeChild`，再 `destory()` 置空。最后 `GameInputer.enabled = false`。

缺口：若 500ms 定时器尚未触发就切走，`render` 可能稍后才 `add`；若已 `add` 但还没 `showBtns`，这里也不 `GameRender.remove(render)`。正常路径只能从菜单钮离开，此时 render 已卸。不调 `param1`。
