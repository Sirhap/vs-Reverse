# `ConfigVO` — 玩家设置：键位、画质、音量、AI、HP、回合时限

一句话目的：运行时设置对象。`GameData.config` 持有一份；构造填默认键位，`applyConfig` 把画质字符串落到 Stage 质量 / 战斗 FPS / 闪光帧率 / 特效平滑，并把音量推给 `SoundCtrl`。存档只序列化战斗相关字段，不含菜单键和选人表。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/ConfigVO.as`（183 行）

## Callers / callees

- **Callers**：
  - `GameData`：字段 `config = new ConfigVO()`；`saveData` → `toSaveObj`；`loadData` → `readSaveObj`。
  - `MainGame.initlize`：`loadData` 之后立刻 `config.applyConfig()`，再 `GameInputer.updateConfig`。
  - `SettingState`：`setValueByKey` 改选项；APPLY 再 `saveData` + `applyConfig` + `GameInputer.updateConfig`。
  - `SetBtnGroup`：`getValueByKey(optionKey)` 把 UI 拨到当前值。
  - `SetCtrlBtnUI`：`setDefaultConfig(_tmpKeyConfig)` 重置正在编辑的键。
  - `GameInputer.initlize`：把 `key_menu` / `key_p1` / `key_p2` 灌进输入表。
  - `GameCtrl.addFighter`：`keyInputMode == 1` → `FighterKeyCtrl.classicMode`。
  - `GameLogic.addScore`：`keyInputMode == 0` 满分，否则 ×0.8。
  - `GameLogic.resetFighterHP` / `GameRunDataVO.reset`：读 `fighterHP`、`fightTime`。
  - `MessionModel.initMession`：把 `AI_level` 拷到 `MessionModel.AI_LEVEL`。
  - `GameState.addGameSprite*` / `ResUtils` / `FighterVoiceCtrler` / `GameUI`：读 `soundVolume`。
  - `MapMain`：`quality == "best"` 才开背景 Bitmap smoothing。
  - `bleachvsnaruto_2`：启动覆盖 `AI_level`/`quality`/`keyInputMode`，并拿本对象判断是否弹更新。
- **Callees**：`KeyConfigVO`、`SelectStageConfigVO`、`GameInterface.instance.getConfigExtend` / `applyConfig`、`KyoUtils.setValueByObject`、`MainGame.I.stage`、`GameConfig.setGameFps`、`EffectCtrl.EFFECT_SMOOTHING`、`SoundCtrl.setBgmVolumn` / `setSoundVolumn`。

## 命名备注

- `setBgmVolumn` / `setSoundVolumn`：volume 的原拼写，本文件照调。
- `key_menu` 的 `KeyConfigVO.id = 0`，P1=1，P2=2。
- `quality` 字符串与 `GameQuailty` 常量同文：`low`/`medium`/`high`/`higher`/`best`。设置 UI **没有** `higher` 档。
- `keyInputMode`：`0` NORMAL，`1` CLASSIC（默认）。
- `extendConfig`：网页壳 `GameInterfaceManager.getConfigExtend()` 返回 `null`。
- 不存 `key_menu`、`select_config`。

## 逐行说明

### 字段（L14–36）

- `key_menu` / `key_p1` / `key_p2`：`const` 三个 `KeyConfigVO`，构造后再 `setDefaultConfig`。菜单确认键单独一张表。
- `select_config`：选人网格。`GameData.loadConfig` 用 `select.xml` 填；`GameLogic.setGameMode` 可再换 `salect.xml`。
- `AI_level = 1`：设置里 1..6（VERY EASY→HELL）。街机真正喂给 AI 的是 `MessionModel.AI_LEVEL`，只在 `initMession` 从这里拷一次。
- `fighterHP = 1`：**倍率**不是血量。`GameLogic.resetFighterHP`：`1000 * fighterHP * 关卡 hpRate`。设置档 0.5/1/2/3/5。
- `fightTime = 60`：回合秒数。`GameRunDataVO.reset` 写成 `gameTimeMax`。练习模式随后被 `GameCtrl` 改成 `-1`。
- `quality = "medium"`。
- `soundVolume` / `bgmVolume = 0.7`。
- `keyInputMode = 1`：经典操作。
- `extendConfig:IExtendConfig`：平台扩展设置，可空。

### 构造（L38–45）

`extendConfig = GameInterface.instance.getConfigExtend()`（网页实现恒 `null`）。然后三个键位都走 `setDefaultConfig`。

### `setDefaultConfig`（L47–61）

`param1` = 要重置的 `KeyConfigVO`，按 `.id` 分支。`setKeys(up, down, left, right, attack, jump, dash, skill, superKill, beckons)`：

| id | 方向 | 攻击/跳/冲/技能/超杀/召唤 |
|----|------|--------------------------|
| 0 菜单 | WASD（87/83/65/68） | JKL UIO（74/75/76/85/73/79） |
| 1 P1 | 同上 WASD | 同上 JKL UIO |
| 2 P2 | 方向键 38/40/37/39 | 小键盘 1–6（97–102） |

菜单额外 `selects = [74,75,76,85,73,79]`：六个动作键都能当菜单确认。P1/P2 不改 `selects`；`KeyConfigVO.setKeys` 在 `selects` 仍空时写成 `[attack]`。

`SetCtrlBtnUI` 对正在编辑的临时 VO 调这个，等于恢复该 id 的出厂键。

### `toSaveObj`（L63–80）

新 `{}`：`key_p1`/`key_p2` 各自 `toSaveObj`，再抄 `AI_level`/`fighterHP`/`fightTime`/`quality`/`keyInputMode`/`soundVolume`/`bgmVolume`。有 `extendConfig` 才写 `extend_config`。

**不写** `key_menu`、`select_config`。菜单键每次启动都是默认 WASD+JKL。

### `readSaveObj`（L82–93）

`param1` = 存档里的 `config` 对象。

1. `key_p1.readSaveObj` / `key_p2.readSaveObj`。`param1.key_p1` 缺失时行为取决于 `KyoUtils.setValueByObject`（?）。
2. 同时有 `extend_config` 和 `extendConfig` 才转发。
3. `delete` 掉 `key_p1`/`key_p2`，避免下一步把 Object 写进 `const` 键位。
4. `KyoUtils.setValueByObject(this, param1)`：剩下的同名字段直接赋到本对象（含 `extend_config` 这个**不存在**的属性名，通常被忽略）。不 `delete extend_config`。

### `getValueByKey`（L95–113）

`param1` = 设置项 key（`SetBtn.optionKey`：`AI_level`/`keyInputMode`/`fighterHP`/`fightTime`/`soundVolume`/`bgmVolume`/`quality`）。本对象 `hasOwnProperty` 则返回该字段；否则尝试 `extendConfig[key]`，访问失败 `trace` 后 `null`。

### `setValueByKey`（L115–141）

`param1` 字段名，`param2` 新值。`SettingState.onOptionChange` 每拨一次就写。

本对象有该属性：赋值。若是 `bgmVolume`/`soundVolume` **立刻**推 `SoundCtrl`（预览音量，APPLY 前已生效）。其它字段只改内存，要等 APPLY 的 `applyConfig` 才落到 Stage/FPS。

无该属性且有 `extendConfig`：`extendConfig[key] = value`，失败 `trace`。

### `applyConfig`（L143–180）

把 `quality` 映射到运行参数。无 `default`，未知字符串整段跳过画质分支，仍会跑后面的接口和音量。

| quality | `stage.quality` | `FPS_GAME` | `FPS_SHINE_EFFECT` | `EFFECT_SMOOTHING` |
|---------|-----------------|------------|--------------------|--------------------|
| `low` | `"low"` | 30 | 15 | false |
| `medium` | **`"low"`**（不是 medium） | 60 | 30 | false |
| `high` | `"medium"` | 60 | 30 | false |
| `higher` | `"high"` | 60 | 30 | true |
| `best` | `"high"` | 60 | 60 | true |

`medium` 战斗已 60fps，但 Stage 质量仍 `low`：角色矢量锯齿换性能。`higher` 只在 `GameQuailty` / 本 switch 出现，设置菜单没有这一档。

然后 `GameInterface.instance.applyConfig(this)`（网页实现空函数）。最后无论画质如何都 `setBgmVolumn`/`setSoundVolumn`。
