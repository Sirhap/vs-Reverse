# `stake_fla.MainTimeline` — 助战 托尼·斯塔克 根时间轴

一句话目的：助战 `托尼·斯塔克` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/stake/scripts/stake_fla/MainTimeline.as`（110 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `stake`，comic_type 0 交叉。文件 `assets/fighter/fz/stake.swf`。

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
- L32: `addFrameScript(0,frame1,9,frame10,20,frame21,26,frame27,33,frame34,42,frame43,73,frame74);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–70）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":2, "hitx":4, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L52: `$assisterCtrler.defineAction("atm2",{ "power":20, "hitType":1, "hitx":2, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L61: `$assisterCtrler.defineAction("atm3",{ "power":100, "hitType":5, "hitx":10, "hity":0, "hurtTime":800, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 20 | 2 DA 打 | 4 | 0 | 500 | 0 | false |
| L52 | `atm2` | 助战判定 2 | 20 | 1 KAN 砍 | 2 | 0 | 500 | 0 | false |
| L61 | `atm3` | 助战判定 3 | 100 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 800 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F43 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L72–75 / L74 | `stop();` — 停时间轴 |
| F10 | L77–80 / L79 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F21 | L82–85 / L84 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F27 | L87–90 / L89 | `$assisterCtrler.moveToTarget(-50,0,false);` — 瞬移到目标相对坐标 |
| F34 | L92–96 / L94 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L95 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F43 | L98–102 / L100 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L101 | `$assisterCtrler.damping(1,0);` — 阻尼 |

#### F74 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F74 | L104–107 / L106 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
