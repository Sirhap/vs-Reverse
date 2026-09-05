# `FightQiBarMode` — 气条贴边模式枚举

一句话目的：给 `FightUI.QI_BAR_MODE` 用的三个 int 常量。AUTO 按镜头 zoom 在底/顶之间切（实现于未调用的 `renderQibarPos`）；TOP 开场就把气条钉在血条旁；BOTTOM 留 SWF 底边原位。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/ui/fight/FightQiBarMode.as`（16 行）

## Callers / callees

- **引擎调用**：本包 **零引用**。没有任何 `.as` import 本类，也没有任何地方给 `FightUI.QI_BAR_MODE` 赋值。
- `FightUI` 只拿整型字面量比：`QI_BAR_MODE != 0`、`== 1`。语义上 0/1/2 与本类常量对齐，但代码没写 `FightQiBarMode.AUTO`。
- 可能的写入点（本包不存在）：设置页 / `ConfigVO.extendConfig` / 外部 `GameInterface`。默认 int=0 → AUTO。
- **Callees**：无。

## 命名备注

- 全静态常量类，空构造。与 `HitType` / `FighterActionState` 同风格。
- `FightUI.fadIn` 只特殊处理 `==1`（TOP）；`==2`（BOTTOM）和 `==0`（AUTO）在 fadIn 上行为相同（气条留原位）。AUTO 的动态位移本应在 `renderQibarPos`，但 `render` 从不调它。
- 因此 **当前构建里三种模式外观无区别**：气条永远在 `qbar_mc` 的 SWF 原位（底侧），BITMAP 下只是显示/隐藏。

## 逐行说明

### 常量（L7–10）

| 值 | 名 | 设计意图（对照 `FightUI`） |
|---|---|---|
| 0 | `AUTO` | zoom<1.5 时 `moveTo(120/675, 60, 0.8)` 贴顶缩小，否则 `moveResume` 回底。依赖死代码 `renderQibarPos`。 |
| 1 | `TOP` | `fadIn` 时 `fadIn(false)` + `setPosAndScale(120/675, 60, 0.8)`，一直贴顶。 |
| 2 | `BOTTOM` | 不改坐标，SWF 底边。 |

TOP 坐标与 AUTO 的「近景贴顶」是同一组数字：P1 `(120,60)×0.8`，P2 `(675,60)×0.8`。`GAME_SIZE.x=800`，675 在右侧。

### 空构造（L12–15）

全静态。外部若 `new FightQiBarMode()` 无副作用。
