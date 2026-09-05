# `BuffEffectView` — 跟随角色的循环 buff 光

一句话目的：`EffectView` 子类。`loopPlay=true`，逻辑帧跟随 fighter 脚底；`FighterBuffVO.finished` 后 `resumeColor` 并 `remove`。`EffectManager` 在 VO.`isBuff` 时建本类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/BuffEffectView.as`（63 行）

## Callers / callees

- **工厂**：`EffectManager.getEffectView`：`isSpecial` 之后、`isSteelHit` 之前，`isBuff` → `new BuffEffectView(vo)`。池 key 是 EffectVO 引用。
- **导演**：`EffectCtrl.doBuffEffect(id, fighter, buffVO)`：`addEffect`（内部 `start`）→ `setTarget` → `setBuff` → `_effectLayer.addChild`。
- **触发**：`FighterBuffCtrler.speedUp` / `attackUp` / `defenseUp` 先 `doEffectById("buff_effect_*")` 播一次性爆发（普通 `EffectView`，**没有** `isBuff`），再 `doBuffEffect("buff_speed|power|defense")` 挂本类。
- **数据**：`EffectModel.initBuffEffect`：`buff_speed` / `buff_power` / `buff_defense`，`blendMode=add`，`isBuff=true`，**无** `targetColorOffset`、无声。
- **基类**：继承 `EffectView` 的光栅 MC 播放、`addRemoveBack`、池化 `isActive`。
- **Callees**：`FighterMain.changeColor` / `resumeColor`（现表无 offset，走不到）；`FighterBuffVO.finished`；`setPos` / `remove` 来自基类。

## 命名备注

- 与 `SpecialEffectView` 对称：都跟随 fighter、都可读 `targetColorOffset`。差别：本类看 **buff 剩余时间**，Special 看 **actionState**；本类构造就把 `loopPlay=true`。
- `buff_effect_*` 不是本类。名字带 effect 的是爆发火花。
- `destory` 不覆盖，用基类。不在结束时 `resumeColor` 以外的路径还原。

## 继承关系

```
EffectView
  ├─ SpecialEffectView   (isSpecial, 火/冰/电持续)
  ├─ BuffEffectView      (isBuff, 本类)
  └─ SteelHitEffect      (isSteelHit, 钢体火花)
```

## 逐行说明

### 字段 / 构造（L12–20）

- `_fighter`：`setTarget` 里若是 `FighterMain` 才赋值。
- `_buff`：`setBuff` 注入，`render` 读 `finished`。
- `super(param1)` 后 **`this.loopPlay = true`**。基类默认 false。循环到最后一帧回到 0，**不会**因播完 `removeSelf`。结束只靠 buff 到期。

池复用时构造不再跑，`loopPlay` 保持 true。`start()` 不改这个旗。

### `setBuff`（L22–25）

只存引用。`FighterBuffCtrler.addBuff` 同名刷新是同一 VO 上 `setHold`，本 View 跟着那条 VO 的 `finished`，不用重建。

### `setTarget`（L27–43）覆盖

1. `super.setTarget` 写 `_target`。
2. `is FighterMain` 则记下 `_fighter`。
3. `_fighter && _data.targetColorOffset` 才组 `ColorTransform`（r/g/b 来自数组 `[0][1][2]`）调 `changeColor`。

当前 `EffectModel` 三条 buff VO **都没** `targetColorOffset`，这段是死代码，除非改表。对比 `fire_ing` 等 special 才有 offset。`changeColor` 只改 `_mainMc.transform`，不写 `_colorTransform`，所以 `resumeColor` 能回到原来的色。

### `render`（L45–60）覆盖

基类 `render()` 空。`EffectCtrl.render` 每逻辑帧（含 freeze/必杀 pause 期间）调。

1. `super.render()`。
2. **`_buff.finished`**：到期则若有 offset 且 `_fighter` 存在 → `resumeColor()`，再 `remove()`（基类 `removeSelf`：`isActive=false`、回调 `removeEffect`、从 parent 摘 display）。
3. 否则若有 `_fighter`：`setPos(_fighter.x, _fighter.y)`。只更新 `_orgX/_orgY`；真正 `display.x/y` 在随后的 `renderAnimate` → `renderDisplay` 才写。跟随节奏 = 特效动画 30fps，不是逻辑 60fps。

**`_buff` 空则 NPE**。`doBuffEffect` 在 `addEffect`（已 push `_effects`）之后立刻 `setBuff`，正常同帧不会 `render` 到它（`FighterBuffCtrler` 走主逻辑，晚于 `EffectCtrl.render`）。池复用漏 `setBuff` 会炸。?

`remove()` 发生在 `render()` 里：`removeEffect` 从 `_effects` splice。随后同拍 `renderAnimate` 用新 length，已摘掉的本实例不再 `renderAnimate`。一边 while index++ 一边 splice，可能跳过 **下一个** 特效的 `render()`。`EffectCtrl` 这条循环与 `renderShine` 同类隐患。?

buff 到期当帧光消失；角色属性还原在 `FighterBuffCtrler.render`（同一逻辑帧、主循环里），顺序是 EffectCtrl 先、fighter 后，所以特效可能比属性早一拍看到 `finished`（VO 在上一帧末或本帧 Ctrler 之前？）。`FighterBuffVO.render` 在 `FighterMain.render` 里，晚于 EffectCtrl，故本 View 看到 `finished` 是 **Ctrler 已经标过的下一帧**。光比属性晚最多 1 逻辑帧结束。
