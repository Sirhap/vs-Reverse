# `yoruichi_fla.MainTimeline` — 助战 四枫院·夜一 根时间轴

一句话目的：助战 `四枫院·夜一` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/yoruichi/scripts/yoruichi_fla/MainTimeline.as`（61 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `yoruichi`，comic_type 0 死神。文件 `assets/fighter/fz/yoruichi.swf`。

## 逐行说明

### 函数

#### `MainTimeline()`（L23–27）

- L25: `super();`
- L26: `addFrameScript(0,frame1,1,frame2);`

#### `setAssistCtrler(param1:*)`（L29–33）

- L31: `$assisterCtrler = param1;`
- L32: `defineActions();`

#### `defineActions()`（L35–46）

- L37: `$assisterCtrler.defineAction("atm1",{ "power":0, "hitType":0, "hitx":0, "hity":0, "hurtTime":0, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L37 | `atm1` | 助战判定 1 | 0 | 0 无（?） | 0 | 0 | 0 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 2 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F2 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L48–51 / L50 | `stop();` — 停时间轴 |
| F2 | L53–58 / L55 | `$assisterCtrler.effect.shine(16776960);` — 闪光（0xFFFF00） |
|  |  / L56 | `$assisterCtrler.getOwner().getCtrler().moveOnce(120,0);` — 一次性位移 |
|  |  / L57 | `$assisterCtrler.getOwner().getBuffCtrl().speedUp(5,5);` — 主人 buff |
