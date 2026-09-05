# `harribel_fla.MainTimeline` — 助战 蒂雅.赫丽贝尔（XML id=`halibel`） 根时间轴

一句话目的：助战 `蒂雅.赫丽贝尔（XML id=`halibel`）` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/harribel/scripts/harribel_fla/MainTimeline.as`（86 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `harribel`，comic_type 0 死神。文件 `assets/fighter/fz/harribel.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,15,frame16,29,frame30,31,frame32,32,frame33,42,frame43,54,frame55);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":110, "hitType":5, "hitx":10, "hity":0, "hurtTime":500, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 110 | 5 MAGIC_HEAVY 重法 | 10 | 0 | 500 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 7 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F55 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F16 | L55–58 / L57 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F30 | L60–63 / L62 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F32 | L65–68 / L67 | `$assisterCtrler.move(30,0);` — 设速度 |
| F33 | L70–73 / L72 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |
| F43 | L75–78 / L77 | `$assisterCtrler.damping(3,0);` — 阻尼 |
| F55 | L80–83 / L82 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
