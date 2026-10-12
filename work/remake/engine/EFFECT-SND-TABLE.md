# effect.swf 内嵌 snd_* ← EffectModel 调用表（G12 可选 / Phase E）

| 项 | 值 |
|----|----|
| 日期 | 2026-10-11 17:55 CST（UTC+8） |
| 源 | `decompiled/main/scripts/net/play5d/game/bvn/data/EffectModel.as` |
| EffectVO 行 | **52**（与 EffectModel×52 一致） |
| 带 sound | **39** |
| 唯一 snd_* | **27** |
| 播放链 | `SoundCtrl.playEffectSound` → `AssetManager.getEffect` → `Sound.play` |
| 再生 | `python3 tools/build_effect_snd_table.py` |
| main.swf | **未改** |

## 机制

`EffectVO.sound` 是 **effect.swf SymbolClass 导出名**（非主 SWF DefineSound id）。
主 SWF 嵌入音（`snd_menu*` / `snd_ko*` 等）见 `work/full-analysis/engine/SOUND-CATALOG.md`，不在本表。

## EffectModel → snd_*

| effectKey | kind | className | sound |
|-----------|------|-----------|-------|
| `bisha` | named | `XG_bs` | `snd_bs` |
| `bisha_super` | named | `XG_cbs` | `snd_cbs` |
| `dash` | named | `XG_rush` | `snd_dash_air` |
| `dash_air` | named | `XG_rush_air` | `snd_dash_air` |
| `jump` | named | `XG_jump` | `snd_jump` |
| `jump_air` | named | `XG_jump_air` | `snd_jump` |
| `touch_floor` | named | `XG_luodi` | `snd_luodi` |
| `hit_floor` | named | `XG_hitfloor` | `snd_hitfloor` |
| `hit_floor_low` | named | `xg_hitfloor_low` | `snd_hitfloor_low` |
| `hit_floor_heavy` | named | `xg_hitfllor_heavy` | `snd_hitfloor_heavy` |
| `hit_floor_yan` | named | `xg_hitfloor_yan` | — |
| `hit_end` | named | `xg_hitover` | — |
| `break_def` | named | `XG_mfdjx` | `snd_mfdjx` |
| `fz_bleach` | named | `XG_fz_bleach_mc` | `snd_dash` |
| `fz_naruto` | named | `XG_fz_naruto_mc` | `snd_fz` |
| `replaceSp` | named | `XG_tishen` | `snd_fz` |
| `replaceSp2` | named | `XG_tishen2` | — |
| `explodeSp` | named | `XG_bsq` | `snd_baoqi1` |
| `explodeSp2` | named | `XG_baoqi` | `snd_baoqi` |
| `ghost_step` | named | `XG_ghost_step` | `snd_ghost_step` |
| `kobg` | named | `kobg_effect_mc` | — |
| `fire_ing` | named | `xg_fire_ing` | — |
| `ice_ing` | named | `xg_ice_ing` | — |
| `shock_ing` | named | `xg_dian_ing` | — |
| `buff_effect_speed` | named | `xg_buff_effect_speed` | — |
| `buff_effect_power` | named | `xg_buff_effect_power` | — |
| `buff_effect_defense` | named | `xg_buff_effect_defense` | — |
| `buff_speed` | named | `xg_buff_speed` | — |
| `buff_power` | named | `xg_buff_power` | — |
| `buff_defense` | named | `xg_buff_defense` | — |
| `steel_hit_kan` | named | `XG_kan2` | `snd_hit11` |
| `steel_hit_qdj` | named | `XG_qdj` | `snd_hit11` |
| `steel_hit_mfdj` | named | `XG_mfdj` | `snd_hit11` |
| `hit_11` | hit | `xg_catch_hit` | `snd_hit_cache` |
| `hit_1` | hit | `XG_kan2` | `snd_kan1` |
| `hit_6` | hit | `XG_kanx2` | `snd_kan2` |
| `hit_2` | hit | `XG_qdj` | `snd_hit2` |
| `hit_3` | hit | `XG_qdjx` | `snd_hit_heavy` |
| `hit_4` | hit | `XG_mfdj` | `snd_hit2` |
| `hit_5` | hit | `XG_mfdjx` | `snd_mfdjx` |
| `hit_7` | hit | `XG_fire` | `snd_hit_fire` |
| `hit_8` | hit | `XG_ice` | `snd_hit_ice` |
| `hit_9` | hit | `XG_leidian` | `snd_hit_dian` |
| `defense_1` | defense | `XG_fykan` | `snd_fykan` |
| `defense_6` | defense | `XG_fykanx` | `snd_fykanx` |
| `defense_2` | defense | `XG_fyq` | `snd_def` |
| `defense_3` | defense | `XG_fyqx` | `snd_defx` |
| `defense_4` | defense | `XG_mffy` | `snd_def` |
| `defense_5` | defense | `XG_mffyx` | `snd_defx` |
| `defense_7` | defense | `XG_fire_fy` | `snd_defx` |
| `defense_8` | defense | `XG_ice_fy` | `snd_defx` |
| `defense_9` | defense | `XG_dian_fy` | `snd_defx` |

## 唯一 sound 集合（27）

`snd_baoqi`, `snd_baoqi1`, `snd_bs`, `snd_cbs`, `snd_dash`, `snd_dash_air`, `snd_def`, `snd_defx`, `snd_fykan`, `snd_fykanx`, `snd_fz`, `snd_ghost_step`, `snd_hit11`, `snd_hit2`, `snd_hit_cache`, `snd_hit_dian`, `snd_hit_fire`, `snd_hit_heavy`, `snd_hit_ice`, `snd_hitfloor`, `snd_hitfloor_heavy`, `snd_hitfloor_low`, `snd_jump`, `snd_kan1`, `snd_kan2`, `snd_luodi`, `snd_mfdjx`

## 无 sound 的 EffectVO（13）

`hit_floor_yan`, `hit_end`, `replaceSp2`, `kobg`, `fire_ing`, `ice_ing`, `shock_ing`, `buff_effect_speed`, `buff_effect_power`, `buff_effect_defense`, `buff_speed`, `buff_power`, `buff_defense`

## Legacy 导出 snd（不在 EffectModel）

见 `work/remake/effects/LEGACY-12.md`：**Keep** `snd_fzbs` `snd_hit1` `snd_hit10` `snd_xdash`（时间轴/遗留引用风险）。重制勿因「不在本表」而删。

## JSON

机器可读：`EFFECT-SND-TABLE.json`（同目录）。

未改 `/workspace/bvn-3.3/main.swf`。
