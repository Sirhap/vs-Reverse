# `madara_fla.MainTimeline` — 助战 宇智波·斑 根时间轴

一句话目的：助战 `宇智波·斑` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/madara/scripts/madara_fla/MainTimeline.as`（105 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `madara`，comic_type 1 火影。文件 `assets/fighter/fz/madara.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `smc` | `MovieClip` |

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,14,frame15,30,frame31,35,frame36,36,frame37,65,frame66);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–66）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":3, "hitx":0, "hity":0, "hurtTime":1000, "hurtType":0, "isBreakDef":true });`
- L48: `$assisterCtrler.defineAction("atm2",{ "power":10, "hitType":4, "hitx":0, "hity":0, "hurtTime":1000, "hurtType":0, "isBreakDef":false });`
- L57: `$assisterCtrler.defineAction("atm3",{ "power":100, "hitType":7, "hitx":10, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 20 | 3 DA_HEAVY 重打 | 0 | 0 | 1000 | 0 | true |
| L48 | `atm2` | 助战判定 2 | 10 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 1000 | 0 | false |
| L57 | `atm3` | 助战判定 3 | 100 | 7 FIRE 火 | 10 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 6 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F37 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L68–71 / L70 | `stop();` — 停时间轴 |
| F15 | L73–76 / L75 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F31 | L78–81 / L80 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F36 | L83–92 / L85 | `$assisterCtrler.addAttacker("smc",{ "x":{ "moveToTarget":true, "offset":-20 }, "applyG":false });` — 放出攻击体 ADD_ATTACKER |
| F37 | L94–97 / L96 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |

#### F66 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F66 | L99–102 / L101 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
