# `madara_fla.Timeline_2` — 攻击体 `Timeline_2`

一句话目的：攻击体 `Timeline_2`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 命中检测 / `removeSelf`。

源文件：`decompiled/fighters/fz/madara/scripts/madara_fla/Timeline_2.as`（59 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `justHit` / `removeSelf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `atm3` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_2()`（L30–34）

- L32: `super();`
- L33: `addFrameScript(0,frame1,11,frame12,34,frame35);`

#### `setAttackerCtrler(param1:*)`（L36–39）

- L38: `$attacker_ctrler = param1;`

### 逐帧脚本

共 3 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F12 — 动作 `miss`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L41 | （空；? 仅占位） |
| F12 | L45–51 / L47 | `if(!$attacker_ctrler.justHit("atm1")) $attacker_ctrler.gotoAndPlay("miss");` — 刚命中判定 |

#### F35 — 攻击体卸场

| 帧 | 函数 L | 调用 |
|---|---|---|
| F35 | L53–56 / L55 | `$attacker_ctrler.removeSelf();` — 攻击体卸场 |
