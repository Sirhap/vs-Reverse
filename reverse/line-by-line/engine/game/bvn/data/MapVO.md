# `MapVO` — 一张地图的 XML 元数据

一句话目的：地图 id/显示名、SWF 路径、选人预览图、BGM。`MapModel` 从 `map.xml` 建表；加载与选人 UI 只读这些字段。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/MapVO.as`（31 行）

## Callers / callees

- **Callers**：
  - `MapModel.initByXML`：`new` + `initByXML`。
  - `MapModel.getMap` / `getAllMaps`。
  - `GameLoader`：`fileUrl` 拉地图 SWF。
  - `LoadingState`：按 `GameData.I.selectMap` 取本 VO。
  - `MapMain.data`：运行时地图持有本 VO。
  - `AssetManager.getMapPic`：`picUrl`。
  - `MapSelectUI`：列表 + 预览图。
- **Callees**：`XML` 属性读取。

## 逐行说明

### 字段（L6–14）

| 字段 | XML | 用途 |
|------|-----|------|
| `id` | `@id` | `GameData.selectMap`、`MessionStageVO.map` |
| `name` | `@name` | 选人 UI 显示 |
| `fileUrl` | `file.@url` | 地图 SWF |
| `picUrl` | `img.@url` | 预览图 |
| `bgm` | `bgm.@url` | 进关 BGM |

### 构造（L16–19）

空。必须 `initByXML`。

### `initByXML`（L21–28）

五个属性直接转 String 赋字段。缺节点则空串，加载期会失败（? 无护栏）。
