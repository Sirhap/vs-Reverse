# `(无名包).cover_bgimg` — 封面底图 BitmapData 804×604

一句话目的：loading.swf 导出的封面 PNG `BitmapData`。祝贺页 / 制作组页当全屏底图用。本批只在 loading 里见到导出类；引擎却向 `common_ui` 按名取。

源文件：`decompiled/ui/loading/scripts/cover_bgimg.as`（15 行）

## 如何挂上引擎

[`ResUtils.createBitmapData`](../../../engine/game/bvn/utils/ResUtils.md) → `new Cls(width, height)`。调用方：

| 状态 | 调用 | 尺寸 |
|------|------|------|
| [`CongratulateState.build`](../../../engine/game/bvn/state/CongratulateState.md) | `createBitmapData(ResUtils.I.common_ui, "cover_bgimg", GAME_SIZE.x, GAME_SIZE.y)` | 800×600，再 `new Bitmap`，`alpha = -1`（夹成 0） |
| [`CreditsState.build`](../../../engine/game/bvn/state/CreditsState.md) | 同上 `common_ui` + `"cover_bgimg"` + `GAME_SIZE` | 800×600，不透明 |

[`GameConfig.GAME_SIZE`](../../../engine/game/bvn/GameConfig.md) 是 `Point(800, 600)`。

**库名对不上**：反编译落在 `ui/loading/`（`loading_swf` 链接名 `cover_bgimg`），引擎第一参却写 `ResUtils.I.common_ui`。本批 `decompiled/ui/common_ui/` **没有** 这个类。能用是因为 8 个 UI SWF 都 `loadBytes` 进 `ApplicationDomain.currentDomain`，`getItemClass` 的 `InsSwf.getClass` 是 `_domain.getDefinition(name)`——第一参只要是池里任意已 load 的 SWF，链接名在当前域即可。`cover_bgimg` 由 loading.swf 登记进当前域后，经 `common_ui` 那条 `InsSwf` 也能 `getDefinition`。

默认构造 804×604，引擎传入 800×600，实际 `BitmapData` 是 800×600（PNG 多出的 4px 边被裁掉）。

## 逐行说明

- **L1–3**：无名包。`import flash.display.BitmapData`。
- **L5**：`[Embed(source="/_assets/105_cover_bgimg.png")]`。FFDec 从 DefineBits 抽的 PNG，不是 SWF 元件。
- **L6**：`public dynamic class cover_bgimg extends BitmapData`。导出链接名 = 类名。
- **L9–12 构造** `(param1:int = 804, param2:int = 604)`：`super(param1, param2)`。无参时画布 804×604（嵌入图原始尺寸）。引擎两条路径都显式传 800、600。无其它逻辑、无 `draw`。
