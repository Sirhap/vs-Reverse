# `FighterEvent` — 招式事件（子弹/攻击体/辅助/连击/死亡）

一句话目的：挂在静态总线 `FighterEventDispatcher` 上的 `Event`。主体是 `fighter:BaseGameSprite`，附加 `params`。`FighterEventCtrl` 听字符串 type，与本类常量同文。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/events/FighterEvent.as`（35 行）

## Callers / callees

- **构造**：几乎只 `FighterEventDispatcher.dispatchEvent` `new FighterEvent(type,false,false)` 再写 `fighter`/`params`。例外：`FighterMcCtrler` 对 `_fighter.dispatchEvent(new FighterEvent("DO_ACTION"))` —— **走角色自身 EventDispatcher，总线听不到**。
- **监听**：`FighterEventCtrl.initlize` 听 7 个字符串（不含 `DO_ACTION`）。
- **派发字面量**（多数不写 `FighterEvent.XXX`）：
  - `FIRE_BULLET`：`FighterMcCtrler.fire`、`FighterAttackerCtrler`、`AssisiterCtrler`。
  - `ADD_ATTACKER`：`FighterMcCtrler.addAttacker`、`AssisiterCtrler`。
  - `ADD_ASSISTER`：`FighterMcCtrler`。
  - `HIT_TARGET`：`GameLogic.hitTarget`。
  - `HURT_RESUME` / `DIE`：`FighterMcCtrler`。
  - `HURT_DOWN`：`FighterMC`。
- **Callees**：`flash.events.Event`、`BaseGameSprite`（字段类型）。

## 命名备注

调用方写字符串字面量，常量与字面量同文。`DO_ACTION` 本包总线无 listener。

## 逐行说明

### 常量（L8–23）

| 常量 | 谁派 | `params` |
|------|------|----------|
| `FIRE_BULLET` | 角色/辅助/攻击体时间轴 `fire` | `{mc, hitVO, ...}`，无 `mc` 则 Ctrl 丢弃 |
| `ADD_ATTACKER` | 时间轴 `addAttacker` | 同样要 `mc` |
| `ADD_ASSISTER` | 时间轴召唤 | 无 params，Ctrl 从 `gameRunData` 组里取 `fuzhu` |
| `HIT_TARGET` | `GameLogic.hitTarget` | `{target, hitvo}`（小写 vo） |
| `HURT_RESUME` | 受击结束站起 | 无 |
| `HURT_DOWN` | 倒地 | 无 |
| `DIE` | 死亡动画 | 无 |
| `DO_ACTION` | McCtrler 切动作 | 派到 **fighter 实例**，不是总线 |

### 实例字段（L25–27）

- `params:*`：任意。Ctrl 当 Object 读。
- `fighter:BaseGameSprite`：发射者/受击者。子弹事件里是发射角色，不是子弹。

### 构造（L29–32）

`(type, bubbles=false, cancelable=false)`。`super` 后 **不** 设 fighter/params，由 Dispatcher 后写。
