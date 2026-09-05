# `keyset_mc` — 键位内页根

一句话目的：P1/P2 KEY SET 滑进来的整页。子件 `keysmc` 里摆 `k0`…`k9` 十个键槽。底栏四钮和等键对话框是引擎 `addChild` 上来的，不在本时间轴。

源文件：`decompiled/ui/setting/scripts/keyset_mc.as`（16 行）

## 如何挂上引擎

[`SetCtrlBtnUI`](../../../engine/game/bvn/ui/SetCtrlBtnUI.md) 构造：`createDisplayObject(ResUtils.I.setting, "keyset_mc")` → `ui`。`getUI()` 返回它。[`SettingState.goInnerSetPage`](../../../engine/game/bvn/state/SettingState.md) `_ui.addChild(getUI())` 再 `fadIn()`（从 `GAME_SIZE.y` tween 到 `y=0`）。

引擎往本 MC 上叠：

| 谁 | 位置 |
|---|---|
| [`SetBtnGroup.initKeySet`](../../../engine/game/bvn/ui/SetBtnGroup.md) | SET ALL / SET DEFAULT / APPLY / CANCEL，`startY=30`，`ui.addChild(_btnGroup)` |
| [`SetBtnDialog`](../../../engine/game/bvn/ui/SetBtnDialog.md) | `ui.addChild(_dialog.ui)`，默认 hidden |

`initKeyMapping`：`ui.keysmc.getChildByName("k"+i)`，`i=0…9`。缺则 `trace("mc[kN]不存在！")` 并跳过。槽与 [`KeyMapping`](../../../engine/game/bvn/ui/KeyMapping.md) / `KeyConfigVO` 字段：

| i | id | 对话框英文 | 中文 |
|---|---|---|---|
| 0 | `up` | UP | 上 |
| 1 | `down` | DOWN | 下 |
| 2 | `left` | LEFT | 左 |
| 3 | `right` | RIGHT | 右 |
| 4 | `attack` | ATTACK | 攻击 |
| 5 | `jump` | JUMP | 跳跃 |
| 6 | `dash` | DASH | 冲刺 |
| 7 | `skill` | SKILL | 技能 |
| 8 | `superKill` | SUPER SKILL | 大招 |
| 9 | `beckons` | SPECIAL | 特殊 |

`KeyMapping` 把变暗的 `BitmapFontText` `addChild` 到对应 `kN` Sprite。本 AS 不声明 `k0`…`k9`（在 `keysmc` 时间轴里）。

SWF：`setting`，链接名 `keyset_mc`，`symbol="symbol38"`。

## 逐行说明

### 包与 Embed（L1–6）

无名包。`public dynamic class keyset_mc extends MovieClip`。[Embed] `symbol="symbol38"`。

### 字段（L9）

| L | 名字 | 类型 | 用途 |
|---|---|---|---|
| L9 | `keysmc` | `MovieClip` | 十键槽容器。引擎只从这里 `getChildByName("k0")`…`"k9"` |

### 构造 `keyset_mc()`（L11–14）

- L13: `super();`
- 无 `addFrameScript`。滑入/滑出是 `TweenLite` 改本实例 `y`，不播时间轴。
