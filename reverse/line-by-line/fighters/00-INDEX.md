# 角色 SWF line-by-line 总索引 — `decompiled/fighters`

壳：[`../shell/00-INDEX.md`](../shell/00-INDEX.md)。引擎 `net.play5d`：[`../engine/00-INDEX.md`](../engine/00-INDEX.md)（A–D 已闭合）。

本目录注 **角色 / 助战 SWF 时间轴**（`decompiled/fighters/**/scripts/**.as`）。镜像路径：`decompiled/fighters/` 之后原样换成 `.md`。不改 `decompiled/`。UI SWF 见 [`../ui/00-INDEX.md`](../ui/00-INDEX.md)（已闭合）。

**状态：Batch A–G done。主战花名册闭合。UI SWF 已注。特效 SWF：[`../effect/00-INDEX.md`](../effect/00-INDEX.md)（89/89 done）。不要重开本批。**

对照总表（非逐行）：[`../../03-fighters.md`](../../03-fighters.md)。XML：`extracted/assets/config/fighter.xml`、`assist.xml`。

## 批次

| 批 | 范围 | `.as` | 索引 | 状态 |
|----|------|------|------|------|
| A | `aizen` `byakuya` `chad` `didala` + 全部 `fz/**` 助战 | 73 | [`00-BATCH-A-INDEX.md`](00-BATCH-A-INDEX.md) | **done** |
| B | `gaara` `grimmjow` `ichigo` `ichigo_zero` | 67 | [`00-BATCH-B-INDEX.md`](00-BATCH-B-INDEX.md) | **done** |
| C | `ikkaku` `itachi` `jiraiya` `juggo` `kakashi` `kakashi_sw` `karin` | 62 | [`00-BATCH-C-INDEX.md`](00-BATCH-C-INDEX.md) | **done** |
| D | `kenpachi` `kenshin` `killerbee` `konan` `lee` `madara` `mayuri` | 63 | [`00-BATCH-D-INDEX.md`](00-BATCH-D-INDEX.md) | **done** |
| E | `naruto` `naruto_xr` `neji` `obito` `orihime` | 67 | [`00-BATCH-E-INDEX.md`](00-BATCH-E-INDEX.md) | **done** |
| F | `orochimaru` `pain` `renji` `rukia` `sakura` `sasuke` `sasuke_xz` | 68 | [`00-BATCH-F-INDEX.md`](00-BATCH-F-INDEX.md) | **done** |
| G | `sasuke_xz_old` `soifon` `temari` `toushirou` `ulquiorra` `uryuu` `yin` | 68 | [`00-BATCH-G-INDEX.md`](00-BATCH-G-INDEX.md) | **done** |

清单源：[`../_maps/fighters-batch-A-files.txt`](../_maps/fighters-batch-A-files.txt) … `fighters-batch-G-files.txt`。

`fz/**` 全部收在 A 批（助战 SWF，MainTimeline 短）。G 收完主战花名册剩余目录（含遗留 `sasuke_xz_old`）。不要把 `fz/` 再注一遍。

## 角色 SWF 怎么接到引擎

```
LoadingState + GameLoader
  loadFighter  → new FighterMain(mc) + FighterVO
  loadAssister → new Assister(mc)
GameCtrl.addFighter
  FighterMain.initlize
    setFighterCtrler / setEffectCtrler / setFighterMcCtrler
    gotoAndStop(startFrame+1)     // XML sf=1 → 时间轴 F2
    initMc(this.mc)               // 动作 MC → FighterMC
  之后每帧 FighterMcCtrler.render
    时间轴 parent.$mc_ctrler.setAttack / fire / addAttacker …
```

助战不走 `FighterMain`：`Assister` 构造就 `setAssistCtrler`；满 `fzqi` 才 `goFight()` 从第 2 帧播。

A 批模式备忘（AI 面 / 全动作 / face / hurt sound）写在 [`00-BATCH-A-INDEX.md`](00-BATCH-A-INDEX.md)。B 批（我爱罗 / 葛力姆乔 / 一护四形态 / 零段三形态）写在 [`00-BATCH-B-INDEX.md`](00-BATCH-B-INDEX.md)。C 批（一角 / 鼬 / 自来也 / 重吾 / 卡卡西 / 神威 / 香磷）写在 [`00-BATCH-C-INDEX.md`](00-BATCH-C-INDEX.md)。D 批（剑八 / 剑心两形态 / 奇拉比 / 小南 / 小李两形态 / 斑 / 涅茧利）写在 [`00-BATCH-D-INDEX.md`](00-BATCH-D-INDEX.md)。E 批（鸣人三形态 / 仙人黄金 / 宁次 / 带土两形态 / 织姬）写在 [`00-BATCH-E-INDEX.md`](00-BATCH-E-INDEX.md)。F 批（大蛇丸 / 佩恩 / 恋次 / 露琪亚两形态 / 樱 / 佐助两形态 / 须佐能乎）写在 [`00-BATCH-F-INDEX.md`](00-BATCH-F-INDEX.md)。G 批（须佐旧档 / 碎蜂 / 手鞠 / 东狮郎两形态 / 乌尔奇奥拉两形态 / 雨龙 / 银）写在 [`00-BATCH-G-INDEX.md`](00-BATCH-G-INDEX.md)。

## 不要重开

- 不要把 `fz/` 或主战 A–G 再注一遍
- 不要把 `decompiled/ui/**` 再注一遍
- 特效已闭合：[`../effect/00-INDEX.md`](../effect/00-INDEX.md)
