# `MapModel` — 地图 XML 表（单例）

一句话目的：`map.xml` 解析成 `id → MapVO` 和有序列表。选地图 UI 走数组，加载/闯关走 id。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/MapModel.as`（51 行）

## Callers / callees

- **init**：`GameData.loadConfig` 在 `select.xml` 之后 `assets/config/map.xml` → `initByXML`。
- **读**：
  - `GameLoader` / `LoadingState`：`getMap(selectMap)`。
  - `MapSelectUI`：`getAllMaps()`。
  - `AssetManager`：预览图 URL。
- **Callees**：`MapVO.initByXML`。

## 逐行说明

### 单例（L6、L17–24）

懒 `_i`。`_mapObj` 按 id，`_mapArray` 保持 XML 顺序。

### `getMap`（L26–29）

`_mapObj[id]`。未知 id → undefined，随后 `fileUrl` NPE。

### `getAllMaps`（L31–34）

返回内部 Array（不是拷贝）。`MapSelectUI` 直接当下标列表。

### `initByXML`（L36–48）

`_mapObj={}`，`_mapArray=[]`。每个 `param1.map`：`new MapVO().initByXML`，同时写入字典和数组。重复 id 字典覆盖、数组仍重复。?
