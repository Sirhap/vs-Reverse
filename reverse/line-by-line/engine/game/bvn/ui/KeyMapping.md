# `KeyMapping` — 键位页上的单个键名显示

一句话目的：设置页 `keyset_mc` 里一颗键的位图文字。`SetCtrlBtnUI` 为每个 `k0…k9` 槽 `new KeyMapping`，用 `KyoKeyCode.code2name` 把 keyCode 画成大写名。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/KeyMapping.as`（71 行）

## Callers / callees

- **Callers**：只 `SetCtrlBtnUI`（ui 包，本批不写）。
  - `initKeyMapping`：对 `ui.keysmc` 子级 `k0`–`k9` 各 `new KeyMapping(mc, id, name, cn)`，id 为 `up/down/left/right/attack/jump/dash/skill/superKill/beckons`。
  - `updateKeyMapping`：`_keyMap[id].setKey(_tmpKeyConfig.<field>)`，只传 keyCode。
  - `onKeyDown` / `setNextKey`：读 `.keyId` / `.name` / `.cn`（中英文名给 `SetBtnDialog.show`），再 `setKey(keyCode, name)`（第二实参是刚按下的键名，避免再查表）。
- **Callees**：`AssetManager.I.getFont("font1")` → `BitmapFontText`（kyo.display.bitmap）；`fl.motion.ColorMatrix` + `ColorMatrixFilter` 把字做成暗灰；`KyoKeyCode.code2name`（kyo.input）。

## 命名备注

`keyId` 与 `KeyConfigVO` 字段同名（含 `beckons`）。`name` 是英文标签（`"SUPER SKILL"` / `"SPECIAL"`），`cn` 是中文（`"大招"` / `"特殊"`）。本类不画 `name`/`cn`，只画当前键名。

## 逐行说明

### 字段（L13–21）

- `name` / `cn`：动作英文/中文。`SetCtrlBtnUI.setNextKey` 拿去给改键对话框。
- `mc`：SWF 里的键槽 Sprite（`kN`），本类把文字 `addChild` 上去。
- `keyId`：配置字段名。
- `_keyTxt`：位图字。

### 构造（L23–36）

`(mc, keyId, name, cn)`。`new BitmapFontText(font1)`。`ColorMatrix.SetBrightnessMatrix(-100)` + `SetSaturationMatrix(0)` → 灰度且压暗，贴在键帽图上不像白字。filter 用 `GetFlatArray()` 做 `ColorMatrixFilter`。文字加到 `param1`（键槽），锚点默认 (0,0)，真正居中在 `setKey`。

### `setKey`（L38–69）

`(keyCode, displayName=null)`。

1. 无 `displayName` 则 `KyoKeyCode.code2name(keyCode)`。表里没有的码返回 `null`；随后 `param2.toUpperCase()` **NPE**。`updateKeyMapping` 走这条；默认键都在表内。`SetCtrlBtnUI.onKeyDown` 先查表、失败直接 return，再把 name 传入，避开这坑。
2. `_keyTxt.text = param2.toUpperCase()`（位图字按字符拼，宽度随内容变）。
3. 默认：最大宽 `_loc5_=0` 稍后改、缩放 `_loc4_=1`、Y 偏 `_loc3_=0`。
4. `keyId` 为 `up/down/left/right`：缩放 0.8，最大宽 40，Y 偏 +5（方向键槽更小、略下移）。否则最大宽 60。
5. 若文字宽 > 最大宽：钳 `width`，`scaleY = scaleX`（等比压扁长名，如 `"PAGEUP"`）。
6. 否则 `scaleX = scaleY = _loc4_`（方向键 0.8，其它 1）。
7. 居中：`x = -width/2`，`y = -height/2 + _loc3_`。相对键槽原点。

改一次键会 `setKey` 一次；`SET DEFAULT` / `setKey(KeyConfigVO)` 会十条全刷。
