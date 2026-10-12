# BVN 3.3 全量可读性终验（Phase 8）

| 项 | 值 |
|----|----|
| 样本 | `main.swf` SHA-256 `5ddf9410…ba3e` |
| 计划 | `FULL-ANALYSIS-PLAN-2026-10-11.md` |
| 不可读清单 | `inventory/UNREADABILITY-INVENTORY.md`（U1–U15 终态） |
| 终验时间 | 2026-10-11 14:42 CST（UTC+8） |
| 约束 | 未改 `main.swf`；分析落 `work/full-analysis/` |

## 结论

**静态「一切可读」目标达成**：U1–U15 均为 **Closed** 或 **Documented-Unreadable**（仅 runtime / 第三方 / 资产洞 / 完整 minify JS 图）。  
仍须**线上**运行时才能闭合的唯一壳项：**R8**（4399 Hold 实例指纹；本地 `hold=null` + stub 契约反射 PASS，见 `work/remake/engine/r8-evidence/LOCAL-HOLD-STUB-FINGERPRINT.json`）。

## Phase 勾选

| Phase | 状态 | 主证据 |
|-------|------|--------|
| 0 盘点 | DONE | `inventory/UNREADABILITY-INVENTORY.md` |
| 1 壳符号 | DONE（R8 Documented-Unreadable） | `shell/SHELL-SYMBOL-MAP.md`；`shell/PHASE1-PROGRESS.md`；line-by-line shell×32 |
| 2 主 SWF 资产 | DONE | `ASSET-CATALOG-MAIN.md`（9+8+3） |
| 3 ZIP222 | DONE | `ASSET-CATALOG-ZIP222.md`（407；XML 悬空 0） |
| 4 地图 | DONE | `assets/maps/`；`PHASE4-STATUS.md` |
| 5 时间轴 | DONE | `timelines/`；`PHASE5-STATUS.md`（标签 1725 / defineAction 1534） |
| 6 UI 符号 | DONE | `ui/INDEX.md` + 8 catalogs；SymbolClass Σ=73；交叉池 mismatch→loading |
| 7 引擎交叉 | DONE | `engine/LOAD-PATH.md`；`SOUND-CATALOG.md`；`PHASE7-STATUS.md` |
| 8 总验收 | DONE | 本文 + inventory 终验表 |

## 全局验收 5 条

1. **命名符号**：壳混淆在 MAP 有建议英文名；引擎保持 `net.play5d` 原名。✅  
2. **资产目录**：主 SWF 9 BinaryData + 8 Sound + 3 JPEG + ZIP 407 均有目录行。✅  
3. **证据路径**：结论指向 `decompiled/` / `extracted/` / `work/full-analysis/`。✅  
4. **不改原包**：只写分析目录与文档。✅  
5. **诚实缺口**：R8 / 第三方 / 地图 HARD·SOFT / effect 遗留 12 / `main.js` 完整图 → Documented-Unreadable + 原因。✅

## Documented-Unreadable 一览（不挡「可读」门）

| 项 | 为何静态止步 |
|----|----------------|
| R8 / U2 4399 Hold 实例 | 页面/容器注入；本地 hold=null；本地 stub PASS；线上 BLOCKED |
| U14 第三方库 | greensock / fzip / fl.motion / adobe.utils |
| U10 地图 HARD/SOFT | `shihunjietongdao` 缺 floor；6 图缺 front（资产洞） |
| U11 `random*`×6、~25 辅助无 FrameLabel | 运行时抽 id / Assister 常态 |
| U12 effect 遗留导出 12 | 未进 EffectModel，已列名 |
| U15 `main.js` 完整 minify 图 | 包装 API 已 Closed；全文语义非游戏逻辑 |
| R11 包名 Unicode | ABC 真名；MAP 给建议包名 |

## 中文总结

死神 vs 火影 3.3（`main.swf`）全量静态可读性分析已闭环：GreenHD 壳符号与引导链、引擎菜单→选人→对战加载路径、主 SWF 嵌入资产、ZIP 407 条目、14 地图几何、76 角色时间轴、特效交叉、8 个 UI 库符号均已落盘。唯一需线上才能补的是 4399 Hold 运行时指纹（R8）。未改游戏二进制。

## 证据速查

| 用途 | 路径 |
|------|------|
| 本终验 | `work/full-analysis/FULL-READABILITY-STATUS.md` |
| U1–U15 | `work/full-analysis/inventory/UNREADABILITY-INVENTORY.md` |
| 壳 MAP | `reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md` |
| UI | `work/full-analysis/ui/` |
| 引擎路径 | `work/full-analysis/engine/LOAD-PATH.md` |
