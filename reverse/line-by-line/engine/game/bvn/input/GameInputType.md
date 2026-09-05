# `input.GameInputType` — 输入通道名（本包未引用）

一句话目的：`MENU` / `P1` / `P2` 三个字符串常量，数值与 `GameInputer._inputMap` 的 key 一致，但 **本仓库 `decompiled/main/scripts` 下没有任何 `GameInputType.xxx` 引用**。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/input/GameInputType.as`（18 行）

## Callers / callees

- **Callers**：grep 仅命中本文件。调用方一律写字面量 `"MENU"` / `"P1"` / `"P2"`（`GameInputer.initInput`、`FighterKeyCtrl.inputType`、`MenuBtnGroup`、`SetBtnGroup.gameInputType` 等）。
- **Callees**：无。

## 逐行说明

### 常量（L6–10）

三个 `public static const String`：

- `MENU`：菜单/暂停/选人共用通道。`anyKey` / `back` 固定走这条。
- `P1` / `P2`：1P / 2P 战斗与选人。`GameCtrl.addFighter` 把 `FighterKeyCtrl.inputType` 设成这两个字面量。

### 构造（L12–16）

空构造。只当常量命名空间，无需实例。
