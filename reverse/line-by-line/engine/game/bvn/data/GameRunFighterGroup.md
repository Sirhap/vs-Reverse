# `GameRunFighterGroup` — 一方三个角色槽 + 辅助

一句话目的：P1 或 P2 在本局的出战编制。最多 `fighter1/2/3` 加一个 `fuzhu`，`currentFighter` 是场上那个。换人按 1→2→3 线性推进，不循环。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/GameRunFighterGroup.as`（102 行）

## Callers / callees

- **Callers**：
  - `GameRunDataVO`：const `p1FighterGroup` / `p2FighterGroup`。
  - `LoadingState.gotoGame`：按出战顺序写入三个槽，`currentFighter = fighter1`。辅助在加载队列里直接 `gameRunData[group]["fuzhu"] = Assister`。
  - `GameCtrl`：`initFight`/`resetFight` 把两组交给 `GameState`；`nextFighter(group)` 换人；`destory` 时 `p1.destoryFighters(continueLoser)`、`p2.destoryFighters(null)`。
  - `FighterEventCtrl.addAssister`：按 team 取组，拿出 `fuzhu`。
  - `GameState.initFight` / `resetFight`、`GameUI.initFight`、`FightUI.initlize`、`FightBar.setFighter`、`FightFaceGroup.setFighter`：读 `currentFighter` 和三个槽做血条/脸。
- **Callees**：`FighterMain.destory(true)`、`Assister.destory(true)`。`getFighterDatas` 返回 `FighterVO` 向量。

## 命名备注

- `destory` / `destoryFighters`：全工程拼写。
- `fuzhu`：辅助。与 `SelectVO.fuzhu`（id 字符串）对应；本组存的是已实例化的 `Assister`。
- 单挑只填 `fighter1`，2/3 保持 null。`getNextFighter` 对 null 下一槽照样返回（可能是 null）。

## 逐行说明

### 字段（L9–17）

`fighter1/2/3`：最多三人。`fuzhu`：该队辅助，整场共用，换人不换辅助。`currentFighter`：场上那位，开局 = `fighter1`。

### 构造（L19–22）

空。

### `getFighterDatas`（L24–31）

非空槽的 `.data`（`FighterVO`）推进 `Vector`。短路 `fighterN && push`。decompiled 内**无调用方**（? 可能给外部/调试，或死代码）。

### `getNextFighter`（L33–44）

按 **对象引用** 比 `currentFighter`：

| 当前 | 返回 |
|------|------|
| `fighter1` | `fighter2`（可 null） |
| `fighter2` | `fighter3`（可 null） |
| 其它（含 `fighter3`、已 destory 成 null） | `null` |

不循环、不跳过空槽。组队三人：1 死换 2，2 死换 3，3 死 `nextFighter` 失败 → 整队败。平局时 `startNextTeamFight` 两边都问 next，都没有则当还能继续（双方同尽）。

### `destoryFighters`（L46–61）

`param1` = 要**保留**的 `FighterMain`（街机 continue 的败者）；不相等的槽才 `disposeFighter`。然后**总是** `disposeFuzhu()`——continue 也不留辅助，下场加载会再 new。

`param1 == null`（P2 或非 continue）三人全毁。

### `removeCurrentFighter`（L63–66）

`disposeFighter(currentFighter)`。`GameCtrl.nextFighter` 在 `removeFighter`（移出场景）之后调，再把 `currentFighter` 指到下一位。

### `disposeFighter`（L68–90）私有

null 直接 return。若正是 `currentFighter` 先把该字段置 null。然后 `param1.destory(true)`（卸 MC）。switch 把对应槽置 null：`fighter1` 分支 `return`，2/3 `break`——效果一样。

不把已 destory 的对象从 `fighterN` 以外的地方摘掉；调用方需保证不再持有。

### `disposeFuzhu`（L92–99）私有

`fuzhu != null` 则 `destory(true)` 并置 null。`FighterEventCtrl` 上场的是同一实例，场上未收回就 destory 会把显示对象拆掉（`GameCtrl.destory` 时对局已结束）。
