# `FighterHitRange` — 角色库里「判定面」元件名

一句话目的：角色 SWF 里各招的攻击范围 MovieClip 实例名表。`FighterMC` 初始化时按 `getALL()` 把这些子 MC 藏起来并交给 `McAreaCacher` 当 hit 区。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterHitRange.as`（41 行）

## Callers / callees

- **Callers**：仅 `FighterMC`（约 L578）`for each (FighterHitRange.getALL())` 在主 MC 上 `getChildByName`。
- **Callees**：无。
- 角色时间轴 **不** import 本类；元件名写死在 FLA 库。

## 命名备注

后缀 `mian` = 面（判定面）。前缀是招式拼音缩写，与 `IFighterActionCtrl` / `HitVO.id` 的 bs/kj/zh 体系对应。

## 逐行说明

### 常量（L6–28）

| 常量 | 元件名 | 招 |
|------|--------|-----|
| `JUMP_ATTACK` | `tkanmian` | 跳轻击 |
| `JUMP_SKILL` | `tzmian` | 跳技能 |
| `ATTACK` | `kanmian` | 地面轻击 |
| `SKILL1` | `kj1mian` | 下+攻 |
| `SKILL2` | `kj2mian` | 上+攻 |
| `ZHAO1` | `zh1mian` | 技能 |
| `ZHAO2` | `zh2mian` | 下+技能 |
| `ZHAO3` | `zh3mian` | 上+技能 |
| `BISHA` | `bsmian` | 必杀 |
| `BISHA_AIR` | `kbsmian` | 空必 |
| `BISHA_UP` | `sbsmian` | 上必 |
| `BISHA_SUPER` | `cbsmian` | 超必（下+必） |

常量名本包无引用，只靠 `getALL()` 的字符串数组。

### 空构造（L30–33）

全静态。

### `getALL`（L35–38）

返回上面 12 个字符串的新 Array，顺序与常量声明一致。缺一个元件则 `getChildByName` 得 null，该招无独立范围 MC（? 仍可能用通用 hit 区）。
