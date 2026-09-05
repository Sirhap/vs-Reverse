# `gaara_fla.Timeline_11` — 攻击体 `Timeline_11`

一句话目的：攻击体 `Timeline_11`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/gaara/scripts/gaara_fla/Timeline_11.as`（64 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf`。

Embed `source="/_assets/assets.swf", symbol="symbol468"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `cbs3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `cbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_11()`（L32–36）

- L34: `super();`
- L35: `addFrameScript(0, this.frame1, 9, this.frame10, 61, this.frame62, 108, this.frame109);`

#### `setAttackerCtrler(param1:*)`（L38–41）

- L40: `$attacker_ctrler = param1;`

### 逐帧脚本

共 4 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。
#### F1–F10 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L43–45 | （空；? 仅占位） |
| F10 | L47–50 / L49 | `$attacker_ctrler.stop();` — 停攻击体 |

#### F62 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F62 | L52–56 / L54 | `$attacker_ctrler.owner_fighter_ctrler.setTargetVelocity(0, -0.1);` |
|  |  / L55 | `$attacker_ctrler.owner_fighter_ctrler.setTargetDamping(0, 0);` |

#### F109 — 动作 `end`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F109 | L58–61 / L60 | `$attacker_ctrler.gotoAndPlay("end");` — 切攻击体标签 |
