# `gaara_fla.Timeline_9` — 攻击体 `Timeline_9`

一句话目的：攻击体 `Timeline_9`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/gaara/scripts/gaara_fla/Timeline_9.as`（72 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf`。

Embed `source="/_assets/assets.swf", symbol="symbol352"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `bs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `fighterCtrler` | `*` | 攻击体主人 ctrler 缓存

### 函数

#### `Timeline_9()`（L30–34）

- L32: `super();`
- L33: `addFrameScript(0, this.frame1, 16, this.frame17, 61, this.frame62, 80, this.frame81, 85, this.frame86);`

#### `setAttackerCtrler(param1:*)`（L36–39）

- L38: `$attacker_ctrler = param1;`

### 逐帧脚本

共 5 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。
#### F1–F17 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L41–43 | （空；? 仅占位） |
| F17 | L45–47 | （空；? 仅占位） |

#### F62 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F62 | L49–52 / L51 | `$attacker_ctrler.removeSelf();` — 攻击体卸场 |

#### F81–F86 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F81 | L54–57 / L56 | `$attacker_ctrler.stop();` — 停攻击体 |
| F86 | L59–69 / L61 | `fighterCtrler = $attacker_ctrler.owner_fighter_ctrler;` — 从攻击体拿到主人 ctrler |
|  |  / L59 | `if(fighterCtrler) {if(fighterCtrler.target) {fighterCtrler.target.visible = true;}}` — 目标存在才操作 |
