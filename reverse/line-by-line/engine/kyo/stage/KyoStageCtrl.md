# `KyoStageCtrl` — 单屏状态机

一句话目的：在一个根 Sprite 上切换 `Istage`。`MainGame` 所有 `goXxx` 都走 `goStage`。图层 API（`addLayer`）本包编译进来但没人调。

源文件：`decompiled/main/scripts/net/play5d/kyo/stage/KyoStageCtrl.as`（257 行）

## Callers / callees

- **Callers（构造）**：`MainGame.initlize` L88：`stageCtrl = new KyoStageCtrl(_rootSprite)`。静态字段 `MainGame.stageCtrl`。
- **Callers（`goStage`）**：`MainGame` 全部切屏：
  - 启动 `GameLoadingState`（无 `sameChange`）
  - `goLogo` / `goMenu` / `goHowToPlay` / `goSelect` / `goOption` / `goCredits` / `goCongratulate`
  - `loadGame` → `LoadingState`，**`sameChange=true`**（同类名可重入）
  - `goGame` / `goContinue` / `goGameOver` / `goWinner`
- **Callers（`currentStage`）**：`Ctrler4399` 把当前屏 as `GameOverState` / `CongratulateState` 插提交分按钮。
- **Callees**：`Istage`、`IStageFadEffect`、`KyoStageEvent`、`getQualifiedClassName`、`setTimeout`。
- **本包无调用**：`addLayer` / `hasLayer` / `noneLayer` / `removeLayer` / `removeAllLayer` / `clean` / `changeStateMouseGap`（默认 0）。`KyoStageEvent.CHANGE_STATE` 每次 `goStage` 都派，本 SWF **无** listener。

## 命名备注

- `destory` / `detoryComplete`（闭包名少一个 s）。
- `IStageFadEffect.fadIn` / `fadOut`：fade 的原拼写。
- 主屏 `_curStage` 与图层 `_layers` 两套互不干扰：`goStage` 不碰图层，`addLayer` 不碰主屏。

## 接到主链的位置

```
MainGame.initlize
  → new KyoStageCtrl(_rootSprite)
  → goStage(GameLoadingState)
       destory 旧（首次无）
       build → addChild(display) → afterBuild
       dispatch CHANGE_STATE
  → goLogo → LogoState → … → GameState
```

`loadGame` 是唯一 `sameChange=true`：从 `SelectFighterStage` 再进 `LoadingState` 时，若当前已经是 `LoadingState`（Winner 再战）不会被同类名门挡住。

## 逐行说明

### 字段（L13–19）

- `_mainStage`：游戏根 Sprite（`bleachvsnaruto` 交给 `MainGame` 的那个）。所有 stage display 挂在它上面。
- `_curStage`：当前主 `Istage`。
- `changeStateMouseGap`：切屏后禁止 `stage.mouseChildren` 的毫秒。默认 0，不生效。
- `_layers`：叠加层数组。本游戏空。

### 构造（L21–25）

`param1` 赋给 `_mainStage`。`super()` 因为继承 `EventDispatcher`。

### `currentStage`（L27–30）

只读 `_curStage`。

### `goStage`（L32–95）

签名：`(stg, sameChange=false, buildAfterDestory=false) → Boolean`。

闭包：

- `detoryComplete`（L40–52）：`try removeChild(_curStage.display)`，失败 `trace("KyoStageCtrl: goStage:", e)`。然后 `_curStage = null`，调 `newStage`。
- `newStage`（L53–67）：若 `changeStateMouseGap > 0`，关 `stage.mouseChildren`，`setTimeout` 再开。然后 `_curStage = stg` → `build()` → `addChild(display)` → `afterBuild()`。**同步**，无淡入。

主体：

1. **同类名门**（L68–76）：`sameChange==false` 时用 `getQualifiedClassName` 比新旧。相等 return `false`，**不** destory、**不** dispatch。`_curStage` 为 null 时 `getQualifiedClassName(null)` 是 `"null"`，不会误撞。
2. **有旧屏**（L77–87）：
   - `buildAfterDestory=true`：`destory(detoryComplete)`，等回调才卸。本游戏恒 false。
   - 否则 `destory()` 无参，立刻 `detoryComplete()`。
3. **无旧屏**（L89–92）：直接 `newStage()`。
4. L93 **无论是否真切了都会走到这里**——不对：同类名提前 return。其它路径（含「有旧屏」）在 destory **之前** 就 dispatch `CHANGE_STATE`，payload 是**新** `stg`。若 `buildAfterDestory`，事件会在新屏 `build` 之前发出。?
5. return `true`。

`MainGame.loadGame` 传 `sameChange=true`，跳过同类名门。第三参从不传。

### `addLayer`（L97–153）

叠加一层 `Istage`，不替换 `_curStage`。

`param2/param3` = x/y。`isNaN(x)` 则水平居中：`(stageWidth - display.width * scaleX) / 2`。宽用的是 **已乘 scale 的 display 宽** 对 **未缩放的 stageWidth**，根 Sprite 若被缩放，居中会偏。? `y` 同理。

`removeElse=true` 先 `removeAllLayer()`。然后 `layer.build()`，设坐标，`addChild`。有 `effect` 则 `fadIn(layer, effectBack)`，否则立刻 `effectBack` → `afterBuild` + `addBack`。最后 `_layers.push`。

本包零调用。无 `IStageFadEffect` 实现。

### `hasLayer`（L155–178）

`param1` 可以是 `Istage` 实例（引用相等）或 `Class`（`is` 判断）。循环里两个 `if` **不互斥**：传入实例时两个都跑，第二个 `param1 is Class` 对实例为 false。空数组 false。

### `noneLayer`（L180–183）

`_layers.length == 0`。

### `removeLayer`（L185–221）

有 `effect` 则 `fadOut` 完再卸；否则立刻。`effectFin`：`removeChild` + `destory()`（**先卸再 destory**，与 `goStage` 相反）→ `_layers.splice` → `removeBack`。`indexOf == -1` 不 splice。catch 只包 removeChild/destory。

### `removeAllLayer`（L223–231）

`for each` 调 `removeLayer`（无效果、无回调），然后 `_layers = []`。`removeLayer` 已经 splice，循环中途改正在迭代的数组。AS3 `for each` 对 Array 行为依赖实现；可能漏层。? 随后整表替换，残留引用丢掉。本包无调用。

### `clean`（L233–245）

`param1` 默认 true：先清图层。然后若有 `_curStage`：`destory()` + `removeChild` + null。**不** try/catch。display 已不在列表会抛。本包无调用。

### `stageMouseChildren`（L247–253）

私有 setter。`_mainStage.stage` 空则空操作。只给 `changeStateMouseGap` 用。
