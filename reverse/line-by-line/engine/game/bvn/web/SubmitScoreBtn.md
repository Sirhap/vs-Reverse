# `SubmitScoreBtn` — 结束画面「提交分数」PNG 按钮

一句话目的：嵌入的 215×75 提交分图，hover 提亮 + 音效，click 调 `Ctrler4399.submitScore()`。无 Hold 时按钮仍在，点了只 trace。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/web/SubmitScoreBtn.as`（64 行）

## Callers / callees

- **Callers**：仅 `Ctrler4399.gameHandler`。GAME_OVER 坐标 `(570,600)` tween 到 y=500；GAME_PASS_ALL `(560, getBtnY()+40)`。
- **Callees**：`SoundCtrl.I.sndSelect` / `sndConfrim`（保留 Confirm 少 i）、`Ctrler4399.submitScore`。

## 命名备注

嵌入图：`submitscore_png$2019b938d40548ede75322f262e40e85-2138765347`（`§` 因哈希里的 `-`）。不走 ZIP / ResUtils。

无 `destory`、不卸监听。结束 State 被舞台切走后随显示列表回收。

## 逐行说明

### 字段（L12–16）

- `_asset`：PNG 的 Bitmap Class。
- `_png`：实例，hover/按下改它而不是整个 Sprite。
- `_highCt`：高亮 `ColorTransform`。

### 构造（L18–36）

`param1/param2` 默认 0，当 x/y。`buttonMode=true`、`mouseChildren=false`（点到图也算点按钮）。

`new _asset()` → smoothing、addChild。`ColorTransform` 的 RGB offset 全 `30`（hover 发白）。

监听 `click` / `mouseUp` / `mouseDown` / `mouseOver` / `mouseOut`（字符串，即对应 `MouseEvent` 常量）。

### `mouseHandler`（L38–60）

| type | 行为 |
|------|------|
| `mouseOver` | `_png` 换 `_highCt`；`sndSelect()` |
| `mouseOut` | 还原空 `ColorTransform()`（不复用对象） |
| `mouseDown` | `_png.y = 5`（按下位移，父 Sprite 不动） |
| `mouseUp` | `_png.y = 0`，`alpha = 1`（alpha 从未被改过，这行无实际效果） |
| `click` | `sndConfrim()` + `Ctrler4399.submitScore()` |

没有 `removeEventListener`。按下后拖出再 mouseUp 仍会把 y 拉回 0。
