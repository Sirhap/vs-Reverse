# `fighter.vos.MoveTargetParamVO` — 拉/推对手参数

一句话目的：抓取、必杀、技能时间轴调用 `mc_ctrler.moveTarget({…})` 时，记下要把当前目标吸到哪、跟哪段 MC、以多快速度；`FighterMcCtrler.renderMoveTarget` 每逻辑帧执行。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/vos/MoveTargetParamVO.as`（67 行）

## Callers / callees

- **创建 / 清除**：仅 `FighterMcCtrler.moveTarget(obj)`。`obj` 有值则 `new MoveTargetParamVO(obj)` + `setTarget(fighter.getCurrentTarget())`；`obj==null` 才走 `clear()` 再丢掉引用。`endAct` / `destory` 直接 `_moveTargetParam=null`，**不** `clear()`（重力不会在这两处被本 VO 复位）。
- **每帧**：`FighterMcCtrler.render` 若字段非空 → `renderMoveTarget`：有 `followMcName` 则跟自己 MC 里该子件的世界坐标（`fighter.x + child.x*direct`，`fighter.y + child.y`）；否则用 `x/y`。有 `speed` 则按步长靠近（Y 对 `BaseGameSprite` 走 `setVecY`+`setDampingY(1)`）；无 speed 则瞬移贴上。
- **时间轴**（`decompiled/fighters/*/scripts/**`）：`parent.$mc_ctrler.moveTarget({"followmc":"move_mc"})`、带 `"speed":5|13`，结束 `moveTarget(null)`。例：`obito` 樱/鸣人、`kakashi_sw` 人物全动作、`lee` 樱、`aizen` 蓝染全动作、`gaara` Timeline。
- **Callees**：`GameConfig.SPEED_PLUS` 乘进 speed；`BaseGameSprite.setVelocity(0,0)` / `isApplyG=true`。

## 命名备注

- 时间轴键是 **`followmc`**（全小写），字段是 `followMcName`。
- `speed` 可是 Number（xy 同速）或 `{x,y}`。写入前乘 `GameConfig.SPEED_PLUS`（与 30fps 基准的帧速比）。
- 无 `id`。`x`/`y` 未出现在 obj 里时保持 `NaN`（Number 未赋默认值），`renderMoveTarget` 用 `isNaN` 跳过该轴。构造里若 obj 有键则缺省 0。

## 逐行说明

### 字段（L11–19）

`x`/`y`：目标点（相对/绝对语义由调用约定；无 follow 时当世界坐标用）。`followMcName`：跟随的子 MC 名，常见 `"move_mc"`。`target`：被拉的精灵。`speed`：每帧最大步长（已含 SPEED_PLUS）。

### 构造（L21–44）

`param1==null` 直接 return（字段全 NaN/null）。否则：

- `x = obj.x != undefined ? obj.x : 0`
- `y` 同
- `followMcName = obj.followmc != undefined ? obj.followmc : null`
- 有 `obj.speed`：`new Point()`。若 speed 是 Number：`speed.x = speed.y = speed * SPEED_PLUS`。否则按 `speed.x`/`speed.y` 缺省 0 再乘 SPEED_PLUS。

不读其它键。`target` 构造时仍空，等 `setTarget`。

### `setTarget`（L46–53）

`target = param1`。若是 `BaseGameSprite`，`setVelocity(0,0)` 清掉当前速度，避免吸人时惯性顶飞。`moveTarget` 传入 `getCurrentTarget()`，可能不是角色（? 仍可拉 x/y）。

未在这里关重力；`renderMoveTarget` 用 `setVecY` 时也不关 `isApplyG`。只有 `clear` 把 `isApplyG` 置回 true——意味着若别处曾关掉重力，结束拉人会恢复。本 VO **从不把 isApplyG 设 false**（? 重力开关在 McCtrler 其它路径）。

### `clear`（L55–64）

有 target 且是 `BaseGameSprite` 则 `isApplyG = true`。不 `setVelocity`。不把 `target` 置 null（随 VO 一起丢）。
