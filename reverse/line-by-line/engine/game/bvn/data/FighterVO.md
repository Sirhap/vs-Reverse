# `FighterVO` — 角色/辅助的 XML 元数据

一句话目的：id、显示名、漫画阵营、SWF 与头像 URL、开场帧、BGM、关系与胜利台词。主角表和辅助表共用。运行时 `FighterMain.data` / `Assister.data` 持有同一类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/FighterVO.as`（85 行）

## Callers / callees

- **创建**：`FighterModel` / `AssisterModel.initByXML`。
- **持有**：`FighterMain.data`、`Assister.data`、`GameRunFighterGroup` 的 fighter1/2/3 数据、`GameRunDataVO.lastLoserData`、选人 UI 各项。
- **读字段**：
  - `GameLoader`：`fileUrl`、`startFrame`。
  - `AssetManager.getFighterFace*`：`faceUrl` / `faceBigUrl` / `faceBarUrl` / `faceWinUrl`。
  - `WinnerState`：`getRandSay()`。
  - `MessionModel`：`comicType` 选关卡线。
  - `SoundCtrl` / 进关：`bgm`、`bgmRate`。
- **Callees**：`KyoRandom.getRandomInArray`（台词）。

## 命名备注

`comic_type` XML 属性 → `comicType`。`bgm.@rate` 是百分数，代码 `/100` 成倍率。

`_cloneKey` **不含** `faceWinUrl`：`clone()` 会丢胜利头像路径。本包未见 `FighterVO.clone()` 调用方。

`startFrame != 0 && !bgm` 时 `trace` 警告——`startFrame!=0` 被当成「正式角色应有 BGM」的启发式。

## 逐行说明

### 字段（L8–36）

| 字段 | XML | 用途 |
|------|-----|------|
| `id` / `name` | `@id` `@name` | 选人 key / 显示 |
| `comicType` | `@comic_type` | 0/1 阵营，关卡线与随机池 |
| `fileUrl` | `file.@url` | 角色/辅助 SWF |
| `startFrame` | `file.@startFrame` | 库主时间轴起始帧 |
| `faceUrl` | `face.@url` | 选人头 |
| `faceBigUrl` | `face.@big_url` | 大头 |
| `faceBarUrl` | `face.@bar_url` | 血条头 |
| `faceWinUrl` | `face.@win_url` | 胜利图 |
| `contactFriends` / `contactEnemys` | `contact.friend/enemy` 逗号 | ? UI/对话，本批引擎少用 |
| `says` | `says.say_item` 文本 | 胜利随机句 |
| `bgm` / `bgmRate` | `bgm.@url` `@rate/100` | 出场 BGM |

### 构造（L38–41）

空。

### `initByXML`（L43–67）

按上表赋值。`says` 先 `[]` 再 push 每个 `say_item` 的 `children().toString()`。`contact*` 对空节点也会 `split(",")` 得到 `['']` 一类残值（?）。

`startFrame != 0 && !bgm` → `trace(id+"没有定义bgm!")`。辅助往往 `startFrame=0`，不警告。

### `getRandSay`（L69–72）

`KyoRandom.getRandomInArray(says)`。空数组时行为见 kyo（?）。`WinnerState` 用。

### `clone`（L74–82）

新 VO，只拷 `_cloneKey` 列出的字段。缺 `faceWinUrl`。本包无调用。
