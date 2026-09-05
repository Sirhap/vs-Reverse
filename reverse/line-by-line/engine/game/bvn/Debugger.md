# `Debugger` — 调试开关、trace、FPS 字、秘籍序列

一句话目的：全静态调试工具。发布包五个开关全是 `false`；`log`/`errorMsg` 仍被加载失败和异常 catch 调用。`initDebug` / `runScriect` 本包无调用方。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/Debugger.as`（114 行）

## Callers / callees

- **Callers（log/errorMsg）**：`GameData.loadConfig` 各 XML 失败、`GameLoadingState` 预载/配置失败、`LoadingState` → `errorMsg`、`GameLoader` 找不到 SWF、`SelectFighterStage.addFighterItem`、`GameCtrl.addGameSprite` team 空、`GameMainLogicCtrler.renderGameSprite` catch、`BaseGameSprite.renderSelfEnterFrame` catch、`FighterEffectCtrl` 未定义必杀特写。
- **Callers（开关 / initDebug / runScriect）**：`decompiled/main/scripts` 内除本文件 **零引用**。`DRAW_AREA` 等 const false 可能在其它文件被 ASC 内联后 DCE，或从未接线。
- **Callees**：`trace`、`Stage`、`TextField`、`Timer`、`KyoKeyCode`（P/L/A/Y）。

## 符号对照 / 命名备注

| 名 | 建议理解 | 说明 |
|----|----------|------|
| `runScriect` | `runScript` | 原拼写。顺序键 P-L-A-Y。 |
| `onErrorMsgCall` | 错误回调 | 本包无人赋值；`errorMsg` 仍 trace。 |

## 逐行说明

### 静态字段（L15–27）

- `onErrorMsgCall`：可选 `Function(String)`。`LoadingState` 走 `errorMsg` 但不设此回调。
- `DRAW_AREA` / `SAFE_MODE` / `DEBUG_ENABLED` / `HIDE_MAP` / `HIDE_HITEFFECT`：全 `false`。名字表明：画判定、安全模式、总开关、藏地图、藏受击特效。发布包等于死代码开关。
- `_stage`：仅 `initDebug` 写入；`addChild`/`showFPS` 依赖它。无人调 `initDebug` 则 `_stage` 恒 null。

### 空构造（L29–32）

全静态。

### `log`（L34–37）

`trace.call(null, rest)`：把 rest 数组当 `trace` 的 arguments。`Debugger.log("a","b")` 实际 `trace(["a","b"])`，输出带方括号，不是 `"a b"`。

### `errorMsg`（L39–46）

先 `trace("Debugger.errorMsg:", msg)`，再若有 `onErrorMsgCall` 则调用。`LoadingState` 加载失败走这里（用户可见 UI 另说）。

### `initDebug`（L48–52）

存 stage，立刻 `showFPS()`。本包无调用。

### `addChild`（L54–57）

往调试 stage 上叠 DisplayObject。无 null 检查。本包无调用。

### `showFPS`（L59–82）

1. 黄字 `TextField`（`0xFFFF00`），`mouseEnabled=false`，addChild 到 `_stage`（默认 0,0）。
2. 每 `enterFrame` `fpsCount++`。
3. `Timer(1000)` 把文本写成 `"fps:" + fpsCount` 后清零。这是 **帧计数/秒**，不是 `1/dt` 平均。
4. 局部变量 `currentTime`、`n` 声明后未用。
5. 监听从不移除。

### `runScriect`（L84–111）

在 `stage` 上听 `keyDown`（weak ref `true`）：

- 目标序列 `KyoKeyCode.P, L, A, Y`。
- 连续命中则 `_keyIndex++`；满 4 键 `_successed=true` 并 `success()`。
- 打错清零。成功后后续 keyDown 直接 return。
- **无**超时，也无 UI 提示。本包无调用，等于死秘籍入口。`success` 回调由调用方决定（未接线，不知道原本要开什么）。
