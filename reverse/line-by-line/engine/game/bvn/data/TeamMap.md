# `TeamMap` — 对局队伍字典（1/2）

一句话目的：`GameCtrl` 持有的 `id → TeamVO`。提供「我方」「敌方们」和用于双重循环的 `teams` 向量。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/TeamMap.as`（63 行）

## Callers / callees

- **持有**：`GameCtrl._teamMap` 字段 `new`，随单例活。
- **Callers**：
  - `GameCtrl`：`doStartGame`/`buildGame` 前 `_teamMap.clear()` 再 `add` 两队；`getTeam` / `getOtherTeams`（给 `FighterMain.targetTeams`）；`getEnemyTeam`。
  - `GameMainLogicCtrler.initlize` 注入，每帧扫 `teams`。
- **Callees**：`TeamVO`。

## 命名备注

`clear` **只清字典**，不直接清公开字段 `teams`。随后 `add` 会 `refreshTeams` 重建。若 clear 后、add 前有人读 `teams` 会看到上一场（本包无此窗口）。

`remove` 本包未见调用。

## 逐行说明

### 字段（L6–8）

- `teams`：`refreshTeams` 重建的值列表，顺序 = `for each`（Object 键序不保证，但只有 1/2）。
- `_teamObj`：`id → TeamVO`。

### 构造（L10–13）

空。`GameCtrl` 字段初始化一次，`destory` 不清掉这个实例。

### `clear`（L15–18）

`_teamObj = {}`。不 `teams = new`。

### `getTeam`（L20–23）

`_teamObj[id]`。未知 id → undefined。

### `getOtherTeams`（L25–36）

所有 `id != param1` 的队。两队时就是长度为 1 的 Vector。给角色 `targetTeams`。

### `add`（L38–42）

按 `param1.id` 放入（同 id 覆盖）+ `refreshTeams`。

### `remove`（L44–48）

`delete _teamObj[id]` + refresh。无引用。

### `refreshTeams`（L50–60）

新 Vector，把 `_teamObj` 里非空值 push。`clear` 不走这里。
