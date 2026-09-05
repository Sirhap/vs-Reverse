# `GameRender` — Stage ENTER_FRAME 分发中枢

一句话目的：唯一的帧循环入口。`initlize` 在舞台上听 `"enterFrame"`，每帧按 owner 分组调用已 `add` 的函数。游戏逻辑、输入、UI 动画、转场 MC 都挂在这里，而不是各自 `addEventListener(ENTER_FRAME)`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/GameRender.as`（83 行）

## Callers / callees

- **Callers**（`add`/`remove`；括号内为 owner 实参）：
  - `MainGame.initlize`：`initlize(stage)`，只此一次。
  - `GameInputer.initlize`：`add(render)` → owner 默认 `"anyone"`。从不 remove。
  - `GameCtrl`：开战 `add(render)`，`destory` `remove(render)`。
  - 状态机：`MenuState`/`SelectFighterStage`/`LoadingState`/`HowToPlayState`/`WinnerState`/`GameOverState`/`CongratulateState` 的 `render`，destory 时 remove。
  - UI：`MenuBtnGroup`、`SetBtnGroup`（owner=`this`）、`SelectIndexUIGroup`、`TransUI`。
  - `BaseGameSprite`：`add(renderSelfEnterFrame, this)` / `remove(..., this)` —— 独立于对局主循环的自渲染（例如暂停后仍要播的效果）。
- **Callees**：仅 `Stage.addEventListener("enterFrame", render)`。不调游戏逻辑。

本包 **没有** 对 `isRender` 的写入（除声明 `= true`）。公开变量，外部/调试可用来整帧暂停；`GameCtrl.pause` **不**走这个开关，它有自己的 `_isRenderGame`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `initlize` | 原拼写 |
| `_fucs` | functions 的缩写/拼写，`Dictionary` |
| `"anyone"` | owner 缺省/falsy 时的公共桶。多数 state 的 render 都在这一组 |
| owner `this` | 用对象当 Dictionary 键，remove 时必须传同一引用 |

## 逐行说明

### 静态字段（L10–12）

- `isRender`：总闸。false 时 `render` 立刻 return，所有回调本帧跳过。默认 true。
- `_fucs`：`Dictionary`，key=owner，value=`Vector.<Function>`。用 Dictionary 是为了允许 `BaseGameSprite` 实例做 key（Object 只能用字符串键）。

### 空构造（L14–17）

全静态。

### `initlize`（L19–21）

`stage.addEventListener("enterFrame", render)`。无弱引用、无优先级。重复调用会 **叠多个** listener（同一函数多次登记，Flash 会每帧调 N 次）。`MainGame.initlize` 只走一次。

没有对应的 shutdown。换 stage 不会卸旧的。

### `add`（L24–37）

`(fn, owner=null)`。`!owner` 时（null/undefined/0/""/false）改成 `"anyone"`。

去重：该 owner 桶已存在且 `indexOf(fn)!=-1` 则 return。同一函数可以挂在不同 owner 下（会每帧跑两次）。

`_fucs[owner] ||= new Vector.<Function>()` 后 `push(fn)`。

`SetBtnGroup` / `BaseGameSprite` 必须带 `this`，否则和别人挤在 `"anyone"`，`remove(fn)` 不带 owner 时只会从 `"anyone"` 删，对象桶里的会泄漏，每帧继续跑。

### `remove`（L39–54）

同样把 falsy owner 归一成 `"anyone"`。桶不存在直接 return。`indexOf` 到则 `splice(1)`。不删空桶（空 Vector 仍留在 Dictionary）。

只删 **第一个** 匹配。因 `add` 已去重，正常只有一个。

`TransUI.destory`/`stopRender` 调 `remove(render)` 不带 owner —— 与 `add(render)` 一致，都在 `"anyone"`。

### `render`（L56–79）—— 每帧

1. `!isRender` → return。Stage 事件仍在，只是空转。
2. `for each (_loc2_ in _fucs)`：遍历 **values**（每个 Vector），**不保证 owner 顺序**。Dictionary 迭代顺序插入相关但不稳定，不要依赖「输入一定在逻辑前」。
3. 对每个 Vector：先记下 `_loc3_ = length`，再 `while (_loc4_ < _loc3_)`：
   - 若 `_loc4_ > length-1`：break。本帧有人 `remove` 导致向量缩短，避免越界。
   - `_loc2_[_loc4_]()`：无参调用。回调里抛错会中断 **整个** 后续渲染（没有 try/catch）。`GameMainLogicCtrler.renderGameSprite` 自己 catch；挂在这里的 state.render 没有。
   - `_loc4_++`。

本帧 `add` 到同一 Vector 的新函数：length 快照在循环前，**本帧不会跑**（要等下一帧）。`add` 到尚未迭代到的另一个 owner 桶：`for each` 是否包含本帧新建的桶取决于 Dictionary 实现，`?` 不保证。

本帧 `remove` 自己：splice 后后面的元素前移，`_loc4_++` 会 **跳过** 紧随其后的一个回调。`remove` 一个尚未执行的后面项：后面项前移，可能被当前下标立刻执行，或因 `_loc3_` 限制而少跑。常见模式是 destory 里 remove 自己，跳过问题不大。

`GameCtrl.render` 与各 `State.render` 同在 `"anyone"` 桶时，顺序 = add 顺序。`GameInputer` 在 `MainGame.initlize` 里最早 add，所以多数时候输入采样在状态逻辑前。`TransUI` 在转场时临时 add，插在当时 Vector 尾部。
