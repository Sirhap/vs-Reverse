# `sai_fla.MainTimeline` — 助战 佐井 根时间轴

一句话目的：助战 `佐井` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/sai/scripts/sai_fla/MainTimeline.as`（88 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `sai`，comic_type 1 火影。文件 `assets/fighter/fz/sai.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atmmc` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L25–29）

- L27: `super();`
- L28: `addFrameScript(0,frame1,14,frame15,29,frame30,31,frame32,32,frame33,53,frame54);`

#### `setAssistCtrler(param1:*)`（L31–35）

- L33: `$assisterCtrler = param1;`
- L34: `defineActions();`

#### `defineActions()`（L37–48）

- L39: `$assisterCtrler.defineAction("atm1",{ "power":10, "hitType":4, "hitx":0, "hity":-5, "hurtTime":800, "hurtType":0, "isBreakDef":false });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L39 | `atm1` | 助战判定 1 | 10 | 4 MAGIC 忍术/鬼道 | 0 | -5 | 800 | 0 | false |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 6 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F54 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L50–53 / L52 | `stop();` — 停时间轴 |
| F15 | L55–59 / L57 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
|  |  / L58 | `$assisterCtrler.getOwner().getBuffCtrl().speedUp(5,5);` — 主人 buff |
| F30 | L61–64 / L63 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F32 | L66–75 / L68 | `$assisterCtrler.addAttacker("atmmc",{ "x":{ "moveToTarget":true, "offset":0 }, "applyG":false });` — 放出攻击体 ADD_ATTACKER |
| F33 | L77–80 / L79 | `$assisterCtrler.effect.shine(0);` — 闪光 |
| F54 | L82–85 / L84 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
