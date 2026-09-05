# `GameQuailty` — 画质档位字符串枚举（类名拼错）

一句话目的：五个 `String` 常量，值是 `"low"` / `"medium"` / `"high"` / `"higher"` / `"best"`。本包 **没有任何 `GameQuailty.XXX` 引用**；`ConfigVO.quality` 和设置菜单用同名字面量。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/GameQuailty.as`（22 行）

## Callers / callees

- **Callers**：`decompiled` 下 grep `GameQuailty` 只命中本文件。运行时画质走 `ConfigVO.quality` 字符串 + `SetBtnGroup` 的 `optoinKey:"quality"`（那边也拼错 option）。
- **Callees**：无。

## 符号对照 / 命名备注

| 名 | 说明 |
|----|------|
| `GameQuailty` | 应为 Quality。保留原拼写。 |
| 五档 | 与 `ConfigVO.applyConfig` 的 `switch(quality)` case 一一对应。 |

`applyConfig` 映射（不在本文件，对照用）：

| 本类常量 | 舞台 `stage.quality` | `FPS_GAME` | `FPS_SHINE_EFFECT` | `EFFECT_SMOOTHING` |
|----------|----------------------|------------|--------------------|--------------------|
| LOW | low | 30 | 15 | false |
| MEDIUM | low | 60 | 30 | false |
| HIGH | medium | 60 | 30 | false |
| HIGHER | high | 60 | 30 | true |
| BEST | high | 60 | 60 | true |

壳 `bleachvsnaruto.initlize` 把出厂 quality 设成 `"medium"`，用来判断要不要塞 `UPDATE_INFO`。

## 逐行说明

### 常量（L6–14）

五个 `public static const String`。没有数字档、没有比较函数。

### 构造（L16–19）

空。只当常量命名空间。无需实例。
