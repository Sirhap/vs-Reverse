# UI SymbolClass×73 空子类占位计划（Phase D2 · G3/G11）

| 项 | 值 |
|----|----|
| 源目录 | `work/full-analysis/ui/_dumps/*.symbolclass.tsv` + `ui/*.md` |
| 占位根 | `work/remake/ui/stubs/` |
| 已生成 `.as` | **73** / 73 |
| 优先验证 | **title** + **select**（本轮已落文件） |
| 短期策略 | 引擎侧继续 `:*` |
| 中期策略 | import 时让 JPEXS 看见同名空类，去掉库类型 SEVERE |
| 时间 | 2026-10-11 17:48 CST |

## 用法

1. 将 `stubs/<ui>/*.as` 纳入独立 ASC/FLA 类路径，**或**在引擎 import 前把对应空类拷入临时 classpath（JPEXS 同名类型解析）。
2. 空类 **不替代** 嵌套 SWF 内 SymbolClass 绑定；运行时显示对象仍来自 `ResUtils.I.<ui>` 池。
3. 交叉池符号：引擎 `createDisplayObject(select|fight, name)` 但导出在 **loading** — 见 `CROSS-POOL.md`；占位类放在 `stubs/loading/`，不要复制到 select/fight。
4. title+select 验收：改引擎文案/逻辑后 import，确认 `import-clean.log` 无 `stg_title`/`stg_select`/`select_*` 相关「not an existing type」。

## 按 UI 汇总

| UI | BinaryData id | exports | stubs 目录 |
|----|---------------|---------|------------|
| `common_ui` | 225 | 8 | `stubs/common_ui/` |
| `fight` | 226 | 33 | `stubs/fight/` |
| `gameover` | 227 | 1 | `stubs/gameover/` |
| `howtoplay` | 228 | 3 | `stubs/howtoplay/` |
| `loading` | 229 | 12 | `stubs/loading/` |
| `select` | 2210 | 8 | `stubs/select/` |
| `setting` | 2211 | 5 | `stubs/setting/` |
| `title` | 2215 | 3 | `stubs/title/` |

## 全表

