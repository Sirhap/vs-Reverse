# Phase 1 进度（2026-10-11，续修）

## 本批完成（初轮）

1. 盘点不可读性 → `work/full-analysis/inventory/UNREADABILITY-INVENTORY.md`
2. 总计划 → `/workspace/bvn-3.3/FULL-ANALYSIS-PLAN-2026-10-11.md`
3. 扩展 `SHELL-SYMBOL-MAP`：`com.sh` / `Ȇ` / `LOADING_*` / `Ǻ` 冷路径 / **UNRESOLVED** 表
4. 新增 line-by-line 7 篇（原先 shell-files 外的 callee）
5. `shell-files.txt` 扩至 32 条

## 续修（同日，缩 UNRESOLVED R1–R11）

权威图：`reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md`（已同步 `work/full-analysis/shell/SHELL-SYMBOL-MAP.md`）。未改 `main.swf`。

| ID | 结果 | 摘要 |
|----|------|------|
| R1 | **RESOLVED-reconstructed** | `latency` HH:MM 分支：FFDec 把 `split(":")` 的 `_loc5_` 错写成 `_loc4_`；意图右→左 60^n×1000。本包 Number 死路径。 |
| R2 | Closed-as-dead | 不变 |
| R3 | Closed-as-dead | 不变 |
| R4 | Closed-unused | 不变 |
| R5 | **RESOLVED** | `ʔ`/`addCallback` 失败返回捕获的 `e`；`§--UNKNOWN--§`=异常逃逸类型洞 |
| R6 | Closed-unused | 不变 |
| R7 | Documented | 不变 |
| R8 | **REMAINING-runtime** | 静态 Hold API 契约已写入 MAP；线上实例指纹需 4399 运行时 |
| R9 | **RESOLVED-static** | 壳 EI 一阶 call 名全表（`console.g`/`eval`/`close`/域名 IIFE/…） |
| R10 | **Documented-stub** | `script_105`…`165` → SymbolClass tag 225–229/2210/2211/2215 |
| R11 | Documented | 不变 |

## 仍开着的（壳 Phase1）

| ID | 项 | 为何静态止步 |
|----|-----|-------------|
| R8 | 4399 Hold 运行时指纹 | Hold 由页面注入；本地 `hold=null` |

## 下一步

- R8：可选 4399 页运行捕获（非本 Phase1 静态范围；Phase 8 标 Documented-Unreadable）
- 静态 Phase1：**完成**（其余 Phase 2–8 已在同日闭环）
