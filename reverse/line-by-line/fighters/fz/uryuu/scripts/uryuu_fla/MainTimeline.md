# `uryuu_fla.MainTimeline` — 助战 石田·雨龙 根时间轴

一句话目的：助战 `石田·雨龙` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/uryuu/scripts/uryuu_fla/MainTimeline.as`（85 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `uryuu`，comic_type 0 死神。文件 `assets/fighter/fz/uryuu.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,16,frame17,19,frame20,38,frame39,40,frame41,46,frame47);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":80, "hitType":5, "hitx":3, "hity":10, "hurtTime":500, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 80 | 5 MAGIC_HEAVY 重法 | 3 | 10 | 500 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 6 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F47 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F17 | L55–59 / L57 | `$assisterCtrler.moveToTarget(0,-100);` — 瞬移到目标相对坐标 |
|  |  / L58 | `$assisterCtrler.setApplyG(false);` — 是否受重力 |
| F20 | L61–64 / L63 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F39 | L66–69 / L68 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F41 | L71–77 / L73 | `$assisterCtrler.effect.shine();` — 闪光 |
|  |  / L74 | `$assisterCtrler.effect.shine(7329791);` — 闪光（0x6FD7FF） |
|  |  / L75 | `$assisterCtrler.move(0,-5);` — 设速度 |
|  |  / L76 | `$assisterCtrler.damping(0,0.5);` — 阻尼 |
| F47 | L79–82 / L81 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
