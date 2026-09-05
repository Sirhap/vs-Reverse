# `minato_fla.MainTimeline` — 助战 四代火影 根时间轴

一句话目的：助战 `四代火影` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/minato/scripts/minato_fla/MainTimeline.as`（187 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `minato`，comic_type 1 火影。文件 `assets/fighter/fz/minato.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atm2` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L25 | `atm3` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L27 | `atm4` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L29 | `atm5` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L33–37）

- L35: `super();`
- L36: `addFrameScript(0,frame1,2,frame3,24,frame25,30,frame31,34,frame35,39,frame40,49,frame50,59,frame60,69,frame70,84,frame85,90,frame91,91,frame92,98,frame99,133,frame134,138,frame139,163,frame164,169,frame170);`

#### `setAssistCtrler(param1:*)`（L39–43）

- L41: `$assisterCtrler = param1;`
- L42: `defineActions();`

#### `defineActions()`（L45–92）

- L47: `$assisterCtrler.defineAction("atm1",{ "power":20, "hitType":5, "hitx":0, "hity":20, "hurtTime":0, "hurtType":1, "isBreakDef":false });`
- L56: `$assisterCtrler.defineAction("atm3",{ "power":20, "hitType":3, "hitx":5, "hity":-10, "hurtTime":1000, "hurtType":0, "isBreakDef":false });`
- L65: `$assisterCtrler.defineAction("atm5",{ "power":5, "hitType":4, "hitx":0, "hity":20, "hurtTime":300, "hurtType":0, "isBreakDef":false });`
- L74: `$assisterCtrler.defineAction("atm2",{ "power":20, "hitType":3, "hitx":5, "hity":0, "hurtTime":1000, "hurtType":0, "isBreakDef":false });`
- L83: `$assisterCtrler.defineAction("atm4",{ "power":20, "hitType":6, "hitx":-4, "hity":0, "hurtTime":1000, "hurtType":0, "isBreakDef":true });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L47 | `atm1` | 助战判定 1 | 20 | 5 MAGIC_HEAVY 重法 | 0 | 20 | 0 | 1 | false |
| L56 | `atm3` | 助战判定 3 | 20 | 3 DA_HEAVY 重打 | 5 | -10 | 1000 | 0 | false |
| L65 | `atm5` | 助战判定 5 | 5 | 4 MAGIC 忍术/鬼道 | 0 | 20 | 300 | 0 | false |
| L74 | `atm2` | 助战判定 2 | 20 | 3 DA_HEAVY 重打 | 5 | 0 | 1000 | 0 | false |
| L83 | `atm4` | 助战判定 4 | 20 | 6 KAN_HEAVY 重砍 | -4 | 0 | 1000 | 0 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 17 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F99 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L94–97 / L96 | `stop();` — 停时间轴 |
| F3 | L99–102 / L101 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F25 | L104–107 / L106 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F31 | L109–115 / L111 | `$assisterCtrler.moveToTarget(-100,0,false);` — 瞬移到目标相对坐标 |
|  |  / L112 | `$assisterCtrler.move(15,0);` — 设速度 |
|  |  / L113 | `$assisterCtrler.damping(0.5,0);` — 阻尼 |
|  |  / L114 | `$assisterCtrler.effect.shadow(200,200,0);` — 残影 |
| F35 | L117–121 / L119 | `$assisterCtrler.effect.shine();` — 闪光 |
|  |  / L120 | `$assisterCtrler.effect.shine(1069248);` — 闪光（0x1050C0） |
| F40 | L123–126 / L125 | `$assisterCtrler.effect.endShadow();` — 关残影 |
| F50 | L128–131 / L130 | `$assisterCtrler.justHit("atm2","attack2",false);` — 刚命中判定 |
| F60 | L133–136 / L135 | `$assisterCtrler.gotoAndPlay("atm");` — 切助战/攻击体标签（引擎实现是 gotoAndStop+逐帧） |
| F70 | L138–141 / L140 | `$assisterCtrler.moveToTarget(10,0,false);` — 瞬移到目标相对坐标 |
| F85 | L143–146 / L145 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
| F91 | L148–151 / L150 | `$assisterCtrler.finish(false);` — 助战退场 removeSelf |
| F92 | L153–157 / L155 | `$assisterCtrler.effect.shine();` — 闪光 |
|  |  / L156 | `$assisterCtrler.effect.shine(1069248);` — 闪光（0x1050C0） |
| F99 | L159–162 / L161 | `$assisterCtrler.moveToTarget(40,0,true);` — 瞬移到目标相对坐标 |

#### F134–F139 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F134 | L164–169 / L166 | `$assisterCtrler.moveToTarget(-20,-200,false);` — 瞬移到目标相对坐标 |
|  |  / L167 | `$assisterCtrler.move(0,20);` — 设速度 |
|  |  / L168 | `$assisterCtrler.effect.shadow(200,200,0);` — 残影 |
| F139 | L171–174 / L173 | `$assisterCtrler.effect.endShadow();` — 关残影 |

#### F164–F170 — 助战退场

| 帧 | 函数 L | 调用 |
|---|---|---|
| F164 | L176–179 / L178 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
| F170 | L181–184 / L183 | `$assisterCtrler.finish(false);` — 助战退场 removeSelf |
