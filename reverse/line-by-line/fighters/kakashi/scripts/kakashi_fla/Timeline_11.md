# `kakashi_fla.Timeline_11` — 攻击体 `Timeline_11`

一句话目的：攻击体 `Timeline_11`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/kakashi/scripts/kakashi_fla/Timeline_11.as`（83 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf` / `setHitTarget`。

Embed `source="/_assets/assets.swf", symbol="symbol518"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `$attacker_ctrler` | `*` | 引擎注入
| L28 | `isHit` | `Boolean` | 运行时缓存/标志
| L30 | `hitTarget` | `*` | 运行时缓存/标志
| L32 | `target` | `*` | 运行时缓存/标志

### 函数

#### `Timeline_11()`（L34–38）

- L36: `super();`
- L37: `addFrameScript(0,frame1,36,frame37,40,frame41,54,frame55);`

#### `setAttackerCtrler(param1:*)`（L40–43）

- L42: `$attacker_ctrler = param1;`

### 逐帧脚本

共 4 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L45–48 / L47 | `isHit = false;` — 记下引用/标志 |

#### F37–F55 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F37 | L50–63 / L52 | `if($attacker_ctrler.justHit("cbs1")){target = $attacker_ctrler.owner_fighter_ctrler.getTargetSP(); if(target){hitTarget = target; target.isApplyG = false; target.getDisplay().visible = false; isHit = true;}}` — 刚命中判定 |
| F41 | L65–71 / L67 | `if(!isHit){$attacker_ctrler.removeSelf();}` — 移除攻击体 |
| F55 | L73–80 / L75 | `if(hitTarget){target.getDisplay().visible = true; target.isApplyG = true;}` — 目标存在才操作 |
