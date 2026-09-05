# `SelectedFighterGroup` — 选人底部已选头像叠

一句话目的：选人阶段屏幕底部的已选条。每确认一人（未满次数）`addFighter` 叠一张新 `SelectedFighterUI`，旧卡缩小上移；当前槽 `_curUI` 给 `updateFighter` 刷 hover / 随机闪。出战顺序 UI **不用** 本类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/SelectedFighterGroup.as`（79 行）

## Callers / callees

- **创建**：`SelectUIFactory.createSelecter` `new SelectedFighterGroup(cls)` + `addFighter(null)` 占第一槽。赋给 `SelecterItemUI.group`。
- **addChild**：`SelectFighterStage.initSelecterP*` `_ui.addChild(_p*Slt.group)`。P1 x=10，P2 x=535，y=520。
- **`updateFighter`**：`SelectFighterStage.moveToSelectFighter` / `renderRandom`（hover、随机闪）；`SelecterItemUI.setCurrentSelect`（联机灌选择，先 update fighter1 再 add 后两个）。
- **`addFighter`**：`SelectUIFactory` 空槽；`SelecterItemUI.select` 在 `!selectFinish()` 时（小队第 1、2 人）；`setCurrentSelect` 的 fighter2/3。
- **摘除**：`SelecterItemUI.removeGroup` / `destory` `removeChild(group)`。VsCPU `nextStep` 只 `removeSelecter` 留 group，但 `playerSeltBack` 随后 `destory` 仍会 `removeGroup` —— P1 底条在「替 CPU 选」时被拆掉。见 `SelectFighterStage.md`。
- **Callees**：`SelectedFighterUI`、`TweenLite` 0.1s。
- **死字段对照**：`SelectFighterStage._p1SelectedGroup/_p2SelectedGroup` 从未赋值，`clear` 里 destory 的是 null。真组是 `SelecterItemUI.group`。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | destroy 拼写。只 destory `_curUI`，**不**遍历 `_uis`。 |
| `_uiClass` | `selected_item_p1_mc` 或 `p2_mc`。 |
| `_uis` | 所有卡片，含已被 `_curUI.destory()` 摘了字的旧槽。 |
| `_curUI` | 最上面那张，hover / 随机只改它。 |

叠放直觉（3 人小队确认两次后，第三张仍是当前预览）：

| 槽 | 含义 | 典型 scale / y |
|---|---|---|
| 最早 | 已确认 1 | 更小、更上、更淡 |
| 中间 | 已确认 2 | 中 |
| `_curUI` | 当前 hover | scale 1，y=0 |

最后一次确认（`selectFinish`）**不再** `addFighter`，第 3 人就留在当前预览槽。

## 逐行说明

### 包与 import（L1–5）

`Sprite`。无 ResUtils —— Class 由工厂注入。

### 字段 / 构造（L10–20）

`_uis=[]`，`_curUI` 空。构造只存 `_uiClass`。坐标由工厂写在本 Sprite 上。

### `destory`（L22–29）

有 `_curUI` 则 `destory` 置 null。**不** destory `_uis` 里其它张，**不** `TweenLite.kill`，**不** `removeChild` 自己（`SelecterItemUI.removeGroup` 负责摘显示列表）。旧卡 `SelectedFighterUI` 泄漏到 GC。?

### `addFighter`（L31–71）

`param1` 可 null（工厂占槽）或 `FighterVO`。

先按 **当前** `_uis.length` 算旧卡目标：

```
spacing = 20 - (length-1)*3
y       = length * -20          // 从最上面开始
alpha   = 0.7 - (length-1)*0.3
scale   = 0.85 - (length-1)*0.15
```

然后对已有每张 `TweenLite.to(ui, 0.1, {y, alpha, scaleX, scaleY})`，每张之后 `y+=spacing`、`alpha+=0.3`、`scale+=0.15`（越新越大越实）。

length 0（第一张）：循环 0 次。spacing/alpha/scale 公式里 `(0-1)` 得到 spacing=23、alpha=1、scale=1，反正用不上。

length 1→2：旧卡 y=-20、alpha=0.7、scale=0.85。

length 2→3：最旧 y=-40、a=0.4、s=0.7；中间 y=-23、a=0.7、s=0.85。

新卡：`new SelectedFighterUI(new _uiClass())`。`param1` 有则 `setFighter`。`ui.y=50`，`TweenLite.to(..., 0.1, {y:0, delay:0.05})`。`addChild` + `_uis.push`。

若已有 `_curUI`：先 `_curUI.destory()`（摘监听、`BitmapText.destory`，**不**摘 MC）。旧脸还在叠层里，只是中文名没了。? 然后 `_curUI =` 新卡。

小队路径：工厂空槽 → hover `updateFighter` 填脸 → 确认 1 `addFighter(f1)` 把预览 destory 字、新卡也是 f1，随后 `moveSlt` `updateFighter` 把新卡改成下一人 hover。视觉上底部留下「已确认缩小 + 当前大图」。

### `updateFighter`（L73–76）

`_curUI.setFighter(param1)`。无 `_curUI` 会 NPE。工厂已 `addFighter(null)`，正常有。`param1` 空时 `setFighter` 直接 return（空槽保持空）。随机闪每两帧一次，每次新 Bitmap（`getFighterFace*` 每次 new Bitmap）。
