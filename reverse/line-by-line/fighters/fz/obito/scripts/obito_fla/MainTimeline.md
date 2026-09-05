# `obito_fla.MainTimeline` — 助战 宇智波·带土 根时间轴

一句话目的：助战 `宇智波·带土` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/obito/scripts/obito_fla/MainTimeline.as`（88 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `obito`，comic_type 1 火影。文件 `assets/fighter/fz/obito.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,12,frame13,27,frame28,38,frame39,39,frame40,45,frame46,63,frame64);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":100, "hitType":7, "hitx":5, "hity":5, "hurtTime":700, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 100 | 7 FIRE 火 | 5 | 5 | 700 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F64 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F13 | L55–58 / L57 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F28 | L60–63 / L62 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F39 | L65–69 / L67 | `$assisterCtrler.moveToTarget(30,-20,true);` — 瞬移到目标相对坐标 |
|  |  / L68 | `$assisterCtrler.move(-1,-1);` — 设速度 |
| F40 | L71–74 / L73 | `$assisterCtrler.effect.slowDown(0.5);` — 全局慢动作 |
| F46 | L76–80 / L78 | `$assisterCtrler.move(-5,-5);` — 设速度 |
|  |  / L79 | `$assisterCtrler.damping(0.1,0.1);` — 阻尼 |
| F64 | L82–85 / L84 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
