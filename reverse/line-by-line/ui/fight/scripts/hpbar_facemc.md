# `hpbar_facemc` — 单张血条头像槽

一句话目的：一个头像坑。`ct` 是容器；引擎把 102×64 的 bar 脸 Bitmap 塞进去。空槽则整块隐藏。

源文件：`decompiled/ui/fight/scripts/hpbar_facemc.as`（17 行）

## 如何挂上引擎

[`hpbar_facegroup.face` / `face2` / `face3`](hpbar_facegroup.md) 各一颗。[`FightFaceGroup`](../../../engine/game/bvn/ui/fight/FightFaceGroup.md) `new FightFaceUI` 绑本类。

[`FightFaceUI`](../../../engine/game/bvn/ui/fight/FightFaceUI.md) `setData(FighterVO|null)`：

- null → `_ui.visible=false`（候补空槽）。
- 有 VO → `visible=true`，`AssetManager.I.getFighterFaceBar`（默认 `Point(102,64)`）非 null 则 **`ct.addChild`**。从不 `removeChild`，换人叠脸。?
- `setDirect` **空函数**。P2 翻脸没写。

本类无 `destory`。脸图失败则 `ct` 空，露出 SWF 底图。

## 逐行说明

- **L5** `symbol="symbol117"`。
- **L6** `public dynamic class hpbar_facemc extends MovieClip`。
- **L9 `ct`**：`MovieClip`。唯一公开槽。引擎只往这里加 Bitmap，不改本 MC 的 `scaleX`。
- **L11–14 构造**：只 `super()`。无帧脚本。
