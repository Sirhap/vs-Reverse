# `grimmjow_fla.MainTimeline` — 助战 葛力姆乔·贾卡杰克 根时间轴

一句话目的：助战 `葛力姆乔·贾卡杰克` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/grimmjow/scripts/grimmjow_fla/MainTimeline.as`（111 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `grimmjow`，comic_type 0 死神。文件 `assets/fighter/fz/grimmjow.swf`。

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
- L32: `addFrameScript(0,frame1,19,frame20,35,frame36,36,frame37,40,frame41,44,frame45,107,frame108);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–70）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":2, "hitx":3, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L52: `$assisterCtrler.defineAction("atm2",{ "power":5, "hitType":1, "hitx":0, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L61: `$assisterCtrler.defineAction("atm3",{ "power":50, "hitType":6, "hitx":5, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 20 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L52 | `atm2` | 助战判定 2 | 5 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L61 | `atm3` | 助战判定 3 | 50 | 6 KAN_HEAVY 重砍 | 5 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F45 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L72–75 / L74 | `stop();` — 停时间轴 |
| F20 | L77–80 / L79 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F36 | L82–85 / L84 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F37 | L87–91 / L89 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L90 | `$assisterCtrler.damping(0.5,0);` — 阻尼 |
| F41 | L93–96 / L95 | `$assisterCtrler.moveToTarget(-50,0,false);` — 瞬移到目标相对坐标 |
| F45 | L98–103 / L100 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |
|  |  / L101 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L102 | `$assisterCtrler.damping(1,0);` — 阻尼 |

#### F108 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F108 | L105–108 / L107 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
