# `events.GameEvent` — 全局游戏事件总线

一句话目的：静态 `EventDispatcher` 包装。战斗/选人/分数用字符串 type 广播，附带可选 `param`，不走显示列表。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/events/GameEvent.as`（61 行）

## Callers / callees

- **Callers（dispatch）**：`GameLogic.addScore*` → `SCORE_UPDATE`。`GameCtrl` → `GAME_START` / `ROUND_START` / `GAME_END` / `PAUSE_GAME` / `RESUME_GAME` / `ROUND_END`。`SelectFighterStage` → `SELECT_FIGHTER_STEP`（带当前选择）、`SELECT_FIGHTER_FINISH`。`SelectIndexUIGroup` → `SELECT_FIGHTER_INDEX`（出战顺序）。`CongratulateState` → `GAME_PASS_ALL`。`GameOverState` → `GAME_OVER`。
- **Callers（listen）**：`FightUI` 听 `SCORE_UPDATE` 刷分数条。`Ctrler4399.init` 听 `GAME_OVER` / `GAME_PASS_ALL` 挂 4399 提交分按钮。
- **Callees**：`flash.events.Event` / `EventDispatcher`。本文件不引用其它 bvn 类。

## 命名备注

调用方几乎全部写字符串字面量（`"GAME_START"`），**不用** `GameEvent.SCORE_UPDATE` 这类常量。常量与字面量同文。`LOAD_GAME_COMPLETE` 本包无 dispatch、无 listener。`PAUSE_GAME` / `RESUME_GAME` / `GAME_START` / `ROUND_*` / `GAME_END` / `SELECT_FIGHTER_*` 有 dispatch，本 SWF **无** listener（留给平台 overlay / 未接入代码）。

## 逐行说明

### 常量（L9–33）

- `SCORE_UPDATE`：闯关加分后。`FightUI.updateScore` 读 `GameData.I.score`。
- `PAUSE_GAME` / `RESUME_GAME`：`GameCtrl.pause/resume(true)` 玩家暂停对话框时。同时 stage 发 `"5d_message"` `game_pause` / `game_resume`。
- `LOAD_GAME_COMPLETE`：未使用。?
- `GAME_START`：`GameCtrl.doStartGame`，对局逻辑开始、`GameRender.add(render)` 之前。
- `ROUND_START`：开下一回合动画后。
- `ROUND_END`：`doGameEnd`，胜负已写入 `gameRunData`，`GameEndCtrl` 已建。
- `GAME_END`：VS 模式整局结束、回选人。**不是** 回合结束。
- `GAME_OVER`：`GameOverState` 继续失败/退出。4399 在此插提交分按钮。
- `GAME_PASS_ALL`：`CongratulateState` 通关。同样插提交分。
- `SELECT_FIGHTER_STEP`：`param` = 该选人器当前已选 ID 列表。2P 对战一方选完。
- `SELECT_FIGHTER_FINISH`：选人流程结束。
- `SELECT_FIGHTER_INDEX`：`param` = `SelectIndexUIGroup.getOrder()` 出战顺序。

### 静态总线与实例字段（L35–37）

- `_dispatcher`：进程级单例。不挂 Stage，因此 `bubbles` 实际无意义。
- `param`：任意附加数据。多数 dispatch 不传。

### 构造（L39–43）

`param1` type，`param2` → `this.param`，`param3` bubbles，`param4` cancelable。`super(type, bubbles, cancelable)`。外部几乎只走静态 `dispatchEvent`，不 `new`。

### `dispatchEvent`（L45–48）

`new GameEvent(...)` 丢给 `_dispatcher`。签名与构造一致。调用方最多用到前两个参数。

### `addEventListener`（L50–53）

原样转发 `EventDispatcher.addEventListener`：type / listener / useCapture / priority / useWeakReference。`FightUI` 不传后三个（默认 false/0/false）。`Ctrler4399` 同样。

### `removeEventListener`（L55–58）

转发 remove。`FightUI.destory` 卸 `SCORE_UPDATE`。`Ctrler4399` **不** remove（生命周期 = 整局）。
