# `input.IGameInput` — 单路输入设备接口

一句话目的：键盘/手柄等设备的统一查询面。`GameInputer` 按通道持有 `Vector.<IGameInput>`，用方法名字符串动态 `apply`。本包唯一实现是 `GameKeyInput`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/input/IGameInput.as`（49 行）

## Callers / callees

- **Implementors**：`GameKeyInput`。`GameInterfaceManager.getGameInput` 也 `new GameKeyInput()`。
- **Holders**：`GameInputer._inputMap`；`IGameInterface.getGameInput` 返回 `Vector.<IGameInput>`。
- **Callees**：`flash.display.Stage`（`initlize` 参数）。

## 命名备注

`initlize` 拼写错误（initialize），全引擎同一错。`wankai` = 万解（攻击+跳）。`superSkill` 对应配置字段 `superKill`。`special` 对应 `beckons`（召唤）。

## 逐行说明

### 生命周期 / 配置（L8–16）

- `initlize(Stage)`：挂键盘（或其它）监听。`GameInputer.initlize` 经 `callVoid` 对 **所有通道** 各调一次。
- `setConfig(Object)`：实际是 `KeyConfigVO`。`GameInputer.updateConfig` 按 MENU/P1/P2 分别下发。
- `enabled` get/set：设备级开关。`GameInputer.call` 跳过 `enabled==false` 的项。本包未见写入 false（只用静态 `GameInputer.enabled`）。

### 焦点 / 任意键 / 菜单（L18–22）

- `focus()`：把 Stage 焦点抢回来（Flash 点到别的控件后按键会丢）。
- `anyKey()`：任意物理键按下（不看配置）。菜单「按任意键继续」。
- `back()`：实现里写死 ESC(27)，不是配置键。
- `select()`：确认。配置 `selects:Array` 里任一键。

### 方向（L24–30）

`up` / `down` / `left` / `right`：对应 `KeyConfigVO` 四方向。返回当前是否按住（不是 just-down；边沿由 `GameInputer` 做）。

### 战斗键（L32–46）

- `attack` / `jump` / `dash` / `skill`：普攻/跳/冲/技能。
- `superSkill`：必杀键。
- `special`：召唤/特殊。
- `wankai`：万解（实现 = attack ∧ jump 同时按住）。
- `clear()`：清按下表。切状态/结束对局时 `GameInputer.clearInput` 会 `callVoid("clear")`。
