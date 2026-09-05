# `fighter.models.HitVO` — 单次打击参数

一句话目的：一条攻击的伤害、类型、击退、硬直、破防/抓取标志；时间轴 `defineAction` 灌进来，命中时 `clone` 后挂 `currentArea` 参与检测。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/models/HitVO.as`（79 行）

## Callers / callees

- **创建**：`FighterHitModel.addHitVO`；`FighterMain` 爆气 `_explodeHitVO = new HitVO()` 手填 power/hitx/hitType/hurtType/currentArea。
- **clone**：`Bullet.setHitVO`、`FighterAttackerCtrler.fire`（改 `owner` 为子弹/Attacker）。`EffectManager.getEffectVOByHitVO` clone 的是 `EffectVO` 不是本类。
- **isBisha**：`FighterMain.hit`（必杀不加气）、`GameLogic.addScoreByHitTarget`（分×2）/`addScoreByKO`、`FighterMcCtrler.doSteelHurt`（破钢体）、`getLastHurtHitVO().isBisha`。
- **isCatch**：`doSteelHurt` 与必杀一起绕过普通钢体；防御里 `isBreakDef && hitType==11` 另走 `doHurt`（抓破防）。
- **getDamage**：扣血/`loseHp`、钢体耗能量、`FighterMain.currentHurtDamage` 累加。
- **hitType**：`EffectManager.getEffectVOByHitVO` → `EffectModel.getHitEffect(hitType)`。整型对应 `data.HitType` 常量。
- **currentArea**：`FighterCtrler`/`Assister`/`FighterAttacker`/`Bullet` 每帧写成世界矩形；`GameMainLogicCtrler` 用它做 hitTest。
- **checkDirect**：`FighterMcCtrler.beHit` 防御时，true 则 `checkDefDirect(owner)`——从背后打穿防御。

## 命名备注

保留字段原名：`hitx`/`hity`（击退）、`hurtTime`（硬直 ms）、`hurtType`（0 站硬直 / 1 击飞倒地）。`isBreakDef` 破防。`id` 来自 `defineAction` 第一参。

## `hitType` ↔ `HitType`

| 值 | 常量 | 备注 |
|---|---|---|
| 1 | `KAN` | 默认；砍。构造把 `hurtTime` 下限提到 100 |
| 2 | `DA` | 打 |
| 3 | `DA_HEAVY` | 重打；`HitType.isHeavy` |
| 4 | `MAGIC` | 忍术/鬼道 |
| 5 | `MAGIC_HEAVY` | 重法；爆气 HitVO 手写 5 |
| 6 | `KAN_HEAVY` | 重砍 |
| 7 | `FIRE` | 火 |
| 8 | `ICE` | 冰 |
| 9 | `ELECTRIC` | 雷 |
| 10 | `STONE` | 石化 |
| 11 | `CATCH` | 抓；`isCatch` 还要求 `isBreakDef` |

`isHeavy` 数组是 `[6,3,5,7,8,9]`（KAN_HEAVY/DA_HEAVY/MAGIC_HEAVY/FIRE/ICE/ELECTRIC），不含 STONE/CATCH。

时间轴例（`itachi MainTimeline`）：`"tk"` power 30 hitType 1；`"tz"` 120 / 6 / hurtType 1。部分招写 `checkDirect:false`（如鸣人）。

## 逐行说明

### 字段（L10–34）

- `id` / `owner`：登记时由 HitModel 写入。
- `power=0`、`powerRate=1`：最终伤害 `power*powerRate` 再转 int。
- `hitType=1`（KAN）、`isBreakDef=false`。
- `hitx/hity=0`：击退；调用方常再乘朝向。
- `hurtTime=300`、`hurtType=0`。
- `checkDirect=true`。
- `currentArea`：运行时矩形，defineAction 一般不带。
- `_cloneKey`：clone 白名单，含 `currentArea`（共享 Rectangle 引用，不是深拷）。

### 构造（L36–50）

`param1` 可选。有则 `KyoUtils.setValueByObject(this, obj)` 按同名 public 字段灌。然后若 `hitType==1` 且 `hurtTime<100`，抬到 100。其它 hitType 允许 0（例 `tz` hurtTime 0 + hurtType 1）。

### `clone`（L52–57）

空 `new HitVO()` 再 `KyoUtils.cloneValue(dst, this, _cloneKey)`。不走「hurtTime 下限」逻辑（字段已拷）。子弹/Attacker 随后改 `owner`。

### `isBisha`（L59–66）

`id==null` → false。否则 id 包含 `"bs"` **或** `"sbs"` **或** `"cbs"` **或** `"kbs"`。

`"bs"` 已是后三个的子串，后三项冗余。任意含 `bs` 的 id 都算必杀（`bs`/`bs1`/`sbs`/`cbs2`/`kbs`）。辅助 `sh1` 不含 bs，不是必杀；`GameLogic.addScoreByHitTarget` 对 `sh1/sh2` 另 +500。

### `isCatch`（L68–71）

`hitType==11 && isBreakDef`。只有「破防抓」走抓取逻辑；hitType 11 但不破防的不算 `isCatch`（? 时间轴里抓一般两字段一起开）。

### `getDamage`（L73–76）

`return power * powerRate`，类型 `int`，AS3 截断（非四舍五入）。`powerRate` 来自角色 `attackRate`。
