# `input.GameKeyInput` — 键盘版 `IGameInput`

一句话目的：把 `KeyBoarder` 的 keyDown/keyUp 记进 `_downKeys`，再按 `KeyConfigVO` 回答方向/攻击/跳/冲/技能/万解。MENU、P1、P2 各持有独立实例，但共享同一套舞台键盘事件。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/input/GameKeyInput.as`（155 行）

## Callers / callees

- **Callers**：`GameInputer.initInput` 在 `getGameInput` 返回空时 fallback `new GameKeyInput()`。`GameInterfaceManager.getGameInput` 无视 type，每个通道 `push(new GameKeyInput())`。
- **Callees**：`KeyBoarder.initlize/listen/focus`。`KeyConfigVO`（`setConfig` 强转）。实现 `IGameInput`。
- **不 unListen**：`destory` 不存在；三个实例的 `keyBoardHandler` 一直挂在 `KeyBoarder._keyHandlers`。

## 逐行说明

### 字段（L11–15）

- `_config:KeyConfigVO`：按键表。未 `setConfig` 前查方向会 NRE。
- `_downKeys:Object`：`keyCode → 1|0`。keyup 写 0 **不 delete**。`anyKey` 只认 `== 1`。
- `_enabled`：默认 true。

### 构造（L17–20）

空。

### `initlize`（L22–26）

`KeyBoarder.initlize(stage)`（已 init 则 no-op）+ `listen(keyBoardHandler)`。三通道会注册三个 handler，每条 KeyboardEvent 复制进三份 `_downKeys`。通道差异只在 `_config` 键码。

### `enabled` get/set（L28–36）

直通 `_enabled`。

### `setConfig`（L38–41）

`param1 as KeyConfigVO`。传入非 VO 则 `_config` 为 null，随后 `up()` 等会炸。

### `focus`（L43–46）

`KeyBoarder.focus()` → `stage.focus = stage`。

### `anyKey`（L48–58）

遍历 `_downKeys`，任一值为 1 即 true。菜单任意键；不区分 P1/P2 配置。

### `back`（L60–63）

`isDown(27)`。Esc 写死。菜单返回/暂停共用。

### `select`（L65–75）

`_config.selects` 任一 `isDown`。默认：MENU 是 J/K/L/U/I/O（`ConfigVO.setDefaultConfig` id=0 另写 `selects`）；P1/P2 仅 `[attack]`（`KeyConfigVO.setKeys` 在 `selects` 为空时用攻击键）。

### 方向 / 战斗（L77–125）

全部 `isDown(_config.xxx)`：

| 方法 | 配置字段 | 默认 P1 | 默认 P2 |
|------|----------|---------|---------|
| `up/down/left/right` | 同名 | WASD | 方向键 |
| `attack` | `attack` | J | 小键盘 1 (97) |
| `jump` | `jump` | K | 2 (98) |
| `dash` | `dash` | L | 3 (99) |
| `skill` | `skill` | U | 4 (100) |
| `superSkill` | `superKill` | I | 5 (101) |
| `special` | `beckons` | O | 6 (102) |

`superSkill` 方法名 ≠ 字段名 `superKill`。

### `wankai`（L127–130）

`attack` 与 `jump` **同时** `isDown`。`FighterKeyCtrl.waiKai*` 再叠加方向。

### `clear`（L132–135）

`_downKeys = {}`。不卸监听。切场景后残留 keyUp 仍会写 0 到新表。

### `keyBoardHandler`（L137–147）

`switch(type)`：`"keyDown"` → 1，`"keyUp"` → 0。其它 type 忽略。不 `preventDefault`。

### `isDown`（L149–152）

`_downKeys[code] == 1`。缺省/0 都是 false。
