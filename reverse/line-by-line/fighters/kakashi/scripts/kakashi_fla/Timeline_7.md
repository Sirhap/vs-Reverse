# `kakashi_fla.Timeline_7` — 攻击体 `Timeline_7`

一句话目的：攻击体 `Timeline_7`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/kakashi/scripts/kakashi_fla/Timeline_7.as`（75 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf` / `setHitTarget`。

Embed `source="/_assets/assets.swf", symbol="symbol172"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `zh20atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `$attacker_ctrler` | `*` | 引擎注入

### 函数

#### `Timeline_7()`（L28–32）

- L30: `super();`
- L31: `addFrameScript(0,frame1,9,frame10,16,frame17,29,frame30,39,frame40,61,frame62,62,frame63);`

#### `setAttackerCtrler(param1:*)`（L34–37）

- L36: `$attacker_ctrler = param1;`

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F40 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L39–41 | （空；? 仅占位） |
| F10 | L43–47 / L45 | `$attacker_ctrler.move(20,0);` — 设速度 |
|  |  / L46 | `$attacker_ctrler.setHitTarget("zh20atm","hit");` — 指定命中取样盒 |
| F17 | L49–52 / L51 | `$attacker_ctrler.damping(5,0);` — 阻尼 |
| F30 | L54–57 / L56 | `$attacker_ctrler.move(15,0);` — 设速度 |
| F40 | L59–62 / L61 | `$attacker_ctrler.damping(5,0);` — 阻尼 |

#### F62–F63 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F62 | L64–67 / L66 | `$attacker_ctrler.removeSelf();` — 移除攻击体 |
| F63 | L69–72 / L71 | `$attacker_ctrler.damping(5,0);` — 阻尼 |
