# `CreditsState` — 制作组名单

一句话目的：主菜单 CREDITS。封面底图 + `GameInterface.getCreadits` 名单，底下 BACK 回菜单。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/state/CreditsState.as`（106 行）

## Callers / callees

- **Callers**：`MainGame.goCredits()` → `goStage(new CreditsState())` + `setFPS(30)`。来自 `MenuBtnGroup` `"CREDITS"`。
- **Callees**：`SoundCtrl.BGM("back")`；`ResUtils.createBitmapData(common_ui, "cover_bgimg", GAME_SIZE)`（PNG 约 804×604）；`GameInterface.instance.getCreadits`（接口拼写 **Creadits**）；本包 `GameInterfaceManager.getCreadits` 追加「游戏出品：5dplay / 发布支持：GreenHD」并自己建黄字 TextField，**不会返回 null**；`SetBtnGroup.setBtnData([{BACK}])`；BACK → `MainGame.goMenu()`。

## 命名备注

- `getCreadits` / `_createsSp`（creates 不是 credits）：源码拼写，保留。
- 接口 `IGameInterface.getCreadits(String):Sprite`。空实现才会落到 `getDefaultCredits`。
- `destory` 拼写保留。

## 逐行说明

### 字段 / 构造（L22–31）

- `_ui:Sprite`：本状态自己 new，不是 SWF 根。
- `_btngroup`：底部 BACK。
- `_createsSp`：名单 DisplayObject。
- 构造空。

### `display`（L33–36）

返回 `_ui`。

### `build`（L38–60）

1. BGM `"back"`。
2. `new Sprite()` 作根。
3. `cover_bgimg` BitmapData 铺满 `GAME_SIZE`，`addChild`。
4. `getCreditsText()` 得到 HTML 名单，交给 `getCreadits`。若返回 falsy 才 `getDefaultCredits`（本包走不到）。
5. `SetBtnGroup`：`y = GAME_SIZE.y - 150`，单钮 `"BACK"` / `"返回"`，听 `"SELECT"` → `selectBtnHandler`，addChild。

### `afterBuild`（L62–64）

空。

### `destory`（L66–74）

`_btngroup.destory()`，卸 SELECT，置空。不 removeChild 底图/名单。不停 BGM。不调 `param1`。

### `selectBtnHandler`（L76–79）

任意 SELECT（只有 BACK）→ `goMenu()`。不读 `selectedLabel`。

### `getCreditsText`（L81–84）

硬编码 HTML：设计/美术/研发/特效/人物制作 剑jian；人物制作多人；辅助 小海、主流；资源整理；测试策划；特殊贡献 灰原·银。用 `<br/>`。

### `getDefaultCredits`（L86–103）

平台没给名单时的黄字（16776960）微软雅黑 20px、leading 15、multiline htmlText，位置 (50, 30)。与 `GameInterfaceManager.getCreadits` 排版几乎相同，后者多两行出品信息。
