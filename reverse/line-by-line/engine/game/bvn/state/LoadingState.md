# `LoadingState` — 选人后战前加载（角色/辅助/地图 SWF）

一句话目的：选人结束到开打之间的加载屏。按 `SelectVO` 排队 `GameLoader` 拉 6 角色 + 2 辅助 + 地图 + 可选 BGM；同时 `SelectIndexUI` 让玩家排出场顺序。两边都完且 `AUTO_START_GAME` 才 `gotoGame` → `transIn(goGame)`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/LoadingState.as`（398 行）

## Callers / callees

- **Callers**：`MainGame.loadGame()` → `new LoadingState()` + `stageCtrl.goStage(_loc1_, true)`（**sameChange=true**，允许替换另一座 LoadingState）+ `setFPS(30)`。来自 `SelectFighterStage.goLoadGame`（`StateCtrl.transIn(MainGame.I.loadGame)`）以及 `WinnerState` 再战。
- **Callees**：`GameLoader.loadFighter/loadAssister/loadMap`（各 SWF → `FighterMain` / `Assister` / `MapMain`）；`SoundCtrl.loadFightBGM`；`FighterModel.getFighter`；`MapModel.getMap`；`GameCtrl.I.gameRunData`（`p1FighterGroup` / `p2FighterGroup` / `map`）；`SelectIndexUI`（ui.select）；`StateCtrl.transIn/transOut`；`GameUI.confrim` / `closeConfrim`；`Debugger.errorMsg`；`TweenLite`；舞台 `DataEvent("5d_message")`：`loading_start` / `loading_finish`。
- **后续**：`gotoGame` → `StateCtrl.I.transIn(MainGame.I.goGame, false)`。`goGame` 再 `goStage(GameState)` + `GameCtrl.startGame`，转场 UI 不自动摘（`removeAfterComplete=false`）。`afterBuild` 里 `transOut` 解开选人进来时的黑场。

## 命名备注

- `destory` / `GameUI.confrim` / `closeConfrim` 拼写保留。
- `fuzhu`：辅助。`runobj.group` 是 `"p1FighterGroup"` 字符串，用 `gameRunData[group][id]` 动态赋值。
- `AUTO_START_GAME`：默认 true；`MainGame.goMenu.resetDefault` 写回 true。本包无其它写入。false 时 `finish()` 不自动开打，留给外部 `gotoGame`。
- `p1SelectFinish` / `p2SelectFinish` / `selectFinish` / `getSort` / `setOrder` / 公开 `gotoGame`：本包 **无调用者**，像联机钩子残留。
- `_currentLoadBack` + `loadFighterComplete`：队列项从不设 `.back`，`loadFighterComplete` 也无人调用，死代码。
- 队列闭包用 `param2`（`customBackParam`）取 p1/p2，不捕获循环变量 `o`，安全。

## 逐行说明

### 静态 / 字段 / 构造（L34–61）

- `AUTO_START_GAME`：见上。
- `_ui:loading_fight_mc`（子级 `sltui:loading_select_ui_mc`，其下 `bar:loadingbar_mc`）。
- `_sltUI`：选人/进度条层，`loadFin` 会 tween 它的 y。
- `_loadQueue`：`{msg, func, params}` 先进先出。
- `_curMsg` / `_loadCount`：进度文字。
- `_destoryed`：`finish` 守卫。
- `_loadFin`：队列空且入场 tween+2s 之后才 true。
- `_selectIndexUI`：出场顺序 UI。
- `_loadedFighterCache`：键 `"p1_"+fighterId` / `"p2_"+fighterId`。
- `_currentLoadBack`：未使用。
- `_gameFinished`：防 `gotoGame` 重入。
- 构造空。

### `display`（L64–67）

返回 `_ui`。

### `p1SelectFinish` / `p2SelectFinish` / `selectFinish`（L68–81）

转给 `_selectIndexUI.p1Finish/p2Finish/isFinish`。本包无调用。

### `getSort`（L83–86）

`[P1Order, P2Order]`。本包无调用。

### `setOrder`（L88–98）

`param1==1` 设 P1 顺序，`==2` 设 P2。两个 if 独立（不是 else if）。本包无调用。

### `build`（L100–239）

顺序：

1. `stage.dispatchEvent(DataEvent("5d_message", … JSON ["loading_start"]))`。
2. `GameRender.add(render)`；`GameInputer.focus()` + `enabled=true`。
3. BGM `"loading"`。
4. 建 `loading_fight_mc`；`_sltUI = _ui.sltui`。
5. `new SelectIndexUI()`，`onFinish = finish`，addChild 到 `_sltUI`。
   - `SelectIndexUI.initSelect` 按 `GameMode.currentMode`：10 小队闯关 P1 手选 + P2 `autoSelect`；11 双人手选；12 对 CPU 则 P1 完再让 P1 键选 P2；其它模式（单人/练习等）两边直接 `isFinish=true`。
6. 读 `GameData.I.p1Select` / `p2Select`。
7. **fighters 队列**（最多 6）：每项 `{id, runobj:{id:"p1"|"p2"}}`。`id` 空则跳过（单人只有 1 人）。有 `FighterVO` 则用 `name` 作文案，若 `fighter.bgm` 则推进 `fightBGMs` `{id, url, rate}`。`func=GameLoader.loadFighter`，params：`[id, complete, loadFail, loadProcess, runobj]`。complete：`cacheFighter(fighter, "p1"|"p2", fighter.data.id)` 再 `loadNext()`。
8. **assisters**（2）：`runobj={group:"p1FighterGroup"|"p2FighterGroup", id:"fuzhu"}`。名字来自 `FighterModel.getFighter`（辅助也在 Fighter 表里查展示名；真正 SWF 走 `AssisterModel`）。complete：`GameCtrl.I.gameRunData[group]["fuzhu"] = Assister` 再 `loadNext()`。
9. **map**：`MapModel.getMap(selectMap)` 取显示名。`GameLoader.loadMap`。complete：若 `map.data.bgm` 则 `fightBGMs.push({id:"map", url, rate:1})`；`gameRunData.map = MapMain`；`loadNext()`。地图加载 **没有** `loadProcess`（params 只到 fail）。
10. **BGM**：仅当 **build 当下** `fightBGMs.length > 0`（已收集到角色 BGM）才入队 `SoundCtrl.I.loadFightBGM`。地图 BGM 在 map 回调里 push 进**同一数组**；因为 map 排在 BGM 之前，角色 BGM 存在时地图曲会一起加载。若没有任何角色 BGM，地图曲 **不会** 入队。?
11. `_loadCount = queue.length`；`setTimeout(loadNext, 1000)` 等 1 秒再开始（给 UI 入场）。

`var i:int` 未赋初值，AS3 默认 0，两段 while 可用。

### `render`（L241–254）

`GameInputer.back(1)`：若已有对话框 `GameUI.closeConfrim()`，否则 `GameUI.confrim("BACK TITLE?","返回到主菜单？", MainGame.I.goMenu)`。注意 `confrim` 拼写。确定后 `goMenu` 会 `destory` 本状态。

### `loadNext`（L256–267）

队列空 → `loadFin()` 返回。否则 `shift` 一项，`updateMsg(msg)`，`_currentLoadBack = item.back`（队列从不设 back，恒 undefined），`func.apply(null, params)` 启动加载。串行：上一项 complete 才 `loadNext`。

### `loadFighterComplete`（L269–277）

死代码。若被调用：有 `_currentLoadBack` 则先调再清空，然后 `loadNext()`。当前 fighter 回调已自己 `loadNext`，走这条会 **双跳** 队列。

### `loadFin`（L279–293）

队列完成：`TweenLite.to(_sltUI, 1, {y:80})`，tween 完再 `setTimeout(delayCall, 2000)`。`delayCall` 置 `_loadFin=true` 并 `finish()`。选人顺序 UI 上移，再等 2 秒。即使 `SelectIndexUI` 早已 finish，也要等这段延迟。

### `finish`（L295–317）

四道闸：

1. `_destoryed` → return（中途回菜单）。
2. `!_selectIndexUI.isFinish() || !_loadFin` → return。两边谁先到谁等。`SelectIndexUI.onSelectFinish` 在双方完成后再 `setTimeout(onFinish, 1000)`，因此顺序 UI 还多 1s。
3. `!AUTO_START_GAME` → return（外部应自己 `gotoGame`）。
4. `_gameFinished` → return。然后置 true，取 P1/P2 order，`gotoGame`。

### `gotoGame`（L319–333）

公开。

1. 取 `p1FighterGroup` / `p2FighterGroup`。
2. `fighter1/2/3 = getCacheFighter("p1"|"p2", order[0/1/2])`。order 来自 `SelectIndexUI.getP1Order`（角色 id 数组）。缺人（单人空槽）`param2==null` 则该槽 null。
3. `currentFighter = fighter1`。
4. 派 `5d_message` `["loading_finish"]`。
5. `StateCtrl.I.transIn(MainGame.I.goGame, false)`：黑场淡入，完成回调 `goGame`，转场层留下。

辅助已在 load 回调写入 group.fuzhu；此处不再动辅助。

### `getCacheFighter`（L335–348）

`id==null` → null。否则键 `side+"_"+fighterId`。cache 没有则 `throw new Error("未找到fighter:"+key)`。

### `cacheFighter`（L350–354）

`_loadedFighterCache[side+"_"+dataId] = FighterMain`。`dataId` 用 `param1.data.id`（VO id），与 order 里的选人 id 应对上。

### `loadFail`（L356–359）

`Debugger.errorMsg(param1)`。不 `loadNext`，队列卡住。不调 `_initFail` 一类的上层回调。

### `loadProcess`（L361–364）

`_sltUI.bar.bar.scaleX = progress`。只反映 **当前这一件** 的进度，不是总进度。地图项无 process。

### `updateMsg`（L366–374）

有新 msg 则更新 `_curMsg`。计数 `_loadCount - _loadQueue.length`：shift 之后 length 已减，所以第一件显示 `(1/N)`，最后一件开始时 `(N/N)`。格式 `_curMsg+"("+cur+"/"+_loadCount+")"` 写到 `_sltUI.bar.txt`。

### `afterBuild`（L376–379）

`StateCtrl.I.transOut()`：解开选人 `transIn(loadGame)` 留下的转场。默认 `removeAfterComplete=true`。

### `destory`（L381–395）

1. `_destoryed = true`（挡住后续 `finish`）。
2. `_selectIndexUI.destory()` 置空。
3. `BGM(null)`。
4. `_loadedFighterCache = null`；`_loadQueue = null`。
5. `GameInputer.clearInput()`；`GameRender.remove(render)`；`GameUI.closeConfrim()`。

不调 `param1`。**不取消** 进行中的 `GameLoader`。若 destory 发生在某 SWF complete 之前：fighter 回调 `cacheFighter` 会对 null 对象赋值抛错；assister/map 仍会写 `gameRunData`；`loadNext` → `loadFin` 的 TweenLite 仍可能打已摘掉的 `_sltUI`。`finish` 因 `_destoryed` 不会 `gotoGame`。?

回菜单后 `resetDefault` 会把 `AUTO_START_GAME` 设回 true。
