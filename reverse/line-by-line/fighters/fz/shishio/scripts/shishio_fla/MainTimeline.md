# `shishio_fla.MainTimeline` — 助战 志志雄·真实 根时间轴

一句话目的：助战 `志志雄·真实` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/shishio/scripts/shishio_fla/MainTimeline.as`（131 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `shishio`，comic_type 0 交叉。文件 `assets/fighter/fz/shishio.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L25 | `atm3` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L27 | `ckmc` | `MovieClip` |

### 函数

#### `MainTimeline()`（L31–35）

- L33: `super();`
- L34: `addFrameScript(0,frame1,15,frame16,34,frame35,35,frame36,54,frame55,56,frame57,59,frame60,65,frame66,80,frame81,95,frame96);`

#### `setAssistCtrler(param1:*)`（L37–41）

- L39: `$assisterCtrler = param1;`
- L40: `defineActions();`

#### `defineActions()`（L43–72）

- L45: `$assisterCtrler.defineAction("atm1",{ "power":10, "hitType":11, "hitx":0, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":true });`
- L54: `$assisterCtrler.defineAction("atm3",{ "power":50, "hitType":1, "hitx":0, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false });`
- L63: `$assisterCtrler.defineAction("atm2",{ "power":50, "hitType":7, "hitx":15, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L45 | `atm1` | 助战判定 1 | 10 | 11 CATCH 抓 | 0 | 0 | 500 | 0 | true |
| L54 | `atm3` | 助战判定 3 | 50 | 1 KAN 砍 | 0 | 0 | 500 | 0 | false |
| L63 | `atm2` | 助战判定 2 | 50 | 7 FIRE 火 | 15 | 0 | 0 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 10 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F96 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L74–77 / L76 | `stop();` — 停时间轴 |
| F16 | L79–82 / L81 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F35 | L84–87 / L86 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F36 | L89–95 / L91 | `$assisterCtrler.effect.dash();` — 冲刺特效 dash/dash_air |
|  |  / L92 | `$assisterCtrler.move(15,0);` — 设速度 |
|  |  / L93 | `$assisterCtrler.setHitTarget("ckmc","攻击2");` — 打中检测盒 → 跳转标签 |
|  |  / L94 | `$assisterCtrler.effect.shadow(0,0,200);` — 残影 |
| F55 | L97–100 / L99 | `$assisterCtrler.effect.endShadow();` — 关残影 |
| F57 | L102–105 / L104 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
| F60 | L107–111 / L109 | `$assisterCtrler.move(0,0);` — 设速度 |
|  |  / L110 | `$assisterCtrler.finish();` — 助战退场 removeSelf |
| F66 | L113–118 / L115 | `$assisterCtrler.effect.shine(9461864);` — 闪光（0x906068） |
|  |  / L116 | `$assisterCtrler.move(0,0);` — 设速度 |
|  |  / L117 | `$assisterCtrler.effect.endShadow();` — 关残影 |
| F81 | L120–123 / L122 | `$assisterCtrler.effect.shine(16281600);` — 闪光（0xF87000） |
| F96 | L125–128 / L127 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
