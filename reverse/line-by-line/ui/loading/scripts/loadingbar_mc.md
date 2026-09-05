# `(无名包).loadingbar_mc` — 共用进度条（条 + 文案）

一句话目的：一根可 `scaleX` 的内层 MC + 一行 `TextField`。封面加载和战前加载各嵌一份，导出类相同。

源文件：`decompiled/ui/loading/scripts/loadingbar_mc.as`（20 行）

## 如何挂上引擎

不单独 `createDisplayObject`。两处舞台实例：

| 父 MC | 实例名 | 引擎读写 |
|--------|--------|----------|
| [`loading_cover_mc`](./loading_cover_mc.md) | `bar` | [`GameLoadingState`](../../../engine/game/bvn/state/GameLoadingState.md)：`_ui.bar.bar.scaleX`、`_ui.bar.txt.text` |
| [`loading_select_ui_mc`](./loading_select_ui_mc.md) | `bar` | [`LoadingState`](../../../engine/game/bvn/state/LoadingState.md)：`_sltUI.bar.bar.scaleX`、`_sltUI.bar.txt.text` |

约定：

- 外层本类 = `_ui.bar` / `_sltUI.bar`
- 内层填充 MC 也叫 `bar` → `.bar.bar.scaleX`（0..1，引擎负责夹到 ≤1）
- `txt` 直接 `.text =` 整句，本类不拼进度数字（封面无「i/N」；战前 `updateMsg` 才拼）

无 `addFrameScript`。填充动画若有，是内层 `bar` 时间轴，不是本类。

## 逐行说明

- **L1–4**：无名包。`MovieClip` + `TextField`。
- **L6**：`[Embed(..., symbol="symbol98")]`。
- **L7**：`public dynamic class loadingbar_mc extends MovieClip`。
- **L10**：`public var bar:MovieClip;` —— 进度填充。引擎只改 `scaleX`，不 `gotoAndStop`。类型是裸 `MovieClip`（可能内嵌 [`元件8_17`](./loading_fla/元件8_17.md) 一类装饰，本 AS 不声明）。
- **L12**：`public var txt:TextField;` —— 动态文案。引擎当普通 `text` 写，不改 TextFormat。
- **L14–17 构造**：`super()`。无脚本。
