# `GameStartCtrl` — 开场 intro / 下一回合 FIGHT

一句话目的：1v1 开场（镜头、台词、BGM、START UI）或下一回合倒计时；`render` 返回 true 后 `GameCtrl` 才 `actionEnable=true` 并允许掉血。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/GameStartCtrl.as`（204 行）

## Callers / callees

- **Callers**：只 `GameCtrl`。
  - `buildGame`（非练习）→ `new GameStartCtrl(gameState).start1v1(p1,p2)`（intro=-1）。
  - `doBuildNextRound(true)` 组队 → `start1v1(..., introTeamId=败方)`。
  - `doBuildNextRound(false)` 单挑下一局 → `startNextRound()`。
  - 每帧 `_startCtrl.render()`；`renderPause` 把 back/MENU 转 `skip()`。
- **Callees**：`SoundCtrl.playFightBGM`、`GameState.cameraFocusOne/cameraResume/updateNow/gameUI`、`StateCtrl.transOut/quickTrans`、`FighterMain.sayIntro/idle`、`GameConfig.FPS_GAME`。

## 命名备注

- `destory`：原拼写。无 `initlize`，状态靠 `start1v1`/`startNextRound`。
- `_introTeamId`：`-1` 双方 intro；`1` 只 P1；`2` 只 P2。组队下一回合传**败方/换人方**。
- `actionState==60` = `FighterActionState.KAI_CHANG`（`sayIntro` 所置）。
- `skip` 的 next-round 分支是空体，下一回合 FIGHT UI **不能**跳过。

## 逐行说明

### 字段 / 构造（L12–34）

`_state` 即 `GameState`。`_p1/_p2`。`_isStart1v1` / `_isStartNextRound` 互斥模式位（只置 true，结束靠 `GameCtrl` destory 实例）。`_step`、`_holdFrame`、`_uiPlaying`。`_introTeamId` 默认 -1。构造只存 `_state`。

### `destory`（L36–41）

null `_p1/_p2/_state`。

### `render`（L43–54）

优先 1v1，否则 next-round，都不是则 false（`GameCtrl` 会一直 `actionEnable=false`；正常路径总会调两个 start 之一）。

### `start1v1`（L56–74）

存双方，`_isStart1v1=true`，`_introTeamId=param3`。

BGM（`param3-1` switch）：

- `param3==1`：P1 角色 id。
- `param3==2`：P2。
- **default（含 -1 开局）**：也播 **P2**。

组队换人时 intro 焦点是败方，BGM 跟败方走。然后 `preRenderStart()`。

### `preRenderStart`（L76–98）

`_step=-1`（等 transOut）。`switch(_introTeamId - -1)` 即 `intro+1`：

| intro | case | 立即镜头 | `initStep` |
| --- | --- | --- | --- |
| -1 | 0 | 无 | 0（完整双方 intro） |
| 1 | 2 | 对 P1 `cameraFocusOne` | 1（直接 P1 台词） |
| 2 | 3 | 对 P2 | 2（跳过 P1） |

`camera.updateNow()`。`StateCtrl.transOut(cb, true)`，cb 把 `_step=initStep`。`true` = 快切。转场结束前 `renderStart1v1` 因 `_step` 无匹配只空转（且 `_holdFrame` 默认 0）。

### `renderStart1v1`（L100–165）

闸：`_uiPlaying` → false；任一方 `actionState==60`（台词中）→ false；`_holdFrame-- > 0` → false。

- **case 0**：intro 是 -1 或 1 → 镜头 P1，hold `0.5s`，去 1；否则跳 2（只给 P2 intro 时）。
- **case 1**：`_p1.sayIntro()`（置 60），hold `0.3s`，去 2。真正台词时长靠上面的 `actionState==60` 闸，0.3s 只是台词**开始后**的余量。
- **case 2**：intro 是 -1 或 2 → 镜头 P2，hold 0.5s，去 3；否则跳 4。
- **case 3**：`_p2.sayIntro()`，hold 0.3s，去 4。
- **case 4**：`cameraResume()`，hold 0.1s，去 5。
- **case 5**：`_uiPlaying=true`，`showStart(cb)`（FIGHT），cb 清 `_uiPlaying`。`_step=6`。UI 播完前每帧被 `_uiPlaying` 卡住。
- **case 6**：null 双方，**return true** → `GameCtrl` 开操作。

### `startNextRound`（L167–176）

`_isStartNextRound=true`，`_uiPlaying=true`。`transOut(null,true)`（无回调）。立刻 `showStart(cb)` 清 `_uiPlaying`。无镜头、无台词、不碰 `_step`。

### `skip`（L178–197）

- **1v1 且 `_step<5`**（尚未 showStart）：`quickTrans`、`cameraResume`、`_uiPlaying=false`、`_step=6`、`fadIn(true)`、双方 `idle()`、hold `0.5s`。下一有效帧走 case 6 结束。不补 `showStart`。
- `_step>=5`（FIGHT UI 已上）不跳。
- **next-round**：空 `if`，不能 skip。

### `renderNextRound`（L199–202）

`_uiPlaying==false` 即 true。`showStart` 播完就结束，无额外 hold。
