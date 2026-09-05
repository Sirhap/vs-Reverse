# `SoundCtrl` — BGM / 音效 / 菜单音

一句话目的：音频单例。预载资源音用 `AssetManager.getSound`；特效 SWF 里的 Sound 符号用 `getEffect`；主 SWF 内嵌 MP3 用 `playSwcSound`；循环 BGM 走 `KyoBGSounder`；对局再另装一套 `loadFightBGM`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/SoundCtrl.as`（265 行）

## Callers / callees

- **Callers**：
  - `ConfigVO.applyConfig`：`setBgmVolumn` / `setSoundVolumn`。
  - `bleachvsnaruto_2.activeHandler`：窗口 deactivate → `pauseBGM`，activate → `resumeBGM`（同时 `GameCtrl.pause`）。
  - 各 State 的 BGM：`MenuState("op")`、`SelectFighterStage("select")`、`LoadingState("loading")`、`SettingState`/`HowToPlayState`/`CreditsState("back")`、`GameOverState("continue")`、`CongratulateState("congratulation")`、`WinnerState` 先 `BGM(null)` 再 `playAssetSound("win")` 后 `BGM("winloop")`。
  - 菜单确认：`sndSelect` / `sndConfrim` —— `MenuBtn`/`SetBtn`/`SelectFighterStage`/`SelectIndexUIGroup`/`MapSelectUI`/`WinnerState`/`GameOverState`/`CongratulateState`/`SubmitScoreBtn`。
  - 其它 SWC：`MenuState` `snd_menu5`；`GameOverState` `snd_gameover`；`FightUI` `snd_ko`/`snd_ko_bs`/`snd_over_hit`；`EffectCtrl` `snd_ghost_jump`。
  - 战斗：`LoadingState` 队列 `loadFightBGM`；`GameStartCtrl.start1v1` / `GameCtrl` 练习模式 `playFightBGM`；`FighterEffectCtrl` `playAssetSoundRandom("step1","step2","step3")`；`EffectView` `playEffectSound(_data.sound)`。
- **Callees**：`AssetManager.getSound`/`getEffect`/`loadSound`、`KyoBGSounder`、`KyoSoundLoader`、`KyoRandom.getRandomInArray`、内嵌 `snd_menu1`/`snd_menu2`。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `Volumn` | volume 的原拼写（`setSoundVolumn`/`setBgmVolumn`） |
| `sndConfrim` | confirm 的原拼写 |
| `_bgSound` | 实例 `KyoBGSounder`（不用它的静态 `I`） |
| `_soundLoader` | **仅战斗 BGM**。预载 SFX 在 `AssetManager._soundLoader` |
| `_bgmObj` | `id → {id,url,rate}`。地图 id 固定 `"map"` |
| `rate` | `FighterVO.bgmRate` = XML `@rate/100`。`Math.random() > rate` 则改播地图曲 |
| `playAssetSound` | 预载库，key 可以是 `"select"` 这种基名 |
| `playEffectSound` | `getEffect` new 出来的 Sound 符号 |
| `playSwcSound` | 主文件 embed 的 Class，每次 `new` 再 `play` |

## 逐行说明

### 字段（L12–24）

- `_i`：单例。
- `_bgSound`：懒创建。只服务当前循环 BGM。
- `_soundLoader`：`loadFightBGM` 时 new，`unloadFightBGM` 卸。
- `_bgmObj`：战斗 BGM 元数据。
- `_bgmPaused`：与 `KyoBGSounder` 自身 playing 独立。暂停期间新的 `BGM()` 请求进 `_waitingSound`。
- `_waitingSound`：暂停时到来的下一首（Object：Sound/Class/String/null）。
- `_sndTransform`：SFX 音量。BGM 音量在 `_bgSound.volume`，两套分开。

### 构造 / `I`（L26–38）

懒单例。空构造。

### `setSoundVolumn`（L40–43）

只改 `_sndTransform.volume`。**已经在播的** SoundChannel 不会更新（`Sound.play` 时拷贝 transform）。下一声才用新音量。

### `setBgmVolumn`（L45–52）

懒 new `KyoBGSounder`，设 `volume`。`KyoBGSounder` 的 setter 会立刻写到当前 `_channel.soundTransform`，所以 BGM 边播边改音量有效。

### `playAssetSound`（L54–71）

`(name, volMul=1)`。`name==null` return。`AssetManager.I.getSound(name)` 找不到则静默。

音量：`volMul==1` 复用共享 `_sndTransform`；否则 `new SoundTransform(volMul * volume)`。`play(0, 0, transform)` —— 起点 0，循环 0 次（播一遍）。返回的 Channel 丢弃，无法 stop。

预载清单来自 `preload.xml`（`loadBasic` 第一段）。菜单 BGM 也走这条取值，但循环要再交给 `BGM(sound)`。

### `playEffectSound`（L73–90）

同构，但 `AssetManager.I.getEffect(name)`：从 effect.swf **new 一个 Sound 实例**。每次调用都 new，不缓存。`getEffect` 对 MC 类也会 `new`；若配置把 MC 名当 sound 会得到非 Sound，`.play` 运行时错。

`EffectView` 用 `EffectVO.sound` 字段当 name。

### `playAssetSoundRandom`（L92–96）

`...rest` → `KyoRandom.getRandomInArray(rest)` 抽一个字符串再 `playAssetSound`。数组空返回 null，`playAssetSound` 对 null 直接 return。脚步声三选一。

### `playSwcSound`（L98–102）

`new param1()` 必须是 `Sound` 子类。`play(0,0,_sndTransform)`。主 SWF embed：`snd_menu1`（选中）、`snd_menu2`（确认）等。不经 AssetManager，ZIP 与否都能响。

### `BGM`（L104–126）

参数是 `KyoBGSounder.play` 能吃的 Object：`Sound` / `Class` / URL `String` / `null`。

1. 若 `_bgmPaused`：记下 `_waitingSound = param1`，return。resume 时再播。**暂停中 `BGM(null)` 也会被推迟**，resume 可能把「停止」当成下一首（`if(param1)` 为假则只 stop 后的空 play 路径）。
2. 懒创建 `_bgSound`。
3. `_bgSound.sound == param1`：同一引用则跳过（不重头播）。换一首同 URL 但不同 Sound 实例会重播。
4. 正在播则 `stop()`（关 channel，`close` Sound；对共享的 AssetManager Sound `close` 可能让以后 `getSound` 再 play 失败 —— `?` 取决于 Flash 对已 load 的 Sound.close 行为）。
5. `param1` 真则 `play(param1)`（内部循环 `int.MAX_VALUE`）。

菜单切状态常 `BGM(AssetManager.I.getSound("op"))`。`HowToPlayState` destory、`SelectFighterStage` destory、`WinnerState` 开场会 `BGM(null)` 停曲。

### `pauseBGM`（L128–140）

已暂停则 return。`_bgmPaused=true`，有 `_bgSound` 则 `pause()`（记 position，停 channel，**不** close Sound）。

### `resumeBGM`（L142–159）

未暂停 return。清 `_bgmPaused`。若有 `_waitingSound`：立刻 `BGM(waiting)` 并清空等待，**不**走原来的 resume 位置（等于换曲或按等待项重来）。否则 `_bgSound.resume()` 从暂停点继续。

壳在浏览器失焦时 pause，回焦 resume。若失焦期间状态机调了 `BGM(新曲)`，回焦会播新曲而不是旧曲暂停点。

### `loadFightBGM`（L161–214）

选人后 `LoadingState` 把角色 `FighterVO.bgm` + 地图 `MapVO.bgm` 收成 `{id,url,rate}` 数组。

1. `_bgmObj = {}`，`urls=[]`。foreach 项：`_bgmObj[o.id]=o`，`urls.push(o.url)`。
2. **new** `KyoSoundLoader()` 赋给 `_soundLoader`（上一局若没 unload 会丢引用，旧 Sound 靠 GC）。
3. 顺序 `loadSound`：成功 `addSound(curUrl, sound)` 再下一首；失败 `trace("SoundCtrl.loadFightBGM fail!", url)` **继续**；进度闭包算了总进度 `_loc2_` 却调用 `process(param1)` —— **只上报当前文件 0–1**，总进度算了没用。`LoadingState` 条会在每首 BGM 内从 0 跳到 1。
4. 队列空 → `success()`。

不 `disposeAsset`。ZIP 里这些文件会留下。

### `playFightBGM`（L216–241）

`(id)`。`GameStartCtrl`：按 intro 队播 P1 或 P2 的 `data.id`；缺省播 **P2**。练习模式直接 `"map"`。

逻辑：

- id 是 `"map"`：没有 map 项就 return（保持当前 BGM）。
- 其它 id：没有该项 **或** `Math.random() > Number(rate)` → 递归 `playFightBGM("map")`。rate=1 时 `random > 1` 恒假，必播角色曲；rate=0 恒切地图。
- 取出 `_soundLoader.getSound(url)`（完整 URL key），`BGM(sound)`。Sound 空则 `BGM` 里 `if(param1)` 为假，等于停 BGM。

### `unloadFightBGM`（L243–251）

`BGM(null)` 停当前。`_soundLoader.unload()`（对每首 `close`）再 null。本包 **未见调用**。`GameCtrl.destory` 不卸战斗 BGM。下一局 `loadFightBGM` 会换新 loader，旧的若没 close 可能占通道。`?` 泄漏。

### `sndSelect`（L253–256）

`playSwcSound(snd_menu1)`。光标移动/悬停。

### `sndConfrim`（L258–261）

`playSwcSound(snd_menu2)`。确定。拼写 Confrim 与 `GameUI.confrim`、`ConfrimUI` 一致。
