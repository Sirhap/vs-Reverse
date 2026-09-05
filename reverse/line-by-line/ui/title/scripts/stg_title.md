# `stg_title` — 主菜单 / 标题根 MC

一句话目的：`title` SWF 主导出。片头播完停在 F50；任意键/点击跳 `"menu"` 停在 F75，同时引擎往 `btnct` 里塞 [`MenuBtnGroup`](../../../engine/game/bvn/ui/MenuBtnGroup.md)。本类派 `Event.COMPLETE`，**引擎不听**。

源文件：`decompiled/ui/title/scripts/stg_title.as`（33 行）

## 如何挂上引擎

[`ResUtils.TITLE`](../../../engine/game/bvn/utils/ResUtils.md) = `"stg_title"`。[`MenuState.build`](../../../engine/game/bvn/state/MenuState.md)：

```
createDisplayObject(ResUtils.I.title, ResUtils.TITLE)
gotoAndStop(1)
GameInterface.instance.initTitleUI(_ui)   // 本包 GameInterfaceManager 空实现
```

`afterBuild`：`gotoAndPlay(2)` 开片头。**500ms** 后才 `buttonMode`、听 click/touchTap、`GameRender.add(render)`、开 `GameInputer`。任意键 `anyKey(1)` 与点击都进 `showBtns`：

1. 卸监听 / 关手型
2. `_ui.gotoAndPlay("menu")`
3. `snd_menu5`
4. `new MenuBtnGroup()` 坐标 (470, 100)，优先 `getChildByName("btnct")`，没有则 `_ui.addChild`
5. `build()` + `fadIn(0.2, 0.04)`，400ms 后 `enabled=true`

版本字 `"V3.3-REV"` 是引擎 `addChild` 到本 MC 的 `TextField`，不是时间轴元件。

SWF：`title_swf`（DefineBinaryData id 2215），链接名 `stg_title`，`symbol="symbol64"`。Sprite id=64，**90** 帧，fps=30 与 `setFPS(30)` 一致。AS 无标签字面量；`"menu"` 来自 SWF `FrameLabel`（`extracted/full/swf/bin_2215.swf`）。同 SWF 还有 [`stg_test`](stg_test.md)（引擎不用）和 [`title_fla.logomc_3`](title_fla/logomc_3.md)。

## 时间轴（按标签分组）

`addFrameScript` 0-based：`N` = `F{N+1}`。

| 段 | 帧 | 脚本 / 标签 | 引擎 |
|----|----|-------------|------|
| 停帧 | F1 | 无脚本。已放 `logo_mc`、`btnct` | `build` `gotoAndStop(1)` |
| 片头 | F2 → F49 | 无脚本 | `afterBuild` `gotoAndPlay(2)`。500ms 后已能点/按跳过 |
| 片头结束 | **F50** | `frame50`：`stop` + `COMPLETE` | **MenuState 不听 complete**。不点就停在这里等输入 |
| `"menu"` | **F65** | 仅 FrameLabel | `showBtns` `gotoAndPlay("menu")` |
| 菜单定格 | **F75** | `frame75`：`stop` + `COMPLETE` | 同样无人监听。按钮组在这段期间淡入 |

两处 COMPLETE 是 FLA 留给「播完再解锁」的钩子，本包改成 500ms 定时器 + 任意键，COMPLETE 空放。点得早会从片头中途跳到 F65，F50 脚本不会跑。

## 字段 / 按钮容器

| L | 名字 | 类型 | 时间轴 | 引擎 |
|---|------|------|--------|------|
| L10 | `btnct` | `MovieClip` | F1 放置，cid=20，空 1 帧容器 | `showBtns` 优先 `ct.addChild(_btnGroup)`。菜单钮不是时间轴预摆，是运行时 [`MenuBtn`](../../../engine/game/bvn/ui/MenuBtn.md)（`mc_wzbtn`） |
| L12 | `logo_mc` | `MovieClip` | F1 放置，**cid=19 = `title_fla.logomc_3`** | 本包不读写。渠道可在 `initTitleUI` 里显某个子 Logo。默认整棵 `visible=false`（见 [`logomc_3`](title_fla/logomc_3.md)） |

无 skip 钮、无文本槽。菜单项来自 `GameInterface.getGameMenu` / `getDefaultMenu`（TEAM/SINGLE/OPTION/TRAINING/CREDITS/MORE GAMES，本包再插 RANK）。

## 逐行说明

### 包与 Embed（L1–7）

无名包。`MovieClip`、`Event`。[Embed] `source="/_assets/assets.swf", symbol="symbol64"`。`public dynamic class stg_title extends MovieClip`。

### 字段（L10–12）

见上表。`logo_mc` 声明成 `MovieClip`，运行时实例类是 `title_fla.logomc_3`（SymbolClass id 19）。

### 构造 `stg_title()`（L14–18）

- L16: `super();`
- L17: `addFrameScript(49, this.frame50, 74, this.frame75);`
  - **addFrameScript 49 = F50**
  - **addFrameScript 74 = F75**

### `frame50`（L20–24）—— 片头定格

- L22: `stop();`
- L23: `dispatchEvent(new Event(Event.COMPLETE));` —— type `"complete"`。MenuState **没有** `addEventListener("complete", …)`。500ms 后输入已开，停在 F50 等 click/anyKey。

### `frame75`（L26–30）—— 菜单定格

- L28: `stop();`
- L29: 再派一次 COMPLETE，同样无人听。`MenuBtnGroup` 此时应已挂在 `btnct`（`showBtns` 里先 `gotoAndPlay("menu")` 再 `addChild`）。

`MenuState.destory` 拆按钮组、关输入，**不** `gotoAndStop` 本 MC。
