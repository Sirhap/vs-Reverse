# `temari_fla.MainTimeline` — 助战 手鞠 根时间轴

一句话目的：助战 `手鞠` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/temari/scripts/temari_fla/MainTimeline.as`（93 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `temari`，comic_type 1 火影。文件 `assets/fighter/fz/temari.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,19,frame20,35,frame36,36,frame37,37,frame38,38,frame39,68,frame69);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":10, "hitType":4, "hitx":0.5, "hity":-1, "hurtTime":300, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 10 | 4 MAGIC 忍术/鬼道 | 0.5 | -1 | 300 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F39 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F20 | L55–58 / L57 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F36 | L60–63 / L62 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F37 | L65–69 / L67 | `$assisterCtrler.move(5,0);` — 设速度 |
|  |  / L68 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F38 | L71–80 / L73 | `$assisterCtrler.fire("atm1",{ "x":{ "start":20, "hit":1 }, "hits":-1 });` — 发射子弹 FIRE_BULLET |
| F39 | L82–85 / L84 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |

#### F69 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F69 | L87–90 / L89 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
