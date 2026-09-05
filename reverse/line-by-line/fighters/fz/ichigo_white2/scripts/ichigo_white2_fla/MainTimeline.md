# `ichigo_white2_fla.MainTimeline` — 助战 一护·虚·二段 根时间轴

一句话目的：助战 `一护·虚·二段` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/ichigo_white2/scripts/ichigo_white2_fla/MainTimeline.as`（130 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `ichigo_white2`，comic_type 0 死神。文件 `assets/fighter/fz/ichigo_white2.swf`。

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
- L32: `addFrameScript(0,frame1,14,frame15,28,frame29,31,frame32,43,frame44,54,frame55,61,frame62,62,frame63,69,frame70,89,frame90,92,frame93);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–70）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":30, "hitType":1, "hitx":10, "hity":-10, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L52: `$assisterCtrler.defineAction("atm2",{ "power":10, "hitType":1, "hitx":5, "hity":-5, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L61: `$assisterCtrler.defineAction("atm3",{ "power":50, "hitType":5, "hitx":10, "hity":10, "hurtTime":0, "hurtType":1, "isBreakDef":true });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 30 | 1 KAN 砍 | 10 | -10 | 500 | 0 | false |
| L52 | `atm2` | 助战判定 2 | 10 | 1 KAN 砍 | 5 | -5 | 500 | 0 | false |
| L61 | `atm3` | 助战判定 3 | 50 | 5 MAGIC_HEAVY 重法 | 10 | 10 | 0 | 1 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 11 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F93 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L72–75 / L74 | `stop();` — 停时间轴 |
| F15 | L77–80 / L79 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F29 | L82–85 / L84 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F32 | L87–91 / L89 | `$assisterCtrler.moveToTarget(50,0,true);` — 瞬移到目标相对坐标 |
|  |  / L90 | `$assisterCtrler.effect.slowDown(0.5);` — 全局慢动作 |
| F44 | L93–96 / L95 | `$assisterCtrler.justHit("atm1","act1",false);` — 刚命中判定 |
| F55 | L98–101 / L100 | `$assisterCtrler.finish(true);` — 助战退场 removeSelf |
| F62 | L103–106 / L105 | `$assisterCtrler.moveToTarget(10,0,true);` — 瞬移到目标相对坐标 |
| F63 | L108–111 / L110 | `$assisterCtrler.effect.shine();` — 闪光 |
| F70 | L113–117 / L115 | `$assisterCtrler.moveToTarget(-30,-50,false);` — 瞬移到目标相对坐标 |
|  |  / L116 | `$assisterCtrler.move(1,-1);` — 设速度 |
| F90 | L119–122 / L121 | `$assisterCtrler.move(0,0);` — 设速度 |
| F93 | L124–127 / L126 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
