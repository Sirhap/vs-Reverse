# `juggo_fla.Symbol1_10` — 攻击体 `Symbol1_10`

一句话目的：攻击体 `Symbol1_10`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/juggo/scripts/juggo_fla/Symbol1_10.as`（61 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf` / `setHitTarget`。

Embed `source="/_assets/assets.swf", symbol="symbol213"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `zh21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `$attacker_ctrler` | `*` | 引擎注入

### 函数

#### `Symbol1_10()`（L28–32）

- L30: `super();`
- L31: `addFrameScript(0,frame1,15,frame16,55,frame56);`

#### `setAttackerCtrler(param1:*)`（L34–37）

- L36: `$attacker_ctrler = param1;`

### 逐帧脚本

共 3 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F16 — 动作 `招22` / `miss`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L39–41 | （空；? 仅占位） |
| F16 | L43–53 / L45 | `if(Boolean($attacker_ctrler.justHit("zh2")) && Boolean($attacker_ctrler.owner_mc_ctrler)){$attacker_ctrler.owner_mc_ctrler.gotoAndPlay("招22");}else{$attacker_ctrler.gotoAndPlay("miss");}` — 刚命中判定 |

#### F56 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F56 | L55–58 / L57 | `$attacker_ctrler.removeSelf();` — 移除攻击体 |
