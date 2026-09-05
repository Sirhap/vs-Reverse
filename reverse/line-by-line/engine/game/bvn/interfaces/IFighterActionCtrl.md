# `interfaces.IFighterActionCtrl` — 角色动作输入（键控/AI 共用）

一句话目的：每帧问「这一招要不要出」。`FighterKeyCtrl` 把 `GameInputer` 键位组合成招式；`FighterAICtrl` 用同一套方法名喂 AI。`FighterMcCtrler` 按 `FighterAction` 开关 + 本接口布尔值决定切 MC 动作。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IFighterActionCtrl.as`（77 行）

## Callers / callees

- **Implementors**：`fighter.ctrler.FighterKeyCtrl`、`FighterAICtrl`（本任务不注解这两文件）。
- **装配**：`GameCtrl.addFighter`：P1 总是 `FighterKeyCtrl`（`inputType="P1"`，`classicMode = keyInputMode==1`）；P2 在 VS CPU / 闯关时 `FighterAICtrl`，否则键控 `"P2"`。然后 `FighterMain.setActionCtrl` → `FighterCtrler.setActionCtrl` → `FighterMcCtrler.setActionCtrler`。
- **消费**：`FighterMcCtrler` 地面/空中/防御/鬼步/万解轮询（约 60 处 `_actionCtrler.xxx()`）。`specailSkill` 在 L1822 附近。`destory` 在卸控制器时。
- **额外**：`GameInterfaceManager.getFighterCtrl` 声明返回本接口但 **恒 null**，且不在 `IGameInterface` 里。本包角色控制不走平台钩子。

## 命名备注

保留原拼写：`initlize`、`destory`、`specailSkill`（special）、`waiKai`（万解，对应输入 `wankai`）。`zhao*` = 招式键 skill 系。`bisha*` = 必杀 superSkill 系。下列「键控语义」来自 `FighterKeyCtrl`，AI 实现另算。

## 逐行说明

### 生命周期（L6–14）

- `initlize`：键控非经典模式 `_justDown=2` 并 `GameInputer.listenKeys`（攻击类 0.1s 缓冲）；经典 `_justDown=0`。
- `render` / `renderAnimate`：键控皆空；AI 在这里想招。`FighterMcCtrler` 每逻辑帧/动画帧各调一次。
- `destory`：键控 `unListenKeys`。
- `enabled()`：**方法不是 getter**。键控 = `GameCtrl.I.actionEnable`（开场/结束动画时 false）。AI 另有自己的允许标志。

### 移动 / 防御 / 基础（L16–32）

- `moveLEFT` / `moveRIGHT`：单方向按住（互斥）。
- `defense`：按下。
- `attack`：攻击边沿，排除上/下/跳（避免跟 skill1/2、jump 抢）。
- `jump`：跳边沿且没按攻击。
- `jumpQuick`：小跳。经典模式键控恒 false。
- `jumpDown`：下+跳（下平台）。
- `dash`：冲，排除按下。
- `dashJump`：冲（含下，给空中冲跳）。

### 技能 / 招 / 抓（L34–46）

- `skill1`：下+攻击。`skill2`：上+攻击。
- `zhao1`：技能键，排除上/下。`zhao2`：下+技能。`zhao3`：上+技能。
- `catch1`：攻击 justDown=2 + 左右。`catch2`：技能 justDown=2 + 左右。抓取用 0.1s 窗，经典模式也写死 2。

### 必杀 / 辅助（L48–56）

- `bisha`：必杀，排除上/下。`bishaUP`：上+必杀。`bishaSUPER`：下+必杀。
- `assist` / `specailSkill`：键控都是 `special` 按住（召唤键）。`McCtrler` 两处语义不同：assist 叫助战，`specailSkill` 叫角色特殊（爆气等）。同一键。

### 空中（L58–62）

`attackAIR` / `skillAIR` / `bishaAIR`：空中不叠加方向过滤，只看对应键边沿。

### 万解（L64–68）

- `waiKai`：万解（攻+跳）且无上/下。
- `waiKaiW`：上+万解。`waiKaiS`：下+万解。

### 鬼步（L70–74）

- `ghostStep`：冲+下（地面）。
- `ghostJump`：冲+上。
- `ghostJumpDown`：冲+下（空中，与 ghostStep 键控相同，由 MC 状态分流）。
