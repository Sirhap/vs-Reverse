# `TrainingCtrler` — 练习模式锁血 / 回气

一句话目的：`GameMode.TRAINING==40` 下每帧把双方 HP/气/辅助气在延迟后拉回满值；受击中延长 HP 回满。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ctrl/game_ctrls/TrainingCtrler.as`（107 行）

## Callers / callees

- **Callers**：只 `GameCtrl.buildGame` 在 `currentMode==40` 时 `new TrainingCtrler().initlize([p1,p2])`；`GameCtrl.render` 末尾 `_trainingCtrl.render()`；`GameCtrl.destory` → `destory()`。
- **Callees**：`StateCtrl.I.transOut`；读 `FighterMain.hp/hpMax/qi/fzqi/actionState/id`；`GameConfig.FPS_GAME`。
- 练习模式配套：`GameLogic.checkFighterDie` 对 mode 40 恒 false（不会 `DIE`/`gameEnd`）；`gameTimeMax=-1` 不计时；P2 是键鼠不是 AI。

## 命名备注

- `initlize` / `destory`：原拼写。
- `RECOVER_HP` / `RECOVER_QI` / `RECOVER_FZ_QI`：公开静态，默认 true。**本包未见其它写入**（? 预留练习菜单/调试）。为 false 时倒计时仍走，到期不回。
- 延迟 key：`id+"_hp"`、`id+"_qi"`、`id+"fz"`（辅助气 **没有** 下划线）。
- `actionState` 21/22 = `HURT_ING` / `HURT_FLYING`。倒地 23 不算「受击中」，会开始回血倒计时。
- 气满值写死 300，辅助气写死 100，不读 `GameConfig`。

## 逐行说明

### 静态 / 字段 / 构造（L10–23）

三个 `RECOVER_*` 默认 true。`_trainAddDelay:Object` 当 map。`_fighters:Array`。构造空。

### `initlize`（L25–34）

存双方数组，**立刻 `qi=300`**（开场满气）。`_trainAddDelay={}`。`StateCtrl.I.transOut(null,true)`：练习没有 `GameStartCtrl`，这里自己把转场切掉。不改 HP/`fzqi`（HP 由 `GameState.initFight` → `GameLogic.resetFighterHP`）。

### `destory`（L36–40）

null 数组和 delay map。

### `render`（L42–105）

对每个 fighter 三段独立延迟。局部 `_loc2_/_loc1_/_loc3_` 分别是 hp/qi/fz key。

**HP（L49–69）**

1. 正在 21/22：**每帧重置** `delay = 1*FPS_GAME`（受击期间不倒数，松开后还有约 1s）。
2. 否则若 delay 已定义且 >0：`--`；到 0 且 `RECOVER_HP` → `hp=hpMax`。
3. 否则若已满血：delay=0。
4. 否则（掉血且 delay 为 0/undefined）：`delay = 2*FPS_GAME`。

因此：不在受击中掉血 → 等 2s 回满；受击结束 → 从 1s 倒数回满。回满后 delay 保持 0，直到再次掉血。

**QI（L70–86）**

无受击特殊分支。delay>0 则倒数，到 0 且 `RECOVER_QI` → `qi=300`。已是 300 → delay=0。否则（气不满）设 2s。`initlize` 已拉满，只有放必杀后才会进 2s。

**FZ QI（L87–103）**

同气，满值 100，flag `RECOVER_FZ_QI`。key 为 `id+"fz"`。

练习仍跑 `_startCtrl` 以外的主循环（无开场 ctrl），`actionEnable` 在 `buildGame` 已 true，本 ctrl 只负责资源回满。
