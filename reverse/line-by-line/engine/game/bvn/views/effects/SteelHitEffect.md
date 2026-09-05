# `SteelHitEffect` — 钢体受击火花 + 刷白

一句话目的：`EffectView` 子类。火花本身走基类光栅播放；`setTarget` 时若目标是钢体，把角色刷成高亮（超钢体再去掉蓝通道并黄闪），并在 **freeze 结束** `resumeColor`。`EffectManager` 在 VO.`isSteelHit` 时建本类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/SteelHitEffect.as`（48 行）

## Callers / callees

- **工厂**：`EffectManager.getEffectView`：非 special、非 buff、`isSteelHit` → `new SteelHitEffect(vo)`。
- **导演**：`EffectCtrl.doSteelHitEffect(hitVO, rect, target)`：按 `hitType` 选 id，再 `doEffectVO`（`addEffect` + freeze/shine + `setTarget`）。
  - `0`：return，无特效
  - `1`/`6` 斩：`steel_hit_kan`（符号 `XG_kan2`）
  - `2`/`3` 拳：`steel_hit_qdj`（`XG_qdj`）
  - default（法/火/冰/电/抓等）：`steel_hit_mfdj`（`XG_mfdj`）
- **触发**：`FighterMcCtrler` 钢体挨打 `EffectCtrl.I.doSteelHitEffect(...)`。
- **数据**：`EffectModel.initSteelHitEffect`：三者都 `isSteelHit`、freeze 400、白闪 0.2、`randRotate`、`snd_hit11`、**无 shake**。符号复用轻击那套。
- **Callees**：`FighterMain.changeColor` / `resumeColor` / `isSteelBody` / `isSuperSteelBody`；`EffectCtrl.I.shine(16776960, 0.3)`、`setOnFreezeOver`。

## 命名备注

- 不覆盖 `render` / `start` / `destory`。视觉播完靠基类 `autoRemove`；颜色还原 **不**绑特效结束，绑 hit-stop 结束。
- `16776960` = `0xFFFF00` 黄。`ShineEffectView` 里 `> 0x7FFFFF` 走 `add` 混合。
- 钢体光晕（`FighterMcCtrler.setSteelBody` → `startGlow` 白/黄）是 `BitmapFilterView`，与本类无关。本类只是挨打那一下的火花+闪白。

## 继承关系

```
EffectView
  ├─ SpecialEffectView
  ├─ BuffEffectView
  └─ SteelHitEffect      ← 本类
```

## 逐行说明

### 字段 / 构造（L12–17）

- `_fighter`：仅 `FighterMain`。
- `super(vo)`。`loopPlay` false，播完移除。

### `setTarget`（L19–45）覆盖

反编译保留了命名局部：`v`=`param1`，`ct`=`ColorTransform`。闭包要捕获 `_fighter`。

1. `super.setTarget(v)`。
2. 不是 `FighterMain`：只记下空，当普通火花。`doSteelHitEffect` 的 `param3` 一般是挨打的角色。
3. 是 `FighterMain`：写 `_fighter`。**仅 `isSteelBody` 才染色**（调用方已是钢体路径，这是双保险）。
4. `ColorTransform`：`redOffset=greenOffset=blueOffset=150`（刷白）。
5. 若 **`isSuperSteelBody`**：`blueOffset=0`（黄白）+ `EffectCtrl.I.shine(16776960, 0.3)`。普通钢体不额外 shine（VO 自带的白闪 0.2 已在 `doEffectVO` 里打过）。
6. `_fighter.changeColor(ct)`：只改 MC 当前 transform，不覆盖 `_colorTransform`。
7. `setOnFreezeOver(function():void { _fighter.resumeColor(); })`：freeze 帧减到 0 时同步调。`EffectCtrl` 懒建 `Vector.<Function>`，按插入序一次性跑完丢弃。

`doEffectVO` 顺序：`addEffect`/`start` → **`freeze(400)`** → shine → **`setTarget`**。freeze 先开、回调后挂，同帧 freeze 不会已经结束。`freezeEnabled==false`（KO）时 `freeze()` 直接 return，回调仍进队列，要等 **下一次** 别人的 freeze 结束才 `resumeColor`，期间角色一直刷白。?

连打钢体：每次 `setTarget` 再 push 一个 resumeColor，`changeColor` 覆盖。多次回调都 resume 到同一 `_colorTransform`，幂等。超钢体每次再黄闪一次。

不覆盖 `render`：不跟随角色。火花钉在受击矩形中心（`doHitEffect` 同款坐标）。
