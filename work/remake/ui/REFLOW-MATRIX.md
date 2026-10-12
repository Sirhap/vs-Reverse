# UI / 引擎脚本回流矩阵（Phase D1 · G3）

| 项 | 值 |
|----|----|
| 权威 import | `import-rev2`（与 `import-full-clean` 同 skip×9；REV2b 增量：BitmapText + stamp） |
| 对照 | `import-full/_type_changes.txt`（`:*` 意图）；`play/games/bvn-rev2/import-clean.log`（JPEXS SEVERE） |
| `.as` 候选 | **172** |
| `.as.skip` | **9**（明示 keep-ABC） |
| 回流（本轮判定） | **153** |
| 仍原 ABC（`-onerror ignore` 静默失败） | **19**（库类型 16 + 其它编译 3） |
| 盘点时间 | 2026-10-11 17:48 CST（UTC+8） |
| 样本 | `/workspace/bvn-3.3/main.swf` **未改** |

三类标签：**回流** = 已成功 import 进包；**仍原ABC** = 源树有 `.as` 但 JPEXS 编不过、原 ABC 保留；**skip** = 故意不 import（`.as.skip`）。

---

## 1) skip×9 — 明示 keep-ABC（loader / ZIP）

禁止误 import；弄死 ZIP/加载。与 FULL-CLEAN / REV2 BUILD 一致。

