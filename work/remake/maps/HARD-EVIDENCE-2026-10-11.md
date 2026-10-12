# HARD 地图空 floor 证据（G5 · 保真 SAME-HOLE 结案）

| 项 | 值 |
|----|----|
| 策略 | **保真 SAME-HOLE**（`HARD-SOFT-POLICY.md`；**不增强**） |
| 静态证据 | **PASS / 结案**（2026-10-11 21:53；复核 22:09） |
| 桌面进场×3 | **可选视觉确认**（挂 A2；**不挡** G5 Documented-gap / F 保真门） |
| main.swf | **未改** |

## HARD×3

| map_id | 洞形态 | FloorVO | 几何证据 |
|--------|--------|--------:|----------|
| `shihunjietongdao` | 根实例 **缺 floor** | 0 | `export/_meta/map/shihunjietongdao/geometry.json` → `holes.hard=["floor"]` |
| `jianchang` | `floor` 在、**empty sprite 0×0**、0 子 | 0 | 同目录 geometry；chid=21 |
| `zoulang` | 同上 | 0 | chid=24 |

机器可读：`HARD-EMPTY-FLOOR-EVIDENCE.json`。  
进场步骤（若要视觉）：`HARD-ENTRANCE-SMOKE.md` → parity §4 填 **SAME-HOLE**。

**结案口径**：计划默认「保真不增强」→ 静态洞证据 + 策略文档 = G5 Documented-gap **静态门关闭**；增强路径 N/A。
