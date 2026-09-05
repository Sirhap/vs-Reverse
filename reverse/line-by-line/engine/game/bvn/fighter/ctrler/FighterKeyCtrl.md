# `fighter.ctrler.FighterKeyCtrl` — 键鼠的 `IFighterActionCtrl`

一句话目的：把 `GameInputer` 的方向/攻击/跳/冲/技能/必杀/万解组合成招式布尔。`FighterMcCtrler` 只问「这一招要不要出」，组合规则全在这里。经典模式按住即出招、无小跳、无 0.1s 缓冲。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterKeyCtrl.as`（210 行）

## Callers / callees

- **装配**：`GameCtrl.addFighter`：
  - team 1：永远本类，`inputType="P1"`，`classicMode = keyInputMode==1`。
  - team 2：非 VS CPU / 非街机（含练习 40、VS 人 11/21）也是本类，`"P2"`。
  - 然后 `FighterMain.setActionCtrl` → `initlize()`。
- **消费**：同 `FighterAICtrl`：`FighterMcCtrler` 逻辑帧 `render()`（空）、动画帧 `renderAnimate()`（空）后按 `FighterAction` 开关 poll 各方法。`destory` 在卸 McCtrler 时 `unListenKeys`。
- **Callees**：`GameInputer`（`left/right/up/down/attack/jump/dash/skill/superSkill/special/wankai` + `listenKeys`）、`GameCtrl.I.actionEnable`。实现 `IFighterActionCtrl`。

## 命名备注

- `initlize` / `destory` / `specailSkill` / `waiKai`：接口原拼写。`waiKai` 对应输入 `wankai`。
- `_justDown`：传给 `GameInputer` 的模式。0=按住，1=边沿（本类不用），2=0.1s 缓冲窗。
- `classicMode`：`ConfigVO.keyInputMode==1`。经典=按住出招 + 关 listenKeys + 关小跳。
- `catch1/catch2` **写死** justDown=2，经典模式也有 0.1s 窗（但没 listenKeys 预热，只有 poll 到的那几帧算）。
- `assist` 与 `specailSkill` 同一键 `special` 按住。McCtrler 两处语义不同：assist=召唤助战，`specailSkill`=角色特殊（爆气等）。

## 逐行说明

### 字段 / 构造（L10–19）

- `inputType`：`"P1"` / `"P2"`。未赋值就 `initlize` 会 listen 到 undefined 键。
- `classicMode` 默认 false（现代缓冲）。
- `_justDown` 默认 0，`initlize` 再改。
- 构造空。

### `initlize`（L21–32）

非经典：`_justDown=2`，`GameInputer.listenKeys(inputType, ["attack","jump","dash","skill","superSkill"], 2)`。这五键从按下那一帧就开始进 0.1s 缓冲，即使当前动作没 poll。方向/special/wankai **不** listen。

经典：`_justDown=0`，不 listen。按住期间每帧 `xxx()` 都为 true，McCtrler 靠动作状态互斥。

### `render` / `renderAnimate`（L34–40）

皆空。键状态由 `GameInputer.render`（GameRender 每 enterFrame）维护。

### `destory`（L42–48）

非经典才 `unListenKeys(inputType, 2)`。经典没 listen 也不 un。`GameInputer.clearInput` 不清 `_listenKeys`，所以非经典必须走这里，否则下场 P1_2 监听残留。

### `enabled`（L50–53）

`GameCtrl.I.actionEnable`。开场 intro / 终场 cinema 为 false。

### 移动 / 防御 / 基础（L55–102）

`GameInputer.*(inputType, justDown)`：

- `moveLEFT`：left 按住 **且非** right。`moveRIGHT` 对称。同时按左右不动。
- `defense`：down 按住。下蹲与防御同一键。
- `attack`：攻击 `_justDown`，排除 up/down/jump（避免跟 skill1/2、跳攻击抢）。
- `jump`：跳 `_justDown` 且没按攻击（避免跟万解抢？万解是 attack+jump 同时按住走 `wankai`，但 jump() 仍可能为真若 attack 的 justDown 已消费。McCtrler 状态分流）。
- `jumpQuick`：经典恒 false；否则与 `jump()` **同一条件**。小跳/高跳由 McCtrler 不同动作开关决定谁先问。
- `jumpDown`：down 按住 + 跳 `_justDown`（下平台）。
- `dash`：冲 `_justDown` 且非 down（排除鬼步键）。
- `dashJump`：冲 `_justDown`，**含** down。空中冲跳用。

### 技能 / 招 / 抓（L104–137）

- `skill1`：下+攻击。`skill2`：上+攻击。
- `zhao1`：技能，排除上/下。`zhao2`：下+技能。`zhao3`：上+技能。
- `catch1`：攻击 **justDown=2** + 左或右。`catch2`：技能 justDown=2 + 左或右。抓取即使用经典模式也走 0.1s 窗。

### 必杀 / 辅助（L139–162）

- `bisha`：必杀 `_justDown`，排除上/下。
- `bishaUP`：必杀 + 上。`bishaSUPER`：必杀 + 下。
- `assist` / `specailSkill`：都是 `special` **按住**（justDown=0）。同一物理键。

### 空中（L164–177）

`attackAIR` / `skillAIR` / `bishaAIR`：对应键 `_justDown`，**不加**方向过滤。空中方向由 McCtrler 不走地面 skill1/zhao2 那套。

### 万解（L179–192）

`wankai` = 攻击与跳**同时按住**（`GameKeyInput.wankai`）。

- `waiKai`：万解且无上/下。
- `waiKaiW`：上+万解。`waiKaiS`：下+万解。

justDown=0：按住期间每帧都真，McCtrler 用 `actionState` / 气量闸一次。

### 鬼步（L194–207）

- `ghostStep`：冲 `_justDown` + down。地面。
- `ghostJump`：冲 + 上。
- `ghostJumpDown`：冲 + down。与 `ghostStep` **键控相同**，由 MC 空中/地面状态分流。
