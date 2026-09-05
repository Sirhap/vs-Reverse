# `MCNumber` — MovieClip 逐位数字

一句话目的：每个数字一位 `MovieClip`，`gotoAndStop(startFrame + digit)`。战斗 HUD 的连击 / 分数 / 倒计时用。

源文件：`decompiled/main/scripts/net/play5d/kyo/display/MCNumber.as`（77 行）

## Callers / callees

- **Callers**：
  - `HitsUI`：`new MCNumber(hits_num_mc, 0, 1, 35)` — 位宽 35，**不**补零（`bits=0`）。
  - `FightScoreUI`：`new MCNumber(txtmc_score, 0, 1, 10, 10)` — 10 位，宽 10。
  - `FightTimeUI`：`new MCNumber(time_txtmc, 0, 1, 20, 2)` — 2 位，宽 20。无限时间不建。
- **Callees**：`MovieClip.gotoAndStop`。数字皮肤来自 `ResUtils.I.fight` 的 Class。

## 约定

时间轴：**第 `startFrame` 帧是数字 0**，+1 是 1，…，+9 是 9。三个调用方都传 `startFrame=1`，即第 1 帧 = 0。

## 逐行说明

### 字段（L9–19）

- `mcWidth`：每位占用的 x 步进。`-1` 用该 MC 的 `width`。
- `startFrame`：0 对应的帧号。
- `_mc`：数字 MC 的 Class。
- `_mcs`：当前在屏的各位。
- `_number` / `_bits`：值和最小位数。

### 构造（L22–30）

`(Class, number, startFrame=1, mcWidth=-1, bits=0)`。最后 `this.number = param2` 走 setter 立刻建位。

### `number` getter（L32–35）

返回 `_number`。

### `number` setter（L37–64）

1. 记下值。
2. 旧各位 `removeChild`，`_mcs = []`。**不** `stop` / 卸监听。
3. `toString()`。`while(length < bits)` 左补 `"0"`。`bits=0` 时 `length < 0` 恒 false，不补。`uint` 不会出负号。
4. 从左到右 `createNum(int(char))`，x 累加：`mcWidth==-1 ? child.width : mcWidth`。

分数 10 位会画出一长串前导零。连击位数随数字变，每次 setter 全拆重建。

### `createNum`（L66–73）

`new _mc()` → `gotoAndStop(startFrame + digit)` → `addChild` → `_mcs.push` → 返回该 MC。digit 0–9；`int("0")`=0。

无 `destory`。HUD 拆掉时由父级 `removeChild` 本 Sprite。
