# `FighterVoice` — 角色语音槽下标

一句话目的：`FighterVoiceCtrler.playVoice(int)` 的槽号。引擎调用写数字 `0/1/2`，**不引用本类名**。时间轴 `setVoice(slot, Class[])` 用同一套下标。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/fighter/ctrler/FighterVoice.as`（18 行）

## Callers / callees

- **运行时**：`FighterMcCtrler` 受击：
  - 重击且活着 → `playVoice(0, 0.5)`（50% 概率轻受击）
  - 击飞 → `playVoice(1, 1)`
  - 死亡两处 → `playVoice(2, 1)`
- **注册**：角色时间轴经 `$fighter_ctrler` → `FighterCtrler` → `FighterVoiceCtrler.setVoice(int, Array)`。
- **本类**：主包零 import。与 `FighterDefenseType` 同类「给 FLA 作者看的枚举」。

## 逐行说明

### 常量（L6–10）

| 值 | 名 | 何时播 |
|----|----|--------|
| 0 | `HURT` | 重击受击，50% |
| 1 | `HURT_FLY` | 击飞 |
| 2 | `DIE` | 死亡动画 |

### 空构造（L12–15）

全静态。
