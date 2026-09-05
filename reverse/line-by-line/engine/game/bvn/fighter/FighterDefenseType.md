# `FighterDefenseType` — 防御姿态：剑挡 / 手挡

一句话目的：角色 SWF 初始化写 `$fighter_ctrler.defenseType = 0|1` 的字典。引擎 **零引用本类**，只认 `FighterMain.defenseType` 整型。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterDefenseType.as`（16 行）

## Callers / callees

- **本类常量**：decompiled 主包与 fighter 时间轴均 **不 import**。时间轴写数字：剑士/拔刀类多为 `0`，拳脚/忍者多为 `1`（例：`kenshin`→0，`neji`/`uryuu`/`itachi`→1）。
- **运行时字段**：`FighterMain.defenseType` 默认 0；`FighterCtrler` 的 getter/setter 转给它。受击/防御动画选型读这个 int（`FighterMcCtrler` / `FighterMC`）。
- **Callees**：无。

## 命名备注

`SWOARD` = sword 的原拼写，保留。

## 逐行说明

### 常量（L6–8）

- `SWOARD = 0`：剑挡。
- `HAND = 1`：手挡。

### 空构造（L10–13）

全静态。存在只为给时间轴作者对照；编译进主 SWF 但无引用，可能 DCE 未删。
