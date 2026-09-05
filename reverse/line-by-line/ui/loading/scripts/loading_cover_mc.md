# `(无名包).loading_cover_mc` — 启动封面加载屏

一句话目的：游戏启动第一张加载 UI。只有一条 [`loadingbar_mc`](./loadingbar_mc.md)：内层 `bar.bar.scaleX` 当进度，`bar.txt` 当文案。没有时间轴脚本。

源文件：`decompiled/ui/loading/scripts/loading_cover_mc.as`（17 行）

## 如何挂上引擎

[`GameLoadingState.build`](../../../engine/game/bvn/state/GameLoadingState.md) L31：

```
_ui = ResUtils.I.createDisplayObject(ResUtils.I.loading, "loading_cover_mc");
```

字段类型也是 `loading_cover_mc`。[`ResUtils.initalize`](../../../engine/game/bvn/utils/ResUtils.md) 成功后 `MainGame.initlize` 才 `goStage(GameLoadingState)`，再 `loadGame`。

引擎读写（不碰本类方法，全靠实例名）：

| 引擎位置 | 路径 | 作用 |
|----------|------|------|
| `loadPreloadProcess` | `_ui.bar.bar.scaleX = param1`（夹 ≤1） | ZIP 预载进度 |
| `loadAssetProcess` | 同上 `scaleX` | `loadBasic` 四步进度 |
| `msg` | `_ui.bar.txt.text = param1` | 「游戏初始化：…」 |

`bar` 类型见 [`loadingbar_mc`](./loadingbar_mc.md)（与战前加载条共用同一导出类）。本 MC 本身无 `addFrameScript`。

**不是** 选人后的 [`LoadingState`](../../../engine/game/bvn/state/LoadingState.md)（那张是 [`loading_fight_mc`](./loading_fight_mc.md)）。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(source="/_assets/assets.swf", symbol="symbol106")]`。loading.swf 内元件。
- **L6**：`public dynamic class loading_cover_mc extends MovieClip`。`dynamic` 让引擎用点语法摸子件。
- **L9**：`public var bar:loadingbar_mc;` —— 舞台实例名 `bar`，进度条 + 文案。
- **L11–14 构造**：`super()`。无 `addFrameScript`。时间轴若有封面图/循环动画，由 FLA 自己播，AS 不 `stop`。
