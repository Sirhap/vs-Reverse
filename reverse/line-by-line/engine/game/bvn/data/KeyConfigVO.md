# `KeyConfigVO` — 一套键位（菜单 / P1 / P2）

一句话目的：10 个功能键的 keyCode + 菜单「确认」键数组。`ConfigVO` 持有三份（id 0/1/2）；`GameKeyInput.setConfig` 用它查按下。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/KeyConfigVO.as`（78 行）

## Callers / callees

- **创建**：`ConfigVO` 字段 `key_menu(0)` / `key_p1(1)` / `key_p2(2)`，构造里 `setDefaultConfig`。
- **读**：`GameKeyInput` 方向与 `attack/jump/dash/skill/superKill/beckons`；`select()` 扫 `selects`。
- **改**：`SettingState` → `SetCtrlBtnUI.setKey`（先 `clone` 成临时，确认再写回）。`HowToPlayState` 把 keyCode 显示成字。
- **存档**：`toSaveObj` / `readSaveObj` 经 `ConfigVO` ↔ `GameData` SharedObject。`id` 不进存档。
- **Callees**：`KyoUtils.itemToObject` / `setValueByObject`。

## 命名备注

- `superKill` 字段 ↔ `GameKeyInput.superSkill()` 方法。
- `beckons` = 召唤/特殊键 ↔ `IGameInput.special` / `assist` / `specailSkill`。
- `setKeys` 里 `this.dash = param7` **写了两次**（L47 与 L49），无功能影响。

默认键见 `ConfigVO.setDefaultConfig`：

| id | 方向 | 攻/跳/冲/技能/必/召 |
|----|------|---------------------|
| 0 菜单 / 1 P1 | WASD | J K L U I O；菜单 `selects` 另写成这 6 键 |
| 2 P2 | 方向键 | 小键盘 1–6（97–102） |

P1 `setKeys` 在 `selects` 为空时只设 `[attack]`（J）。菜单 id=0 在 setKeys 后再覆盖 `selects`。

## 逐行说明

### 字段（L8–30）

`id` 区分三套。十个 `uint` 键码。`selects:Array` 菜单确认键列表。

### 构造（L32–36）

只写 `id`。键码 0 直到 `setKeys` / `readSaveObj`。

### `setKeys`（L38–55）

10 个 uint：up, down, left, right, attack, jump, dash, skill, superKill, beckons。若 `selects` 已有（读档后）则不改；否则 `selects = [attack]`。

### `toSaveObj`（L57–62）

反射全部可枚举字段成 Object，`delete id`（读回时靠构造传入的 id）。

### `readSaveObj`（L64–67）

`KyoUtils.setValueByObject(this, obj)` 按同名字段覆盖，包括 `selects`。

### `clone`（L69–75）

`new KeyConfigVO(id)` + `readSaveObj(toSaveObj())`。设置界面改键用副本，取消则丢。
