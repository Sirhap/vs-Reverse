# `fighter.ctrler.FighterAICtrl` — CPU 的 `IFighterActionCtrl`

一句话目的：把 `FighterAILogic` 想好的布尔招式喂给 `FighterMcCtrler`。方法名与 `FighterKeyCtrl` 一一对应；本类自己不算距离、不出键。万解三招与小跳恒 false。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterAICtrl.as`（210 行）

## Callers / callees

- **装配**：`GameCtrl.addFighter` team=2 且 `GameMode.isVsCPU(false) || isAcrade()`：`new FighterAICtrl()`，写 `AILevel=MessionModel.I.AI_LEVEL`、`fighter=param1`，再 `FighterMain.initlize` + `setActionCtrl`（内部 `initlize()`）。`isVsCPU(false)` **不含** 练习 40，练习 P2 是键控。街机 10/20/30 与 VS CPU 12/22 才是本类。
- **消费**：`FighterMcCtrler.render` → `_actionCtrler.render()`（空）；`renderAnimate` → `_actionCtrler.renderAnimate()`（这里才想招）。轮询约 60 处 `_actionCtrler.xxx()`。`destory` 在 `FighterMcCtrler.destory`。
- **Callees**：`FighterAILogic(AILevel, fighter)`。实现 `IFighterActionCtrl`。读 `GameCtrl.I.actionEnable`。

## 命名备注

- `initlize` / `destory` / `specailSkill`：接口原拼写。
- `ghostJumpDowm`：`FighterAILogic` 字段少一个 n，本类 `ghostJumpDown()` 读的就是它。
- `dashJump` 读 `_AIlogic.downJump`（不是 dash）。
- `_target` / `_ai_update_gap` / `_ai_update_frame`：**声明后从未读写**。? 旧版按 gap 抽帧想招的残留。

## 与 `FighterKeyCtrl` 的差异

| 点 | KeyCtrl | AICtrl |
|----|---------|--------|
| `render` | 空 | 空 |
| `renderAnimate` | 空 | `_AIlogic.render()`（动画帧想招，约 30fps） |
| `enabled` | `actionEnable` | 同，**没有**另一套允许标志 |
| `jumpQuick` | 非经典=跳边沿 | **恒 false** |
| `waiKai*` | 攻+跳 | **恒 false**（CPU 不出万解） |
| `assist` / `specailSkill` | 同一 `special` 按住 | 两个独立 AI 布尔 |

## 逐行说明

### 字段 / 构造（L12–26）

- `AILevel`：公开，装配时写入。传给 `FighterAILogic` 构造。
- `fighter`：公开，逻辑体要读自己状态。
- `_target`：死字段。
- `_ai_update_gap` / `_ai_update_frame`：死字段。
- `_AIlogic`：`initlize` 才 new。
- 构造空。

### `initlize`（L28–32）

`new FighterAILogic(AILevel, fighter)`。须先写好那两个公开字段，否则 logic 拿到 0 / null。`FighterMain.setActionCtrl` 在 `addFighter` 写完字段之后才调，顺序正确。

### `destory`（L34–43）

`fighter`/`_target` null；有 `_AIlogic` 则 destory。不重置 `AILevel`。

### `enabled`（L45–48）

**方法不是 getter**。`GameCtrl.I.actionEnable`。开场/终场 false，与键控同一闸。AI 想招仍在 `renderAnimate` 跑，只是 `FighterMcCtrler` 用 `enabled()` 挡住出招。

### `render`（L50–53）

空。想招不在逻辑帧。

### `renderAnimate`（L54–57）

`_AIlogic.render()`。`FighterMcCtrler` 每动画帧先让 AI 刷新布尔，再 poll 接口。`_AIlogic` 空则 NPE（须先 `initlize`）。

### 移动 / 防御 / 基础（L59–102）

全部直通 `_AIlogic` 同名（或近名）布尔：

- `moveLEFT` ← `moveLeft`（大小写不同）
- `moveRIGHT` ← `moveRight`
- `defense` / `attack` / `jump` / `jumpDown` / `dash`
- `jumpQuick`：**写死 false**。CPU 没有小跳。
- `dashJump` ← `downJump`（空中冲跳/下平台语义由 MC 状态分流）

### 技能 / 招 / 抓（L104–137）

`skill1/2`、`zhao1/2/3`、`catch1/2` 同名直通。

### 必杀 / 辅助（L139–162）

- `bisha` / `bishaUP` / `bishaSUPER` 同名。
- `assist` ← `assist`
- `specailSkill` ← `specialSkill`（接口拼错，logic 字段是 special）

### 空中（L164–177）

`attackAIR` / `skillAIR` / `bishaAIR` 同名。AI 不叠加方向过滤（方向已经在 logic 里决定出哪一招）。

### 万解（L179–192）

`waiKai` / `waiKaiW` / `waiKaiS` 全 **false**。CPU 不能切完全体。

### 鬼步（L194–207）

- `ghostStep` ← `ghostStep`
- `ghostJump` ← `ghostJump`
- `ghostJumpDown` ← `ghostJumpDowm`（保留 logic 拼写）
