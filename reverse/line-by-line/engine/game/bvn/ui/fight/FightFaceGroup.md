# `FightFaceGroup` — 一侧三槽头像（出战大脸 + 两名候补）

一句话目的：包 `hpbar_facegroup`。`face`/`face2`/`face3` 各一个 `FightFaceUI`。按 `GameRunFighterGroup.currentFighter` 决定谁在大槽、候补怎么排。P2 `setDirect(-1)` 会转发，但 `FightFaceUI.setDirect` 是空函数。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightFaceGroup.as`（64 行）

## Callers / callees

- **Callers**：只 `FightBar`。构造 `new FightFaceGroup(_ui.face1/face2)`；P2 `setDirect(-1)`；`setFighter(group)` 在 `FightBar.setFighter` / `FightUI.initlize` / 下一回合 `resetFight`。
- **Callees**：`FightFaceUI.setData(FighterVO|null)` / `setDirect`。

## 槽位规则

`hpbar_facegroup`：`face` 出战，`face2`/`face3` 候补（SWF 更小）。

`switch(currentFighter)` 用的是**引用相等**：

| current | face（大） | face2 | face3 |
|---|---|---|---|
| `fighter1` | fighter1 | fighter2 或藏 | fighter3 或藏 |
| `fighter2` | fighter2 | fighter3 或藏 | 藏 |
| `fighter3` | fighter3 | 藏 | 藏 |
| 其它 / null | 见下 | | |

`currentFighter` 为 null：第一个 `if(currentFighter)` 跳过 `face1.setData`，但 `switch(null)` 进 default——**什么都不做**，三张脸保持上一回合。随后 `cacheAsBitmap=true`。?

单挑只有 `fighter1`：face2/face3 `setData(null)` 隐藏。组队三人死一个换 `fighter2` 时，大脸换成 2，候补只剩 3。

## 命名备注

- **没有** `destory`。
- `_ui.cacheAsBitmap=true` 构造就开；`setFighter` 先关再开，避免换脸过程中缓存脏图。BITMAP 总 HUD 还会再 `updateBitmap` 拍一次（脸仍在 `hpbar_mc` 子树里）。
- `setDirect` 三个都转——最终空操作。P2 镜像靠 `face2` 元件在 SWF 里已经 scaleX=-1 / 右对齐布局。?
- `setData` 不清旧 `ct` 孩子，换人叠脸。见 `FightFaceUI.md`。

## 逐行说明

### 字段 / 构造（L9–25）

`_ui=hpbar_facegroup`，立刻 `cacheAsBitmap=true`。三个 `FightFaceUI` 绑 `face` / `face2` / `face3`（类型 `hpbar_facemc`）。

### `ui` getter（L27–30）

返回 group MC。`FightBar` 不把它加入 BITMAP `_children`（脸烤进底图）。

### `setFighter`（L32–54）

`param1` 默认 null，但立刻读 `param1.currentFighter`——`FightBar` 只在 `if(param1)` 里调，不会传 null。

1. `cacheAsBitmap=false`。
2. 有 current → `_face1.setData(current.data)`。
3. `switch(currentFighter)` 三分支如上；`fighter2`/`fighter3` 缺席用 `? : null`。
4. `cacheAsBitmap=true`。

`current` 不是 1/2/3 任一引用（? 不应发生）则只更新了大脸、候补不动。

### `setDirect`（L56–61）

三个 `FightFaceUI.setDirect(param1)`。全部空实现。P2 仍调用以备将来翻脸。
