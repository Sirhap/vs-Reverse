# `FighterAction` — 当前帧「能出什么招」的允许表

一句话目的：每个 `FighterMcCtrler` 持有一份。时间轴 `setXxx("帧名")` 把允许出的招写成 **MC 帧标签**；`render` 每逻辑帧先扣 CD，再按 `IFighterActionCtrl` 边沿决定是否 `goFrame`。状态布尔与落地/击中回调也挂在这里。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterAction.as`（177 行）

## Callers / callees

- **持有**：`FighterMcCtrler._action = new FighterAction()`（构造即建，整场不换）。
- **写字段**：`FighterMcCtrler` 的 `setMoveLeft` / `setAttack` / `setBisha` / `setWankai` / `setHitTarget` / `setHurtAction` / `setTouchFloor` / `setAirMove` / `idle` / `dash` 等（约 40 处）。`idle` 从 `FighterMain.jumpTimes`/`airHitTimes` 拷回计数。
- **读字段**：`FighterMcCtrler.render` 地面/空中轮询（`_action.attack && _actionCtrler.attack()` 模式）；`FighterAILogic` / `FighterAILogicBase` 经 `getMcCtrl().getAction()` 看哪些招当前允许，再决定 AI 出招。
- **生命周期**：`McCtrler.render` 每逻辑帧 `_action.render()` 扣 CD。`idle`/`doJump`/`doHurt` 等调 `clear` / `clearAction` / `clearState`。
- **Callees**：只 `GameConfig.FPS_GAME`（`setCD`）。

## 命名备注

- 字符串字段值是 **MC 帧标签**（`"走"`、`"防御"`、`"万解W"`），不是键名。`null` = 这一招当前不允许。
- `waiKai` / `waiKaiW` / `waiKaiS`：万解三路，对应 `IFighterActionCtrl.waiKai*`。保留拼写。
- `zhao*` = 招式键 skill 系；`bisha*` = 必杀；`bishaSUPERQi` 默认 300，其余气耗默认 100。
- `isDefenseHiting`：防御被打中（不是 `Hitting`）。
- `touchFloorBreakAct`：落地切帧时是否打断当前招。
- `setCD` / `CDOK`：本包 **零调用**（搜索仅定义）。API 留给时间轴/插件。

## 逐行说明

### 字段（L8–93）

**状态布尔**（`clearState` 清）：

- `isMoving` / `isJumping` / `isDefensing` / `isDashing`：当前正在走/跳/防/冲。
- `isHurting` / `isHurtFlying` / `isDefenseHiting`：受击硬直、击飞、防御受击。`McCtrler.renderAnimate` 按这三项分流 `renderHurtAnimate` / 击飞 / 防御硬直。

**落地 / 击中回调**（`clearAction` 清）：

- `airMove`：空中是否允许左右走。`setAirMove` 写；`idle` 落地后 `setAllAct` 会再开。
- `touchFloor:String`：落地要切的帧名。`touchFloorBreakAct` 默认 false。
- `hitTarget` / `hitTargetChecker`：打中后取消到 `hitTarget` 帧；检测盒名是 `hitTargetChecker`（`McCtrler.setHitTarget` 两参对调写入：checker 在前、目标帧在后）。

**招式允许表**（值 = 帧标签，`null` 禁）：

| 字段 | 典型帧 | 对应输入 |
|---|---|---|
| `moveLeft` / `moveRight` | `"走"` | `moveLEFT` / `moveRIGHT` |
| `defense` | `"防御"` | `defense` |
| `jump` / `jumpQuick` / `jumpDown` | 起跳/小跳/下平台 | `jump` / `jumpQuick` / `jumpDown` |
| `dash` | 冲 | `dash` / `dashJump` |
| `attack` / `skill1` / `skill2` | 普攻、下攻、上攻 | `attack` / `skill1` / `skill2` |
| `zhao1`/`zhao2`/`zhao3` | 招 | `zhao*` |
| `catch1`/`catch2` | 抓 | `catch*` |
| `bisha`/`bishaUP`/`bishaSUPER` | 必杀三路 | `bisha*` |
| `hurtAction` | 受击时强制切的招 | 时间轴 `setHurtAction`，state 改 16 |
| `waiKai`/`waiKaiW`/`waiKaiS` | `"万解"` / `"万解W"` / `"万解S"` | `waiKai*` |
| `attackAIR`/`skillAIR`/`bishaAIR` | 空中三路 | `*AIR` |

**计数 / 气耗**：

- `airHitTimes` / `jumpTimes`：剩余空中攻击次数、跳跃次数。`idle("站立")` 从 `FighterMain` 重置。`clearAction` **不清**。
- `bishaQi=100`、`bishaUPQi=100`、`bishaSUPERQi=300`、`bishaAIRQi=100`：`McCtrler.setBisha*(frame, qi)` 覆盖。`doBisha` 走 `FighterMain.useQi`。

`_cdObj:Object = {}`：键 → 剩余逻辑帧。`render` 每帧 `--`，`<=0` 则 `delete`。

### 构造（L95–99）

空。字段用声明默认值。

### `clear`（L101–105）

`clearState()` + `clearAction()`。`McCtrler.doJumpDown` 用全清。

### `clearState`（L107–117）

七个状态布尔全 false，含 `touchFloorBreakAct`。**不清** `airMove`（它在 `clearAction`）。`McCtrler.idle` / `doHurt` / `hurtResume` 等切状态时先清，再单独点亮当前态。

### `clearAction`（L119–152）

所有招式帧名置 `null`，气耗恢复默认 100/100/100/300，`airMove=false`，`touchFloor=null`。

**漏清**（?）：`waiKaiW`、`waiKaiS` 不在列表里（`waiKai` 有）。`jumpQuick`/`jumpDown`/`waiKai` 有。计数 `airHitTimes`/`jumpTimes` 故意保留。`idle` 之后会 `setAllAct`/`setWankai` 重填，实战多数路径无残留；`doJump` 只 `clearAction` 后再 `setAirAllAct`，万解 W/S 可能短暂残留（?）。

### `render`（L154–163）

`for in _cdObj`：`--` 后 `<=0` 则 `delete`。`McCtrler.render` 每 **逻辑帧** 调一次（60fps 时每帧一次）。空表空转。

### `setCD`（L165–169）

`param1` = CD 键（招名?），`param2` = 分子。写入 `_cdObj[key] = param2 / GameConfig.FPS_GAME`。60fps 时 `setCD("x", 60)` → 1 逻辑帧。随后 `trace` 该值。本包无调用点。

### `CDOK`（L171–174）

`return !_cdObj[param1]`：键不存在或值为 0/undefined 即 true。`0` 在 `render` 里会被 delete，正常不会读到 0。本包无调用点。
