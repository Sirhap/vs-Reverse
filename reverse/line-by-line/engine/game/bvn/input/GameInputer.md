# `input.GameInputer` — 三通道输入门面 + just-down 缓冲

一句话目的：静态门面。MENU/P1/P2 各挂一组 `IGameInput`，每帧维护「刚按下」与 0.1s 缓冲窗，再按方法名动态调用。`enabled` 总闸只挡查询，不挡 init/focus/clear。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/input/GameInputer.as`（337 行）

## Callers / callees

- **Init**：`MainGame.initlize` → `GameInputer.initlize(_stage)`，随后 `updateConfig()`。
- **配置刷新**：`SettingState` APPLY 后再 `updateConfig()`。
- **查询**：`FighterKeyCtrl`（战斗，P1/P2）；`MenuBtnGroup` / `SetBtnGroup` / `MenuState.anyKey` / `SelectFighterStage` / `SelectIndexUIGroup` / `GameOverState` / `HowToPlayState` / `LoadingState` / `WinnerState` / `CongratulateState` / `GameCtrl.renderPause`。
- **listenKeys**：仅 `FighterKeyCtrl.initlize`（非经典模式，`justDown=2`，键名 `attack/jump/dash/skill/superSkill`）；`destory` 时 `unListenKeys`。
- **clearInput**：`GameCtrl.destory`、`LoadingState`。
- **enabled 总闸**：选人/菜单过场/Winner 过场置 false，进可操作态再 true。`doStartGame` 强制 true。
- **Callees**：`GameInterface.instance.getGameInput/updateInputConfig`；`GameKeyInput`（fallback）；`GameData.I.config.key_*`；`GameRender.add(render)`；`MainGame.I.getFPS()`。

## 命名备注

`initlize` 拼写同全引擎。`wankai` = 万解。`JUST_DOWN_DELAY = 0.1` **从未被引用**；`isJustDownDelay` 内写死字面量 `0.1 * fps`。

## 逐行说明

### 静态字段（L13–23）

- `JUST_DOWN_DELAY = 0.1`：秒。死常量。
- `enabled = true`：总闸。`call()` 开头若 false 直接 return false。`callVoid` **不读** 此字段。
- `_listenKeys`：`{ "P1_2": {type, ids, justDown} }`。延迟窗预热表。
- `_inputMap:Dictionary`：key = `"MENU"|"P1"|"P2"`，value = `Vector.<IGameInput>`。
- `_justDownKeys`：`type_func → Boolean`。已消费的边沿。
- `_justDownDelayKeys`：`type_func → Number`（剩余帧）。`render` 每帧 `--`，≤0 则 delete。

### 构造（L25–28）

空。全静态。

### `initlize`（L30–35）

`initInput()` → `callVoid("initlize", stage)`（三通道都 init）→ `GameRender.add(render)`（无 owner，进 `"anyone"` 桶，每 enterFrame）。

### `initInput`（L37–57）

分别 `getGameInput("MENU"|"P1"|"P2")`。本包 `GameInterfaceManager` 总返回 1 个新 `GameKeyInput`，fallback 走不到。空则 `new Vector.<IGameInput>([new GameKeyInput()])`。然后 `setInput` 三次。MENU 用 `setInput(...)`，P1/P2 写成 `GameInputer.setInput`（等价）。

### `setInput`（L59–62）

覆盖 `_inputMap[type]`。无合并。

### `updateConfig`（L64–73）

若 `GameInterface.instance.updateInputConfig()` 为 true，**整段跳过**（平台自己灌配置）。本包 GIM 恒 false。否则 `setConfig` 三次：`key_menu` / `key_p1` / `key_p2`。

### `setConfig`（L75–78）

`call(type, "setConfig", vo)`。`call` 对 Vector 里每个 enabled 设备都 `apply`；void 返回值当 false，因此 **不会** 在第一个设备后 break，所有设备都能收到配置。

### `focus`（L80–83）

`callVoid("focus")`。三通道都把 stage.focus 设回 stage。

### `listenKeys`（L85–101）

`param3` 必须是 1 或 2，否则 return。key = `type + "_" + justDown`（**不含** ids）。同一通道同一 justDown 模式只能有一份 ids。`FighterKeyCtrl` 用 `2`：非经典模式把攻击类键的 0.1s 窗从 **按下那一帧** 就开始计，即使当前动作状态没 poll。

### `unListenKeys`（L103–107）

`delete _listenKeys[type_justDown]`。不判 `_listenKeys` 空；须先 `listenKeys`。经典模式不 listen，`destory` 也不 unListen。

### `renderListenKeys`（L109–129）

对每条 listen 的每个 id，调 `isDown(type, id, justDown, true)`。`param4=true` 跳过 `isListenedKey`（其结果反正没被用）。作用：每帧用 justDown=2 路径 **预热** `_justDownKeys` + `_justDownDelayKeys`，形成输入缓冲。

### `isListenedKey`（L131–144）

`ids.indexOf(funcName) != -1`。`isDown` 在 `param4==false` 时算一次，传给 `isJustDownDelay` 的 `param3`，但 **`isJustDownDelay` 不读 param3**（死参）。?

### `render`（L146–161）

1. 遍历 `_justDownDelayKeys`：`>0` 则 `--`，否则 delete。AS3 Number `--` 减 1。
2. `renderListenKeys()`。

与 `FighterKeyCtrl` 谁先跑取决于 `GameRender` Dictionary 插入序。无论先后，0.1s 窗都覆盖「按下后若干帧」。

### 查询包装（L163–231）

全部转 `isDown(type, methodName, justDownFlag)`：

- `anyKey(justDown=0)` / `back(justDown=0)`：type **写死** `"MENU"`。`GameCtrl` / 菜单用 `back(1)` 边沿。
- `select/up/down/left/right/attack/jump/dash/skill/superSkill/special/wankai(type, justDown=0)`：type 由调用方传。

`justDown` 语义见 `isDown`。默认 0 = 按住。UI 普遍传 `1`（边沿，防连跳菜单）。`FighterKeyCtrl` 非经典 `_justDown=2`（缓冲）；经典 = 0（按住即出招）。`catch1/catch2` 写死 `2`。

### `clearInput`（L233–238）

清两个 just-down 表 + `callVoid("clear")`。**不清** `_listenKeys`。

### `isDown`（L240–252）

`param1` type，`param2` 方法名，`param3` 模式，`param4` 是否跳过 listen 检查。

- `param3==1` → `isJustDown`（边沿，按住只真一次）。
- `param3==2` → `isJustDownDelay`（边沿触发后维持 `0.1*fps` 帧）。
- 其它（0）→ `call(type, method)` 当前按住。

`_loc5_ = param4 ? false : isListenedKey(...)` 只传给 delay 路径且未被使用。

### `isJustDown`（L254–269）

key = `type_method`。当前 `call` 为 false → 记 false，return false（松开复位）。为 true 且已经 true → false（按住中）。为 true 且尚未标记 → 标记并 return true。即「按下后第一次查询」。配合 `listenKeys`，第一次查询发生在 `renderListenKeys`，战斗 poll 时边沿已被消费，要靠 delay 窗。

### `isJustDownDelay`（L271–280）

先 `isJustDown`。若本次是边沿，把计数器写成 `0.1 * MainGame.I.getFPS()`（30fps → 3；60fps → 6）。返回「计数器存在且 > 0」。`param3` 未使用。边沿帧与随后若干帧都为 true，形成 0.1 秒输入缓冲。

### `call`（L282–311）

`!enabled` 或没有该 type → false。否则扫 `Vector.<IGameInput>`：跳过 `!enabled`；`device[methodName]` 当 Function；`apply(null, rest)` 为真则 **立刻 return true**（多设备时先到先得）。本包每通道仅 1 个 `GameKeyInput`。

rest：查询方法无参；`setConfig` 把 VO 当 rest[0]。void/`undefined` 当 false，所以 `setConfig` 会跑完整个 Vector。

### `callVoid`（L313–334）

**所有** type 的所有 enabled 设备。`initlize` / `focus` / `clear` 走这里。不看静态 `GameInputer.enabled`。因此 `enabled=false` 时仍可 focus/clear，只是方向/确认全假。