| # | 类 | 路径（`.as.skip`） | 原因 |
|---|----|-------------------|------|
| 1 | `AssetLoader` | `net/play5d/game/bvn/ctrl/AssetLoader.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 2 | `AssetManager` | `net/play5d/game/bvn/ctrl/AssetManager.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 3 | `GameLoader` | `net/play5d/game/bvn/ctrl/GameLoader.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 4 | `IAssetLoader` | `net/play5d/game/bvn/interfaces/IAssetLoader.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 5 | `GameLoadingState` | `net/play5d/game/bvn/state/GameLoadingState.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 6 | `LoadingState` | `net/play5d/game/bvn/state/LoadingState.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 7 | `BitmapAssetLoader` | `net/play5d/game/bvn/utils/BitmapAssetLoader.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 8 | `ZipAssetLoader` | `net/play5d/game/bvn/web/ZipAssetLoader.as.skip` | loader/ZIP 资产链；必须原 ABC |
| 9 | `ZipCtrler` | `net/play5d/game/bvn/web/ZipCtrler.as.skip` | loader/ZIP 资产链；必须原 ABC |

---

## 2) 仍原ABC — import-clean.log SEVERE（`-onerror ignore`）

源在 `import-rev2`，但 JPEXS 未写入；包内仍是原版 ABC。改这些文件**不会进包**，除非先补库符号占位（D2）或改写 `:*`。

### 2a 库 MovieClip 类型缺失（G3/G11）

| 脚本 | 失败摘要 |
|------|----------|
| `net/play5d/game/bvn/state/CongratulateState.as` | `mc_win_all is not an existing type (L73)` |
| `net/play5d/game/bvn/state/GameOverState.as` | `select_arrow_mc is not an existing type (L29)` |
| `net/play5d/game/bvn/ui/SetBtn.as` | `txt_arrow_mc is not an existing type (L27)` |
| `net/play5d/game/bvn/ui/WinUI.as` | `winmc is not an existing type (L14)` |
| `net/play5d/game/bvn/ui/fight/EnergyBar.as` | `energy_bar is not an existing type (L21)` |
| `net/play5d/game/bvn/ui/fight/FightBar.as` | `hpbar_mc is not an existing type (L55)` |
| `net/play5d/game/bvn/ui/fight/FightFaceGroup.as` | `hpbar_facegroup is not an existing type (L17)` |
| `net/play5d/game/bvn/ui/fight/FightFaceUI.as` | `hpbar_facemc is not an existing type (L12)` |
| `net/play5d/game/bvn/ui/fight/FightScoreUI.as` | `score_mc is not an existing type (L13)` |
| `net/play5d/game/bvn/ui/fight/FightTimeUI.as` | `time_mc is not an existing type (L17)` |
| `net/play5d/game/bvn/ui/fight/FightUI.as` | `player_pos_p1 is not an existing type (L57)` |
| `net/play5d/game/bvn/ui/fight/FighterHpBar.as` | `hpbar_barmc is not an existing type (L26)` |
| `net/play5d/game/bvn/ui/fight/HitsUI.as` | `hits_mc is not an existing type (L18)` |
| `net/play5d/game/bvn/ui/fight/QiBar.as` | `qbar_mc is not an existing type (L45)` |
| `net/play5d/game/bvn/ui/select/MapSelectUI.as` | `select_map_txt_mc is not an existing type (L28)` |
| `net/play5d/game/bvn/ui/select/SelectedFighterUI.as` | `seltwzmc is not an existing type (L137)` |

**合计**：16

### 2b 其它编译失败（非库类型）

| 脚本 | 失败摘要 |
|------|----------|
| `net/play5d/game/bvn/fighter/FighterAttacker.as` | `Default value must be compiletime constant (L301)` |
| `net/play5d/game/bvn/fighter/ctrler/FighterAttackerCtrler.as` | `Default value must be compiletime constant (L120)` |
| `net/play5d/kyo/utils/KyoUtils.as` | `Default value must be compiletime constant (L802)` |

**合计**：3

---

## 3) 回流 — 其余引擎 `.as`

`import-rev2` 中 **153** 个 `.as` 未出现在上表 SEVERE，且非 skip → 判定为**已回流**（含 MenuBtn/MenuState BitmapText 修复、大量 `:*` 解耦脚本）。

按包统计（回流 / 仍原ABC / skip）：

| 目录 | 回流 | 仍原ABC | skip |
|------|------|---------|------|
| `net/play5d/game/bvn` | 4 | 0 | 0 |
| `net/play5d/game/bvn/ctrl` | 5 | 0 | 3 |
| `net/play5d/game/bvn/ctrl/game_ctrls` | 6 | 0 | 0 |
| `net/play5d/game/bvn/data` | 24 | 0 | 0 |
| `net/play5d/game/bvn/events` | 2 | 0 | 0 |
| `net/play5d/game/bvn/fighter` | 8 | 1 | 0 |
| `net/play5d/game/bvn/fighter/ctrler` | 9 | 1 | 0 |
| `net/play5d/game/bvn/fighter/ctrler/ai` | 2 | 0 | 0 |
| `net/play5d/game/bvn/fighter/events` | 2 | 0 | 0 |
| `net/play5d/game/bvn/fighter/models` | 2 | 0 | 0 |
| `net/play5d/game/bvn/fighter/utils` | 1 | 0 | 0 |
| `net/play5d/game/bvn/fighter/vos` | 2 | 0 | 0 |
| `net/play5d/game/bvn/input` | 4 | 0 | 0 |
| `net/play5d/game/bvn/interfaces` | 8 | 0 | 1 |
| `net/play5d/game/bvn/map` | 2 | 0 | 0 |
| `net/play5d/game/bvn/state` | 9 | 2 | 2 |
| `net/play5d/game/bvn/ui` | 14 | 2 | 0 |
| `net/play5d/game/bvn/ui/dialog` | 2 | 0 | 0 |
| `net/play5d/game/bvn/ui/fight` | 1 | 10 | 0 |
| `net/play5d/game/bvn/ui/select` | 6 | 2 | 0 |
| `net/play5d/game/bvn/utils` | 6 | 0 | 1 |
| `net/play5d/game/bvn/views/effects` | 9 | 0 | 0 |
| `net/play5d/game/bvn/web` | 3 | 0 | 2 |
| `net/play5d/kyo` | 1 | 0 | 0 |
| `net/play5d/kyo/display` | 2 | 0 | 0 |
| `net/play5d/kyo/display/bitmap` | 3 | 0 | 0 |
| `net/play5d/kyo/display/shapes` | 1 | 0 | 0 |
| `net/play5d/kyo/input` | 2 | 0 | 0 |
| `net/play5d/kyo/loader` | 4 | 0 | 0 |
| `net/play5d/kyo/sound` | 1 | 0 | 0 |
| `net/play5d/kyo/stage` | 2 | 0 | 0 |
| `net/play5d/kyo/stage/effect` | 1 | 0 | 0 |
| `net/play5d/kyo/stage/events` | 1 | 0 | 0 |
| `net/play5d/kyo/utils` | 4 | 1 | 0 |

### 回流清单（完整）

<details><summary>展开 153 条</summary>

- `net/play5d/game/bvn/Debugger.as`
- `net/play5d/game/bvn/GameConfig.as`
- `net/play5d/game/bvn/GameQuailty.as`
- `net/play5d/game/bvn/MainGame.as`
- `net/play5d/game/bvn/ctrl/EffectCtrl.as`
- `net/play5d/game/bvn/ctrl/GameLogic.as`
- `net/play5d/game/bvn/ctrl/GameRender.as`
- `net/play5d/game/bvn/ctrl/SoundCtrl.as`
- `net/play5d/game/bvn/ctrl/StateCtrl.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/FighterEventCtrl.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/GameCtrl.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/GameEndCtrl.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/GameMainLogicCtrler.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/GameStartCtrl.as`
- `net/play5d/game/bvn/ctrl/game_ctrls/TrainingCtrler.as`
- `net/play5d/game/bvn/data/AssisterModel.as`
- `net/play5d/game/bvn/data/BitmapDataCacheVO.as`
- `net/play5d/game/bvn/data/ConfigVO.as`
- `net/play5d/game/bvn/data/EffectModel.as`
- `net/play5d/game/bvn/data/EffectVO.as`
- `net/play5d/game/bvn/data/FighterModel.as`
- `net/play5d/game/bvn/data/FighterVO.as`
- `net/play5d/game/bvn/data/GameData.as`
- `net/play5d/game/bvn/data/GameMode.as`
- `net/play5d/game/bvn/data/GameRunDataVO.as`
- `net/play5d/game/bvn/data/GameRunFighterGroup.as`
- `net/play5d/game/bvn/data/HitType.as`
- `net/play5d/game/bvn/data/KeyConfigVO.as`
- `net/play5d/game/bvn/data/MapModel.as`
- `net/play5d/game/bvn/data/MapVO.as`
- `net/play5d/game/bvn/data/MessionModel.as`
- `net/play5d/game/bvn/data/MessionStageVO.as`
- `net/play5d/game/bvn/data/MessionVO.as`
- `net/play5d/game/bvn/data/SelectCharListConfigVO.as`
- `net/play5d/game/bvn/data/SelectCharListItemVO.as`
- `net/play5d/game/bvn/data/SelectStageConfigVO.as`
- `net/play5d/game/bvn/data/SelectVO.as`
- `net/play5d/game/bvn/data/TeamMap.as`
- `net/play5d/game/bvn/data/TeamVO.as`
- `net/play5d/game/bvn/events/GameEvent.as`
- `net/play5d/game/bvn/events/SetBtnEvent.as`
- `net/play5d/game/bvn/fighter/Assister.as`
- `net/play5d/game/bvn/fighter/Bullet.as`
- `net/play5d/game/bvn/fighter/FighterAction.as`
- `net/play5d/game/bvn/fighter/FighterActionState.as`
- `net/play5d/game/bvn/fighter/FighterDefenseType.as`
- `net/play5d/game/bvn/fighter/FighterHitRange.as`
- `net/play5d/game/bvn/fighter/FighterMC.as`
- `net/play5d/game/bvn/fighter/FighterMain.as`
- `net/play5d/game/bvn/fighter/ctrler/AssisiterCtrler.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterAICtrl.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterBuffCtrler.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterCtrler.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterEffectCtrl.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterKeyCtrl.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterMcCtrler.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterVoice.as`
- `net/play5d/game/bvn/fighter/ctrler/FighterVoiceCtrler.as`
- `net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogic.as`
- `net/play5d/game/bvn/fighter/ctrler/ai/FighterAILogicBase.as`
- `net/play5d/game/bvn/fighter/events/FighterEvent.as`
- `net/play5d/game/bvn/fighter/events/FighterEventDispatcher.as`
- `net/play5d/game/bvn/fighter/models/FighterHitModel.as`
- `net/play5d/game/bvn/fighter/models/HitVO.as`
- `net/play5d/game/bvn/fighter/utils/McAreaCacher.as`
- `net/play5d/game/bvn/fighter/vos/FighterBuffVO.as`
- `net/play5d/game/bvn/fighter/vos/MoveTargetParamVO.as`
- `net/play5d/game/bvn/input/GameInputType.as`
- `net/play5d/game/bvn/input/GameInputer.as`
- `net/play5d/game/bvn/input/GameKeyInput.as`
- `net/play5d/game/bvn/input/IGameInput.as`
- `net/play5d/game/bvn/interfaces/BaseGameSprite.as`
- `net/play5d/game/bvn/interfaces/GameInterface.as`
- `net/play5d/game/bvn/interfaces/IExtendConfig.as`
- `net/play5d/game/bvn/interfaces/IFighterActionCtrl.as`
- `net/play5d/game/bvn/interfaces/IGameInterface.as`
- `net/play5d/game/bvn/interfaces/IGameSprite.as`
- `net/play5d/game/bvn/interfaces/IInnerSetUI.as`
- `net/play5d/game/bvn/interfaces/ILoger.as`
- `net/play5d/game/bvn/map/FloorVO.as`
- `net/play5d/game/bvn/map/MapMain.as`
- `net/play5d/game/bvn/state/CreditsState.as`
- `net/play5d/game/bvn/state/GameCamera.as`
- `net/play5d/game/bvn/state/GameState.as`
- `net/play5d/game/bvn/state/HowToPlayState.as`
- `net/play5d/game/bvn/state/LogoState.as`
- `net/play5d/game/bvn/state/MenuState.as`
- `net/play5d/game/bvn/state/SelectFighterStage.as`
- `net/play5d/game/bvn/state/SettingState.as`
- `net/play5d/game/bvn/state/WinnerState.as`
- `net/play5d/game/bvn/ui/GameUI.as`
- `net/play5d/game/bvn/ui/IGameUI.as`
- `net/play5d/game/bvn/ui/KeyMapping.as`
- `net/play5d/game/bvn/ui/MenuBtn.as`
- `net/play5d/game/bvn/ui/MenuBtnGroup.as`
- `net/play5d/game/bvn/ui/MoveListSp.as`
- `net/play5d/game/bvn/ui/PauseDialog.as`
- `net/play5d/game/bvn/ui/QuickTransUI.as`
- `net/play5d/game/bvn/ui/SetBtnDialog.as`
- `net/play5d/game/bvn/ui/SetBtnGroup.as`
- `net/play5d/game/bvn/ui/SetBtnLine.as`
- `net/play5d/game/bvn/ui/SetCtrlBtnUI.as`
- `net/play5d/game/bvn/ui/TransUI.as`
- `net/play5d/game/bvn/ui/UIUtils.as`
- `net/play5d/game/bvn/ui/dialog/AlertUI.as`
- `net/play5d/game/bvn/ui/dialog/ConfrimUI.as`
- `net/play5d/game/bvn/ui/fight/FightQiBarMode.as`
- `net/play5d/game/bvn/ui/select/SelectFighterItem.as`
- `net/play5d/game/bvn/ui/select/SelectIndexUI.as`
- `net/play5d/game/bvn/ui/select/SelectIndexUIGroup.as`
- `net/play5d/game/bvn/ui/select/SelectUIFactory.as`
- `net/play5d/game/bvn/ui/select/SelectedFighterGroup.as`
- `net/play5d/game/bvn/ui/select/SelecterItemUI.as`
- `net/play5d/game/bvn/utils/EffectManager.as`
- `net/play5d/game/bvn/utils/GameLoger.as`
- `net/play5d/game/bvn/utils/GameUtils.as`
- `net/play5d/game/bvn/utils/KeyBoarder.as`
- `net/play5d/game/bvn/utils/MCUtils.as`
- `net/play5d/game/bvn/utils/ResUtils.as`
- `net/play5d/game/bvn/views/effects/BishaFaceEffectView.as`
- `net/play5d/game/bvn/views/effects/BitmapFilterView.as`
- `net/play5d/game/bvn/views/effects/BlackBackView.as`
- `net/play5d/game/bvn/views/effects/BuffEffectView.as`
- `net/play5d/game/bvn/views/effects/EffectView.as`
- `net/play5d/game/bvn/views/effects/ShadowEffectView.as`
- `net/play5d/game/bvn/views/effects/ShineEffectView.as`
- `net/play5d/game/bvn/views/effects/SpecialEffectView.as`
- `net/play5d/game/bvn/views/effects/SteelHitEffect.as`
- `net/play5d/game/bvn/web/Ctrler4399.as`
- `net/play5d/game/bvn/web/GameInterfaceManager.as`
- `net/play5d/game/bvn/web/SubmitScoreBtn.as`
- `net/play5d/kyo/KyoSharedObject.as`
- `net/play5d/kyo/display/BitmapText.as`
- `net/play5d/kyo/display/MCNumber.as`
- `net/play5d/kyo/display/bitmap/BitmapFont.as`
- `net/play5d/kyo/display/bitmap/BitmapFontLoader.as`
- `net/play5d/kyo/display/bitmap/BitmapFontText.as`
- `net/play5d/kyo/display/shapes/Box.as`
- `net/play5d/kyo/input/KyoKeyCode.as`
- `net/play5d/kyo/input/KyoKeyVO.as`
- `net/play5d/kyo/loader/BitmapLoader.as`
- `net/play5d/kyo/loader/KyoClassLoader.as`
- `net/play5d/kyo/loader/KyoSoundLoader.as`
- `net/play5d/kyo/loader/KyoURLoader.as`
- `net/play5d/kyo/sound/KyoBGSounder.as`
- `net/play5d/kyo/stage/Istage.as`
- `net/play5d/kyo/stage/KyoStageCtrl.as`
- `net/play5d/kyo/stage/effect/IStageFadEffect.as`
- `net/play5d/kyo/stage/events/KyoStageEvent.as`
- `net/play5d/kyo/utils/KyoMath.as`
- `net/play5d/kyo/utils/KyoRandom.as`
- `net/play5d/kyo/utils/UUID.as`
- `net/play5d/kyo/utils/setFrameOut.as`

</details>

---

## 4) 与 `:*` / type_changes 的关系

- `import-full/_type_changes.txt` 记录了把库类型改成 `:*` 的意图；**rev2/full-clean 未完整应用**，故上表 2a 仍失败。
- 已成功用 `:*` 的脚本（如 `MenuState._ui:*`、`SelectFighterStage`、`SelecterItemUI`）归入**回流**。
- D2 空子类占位落地后，应重跑 import **不带** `-onerror ignore`（或报表强制非零 SEVERE=失败），把 2a 转为回流。

---

## 5) 嵌套 UI SWF（SymbolClass×73）

8 个 UI BinaryData（225–229, 2210, 2211, 2215）内的库脚本**不在** `import-rev2` 树；引擎通过 `ResUtils.createDisplayObject` 取符号。改库艺术/时间轴 → D3 外置替换；改引擎逻辑 → 本矩阵。

交叉池×4（引擎 pool ≠ SymbolClass home，实际在 **loading**）：见 `stubs/CROSS-POOL.md` / `work/full-analysis/ui/INDEX.md`。

---

## 6) 验收用法

```bash
# 每次 import 后：把 JPEXS 日志与本矩阵 diff
rg 'SEVERE:' play/games/<build>/import-clean.log
# 期望：库类型 SEVERE → 0（D2 占位后）；skip×9 仍为 .as.skip
```

未改 `main.swf`。
