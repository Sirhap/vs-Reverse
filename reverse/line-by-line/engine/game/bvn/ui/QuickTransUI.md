# `QuickTransUI` — 上下黑幕快切

一句话目的：两块 800×300 黑 `Box` 从屏幕上下合拢再打开（各 TweenLite 0.1s）。只给 `StateCtrl.quickTrans` 用，跳过 1v1 开场。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/QuickTransUI.as`（56 行）

## Callers / callees

- **Callers**：只 `StateCtrl.quickTrans`。懒 `new QuickTransUI()`，`addChild` 到 `MainGame.I.root`，`fadInAndOut(transCom)`；播完 `removeChild` 再调 back。`GameStartCtrl.skip` 在 intro step<5 时走这条（不播 `trans_mc`）。
- **Callees**：`kyo.display.shapes.Box`（宽 `GAME_SIZE.x`、高 `_center`，默认色 0 / alpha 1 = 不透明黑）；`TweenLite`；`GameConfig.GAME_SIZE`（800×600 → `_center=300`）。

## 命名备注

`fadIn` / `fadOut` / `fadInAndOut` 拼写与 `TransUI` 相同。本类 **extends Sprite**，`StateCtrl` remove 的是实例本身；`TransUI` remove 的是 `.ui`。

**不看** `StateCtrl.transEnabled`。无 destory。连点 skip 会叠加 Tween（`StateCtrl` 也无打断）。

## 逐行说明

### 字段 / 构造（L11–25）

- `_center = GAME_SIZE.y / 2`（300）。
- `_up` / `_down`：`new Box(800, 300)` 各一块。合拢后 `_up` 盖 0–300，`_down` 盖 300–600，满屏黑。
- 构造只 `addChild` 两块，**不**设初始 y（默认 0）。真正入场坐标在 `fadIn` 里写。若尚未 `fadIn` 就已在舞台，两块会叠在 (0,0) 盖住上半屏；实际 `StateCtrl` 先 new 再立刻 `fadInAndOut`。

### `fadInAndOut`（L27–34）

`(back=null)`。`fadIn` 完成后再 `fadOut(back)`。`fadIn` 的 onComplete 只挂在下幕，所以上幕若被杀 Tween 仍可能先结束。

### `fadIn`（L36–45）

合拢：

1. `_up.y = -_center`（-300，整块在屏外上方）。
2. `_down.y = GAME_SIZE.y`（600，整块在屏外下方）。
3. 0.1s：`_up` → `y=0`（上缘对齐屏幕顶）。
4. 0.1s：`_down` → `y=_center`（300，上缘对齐中线）。`onComplete=param1`。

### `fadOut`（L47–54）

揭开，与 fadIn 对称：`_up` → `-_center`，`_down` → `GAME_SIZE.y`，同样 0.1s，onComplete 在下幕。`StateCtrl` 的 `transCom` 在这里卸 Sprite 再调业务 back。
