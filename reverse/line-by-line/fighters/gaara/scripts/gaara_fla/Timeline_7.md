# `gaara_fla.Timeline_7` — 攻击体 `Timeline_7`

一句话目的：攻击体 `Timeline_7`：`setAttackerCtrler` 接 `$attacker_ctrler`，时间轴里 stop / 位移 / `removeSelf` / 切标签。

源文件：`decompiled/fighters/gaara/scripts/gaara_fla/Timeline_7.as`（47 行）

## 如何挂上引擎

攻击体子 MC。时间轴 `addAttacker("名字")` 后 [`FighterAttacker`](../../../../engine/game/bvn/fighter/FighterAttacker.md) 若 SWF 有 `setAttackerCtrler` 则注入 `$attacker_ctrler`（**没有也不 throw**）。本 clip 用它 `stop` / `gotoAndPlay` / `move` / `removeSelf`。

Embed `source="/_assets/assets.swf", symbol="symbol195"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_7()`（L26–30）

- L28: `super();`
- L29: `addFrameScript(0, this.frame1, 3, this.frame4);`

#### `setAttackerCtrler(param1:*)`（L32–35）

- L34: `$attacker_ctrler = param1;`

### 逐帧脚本

共 2 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。
#### F1–F4 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L37–39 | （空；? 仅占位） |
| F4 | L41–44 / L43 | `$attacker_ctrler.stopFollowTarget();` — 停止跟随目标 |
