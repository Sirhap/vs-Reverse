# `FighterActionState` — 角色整数状态机常量

一句话目的：`FighterMain.actionState` 的取值表。`FighterMcCtrler` 切招时写入，HUD/开场/终场/AI/受击逻辑用静态谓词判断「能不能赢动作 / 在不在打 / 能不能鬼步 / 是不是受击」。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterActionState.as`（75 行）

## Callers / callees

- **写入 `actionState`**：
  - `FighterMcCtrler`：idle=0、freeze=40、attack=10、skill=11、bisha=12、超必=13、跳=14、冲=15、hurtAct=16、防=20、被打=21、击飞=22、开场=60、胜利=61、失败=62、万解=50。
  - `FighterMC.renderHurtFly`：倒地=23、弹起=24、死亡=30。
  - `FighterCtrler.initMc`：万解途中 `initMc` 把 state 置 50。
- **谓词调用**：
  - `isHurting`：`FighterMcCtrler.idle`（受击结束回站立要 `_justHurtResume`）；`FighterMain.die`（已经在受击/死亡则不补 `playHurtDown`）。
  - `isAttacking`：`FighterMain.renderEnergy`（进攻回气 1.1）；`McCtrler` 地面/空中轮询里决定能否出空中招或地面连段。
  - `allowGhostStep`：`McCtrler` 鬼步入口。
  - `isAllowWinState`：`GameEndCtrl` 等胜者播完必杀/万解才切 `win()`。
  - `isBishaIng`：本包 **零调用**（仅定义）。
- **直接读数字**（不用谓词）：`FighterAILogic`（20=防，21/22/23=对手受击）；`TrainingCtrler`（21/22 延迟回血）；`FightUI`（12/13 必杀 UI，22 击飞，30 死）；`GameStartCtrl`（60=开场）；`FighterEffectCtrl`（50=万解）；`FighterAILogicBase._isConting`（10–13 连段中）。
- **无 callees**。构造空，从不 `new` 当实例用。

## 命名备注

- `NORNAL`：NORMAL 拼错，值 0。代码写入用字面量 `0`，从不引用这个常量名。
- 区间大致：0 常态，10–16 主动作，20–24 防/受击，30 死，40 冻结，50 万解，60–62 过场。
- `HURT_DOWN_TAN`：倒地弹起（弹）。`WAN_KAI_ING`：万解进行中。`KAI_CHANG`：开场。
- `isAllowWinState` 与 `allowGhostStep` **体相同**：禁 12/13/50。

## 逐行说明

### 常量（L6–42）

| 名 | 值 | 谁写入 | 语义 |
|---|---|---|---|
| `NORNAL` | 0 | `McCtrler.idle` / `dashStop` / 走停 | 站立/可行动 |
| `FREEZE` | 40 | `McCtrler` 定身 | 定帧，输入轮询仍可能被挡 |
| `ATTACK_ING` | 10 | `doAttack` / 空中普攻 | 普攻中 |
| `SKILL_ING` | 11 | `doSkill` / 空中技能 / 招 | 技能/招中 |
| `BISHA_ING` | 12 | `doBisha` 非超 / `doAirBisha` | 必杀中 |
| `BISHA_SUPER_ING` | 13 | `doBisha(..., true)` | 超必中（气 300） |
| `JUMP_ING` | 14 | `doJump` / `doAirJump` | 跳起过程 |
| `DASH_ING` | 15 | 地面冲 / 空中冲 | 冲刺 |
| `HURT_ACT_ING` | 16 | `setHurtAction` | 受击触发的反击招 |
| `DEFENCE_ING` | 20 | 进入防御 | 防御（`renderEnergy` 慢回气） |
| `HURT_ING` | 21 | `doHurt` hurtType=0 | 被打硬直。`FighterMain.beHit` 在 21/22 才累计 `_currentHurts` |
| `HURT_FLYING` | 22 | `doHurt` hurtType=1 | 击飞。`FightUI` 用它切击飞镜头 |
| `HURT_DOWN` | 23 | `FighterMC` 落地倒 | 倒地。派 `HURT_DOWN` |
| `HURT_DOWN_TAN` | 24 | `FighterMC` 弹起 | 倒地弹。`McCtrler` 可受身 |
| `DEAD` | 30 | `FighterMC` 倒地后 `!isAlive` | 死亡姿势。`FightUI` KO |
| `WAN_KAI_ING` | 50 | `doWaiKaiAction` / `initMc` | 万解。禁赢动作、禁鬼步 |
| `KAI_CHANG` | 60 | `sayIntro` | 开场喊招。`GameStartCtrl` 等双方离开 60 |
| `WIN` | 61 | `doWin` | 胜利动作 |
| `LOSE` | 62 | `doLose` | 失败动作 |

常量本身在本包几乎不被引用（都写裸数字）；谓词内部也写 `[12,13]` 而不是 `BISHA_ING`。表的价值是给反编译对照。

### 构造（L44–47）

空。无实例字段。

### `isAllowWinState`（L49–52）

`param1` = `actionState`。`!= 12 && != 13 && != 50`：必杀/超必/万解播完才允许切胜利。`GameEndCtrl` 每帧问胜者。

### `isBishaIng`（L54–57）

`[12,13].indexOf != -1`。本包无调用。与 `isAttacking` 子集重合。

### `isAttacking`（L59–62）

`[10,11,12,13]`：普攻/技能/必杀/超必。不含跳、冲、抓 hurtAct、万解。`FighterMain.renderEnergy` 进攻回气走这条；`McCtrler` 用来允许「攻击中取消到空中招」一类。

### `allowGhostStep`（L64–67）

与 `isAllowWinState` 同条件。鬼步不能从必杀/万解进。

### `isHurting`（L69–72）

`[21,22,23,24]`：被打、击飞、倒地、弹起。不含 `DEAD=30`、不含 `HURT_ACT_ING=16`。`FighterMain.die`：已经在这四态或 30 就不补倒地动画（击飞状态机自己会倒）。
