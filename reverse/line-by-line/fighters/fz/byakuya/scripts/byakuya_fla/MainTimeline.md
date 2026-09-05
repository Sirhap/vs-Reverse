# `byakuya_fla.MainTimeline` — 助战 朽木·白哉 根时间轴

一句话目的：助战 `朽木·白哉` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/byakuya/scripts/byakuya_fla/MainTimeline.as`（129 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `byakuya`，comic_type 0 死神。文件 `assets/fighter/fz/byakuya.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm0` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `lzgl` | `MovieClip` |
| L27 | `judge` | `Boolean` |

### 函数

#### `MainTimeline()`（L29–33）

- L31: `super();`
- L32: `addFrameScript(0,frame1,18,frame19,46,frame47,49,frame50,50,frame51,51,frame52,59,frame60,60,frame61,84,frame85);`

#### `setAssistCtrler(param1:*)`（L35–39）

- L37: `$assisterCtrler = param1;`
- L38: `defineActions();`

#### `defineActions()`（L41–52）

- L43: `$assisterCtrler.defineAction("atm1",{ "power":50, "hitType":11, "hitx":0, "hity":0, "hurtTime":1750, "hurtType":0, "isBreakDef":false });`

#### `HurtStateEvent(param1:Event)`（L54–61）

- L56: `if($assisterCtrler.getOwner().getCtrler().getTargetState() != 21) $assisterCtrler.getOwner().getCtrler().getMcCtrl().getAttacker("lzgl").gotoAndPlay("end");` — 切助战/攻击体标签（引擎实现是 gotoAndStop+逐帧）
- L59: `removeEventListener(Event.ENTER_FRAME,HurtStateEvent);`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L43 | `atm1` | 助战判定 1 | 50 | 11 CATCH 抓 | 0 | 0 | 1750 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 9 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F19 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L63–66 / L65 | `stop();` — 停时间轴 |
| F19 | L68–71 / L70 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |

#### F47–F61 — 放出攻击体 `lzgl`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F47 | L73–76 / L75 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F50 | L78–82 / L80 | `judge = false;` |
|  |  / L81 | `$assisterCtrler.setHitTarget("atm0","success");` — 打中检测盒 → 跳转标签 |
| F51 | L84–87 / L86 | `$assisterCtrler.gotoAndPlay("failure");` — 切助战/攻击体标签（引擎实现是 gotoAndStop+逐帧） |
| F52 | L89–104 / L91 | `$assisterCtrler.effect.shine(16776960);` — 闪光（0xFFFF00） |
|  |  / L92 | `judge = true;` |
|  |  / L93 | `$assisterCtrler.addAttacker("lzgl",{ "x":{ "followTarget":true, "offset":0 }, "y":{ "followTarget":true, "offset":-30 }, "applyG":false });` — 放出攻击体 ADD_ATTACKER |
| F60 | L106–116 / L108 | `if($assisterCtrler.getOwner().getCtrler().getTargetState() == 21 && judge) $assisterCtrler.getTarget().getCtrler().getMcCtrl().isApplyG(false);` — 是否受重力 |
|  |  / L112 | `if(judge) addEventListener(Event.ENTER_FRAME,HurtStateEvent);` — 条件 |
| F61 | L118–121 / L120 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |

#### F85 — 助战退场

| 帧 | 函数 L | 调用 |
|---|---|---|
| F85 | L123–126 / L125 | `$assisterCtrler.finish();` — 助战退场 removeSelf |
