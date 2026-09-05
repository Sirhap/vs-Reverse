# `SettingState` — 设置页（setting_swf + IInnerSetUI）

一句话目的：主菜单 OPTION。主列表改 `ConfigVO`，P1/P2 KEY SET 滑入 `IInnerSetUI`（本包是 `SetCtrlBtnUI`），APPLY 存档并回菜单。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/SettingState.as`（178 行）

## Callers / callees

- **Callers**：`MainGame.goOption()` → `goStage(new SettingState())` + `setFPS(30)`。来自 `MenuBtnGroup` `"OPTION"`。
- **Callees**：`ResUtils.I.setting`（`setting_swf`，导出名 `ResUtils.SETTING` = `"stg_set_ui"`）；`SetBtnGroup.initMainSet` / `initScroll`；`SetBtnEvent`；`ConfigVO.setValueByKey`；`SetCtrlBtnUI`（ui，实现 `IInnerSetUI`）；`TweenLite`；`SoundCtrl.BGM("back")`；APPLY 时 `GameData.saveData` / `config.applyConfig` / `GameInputer.updateConfig` / `MainGame.goMenu`。
- **主列表默认项**（`SetBtnGroup.initMainBtns`，`getSettingMenu()` 本包返回 null 时）：P1/P2 KEY SET、COM LEVEL（`AI_level`）、OPERATE MODE（`keyInputMode`）、LIFE（`fighterHP`）、TIME（`fightTime`）、SOUND / BGM 音量、QUALITY，末尾硬加 `"APPLY"`。键名字段在 UI 里拼成 `optoinKey`。

## 命名备注

- `destory` / `destoryInnerSetUI` 拼写保留。
- `IInnerSetUI`：`fadIn` / `fadOut` / `getUI` / `destory` + 派发 `"APPLY_SET"` / `"CANCEL_SET"`。
- `stg_set_ui.ichigo`：一护立绘 MC，切按键页播 `"key_fadin"` / `"key_fadout"`。
- `innerSetHandler(param1:String)`：反编译把监听参数标成 String，运行时实际是 `SetBtnEvent`；函数体不用该参数。

## 逐行说明

### 字段 / 构造（L24–35）

- `_ui:stg_set_ui`
- `_btnGroup`：主设置列表
- `_innerSetUI`：内页（按键设置）
- `_man`：`_ui.ichigo`
- 构造空。

### `display`（L37–40）

返回 `_ui`。

### `build`（L42–56）

1. 取出 `stg_set_ui`。
2. `new SetBtnGroup()`：`startY=30`，`endY=550`，`gap=70`。
3. `initMainSet()`：建主按钮、箭头、`GameRender` + 开输入。
4. `initScroll(GAME_SIZE.x, 600)`：竖向 scrollRect。
5. 听 `"SELECT"` → `onBtnSelect`；`"OPTION_CHANGE"` → `onOptionChange`。
6. `_ui.addChild(_btnGroup)`；`_man = _ui.ichigo`。
7. BGM `"back"`。

### `onOptionChange`（L58–62）

`GameData.I.config.setValueByKey(optionKey, optionValue)`。音量键会立刻 `SoundCtrl.setBgmVolumn` / `setSoundVolumn`；画质等要等 APPLY 的 `applyConfig`。

### `onBtnSelect`（L64–80）

按 `selectedLabel`：

- `"P1 KEY SET"` → `goKeyConfig(1, key_p1)`
- `"P2 KEY SET"` → `goKeyConfig(2, key_p2)`
- `"APPLY"`：`saveData()`（`GameInterface.saveGame`，本包 SharedObject `"bvn3_save"`）→ `config.applyConfig()`（画质/FPS 等）→ `GameInputer.updateConfig()` → `goMenu()`。

无主页 CANCEL；不点 APPLY 直接离开会丢未保存项，但 OPTION_CHANGE 已写进内存 `ConfigVO`，只是没 save / apply。? 切走 `destory` 不回滚。

### `goKeyConfig`（L82–87）

`new SetCtrlBtnUI()`，`setKey(KeyConfigVO)`（内部 clone 到临时表），再 `goInnerSetPage`。`param1` 玩家号本函数未用。

### `goInnerSetPage`（L89–108）

公开，可供其它 `IInnerSetUI` 接入（本包只有按键页）。

1. `destoryInnerSetUI()` 清旧页。
2. 听 `"APPLY_SET"` / `"CANCEL_SET"` → `innerSetHandler`。
3. `_ui.addChild(innerUI.getUI())`；`fadIn()`。
4. 主列表 `TweenLite` 0.2s 移到 `y = -GAME_SIZE.y`，完成后 `visible=false`。
5. `_btnGroup.keyEnable = false`（防底下列表抢键）。
6. `_man.gotoAndPlay("key_fadin")`。

### `destoryInnerSetUI`（L110–126）

有内页则 try `removeChild(getUI())`，卸两事件，`destory()`，置空。

### `goMainSetting`（L128–147）

从内页回到主列表：列表 `visible=true`，0.1s 后再 0.2s tween `y=0`，完成时 `keyEnable=true`。内页 `fadOut` 并卸监听，**不** `destoryInnerSetUI`（残留在显示列表直到下次进入或整个 Setting destory）。`_man.gotoAndPlay("key_fadout")`。

### `innerSetHandler`（L149–152）

APPLY/CANCEL 都只 `goMainSetting()`。真正写回 `KeyConfigVO` 在 `SetCtrlBtnUI` 派 APPLY 之前。

### `afterBuild`（L154–156）

空。

### `destory`（L158–175）

卸主列表（removeChild / 两事件 / destory），再 `destoryInnerSetUI()`。不停 BGM（下个状态会换）。不调 `param1`。
