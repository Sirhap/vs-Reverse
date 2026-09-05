# `SpecialEffectView` — 火/冰/电持续环绕

一句话目的：`EffectView` 子类。挂到受击 `FighterMain` 上跟随坐标，按 `targetColorOffset` 改角色颜色；`actionState` 落到倒地/弹起/站立则跳 `"finish"` 并 `resumeColor`。`EffectManager` 在 VO.`isSpecial` 时建本类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/views/effects/SpecialEffectView.as`（73 行）

## Callers / callees

- **工厂**：`EffectManager.getEffectView` **最先**看 `isSpecial` → `new SpecialEffectView(vo)`。
- **导演**：`EffectCtrl.doSpecialEffect(id, fighter)`：`addEffect` at `(fighter.x, y, direct)` → `as SpecialEffectView` → `setTarget` → addChild。由 `doEffectVO` 末尾触发：hit VO 带 `specialEffectId` 且 target 是 `FighterMain`。
- **数据**：`EffectModel.initSpeicalEffect`（原拼写）：

  | id | className | targetColorOffset | 来源 hitType |
  |----|-----------|-------------------|--------------|
  | `fire_ing` | `xg_fire_ing` | `[-255,-255,-255]` 全黑 | 7 FIRE |
  | `ice_ing` | `xg_ice_ing` | `[0,0,255]` 加蓝 | 8 ICE |
  | `shock_ing` | `xg_dian_ing` | `[50,-75,255]` 偏蓝紫 | 9 ELECTRIC |

  全部 `blendMode=add`。防御命中 **不**带 `specialEffectId`，防住不挂持续。
- **状态**：`FighterActionState`：0=`NORNAL` 站立，23=`HURT_DOWN` 倒地，24=`HURT_DOWN_TAN` 弹起。被打 21、击飞 22 **不**结束，火/冰/电一直跟到落地或回 idle。
- **Callees**：`FighterMain.changeColor` / `resumeColor`；基类 `gotoAndPlay` / `setPos`。

## 命名备注

- 不设 `loopPlay`（对比 `BuffEffectView`）。持续段靠 MC 帧标签 `"loop"`（基类 `renderFrameLabel`）或片段本身够长；没有 loop 则播到缓存末帧 `autoRemove`，角色可能还带着染色。?
- `"finish"` 标签在 `xg_fire_ing` 等反编译 MC 里看不到（FLA 时间轴）。没有该标签则 `gotoAndPlay` 空转，只是停止跟随、染色已 `resumeColor`，片子播完自己摘。?
- `destory` 不覆盖：场切时不 `resumeColor`。角色一并 destory 则无所谓。

## 继承关系

```
EffectView
  ├─ SpecialEffectView   ← 本类
  ├─ BuffEffectView
  └─ SteelHitEffect
```

## 逐行说明

### 字段 / 构造（L11–18）

- `_fighter`：仅 `FighterMain`。
- `_finished`：进了结束段后 `render` 不再跟随、不再二次 finish。
- 构造只 `super(vo)`。`loopPlay` 保持基类 false，`autoRemove` true。

### `setTarget`（L20–36）覆盖

`super` 后若是 `FighterMain`：记下，且 VO 有 `targetColorOffset` 则 `ColorTransform` 三通道 offset 后 `changeColor`。

`doSpecialEffect` 顺序：`addEffect`（`start`，此时 `_fighter` 可能是池里上一任）→ 然后才 `setTarget`。`start` 先把 `_finished=false`，再上色。连打火属性会再挂一个新 View（池耗尽就 new），`changeColor` 覆盖；多个 View 各自在 finish 时 `resumeColor`，后结束的那个可能把还在燃烧的染色清掉。?

### `start`（L38–42）覆盖

`super.start` 后 `_finished = false`。池复用必须清这个旗，否则上次 finish 过的实例再播会立刻 `render` return。

不重置 `_fighter`。同帧 `setTarget` 会覆盖。

### `render`（L44–70）覆盖

每逻辑帧（`EffectCtrl.render`，pause 期间仍走）：

1. `super.render()` 空。
2. 已 `_finished` 或没有 `_fighter`：return。无 fighter 时特效停在 `start` 的坐标，播完 autoRemove（普通火花路径）。
3. `switch(_fighter.actionState)`：
   - **23 / 24 / 0**：`gotoAndPlay("finish")`，`_finished=true`，有 offset 则 `resumeColor`。之后不再 `setPos`，结束动画钉在倒地/起身那一拍的坐标。
   - **default**（被打 21、击飞 22、其它）：`setPos(_fighter.x, _fighter.y)`。display 仍等 `renderAnimate` 才挪。

站立 0 也结束：受击硬直还没出、或立刻 idle 的情况会把火掐掉。死亡 30 不在 case 里，火会继续跟尸体直到播完。?

`gotoAndPlay("finish")` 的帧号来自 `EffectVO.frameLabelCache`，key 是 MC **1-based** `currentFrame`，而 `_curFrame` 是位图 Vector 的 **0-based** 下标。标签所在 MC 帧 F 会把 `_curFrame` 设成 F，可能错一位或越界。见 `EffectView.gotoAndPlay`。?
