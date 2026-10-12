# StartSound 帧→声名索引（Phase C / G7）

| 项 | 值 |
|----|----|
| 产出日 | 2026-10-11 17:45 CST（UTC+8） |
| 范围 | `assets/fighter/*.swf`×41（可玩 40 + 额外 `sasuke_xz_old`）；辅助抽样×8 |
| 解析 | SWF tag 14 DefineSound / 15 StartSound / 89 StartSound2 / 43 FrameLabel / 76 SymbolClass / 39 DefineSprite |
| 命名 | SymbolClass 优先 → effect/他包 sha1 交叉 → 否则 `cid:<id>`（多数时间轴音未导出类名） |
| 证据 | `work/remake/audio/fighters/*.startsound.json` |
| 约束 | **未改** `main.swf` |

## 方法说明

1. 解压 CWS，遍历根时间轴与每个 `DefineSprite` 内嵌标签。
2. `ShowFrame` 累计帧号；`StartSound`/`StartSound2` 归属当前正在构建的帧（`frames+1`）。
3. 同精灵内最近的 `FrameLabel`（`frame ≤ 事件帧`）记为 `label`。
4. 主动作剪辑 = 非 `stop` 标签最多的 sprite（与 Phase5 一致）。
5. 声名：
   - `SymbolClass` 导出名（常见仅 `snd_hurt*` / `bsface*`）
   - 或 DefineSound body sha1 与 `effect.swf` / 其他角色已导出名交叉（如 `snd_jump`/`snd_cbs`）
   - 否则稳定别名 `cid:<characterId>` + sha1（换皮时按哈希对齐）

**注意**：时间轴 `StartSound` 几乎全部指向**未**挂 SymbolClass 的 DefineSound；
AS3 `defineHurtSound(snd_hurt1)` 等走类实例，不在本表。与 `SOUND-CATALOG.md`（主包/预载）无矛盾。

## fighter/*.swf ×41 汇总（含 sasuke_xz_old）

| id | DefineSound | StartSound 事件 | 已命名 | 未命名 | 主动作 clip | 主动作事件 |
|----|------------:|----------------:|-------:|-------:|-------------|-----------:|
| `aizen` | 26 | 49 | 1 | 48 | `aizen_fla.蓝染全动作_1` (id=638) | 49 |
| `byakuya` | 36 | 58 | 1 | 57 | `byakuya_fla.一护万解全动作_1` (id=640) | 31 |
| `chad` | 16 | 36 | 0 | 36 | `chad_fla.一护万解全动作_1` (id=541) | 36 |
| `didala` | 21 | 51 | 1 | 50 | `didala_fla.Timeline_1` (id=524) | 48 |
| `gaara` | 23 | 47 | 2 | 45 | `gaara_fla.Timeline_1` (id=500) | 35 |
| `grimmjow` | 38 | 44 | 1 | 43 | `grimmjow_fla.一护全动作_1` (id=515) | 44 |
| `ichigo` | 70 | 180 | 7 | 173 | `ichigo_fla.一护全动作_30` (id=1855) | 54 |
| `ichigo_zero` | 51 | 119 | 5 | 114 | `ichigo_zero_fla.白一护全动作_11` (id=729) | 51 |
| `ikkaku` | 21 | 42 | 1 | 41 | `ikkaku_fla.鸣人全动作_1` (id=437) | 42 |
| `itachi` | 30 | 57 | 1 | 56 | `itachi_fla.卡卡西_1` (id=566) | 40 |
| `jiraiya` | 22 | 40 | 0 | 40 | `jiraiya_fla.自来也全动作_1` (id=371) | 38 |
| `juggo` | 24 | 54 | 3 | 51 | `juggo_fla.迪达拉全动作_XIN_1` (id=505) | 52 |
| `kakashi` | 12 | 39 | 2 | 37 | `kakashi_fla.Timeline_1` (id=642) | 38 |
| `kakashi_sw` | 23 | 61 | 0 | 61 | `kakashi_sw_fla.人物全动作_1` (id=551) | 59 |
| `karin` | 20 | 49 | 1 | 48 | `karin_fla.卡卡西_1` (id=425) | 47 |
| `kenpachi` | 18 | 48 | 0 | 48 | `kenpachi_fla.剑八全动作_1` (id=503) | 48 |
| `kenshin` | 39 | 91 | 2 | 89 | `kenshin_fla.全动作_15` (id=1411) | 51 |
| `killerbee` | 33 | 58 | 1 | 57 | `killerbee_fla.八尾人柱力全动作_1` (id=759) | 58 |
| `konan` | 17 | 34 | 1 | 33 | `konan_fla.卡卡西_1` (id=561) | 32 |
| `lee` | 38 | 117 | 1 | 116 | `lee_fla.小李杜门_10` (id=1102) | 76 |
| `madara` | 32 | 47 | 0 | 47 | `madara_fla.鸣人全动作_1` (id=906) | 46 |
| `mayuri` | 30 | 48 | 2 | 46 | `mayuri_fla.Timeline_1` (id=474) | 46 |
| `naruto` | 21 | 139 | 6 | 133 | `naruto_fla.鸣人全动作_1` (id=737) | 54 |
| `naruto_xr` | 39 | 105 | 0 | 105 | `naruto_xr_fla.鸣人全动作副本_16` (id=1256) | 52 |
| `neji` | 27 | 44 | 1 | 43 | `neji_fla.一护全动作_1` (id=539) | 44 |
| `obito` | 36 | 84 | 0 | 84 | `obito_fla.鸣人全动作_14` (id=1097) | 53 |
| `orihime` | 18 | 40 | 0 | 40 | `orihime_fla.织姬全动作_1` (id=503) | 39 |
| `orochimaru` | 26 | 49 | 1 | 48 | `orochimaru_fla.一护全动作_1` (id=559) | 49 |
| `pain` | 18 | 46 | 1 | 45 | `pain_fla.佩恩_1` (id=622) | 30 |
| `renji` | 17 | 34 | 1 | 33 | `renji_fla.一护全动作_1` (id=696) | 34 |
| `rukia` | 26 | 68 | 1 | 67 | `rukia_fla.露琪雅_1` (id=499) | 31 |
| `sakura` | 13 | 42 | 2 | 40 | `sakura_fla.樱_1` (id=629) | 41 |
| `sasuke` | 25 | 100 | 2 | 98 | `sasuke_fla.佐助_1` (id=548) | 59 |
| `sasuke_xz` | 26 | 44 | 2 | 42 | `sasuke_xz_fla.须作_1` (id=602) | 44 |
| `sasuke_xz_old` | 29 | 51 | 3 | 48 | `sasuke_xz_old_fla.Timeline_1` (id=739) | 51 |
| `soifon` | 24 | 55 | 1 | 54 | `soifon_fla.碎蜂全动作_1` (id=492) | 53 |
| `temari` | 24 | 30 | 0 | 30 | `temari_fla.佐助咒化_1` (id=505) | 30 |
| `toushirou` | 33 | 70 | 2 | 68 | `toushirou_fla.万解全动作_8` (id=894) | 37 |
| `ulquiorra` | 25 | 59 | 1 | 58 | `ulquiorra_fla.一护虚化全动作副本_9` (id=814) | 28 |
| `uryuu` | 30 | 43 | 1 | 42 | `uryuu_fla.Timeline_1` (id=387) | 42 |
| `yin` | 22 | 43 | 1 | 42 | `yin_fla.Timeline_1` (id=435) | 43 |

