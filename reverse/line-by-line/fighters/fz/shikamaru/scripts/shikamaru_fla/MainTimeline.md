# `shikamaru_fla.MainTimeline` — 助战 奈良·鹿丸 根时间轴

一句话目的：助战 `奈良·鹿丸` 的 SWF 根时间轴：`setAssistCtrler` 注入 `$assisterCtrler`，`defineActions` 登记 `atm*` HitVO，后续帧驱动位移/必杀演出/子弹或攻击体，最后 `endAct`/`finish`。

源文件：`decompiled/fighters/fz/shikamaru/scripts/shikamaru_fla/MainTimeline.as`（99 行）

## 如何挂上引擎

助战 SWF 文档类。[`Assister`](../../../../../engine/game/bvn/fighter/Assister.md) 构造要求 `setAssistCtrler`，否则 throw。`new AssisiterCtrler` → `initAssister` → `_mainMc.setAssistCtrler`。本类把 ctrler 存成 `$assisterCtrler`，立刻 `defineActions()`。

`Assister.goFight()` 从第 2 帧播。时间轴 API 见 [`AssisiterCtrler`](../../../../../engine/game/bvn/fighter/ctrler/AssisiterCtrler.md)（类名少一个 s 的拼写是原样）。播到 `totalFrames-1` 会自动 `finish(true)`。

XML 辅助 id 目录名 `shikamaru`，comic_type 1 火影。文件 `assets/fighter/fz/shikamaru.swf`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L21 | `atm0` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L23 | `atmmc` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `MainTimeline()`（L27–31）

- L29: `super();`
- L30: `addFrameScript(0,frame1,15,frame16,37,frame38,39,frame40,43,frame44,57,frame58,74,frame75,80,frame81);`

#### `setAssistCtrler(param1:*)`（L33–37）

- L35: `$assisterCtrler = param1;`
- L36: `defineActions();`

#### `defineActions()`（L39–50）

- L41: `$assisterCtrler.defineAction("atm1",{ "power":10, "hitType":11, "hitx":0, "hity":0, "hurtTime":2000, "hurtType":0, "isBreakDef":true });`

HitVO 见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。助战 `getCurrentHits` 按子件 **name** 查模型。

### defineAction（助战）

| L | id | 含义 | power | hitType | hitx | hity | hurtTime | hurtType | 破防 |
|---|---|---|---|---|---|---|---|---|---|
| L41 | `atm1` | 助战判定 1 | 10 | 11 CATCH 抓 | 0 | 0 | 2000 | 0 | true |

`hurtType` 0=站硬直 / 1=击飞。`isBisha` 看 id 是否含 `bs`。`isCatch` 要 `hitType==11 && isBreakDef`（`sh1`/`sh2` 典型；助战 `atm1` 有时 hitType 11 但不破防，不算抓）。字段见 [`HitVO`](../../../../../engine/game/bvn/fighter/models/HitVO.md)。

### 逐帧脚本

共 8 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F1–F81 — 必杀演出

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1 | L52–55 / L54 | `stop();` — 停时间轴 |
| F16 | L57–60 / L59 | `$assisterCtrler.effect.bisha(false);` — 必杀演出（脸/黑屏） |
| F38 | L62–65 / L64 | `$assisterCtrler.effect.endBisha();` — 关必杀演出 |
| F40 | L67–70 / L69 | `$assisterCtrler.setHitTarget("atm0","hit");` — 打中检测盒 → 跳转标签 |
| F44 | L72–75 / L74 | `$assisterCtrler.effect.shine(9461816);` — 闪光（0x906038） |
| F58 | L77–80 / L79 | `$assisterCtrler.endAct();` — 结束当前招，清攻击允许 |
| F75 | L82–85 / L84 | `$assisterCtrler.finish();` — 助战退场 removeSelf |
| F81 | L87–96 / L89 | `$assisterCtrler.addAttacker("atmmc",{ "x":{ "moveToTarget":true, "offset":0 }, "applyG":false });` — 放出攻击体 ADD_ATTACKER |
