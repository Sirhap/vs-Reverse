# `suigetsu_fla.MainTimeline` — 助战 鬼灯·水月 根时间轴

一句话目的：助战 `鬼灯·水月` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/suigetsu/scripts/suigetsu_fla/MainTimeline.as`（100 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `suigetsu`，comic_type 1 火影。文件 `assets/fighter/fz/suigetsu.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,12,frame13,27,frame28,34,frame35,43,frame44,52,frame53,63,frame64);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–59）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":1, "hitx":3, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L50: `$assisterCtrler.defineAction("atm2",{ "power":50, "hitType":6, "hitx":5, "hity":-5, "hurtTime":600, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 20 | 1 KAN 砍 | 3 | 0 | 500 | 0 | false |
| L50 | `atm2` | 助战判定 2 | 50 | 6 KAN_HEAVY 重砍 | 5 | -5 | 600 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F64 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L61–64 / L63 | `stop();` — 停时间轴 |
| F13 | L66–69 / L68 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F28 | L71–74 / L73 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F35 | L76–80 / L78 | `$assisterCtrler.moveToTarget(80,null,true);` — 瞬移到目标相对坐标 |
|  |  / L79 | `$assisterCtrler.effect.slowDown(0.5);` — 全局慢动作 |
| F44 | L82–86 / L84 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L85 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F53 | L88–92 / L90 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L91 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F64 | L94–97 / L96 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
