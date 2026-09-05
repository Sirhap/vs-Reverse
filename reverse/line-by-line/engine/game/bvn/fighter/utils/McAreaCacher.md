# `fighter.utils.McAreaCacher` — MC 判定框帧缓存

一句话目的：按 **帧号** 和 **子 DisplayObject 几何指纹** 两级缓存 hit/body 矩形，避免每帧对同一剪辑 `getBounds`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/utils/McAreaCacher.as`（76 行）

## Callers / callees

三处持有（本包角色时间轴不直接 new，引擎侧）：

| 持有者 | 实例 | 用途 |
|---|---|---|
| `FighterMC` | `_bodyAreaCache("body")`、`_hitAreaCache("hit")`、`_hitCheckAreaCache("hit_check")` | 身体 `bdmn`；攻击盒 `atm*`+HitVO；`getCheckHitRect(name)` |
| `FighterAttacker` | `hit` / `hit_check` | 攻击体当前帧 hit 数组 |
| `Assister` | `hit` / `hit_check` | 辅助当前帧 hit 数组 |

典型路径（`FighterMC.findBodyArea/findHitArea`）：

1. `areaFrameDefined(currentFrame)` 已定义则跳过。
2. 否则扫子件：`getAreaByDisplay` 命中指纹则复用；否则 `getBounds(fighterDisplay)` + `cacheAreaByDisplay`（hit 额外塞 `{hitVO}`）。
3. `cacheAreaByFrame(frame, obj或Array或null)`。

读取：`getCurrentBodyArea` → 帧缓存 `.area`；`getCurrentHitArea` → 帧缓存 Array。`destory`：`FighterMC` 三个都调；`Assister`/`FighterAttacker` 的 `hit` 与 `hit_check` 都调。

无其它 callees。纯缓存。

## 命名备注

- `destory`：原拼写。
- `name`：仅标签（`"body"`/`"hit"`/`"hit_check"`），不参与 key。
- `_idCache`：DisplayObject 指纹 → `{name, area, …extra}`。
- `_frameCache`：帧号 → 任意 Object（body 是单条 cache 对象；hit 是 Array；无盒时可能 undefined/null）。

## 逐行说明

### 字段 / 构造（L9–19）

两空 Object + `this.name = param1`。

### `destory`（L21–25）

两 cache 置 null。

### `areaFrameDefined`（L27–30）

`_frameCache[frame] !== undefined`。严格不等：缓存了 `null` 算已定义（空身体帧可跳过重扫）；赋 `undefined` 或不存在的键都算未定义。`findBodyArea` 在没有 `bdmn` 时 `cacheAreaByFrame(frame, undefined)`，下一帧仍会重扫（?）。

### `getAreaByFrame`（L32–35）

直接下标，没有则 `undefined`。

### `cacheAreaByFrame`（L37–40）

覆盖写。body：`{name, area}` 或 undefined。hit：`[{name, area, hitVO}, …]`，空则 `null`（`FighterMC` 把空数组改成 null 再写入）。

### `getAreaByDisplay`（L42–50）

指纹命中返回对象，否则 **显式 null**（不是 undefined）。

### `cacheAreaByDisplay`（L52–68）

`param1` DisplayObject，`param2` 矩形，`param3` 可选附加字段（hit 传 `{hitVO:HitVO}`）。

新建 `{name: display.name, area: rect}`，再把 extra 的键浅拷进来（`hitVO` 引用同一条登记 HitVO）。写入 `_idCache[fingerprint]` 并返回该对象。同一几何复用时，`findHitArea` 把同一对象推进当前帧数组。

### `getDisplayCacheId`（L70–73）

`name + "_" + x + "," + y + "," + width + "," + height + "," + rotation`。

同一实例换帧后只要本地 x/y/尺寸/旋转变了就是新 key。不同子件同名同几何会撞车（? 少见）。不含 `scaleX/scaleY`，只缩放不旋转可能误命中旧矩形。
