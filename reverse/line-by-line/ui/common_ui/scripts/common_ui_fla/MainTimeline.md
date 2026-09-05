# `common_ui_fla.MainTimeline` — common_ui SWF 文档类（F1 停）

一句话目的：`common_ui` 嵌套 SWF 的文档类。根时间轴两帧、30fps、舞台 800×600、底色黑；F1 `stop`。引擎从不 `new` 本类，只靠 `ResUtils` `loadBytes` 整份 SWF 把导出类灌进当前域。

源文件：`decompiled/ui/common_ui/scripts/common_ui_fla/MainTimeline.as`（19 行）

## 如何挂上引擎

[`ResUtils.I`](../../../../engine/game/bvn/utils/ResUtils.md) 字段 `common_ui` 对应 main.swf 里嵌入的 `common_ui_swf$a3bf7921…`（DefineBinaryData 225 → `extracted/full/swf/bin_225.swf`，CWS15）。`initalize` 对 8 个 UI SWF 全部 `Loader.loadBytes`，`LoaderContext` 并入 `ApplicationDomain.currentDomain`，所以后面 `createDisplayObject(common_ui, "logo_movie")` 这类按**链接名**取类，不必、也不会实例化文档类。

`InsSwf` 构造 `new common_ui_swf$…()` 后读 `movieClipData` 当 ByteArray；`loadBytes` 完成后 Loader 的 `content` 才是本 `MainTimeline`。引擎只留 domain 做 `getDefinition`，从不把这份 content 加到舞台。

本 SWF SymbolClass 导出（引擎真正 `new` 的是这些，不是本类）：

| char | 链接名 | 引擎入口 |
|------|--------|----------|
| 26 | `logo_movie` | [`LogoState`](../../../../engine/game/bvn/state/LogoState.md) |
| 25 | `mc_congratulations` | [`CongratulateState`](../../../../engine/game/bvn/state/CongratulateState.md)（`ResUtils.CONGRATULATIONS`） |
| 20 | `mc_win_all` | `CongratulateState.playComplete` |
| 14 | `mc_wzbtn` | [`MenuBtn`](../../../../engine/game/bvn/ui/MenuBtn.md) |
| 13 | `common_ui_fla.wzimg_bgimg_5` | 不单独 `createDisplayObject`，嵌在 `mc_wzbtn.bg` |
| 8 | `select_arrow_mc` | [`GameOverState`](../../../../engine/game/bvn/state/GameOverState.md) / [`SetBtnGroup`](../../../../engine/game/bvn/ui/SetBtnGroup.md) |
| 5 | `trans_mc` | [`TransUI`](../../../../engine/game/bvn/ui/TransUI.md) |
| 0 | `common_ui_fla.MainTimeline` | 文档类，引擎不 new |

`cover_bgimg` **不在**本 SWF。`CongratulateState` / [`CreditsState`](../../../../engine/game/bvn/state/CreditsState.md) 写 `createBitmapData(common_ui, "cover_bgimg", …)` 能成功，是因为 8 个 UI SWF 共用 `currentDomain`，类名实际落在 `loading` SWF。

ABC 调试路径：`E:\fb_workspace\play\死神VS火影_绊_assets\fla\ui\`。

## 逐行说明

无名包外的 FLA 文档包 `common_ui_fla`。`public dynamic class MainTimeline extends MovieClip`。无 `[Embed]`（它就是这份 SWF 自己）。无公开字段。

### `MainTimeline()`（L9–12）

- L11: `super();`
- L12: `addFrameScript(0, this.frame1);` — 0-based 下标 0 = 时间轴 **F1**。

根时间轴声明 2 帧、无场景标签。F1 停住后到不了 F2（F2 空）。

### `frame1`（时间轴 F1，L14–17）

- L16: `stop();` — 文档停在空白/黑底。即使 Loader 把 content 留在内存里也不会空转播。
