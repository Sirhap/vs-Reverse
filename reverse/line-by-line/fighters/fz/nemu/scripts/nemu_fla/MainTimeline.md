# `nemu_fla.MainTimeline` — 助战 涅音梦 根时间轴

一句话目的：助战 `涅音梦` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/nemu/scripts/nemu_fla/MainTimeline.as`（126 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `nemu`，comic_type 0 死神。文件 `assets/fighter/fz/nemu.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L25 | `ckm` | `MovieClip` |

### 函数

#### `MainTimeline()`（L29–33）

- L31: `super();`
- L32: `addFrameScript(0,frame1,14,frame15,30,frame31,31,frame32,50,frame51,56,frame57,64,frame65,71,frame72,74,frame75,81,frame82,92,frame93);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–61）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":2, "hitx":3, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L52: `$assisterCtrler.defineAction("atm2",{ "power":40, "hitType":3, "hitx":10, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":true });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 20 | 2 DA 打 | 3 | 0 | 500 | 0 | false |
| L52 | `atm2` | 助战判定 2 | 40 | 3 DA_HEAVY 重打 | 10 | 0 | 500 | 0 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 11 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F93 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L63–66 / L65 | `stop();` — 停时间轴 |
| F15 | L68–71 / L70 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F31 | L73–76 / L75 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F32 | L78–83 / L80 | `$assisterCtrler.move(20,0);` — 设速度 |
|  |  / L81 | `$assisterCtrler.setHitTarget("ckm","攻击2");` — 打中检测盒 → 跳转标签 |
|  |  / L82 | `$assisterCtrler.effect.shadow(100,-50,100);` — 残影 |
| F51 | L85–90 / L87 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |
|  |  / L88 | `$assisterCtrler.move(5,0);` — 设速度 |
|  |  / L89 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F57 | L92–96 / L94 | `$assisterCtrler.move(5,0);` — 设速度 |
|  |  / L95 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F65 | L98–101 / L100 | `$assisterCtrler.justHit("atm1","attack2",false);` — 刚命中判定 |
| F72 | L103–106 / L105 | `$assisterCtrler.finish(true);` — 助战退场 removeSelf |
| F75 | L108–112 / L110 | `$assisterCtrler.move(13,0);` — 设速度 |
|  |  / L111 | `$assisterCtrler.damping(0.5,0);` — 阻尼 |
| F82 | L114–118 / L116 | `$assisterCtrler.setDirectToTarget();` — 朝向目标 |
|  |  / L117 | `$assisterCtrler.effect.endShadow();` — 关残影 |
| F93 | L120–123 / L122 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
