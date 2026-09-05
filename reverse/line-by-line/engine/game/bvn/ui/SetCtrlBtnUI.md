# `SetCtrlBtnUI` — 键位内页（`IInnerSetUI` + `keyset_mc`）

一句话目的：设置主列表 P1/P2 KEY SET 滑进来的子页。实现 `IInnerSetUI`。`setKey` 把 `KeyConfigVO` clone 成临时表，画面上 10 个 `KeyMapping` 显示当前键名。SET ALL 逐键弹出 `SetBtnDialog` 等键盘；APPLY 把临时表 `readSaveObj` 写回原 VO 再派 `"APPLY_SET"`；CANCEL 只派 `"CANCEL_SET"` 丢副本。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/SetCtrlBtnUI.as`（257 行）

## Callers / callees

- **Callers**：仅 `SettingState.goKeyConfig`：`new SetCtrlBtnUI()` → `setKey(key_p1|key_p2)` → `goInnerSetPage`。`param1` 玩家号（1/2）**本函数未用**，只靠传入哪份 `KeyConfigVO`。`SettingState` 听 `"APPLY_SET"` / `"CANCEL_SET"`，两者都只 `goMainSetting()`；真正写回发生在本类派 APPLY 之前。
- **Implementor**：`interfaces.IInnerSetUI` —— `fadIn` / `fadOut` / `getUI` / `destory` + `IEventDispatcher`。本包唯一实现。
- **Callees**：`ResUtils.I.setting` 的 `keyset_mc`；`SetBtnGroup.initKeySet`；`SetBtnDialog`；`KeyMapping`；`KeyConfigVO.clone` / `toSaveObj` / `readSaveObj`；`GameData.I.config.setDefaultConfig`；`KyoKeyCode.code2name`；`MainGame.I.stage` 听 `"keyDown"`；`TweenLite`；`SetBtnEvent("APPLY_SET"|"CANCEL_SET")`；`GameConfig.GAME_SIZE`。

## 命名备注 / 符号对照

| 名 | 说明 |
|----|------|
| `fadIn` / `fadOut` | fade 少 e。接口同名 |
| `destory` | destroy 的原拼写 |
| `_tmpKeyConfig` | 编辑副本。CANCEL 直接丢；APPLY 才写回 `_keyConfig` |
| `_keyMap` | `keyId → KeyMapping`，供 `updateKeyMapping` 按字段名写 |
| `_keyMappings` | 顺序数组，SET ALL 按这个次序问键 |
| `_setKeyIndex` | SET ALL 当前问到第几个。开始前是 -1，`setNextKey` 先 ++ |
| `beckons` | 召唤/特殊键。UI 英文是 `SPECIAL` |
| `superKill` | 大招。UI 英文是 `SUPER SKILL` |

### 十个键位槽（`ui.keysmc` 子级 `k0`…`k9`）

| i | `id`（VO 字段） | `name`（对话框英文） | `cn` |
|---|-----------------|----------------------|------|
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

缺 `kN` 时 `trace("mc[kN]不存在！")` 并跳过，该 id 不进 `_keyMap`。随后 `updateKeyMapping` 对缺的 id 会 NRE。本包 `keyset_mc` 应有 k0–k9。

### 底栏四钮（`SetBtnGroup.initKeySet`）

| label | 行为 |
|-------|------|
| SET ALL | stage 听 keyDown；逐个 Dialog；写 `_tmpKeyConfig` |
| SET DEFAULT | `config.setDefaultConfig(_tmpKeyConfig)` 按 VO.id 恢复出厂，刷新显示。**不**写回 `_keyConfig`，要再 APPLY |
| APPLY | `_keyConfig.readSaveObj(_tmpKeyConfig.toSaveObj())`；派 `APPLY_SET` |
| CANCEL | 派 `CANCEL_SET`。临时表丢弃 |

默认键见 `ConfigVO.setDefaultConfig`：P1=WASD+JKL UIO；P2=方向+小键盘 1–6。菜单键 `key_menu` 不走本页。

## 逐行说明

### 字段（L21–34）

- `ui:keyset_mc`：根。`getUI()` 返回它。`SettingState` `addChild(getUI())`。
- `_keyMappings:Array` / `_keyMap:Object`。
- `_keyConfig`：正在编辑的那份（`key_p1` 或 `key_p2` 的原引用）。
- `_btnGroup:SetBtnGroup`。
- `_dialog:SetBtnDialog`。
- `_tmpKeyConfig`：clone。
- `_setKeyIndex`：SET ALL 游标。

本类 **extends EventDispatcher**，显示对象是 `ui` 不是 `this`。事件（APPLY_SET）派在逻辑对象上，和 `IInnerSetUI` 设计一致。

### 构造（L37–48）

`super()` 之后：

1. `createDisplayObject(setting, "keyset_mc")`。
2. `new SetBtnGroup()`，`startY=30`，`initKeySet()`（同时 `GameRender.add(render, group)` + 开输入）。
3. Group 听 `"SELECT"` → `onBtnSelect`。`ui.addChild(_btnGroup)`。
4. `new SetBtnDialog()`，`ui.addChild(_dialog.ui)`（默认 hidden）。
5. `initKeyMapping()` 绑 k0–k9。此时还没有 VO，`KeyMapping` 文本空着，等 `setKey`。

构造里 **不** `keyEnable=false`。Group `initKeySet` 已 `keyEnable=true`。`SettingState.goInnerSetPage` 先 `addChild` 再 `fadIn`；`fadIn` 把 `ui.y` 放到屏底再滑上来，滑入期间底栏已经能吃键盘。`fadIn` 结束才又 `keyEnable=true`（冗余），并 `setArrowIndex(0)`。?

### `destory`（L51–65）

只处理 `_btnGroup`：try `ui.removeChild`，卸 `"SELECT"`，`destory()` 置空。

**不**处理：`_dialog`（无 destory）、`KeyMapping` 的 `BitmapFontText`、SET ALL 期间挂在 `stage` 上的 `"keyDown"`。若在问键中途按 CANCEL：`onBtnSelect` 立刻派 `CANCEL_SET` → `SettingState.goMainSetting` → `fadOut`，**不** `removeEventListener("keyDown")`。之后 `destoryInnerSetUI` 只在**再次进入**或整个 Setting destory 时才调。`goMainSetting` **不** destory 内页，只 `fadOut`。所以：SET ALL 中途 CANCEL，stage 上的 keyDown **还在**，`onKeyDown` 仍会改已经 fadOut 的临时表 / 可能 NRE。?

正常 SET ALL 走完 `setNextKey` 会自己卸 listener。APPLY 不走 SET ALL 则没挂过。

### `getUI`（L68–70）

返回 `ui`。接口要求。

### `setKey`（L73–77）

`_keyConfig = param1`；`_tmpKeyConfig = param1.clone()`（`new KeyConfigVO(id)` + `readSaveObj(toSaveObj())`，`id` 保留所以 SET DEFAULT 能按 1/2 分支）。`updateKeyMapping()` 把临时表刷到 10 个槽。

`SettingState` 每次进键位页都 `new SetCtrlBtnUI()`，不会在同一实例上 `setKey` 两次。

### `updateKeyMapping`（L80–91）

十次 `_keyMap[id].setKey(_tmpKeyConfig[id])`。只传 keyCode，键名由 `KeyMapping` 内 `KyoKeyCode.code2name`。字段名与 VO 一一对应，含 `superKill` / `beckons`。

### `initKeyMapping`（L94–159）

`ui.keysmc` 当容器。硬编码 10 个 `{id, name, cn}`（见上表）。

循环 `k0`…`k9`：`getChildByName("k"+i) as Sprite`。没有则 `trace` 中文「mc[kN]不存在！」并 continue。有则 `new KeyMapping(sprite, id, name, cn)`，push 进 `_keyMappings`，`_keyMap[keyId] = mapping`。

`KeyMapping` 会把变暗的 `BitmapFontText` 加到该 sprite 上。方向键槽用更小字（见 `KeyMapping.setKey`，本批不逐行，只作 callee）。

### `onBtnSelect`（L162–183）

`switch(selectedLabel)`：

**SET ALL**

1. `MainGame.I.stage.addEventListener("keyDown", onKeyDown)`。原生 KeyboardEvent，**不**走 `GameInputer`（此时 `keyEnable=false`，Group 也不会抢）。
2. `stage.focus = stage`（避免焦点在 TextField 上吞键）。本页中文 Dialog 的 `txt` 默认 `mouseEnabled` 未关，理论上能抢焦点；强制拉回 stage。
3. `_setKeyIndex = -1`。
4. `_btnGroup.keyEnable = false`。
5. `setNextKey()` → 问 UP。

**SET DEFAULT**

`GameData.I.config.setDefaultConfig(_tmpKeyConfig)`：按 `_tmpKeyConfig.id` 灌出厂键（P1 WASD+JKL UIO，P2 方向+小键盘）。然后 `updateKeyMapping()`。原 `_keyConfig` 不动，界面已是默认，要 APPLY 才持久。

**APPLY**

`_keyConfig.readSaveObj(_tmpKeyConfig.toSaveObj())` 覆盖 10 个键码（`id` 不在 save 对象里）。`dispatchEvent(new SetBtnEvent("APPLY_SET"))`。`SettingState.innerSetHandler` 回到主列表。主列表 APPLY 才会 `GameData.saveData` / `GameInputer.updateConfig`。只在键位页 APPLY、主列表不点 APPLY 就走：内存里的 `key_p1/p2` 已改，存档没有，下次 `loadData` 会盖回去。? 中途切走 `SettingState.destory` 也不回滚。

**CANCEL**

只 `dispatchEvent("CANCEL_SET")`。不碰 `_keyConfig`。

字面量 `"APPLY_SET"` / `"CANCEL_SET"` 与 `SetBtnEvent` 常量同文。`SettingState` 听的也是字面量。

### `setNextKey`（L186–198）

`_setKeyIndex++`。取 `_keyMappings[index]`。

- 有：`_dialog.show(name, cn)`。等 `onKeyDown`。
- 没有（问完 k9 再 ++ 变成 10）：`stage.removeEventListener("keyDown", onKeyDown)`；`_btnGroup.keyEnable = true`。Dialog 在上一键的 `onKeyDown` 里已经 `hide()`。

不把 `_setKeyIndex` 复位。再按一次 SET ALL 会从 -1 重新来。

### `onKeyDown`（L201–225）

1. `!_dialog.isShow` return（hide 与下一 show 之间的键丢掉）。
2. 当前 `KeyMapping` 空则 return（越界保护）。
3. `keyId` 空则 return。
4. `KyoKeyCode.code2name(keyCode)`：表里没有的键（某些 OEM、未登记码）返回 `null`，**整键忽略**，Dialog 继续等。Esc / 功能键是否在表里取决于 `KyoKeyCode._keyArray`。?
5. `_tmpKeyConfig[keyId] = keyCode`（动态字段，id 即 VO 属性名）。
6. `mapping.setKey(keyCode, name)`：第二参已有名字，不再查表。显示强制 `toUpperCase`。
7. `_dialog.hide()`；`setNextKey()`。

**不检查冲突。** 两个动作可以绑同一键。也不挡 `GameInputer` 的菜单 back/select；`keyEnable` 已关，底栏不会误 APPLY。`GameInputer` 自己的 render 仍在 `"anyone"` 桶里更新 just-down 状态，只是本页不 poll。

### `fadIn`（L228–240）

接口。`SettingState.goInnerSetPage` 在 `addChild` 之后调。

1. `duration = 0.3`。
2. `ui.y = GAME_SIZE.y`（屏底外），0.3s tween 到 `y=0`，完成回调 `_btnGroup.keyEnable = true`。
3. 立刻 `setArrowIndex(0)`（SET ALL）+ `ui.visible = true`。

与主列表的配合：主列表同时 0.2s tween 到 `y = -GAME_SIZE.y` 后 `visible=false`，并立刻 `keyEnable=false`。内页从底下盖上来。`_man.gotoAndPlay("key_fadin")` 是 Setting 里一护立绘，不在本类。

重复 `fadIn` 不 `killTweensOf`。本包每次都是新实例。

### `fadOut`（L243–253）

立刻 `_btnGroup.keyEnable = false`。0.3s tween `y` 到 `GAME_SIZE.y`，完成 `ui.visible = false`。**不**卸 keyDown、不 destory。`SettingState.goMainSetting` 调这个之后内页仍在显示列表里（只是移出屏幕并 hidden），直到下次 `goInnerSetPage` / `destoryInnerSetUI`。

第二次进键位页：`goKeyConfig` 又 `new SetCtrlBtnUI()`，先 `destoryInnerSetUI` 清旧的。旧实例若还在 SET ALL，其 stage listener 在 `destory` 里也不卸，见上。?
