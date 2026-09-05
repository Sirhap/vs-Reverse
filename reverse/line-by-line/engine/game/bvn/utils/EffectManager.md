# `EffectManager` — 受击特效对象池（不是 `EffectCtrl`）

一句话目的：按 `HitVO` 克隆一份 `EffectVO`、按 `EffectVO` 复用 `EffectView` / `ShineEffectView`。战斗导演是 `EffectCtrl`，本类只负责取实例。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/EffectManager.as`（135 行）

## Callers / callees

- **Callers**：仅 `EffectCtrl`。`initlize` 里 `new EffectManager()`（L143）；`destory` 转调本类 `destory`（L124）；`doHitEffect` → `getEffectVOByHitVO`（L321）；`addEffect` → `getEffectView`（L500）；`shine` → `getShine`（L585）。
- **Callees**：`EffectModel.I.getHitEffect`、`EffectVO.clone`；视图 `SpecialEffectView` / `BuffEffectView` / `SteelHitEffect` / `EffectView` / `ShineEffectView`。

## 命名备注

保留 `destory`（全工程销毁方法都这么拼）。**不要**和 `EffectCtrl` 搞混：

| | `EffectManager` | `EffectCtrl` |
|--|-----------------|--------------|
| 角色 | 池 + HitVO→VO | 战斗单例导演 |
| 生命周期 | 一场 `initlize`/`destory` | 静态 `I` |
| 做什么 | new/reuse 视图 | 挂层、顿帧、震动、闪光次数上限 |

`_viewCache` 的 key 是 **EffectVO 对象引用**（`Dictionary`），不是 `className`。`getEffectVOByHitVO` 每次 clone 新 VO，因此每种 HitVO 实例对应一条独立池。

## 逐行说明

### 字段（L17–20）

- `_viewCache: Dictionary`：`EffectVO → Vector.<EffectView>`。
- `_hitCache: Dictionary`：`HitVO → EffectVO|null`。同一 `HitVO` 实例只解析一次。
- `_shineCache: Vector.<ShineEffectView>`：闪光层池，不按 VO 分组。

### 空构造（L22–25）

字段已在声明处 new。

### `destory`（L27–43）

双重 `for each` 调每个 `EffectView.destory`，再清 `_shineCache`。然后三缓存置 null。由 `EffectCtrl.destory` 在离开战斗时调用。拼写 `destory` 保持原样。

### `getEffectVOByHitVO`（L45–71）

1. `_hitCache[param1] != undefined` 则直接返回（含缓存过的 `null`）。
2. `EffectModel.I.getHitEffect(param1.hitType)` → 表键 `"hit_" + hitType`。没有则缓存 `null` 并 return，避免每次 miss 都查表。
3. **clone**：后面改 `shake` 不能写回 `EffectModel` 的原型。
4. 若有 `shake`：
   - `shake.pow` 有定义且 ≠0 → 拷到 `shake.y`（纵向震，pow 当幅度）。
   - `x==0 && y==0` → `x = 3`（给一个默认横震，避免「有 shake 对象但幅度全 0」）。
5. 写入 `_hitCache` 并返回克隆。

### `getEffectView`（L73–114）

1. 取 `_viewCache[param1]`。有则扫 `isActive==false` 的槽直接 reuse（`EffectView.remove` 会把 `isActive` 置 false）。
2. 没有 Vector 则新建并挂到 Dictionary。
3. 按 VO 标志 new 子类（互斥顺序）：
   - `isSpecial` → `SpecialEffectView`
   - `isBuff` → `BuffEffectView`（`EffectCtrl.doBuffEffect` 走这里）
   - `isSteelHit` → `SteelHitEffect`
   - 否则普通 `EffectView`
4. `push` 进池后返回。**不**在这里 `start`/addChild，那是 `EffectCtrl.addEffect`。

池只增不缩，一场战斗特效种类×并发峰值会留在内存直到 `destory`。

### `getShine`（L116–131）

同样扫 `_shineCache` 找 `!isActive`。没有则 `new ShineEffectView()` 并 push。`EffectCtrl.shine` 随后 `init(color, alpha)` 并受 `shineMaxCount`（默认 3）限制。
