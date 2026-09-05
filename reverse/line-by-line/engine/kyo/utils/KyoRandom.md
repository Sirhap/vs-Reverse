# `KyoRandom` — 数组随机

一句话目的：从数组里抽一个 / 打乱。战斗语音、街机敌、选人 randoms、地图、音效名都走 `getRandomInArray`。

源文件：`decompiled/main/scripts/net/play5d/kyo/utils/KyoRandom.as`（175 行）

## Callers / callees

- **`getRandomInArray`**：
  - `FighterVoiceCtrler`：多条语音里抽一条
  - `MessionStageVO`：`fighters` 数组抽一个包成单元素数组
  - `FighterVO`：`says` 对白
  - `SelectFighterStage`：`randoms` 里抽 `currentFighter`（第二参 `false`，不删）
  - `MapSelectUI`：随机图
  - `SoundCtrl.playAssetSoundRandom`：`rest` 当数组抽一个文件名
- **`arraySortRandom`**：`SelectIndexUIGroup` 打乱出战顺序
- **本包无调用**：`getRandomSomeInArray` / `getRandomOne` / `between` / `getRandomByRate` / `getRandomByRateLite` / `getRandomInts` / `getRandomColor`

## 逐行说明

### `getRandomInArray`（L11–24）

`(list, remove=false)`。`null` 或 `length<1` → `null`。`index = Math.random()*length << 0`（向 0 截成 int）。`param2` 真则 `splice` 掉该项。`SoundCtrl` 把 `...rest` 直接传入，rest 是 Array，可用。

### `getRandomSomeInArray`（L26–45）

抽 `param2` 个。先 `concat` 工作副本。`param3==false`（默认）抽完 splice，不重复；`true` 放回，可重复。`param2 > length` 且不放回时，后期 `length=0`，`random*0<<0=0`，`undefined` 仍 push。无调用。

### `getRandomOne`（L47–50）

`...rest` 转给 `getRandomInArray(rest)`。无调用。

### `between`（L52–76）

`[min,max]` 闭区间均匀（先交换保证 min≤max）。`min + random*(max-min)`。随后两行钳制（浮点边界）。`max==min` 得 min。无调用。

### `getRandomByRate`（L78–107）

`param1` 对象数组，`param2` 权重字段名。`sortOn(NUMERIC)` 后累加权重，`random * total` 落在哪段返回哪项。`random` 若 `> total-1` 钳到 `total-1`（权重全是小数且 total<1 时可能把所有区间切掉）。扫完没命中抛 `"无法按机率选择，请检查数据"`。无调用。

### `getRandomByRateLite`（L109–137）

`sortOn` 后 `random * param3`（默认 1）。找 **第一个 `rate >= 随机数` 的档**，再把同档权重的项放进数组，最后 `getRandomInArray`。权重是「阈值」不是「相对比重」。无调用。

### `getRandomInts`（L139–150）

`[param1, param2)` 填整数再 `arraySortRandom`。`param1>=param2` 空数组。无调用。

### `arraySortRandom`（L152–166）

`Array.sort` 比较函数：`random<0.5 → -1` 否则 `1`（**从不返回 0**）。不是 Fisher–Yates，分布不均匀，但够打乱出战顺序。原地改数组。

### `getRandomColor`（L168–171）

`min + (max-min)*random`，默认 0..0xFFFFFF。浮点再当 uint。无调用。
