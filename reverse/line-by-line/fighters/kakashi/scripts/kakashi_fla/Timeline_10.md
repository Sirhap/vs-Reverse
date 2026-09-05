# `kakashi_fla.Timeline_10` — 攻击体 `Timeline_10`

一句话目的：攻击体 `Timeline_10`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/kakashi/scripts/kakashi_fla/Timeline_10.as`（49 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf` / `setHitTarget`。

Embed `source="/_assets/assets.swf", symbol="symbol351"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `sbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `$attacker_ctrler` | `*` | 引擎注入

### 函数

#### `Timeline_10()`（L28–32）

- L30: `super();`
- L31: `addFrameScript(0,frame1,1,frame2);`

#### `setAttackerCtrler(param1:*)`（L34–37）

- L36: `$attacker_ctrler = param1;`

### 逐帧脚本

共 2 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F2 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L39–41 | （空；? 仅占位） |
| F2 | L43–46 / L45 | `$attacker_ctrler.move(12,0);` — 设速度 |
