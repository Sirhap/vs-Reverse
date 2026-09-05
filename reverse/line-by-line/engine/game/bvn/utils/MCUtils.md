# `MCUtils` — MovieClip 帧标签与色相

一句话目的：查 MC 是否有某个 `FrameLabel`；以及用 `ColorMatrixFilter` 转色相。本包只用了前者。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/MCUtils.as`（58 行）

## Callers / callees

- **Callers（`hasFrameLabel`）**：
  - `FighterMC.checkFrame`（L259）：动作名对应时间轴标签不存在则记入 `_undefinedFrames` 并 `trace("未找到帧：")`。
  - `Bullet.renderAnimate`：标签 `"loop"` 时若有 `"loop_start"` 就循环到该帧（L294）；缺 `"timeout"` 则走另一分支（L364）。
- **Callers（`setHUE`）**：本包 **零调用**。方法仍编译进来。
- **Callees**：`MovieClip.currentLabels`、`ColorMatrixFilter`。

## 命名备注

`hasFrameLabel` 扫的是 **整段时间轴** 的 `currentLabels`，不是当前帧的 label。`setHUE` 的矩阵是 NTSC 亮度 0.213/0.715/0.072 的标准 hue rotate，角度单位度。

## 逐行说明

### 空构造（L11–14）

全静态。

### `hasFrameLabel`（L16–26）

`param1.currentLabels` 是 `FrameLabel[]`。任一 `.name == param2` 则 true。空数组 / 无匹配 → false。不 `gotoAndStop`，只查询。

`FighterMC` 用它避免对不存在的动作 `gotoAndPlay`；命中失败会缓存到 `_undefinedFrames`，之后不再扫。

### `setHUE`（L29–41）

`param2 == 0`：`filters = null`（清掉，不只是单位矩阵）。否则 `createHueFilter` 后 `filters = [_loc3_]`，**覆盖**原有滤镜数组。

### `createHueFilter`（L43–54）

`cos/sin(param1 * π / 180)`。矩阵一行写完，布局：

```
R'  [ 0.213+c*(1-0.213)+s*(0-0.213) , 0.715+c*(0-0.715)+s*(0-0.715) , 0.072+c*(0-0.072)+s*(1-0.072) , 0, 0 ]
G'  [ 0.213+c*(0-0.213)+s*0.143     , 0.715+c*(1-0.715)+s*0.14      , 0.072+c*(0-0.072)+s*-0.283     , 0, 0 ]
B'  [ 0.213+c*(0-0.213)+s*-0.787    , 0.715+c*(0-0.715)+s*0.715     , 0.072+c*(1-0.072)+s*0.072      , 0, 0 ]
A   [ 0, 0, 0, 1, 0 ]
```

G 行 `s*0.143` / `s*0.14` 与教科书 `0.143`/`0.140` 一致；B 行 `-0.787` 亦然。本包无调用，可能是给换色人物/调试留的。
