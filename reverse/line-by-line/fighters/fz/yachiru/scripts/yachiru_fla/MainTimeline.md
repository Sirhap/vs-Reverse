# `yachiru_fla.MainTimeline` — 助战 草鹿·八千流 根时间轴

一句话目的：助战 `草鹿·八千流` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/yachiru/scripts/yachiru_fla/MainTimeline.as`（99 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `yachiru`，comic_type 0 死神。文件 `assets/fighter/fz/yachiru.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atmck` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,19,frame20,35,frame36,36,frame37,51,frame52,57,frame58,62,frame63,73,frame74);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–50）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":50, "hitType":3, "hitx":5, "hity":-2, "hurtTime":700, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 50 | 3 DA_HEAVY 重打 | 5 | -2 | 700 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 8 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F74 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L52–55 / L54 | `stop();` — 停时间轴 |
| F20 | L57–60 / L59 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F36 | L62–65 / L64 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F37 | L67–72 / L69 | `$assisterCtrler.move(20,0);` — 设速度 |
|  |  / L70 | `$assisterCtrler.setHitTarget("atmck","攻击2");` — 打中检测盒 → 跳转标签 |
|  |  / L71 | `$assisterCtrler.effect.shadow(200,-50,100);` — 残影 |
| F52 | L74–77 / L76 | `$assisterCtrler.damping(2,0);` — 阻尼 |
| F58 | L79–82 / L81 | `$assisterCtrler.finish(true);` — 助战退场 removeSelf |
| F63 | L84–90 / L86 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |
|  |  / L87 | `$assisterCtrler.setDirectToTarget();` — 朝向目标 |
|  |  / L88 | `$assisterCtrler.move(-10,0);` — 设速度 |
|  |  / L89 | `$assisterCtrler.damping(2,0);` — 阻尼 |
| F74 | L92–96 / L94 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L95 | `$assisterCtrler.effect.endShadow();` — 关残影 |
