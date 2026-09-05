# `KyoMath` — 角度 / 距离 / 范围

一句话目的：静态数学。本引擎只用 `asRadians` + `getPointByRadians` 转特效偏移。

源文件：`decompiled/main/scripts/net/play5d/kyo/utils/KyoMath.as`（104 行）

## Callers / callees

- **Callers**：仅 `EffectView` 渲染旋转帧（约 L186–187）：
  - `KyoMath.asRadians(_rotation)`
  - `KyoMath.getPointByRadians(new Point(offsetX, offsetY), radians)`
  把缓存帧的锚点绕原点旋到显示坐标。
- **Callees**：`flash.geom.Point`、`Math`。
- **本包无调用**：`fixRange` / `inRange` / `decimal` / `average` / `sum` / `getAngleByPoints` / `getDistanceByPoints` / `velocityFromAngle`。`KyoUtils.num_fixRange` 是另一份钳制。

## 逐行说明

### `DEGTORAD`（L7）

`Math.PI / 180`。类初始化算一次。

### 空构造（L10–13）

全静态。

### `fixRange`（L15–26）

钳到 `[min, max]`。不处理 min>max。无调用。

### `inRange`（L28–31）

闭区间。无调用。

### `decimal`（L33–38）

保留 `param2` 位小数。`param3` 默认 `Math.round`，也可传 `floor`/`ceil`。`pow(10,n)` 乘再除。无调用。

### `average` / `sum`（L40–57）

`rest[0] is Array` 则当数组，否则把 rest 当数组。`sum` 累加后 `average` 除以 `length`。空数组 `sum=0`，average 除零 → `NaN`。无调用。

### `getAngleByPoints`（L59–71）

从 `p1` 到 `p2`。`acos(dx/len)` 得 0..π，再 `180 / (PI / angle)` = `angle * 180 / PI` 成度数。`dy<0` 取负（上半平面）。重合点 `len=0` → `acos(NaN)`。返回 `int`。无调用。

### `getDistanceByPoints`（L73–78）

欧氏距离。无调用。

### `getPointByRadians`（L80–86）

把 `param1` 当向量，绕原点旋 `param2` 弧度。`param3` 默认 1，乘在 **sin 项的 y 分量** 上：

```
x' = x cos θ − y sin θ * s
y' = x sin θ + y cos θ * s
```

`s≠1` 时不是纯旋转（y 被非均匀缩放）。`EffectView` 不传第三参，s=1，标准旋转。用于把 `offsetX/offsetY` 随特效 `_rotation` 转。

### `asRadians`（L88–91）

度 × `DEGTORAD`。

### `velocityFromAngle`（L93–100）

`(angle, speed, isDegrees=true)`。cos/sin 后 **`int()` 截断** 成 Point。负分量向 0 截。无调用。
