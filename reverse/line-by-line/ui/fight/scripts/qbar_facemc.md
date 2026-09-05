# `qbar_facemc` — 辅助脸槽（不是出战角色）

一句话目的：气条侧面的脸坑。`ct` 是容器；引擎把辅助 `Assister.data` 的 50×50 脸塞进去。跟血条 `hpbar_facemc` 不是同一张图。

源文件：`decompiled/ui/fight/scripts/qbar_facemc.as`（16 行）

## 如何挂上引擎

[`qbar_mc.facemc`](qbar_mc.md)。[`QiBar.setFighter(fighter, assister)`](../../../engine/game/bvn/ui/fight/QiBar.md)：有 `param2.data` 才 `AssetManager.I.getFighterFace(assister.data)`（默认 50×50）→ **`facemc.ct.addChild`**。没辅助 / 没图就算了。

对照血条 [`hpbar_facemc`](hpbar_facemc.md)：那边走 `getFighterFaceBar`（102×64），是**出战**角色。本槽永远是辅助。

`setFighter` 每次 `ct.addChild` **不**清旧孩子。`resetFight` 再 `initlize` 会叠一张。BITMAP 则 `KyoUtils.drawDisplay(facemc)` 烤成 `_faceBp`，旧脸还在子树里一起被烤进去。?

BITMAP：脸 Bitmap 按 `facemc` 的 x/y 放到 `qbar_mc` 上，try `removeChild(facemc)`，再 `addChild(readymc)` 保证 ready 在脸之上。

`setCacheBitmap`：非 BITMAP 才把本 MC `cacheAsBitmap` 打开（淡入完成）或关掉（动画中）。

P2 `setDirect` **不**翻脸——`fzqi2` SWF 已镜像。

## 逐行说明

- **L5** `symbol="symbol72"`。
- **L6** `public dynamic class qbar_facemc extends MovieClip`。
- **L9 `ct`**：`MovieClip`。唯一公开槽。引擎只往这里加脸。
- **L11–14 构造**：只 `super()`。无帧脚本。
