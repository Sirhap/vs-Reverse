# random*×6 — XML-only（Phase C / G10）

| 项 | 值 |
|----|----|
| 产出日 | 2026-10-11 17:45 CST（UTC+8） |
| 条目 | `random` / `random_bleach` / `random_naruto` ×（fighter.xml + assist.xml）= **6** |
| SWF | **无**（设计如此，非缺失） |
| Face | `assets/face/random.png` 等 PNG 保留 |
| 运行时 | `SelectFighterStage`：`id.indexOf("random")` → 按 comicType 抽真实 id |

## 怎么修（保真）

1. **不要**造空 SWF 或假 fighter 文件。
2. 重制包继续带齐 6 条 XML + face PNG。
3. 选人三项 random 行为与原版一致即 DONE。

## DONE 勾选

- [x] 文档写明 XML-only / 无 SWF
- [ ] 桌面选人三项 random 冒烟（挂 parity 清单）

## Chinese summary

六个 random* 仅为选人占位 XML，运行时抽真实角色/辅助；禁止补空 SWF。未改 main.swf。
