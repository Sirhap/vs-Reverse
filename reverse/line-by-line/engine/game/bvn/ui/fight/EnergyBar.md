# `EnergyBar` — 体力条（`FighterMain.energy`，不是气 / 不是辅助）

一句话目的：绑 `energy_bar` MC。绿条跟 `energy/energyMax`，overload 停在帧 2，低于 30% 闪。文字按 `comicType` 切死神/火影。P2 `setDirect(-1)` 水平翻转文字。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/EnergyBar.as`（259 行，含脚本级 `InsBar` / `InsTxt`）

## Callers / callees

- **Callers**：只 `FightBar`。构造 `new EnergyBar(_ui.energy1/2)`；P2 `setDirect(-1)`；`setFighter(currentFighter)`；每逻辑帧 `render`；`destory`。
- **Callees**：无引擎类型。读 `FighterMain.energy` / `energyMax` / `energyOverLoad` / `data.comicType`。MC：`energy_bar.barmc.bar`、`energy_bar.txtmc`。

## 和气条的区别

| | EnergyBar | QiBar |
|---|---|---|
| 资源 | `hpbar_mc.energy1/2`（顶栏） | `ui_fight.fzqi1/2`（底侧） |
| 数值 | `energy` 0..`energyMax`(100) 体力 | `qi` 0..300 气 + `fzqi` 0..100 辅助 |
| 用途 | 冲刺/跳跃/攻击消耗，空了 `energyOverLoad` | 必杀/辅助出场 |
| 脸 | 无 | 辅助脸 |

任务备忘里「EnergyBar: fzqi / energy for assist」不准确：辅助气在 `QiBar._fzBar`。本类只画**出战角色体力**。

## 命名备注

- `destory`：只 null `_fighter`，不拆 `_bar`/`_txt`/`_ui`。
- 外层 `_renderFlash` / `_renderFlashInt`（L17–19）**从未读写**。闪烁状态在 `InsBar`/`InsTxt` 各自一份。
- `InsBar` / `InsTxt` 是 **脚本级类**（package 外，本文件可见），不是 `EnergyBar` inner class 语法。
- `txtmc` 期望子级 `mc`（`fight_fla.energybar_txt_mc_3`）。`InsTxt` 多处 `if(_mc.mc)` 护栏。
- `setType`：`comicType` 0→帧 1（死神），1→帧 2（火影）。其它值不切帧。
- `render` 不判 `_fighter`：`initlize` 前调用会 NPE。

## 体力逻辑对照（`FighterMain`）

- 默认 `energy=100`，`energyMax=100`，`energyOverLoad=false`。
- `useEnergy` 扣到 <0 则钳 0 并 `energyOverLoad=true`，`_energyAddGap=0.8*30` 帧内不回。
- 回复：overload 时 +0.6/帧，过 30 清 overload；防御 +0.8；攻击中 +1.1；其它 +2。
- UI：overload → 条/字停帧 2；否则 `rate<0.3` 闪；否则正常帧 1。

## 逐行说明

### `EnergyBar` 字段 / 构造（L9–27）

`_ui`=`energy_bar`。`_bar = new InsBar(_ui.barmc.bar)`（真正 scaleX 的那截 MovieClip）。`_txt = new InsTxt(_ui.txtmc)`。

### `ui` getter（L29–32）

返回 `_ui`。`FightBar.initBitmapUI` `addChildren(_energyBar.ui)` 把它从 `hpbar_mc` 里抬到 `ui_fight`。

### `destory`（L34–37）

`_fighter=null`。条 MC 随 HUD 拆。

### `setFighter`（L39–46）

存引用。`param1.data` 有则 `_txt.setType(data.comicType)`。换人只改类型，不重置条状态（`_isOverLoad` 等留在 Ins* 里，下一帧 `render` 会按新角色纠正）。

### `setDirect`（L48–51）

转发 `_txt.setDirect`。条本身不翻（P2 的 `energy2` SWF 已镜像布局）。

### `render`（L53–73）

1. `_bar.rate = energy/energyMax`（可 >1 或 NaN，若 max=0）。?
2. `energyOverLoad` → 双方 `overLoad()`。
3. 否则 `rate<0.3` → `flash()`；否则 `normal()`。
4. `_bar.render()`（lerp scaleX + 可能闪帧）、`_txt.render()`（只闪）。

阈值 0.3 对应 energy<30，与 overload 恢复线（energy>30 才清 flag）对齐：刚从 overload 出来时 rate 刚过 0.3，直接 normal。

---

### 脚本级 `InsBar`（L79–161）

`rate` 公开，外层每帧写。`_curRate` **声明了从未用**（lerp 直接改 `_mc.scaleX`）。

#### 构造（L96–100）

只存 `_mc`。

#### `render`（L102–117）

`delta = rate - scaleX`。`abs<0.01` 则贴死 `rate`，否则 `scaleX += delta*0.4`（一阶平滑，约几帧追上）。`_isFlash` 则 `renderFlash()`。

#### `renderFlash`（L119–127）

每 3 次 `render`（`++_renderFlashInt > 2`）切一次 `_mc` 帧：2↔1。即逻辑帧 60fps 时约 10Hz 闪。`flash()` 把 frame 种子设为 2，第一次切到 2。

#### `normal`（L129–138）

已是非 overload 非 flash 则 return。清两旗，`gotoAndStop(1)`。

#### `flash`（L140–149）

已在 flash 则 return（不重置计数，闪的相位连续）。否则开 flash、计数 0、下一目标帧 2。**不清** `_isOverLoad`——但外层 if/else 互斥，overload 不会同时 flash。

#### `overLoad`（L151–160）

已 overload 则 return。置旗、关 flash，`gotoAndStop(2)`（SWF 第二帧=耗尽样式）。之后 `renderFlash` 因 `_isFlash=false` 不跑，条停在红/灰帧，scaleX 仍跟 rate 涨（overload 回复时条子在帧 2 上变长）。

---

### 脚本级 `InsTxt`（L163–259）

结构几乎同 `InsBar`，作用对象是 `_mc.mc`（文字内层），没有 `rate`/`scaleX`。

#### `setDirect`（L182–185）

`_mc.scaleX = param1>0 ? 1 : -1`。翻的是整块 `txtmc`，P2 文字朝左。

#### `setType`（L187–197）

`switch(comicType)`：0→`gotoAndStop(1)`，1→`gotoAndStop(2)`。无 default。`energybar_txt_mc_3` 帧 1 就 `stop`。切类型后内层 `mc` 可能被换掉，flash 仍对着旧引用？下一帧 `renderFlash` 读当前 `_mc.mc`。

#### `render` / `renderFlash`（L199–219）

无 `mc` 则 return。同样每 3 帧在 `mc` 的 1/2 帧间切。

#### `normal` / `flash` / `overLoad`（L221–258）

与 InsBar 同旗语义。`normal`/`overLoad` 改的是 `_mc.mc` 帧，缺子级则只改旗。overload 文字停帧 2；flash 在 1/2 间闪。
