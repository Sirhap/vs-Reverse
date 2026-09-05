# `jiraiya_fla.MainTimeline` — 助战 自来也 根时间轴

一句话目的：助战 `自来也` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/jiraiya/scripts/jiraiya_fla/MainTimeline.as`（101 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `jiraiya`，comic_type 1 火影。文件 `assets/fighter/fz/jiraiya.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,9,frame10,29,frame30,30,frame31,35,frame36,47,frame48,73,frame74);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–59）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":50, "hitType":4, "hitx":3, "hity":0, "hurtTime":800, "hurtType":0, "isBreakDef":false });`
- L50: `$assisterCtrler.defineAction("atm2",{ "power":50, "hitType":5, "hitx":15, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 50 | 4 MAGIC 忍术/鬼道 | 3 | 0 | 800 | 0 | false |
| L50 | `atm2` | 助战判定 2 | 50 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F48 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L61–64 / L63 | `stop();` — 停时间轴 |
| F10 | L66–69 / L68 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F30 | L71–74 / L73 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F31 | L76–81 / L78 | `$assisterCtrler.effect.dash();` — 冲刺特效 dash/dash_air |
|  |  / L79 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L80 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F36 | L83–88 / L85 | `$assisterCtrler.moveToTarget(-100,0,false);` — 瞬移到目标相对坐标 |
|  |  / L86 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L87 | `$assisterCtrler.damping(0.5,0);` — 阻尼 |
| F48 | L90–93 / L92 | `$assisterCtrler.effect.shine();` — 闪光 |

#### F74 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F74 | L95–98 / L97 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
