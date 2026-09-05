# `orihime_fla.MainTimeline` — 助战 井上·织姬 根时间轴

一句话目的：助战 `井上·织姬` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/orihime/scripts/orihime_fla/MainTimeline.as`（161 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `orihime`，comic_type 0 死神。文件 `assets/fighter/fz/orihime.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `main` | `MovieClip` |

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,10,frame11,20,frame21,24,frame25,47,frame48,49,frame50,51,frame52,53,frame54,55,frame56,57,frame58,59,frame60,61,frame62,63,frame64,65,frame66,67,frame68,70,frame71);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":0, "hitType":0, "hitx":0, "hity":0, "hurtTime":0, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 0 | 0 无（?） | 0 | 0 | 0 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 16 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F25 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F11 | L55–58 / L57 | `$assisterCtrler.move(6);` — 设速度 |
| F21 | L60–63 / L62 | `$assisterCtrler.move(0);` — 设速度 |
| F25 | L65–68 / L67 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |

#### F48–F71 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F48 | L70–73 / L72 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F50 | L75–81 / L77 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F52 | L83–89 / L85 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F54 | L91–97 / L93 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F56 | L99–105 / L101 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F58 | L107–113 / L109 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F60 | L115–121 / L117 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F62 | L123–129 / L125 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F64 | L131–137 / L133 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F66 | L139–145 / L141 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F68 | L147–153 / L149 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(10);` — 检测盒打中主人 |
| F71 | L155–158 / L157 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
