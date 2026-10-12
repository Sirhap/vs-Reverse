# effect 遗留 12 — Keep/Drop（Phase C / G9，衔接 B4）

| 项 | 值 |
|----|----|
| 产出日 | 2026-10-11 17:45 CST（UTC+8） |
| 源 | `timelines/effects/INDEX.md` Holes；`effect.swf` SymbolClass×89；`EffectModel`×52 |
| 默认策略 | **完美重制保真 = Keep 全部 89 导出**（含本 12） |
| EffectModel | 52 行 className 在 SWF 中 **0 缺符号**（已验证） |
| 约束 | **未改** `main.swf` / 未剔 effect.swf |

## Keep/Drop 表

| symbol | 类型 | 决策 | 证据 / 说明 | 精简包 |
|--------|------|------|-------------|--------|
| `XG_bdj` | MC | **Keep** | EffectModel 未登记；无引擎 AS 引用。保真导出保留 89 全符号，避免时间轴/旧 FLA 隐性依赖被误删。 | 仅精简包 + 全特效回归后可 Drop |
| `XG_fzbs` | MC | **Keep** | 辅助必杀类旧符号；引擎现用 XG_bs/XG_cbs。无 AS 引用，保真 Keep。 | 回归后可 Drop |
| `XG_ice2` | MC | **Keep** | 冰系变体；现网 EffectModel 用 XG_ice。保真 Keep。 | 回归后可 Drop |
| `XG_kan` | MC | **Keep** | 旧砍击；现用 `XG_kan2`（hit_1 / steel_hit_kan）。勿与 kan2 混淆删除。 | 确认无 SWF 内嵌引用后可 Drop |
| `XG_kanx` | MC | **Keep** | 旧砍击强；现用 `XG_kanx2`（hit_6）。保真 Keep。 | 回归后可 Drop |
| `XG_qdjx2` | MC | **Keep** | 拳/打击变体；现用 XG_qdj / XG_qdjx。保真 Keep。 | 回归后可 Drop |
| `XG_xdash` | MC | **Keep** | 旧冲刺特效；现用 XG_rush / XG_rush_air。保真 Keep。 | 回归后可 Drop |
| `snd_fzbs` | Sound | **Keep** | SymbolClass 导出音；EffectModel 无 sound 字段引用。可能曾配 XG_fzbs。保真 Keep。 | 精简包可 Drop（听感回归） |
| `snd_hit1` | Sound | **Keep** | 导出音 orphan；现 hit 链用 snd_kan1/snd_hit2/…。保真 Keep。 | 听感回归后可 Drop |
| `snd_hit10` | Sound | **Keep** | 导出音 orphan；非 EffectModel。保真 Keep。 | 听感回归后可 Drop |
| `snd_xdash` | Sound | **Keep** | 旧冲刺音；现 dash 用 snd_dash / snd_dash_air。保真 Keep。 | 听感回归后可 Drop |
| `xg_dian_ing2` | MC | **Keep** | 电击持续变体（自带 loop/finish 标签）；现用 `xg_dian_ing`（shock_ing）。保真 Keep。 | 状态特效回归后可 Drop |

## 相关非遗留项（一并冻结）

| 符号 / 项 | 决策 | 说明 |
|-----------|------|------|
| `xg_hitfllor_heavy` | **Keep（必留）** | EffectModel `hit_floor_heavy` 故意 typo；删名或改名会缺特效。可另加正确拼写双名兼容。 |
| `bisha_face_mc` | **Keep（运行时）** | 非 EffectModel；`BishaFaceEffectView` 运行时实例化。导出勿丢。 |
| EffectModel 52 className | **Keep** | 与 89 符号交集完整；重制包须 0 缺符号。 |

## 闭合条件（G9 DONE）

- [x] 12 项均有 Keep/Drop + 证据
- [x] 完美包路径：全部 **Keep**
- [ ] 若未来做精简包：按上表 slimDropOK 删后跑特效/听感回归，并更新本表为 Drop

## Chinese summary

遗留 12 个未进 EffectModel 的导出符号（7 MC + 4 snd + 1 电击变体）在完美重制路径全部 **Keep**；
另冻结 typo `xg_hitfllor_heavy` 与运行时 `bisha_face_mc`。精简删除仅允许在回归之后。未改 main.swf。
