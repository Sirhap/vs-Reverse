# `FighterHpBar` — 单侧 HP 条（绿当前 + 红拖尾）

一句话目的：绑 `hpbar_barmc`。绿/前景 `bar.scaleX` 跟 `hp/hpMax` 平滑；红 `redbar` 在受击/击飞期间卡住，延迟后再慢速追上，用来画「刚掉的那截血」。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FighterHpBar.as`（112 行）

## Callers / callees

- **Callers**：只 `FightBar`。构造绑 `bar1`/`bar2`；`setFighter(currentFighter)`；每逻辑帧 `render`；`destory`。
- **Callees**：`FighterMain.hp` / `hpMax` / `actionState`；`GameConfig.FPS_GAME`。

## 命名备注

- `destory`：只 null `_fighter`。
- `actionState` 用 `switch(state - 21)` 对齐 `FighterActionState`：21=`HURT_ING`、22=`HURT_FLYING`、23=`HURT_DOWN`。24=`HURT_DOWN_TAN` 掉进 default，立刻放行红条。
- 绿条下降系数 0.4、回血 0.04；红条下降 0.1、回血 0.02。掉血快、回血慢。
- `_redBarMoveDelay` 单位=**逻辑帧**。`HURT_ING` 时写死 100（60fps≈1.67s）；进入击飞改成 `1.5*FPS_GAME`（90 帧）。
- `_justHurtFly`：从 21 进 22/23 的那一帧把 delay 改成 1.5s，之后每帧 -1。回到 default（idle 等）才清。
- 新伤害且红条正在动：先把红条 **snap** 到上一帧的 `_hprate`（旧血量），再停 `_redBarMoving`。视觉上「上一截拖尾收掉、新缺口从当前血开始再等 delay」。
- `render` 不判 `_fighter`。BITMAP 下 `ui` 被抬到 `ui_fight`，`bar`/`redbar` 仍是 `_ui` 的孩子，scaleX 照常。

## 逐行说明

### 字段 / 构造（L9–32）

`_ui`=`hpbar_barmc`。`_bar=_ui.bar`（当前 HP），`_redbar=_ui.redbar`（拖尾）。`_hprate=1`。`_redBarMoving=false`。`_redBarMoveDelay=0`。`_justHurtFly=false`。

SWF 里两条 MovieClip 默认 scaleX=1（满血）。P2 的 `bar2` 布局已朝左，本类不 `scaleX*=-1`。

### `ui` getter（L34–37）

`FightBar.initBitmapUI` 用来 `addChildren`。

### `destory`（L39–42）

`_fighter=null`。delay/moving 残留无所谓，实例随 FightBar 丢掉。

### `setFighter`（L44–47）

只换引用。不重置 `_hprate`。组队换人时新角色 `GameLogic.resetFighterHP` 通常满血，绿条会从旧 scale 慢慢加到 1（系数 0.04，视觉上「新角色血条涨满」）。红条若 delay=0 也会慢慢跟。

### `render`（L49–110）

`_loc1_ = hp/hpMax`（当前比率）。

**新伤害打断拖尾（L54–58）**：`_redBarMoving && _loc1_ != _hprate` → `redbar.scaleX = _hprate`（旧比率），`_redBarMoving=false`。然后 `_hprate=_loc1_`。同一帧内绿条仍按新比率 lerp。

**绿条 lerp（L60–69）**：`delta = _hprate - bar.scaleX`。掉血（delta<0）系数 0.4，回血 0.04。`abs<0.01` 贴死。满血→0 大约几帧；0→满血要长得多。

**delay 状态机（L70–94）**：`switch(actionState-21)`

| case | 状态 | 行为 |
|---|---|---|
| 0 | 21 受击 | `_redBarMoveDelay=100`（每帧都重写，受击期间红条永不追） |
| 1 | 22 击飞 | 见下 |
| 2 | 23 倒地 | 同击飞 |
| default | 其它 | delay=0，`_justHurtFly=false` |

22/23 且 `delay>0`：

1. 若 `!_justHurtFly`：delay=`1.5*FPS_GAME`，`_justHurtFly=true`，**break**（本帧不 --）。
2. 否则若 `delay>0`：`--`。

从 21（delay 恒 100）进 22：第一帧飞把 100 换成 90，之后每帧减。若从未 21、直接 22（? 少见）且 delay 已是 0，这个分支不进，红条立刻追。

`HURT_DOWN_TAN(24)` / `DEAD(30)` 走 default：delay 清 0，红条开始追。KO 击飞落地进 30 后拖尾才收。`FightUI.renderEnd` 等的也是 22→30。

**红条 lerp（L95–109）**：仅 `delay<=0`。`delta = _hprate - redbar.scaleX`。掉血系数 0.1（比绿慢，所以绿先掉、红在后面），回血 0.02。贴死则 `_redBarMoving=false`，否则 true。

delay>0 时红条完全不动，绿条照掉 → 缺口就是本段伤害。

`hpMax==0` 或 `hp` 负：比率 0/负，scaleX 可负。正常 `resetFighterHP` 不会给 0 max。
