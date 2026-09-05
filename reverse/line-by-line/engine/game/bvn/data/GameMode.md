# `GameMode` — 对局模式常量与查询

一句话目的：菜单写入的整型模式，加上五个静态查询。整包用它判断组队/单挑、人机、街机，从而决定选人数、P2 是否 AI、关卡表、加分。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/GameMode.as`（66 行）

## Callers / callees

- **写入 `currentMode`**：`MenuBtnGroup` 菜单项：10/11/12/20/21/22/30/40。本文件无 setter。
- **查询**：
  - `GameCtrl`：练习 `==40`；P2 是否 AI（`isVsCPU(false)` / `isAcrade`）；下一回合是否组队；胜负后走闯关/VS；`getTeams` 建队；`trace` 打 currentMode。
  - `GameEndCtrl`：组队或生存才换人。
  - `FighterEventCtrl`：街机且 P1 队才加分。
  - `GameLogic`：练习不死、组队首发加分、街机按关卡改 HP/攻击。
  - `MessionModel`：`isTeamMode` 选 comic 关卡表；`isAcrade` 才推进关。
  - `SelectFighterStage`：VS 人/CPU 才出 P2 选人；组队选 3 人。
  - `GameState`：街机 HUD。
  - `FightUI` / `SelectIndexUI`：街机分数、出战顺序 UI。
- **Callees**：无。

## 命名备注

- `TEAM_ACRADE` / `isAcrade`：arcade 的原拼写，全文保留。
- `SURVIVOR=30` 算 `isAcrade()`，不算 `isTeamMode()` / `isSingleMode()`。
- `isVsCPU` 默认把练习（40）也算 CPU；`GameCtrl.addFighter` 传 `false` 把练习排除。

## 逐行说明

### 常量（L6–20）

| 值 | 名 | 菜单语义 |
|----|----|----------|
| 10 | `TEAM_ACRADE` | 组队街机 |
| 11 | `TEAM_VS_PEOPLE` | 组队 1P vs 2P |
| 12 | `TEAM_VS_CPU` | 组队 vs CPU |
| 20 | `SINGLE_ACRADE` | 单人街机 |
| 21 | `SINGLE_VS_PEOPLE` | 单人 1P vs 2P |
| 22 | `SINGLE_VS_CPU` | 单人 vs CPU |
| 30 | `SURVIVOR` | 生存 |
| 40 | `TRAINING` | 练习 |

常量本身几乎不被引用；调用方写字面量 `10`/`40` 或走下面的 `is*`。

### `currentMode`（L22）

未赋默认值（AS3 int → 0）。0 会使所有 `is*` 为 false，直到菜单赋值。

### 空构造（L24–27）

全静态，外部不 `new`。

### `getTeams`（L29–38）

写死返回 `[{id:1,name:"P1"},{id:2,name:"P2"}]`。`GameCtrl` 建 `TeamVO` 用。没有第三队。

### `isTeamMode`（L40–43）

`10 \|\| 12 \|\| 11`。生存/练习/单挑都 false。组队选 3 人、下一回合换人依赖这个。

### `isSingleMode`（L45–48）

`20 \|\| 22 \|\| 21`。不含 30/40。

### `isVsPeople`（L50–53）

`11 \|\| 21`。选人出 P2、结束走 Winner 而非下一关。

### `isVsCPU`（L55–58）

`12 \|\| 22`，若 `param1`（默认 true）再或上 `==40`。练习的 P2 默认当 CPU；`GameCtrl` 传 `false` 时练习 P2 仍用键控。?

### `isAcrade`（L60–63）

`20 \|\| 10 \|\| 30`。含生存。VS 人/CPU、练习都 false。闯关 HP 倍率、加分、`MessionModel` 推进都看这个。
