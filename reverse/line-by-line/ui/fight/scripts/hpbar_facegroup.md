# `hpbar_facegroup` — 一侧三槽头像

一句话目的：出战大脸 + 两名候补。SWF 三个 `hpbar_facemc` 槽；谁在大槽由当前出战角色决定。

源文件：`decompiled/ui/fight/scripts/hpbar_facegroup.as`（21 行）

## 如何挂上引擎

[`hpbar_mc.face1` / `face2`](hpbar_mc.md)。[`FightBar`](../../../engine/game/bvn/ui/fight/FightBar.md) `new FightFaceGroup(_ui.face1/face2)`；P2 `setDirect(-1)`。

[`FightFaceGroup`](../../../engine/game/bvn/ui/fight/FightFaceGroup.md)：

| 实例 | 槽 |
|---|---|
| `face` | 出战大脸 → `_face1` |
| `face2` | 候补 1（SWF 更小）→ `_face2` |
| `face3` | 候补 2 → `_face3` |

`setFighter(GameRunFighterGroup)`：`currentFighter==fighter1` 则候补是 2/3；`fighter2` 则候补只剩 3；`fighter3` 两大槽都 `setData(null)` 隐藏。单挑只有 `fighter1` 时 `face2`/`face3` 藏。

BITMAP：脸留在 `hpbar_mc` 子树，烤进 FightBar 底图；`setFighter` 后 `updateBitmap()`。`cacheAsBitmap` 由引擎在 group 上开关，不是本 AS。

`FightFaceUI.setDirect` 空函数。P2 镜像靠 SWF 里 `face2` 组已 `scaleX=-1` / 右对齐。?

## 逐行说明

- **L5** `symbol="symbol118"`。
- **L6** `public dynamic class hpbar_facegroup extends MovieClip`。
- **L9 `face`**：[`hpbar_facemc`](hpbar_facemc.md)。出战大槽。
- **L11 `face2`**：同类型。候补槽 1。
- **L13 `face3`**：候补槽 2。
- **L15–18 构造**：只 `super()`。无帧脚本。槽位规则全在引擎。
