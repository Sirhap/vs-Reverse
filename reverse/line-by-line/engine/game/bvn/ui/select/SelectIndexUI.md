# `SelectIndexUI` — 战前出战顺序（双方一组）

一句话目的：加载屏里给双方排出场顺序。左右各一块 `SelectIndexUIGroup`（人物竖条 + 辅助角标）。只在组队模式 10/11/12 真正让玩家选；单挑 / 生存 / 训练两边直接 `isFinish=true`。双方完成后延迟 1s 调 `onFinish`（`LoadingState.finish`）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectIndexUI.as`（193 行）

## Callers / callees

- **Callers**：只 `LoadingState.build`（L120–122）`new SelectIndexUI()`，`onFinish = finish`，`addChild` 到 `_sltUI`。公开钩子（本 SWF 无写入方，像联机）：
  - `p1SelectFinish` / `p2SelectFinish` / `selectFinish` → `p1Finish` / `p2Finish` / `isFinish`。
  - `getSort` → `[getP1Order(), getP2Order()]`。
  - `setOrder(player, ids)` → `setP1Order` / `setP2Order`。
  - `gotoGame` 读 `getP1Order` / `getP2Order` 把 cache 填进 `fighter1/2/3`。
- **Callees**：`SelectIndexUIGroup`、`GameData.I.p1Select/p2Select`、`GameMode.currentMode`、`ResUtils.I.select` → `"select_arrow_mc_1"` / `"select_arrow_mc_2"`（链接名也出现在 `loading` SWF；八 SWF 并入 `ApplicationDomain.currentDomain`，按名能取到）。
- **布局开关**：`GameLogic.setGameMode`（Ctrl+F8/F9）写静态 `SHOW_MODE`。1 = 旧 `salect.xml` 紧排；0 = 3.3 默认。
- **事件**：本类不 dispatch。组在 `selectFinish` 时发 `GameEvent "SELECT_FIGHTER_INDEX"`（payload = 该侧 id 数组）。本 SWF 无 listener。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | destroy 拼写。 |
| `SHOW_MODE` | 0 默认；1 旧版间距 / 0.85 缩放。不是 `GameMode.currentMode`。 |
| `fzx` | 辅助头像相对组的 x。组字段，本类按 P1/P2 写入。 |
| `onFinish` | 双方都 `isFinish` 后再 `setTimeout(..., 1000)` 调一次，然后置 null。 |
| `ACRADE` | 模式 10 走 P2 `autoSelect`，与 `GameMode.TEAM_ACRADE` 对应。 |

`currentMode - 10` 的 switch 只覆盖组队三档：

| `currentMode` | case | P1 | P2 |
|---|---|---|---|
| 10 TEAM ACRADE | 0 | 手选，键 `"P1"` | `autoSelect()` 随机顺序 |
| 11 TEAM VS PEOPLE | 1 | 手选 `"P1"` | 手选 `"P2"`，同时进行 |
| 12 TEAM VS CPU | 2 | 手选 `"P1"`，完了再 | 手选，键改成 `"P1"`（同一套键） |
| 20/21/22/30/40 及其它 | default | `isFinish=true` | `isFinish=true`（不建箭头、不 `setKey`） |

单挑只有 1 人，无需排序；生存 / 训练同样跳过。default 时 `onFinish` **不会**从本类触发（组从未 `selectFinish`）。`LoadingState.finish` 另有 `_loadFin` 闸，`isFinish()` 已 true 就能过。

## 逐行说明

### 包与 import（L1–9）

`Sprite` 子类。`setTimeout` 给双方完成的 1s 缓冲。无 Tween。

### 静态 / 字段（L13–20）

- `SHOW_MODE=0`。
- `onFinish`：外部灌。`LoadingState` 指到自己的 `finish`。
- `_p1Group` / `_p2Group`。

### 构造（L22–26）

`buildItems()` 再 `initSelect()`。构造结束时组已 `build`，模式 10/11/12 已挂箭头或 `autoSelect`。

### `getP1Order` / `getP2Order`（L29–37）

转 `SelectIndexUIGroup.getOrder()`：按 `seltwzmc` 序号排的 id 数组。default 模式从未 `setFighterIndex`，组内 index 全是 -1，`sortFighters` 把 -1 当 10，**保持 `build` 时的 fighter1→2→3 原序**。`gotoGame` 单挑也能用。

### `setP1Order` / `setP2Order`（L39–47）

转 `setOrder`：按外部 id 数组盖序号、摘箭头、`isFinish=true`。**不**发 `SELECT_FIGHTER_INDEX`，**不**调本类 `onFinish`。给 `AUTO_START_GAME=false` 时远端灌顺序。本包无调用。

### `p1Finish` / `p2Finish` / `isFinish`（L49–62）

读组 `isFinish`。`isFinish` 是两边 AND。default 模式构造后即 true。

### `destory`（L64–77）

两边 `destory` 置 null；`onFinish=null`（挡住已排队的 1s timeout：`delayCall` 开头查 null）。不 `removeChild` 自己。`LoadingState.destory` 调这里。

### `buildItems`（L79–109）

new 两个 `SelectIndexUIGroup`。

**`SHOW_MODE==1`**（旧格子）：

- P1 `x=35`，P2 `x=515`。
- `setFighterScale(0.85)` —— 此时 `_fighters` 还是 null。`setFighterScale` 先写 `_fighterScale` 再 `for each in _fighters`。AS3 `for each in null` 会 TypeError #1010。? Ctrl+F8 进加载屏可能炸；若运行时不抛，后面 `build` 仍按 0.85 缩放。
- `fighterOffset.x`：P1 `-5`，P2 `40`。
- `fzx`：P1 `-5`，P2 `0`。

**否则（默认 0）**：

- P1 `x=70`，P2 `x=480`。
- `fzx`：P1 `-30`，P2 `45`。
- 缩放保持 1，`fighterOffset` 仍 `(0,0)`。

两边 `y=85`。取类 `selected_item_p1_mc` / `selected_item_p2_mc`（和选人底部条同一套导出类），`build(cls, GameData.I.p*Select)`。`p2Select` 在街机人物阶段不建、由 `initMession` 灌；到 LoadingState 时已有。`addChild` 两组。

### `initSelect`（L111–133）

`switch (GameMode.currentMode - 10)`，无 break 漏到 default 的路径（每个 case 都 break）。

- **10**：`initP1Group()`（无参，P1 完直接 `onSelectFinish`）+ `initP2Group(null, true)`（`autoSelect`）。
- **11**：P1 手选 + P2 `"P2"` 手选，同时 `setKey`。
- **12**：`initP1Group(function(){ initP2Group("P1", false); })` —— P1 的 `onFinish` 先建 P2 再 `onSelectFinish`。VsCPU 串行，和选人阶段同一套 P1 键。
- **default**：两边 `isFinish=true`。组仍显示三人/一人 + 辅助，只是不能动。

### `initP1Group`（L135–154）

`createDisplayObject(..., "select_arrow_mc_1")`，`initArrow(arrow, Point(-10, 30))`（箭头相对第一格）。`setKey("P1")` 开始 `GameRender`。

有 `finishBack`（仅 mode 12）：包一层 `onFinish`，先 `finishBack()`（建 P2）再 `onSelectFinish()`，并把闭包里的 `finishBack` 置 null。无参则 `onFinish = onSelectFinish`。

### `initP2Group`（L156–169）

箭头 `"select_arrow_mc_2"`，偏移 `Point(260, 30)`（P2 卡片朝右，箭头在条右侧）。`param2==true` → `autoSelect()`（立刻 `selectFinish` → 本类 `onSelectFinish`，此时 P1 多半未完，函数空过）。否则 `setKey(param1)`（`"P2"` 或 `"P1"`）。`onFinish` 一律 `onSelectFinish`。

mode 10 传 `param1=null`，但 `autoSelect` 不用它。

### `onSelectFinish`（L171–190）

两边都 `isFinish` 且 `onFinish != null` 才 `setTimeout(delayCall, 1000)`。`delayCall` 再查一次 `onFinish`（destory / 重入），调完置 null。

一边完另一边未完：什么都不做，等下一次组回调。mode 12 的 P1 回调里已经先 `initP2Group`，所以第一次 `onSelectFinish` 时 P2 刚建、`isFinish` 仍 false。

1s 是给最后一次 `updateOrder` tween（0.2s）和角标留的余量。`LoadingState.finish` 还要等加载队列 + 上移 tween + 2s，两边谁慢谁等。
