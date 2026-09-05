# `fighter.models.FighterHitModel` — 角色具名打击表

一句话目的：把时间轴 `defineAction(id, {power, hitType, …})` 登记成 `HitVO`，供攻击盒名（`atm*`）和 AI 前缀查询；`FighterMain.attackRate` 同步到每条 `powerRate`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/models/FighterHitModel.as`（79 行）

## Callers / callees

- **持有**：`FighterCtrler.hitModel`（`initFighter` `new FighterHitModel(_fighter)`）；`AssisiterCtrler.hitModel`（`initAssister`，owner 是 `Assister`）。角色侧没有 `FighterMain.hitModel` 字段，经 `getCtrler().hitModel`。
- **写入**：`FighterCtrler.defineAction` / `AssisiterCtrler.defineAction` → `addHitVO`。角色/辅助 SWF `MainTimeline` 开场大量 `this.defineAction("tk"|"kj1"|"bs"|…, {power, hitType, hitx, hity, hurtTime, hurtType, isBreakDef, checkDirect?})`。
- **读取**：
  - `FighterMC.findHitArea`、`FighterAttacker`、`FighterMcCtrler.fire/addAttacker`、`FighterAttackerCtrler.fire`：`getHitVOByDisplayName`（子 MC 名 `atm`/`atmk1`…）。
  - `Assister.findHitArea`、`AssisiterCtrler.fire`：`getHitVO(name)` 精确名。
  - `FighterAILogicBase.isBreakAct/isHitDownAct`：`getHitVOLike(prefix)`。
- **倍率**：`FighterMain.set attackRate` → `hitModel.setPowerRate`。`GameLogic` 开局写 `fighter.attackRate`。
- **销毁**：`FighterCtrler.destory` / `AssisiterCtrler.destory` → `hitModel.destory()`。`clear()` **无调用方**。

## 命名备注

- `destory`：原拼写。
- `_hitObj`：id → `HitVO` 的动态 Object，不是 Dictionary。
- `atm`：攻击盒 DisplayObject 名前缀；`getHitVOByDisplayName` 去掉此后当 hit id。

## 逐行说明

### 字段 / 构造（L8–16）

`_hitObj = {}`，`_fighter` = 构造参数（`FighterMain` 或 `Assister`）。稍后 `addHitVO` 写到每条 `HitVO.owner`。

### `destory`（L18–22）

两引用置 null。已发出去的 HitVO 仍可能被子弹 `clone` 持有。

### `clear`（L24–27）

`_hitObj = {}`。运行路径未见。

### `getHitVO`（L29–32）

精确 id。没有则 `undefined`（AS3 当 null 用）。

### `getHitVOLike`（L34–45）

`id.indexOf(param1) != -1` 的全部 HitVO，新 `Vector`。空前缀会匹配所有。AI 用 `"kj1"` 能扫到 `kj1`/`kj11`/`kj12`。顺序为 for-in，不稳定。

### `getHitVOByDisplayName`（L47–60）

1. 精确 `getHitVO(name)` 有则返回（盒名与 defineAction id 相同的情况）。
2. `name` **不含** `"atm"` → null。
3. `name.replace("atm","")` 再查。只替换 **第一处**：`atm`→空串再 getHitVO("")；`atmk1`→`k1`；`fooatmbar` 也会剥（实际盒名都是前缀）。

`FighterMC.getCurrentHitSprite` 收集 `name.indexOf("atm")!=-1` 的子件，与这条路径对齐。

### `addHitVO`（L62–68）

`new HitVO(obj)` → `owner=_fighter` → `id=param1` → `_hitObj[id]=`。同 id 后写覆盖。构造里 `HitVO` 已 `KyoUtils.setValueByObject`，随后 **强制** `id`/`owner` 覆盖 obj 里可能带的同名字段。

### `setPowerRate`（L70–76）

遍历已有 HitVO 写 `powerRate`。之后 `addHitVO` 的新条目仍是默认 1，除非再次 set。开局 `attackRate` setter 在 defineAction 之后才调则没问题；中途 buff 改 `attackRate` 只刷当前表。
