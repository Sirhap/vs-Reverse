# `BitmapDataCacheVO` — 特效一帧的位图 + 锚点

一句话目的：把 MovieClip 某一帧光栅化后的 `BitmapData` 和绘制偏移存成一条。`EffectVO` 预烘焙整段动画，`EffectView` 按帧取出贴到场景。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/BitmapDataCacheVO.as`（20 行）

## Callers / callees

- **Callers**：
  - `EffectVO`：`bitmapDataCache:Vector.<BitmapDataCacheVO>`；烘焙循环 `new BitmapDataCacheVO()`，写 `bitmapData` / `offsetX` / `offsetY`。
  - `EffectView`：持有同一 Vector，当前帧 `_bitmapDatas[_curFrame]` 画到 Bitmap。
- **Callees**：`flash.display.BitmapData`（类型）。纯数据，无方法。

## 命名备注

无拼写问题。不是通用贴图缓存（那是 `BitmapAssetLoader`），只服务特效 MC 光栅化。

## 逐行说明

### 字段（L8–12）

- `bitmapData`：该帧光栅。`EffectVO` 用 MC 的 `getBounds` 建 BitmapData 再 `draw`。
- `offsetX` / `offsetY`：默认 0。烘焙时写成包围盒左上相对注册点的偏移，播放时 Bitmap 要减回去才能对齐原 MC。

### 构造（L14–17）

空 `super()`。调用方 `new` 后直接写字段。
