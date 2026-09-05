# `MapSelectUI` — Vs / 训练选地图层

一句话目的：选人向导最后一步的地图预览。左右切 `MapModel.getAllMaps()`（含 `random`），确认时若抽到 `id=="random"` 则重抽直到真实图，写入 `GameData.I.selectMap`。街机 / 生存不进本 UI。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/select/MapSelectUI.as`（219 行）

## Callers / callees

- **Callers**：只 `SelectFighterStage.initMap`（L833）`new MapSelectUI()`，`addChild` 到 `stg_select`。tween 完后 `addMouseEvents(mapPrevHandler, mapNextHandler, mapConfrimHandler)`，`inputType="P1"`，`enabled=true`。`render` 在 `enabled` 时用 `GameInputer.left/right/select(_mapSelectUI.inputType, 1)` 调 `prev/next/select`。`clear` / 舞台 `destory` 调本类 `destory`。
- **Callees**：
  - 符号：`ResUtils.I.select` → `"select_map_mc"` / `"select_map_txt_mc"`。
  - 数据：`MapModel.I.getAllMaps()`（内部数组，含 XML 第一项 `random`）、`MapVO`、`GameData.I.selectMap`。
  - 图：`AssetManager.I.getMapPic`（默认 450×240，`MapVO.picUrl`）。
  - 文案：`GameUI.SHOW_CN_TEXT` 才建底部 `BitmapText`；`UIUtils.formatText`。
  - 音：`SoundCtrl.I.sndSelect` / `sndConfrim`（仅鼠标路径；键盘音在 `SelectFighterStage.render`）。
  - 随机：`KyoRandom.getRandomInArray(_maps)`（不 splice）。
- **不经过本类**：`MessionModel.initMession` 直接灌 `selectMap`（街机 / 生存 `startAcradeGame`）。

## 命名备注

| 符号 | 含义 |
|---|---|
| `destory` | 全工程 destroy 拼写。 |
| `_confrimListener` / `mapConfrimHandler` / `sndConfrim` | confirm 拼写，全文保留。 |
| `inputType` | 本类只存，不读。舞台 `render` 拿它喂 `GameInputer`。默认 `undefined`，tween 完写成 `"P1"`。 |
| `enabled` | 默认 false。舞台键盘闸；本类 `mouseHandler` **不查** 此位。 |
| `_curId` | `_maps` 下标，不是地图 id 字符串。 |
| `_picCache` | `mapId → DisplayObject`。同一图多次 `showMap` 复用 Bitmap。 |
| `_mapmc.kuang` | 预览外框，点它 = 确认。 |
| `_mapmc.ct` | 预览容器；`build` 里 `ct.x -= 2` 像素微调。 |

SWF（`select` 嵌套 SWF，链接名）：

| 链接名 | 类 | 子件 |
|---|---|---|
| `select_map_mc` | 预览框 | `bg` / `ct` / `kuang` / `left_arrow` / `right_arrow` |
| `select_map_txt_mc` | 底部名条底图 | 无子件；`SHOW_CN_TEXT` 才实例化 |

## 逐行说明

### 包与 import（L1–17）

`net.play5d.game.bvn.ui.select`。继承 `Sprite`，本身就是显示对象（和 `SelecterItemUI` 不同，后者把 `ui` 当 MC）。GlowFilter 给中文名描边。

### 字段（L22–41）

- `enabled=false`：构造后不能键选，等舞台弹出动画。
- `inputType`：见上。
- `_mapmc` / `_txtmc` / `_txt`：主 MC、名条 MC、位图字。
- `_maps`：`getAllMaps()` 返回的**内部**数组（不是拷贝）。`map.xml` 顺序，`random` 通常第一项。
- `_curId`：当前下标。
- `_picCache={}`：按 `MapVO.id` 缓存预览 Bitmap。
- `_prevListener` / `_nextListener` / `_confrimListener`：鼠标回调，舞台灌 `mapPrev/Next/ConfrimHandler`。

### 构造（L44–47）

`super()` + `build()`。无参数。

### `addMouseEvents`（L50–64）

三箭头/框 `buttonMode=true`（手型）。记下三个 Function。`left_arrow` / `right_arrow` / `kuang` 各听 `"mouseOver"` + `"click"`，全部进 `mouseHandler`。

舞台只在 `initMap` tween `onComplete` 且 `_mapSelectUI` 仍在时调用。`TOUCH_MODE` **没有** 单独 `touchTap` —— 触摸设备若能发 click 才选图。?

### `mouseHandler`（L66–94）

- `"mouseOver"`：`sndSelect()` 后 **return**（不切图）。
- 其它（实际只有 `"click"`）：按 `currentTarget` 调 `_prevListener` / `_nextListener` / `_confrimListener`（空则跳过），然后 **一律** `sndConfrim()`。

因此左右键鼠标也会播确认音，不是 `sndSelect`。键盘左右在舞台播 `sndSelect`，确认播 `sndConfrim` —— 键鼠音色不一致。?

`mouseHandler` 不看 `enabled`。`select()` 把 `enabled=false` 后、`destory` 摘听之前，连点 `kuang` 会再次进 `select` / `onMapSelect`。?

键盘路径不经过本函数：舞台直接 `prev/next/select`，音在 `render` 播，故键鼠**不叠**两声。

### `build`（L96–120）

1. `createDisplayObject(ResUtils.I.select, "select_map_mc")`。
2. `_maps = MapModel.I.getAllMaps()`。空表则后面 `showMap(0)` 的 VO 为 `undefined`，`getPic` 会 NPE。正常 `map.xml` 至少有 `random`。
3. 水平居中：`x = (GAME_SIZE.x - _mapmc.bg.width) / 2`（800 宽）。竖直：`y = GAME_SIZE.y * 0.25`（150）。
4. `_mapmc.ct.x -= 2`。`addChild(_mapmc)`。
5. `GameUI.SHOW_CN_TEXT`（默认 true）：再取 `"select_map_txt_mc"`，水平居中，`y = GAME_SIZE.y - height - 35`。`BitmapText(true, 0xFFFFFF, [GlowFilter(0,1,3,3,3)])`，`UIUtils.formatText` 白 14 居中，宽度跟名条 MC，挂到 `_txtmc`。
6. `showMap(0)`：默认第一张（XML 里是随机图）。

本 `Sprite` 的 x/y 仍是 0。舞台 `initMap` 记 `oldX/oldY`（0,0），缩到 0 放到屏心再弹回 —— 弹的是整个 `MapSelectUI`，不是 `_mapmc`。

### `destory`（L122–151）

三 listener 置 null。若有 `_mapmc`：左右箭头和 `kuang` 摘 `"mouseOver"` / `"click"`。有 parent 则 `try removeChild(this)` 吞 Error。`_txt.destory()`。

**不**清 `_picCache`、**不** destory `_mapmc` / `_txtmc`、**不** `GameRender`（本类无 render）。Bitmap 靠 GC。舞台 `clear` 之后本对象应无引用。

### `select`（L153–169）

`_maps[_curId]` 空则整函数空过（不关 `enabled`、不回调）。

否则 `while (_loc2_.id == "random") _loc2_ = KyoRandom.getRandomInArray(_maps)`。`getRandomInArray` 第二参默认 false，不从数组摘除，可再次抽到 `random` 再循环。表里只有一项且是 random 会 **死循环**；现 `map.xml` 14 张真图 + 1 random，不会。抽到的仍可能是同一张真图。

`GameData.I.selectMap = _loc2_.id`（字符串，如 `"xianshi"`）。`enabled=false`。有 callback 则立刻调（舞台 `onMapSelect` → `nextStep` → `selectFinish`）。

**不**播动画、**不**摘鼠标。确认音已在调用方（键）或 `mouseHandler`（鼠）播过。

### `prev` / `next`（L171–189）

下标 −1 / +1，越界 wrap 到另一端。`showMap`。不播声音。

### `showMap`（L191–205）

记下 `_curId`。`getPic` 取预览。`_mapmc.ct.removeChildren()` 后若有图 `addChild`。有 `_txt` 则 `_txt.text = _loc2_.name`（XML `@name`，如「现世」「随机场景」）。

`param1` 越界 → `_maps[param1]` 为 `undefined`，随后 `getPic` / `.name` NPE。`prev/next` 已夹紧。

### `getPic`（L207–217）

缓存命中直接返回。否则 `AssetManager.I.getMapPic(param1)`（缺图 null），写入 `_picCache[id]`。`random` 的 `picUrl` 是 `assets/map/random.png`。

同一 `MapVO` 多次 get 得到**不同** Bitmap、同一份 BitmapData（见 `AssetManager.getMapPic`）。此处缓存的是第一次的那张 DisplayObject，`removeChildren` 再 `addChild` 同一实例。
