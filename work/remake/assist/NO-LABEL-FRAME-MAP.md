# 无 FrameLabel 辅助 ×22 — 帧号驱动表（Phase C / G6）

| 项 | 值 |
|----|----|
| 产出日 | 2026-10-11 17:45 CST（UTC+8） |
| 名单 | G6 / `REMAKE-GAP-INVENTORY` primary labels=0 |
| 源 | `decompiled/fighters/fz/<id>/scripts/*_fla/MainTimeline.as` `addFrameScript` |
| 引擎 | `Assister.goFight()` → `_mainMc.gotoAndStop`/`Play`(2)；帧1=`stop` 待机；播完 `totalFrames-1` → `AssisiterCtrler.finish` |
| 可选 | 重制补 FrameLabel 须同步 Assister（当前按帧号，**勿盲补**） |
| 约束 | **未改** `main.swf` |

## 约定

- `addFrameScript` 第一个参数是 **0-based** 帧下标；表中同时给出 **1-based** `frameNumber`（Flash 时间轴）。
- `goFight()` 从帧 **2** 起打（跳过帧1 idle stop）。
- 无 FrameLabel 时改招改特效只能靠本表帧号；有标签的辅助见 `timelines/fighters/fz__*.md`。

## 总表

| id | rootFrames | scripts | defineAction | 关键帧摘要 |
|----|-----------:|--------:|-------------:|----------|
| `gaara` | 85 | 4 | `atm1` | f1:idle/stop<br>f16:effect.bisha(false)<br>f38:effect.endBisha()<br>f44:effect.shine(9461816); addAttacker(atmmc) |
| `grimmjow` | 118 | 7 | `atm1,atm2,atm3` | f1:idle/stop<br>f20:effect.bisha(false)<br>f36:effect.endBisha()<br>f37:move(10,0); damping(0.5,0)<br>f41:moveToTarget(-50,0,false)<br>f45:effect.shine(9461864); move(10,0); damping(1,0)<br>f108:endAct() |
| `harribel` | 61 | 7 | `atm1` | f1:idle/stop<br>f16:effect.bisha(false)<br>f30:effect.endBisha()<br>f32:move(30,0)<br>f33:effect.shine(9461864)<br>f43:damping(3,0)<br>f55:endAct() |
| `hinata` | 66 | 5 | `atm1` | f1:idle/stop<br>f13:effect.bisha(false)<br>f28:effect.endBisha(); move(5,0); damping(0.5,0)<br>f30:effect.shine()<br>f49:endAct() |
| `ichigo_padipata` | 68 | 4 | `atm1` | f1:idle/stop<br>f15:effect.bisha(false)<br>f29:effect.endBisha()<br>f60:endAct() |
| `ino` | 73 | 6 | `atm1` | f1:idle/stop<br>f20:effect.bisha(false)<br>f36:effect.endBisha()<br>f41:effect.shine()<br>f45:effect.shine(9461816)<br>f56:endAct() |
| `jiraiya` | 86 | 7 | `atm1,atm2` | f1:idle/stop<br>f10:effect.bisha(false)<br>f30:effect.endBisha()<br>f31:effect.dash(); move(10,0); damping(1,0)<br>f36:moveToTarget(-100,0,false); move(10,0); dampi...<br>f48:effect.shine()<br>f74:endAct() |
| `kenpachi` | 104 | 5 | `atm1` | f1:idle/stop<br>f16:effect.bisha(false)<br>f55:effect.endBisha()<br>f65:move(10,0); damping(1,0)<br>f81:endAct() |
| `kon` | 102 | 5 | `atm1` | f1:idle/stop<br>f15:effect.bisha(false)<br>f30:effect.endBisha()<br>f67:endAct()<br>f69:getOwner() |
| `obito` | 76 | 7 | `atm1` | f1:idle/stop<br>f13:effect.bisha(false)<br>f28:effect.endBisha()<br>f39:moveToTarget(30,-20,true); move(-1,-1)<br>f40:effect.slowDown(0.5)<br>f46:move(-5,-5); damping(0.1,0.1)<br>f64:endAct() |
| `orihime` | 78 | 16 | `atm1` | f1:idle/stop<br>f11:move(6)<br>f21:move(0)<br>f25:effect.bisha(false)<br>f48:effect.endBisha()<br>f50:checkHitOwner("main"); getOwner()<br>f52:checkHitOwner("main"); getOwner()<br>f54:checkHitOwner("main"); getOwner()<br>…+8 |
| `rangiku` | 110 | 4 | `atm1` | f1:idle/stop<br>f12:effect.bisha(false)<br>f37:effect.endBisha()<br>f45:effect.shine(9461816); addAttacker(atmmc) |
| `sai` | 71 | 6 | `atm1` | f1:idle/stop<br>f15:effect.bisha(false); getOwner()<br>f30:effect.endBisha()<br>f32:addAttacker(atmmc)<br>f33:effect.shine(0)<br>f54:endAct() |
| `stake` | 84 | 7 | `atm1,atm2,atm3` | f1:idle/stop<br>f10:effect.bisha(false)<br>f21:effect.endBisha()<br>f27:moveToTarget(-50,0,false)<br>f34:move(10,0); damping(1,0)<br>f43:move(10,0); damping(1,0)<br>f74:endAct() |
| `suigetsu` | 76 | 7 | `atm1,atm2` | f1:idle/stop<br>f13:effect.bisha(false)<br>f28:effect.endBisha()<br>f35:effect.slowDown(0.5); moveToTarget(80,null,true)<br>f44:move(10,0); damping(1,0)<br>f53:move(10,0); damping(1,0)<br>f64:endAct() |
| `temari` | 80 | 7 | `atm1` | f1:idle/stop<br>f20:effect.bisha(false)<br>f36:effect.endBisha()<br>f37:move(5,0); damping(1,0)<br>f38:this.$assisterCtrler.fire("atm1",{ "x":{ "sta...<br>f39:effect.shine(9461864)<br>f69:endAct() |
| `tsuchikage` | 66 | 6 | `atm1,atm2,atm3` | f1:idle/stop<br>f16:effect.bisha(false)<br>f30:effect.endBisha()<br>f33:getOwner()<br>f36:effect.shine(9461816)<br>f62:endAct() |
| `tsunate` | 79 | 12 | `atm1` | f1:idle/stop<br>f7:checkHitOwner("main"); getOwner()<br>f10:checkHitOwner("main"); getOwner()<br>f13:checkHitOwner("main"); getOwner()<br>f16:checkHitOwner("main"); getOwner()<br>f19:checkHitOwner("main"); getOwner()<br>f22:checkHitOwner("main"); getOwner()<br>f25:checkHitOwner("main"); getOwner()<br>…+4 |
| `uryuu` | 63 | 6 | `atm1` | f1:idle/stop<br>f17:moveToTarget(0,-100); setApplyG(false); setAp...<br>f20:effect.bisha(false)<br>f39:effect.endBisha()<br>f41:effect.shine(); effect.shine(7329791); move(0...<br>f47:endAct() |
| `yamamoto` | 76 | 5 | `atm1` | f1:idle/stop<br>f16:effect.bisha(false)<br>f29:effect.endBisha()<br>f33:effect.shine(9461864)<br>f70:endAct() |
| `yin` | 70 | 5 | `atm1` | f1:idle/stop<br>f13:effect.bisha()<br>f40:effect.endBisha()<br>f43:effect.shine(); effect.shine(1069248)<br>f55:endAct() |
| `yoruichi` | 20 | 2 | `atm1` | f1:idle/stop<br>f2:effect.shine(16776960); getOwner(); getOwner() |

## 逐辅助细表

### `gaara`

- 源：`decompiled/fighters/fz/gaara/scripts/gaara_fla/MainTimeline.as`
- rootFrames：**85**；per-assist JSON：`assist/gaara.frames.json`
- defineAction：
  - `atm1` — `"power":50, "hitType":5, "hitx":0, "hity":0, "hurtTime":2000, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 16 | 15 | `frame16` | `effect.bisha(false)` |
| 38 | 37 | `frame38` | `effect.endBisha()` |
| 44 | 43 | `frame44` | `effect.shine(9461816); addAttacker(atmmc)` |

### `grimmjow`

- 源：`decompiled/fighters/fz/grimmjow/scripts/grimmjow_fla/MainTimeline.as`
- rootFrames：**118**；per-assist JSON：`assist/grimmjow.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":2, "hitx":3, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm2` — `"power":5, "hitType":1, "hitx":0, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm3` — `"power":50, "hitType":6, "hitx":5, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 20 | 19 | `frame20` | `effect.bisha(false)` |
| 36 | 35 | `frame36` | `effect.endBisha()` |
| 37 | 36 | `frame37` | `move(10,0); damping(0.5,0)` |
| 41 | 40 | `frame41` | `moveToTarget(-50,0,false)` |
| 45 | 44 | `frame45` | `effect.shine(9461864); move(10,0); damping(1,0)` |
| 108 | 107 | `frame108` | `endAct()` |

### `harribel`

- 源：`decompiled/fighters/fz/harribel/scripts/harribel_fla/MainTimeline.as`
- rootFrames：**61**；per-assist JSON：`assist/harribel.frames.json`
- defineAction：
  - `atm1` — `"power":110, "hitType":5, "hitx":10, "hity":0, "hurtTime":500, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 16 | 15 | `frame16` | `effect.bisha(false)` |
| 30 | 29 | `frame30` | `effect.endBisha()` |
| 32 | 31 | `frame32` | `move(30,0)` |
| 33 | 32 | `frame33` | `effect.shine(9461864)` |
| 43 | 42 | `frame43` | `damping(3,0)` |
| 55 | 54 | `frame55` | `endAct()` |

### `hinata`

- 源：`decompiled/fighters/fz/hinata/scripts/hinata_fla/MainTimeline.as`
- rootFrames：**66**；per-assist JSON：`assist/hinata.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":4, "hitx":5, "hity":0, "hurtTime":1000, "hurtType":0, "isBreakDef":true`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 13 | 12 | `frame13` | `effect.bisha(false)` |
| 28 | 27 | `frame28` | `effect.endBisha(); move(5,0); damping(0.5,0)` |
| 30 | 29 | `frame30` | `effect.shine()` |
| 49 | 48 | `frame49` | `endAct()` |

### `ichigo_padipata`

- 源：`decompiled/fighters/fz/ichigo_padipata/scripts/ichigo_padipata_fla/MainTimeline.as`
- rootFrames：**68**；per-assist JSON：`assist/ichigo_padipata.frames.json`
- defineAction：
  - `atm1` — `"power":150, "hitType":5, "hitx":5, "hity":0, "hurtTime":500, "hurtType":1, "isBreakDef":true`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 15 | 14 | `frame15` | `effect.bisha(false)` |
| 29 | 28 | `frame29` | `effect.endBisha()` |
| 60 | 59 | `frame60` | `endAct()` |

### `ino`

- 源：`decompiled/fighters/fz/ino/scripts/ino_fla/MainTimeline.as`
- rootFrames：**73**；per-assist JSON：`assist/ino.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":5, "hitx":0, "hity":0, "hurtTime":2000, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 20 | 19 | `frame20` | `effect.bisha(false)` |
| 36 | 35 | `frame36` | `effect.endBisha()` |
| 41 | 40 | `frame41` | `effect.shine()` |
| 45 | 44 | `frame45` | `effect.shine(9461816)` |
| 56 | 55 | `frame56` | `endAct()` |

### `jiraiya`

- 源：`decompiled/fighters/fz/jiraiya/scripts/jiraiya_fla/MainTimeline.as`
- rootFrames：**86**；per-assist JSON：`assist/jiraiya.frames.json`
- defineAction：
  - `atm1` — `"power":50, "hitType":4, "hitx":3, "hity":0, "hurtTime":800, "hurtType":0, "isBreakDef":false`
  - `atm2` — `"power":50, "hitType":5, "hitx":15, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 10 | 9 | `frame10` | `effect.bisha(false)` |
| 30 | 29 | `frame30` | `effect.endBisha()` |
| 31 | 30 | `frame31` | `effect.dash(); move(10,0); damping(1,0)` |
| 36 | 35 | `frame36` | `moveToTarget(-100,0,false); move(10,0); damping(0.5,0)` |
| 48 | 47 | `frame48` | `effect.shine()` |
| 74 | 73 | `frame74` | `endAct()` |

### `kenpachi`

- 源：`decompiled/fighters/fz/kenpachi/scripts/kenpachi_fla/MainTimeline.as`
- rootFrames：**104**；per-assist JSON：`assist/kenpachi.frames.json`
- defineAction：
  - `atm1` — `"power":100, "hitType":5, "hitx":15, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":true`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 16 | 15 | `frame16` | `effect.bisha(false)` |
| 55 | 54 | `frame55` | `effect.endBisha()` |
| 65 | 64 | `frame65` | `move(10,0); damping(1,0)` |
| 81 | 80 | `frame81` | `endAct()` |

### `kon`

- 源：`decompiled/fighters/fz/kon/scripts/kon_fla/MainTimeline.as`
- rootFrames：**102**；per-assist JSON：`assist/kon.frames.json`
- defineAction：
  - `atm1` — `"power":10, "hitType":2, "hitx":1, "hity":0, "hurtTime":300, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 15 | 14 | `frame15` | `effect.bisha(false)` |
| 30 | 29 | `frame30` | `effect.endBisha()` |
| 67 | 66 | `frame67` | `endAct()` |
| 69 | 68 | `frame69` | `getOwner()` |

### `obito`

- 源：`decompiled/fighters/fz/obito/scripts/obito_fla/MainTimeline.as`
- rootFrames：**76**；per-assist JSON：`assist/obito.frames.json`
- defineAction：
  - `atm1` — `"power":100, "hitType":7, "hitx":5, "hity":5, "hurtTime":700, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 13 | 12 | `frame13` | `effect.bisha(false)` |
| 28 | 27 | `frame28` | `effect.endBisha()` |
| 39 | 38 | `frame39` | `moveToTarget(30,-20,true); move(-1,-1)` |
| 40 | 39 | `frame40` | `effect.slowDown(0.5)` |
| 46 | 45 | `frame46` | `move(-5,-5); damping(0.1,0.1)` |
| 64 | 63 | `frame64` | `endAct()` |

### `orihime`

- 源：`decompiled/fighters/fz/orihime/scripts/orihime_fla/MainTimeline.as`
- rootFrames：**78**；per-assist JSON：`assist/orihime.frames.json`
- defineAction：
  - `atm1` — `"power":0, "hitType":0, "hitx":0, "hity":0, "hurtTime":0, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 11 | 10 | `frame11` | `move(6)` |
| 21 | 20 | `frame21` | `move(0)` |
| 25 | 24 | `frame25` | `effect.bisha(false)` |
| 48 | 47 | `frame48` | `effect.endBisha()` |
| 50 | 49 | `frame50` | `checkHitOwner("main"); getOwner()` |
| 52 | 51 | `frame52` | `checkHitOwner("main"); getOwner()` |
| 54 | 53 | `frame54` | `checkHitOwner("main"); getOwner()` |
| 56 | 55 | `frame56` | `checkHitOwner("main"); getOwner()` |
| 58 | 57 | `frame58` | `checkHitOwner("main"); getOwner()` |
| 60 | 59 | `frame60` | `checkHitOwner("main"); getOwner()` |
| 62 | 61 | `frame62` | `checkHitOwner("main"); getOwner()` |
| 64 | 63 | `frame64` | `checkHitOwner("main"); getOwner()` |
| 66 | 65 | `frame66` | `checkHitOwner("main"); getOwner()` |
| 68 | 67 | `frame68` | `checkHitOwner("main"); getOwner()` |
| 71 | 70 | `frame71` | `endAct()` |

### `rangiku`

- 源：`decompiled/fighters/fz/rangiku/scripts/rangiku_fla/MainTimeline.as`
- rootFrames：**110**；per-assist JSON：`assist/rangiku.frames.json`
- defineAction：
  - `atm1` — `"power":10, "hitType":4, "hitx":0, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 12 | 11 | `frame12` | `effect.bisha(false)` |
| 37 | 36 | `frame37` | `effect.endBisha()` |
| 45 | 44 | `frame45` | `effect.shine(9461816); addAttacker(atmmc)` |

### `sai`

- 源：`decompiled/fighters/fz/sai/scripts/sai_fla/MainTimeline.as`
- rootFrames：**71**；per-assist JSON：`assist/sai.frames.json`
- defineAction：
  - `atm1` — `"power":10, "hitType":4, "hitx":0, "hity":-5, "hurtTime":800, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 15 | 14 | `frame15` | `effect.bisha(false); getOwner()` |
| 30 | 29 | `frame30` | `effect.endBisha()` |
| 32 | 31 | `frame32` | `addAttacker(atmmc)` |
| 33 | 32 | `frame33` | `effect.shine(0)` |
| 54 | 53 | `frame54` | `endAct()` |

### `stake`

- 源：`decompiled/fighters/fz/stake/scripts/stake_fla/MainTimeline.as`
- rootFrames：**84**；per-assist JSON：`assist/stake.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":2, "hitx":4, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm2` — `"power":20, "hitType":1, "hitx":2, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm3` — `"power":100, "hitType":5, "hitx":10, "hity":0, "hurtTime":800, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 10 | 9 | `frame10` | `effect.bisha(false)` |
| 21 | 20 | `frame21` | `effect.endBisha()` |
| 27 | 26 | `frame27` | `moveToTarget(-50,0,false)` |
| 34 | 33 | `frame34` | `move(10,0); damping(1,0)` |
| 43 | 42 | `frame43` | `move(10,0); damping(1,0)` |
| 74 | 73 | `frame74` | `endAct()` |

### `suigetsu`

- 源：`decompiled/fighters/fz/suigetsu/scripts/suigetsu_fla/MainTimeline.as`
- rootFrames：**76**；per-assist JSON：`assist/suigetsu.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":1, "hitx":3, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm2` — `"power":50, "hitType":6, "hitx":5, "hity":-5, "hurtTime":600, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 13 | 12 | `frame13` | `effect.bisha(false)` |
| 28 | 27 | `frame28` | `effect.endBisha()` |
| 35 | 34 | `frame35` | `effect.slowDown(0.5); moveToTarget(80,null,true)` |
| 44 | 43 | `frame44` | `move(10,0); damping(1,0)` |
| 53 | 52 | `frame53` | `move(10,0); damping(1,0)` |
| 64 | 63 | `frame64` | `endAct()` |

### `temari`

- 源：`decompiled/fighters/fz/temari/scripts/temari_fla/MainTimeline.as`
- rootFrames：**80**；per-assist JSON：`assist/temari.frames.json`
- defineAction：
  - `atm1` — `"power":10, "hitType":4, "hitx":0.5, "hity":-1, "hurtTime":300, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 20 | 19 | `frame20` | `effect.bisha(false)` |
| 36 | 35 | `frame36` | `effect.endBisha()` |
| 37 | 36 | `frame37` | `move(5,0); damping(1,0)` |
| 38 | 37 | `frame38` | `this.$assisterCtrler.fire("atm1",{ "x":{ "start":20, "hit":1` |
| 39 | 38 | `frame39` | `effect.shine(9461864)` |
| 69 | 68 | `frame69` | `endAct()` |

### `tsuchikage`

- 源：`decompiled/fighters/fz/tsuchikage/scripts/tsuchikage_fla/MainTimeline.as`
- rootFrames：**66**；per-assist JSON：`assist/tsuchikage.frames.json`
- defineAction：
  - `atm1` — `"power":20, "hitType":2, "hitx":5, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm2` — `"power":50, "hitType":1, "hitx":10, "hity":0, "hurtTime":500, "hurtType":0, "isBreakDef":false`
  - `atm3` — `"power":100, "hitType":3, "hitx":10, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 16 | 15 | `frame16` | `effect.bisha(false)` |
| 30 | 29 | `frame30` | `effect.endBisha()` |
| 33 | 32 | `frame33` | `getOwner()` |
| 36 | 35 | `frame36` | `effect.shine(9461816)` |
| 62 | 61 | `frame62` | `endAct()` |

### `tsunate`

- 源：`decompiled/fighters/fz/tsunate/scripts/tsunate_fla/MainTimeline.as`
- rootFrames：**79**；per-assist JSON：`assist/tsunate.frames.json`
- defineAction：
  - `atm1` — `"power":50, "hitType":5, "hitx":15, "hity":0, "hurtTime":500, "hurtType":1, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 7 | 6 | `frame7` | `checkHitOwner("main"); getOwner()` |
| 10 | 9 | `frame10` | `checkHitOwner("main"); getOwner()` |
| 13 | 12 | `frame13` | `checkHitOwner("main"); getOwner()` |
| 16 | 15 | `frame16` | `checkHitOwner("main"); getOwner()` |
| 19 | 18 | `frame19` | `checkHitOwner("main"); getOwner()` |
| 22 | 21 | `frame22` | `checkHitOwner("main"); getOwner()` |
| 25 | 24 | `frame25` | `checkHitOwner("main"); getOwner()` |
| 28 | 27 | `frame28` | `checkHitOwner("main"); getOwner()` |
| 39 | 38 | `frame39` | `moveToTarget(-50,null,false)` |
| 45 | 44 | `frame45` | `move(10,0); damping(1,0)` |
| 60 | 59 | `frame60` | `endAct()` |

### `uryuu`

- 源：`decompiled/fighters/fz/uryuu/scripts/uryuu_fla/MainTimeline.as`
- rootFrames：**63**；per-assist JSON：`assist/uryuu.frames.json`
- defineAction：
  - `atm1` — `"power":80, "hitType":5, "hitx":3, "hity":10, "hurtTime":500, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 17 | 16 | `frame17` | `moveToTarget(0,-100); setApplyG(false); setApplyG(...)` |
| 20 | 19 | `frame20` | `effect.bisha(false)` |
| 39 | 38 | `frame39` | `effect.endBisha()` |
| 41 | 40 | `frame41` | `effect.shine(); effect.shine(7329791); move(0,-5); damping(0,0.5)` |
| 47 | 46 | `frame47` | `endAct()` |

### `yamamoto`

- 源：`decompiled/fighters/fz/yamamoto/scripts/yamamoto_fla/MainTimeline.as`
- rootFrames：**76**；per-assist JSON：`assist/yamamoto.frames.json`
- defineAction：
  - `atm1` — `"power":200, "hitType":7, "hitx":5, "hity":-10, "hurtTime":0, "hurtType":1, "isBreakDef":true`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 16 | 15 | `frame16` | `effect.bisha(false)` |
| 29 | 28 | `frame29` | `effect.endBisha()` |
| 33 | 32 | `frame33` | `effect.shine(9461864)` |
| 70 | 69 | `frame70` | `endAct()` |

### `yin`

- 源：`decompiled/fighters/fz/yin/scripts/yin_fla/MainTimeline.as`
- rootFrames：**70**；per-assist JSON：`assist/yin.frames.json`
- defineAction：
  - `atm1` — `"power":150, "hitType":5, "hitx":10, "hity":0, "hurtTime":0, "hurtType":1, "isBreakDef":true`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 13 | 12 | `frame13` | `effect.bisha()` |
| 40 | 39 | `frame40` | `effect.endBisha()` |
| 43 | 42 | `frame43` | `effect.shine(); effect.shine(1069248)` |
| 55 | 54 | `frame55` | `endAct()` |

### `yoruichi`

- 源：`decompiled/fighters/fz/yoruichi/scripts/yoruichi_fla/MainTimeline.as`
- rootFrames：**20**；per-assist JSON：`assist/yoruichi.frames.json`
- defineAction：
  - `atm1` — `"power":0, "hitType":0, "hitx":0, "hity":0, "hurtTime":0, "hurtType":0, "isBreakDef":false`

| frame# | index0 | function | summary |
|-------:|-------:|----------|---------|
| 1 | 0 | `frame1` | `stop` |
| 2 | 1 | `frame2` | `effect.shine(16776960); getOwner(); getOwner()` |

## 与 Assister 交叉

| 检查 | 结果 |
|------|------|
| 22 辅助均有 MainTimeline `addFrameScript` | YES |
| 帧1 均为 `stop` idle | YES |
| `goFight→2` 与帧1 stop 无冲突 | YES（引擎跳过 idle） |
| 悬空 defineAction id | 未见（atm* 由时间轴 atm 实例消费） |

## Chinese summary

22 个无 FrameLabel 辅助已从反编译 MainTimeline 抽出 addFrameScript 帧号→动作表（齐全）。引擎用帧号而非标签；重制改招以本表为准。未改 main.swf。