**合计**：DefineSound **1119**；StartSound 事件 **2515**；其中可解析名 **59**（2.3%）；其余为 `cid:*`。

## 辅助抽样

| id | DefineSound | StartSound | named |
|----|------------:|-----------:|------:|
| `fz/byakuya` | 2 | 2 | 0 |
| `fz/itachi` | 2 | 5 | 0 |
| `fz/madara` | 3 | 3 | 0 |
| `fz/minato` | 5 | 8 | 1 |
| `fz/gaara` | 2 | 2 | 0 |
| `fz/yoruichi` | 1 | 1 | 0 |
| `fz/grimmjow` | 4 | 5 | 0 |
| `fz/temari` | 2 | 2 | 0 |

## JSON 样例（完整事件表）

下列角色写出**全量** `events`（其余可玩为 slim：`actionEvents` + `eventsSample`）：

- `fighters/aizen.startsound.json`
- `fighters/gaara.startsound.json`
- `fighters/ichigo.startsound.json`
- `fighters/kakashi.startsound.json`
- `fighters/kenpachi.startsound.json`
- `fighters/lee.startsound.json`
- `fighters/madara.startsound.json`
- `fighters/naruto.startsound.json`
- `fighters/obito.startsound.json`
- `fighters/rukia.startsound.json`
- `fighters/sasuke.startsound.json`
- `fighters/ulquiorra.startsound.json`

### 字段

| 字段 | 含义 |
|------|------|
| `frame` | 1-based 时间轴帧 |
| `label` | 同 clip 最近 FrameLabel |
| `soundId` | DefineSound 角色 ID |
| `soundName` | 解析名或 `cid:N` |
| `nameSource` | `SymbolClass` / `sha1-cross` / `unnamed` / `StartSound2` |
| `spriteId` / `spriteExport` | 所在 DefineSprite |

## 与 SOUND-CATALOG / effect snd

- 主包嵌入音（菜单/KO 等）见 `work/full-analysis/engine/SOUND-CATALOG.md` — 不在 fighter SWF。
- `effect.swf` 31 个 `snd_*` 全部 SymbolClass 导出；本索引交叉命中时 `nameSource=sha1-cross`。
- effect 遗留 orphan 音（`snd_hit1`/`snd_hit10`/`snd_fzbs`/`snd_xdash`）见 `work/remake/effects/LEGACY-12.md`。

## Chinese summary

已对 fighter 目录 41 个 SWF（可玩 40 + sasuke_xz_old）二进制展开 StartSound：帧+最近标签→soundId/声名；
事件合计 2515，命名命中 59（SymbolClass 或与 effect 哈希对齐），其余稳定 `cid:`。
样例 JSON 已落盘；辅助 8 个抽样。未改 main.swf。
