# `itachi_fla.MainTimeline` — 助战 宇智波·鼬 根时间轴

一句话目的：助战 `宇智波·鼬` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/itachi/scripts/itachi_fla/MainTimeline.as`（143 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `itachi`，comic_type 1 火影。文件 `assets/fighter/fz/itachi.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L25 | `atm3` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L29–33）

- L31: `super();`
- L32: `addFrameScript(0,frame1,23,frame24,41,frame42,46,frame47,58,frame59,60,frame61,75,frame76,91,frame92,124,frame125,127,frame128,143,frame144,159,frame160,175,frame176,180,frame181);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–70）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":0, "hitType":4, "hitx":0, "hity":0, "hurtTime":2000, "hurtType":0, "isBreakDef":false });`
- L52: `$assisterCtrler.defineAction("atm2",{ "power":20, "hitType":1, "hitx":0, "hity":0, "hurtTime":600, "hurtType":0, "isBreakDef":false });`
- L61: `$assisterCtrler.defineAction("atm3",{ "power":40, "hitType":1, "hitx":-3, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 0 | 4 MAGIC 忍术/鬼道 | 0 | 0 | 2000 | 0 | false |
| L52 | `atm2` | 助战判定 2 | 20 | 1 KAN 砍 | 0 | 0 | 600 | 0 | false |
| L61 | `atm3` | 助战判定 3 | 40 | 1 KAN 砍 | -3 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 14 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L72–75 / L74 | `stop();` — 停时间轴 |

#### F24–F92 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F24 | L77–80 / L79 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F42 | L82–85 / L84 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F47 | L87–90 / L89 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F59 | L92–95 / L94 | `$assisterCtrler.justHit("atm1","攻击2",false);` — 刚命中判定 |
| F61 | L97–100 / L99 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
| F76 | L102–105 / L104 | `$assisterCtrler.finish();` — 助战退场 removeSelf |
| F92 | L107–110 / L109 | `$assisterCtrler.moveToTarget(0,null,false);` — 瞬移到目标相对坐标 |

#### F125–F181 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F125 | L112–115 / L114 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F128 | L117–120 / L119 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F144 | L122–125 / L124 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F160 | L127–130 / L129 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F176 | L132–135 / L134 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F181 | L137–140 / L139 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
