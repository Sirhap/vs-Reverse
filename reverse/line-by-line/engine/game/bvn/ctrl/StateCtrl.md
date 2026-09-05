# `StateCtrl` — 场景切换遮罩（淡入 / 淡出 / 快切）

一句话目的：在 `MainGame.I.root` 顶上盖转场 UI。`transIn` 播 `trans_mc` 淡入（切状态前挡画面），`transOut` 淡出（新状态出现后揭开），`quickTrans` 上下黑幕夹一下（跳过开场用）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/StateCtrl.as`（150 行）

## Callers / callees

- **Callers**：
  - `SelectFighterStage.goLoadGame`：`transIn(MainGame.I.loadGame)`（默认不自动卸 UI）。
  - `SelectFighterStage.build`：`clearTrans()` 清残留。
  - `LoadingState` 加载完：`transIn(MainGame.I.goGame, false)` —— 第二实参 false 表示播完 **不**卸；`afterBuild`：`transOut()`（默认卸）。
  - `GameStartCtrl.preRenderStart`：`transOut(callback, true)` 揭开对局；`startNextRound`：`transOut(null, true)`；`skip` 开场：`quickTrans()`。
  - `GameEndCtrl` 回合结束演出 step2：`transIn(callback, false)` 盖住再切下一回合。
  - `TrainingCtrler`：`transOut(null, true)`。
  - `WinnerState.goNext`：`transIn` 里 `messionComplete` + `loadGame`。
  - `GameOverState.build`：`clearTrans()`。
- **Callees**：`MainGame.I.root` 当容器；`TransUI`（`ResUtils` 的 `trans_mc`，自己挂 `GameRender` 逐帧 `nextFrame`）；`QuickTransUI`（两块 `Box` + TweenLite 0.1s）。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `transIn` / `transOut` | 对玩家：In=变黑/盖住，Out=揭开。对应 `TransUI.fadIn`/`fadOut` 标签 `fadin`/`fadout` |
| `fadIn`/`fadOut` | fade 的原拼写，贯穿 TransUI/QuickTransUI |
| `removeTrainsUI` | trains ≠ trans，原拼写 |
| `removeAfterComplete` | transIn 默认 **false**（盖住留着等 transOut）；transOut 默认 **true**（揭开后卸） |
| `transEnabled` | 默认 true。本包 **无写入**，恒开启。false 时立刻调 back、不播动画 |

## 逐行说明

### 字段（L11–19）

- `_i`：单例。
- `transEnabled`：总开关。
- `_transUI`：懒创建，复用同一 `trans_mc`。
- `_quickTransUI`：懒创建，是 Sprite 本身（不是 `.ui` 包装）。
- `_transContainer`：构造里设为 `MainGame.I.root`。`StateCtrl.I` 若在 `MainGame.initlize` 完成前被碰，`MainGame.I`/`root` 可能仍空 → 容器 null，之后 addChild 会炸。实际首次调用在选人结束，那时 root 已有。

### 构造 / `I`（L21–34）

构造读 `MainGame.I.root`。`I` 懒 new。重复 `new` 会换单例但本包只走 getter。

### `addTransUI`（L36–43）私有

无 `_transUI` 则 `new TransUI()`。`addChild(_transUI.ui)` 到 root。已在舞台上再 addChild 会把它移到最顶（Flash 规则），正好盖住刚切来的状态。

不检查 `ui` 是否已是 child；`remove` 失败也不管。

### `removeTrainsUI`（L45–54）私有

`try removeChild(_transUI.ui) catch {}`。`_transUI` 仍保留，下次 trans 复用。若从未 `addTransUI` 就 remove，`_transUI` 空会 NPE 进 catch，静默。

### `transIn`（L56–85）

`(back=null, removeAfterComplete=false)`。

1. `!transEnabled`：立刻 `back()` return。
2. `addTransUI()`。
3. `removeAfterComplete` 为真：`fadIn(removeSelf)`，播完先 `back()` 再卸 MC。
4. 默认假：`fadIn(back)`，播完只调 back，**MC 留在舞台**（停在 `trans_mc` 的 `"stop"` 帧，通常是满屏遮罩）。这是切状态的标准用法：先盖住 → back 里 `goStage` → 新状态 `afterBuild` 再 `transOut` 揭开。

`TransUI.fadIn`：`gotoAndStop("fadin")`，每动画帧 `nextFrame`，直到 label `"stop"` 调 callback。动画速率跟 `MainGame.getFPS()/30` 对齐。

`LoadingState` 传 `false` 显式保留遮罩，避免加载完成到 `goGame` 之间露馅。`SelectFighterStage` 用默认 false。`GameEndCtrl` 同样 false，让下一回合开场 `transOut` 再揭。

### `transOut`（L87–116）

`(back=null, removeAfterComplete=true)`。

结构与 transIn 对称，调 `fadOut`。默认揭开后 **卸** MC。`LoadingState.afterBuild` 的 `transOut()` 无参，走默认 true：新对局出现后遮罩播完移除。

`GameStartCtrl` 显式 `true`。若上一层 transIn 已经卸掉 UI，这里 `addTransUI` 会重新挂上再播 fadout —— 可能闪一帧遮罩。正常配对是 In 不卸、Out 才卸。

`!transEnabled` 同样立刻 back。

### `quickTrans`（L118–141）

上下黑条快速合上再打开。`GameStartCtrl.skip` 跳过 1v1 开场时用，不走 `trans_mc` 长动画。

1. 闭包 `transCom`：try `removeChild(_quickTransUI)`，再 `back()`。
2. 懒 `new QuickTransUI()`（两块 800×300 的 `Box`，中线 300）。
3. `addChild` 到 root（盖住战斗层）。
4. `fadInAndOut(transCom)`：0.1s 合拢 + 0.1s 打开（TweenLite），结束卸掉。

**不看 `transEnabled`**。没有「已在播则打断」；连点 skip 会重复 addChild/Tween。`_quickTransUI` 与 `_transUI` 独立，可以叠在 trans_mc 上面。

`QuickTransUI` 自身是 Sprite，removeChild 的是它；`TransUI` remove 的是 `.ui`。

### `clearTrans`（L143–146）

只 `removeTrainsUI()`。不卸 QuickTrans，不停 Tween。选人/GameOver 进入时清掉可能还盖着的 `trans_mc`（例如从战斗 transIn 过来但新状态自己负责画面）。不调 `TransUI.destory`，其 `GameRender` 回调若还在跑，MC 不在舞台仍会 `nextFrame` 直到碰到 `"stop"`。`fadIn` 在 stop 时若 `_fadInBack` 非空会调它；clear 中途卸 display 不 `stopRender`，`?` 可能在后台把剩余帧走完并触发旧 back。选人 `clearTrans` 发生在 build，通常上一转场已结束。
