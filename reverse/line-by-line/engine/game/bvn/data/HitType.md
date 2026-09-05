# `HitType` — 打击类型枚举 + 是否「重击」

一句话目的：角色 SWF 的 `HitVO.hitType` 整型字典。引擎几乎不读常量名，只在受击时用 `isHeavy` 决定播受击飞语音。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/HitType.as`（41 行）

## Callers / callees

- **引擎调用**：仅 `FighterMcCtrler` 受击分支 `HitType.isHeavy(hitVO.hitType)` → 活着且重击则 `playVoice(0, 0.5)`（`FighterVoice.HURT`）。
- **数据来源**：各 `decompiled/fighters/*/scripts/*_fla/MainTimeline.as` 的 hit 表写数字 `1..11`，**不**引用本类常量名。
- **Callees**：无。`HitVO.isCatch` 写死 `hitType == 11`，不走本类。

## 命名备注

- `KAN` = 砍（剑类）；`DA` = 打（拳脚）；`MAGIC` = 法/气。
- `STONE=10` 不在 `heavyTypes` 里。
- `CATCH=11` 配合 `HitVO.isBreakDef` 才算抓（`HitVO.isCatch`）。

## 逐行说明

### 常量（L6–26）

| 值 | 名 | 典型用途 |
|----|----|----------|
| 1 | `KAN` | 轻砍 |
| 2 | `DA` | 轻打 |
| 3 | `DA_HEAVY` | 重打 |
| 4 | `MAGIC` | 轻法 |
| 5 | `MAGIC_HEAVY` | 重法 |
| 6 | `KAN_HEAVY` | 重砍 |
| 7 | `FIRE` | 火 |
| 8 | `ICE` | 冰 |
| 9 | `ELECTRIC` | 电 |
| 10 | `STONE` | 石化/? 不进 heavy |
| 11 | `CATCH` | 抓 |

默认 `HitVO.hitType = 1`。

### `heavyTypes`（L28）

`[6,3,5,7,8,9]`：重砍、重打、重法、火、冰、电。不含 1/2/4/10/11。

### 空构造（L30–33）

全静态。

### `isHeavy`（L35–38）

`heavyTypes.indexOf(param1) != -1`。未知值当轻击。
