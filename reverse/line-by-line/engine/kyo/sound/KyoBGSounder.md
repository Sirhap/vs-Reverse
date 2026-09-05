# `KyoBGSounder` — 循环 BGM 播放器

一句话目的：同一时刻一首 BGM，循环 `int.MAX_VALUE` 次。`SoundCtrl` **自己 `new`**，不用静态 `I`。

源文件：`decompiled/main/scripts/net/play5d/kyo/sound/KyoBGSounder.as`（144 行）

## Callers / callees

- **Callers**：仅 `SoundCtrl`：
  - `setBgmVolumn` / `BGM`：惰性 `new KyoBGSounder()` 赋给 `_bgSound`（**不是** `KyoBGSounder.I`）
  - `BGM(obj)`：同曲 return；否则 `stop` 再 `play`
  - `pauseBGM` / `resumeBGM` → `pause` / `resume`
  - `BGM(null)`（`unloadFightBGM`、`GameOverState`）→ 当前实现是 `if(param1)` 不 play，但 **先** `stop` 仅当 `playing`；`sound == null` 时 `if(_bgSound.sound == param1)` 可能已经 return。见下。
- **Callees**：`Sound` / `SoundChannel` / `SoundTransform` / `URLRequest`。
- **本包无调用**：`KyoBGSounder.I`、`toogle`。

## 命名备注

- `toogle`：toggle 的原拼写。
- `SoundCtrl.setBgmVolumn`：volume 的原拼写，在 SoundCtrl 侧。
- 每条公开方法都 `trace("bgm play|stop|pause|resume")`。

## 逐行说明

### 单例字段（L11–24）

- `_i`：`I` getter 懒创建。`SoundCtrl` 不用它，所以进程里可以同时存在 `I`（从未建）和 `SoundCtrl._bgSound` 两套。
- `sound`：当前曲目源（String URL / Class / Sound）。`SoundCtrl.BGM` 用引用相等判断「同一首」。
- `playing`：`play` 成功置 true，`stop` 置 false。`pause` **不**改它。
- `_snd`：真正的 `Sound` 实例。
- `_channel`：当前频道。
- `_soundTransform`：音量。默认 1。
- `_channelPausePosition`：`pause` 记下的毫秒位置。

### `I`（L30–34）

`_i = _i || new KyoBGSounder()`。本包零调用。

### `volume`（L36–48）

getter 读 transform。setter 写 transform，若 `_channel` 非空立刻套上。`SoundCtrl.setBgmVolumn` 在第一次 `BGM` 之前就会 `new` 并设音量，之后 `play` 用这份 transform。

### `play`（L50–81）

1. `trace("bgm play")`。
2. **`if(_snd) return`**：已经有 Sound 就拒绝换曲。`SoundCtrl.BGM` 换曲前会先 `stop()`（清 `_snd`），所以正常路径能进去。直接调 `play` 而不 `stop` 会哑火。
3. `param1` 空则用 `this.sound`。
4. 三者择一赋 `_snd`：
   - `String` → `new Sound(new URLRequest(...))`（流式，未等 COMPLETE）
   - `Class` → `new this.sound()`（SWC 嵌入）
   - `Sound` → 直接用（`SoundCtrl.playFightBGM` 走这条）
   三个 `if` 不 `else if`。一个对象几乎不会同时是三种，无害。
5. `playsnd()`：`_snd.play(0, int.MAX_VALUE, transform)`。`int.MAX_VALUE` 次循环 ≈ 无限。
6. `playing = true`。
7. 无源：`trace("没有可播放的音乐")`。

`SoundCtrl.BGM(null)`：先比 `sound == null`，若上一首已经是 null 则整函数 return，**不会 stop**。首次 `_bgSound.sound` 也是 null，第一次 `BGM(null)` 是空操作。真正停靠 `if(_bgSound.playing) stop()` 那条，要求 `playing` 仍 true。

### `stop`（L83–104）

`channel.stop()` 并 null。`_snd.close()`（流式 URL 才能 close；嵌入 Sound 会进 catch `trace("KyoBGSounder", e)`）。`_snd = null`，`playing = false`。**不**清 `this.sound`。所以 `SoundCtrl.BGM` 用 `sound == param1` 仍能识别「同一首」，下一句 `if(playing) stop` 已是 false，随后 `if(param1) play` 会再 play 同一首——但 `BGM` 在 `sound == param1` 处已经 return 了，不会重入。换曲时 `sound` 不同，先 stop 再 play。

### `pause`（L106–114）

记 `_channel.position`，`channel.stop()`。**保留 `_channel` 引用**（已停的频道对象）。不改 `playing`，不关 `_snd`。

### `resume`（L116–123）

`if(_channel)` 才从暂停点 `play(pausePos, int.MAX_VALUE, transform)`，换新频道。`pause` 后 `_channel` 仍非空，所以能恢复。`stop` 会把 `_channel` 置 null，之后 `resume` 空操作。

`SoundCtrl.resumeBGM` 若暂停期间来过新 `BGM`（记在 `_waitingSound`），会直接 `BGM(waiting)` 而不是 `resume()`。

### `toogle`（L125–135）

`playing` 则 `stop`，否则 `play()`（无参，用 `this.sound`）。本包零调用。

### `playsnd`（L137–140）

从 0 无限循环。不听 `SOUND_COMPLETE`（循环次数已是 max）。