| UI | charId | export | stub 文件 |
|----|--------|--------|-----------|
| `common_ui` | 0 | `common_ui_fla.MainTimeline` | `common_ui/common_ui_fla/MainTimeline.as` |
| `common_ui` | 13 | `common_ui_fla.wzimg_bgimg_5` | `common_ui/common_ui_fla/wzimg_bgimg_5.as` |
| `common_ui` | 26 | `logo_movie` | `common_ui/logo_movie.as` |
| `common_ui` | 25 | `mc_congratulations` | `common_ui/mc_congratulations.as` |
| `common_ui` | 20 | `mc_win_all` | `common_ui/mc_win_all.as` |
| `common_ui` | 14 | `mc_wzbtn` | `common_ui/mc_wzbtn.as` |
| `common_ui` | 8 | `select_arrow_mc` | `common_ui/select_arrow_mc.as` |
| `common_ui` | 5 | `trans_mc` | `common_ui/trans_mc.as` |
| `fight` | 244 | `bsface_mc` | `fight/bsface_mc.as` |
| `fight` | 101 | `energy_bar` | `fight/energy_bar.as` |
| `fight` | 100 | `energybar_barmc` | `fight/energybar_barmc.as` |
| `fight` | 97 | `fight_fla.energybar_bar_8` | `fight/fight_fla/energybar_bar_8.as` |
| `fight` | 90 | `fight_fla.energybar_txt_mc_3` | `fight/fight_fla/energybar_txt_mc_3.as` |
| `fight` | 194 | `fight_fla.game_start_mc_44` | `fight/fight_fla/game_start_mc_44.as` |
| `fight` | 54 | `fight_fla.qbar_txtmc_34` | `fight/fight_fla/qbar_txtmc_34.as` |
| `fight` | 162 | `fight_fla.round_num_mc_45` | `fight/fight_fla/round_num_mc_45.as` |
| `fight` | 123 | `fight_fla.winmc_bleach_22` | `fight/fight_fla/winmc_bleach_22.as` |
| `fight` | 84 | `fight_fla.元件10_4` | `fight/fight_fla/元件10_4.as` |
| `fight` | 89 | `fight_fla.元件11_6` | `fight/fight_fla/元件11_6.as` |
| `fight` | 28 | `fight_fla.元件12_10` | `fight/fight_fla/元件12_10.as` |
| `fight` | 187 | `fight_fla.元件25_46` | `fight/fight_fla/元件25_46.as` |
| `fight` | 30 | `hits_mc` | `fight/hits_mc.as` |
| `fight` | 243 | `hits_num_mc` | `fight/hits_num_mc.as` |
| `fight` | 112 | `hpbar_barmc` | `fight/hpbar_barmc.as` |
| `fight` | 118 | `hpbar_facegroup` | `fight/hpbar_facegroup.as` |
| `fight` | 117 | `hpbar_facemc` | `fight/hpbar_facemc.as` |
| `fight` | 136 | `hpbar_mc` | `fight/hpbar_mc.as` |
| `fight` | 222 | `player_pos_p1` | `fight/player_pos_p1.as` |
| `fight` | 219 | `player_pos_p2` | `fight/player_pos_p2.as` |
| `fight` | 57 | `qbar_barmc` | `fight/qbar_barmc.as` |
| `fight` | 45 | `qbar_barmcgroup` | `fight/qbar_barmcgroup.as` |
| `fight` | 72 | `qbar_facemc` | `fight/qbar_facemc.as` |
| `fight` | 65 | `qbar_fzqi_mc` | `fight/qbar_fzqi_mc.as` |
| `fight` | 78 | `qbar_mc` | `fight/qbar_mc.as` |
| `fight` | 135 | `score_mc` | `fight/score_mc.as` |
| `fight` | 132 | `time_mc` | `fight/time_mc.as` |
| `fight` | 24 | `time_txtmc` | `fight/time_txtmc.as` |
| `fight` | 3 | `txt_mc` | `fight/txt_mc.as` |
| `fight` | 216 | `txtmc_score` | `fight/txtmc_score.as` |
| `fight` | 195 | `ui_fight` | `fight/ui_fight.as` |
| `fight` | 124 | `winmc` | `fight/winmc.as` |
| `gameover` | 39 | `stg_gameover_mc` | `gameover/stg_gameover_mc.as` |
| `howtoplay` | 45 | `howtoplay_fla.arrow020321_6` | `howtoplay/howtoplay_fla/arrow020321_6.as` |
| `howtoplay` | 306 | `howtoplay_fla.元件48_11` | `howtoplay/howtoplay_fla/元件48_11.as` |
| `howtoplay` | 450 | `movie_howtoplay` | `howtoplay/movie_howtoplay.as` |
| `loading` | 105 | `cover_bgimg` | `loading/cover_bgimg.as` |
| `loading` | 106 | `loading_cover_mc` | `loading/loading_cover_mc.as` |
| `loading` | 104 | `loading_fight_mc` | `loading/loading_fight_mc.as` |
| `loading` | 0 | `loading_fla.MainTimeline` | `loading/loading_fla/MainTimeline.as` |
| `loading` | 45 | `loading_fla.元件8_17` | `loading/loading_fla/元件8_17.as` |
| `loading` | 99 | `loading_select_ui_mc` | `loading/loading_select_ui_mc.as` |
| `loading` | 98 | `loadingbar_mc` | `loading/loadingbar_mc.as` |
| `loading` | 76 | `select_arrow_mc_1` | `loading/select_arrow_mc_1.as` |
| `loading` | 73 | `select_arrow_mc_2` | `loading/select_arrow_mc_2.as` |
| `loading` | 85 | `seltwzmc` | `loading/seltwzmc.as` |
| `loading` | 70 | `winner_stg_mc` | `loading/winner_stg_mc.as` |
| `loading` | 69 | `winner_stg_mc2` | `loading/winner_stg_mc2.as` |
| `select` | 81 | `ctmc` | `select/ctmc.as` |
| `select` | 106 | `select_item_mc` | `select/select_item_mc.as` |
| `select` | 100 | `select_map_mc` | `select/select_map_mc.as` |
| `select` | 90 | `select_map_txt_mc` | `select/select_map_txt_mc.as` |
| `select` | 87 | `selected_item_p1_mc` | `select/selected_item_p1_mc.as` |
| `select` | 84 | `selected_item_p2_mc` | `select/selected_item_p2_mc.as` |
| `select` | 79 | `slt_item_mc` | `select/slt_item_mc.as` |
| `select` | 75 | `stg_select` | `select/stg_select.as` |
| `setting` | 44 | `key_set_dialog_mc` | `setting/key_set_dialog_mc.as` |
| `setting` | 38 | `keyset_mc` | `setting/keyset_mc.as` |
| `setting` | 8 | `setting_fla.元件1_13` | `setting/setting_fla/元件1_13.as` |
| `setting` | 9 | `stg_set_ui` | `setting/stg_set_ui.as` |
| `setting` | 3 | `txt_arrow_mc` | `setting/txt_arrow_mc.as` |
| `title` | 66 | `stg_test` | `title/stg_test.as` |
| `title` | 64 | `stg_title` | `title/stg_title.as` |
| `title` | 19 | `title_fla.logomc_3` | `title/title_fla/logomc_3.as` |

## title / select 本轮文件

### title
- `title/stg_test.as`
- `title/stg_title.as`
- `title/title_fla/logomc_3.as`

### select
- `select/ctmc.as`
- `select/select_item_mc.as`
- `select/select_map_mc.as`
- `select/select_map_txt_mc.as`
- `select/selected_item_p1_mc.as`
- `select/selected_item_p2_mc.as`
- `select/slt_item_mc.as`
- `select/stg_select.as`

未改 `main.swf`。
