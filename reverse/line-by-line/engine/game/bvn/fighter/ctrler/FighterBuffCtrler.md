# `fighter.ctrler.FighterBuffCtrler` — 攻速防限时修正

一句话目的：按属性名把 `FighterMain` 的 `speed` / `attackRate` / `defenseRate`（以及误用的 `defense`）加上偏移，到期写回 `resumeValue`。加益时顺带播 `buff_effect_*` 爆发 + `buff_*` 跟随光。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterBuffCtrler.as`（118 行）

## Callers / callees

- **装配**：`FighterMain.initlize` 在 `setFighterCtrler` 成功后 `new FighterBuffCtrler(this)`。`FighterMain.destory` → `destory()`。
- **每帧**：`FighterMain.render`（逻辑帧）→ `render()`。
- **写入**：本包只有助战 SWF 经 `getOwner().getBuffCtrl()`：
  - 夜一 / sai：`speedUp(5,5)`
  - kon：`attackUp(0.3,5)`
  - 土影：`defenseUp(0.3,5)`
- **未见调用**：`speedDown` / `attackDown` / `defenseDown`（本包 SWF 与引擎都没调）。
- **Callees**：`FighterBuffVO`（`param2` 秒 × `FPS_GAME` 成帧）、`EffectCtrl.doEffectById` / `doBuffEffect`。动态 `_fighter[paramName]` 读写。

## 命名备注

- `destory`：原拼写。
- `_speed` / `_attackRate`：字段初始化 0，**从未读写**。? 旧实现残留。
- `defenseUp` 写属性 `"defenseRate"`（倍率，默认 1）；`defenseDown` 写 `"defense"`（`BaseGameSprite` 的平坦减伤值，默认 0）。加减防走的不是同一字段。
- `attackDown` **没有**取负，传正数等于再 `attackUp`。?

## 逐行说明

### 字段 / 构造（L10–22）

- `_fighter`：目标角色。
- `_speed` / `_attackRate`：死字段。
- `_buffObj`：`属性名 → FighterBuffVO`。每种属性同时只一条；重复施加刷新持续时间、覆盖当前值。
- 构造 `param1`=`FighterMain`。

### `destory`（L24–27）

只 `_fighter=null`。**不**把还在身上的 buff 写回 `resumeValue`，也不清 `_buffObj`。角色 destory 后属性一起丢，无泄漏到下一场（新 `FighterMain`）。

### `speedUp`（L29–38）

`param1` 速度增量默认 0，`param2` 持续秒默认 5。`addBuff("speed", …)` 失败（try 炸）则 return，不播特效。成功：`buff_effect_speed` 在角色 x/y 爆发，`buff_speed` 跟随 VO。夜一 `speedUp(5,5)`：speed 基础 6~14 再 +5。

### `attackUp`（L40–49）

`addBuff("attackRate", …)`。特效 id 是 `buff_effect_power` / `buff_power`（名字 power，属性 attackRate）。`FighterMain.set attackRate` 会同步 hit 模型 `setPowerRate`。

### `defenseUp`（L51–60）

`addBuff("defenseRate", …)`。特效 `buff_effect_defense` / `buff_defense`。`loseHp` 读 `defenseRate`。

### `speedDown`（L62–65）

`addBuff("speed", -param1, param2)`。无特效。本包无调用。

### `attackDown`（L67–70）

`addBuff("attackRate", param1, param2)` —— **未取负**。param1>0 时攻击升不是降。无特效。本包无调用。?

### `defenseDown`（L72–75）

`addBuff("defense", -param1, param2)`。写的是平坦 `defense` 不是 `defenseRate`。无特效。本包无调用。?

### `addBuff`（L77–101）私有

`param1` 属性名，`param2` 加到 `resumeValue` 上的偏移，`param3` 持续秒。

try：

1. `_buffObj[param1]` 已有：只 `setHold(param3)` 刷新帧数（`resumeValue` 保持第一次的快照）。
2. 没有：`new FighterBuffVO(param1, param3)`，`resumeValue = _fighter[param1]`（动态属性；名字写错会进 catch）。
3. `_fighter[param1] = resumeValue + param2`。同名再施加会用**第一次**的 resume + **本次** param2，不是叠两次偏移。
4. return VO。

catch：`trace(e)` return null。`speedUp` 等据此跳过特效。

### `render`（L103–115）

遍历 `_buffObj`。`FighterBuffVO.render()` 到期（`--holdFrame <= 0`）为 true：把 `_fighter[vo.param]` 写回 `resumeValue`，`delete` 该键。`BuffEffectView` 看 VO.finished 停光。for-in + delete 当前键在 AS3 安全。
