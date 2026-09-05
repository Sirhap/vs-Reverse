# `tenten_fla.MainTimeline` — 助战 天天 根时间轴

一句话目的：助战 `天天` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/tenten/scripts/tenten_fla/MainTimeline.as`（130 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `tenten`，comic_type 1 火影。文件 `assets/fighter/fz/tenten.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,15,frame16,37,frame38,39,frame40,45,frame46,51,frame52,57,frame58,63,frame64,77,frame78,113,frame114);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–59）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":10, "hitType":1, "hitx":2, "hity":0, "hurtTime":800, "hurtType":0, "isBreakDef":false });`
- L50: `$assisterCtrler.defineAction("atm2",{ "power":50, "hitType":6, "hitx":10, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 10 | 1 KAN 砍 | 2 | 0 | 800 | 0 | false |
| L50 | `atm2` | 助战判定 2 | 50 | 6 KAN_HEAVY 重砍 | 10 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 10 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F78 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L61–64 / L63 | `stop();` — 停时间轴 |
| F16 | L66–69 / L68 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F38 | L71–74 / L73 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F40 | L76–82 / L78 | `$assisterCtrler.fire("atm1",{ "x":20, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F46 | L84–90 / L86 | `$assisterCtrler.fire("atm1",{ "x":20, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F52 | L92–98 / L94 | `$assisterCtrler.fire("atm1",{ "x":20, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F58 | L100–106 / L102 | `$assisterCtrler.fire("atm1",{ "x":20, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F64 | L108–114 / L110 | `$assisterCtrler.fire("atm1",{ "x":20, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F78 | L116–122 / L118 | `$assisterCtrler.fire("atm2",{ "x":30, "hits":1 });` — 发射子弹 FIRE_BULLET |

#### F114 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F114 | L124–127 / L126 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
