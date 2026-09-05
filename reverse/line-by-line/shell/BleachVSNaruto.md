# `BleachVSNaruto` — 文档类，把主时间轴交给 GreenHD FM

一句话目的：SWF 文档类，构造函数里只做 `ǵ.ɐ.Ȱ(this, Ǵ)`，自身不含玩法。

源文件：`decompiled/main/scripts/BleachVSNaruto.as`（17 行）

## Callers / callees

- **Callers**：播放器实例化文档类（SymbolClass char 0）。无人从 AS 再 `new BleachVSNaruto()`。
- **Callees**：`ƒ.ǵ.ɐ.Ȱ`、`ƒ.Ǵ`（作为 FrameTask 第一项传入）。

## 符号对照（本文件）

| 混淆名 | 建议名 | 角色 |
|--------|--------|------|
| `BleachVSNaruto` | `DocumentClass` | 主时间轴 MovieClip |
| `ǵ.ɐ` | `FrameManager.current` | 壳单例 |
| `Ȱ` | `attach` | 绑定时间轴、注册任务 |
| `Ǵ` | `FrameAdapter` | FA 加载 UI 任务类 |

## 逐行说明

### 包与 import（L1–6）

无名包。导入 `MovieClip` 以及壳的 `ƒ.ǵ`、`ƒ.Ǵ`。不导入游戏包。

### 类声明（L8）

`public class BleachVSNaruto extends MovieClip`：与第一帧 SymbolClass 绑定。时间轴 3 帧（F1 文档类 / F2 `FB` / F3 `FC`），不是关卡。

### 构造（L10–14）

```actionscript
super();
ǵ.ɐ.Ȱ(this, Ǵ);
```

- `super()` 走 MovieClip 构造。
- `ǵ.ɐ` 是 FM 单例（构造期已存在；再 `new ǵ()` 会抛「不能被实例化」）。
- `Ȱ(this, Ǵ)`：把**当前时间轴**交给壳；`Ǵ` 进入任务队列第一项。`Ȱ` 上的 `[FrameTask(p2="ƃ", c2="FB", p3="ɕ", c3="ȑ")]` 还会再追加 `ƃ.FB`、`ɕ.ȑ`。
- 此后文档类不再执行任何逻辑；加载条、配置门、游戏实例都由后续 FrameTask 完成。
