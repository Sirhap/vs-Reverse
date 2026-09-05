# `uryuu_fla.Timeline_13` — 攻击体 `Timeline_13`

一句话目的：攻击体/技能 clip `Timeline_13`：`setAttackerCtrler` 注入 `$attacker_ctrler`，帧脚本驱动位移/命中/自毁。

源文件：`decompiled/fighters/uryuu/scripts/uryuu_fla/Timeline_13.as`（69 行）

## 如何挂上引擎

攻击体 clip。动作 MC 里 `addAttacker(...)` 之后引擎调 `setAttackerCtrler` 注入 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 门面 `$attacker_ctrler`（没有也不 throw）。`FighterMC.renderChildren` 对名字含 `atm` 的子件不自动 `nextFrame`；本类若被当独立 attacker 播，则走自己的帧脚本。

Embed `source="/_assets/assets.swf", symbol="symbol207"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `zh21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `$attacker_ctrler` | `*` | 攻击体控制器

### 函数

#### `Timeline_13()`（L28–32）

- L30: `super();`
- L31: `addFrameScript(0, frame1, 1, frame2, 2, frame3, 5, frame6, 6, frame7, 12, frame13);`

#### `setAttackerCtrler(param1:*)`（L34–37）

- L36: `$attacker_ctrler = param1;`

### 逐帧脚本

共 6 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F13 — 动作 `击地`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L39–41 / L39 | （空） |
| F2 | L43–46 / L45 | `$attacker_ctrler.move(0, 30);` — 攻击体速度 |
| F3 | L48–51 / L50 | `$attacker_ctrler.setTouchFloor("击地");` — 落地切标签 |
| F6 | L53–56 / L55 | `$attacker_ctrler.stop();` — 停攻击体 |
| F7 | L58–61 / L60 | `$attacker_ctrler.effect.shake(0, 3);` — 震动 |
| F13 | L63–66 / L65 | `$attacker_ctrler.endAct();` — 结束当前招，清攻击允许 |
