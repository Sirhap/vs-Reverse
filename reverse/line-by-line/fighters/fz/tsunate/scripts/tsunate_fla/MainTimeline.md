# `tsunate_fla.MainTimeline` — 助战 纲手 根时间轴

一句话目的：助战 `纲手` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/tsunate/scripts/tsunate_fla/MainTimeline.as`（138 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `tsunate`，comic_type 1 火影。文件 `assets/fighter/fz/tsunate.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm1` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `main` | `MovieClip` |

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,6,frame7,9,frame10,12,frame13,15,frame16,18,frame19,21,frame22,24,frame25,27,frame28,38,frame39,44,frame45,59,frame60);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–50）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":50, "hitType":5, "hitx":15, "hity":0, "hurtTime":500, "hurtType":1, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 50 | 5 MAGIC_HEAVY 重法 | 15 | 0 | 500 | 1 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 12 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F60 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L52–55 / L54 | `stop();` — 停时间轴 |
| F7 | L57–63 / L59 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F10 | L65–71 / L67 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F13 | L73–79 / L75 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F16 | L81–87 / L83 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F19 | L89–95 / L91 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F22 | L97–103 / L99 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F25 | L105–111 / L107 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F28 | L113–119 / L115 | `if($assisterCtrler.checkHitOwner("main")) $assisterCtrler.getOwner().addHp(5);` — 检测盒打中主人 |
| F39 | L121–124 / L123 | `$assisterCtrler.moveToTarget(-50,null,false);` — 瞬移到目标相对坐标 |
| F45 | L126–130 / L128 | `$assisterCtrler.move(10,0);` — 设速度 |
|  |  / L129 | `$assisterCtrler.damping(1,0);` — 阻尼 |
| F60 | L132–135 / L134 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
