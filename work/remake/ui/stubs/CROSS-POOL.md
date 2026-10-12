# UI 交叉池符号（G11）— 实际在 loading

引擎 `createDisplayObject(pool, name)` 的 pool 参数与 SymbolClass 所在 SWF 不一致时，InsSwf 必须按**导出名所在 SWF**解析。下列 4 个符号的 home 是 **loading**（DefineBinaryData id=229），不是 fight/select。

| 引擎 pool 参数 | 符号 | 实际 home | charId | 调用方 |
|---------------|------|-----------|--------|--------|
| `fight` | `loading_fight_mc` | `loading` | 104 | `state/LoadingState.as` |
| `select` | `seltwzmc` | `loading` | 85 | `ui/select/SelectedFighterUI.as ×2` |
| `select` | `select_arrow_mc_1` | `loading` | 76 | `ui/select/SelectIndexUI.as` |
| `select` | `select_arrow_mc_2` | `loading` | 73 | `ui/select/SelectIndexUI.as` |

另：`GameLogic` 可能在 `winner_stg_mc` / `winner_stg_mc2` 间切换（二者均在 loading SymbolClass）。

重制规则：

- 占位/外置工程：符号放进 `stubs/loading/` 与 `bin_229`，**不要**放进 fight/select 包冒充。
- 引擎改写：可继续写 `ResUtils.I.select`/`fight` 作为 pool 参数（运行时靠名字解析），但文档与导出表必须标 home=loading。

权威：`work/full-analysis/ui/INDEX.md`。

未改 `main.swf`。
