# `fighter.ctrler.FighterVoiceCtrler` — 受击/击飞/死亡语音

一句话目的：三个槽（0 受击、1 击飞、2 死亡）各挂一组 Sound 类，播放时随机抽一个。同声道未播完则丢弃新请求。音量在构造时从 `GameData.config.soundVolume` 拍一次。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterVoiceCtrler.as`（71 行）

## Callers / callees

- **装配**：`FighterCtrler.initFighter` `new FighterVoiceCtrler()`。角色 SWF `defineHurtSound` / `defineHurtFlySound` / `defineDieSound` → `setVoice(0/1/2, rest)`。
- **播放**：仅 `FighterMcCtrler` 受击分支：
  - 活着且 `HitType.isHeavy`：`playVoice(0, 0.5)`（受击，50% 几率）
  - `hurtType==1` 击飞：活着 `playVoice(1, 1)`，已死 `playVoice(2, 1)`
  - 另有一处死亡再 `playVoice(2, 1)`（约 L1879）
- **常量**：`FighterVoice.HURT=0` / `HURT_FLY=1` / `DIE=2`。本类不 import，调用方写字面量。
- **Callees**：`KyoRandom.getRandomInArray`、`Sound.play`、`GameData.I.config.soundVolume`。

## 命名备注

- `destory`：原拼写。
- 槽位是 int 不是枚举；与 `FighterVoice` 常量对齐，但 SWF/McCtrler 都不引用该类。
- `_curLength` 单位与 `Sound.length` / `SoundChannel.position` 一样是**毫秒**。

## 逐行说明

### 字段 / 构造（L12–25）

- `_voiceObj`：`slot → Array of Class`（SWF 导出的 Sound 子类）。
- `_channel`：当前 `SoundChannel`。未播完用来挡下一次。
- `_curLength`：当前 Sound 的 `length`。
- `_soundTransform`：构造时 `volume = GameData.I.config.soundVolume`。**之后改设置音量不会刷新**已有 ctrler。?
- 构造只建 transform。

### `destory`（L27–38）

`_voiceObj=null`；有 channel 则 `stop`。不 destory transform。`FighterCtrler.destory` 调用。

### `setVoice`（L40–43）

`param1` 槽，`param2` 类数组。直接覆盖。`defineHurtSound(...rest)` 把 rest 当 Array 传入；卡卡西神威 `defineHurtSound()` 无参 → 空数组，该槽永远播不出。

### `playVoice`（L45–68）

`param1` 槽，`param2` 触发概率默认 1。

1. `_channel` 存在且 `position < _curLength` → return（截断保护：重击连打不会叠声）。channel 已自然播完则 position ≥ length，放行。
2. `Math.random() > param2` → return。0.5 大约一半受击出声。
3. 取数组：长度 >1 则 `KyoRandom.getRandomInArray`，否则 `[0]`。空/无槽 return。
4. `new Class()` 当 `Sound`，记下 `length`，`play(0, 0, _soundTransform)`。`play` 失败返回 null 时 `_channel` 变 null，下次不再被 step 1 挡住。?
