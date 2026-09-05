# `EffectModel` — 特效图鉴单例：建表、烘焙位图、按 id/hitType 取 `EffectVO`

一句话目的：启动时把全部战斗特效登记成 `EffectVO` 并 `cacheBitmapData`。运行时 `EffectCtrl` / `EffectManager` 只通过 `getEffect` / `getHitEffect` / `getDefenseEffect` 取模板（命中特效还会被 `EffectManager` clone 一份改 shake）。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/EffectModel.as`（410 行）

## Callers / callees

- **Callers**：
  - `MainGame.initlize` 的 `loadGameBack`：配表 + `loadBasic`（含 `effect.swf`）完成之后 `EffectModel.I.initlize()`。必须在 `getEffect` 能取到 MC 之后，否则烘焙 NPE。
  - `EffectCtrl`：`getEffect(id)`（`doEffectById`、必杀/替身/爆气/鬼步/buff/钢体、`doSpecialEffect`、`doBuffEffect`）；`getDefenseEffect(hitType)`。
  - `EffectManager.getEffectVOByHitVO`：`getHitEffect(hitVO.hitType)`，没有则缓存 null。
- **Callees**：只 `new EffectVO(className, props)`。不直接碰 `AssetManager`（烘焙在 VO 里）。

无 `destory`。表和位图进程内常驻，切场不卸。

## 命名备注

- `initlize`：全工程拼写。
- `initSpeicalEffect`：special 的原拼写。
- `_effect`：id → `EffectVO` 的 Object。命中键 `hit_N`，防御键 `defense_N`。
- `HitType`：1 KAN、2 DA、3 DA_HEAVY、4 MAGIC、5 MAGIC_HEAVY、6 KAN_HEAVY、7 FIRE、8 ICE、9 ELECTRIC、10 STONE（**无特效**）、11 CATCH。
- 类名大小写混用；`hit_floor_heavy` 的符号是 `xg_hitfllor_heavy`（fllor 原拼写）。
- `slowDown` 字段本表全部未填。

## 公开 API

| 方法 | 作用 |
|------|------|
| `I` | 懒单例 |
| `initlize` | `initEffects` + `cacheEffects` |
| `getEffect(id)` | 按字符串 id |
| `getHitEffect(hitType)` | `_effect["hit_"+n]`，没有返回 `undefined` |
| `getDefenseEffect(hitType)` | 没有则回落 `defense_5` |

## 逐行说明

### 字段 / 构造 / `I`（L6–22）

`_i` 单例，`_effect` 在 `initEffects` 才 `{}`。空构造。`get I` 首次 `new`。

### `initlize`（L24–28）

先登记全部 VO，再逐条光栅化。只应调一次；再调会丢旧表、重新 `getEffect` 再画一遍（旧 BitmapData 不 dispose）。

### `initEffects`（L30–79）

`_effect = {}` 后写入通用 id，再五个 `init*`。

通用表（id → 符号 / 副作用）：

| id | className | 其它 |
|----|-----------|------|
| `bisha` | `XG_bs` | `snd_bs`，`blendMode=add`。必杀 |
| `bisha_super` | `XG_cbs` | `snd_cbs`，add。超必 |
| `dash` | `XG_rush` | `snd_dash_air` |
| `dash_air` | `XG_rush_air` | `snd_dash_air` |
| `jump` | `XG_jump` | `snd_jump` |
| `jump_air` | `XG_jump_air` | `snd_jump`，add |
| `touch_floor` | `XG_luodi` | `snd_luodi` |
| `hit_floor` | `XG_hitfloor` | `snd_hitfloor` |
| `hit_floor_low` | `xg_hitfloor_low` | `snd_hitfloor_low` |
| `hit_floor_heavy` | `xg_hitfllor_heavy` | `snd_hitfloor_heavy` |
| `hit_floor_yan` | `xg_hitfloor_yan` | `lighten`（落地烟，无声） |
| `hit_end` | `xg_hitover` | KO 收招火花 |
| `break_def` | `XG_mfdjx` | `snd_mfdjx`，add，**freeze 500ms**，shake `{x:6, time:400}`（注意是 `x` 不是 `pow`） |
| `fz_bleach` | `XG_fz_bleach_mc` | `snd_dash`。死神辅助出场 |
| `fz_naruto` | `XG_fz_naruto_mc` | `snd_fz`。火影辅助出场 |
| `replaceSp` | `XG_tishen` | `snd_fz`。替身 |
| `replaceSp2` | `XG_tishen2` | 无声第二段 |
| `explodeSp` | `XG_bsq` | `snd_baoqi1`。爆气起 |
| `explodeSp2` | `XG_baoqi` | `snd_baoqi`。爆气爆 |
| `ghost_step` | `XG_ghost_step` | `snd_ghost_step`，add |
| `kobg` | `kobg_effect_mc` | KO 背景。`FightUI` 走 `BGEffect("kobg")` |

`EffectCtrl.assisterEffect`：`comicType==1` → `fz_naruto`，否则 `fz_bleach`。

### `cacheEffects`（L81–87）

`for each` `_effect` 的每个 `EffectVO.cacheBitmapData()`。含 special/buff/steel/hit/defense。启动卡一下换运行时零 MC。

### `initHitEffect`（L89–197）

`addHitEffect(hitType, className, props)` → `_effect["hit_"+n]`。

轻击 freeze **50ms**、无 shine/shake；重击/属性 freeze **400ms** + 白闪 `alpha 0.2` + shake `{pow:6, time:400}`。`EffectManager` 会把 `pow` 抄到 `shake.y`。

| hitType | 名 | className | 要点 |
|---------|----|-----------|------|
| 11 | CATCH | `xg_catch_hit` | freeze 400，`snd_hit_cache`。无 add/旋转 |
| 1 | KAN | `XG_kan2` | `snd_kan1`，add，`randRotate`，freeze 50 |
| 6 | KAN_HEAVY | `XG_kanx2` | `snd_kan2`，重击套餐 + randRotate |
| 2 | DA | `XG_qdj` | `snd_hit2`，轻拳套餐 |
| 3 | DA_HEAVY | `XG_qdjx` | `snd_hit_heavy`，重击套餐 |
| 4 | MAGIC | `XG_mfdj` | `snd_hit2`，轻法套餐 |
| 5 | MAGIC_HEAVY | `XG_mfdjx` | `snd_mfdjx`，重击套餐 |
| 7 | FIRE | `XG_fire` | `snd_hit_fire`，`specialEffectId=fire_ing`，shine `0xFFFF67` |
| 8 | ICE | `XG_ice` | `snd_hit_ice`，`ice_ing`，shine `0xA3E5F5` |
| 9 | ELECTRIC | `XG_leidian` | `snd_hit_dian`，**hardlight**，`shock_ing`，shine `0x8288D2` |

无 `hit_10`（STONE）。`getHitEffect(10)` 返回 `undefined`，`EffectManager` 当无特效。

`specialEffectId` 在 `doEffectVO` 末尾对受击 `FighterMain` 再 `doSpecialEffect`，挂持续燃烧/冰冻/感电。

### `initDefenseEffect`（L199–304）

`addDefenseEffect` → `_effect["defense_"+n]`。全部 `followDirect=true`（火花朝向跟攻击者）。无 `randRotate`、无 `specialEffectId`（防住不挂 fire_ing）。

| type | className | 档 | 要点 |
|------|-----------|----|------|
| 1 | `XG_fykan` | 轻斩防 | `snd_fykan`，freeze 50 |
| 6 | `XG_fykanx` | 重斩防 | `snd_fykanx`，400，shine 白 `alpha 0.1` 且 shine 自带 `blendMode=screen`，shake pow 6 |
| 2 | `XG_fyq` | 轻拳防 | `snd_def`，50 |
| 3 | `XG_fyqx` | 重拳防 | `snd_defx`，400，白闪 0.1 |
| 4 | `XG_mffy` | 轻法防 | `snd_def`，50 |
| 5 | `XG_mffyx` | 重法防 | `snd_defx`，400，白闪 **0.15** |
| 7 | `XG_fire_fy` | 火防 | `snd_defx`，火色闪 0.2 |
| 8 | `XG_ice_fy` | 冰防 | 冰色闪 0.2 |
| 9 | `XG_dian_fy` | 电防 | 电色闪 0.2 |

无 `defense_11`（抓）。`getDefenseEffect` 未知类型回落 **defense_5**（重法防），不是 defense_1。

`EffectCtrl` 防御：角色 `defenseType==0` 用原始 hitType；`==1` 把斩系 1→2、6→3 再取（拳防角色看到斩击也播拳防火花）。

### `initSpeicalEffect`（L306–323）

持续状态，`isSpecial=true`，add 混合。`EffectManager` 做成 `SpecialEffectView`：跟随角色，并按 `targetColorOffset` 改 ColorTransform。动作回到 idle/21? 实际 View 里 state 0/23/24 播标签 `finish` 并 `resumeColor`。

| id | className | targetColorOffset |
|----|-----------|-------------------|
| `fire_ing` | `xg_fire_ing` | `[-255,-255,-255]` 全黑 |
| `ice_ing` | `xg_ice_ing` | `[0,0,255]` 加蓝 |
| `shock_ing` | `xg_dian_ing` | `[50,-75,255]` 偏蓝紫 |

这些 id 也是普通 `getEffect` 能取到的；由 hit 7/8/9 的 `specialEffectId` 触发。

### `initBuffEffect`（L325–342）

两组：

- `buff_effect_speed` / `_power` / `_defense`：一次性爆发，**没有** `isBuff`。`FighterBuffCtrler` 经 `doEffectById` 当普通 `EffectView`。
- `buff_speed` / `_power` / `_defense`：`isBuff=true` → `BuffEffectView`，跟随 buff 剩余时间。`doBuffEffect` 用。

全部 `blendMode=add`，无声。

### `initSteelHitEffect`（L344–379）

钢体受击火花。符号复用轻击那套（`XG_kan2`/`XG_qdj`/`XG_mfdj`），但：

- `isSteelHit=true` → `SteelHitEffect`
- 一律 freeze 400、白闪 0.2、`randRotate`、`snd_hit11`
- **没有** shake（钢体不震屏）

| id | 对应 hit |
|----|----------|
| `steel_hit_kan` | 斩 |
| `steel_hit_qdj` | 打 |
| `steel_hit_mfdj` | 法 |

`EffectCtrl.doSteelHitEffect` 按 hitType 选这三个 id 之一。

### `getEffect`（L381–384）

`return _effect[param1]`。未知 id → `undefined`。`doEffectById` 有 `if (_loc6_)` 护栏。

### `getHitEffect`（L386–389）

`_effect["hit_"+param1]`。10 或未登记 → `undefined`。

### `getDefenseEffect`（L391–395）

取出 `defense_N`，假值则 `defense_5`。`initlize` 前 `_effect` 仍 null 会 NPE（? 只应在启动后调）。

### `addHitEffect` / `addDefenseEffect`（L397–407）

`new EffectVO(className, props)` 写入对应前缀键。`param3` 默认 null，等于只有 className 的裸 VO。
