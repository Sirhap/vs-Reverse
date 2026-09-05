# `(无名包).loading_fight_mc` — 战前加载屏（角色/地图）

一句话目的：选人结束后进对战前的加载 UI。子件 `sltui` 是 [`loading_select_ui_mc`](./loading_select_ui_mc.md)（进度条 + 出战顺序层）。本类无脚本。

源文件：`decompiled/ui/loading/scripts/loading_fight_mc.as`（17 行）

## 如何挂上引擎

[`LoadingState.build`](../../../engine/game/bvn/state/LoadingState.md) L118：

```
_ui = ResUtils.I.createDisplayObject(ResUtils.I.fight, "loading_fight_mc");
_sltUI = _ui.sltui;
_selectIndexUI = new SelectIndexUI();
_sltUI.addChild(_selectIndexUI);
```

字段类型 `_ui:loading_fight_mc`。随后：

- `_sltUI.bar.bar.scaleX = param1`（`loadProcess`）
- `_sltUI.bar.txt.text = msg + "(n/N)"`（`updateMsg`）
- `loadFin`：`TweenLite.to(_sltUI, 1, {y:80})` 把选人/进度层上移

入口：`MainGame.loadGame()`（选人 `goLoadGame`、[`WinnerState`](../../../engine/game/bvn/state/WinnerState.md) 再战）。

## 库名对不上（currentDomain）

反编译在 **`ui/loading/`**（`loading_swf` 导出 `loading_fight_mc`，symbol104）。引擎第一参却写 **`ResUtils.I.fight`**。本批 `decompiled/ui/fight/` **没有** 这个类。

仍能 `new`：八个 UI SWF 并入 `ApplicationDomain.currentDomain`，[`ResUtils.getItemClass`](../../../engine/game/bvn/utils/ResUtils.md) 用该域 `getDefinition("loading_fight_mc")`。第一参只需池里任意已 load 的 SWF；`fight` 只当钥匙，真正的 ABC 来自 loading.swf。

`BVN-ANALYSIS.md` 把本链接写进 fight_swf 是按引擎调用写的，和本批反编译目录不一致。以本文件 + currentDomain 为准。

## 逐行说明

- **L1–3**：无名包。`MovieClip`。
- **L5**：`[Embed(..., symbol="symbol104")]`。
- **L6**：`public dynamic class loading_fight_mc extends MovieClip`。
- **L9**：`public var sltui:loading_select_ui_mc;` —— 舞台实例名 `sltui`。进度条在它里面的 `bar`，不是本 MC 直属。
- **L11–14 构造**：`super()`。无 `addFrameScript`。背景/循环动画走 FLA。
