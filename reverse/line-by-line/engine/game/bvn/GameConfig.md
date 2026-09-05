# `GameConfig` — 物理、帧率、气槽/防御等战斗常量

一句话目的：全静态配置。重力、800×600、FPS、受击/防御/钢身帧窗口、能量与气槽公式、镜头速度。`SPEED_PLUS` 把 30fps 动画节奏换算到当前战斗帧率。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/GameConfig.as`（159 行）

## Callers / callees

- **Callers**：几乎整个引擎。高频：`BaseGameSprite`（重力/阻尼/SPEED_PLUS）、`GameCtrl` / `GameMainLogicCtrler` / `EffectCtrl`（动画间隔）、`FighterAction`（CD）、`ConfigVO.applyConfig`（`setGameFps` + `FPS_SHINE_EFFECT`）、`MainGame`（`GAME_SIZE`、`FPS_GAME`）、`MapMain`（`MAP_LOGO_STATE`）、`bleachvsnaruto`（`MAP_LOGO_STATE = 1`）。
- **Callees**：无（只依赖 `flash.geom.Point`）。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `SPEED_PLUS` | 当前时间倍率，默认 `30/FPS_GAME`。慢动作时 `GameCtrl.slow` 改它。 |
| `SPEED_PLUS_DEFAULT` | getter，不是字段。`setGameFps` 后重算。 |
| `MAP_LOGO_STATE` | `0` 隐藏地图 `logo4399`；壳写成 `1` 保留。 |
| `TOUCH_MODE` | 默认 false；本批未见写入。? 触屏菜单用。 |
| `G_ADD` | 与 `BaseGameSprite` 里写死的 `1.2 * SPEED_PLUS` 同值，但重力叠加处未必读这个常量。 |

## 逐行说明

### `TOUCH_MODE`（L8）

默认 false。本文件无 setter。? `MenuBtnGroup.touchHandler` 可能另判。

### 重力（L10–14）

| 常量 | 值 | 用途 |
|------|----|------|
| `G` | 12 | 基础重力（像素/逻辑帧量级，再乘 SPEED_PLUS） |
| `G_ADD` | 1.2 | 下落加速增量 |
| `G_ON_FLOOR` | 4 | 贴地时的残余重力/? 落地判定 |

具体乘算在 `BaseGameSprite.render`，不在本文件。

### 帧率（L16–22）

- `FPS_GAME`：**var**，默认 60。`setGameFps` 改它。`ConfigVO`：quality `low` → 30，其余 60。
- `FPS_UI` / `FPS_ANIMATE`：const 30。角色动画按 30fps 设计；战斗 60fps 时用 `ceil(FPS_GAME/30)-1` 隔帧播动画（`GameCtrl`、`EffectCtrl`）。
- `FPS_SHINE_EFFECT`：闪白特效目标帧率。low=15，medium/high/higher=30，best=60（`ConfigVO.applyConfig`）。0 时 `EffectCtrl` 会跳过 shine。

### `SHOW_HOW_TO_PLAY`（L24）

默认 true。`MenuBtnGroup` 街机入口为真则先 `goHowToPlay`。本文件不改。

### 子弹与跳跃（L26–32）

- `BULLET_HOLD_FRAME_PLUS = 2`：子弹 hold 再乘的系数。?
- `JUMP_DELAY_FRAME = 2` / `JUMP_DELAY_FRAME_AIR = 1`：起跳前摇（地面/空中）。
- `JUMP_DAMPING = 0.5`：起跳水平阻尼。

### 受击窗口（L34–40）

| 常量 | 值 | 含义 |
|------|----|------|
| `HURT_JUMP_FRAME` | 15 | 受击中可受身/跳起的帧窗 |
| `HURT_GAP_FRAME` | 4 | 受击判定间隙 |
| `BREAK_DEF_GAP_FRAME` | 4 | 破防后间隙 |
| `BREAK_DEF_DOWN_GAP_FRAME` | 10 | 破防倒地间隙 |
| `BREAK_DEF_HOLD_FRAME` | 42 | 破防硬直 |

### 防御（L43–55）

- `DEFENSE_GAP_FRAME = 4` / `DEFENSE_GAP_FRAME_DOWN = 8`
- `DEFENSE_DAMPING_X = 1`：防御时水平减速
- `DEFENSE_LOSE_HP_RATE = 0.05`：防住仍扣最大 HP 的 5%
- `DEFENSE_HOLD_FRAME_MIN/MAX = 5/10`：防御硬直随机区间
- `DEFENSE_HOLD_FRAME_DOWN = 10`：蹲防硬直

### 击飞与钢身（L57–75）

- `HURT_DAMPING_X/Y = 0.1 / 0.5`
- `HURT_Y_ADD_INAIR = 3` / `HURT_Y_ADD = 6`：受击上抛
- `STEEL_HURT_GAP_FRAME = 4` / `STEEL_HURT_DOWN_GAP_FRAME = 10`
- `STEEL_HURT_HP_PERCENT = 0.65`：钢身仍受伤比例
- `STEEL_SUPER_HURT_HP_PERCENT = 0.3`：超级钢身
- `HURT_FLY_DAMPING_X = 0` / `Y = 0.5`：击飞阻尼（X 不衰减）

### 落地弹起（L77–92）

- `HIT_FLOOR_DAMPING_X = 2` / `HEAVY = 4`
- `HIT_FLOOR_TAN_Y_MIN/MAX = 3/8`：弹起垂直速度夹紧
- `HIT_DOWN_FRAME = 15` / `HEAVY = 30`：倒地躺帧
- `HIT_DOWN_BY_HITY = 5`：按 hitY 决定倒地?
- `NO_TOUCH_BAN_ON_VECY = 5`：竖速度大于此不贴边?
- `HURT_FRAME_OFFSET`：**var** 默认 3，可被改

### 边距与倒地起身（L95–100）

- `X_SIDE_OFFSET = 10`：贴屏幕边偏移
- `HURT_DOWN_JUMP_FRAME = 20` / `HURT_DOWN_JUMP_DAMPING = 1`：倒地起跳

### 能量（L102–112）

- `USE_ENERGY_CD = 0.8` 秒量级 CD
- 每帧回复：`ENERGY_ADD_NORMAL=2`、防御中 `0.8`、攻击中 `1.1`
- 过载：每帧 `0.6`，恢复阈值 `ENERGY_ADD_OVER_LOAD_RESUME=30`

单位是「每逻辑帧加多少」，再经 SPEED_PLUS 缩放到当前 FPS。精确乘法在 fighter 包。

### 气槽 QI（L114–128）

打中别人加气（有上限），被打也加：

| 常量 | 值 |
|------|----|
| `QI_ADD_HIT_BISHA_RATE` | 0（必杀打中不加） |
| `QI_ADD_HIT_RATE` | 0.17 |
| `QI_ADD_HIT_BULLET_RATE` | 0.1 |
| `QI_ADD_HIT_ATTACKER_RATE` | 0.13 |
| `QI_ADD_HIT_ASSISTER_RATE` | 0.15 |
| `QI_ADD_HIT_MAX` | 15 |
| `QI_ADD_HURT_RATE` | 0.08 |
| `QI_ADD_HURT_MAX` | 20 |

### 辅助气 / 镜头 / HP / 地图 logo（L130–136）

- `FUZHU_QU_ADD_PERFRAME = 0.2`：辅助槽每帧（拼写 fuzhu=辅助，QU=? 气/槽）
- `CAMERA_TWEEN_SPD = 2.5`：`GameCamera` 跟随
- `FIGHTER_HP_MAX = 1000`
- `MAP_LOGO_STATE = 0`：壳改成 1 后 `MapMain` 保留实例名 `logo4399`

### `GAME_SIZE`（L138）

`Point(800,600)`。根 scrollRect、UI 居中、镜头 bounds 都读它。不要 `new` 替换（多处持有引用）。

### `SPEED_PLUS`（L140）

初始 `= SPEED_PLUS_DEFAULT`。注意初始化时 `FPS_GAME` 已是 60，故默认 `0.5`。`GameMainLogicCtrler.setSpeedPlus` 直接写这个 var；`GameCtrl.slow(n)` 把它改成 `DEFAULT/n`。

### 构造（L142–145）

空。类只当命名空间。

### `setGameFps`（L147–151）

写 `FPS_GAME`，并把 `SPEED_PLUS` 重置为新的 `30/FPS_GAME`。**会清掉**当前慢动作倍率——切画质时等于恢复常速。`MainGame.setFPS` 只改舞台帧率，不走这里。

### `SPEED_PLUS_DEFAULT` getter（L153–156）

`return 30 / FPS_GAME`。30 是动画设计帧率。60fps → 0.5，30fps → 1。位移/重力乘它后，墙钟时间近似不变。
