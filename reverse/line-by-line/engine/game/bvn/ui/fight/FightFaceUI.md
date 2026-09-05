# `FightFaceUI` — 单张血条头像

一句话目的：绑 `hpbar_facemc`。有 `FighterVO` 则 `visible=true` 并把 `AssetManager.getFighterFaceBar`（102×64）塞进 `ct`；null 则隐藏。`setDirect` 是**空函数**。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightFaceUI.as`（38 行）

## Callers / callees

- **Callers**：只 `FightFaceGroup`。三个槽各一个；`setFighter` → `setData`；`setDirect` 转发到这里后什么都不做。
- **Callees**：`AssetManager.I.getFighterFaceBar(FighterVO)`。读 `faceBarUrl`，默认尺寸 `Point(102, 64)`。辅助预载 **不**收 bar 图（`getFighterFaceUrls` 对 assister 两个 flag 都 false），本类也不给辅助用——辅助脸在 `QiBar` 走 `getFighterFace`（50×50）。

## 命名备注

- **没有** `destory`。
- `setDirect`（L33–36）函数体为空。P2 `FightFaceGroup.setDirect(-1)` 是空转。若 SWF 的 P2 `face2` 组未预先镜像，P2 头像会朝同一边。从布局看 `hpbar_mc.face2` 在右侧，很大概率美术已经翻好。?
- `setData` **从不 `removeChild`**。`ct.addChild` 每次叠加。`GameState.resetFight` → `initFight` → `setFighter` 每回合叠一张 Bitmap。同 id 换人看不出，三人组队换人会在大槽里堆旧脸（新的在最上面，旧的占 DisplayList / 内存）。BITMAP `updateBitmap` 会把整棵 `facemc` 画进去，多层仍只看见最上面。?
- `getFighterFaceBar` 失败（没预载）则只 `visible=true`、`ct` 空，露出 SWF 底图。
- `hpbar_facemc.ct` 是容器 MovieClip。

## 逐行说明

### 字段 / 构造（L9–16）

`_ui=hpbar_facemc`。不做 cache（group 层 `cacheAsBitmap`）。

### `setData`（L18–31）

- `!param1`：`visible=false` return。候补空槽走这里。
- 否则 `visible=true`，`getFighterFaceBar(param1)`，非 null 则 `_ui.ct.addChild`。

不比较「是不是同一 VO」，同一人再次 `setData` 也再 add 一张。

### `setDirect`（L33–36）

空。注释级：原本可能打算 `_ui.scaleX = param1>0 ? 1 : -1`（`EnergyBar.InsTxt` / `QiBar.InsBar` 就是这种），没写完。
