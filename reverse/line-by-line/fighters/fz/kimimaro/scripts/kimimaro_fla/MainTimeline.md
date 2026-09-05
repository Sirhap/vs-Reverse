# `kimimaro_fla.MainTimeline` — 助战 君麻吕 根时间轴

一句话目的：助战 `君麻吕` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/kimimaro/scripts/kimimaro_fla/MainTimeline.as`（96 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `kimimaro`，comic_type 1 火影。文件 `assets/fighter/fz/kimimaro.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm0` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,15,frame16,29,frame30,33,frame34,49,frame50,64,frame65,69,frame70,100,frame101);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–50）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":15, "hitType":1, "hitx":0, "hity":0, "hurtTime":400, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 15 | 1 KAN 砍 | 0 | 0 | 400 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 8 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F70 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L52–55 / L54 | `stop();` — 停时间轴 |
| F16 | L57–60 / L59 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F30 | L62–65 / L64 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F34 | L67–72 / L69 | `$assisterCtrler.move(20,0);` — 设速度 |
|  |  / L70 | `$assisterCtrler.setHitTarget("atm0","动作2");` — 打中检测盒 → 跳转标签 |
|  |  / L71 | `$assisterCtrler.effect.dash();` — 冲刺特效 dash/dash_air |
| F50 | L74–78 / L76 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L77 | `$assisterCtrler.damping(2,0);` — 阻尼 |
| F65 | L80–83 / L82 | `$assisterCtrler.finish();` — 助战退场 removeSelf |
| F70 | L85–88 / L87 | `$assisterCtrler.damping(4,0);` — 阻尼 |

#### F101 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F101 | L90–93 / L92 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
