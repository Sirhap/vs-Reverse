# `FightBar` — 顶部血条带（脸 / HP / 体力 / 计时 / 胜场 / 分数）

一句话目的：包住 `hpbar_mc`。P1 左、P2 右各一套 `FightFaceGroup` + `FighterHpBar` + `EnergyBar` + `WinUI`，正中 `FightTimeUI`，街机再挂 `FightScoreUI`。`GameUI.BITMAP_UI`（默认 true）时把装饰烘焙成一张 Bitmap，动态条子挪到 `ui_fight` 下。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightBar.as`（370 行）

## Callers / callees

- **Callers**：只 `FightUI`。构造 `new FightBar(ui.hpbarmc)`；`initlize` → `setFighter`；街机构造 → `initScore` + `setScore`；`render`/`renderAnimate`/`fadIn`/`fadOut`/`destory`；`showWins` → `showWin`。
- **Callees**：`FightFaceGroup`、`FighterHpBar`、`EnergyBar`、`FightTimeUI`、`FightScoreUI`、`WinUI`（`ui.WinUI`）、`GameUI.BITMAP_UI`。

## HUD 槽位（`hpbar_mc`，`decompiled/ui/fight/scripts/hpbar_mc.as`）

| 实例名 | 类 | 用途 |
|---|---|---|
| `face1` / `face2` | `hpbar_facegroup` | P1 / P2 三槽头像 |
| `bar1` / `bar2` | `hpbar_barmc` | HP 绿条+红拖尾 |
| `energy1` / `energy2` | `energy_bar` | 体力 `FighterMain.energy` |
| `timemc` | `time_mc` | 正中倒计时 /「无限」 |
| `win_p1` / `win_p2` | `winmc` | 胜场灯（死神/火影两套动画） |
| `scoremc` | `score_mc` | 街机分数，非街机隐藏 |

帧脚本：帧 1 `stop`；帧 25 / 46 `stop` + `Event.COMPLETE`（对应 `fadin_fin` / `fadout_fin` 一类标签）。`FightBar` 用标签名 `"fadin"` / `"fadin_fin"` / `"fadout"` / `"destory"`，具体帧号以 SWF 为准。

## 命名备注

- `destory` / `fadIn` / `fadOut`：原拼写。
- `_empytBd`：empty 的笔误，透明空 BitmapData，用来 `copyPixels` 清空再 `draw`。
- `BITMAP_UI`：`GameUI` 默认 true，本包无写入。**生产路径就是位图模式**。MC 淡入动画只在有人把 flag 扳 false 时才走。
- 位图模式把 `_ui`（`hpbar_mc`）从父级摘掉，装饰（脸、底图）画进 `_bp`；HP/体力/计时数字/胜场/分数作为独立 DisplayObject 加到原来的父级（`ui_fight`）。
- `setChildrenPosition` 在 `_ui` 已 `removeChild` 之后跑：子件 `parent` 仍是 `_ui`，while 遇 `_ui` 即停，只加 `_ui.x/y`，等于把局部坐标抬到 `ui_fight` 空间。
- `destory` **不**拆 `FightFaceGroup` / `FightTimeUI` / `FightScoreUI` / `WinUI`。位图模式只 `removeChild` `_children`。脸 Bitmap 随 `_ui` 一起丢掉。
- `initScore` 在 `FightUI` 构造、`FightBar` 构造**之后**调用。BITMAP 时 `scoremc` 已在 `_children` 里，只需 `new FightScoreUI`；非 BITMAP 才把 `scoremc.visible=true`。
- `WinUI`（`ui/WinUI.as`）：`show(FighterVO, wins)`。`wins-1`：0 用 `w1`（P1）或 `w2`（P2 的第一盏——team 参数把左右灯对调）；1 用另一盏。`comicType` 0 → `in_bleach`，1 → `in_naruto`。本类不 render WinUI，时间轴自己 `gotoAndPlay`。
- BITMAP `_children` 顺序（后加的在上）：hp1, hp2, energy1, energy2, **底图 `_bp`**, 计时数字, win1, win2, scoremc。底图夹在条子和灯/分之间，脸在图里、条子在图下、灯在图上。
- `_ui.width/height` 在 `fadin_fin` 上取样。若元件有滤镜/旋转，BitmapData 尺寸可能大于视觉，`getBounds` 补偿负坐标。
- 非 BITMAP 且未 `initScore`：`scoremc` 仍在 `hpbar_mc` 里只是 invisible。街机以外永远不 new `FightScoreUI`。

## 逐行说明

### 字段（L19–53）

- `_ui`：`hpbar_mc`。
- `_faceGroup1/2`：P2 构造里 `setDirect(-1)`（但 `FightFaceUI.setDirect` 是空函数，镜像靠 SWF 布局）。
- `_hpBar1/2`、`_energyBar1/2`：P2 体力 `setDirect(-1)` 翻文字。
- `_score`：仅街机 `initScore` 才 new。
- `_isFadIn`：当前是否处于「已显示」。`fadIn`/`fadOut` 的重入闸。
- `_timerMc`：总是创建。`gameTimeMax==-1` 时内部不建数字。
- `_winUI1/2`：`new WinUI(win_p1, 1)` / `(win_p2, 2)`，team 参数决定亮 `w1` 还是 `w2`。
- `_isRenderAnimate`：非 BITMAP 淡入/淡出期间才 true，让 `renderAnimate` `nextFrame()`。
- `_bp` / `_parent` / `_children` / `_drawMatrix` / `_empytBd`：BITMAP 专用。

### 构造（L55–79）

按上表 new 全套。P2 脸组、P2 体力条 `setDirect(-1)`。

- `BITMAP_UI` → `initBitmapUI()`。
- 否则 `_ui.scoremc.visible=false`（街机稍后 `initScore` 再打开）。

最后 `_ui.addEventListener("complete", uiPlayComplete)`。BITMAP 路径 `_ui` 停在 `fadin_fin` 且已离场，COMPLETE 基本不会再来（除非有人 `gotoAndStop` 播动画）。

### `ui` getter（L81–84）

返回 `_ui`。BITMAP 下 `_ui` 不在显示列表，外部若 addChild 这个会拿不到画面——`FightUI` 不读这个 getter。

### `initBitmapUI`（L86–119）

1. `_ui.gotoAndStop("fadin_fin")`：停在淡入完成帧，装饰是最终布局。
2. `_parent = _ui.parent`（即 `ui_fight`）。
3. `try _parent.removeChild(_ui)`。失败吞掉。
4. `_ui.getBounds(_ui)` → `_drawMatrix = (1,0,0,1, -bounds.x, -bounds.y)`，把可能有负坐标的内容画进 Bitmap 原点。
5. `_children = new Vector.<DisplayObject>()`。
6. `_bp = new Bitmap(new BitmapData(_ui.width, _ui.height, true, 0))`，放在 `bounds.x/y`（与矩阵补偿对上）。
7. `_empytBd` 同样尺寸的全透明板。
8. `addChildren` 顺序：hp1、hp2、energy1、energy2、`_bp`、（若有）`_timerMc.timeUI`、win1、win2、`scoremc`。`_bp` 插在条子和装饰数字之间，脸在图里、条子在图上。
9. `updateBitmap()` 拍第一张。
10. `setChildrenVisible(false)`：开场前整条 HUD 隐藏，等 `fadIn`。

`FightTimeUI.timeUI` 返回的是 **`MCNumber` 不是 `time_mc`**。无限时间 `_numMc==null`，不加入 `_children`；「无限」字样在 `timemc.wuxian` 里，已烘焙进 `_bp`。

### `setChildrenPosition`（L121–132）

从 `param1.parent` 往上爬，累加每个祖先的 x/y，直到碰到 `_ui` 或没有 parent。然后再加 `_ui.x/y`。调用时 `_ui` 已离场但子件仍 parent=`_ui`，所以循环体一次都不进，只加 `_ui` 自身位移。

若某子件已经被挪到 `_parent`（重复 addChildren）会把 `_parent` 链也累进去，本类没有这条路径。

### `addChildren`（L134–146）

先改坐标。`param2==-1`（默认）`_parent.addChild`，否则 `addChildAt`。push `_children`。本类全部走默认 -1。

### `setChildrenVisible`（L148–154）

`for each` 扫 `_children` 设 `visible`。BITMAP 的 fadIn/fadOut 只做这件事。

### `destory`（L156–209）

1. 卸 `"complete"`，`_ui.gotoAndStop("destory")`（SWF 清理帧，标签拼写同引擎），`_ui=null`。
2. 两条 HP、两条体力 `destory`。
3. `BITMAP_UI`：dispose `_bp.bitmapData` 和 `_empytBd`；try `removeChild` 每个 `_children`；null 向量 / matrix。

**不** destory：`_faceGroup*`、`_timerMc`、`_score`、`_winUI*`。`_isFadIn` 也不清。`FightUI.destory` 随后 `ui.removeChildren()`，BITMAP 子件已在 `_parent`=`ui_fight` 上，这一步会再摘一次（已摘过则空转）。

### `uiPlayComplete`（L211–221）

MC `COMPLETE`：`_isFadIn` 则 `visible=true`，否则 `false`。淡出动画结束把整条 `hpbar_mc` 藏掉。BITMAP 不用这条。

### `initScore`（L223–230）

非 BITMAP 才 `scoremc.visible=true`。`new FightScoreUI(_ui.scoremc)`。BITMAP 下 `scoremc` 已在 `_parent` 上且坐标已抬过，`FightScoreUI` 往 `scoremc.ct` 加 `MCNumber` 仍有效。

### `setScore`（L232–238）

`_score` 有则转发。非街机 `_score==null`，`FightUI.updateScore` 空操作。

### `showWin`（L240–264）

`!fighter` return。`param2`（胜场数）不在 0..2 也 return——**0 会通过**，但后面 `param2-1` 的 switch 只有 case 0/1（胜场 1/2），胜场 0 什么都不亮。`FightUI` 传 `getWins`，单挑赢一局=1、两局=2。

`fighter.team.id-1`：0→`_winUI1`，1→`_winUI2`。无 team 会 NPE。? 其它 id 的 switch 不赋 `_loc3_`，下一句 `if(!_loc3_) return`。

`WinUI.show(data, wins)`（`ui/WinUI.as` L26–53）：

- `wins==1`：team 1 播 `_ui.w1`，team 2 播 `_ui.w2`。
- `wins==2`：对调（team 1 的 `w2`，team 2 的 `w1`）。两盏灯是「第一胜 / 第二胜」，不是「左/右角色」。
- `comicType` 0/1 决定 `gotoAndPlay("in_bleach"|"in_naruto")`。其它 comicType 灯 MC 拿到了但不 play。

`FightUI.renderEnd` 只在 `isSingleMode` 调 `showWins`。组队/生存/练习赢了也不亮。BO3 先到 2 结束，所以 wins 只会是 1 然后 2。

### `setFighter`（L266–291）

`param1`/`param2` 默 null，有哪边刷哪边：

- `FightFaceGroup.setFighter(group)`：当前出战大脸 + 候补两张小脸。
- `currentFighter` 有则 HP/体力 `setFighter(current)`。组队换人后 `resetFight` → `initlize` → 这里换条绑定。

BITMAP 再 `updateBitmap()`：脸换了要重绘装饰层。条子本身是独立 DisplayObject，不在图里。

`currentFighter==null` 时 HP/体力条仍指向**上一场**角色（不 unset）。?

### `updateBitmap`（L292–296）

`copyPixels(_empytBd, 全图矩形, (0,0))` 清空，再 `draw(_ui, _drawMatrix)`。`_ui` 已离场但子树还在（HP/energy 被 `addChildren` 挪走了，**不会**画进图；脸还在 `_ui` 里）。每次 `setFighter` 拍一张静态底。

### `render`（L298–305）

每逻辑帧：两条 HP、两条体力、计时。**不** render 脸（静态）、WinUI（MC 自己 play）、Score（事件驱动）。无 null 护栏：构造后、`initlize` 前若 `GameUI.render` 已跑，HP/体力 `_fighter==null` 会 NPE。正常 `initFight` 在第一帧 render 之前。

### `fadIn`（L307–329）

已 `_isFadIn` 则 return（不能重播）。置 true。

- BITMAP：`setChildrenVisible(true)` 完事。
- 否则 `visible=true`；`param1` 真则 `gotoAndStop("fadin")` 并 `_isRenderAnimate=true`；假则直接 `"fadin_fin"`。

`FightUI.showStart` 默认 `param1=true`，但 BITMAP 下看不到淡入 MC。

### `fadOut`（L331–352）

未显示则 return。`_isFadIn=false`。

- BITMAP：`setChildrenVisible(false)`。
- 否则：`param1` 真 → `"fadout"` + 开动画；假 → `visible=false`（`GameEndCtrl.fadOut(false)`）。

### `renderAnimate`（L354–367）

`!_isRenderAnimate` return。当前标签是 `fadin_fin` 或 `fadout_fin` 则关闸 return（停在完成帧，等 COMPLETE 脚本把 visible 改掉——`fadin_fin` 的 COMPLETE 在帧 25 一带）。否则 `nextFrame()`。BITMAP 从不置 `_isRenderAnimate`，这条恒空。
