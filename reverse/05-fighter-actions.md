# 05 角色招式全表

从 `decompiled/fighters/**/MainTimeline.as` 抽出全部 `defineAction(id, {…})`。
对照 `extracted/assets/config/fighter.xml` 与 `assist.xml`。

引擎：`FighterMain.initlize()` 执行 `_mainMc.gotoAndStop(data.startFrame + 1)`，
因此 XML `startFrame=N` 对应时间轴 `frame{N+1}`。
VO 字段：`power` / `hitType` / `hitx` / `hity` / `hurtTime` / `hurtType` / `isBreakDef`。

## 目录

| 目录 | 类型 | XML id | 名称 | startFrame | 招式数 |
|---|---|---|---|---|---:|
| `aizen` | playable | aizen | 蓝染·惣右介 | 1 | 31 |
| `byakuya` | playable | byakuya, byakuya_wanjie | 朽木·白哉, 朽木·白哉 卍解 | 1, 2 | 41 |
| `chad` | playable | chad | 茶渡·泰虎 | 1 | 21 |
| `didala` | playable | didala | 迪达拉 | 1 | 23 |
| `gaara` | playable | gaara | 我爱罗 | 1 | 24 |
| `grimmjow` | playable | grimmjow | 葛力姆乔·贾卡杰克 | 1 | 23 |
| `ichigo` | playable | ichigo, ichigo_wanjie, ichigo_xuhua_half, ichigo_xuhua | 黑崎·一护, 黑崎·一护 卍解, 黑崎·一护 半虚, 黑崎·一护 虚化 | 1, 2, 3, 4 | 87 |
| `ichigo_zero` | playable | ichigo_zero, ichigo_neixu, ichigo_neixu_wanjie | 黑崎·一护 零段, 黑崎·一护 内虚, 黑崎·一护 内虚 卍解 | 1, 2, 3 | 70 |
| `ikkaku` | playable | ikkaku | 斑目·一角 | 1 | 24 |
| `itachi` | playable | itachi | 宇智波·鼬 | 1 | 28 |
| `jiraiya` | playable | jiraiya | 自来也 | 1 | 30 |
| `juggo` | playable | juggo | 天秤·重吾 | 1 | 26 |
| `kakashi` | playable | kakashi | 旗木·卡卡西 | 1 | 27 |
| `kakashi_sw` | playable | kakashi_sw | 旗木·卡卡西 神威 | 1 | 38 |
| `karin` | playable | karin | 漩涡·香磷 | 1 | 26 |
| `kenpachi` | playable | kenpachi | 更木·剑八 | 1 | 28 |
| `kenshin` | playable | kenshin, kenshin_bdz | 绯村·剑心, 绯村·剑心 拔刀斋 | 1, 2 | 55 |
| `killerbee` | playable | killerbee | 奇拉比 | 1 | 25 |
| `konan` | playable | konan | 小南 | 1 | 25 |
| `lee` | playable | lee, lee_dm | 李·洛克, 李·洛克 杜门 | 1, 2 | 61 |
| `madara` | playable | madara | 宇智波·斑 | 1 | 31 |
| `mayuri` | playable | mayuri | 涅茧利 | 1 | 28 |
| `naruto` | playable | naruto, naruto_yw, naruto_sw | 漩涡·鸣人, 漩涡·鸣人 一尾, 漩涡·鸣人 四尾 | 1, 2, 3 | 74 |
| `naruto_xr` | playable | naruto_xianren, naruto_gold | 漩涡·鸣人 仙人, 漩涡·鸣人 黄金 | 1, 2 | 67 |
| `neji` | playable | neji | 日向·宁次 | 1 | 25 |
| `obito` | playable | obito, obito_s2 | 宇智波·带土, 宇智波·带土 真面目 | 1, 2 | 72 |
| `orihime` | playable | orihime | 井上·织姬 | 1 | 23 |
| `orochimaru` | playable | orochimaru | 大蛇丸 | 1 | 26 |
| `pain` | playable | pain | 佩恩 | 1 | 27 |
| `renji` | playable | renji | 阿散井·恋次 | 1 | 21 |
| `rukia` | playable | rukia, rukia_shijie | 朽木·露琪亚 义骸, 朽木·露琪亚 始解 | 1, 2 | 42 |
| `sakura` | playable | sakura | 春野·樱 | 1 | 29 |
| `sasuke` | playable | sasuke, sasuke_zy | 宇智波·佐助, 宇智波·佐助 咒怨 | 1, 2 | 44 |
| `sasuke_xz` | playable | sasuke_xz | 宇智波·佐助 须佐能乎 | 1 | 30 |
| `soifon` | playable | soifon | 碎蜂 | 1 | 25 |
| `temari` | playable | temari | 手鞠 | 1 | 24 |
| `toushirou` | playable | toushirou, toushirou_wanjie | 日番谷·东狮郎, 日番谷·东狮郎 卍解 | 1, 2 | 48 |
| `ulquiorra` | playable | ulquiorra, ulquiorra_guiren | 乌尔奇奥拉, 乌尔奇奥拉 归刃 | 1, 2 | 47 |
| `uryuu` | playable | uryuu | 石田·雨龙 | 1 | 23 |
| `yin` | playable | yin | 市丸·银 | 1 | 25 |
| `fz/byakuya` | assist | byakuya | 朽木·白哉 | — | 1 |
| `fz/gaara` | assist | garra | 我爱罗 | — | 1 |
| `fz/grimmjow` | assist | grimmjow | 葛力姆乔·贾卡杰克 | — | 3 |
| `fz/harribel` | assist | halibel | 蒂雅.赫丽贝尔 | — | 1 |
| `fz/hinata` | assist | hinata | 日向·雏田 | — | 1 |
| `fz/ichigo_padipata` | assist | ichigo_padipata | 黑崎·一护·修行 | — | 1 |
| `fz/ichigo_white2` | assist | ichigo_white2 | 一护·虚·二段 | — | 3 |
| `fz/ino` | assist | ino | 山中·井野 | — | 1 |
| `fz/itachi` | assist | itachi | 宇智波·鼬 | — | 3 |
| `fz/jiraiya` | assist | jiraiya | 自来也 | — | 2 |
| `fz/kenpachi` | assist | kenpachi | 更木·剑八 | — | 1 |
| `fz/kimimaro` | assist | kimimaro | 君麻吕 | — | 1 |
| `fz/kon` | assist | kon | 魂 | — | 1 |
| `fz/madara` | assist | madara | 宇智波·斑 | — | 3 |
| `fz/minato` | assist | minato | 四代火影 | — | 5 |
| `fz/nemu` | assist | nemu | 涅音梦 | — | 2 |
| `fz/obito` | assist | obito | 宇智波·带土 | — | 1 |
| `fz/orihime` | assist | orihime | 井上·织姬 | — | 1 |
| `fz/rangiku` | assist | rangiku | 松本·乱菊 | — | 1 |
| `fz/sai` | assist | sai | 佐井 | — | 1 |
| `fz/shikamaru` | assist | shikamaru | 奈良·鹿丸 | — | 1 |
| `fz/shishio` | assist | shishio | 志志雄·真实 | — | 3 |
| `fz/soifon` | assist | soifon | 碎蜂 | — | 1 |
| `fz/stake` | assist | stake | 托尼·斯塔克 | — | 3 |
| `fz/suigetsu` | assist | suigetsu | 鬼灯·水月 | — | 2 |
| `fz/temari` | assist | temari | 手鞠 | — | 1 |
| `fz/tenten` | assist | tenten | 天天 | — | 2 |
| `fz/tsuchikage` | assist | tsuchikage | 土影 | — | 3 |
| `fz/tsunate` | assist | tsunate | 纲手 | — | 1 |
| `fz/uryuu` | assist | uryuu | 石田·雨龙 | — | 1 |
| `fz/yachiru` | assist | yachiru | 草鹿·八千流 | — | 1 |
| `fz/yamamoto` | assist | yamamoto | 山本元柳斎重国 | — | 1 |
| `fz/yin` | assist | yin | 市丸·银 | — | 1 |
| `fz/yoruichi` | assist | yoruichi | 四枫院·夜一 | — | 1 |
| `fz/soifong` | extra (not in xml) | — | — | — | 1 |
| `sasuke_xz_old` | extra (not in xml) | — | — | — | 33 |
| — | playable xml-only | random | 随机人物 | — | 0 |
| — | playable xml-only | random_bleach | 随机死神人物 | — | 0 |
| — | playable xml-only | random_naruto | 随机炎影人物 | — | 0 |
| — | assist xml-only | random | 随机人物 | — | 0 |
| — | assist xml-only | random_bleach | 随机死神人物 | — | 0 |
| — | assist xml-only | random_naruto | 随机火影人物 | — | 0 |

合计：playable 目录 40 / 招式 1444；assist 目录 34 / 招式 56；extra 2 / 招式 34；MainTimeline 文件 76。
`random` / `random_bleach` / `random_naruto` 在 fighter.xml 与 assist.xml 都没有 `file` 节点，运行时抽真实 id，无 MainTimeline。
`fz/soifong` 与 `sasuke_xz_old` 有反编译时间轴但不在现行 XML。

## 可玩角色

### `aizen` — 蓝染·惣右介 (`aizen`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `aizen` | 蓝染·惣右介 | 0 | `assets/fighter/aizen.swf` | 1 | frame2 |

**frame2** (31 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 6 | 6 | 6 | 600 | 0 | false |
| tz | 80 | 5 | 10 | 0 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 3 | 0 | 400 | 0 | false |
| k3 | 50 | 6 | 4 | 0 | 600 | 0 | false |
| k4 | 50 | 6 | 5 | 0 | 400 | 0 | false |
| k5 | 30 | 1 | 3 | -5 | 600 | 0 | false |
| k52 | 30 | 1 | 3 | -5 | 600 | 1 | false |
| kj2 | 120 | 5 | 10 | -10 | 0 | 1 | true |
| kj21 | 40 | 6 | 1 | 0 | 600 | 0 | false |
| kj22 | 50 | 6 | 7 | 0 | 0 | 1 | false |
| kj1 | 100 | 6 | 3 | 0 | 500 | 0 | false |
| kj12 | 110 | 6 | 7 | 0 | 0 | 1 | false |
| zh1 | 100 | 9 | 15 | 0 | 0 | 1 | false |
| zh2 | 110 | 5 | 30 | -5 | 0 | 1 | true |
| zh3 | 100 | 5 | 10 | 0 | 700 | 1 | false |
| zh31 | 100 | 5 | 20 | -3 | 0 | 1 | false |
| bs1 | 20 | 1 | 0 | 0 | 500 | 0 | false |
| bs | 80 | 5 | 10 | 0 | 0 | 1 | false |
| sbs | 150 | 5 | 0 | -15 | 0 | 1 | false |
| sbs1 | 30 | 1 | 3 | 0 | 500 | 0 | false |
| sbs2 | 30 | 1 | 4 | -4 | 500 | 0 | false |
| sbs3 | 30 | 1 | 4 | 4 | 500 | 0 | false |
| sbs4 | 50 | 6 | 2 | 0 | 1000 | 0 | false |
| kbs | 200 | 5 | 15 | 5 | 0 | 1 | false |
| cbs | 20 | 4 | 1 | -0.1 | 500 | 0 | false |
| cbs2 | 40 | 5 | 2 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | -7 | 1 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 10 | -5 | 0 | 1 | false |

### `byakuya` — 朽木·白哉 (`byakuya`, sf=1) / 朽木·白哉 卍解 (`byakuya_wanjie`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `byakuya` | 朽木·白哉 | 0 | `assets/fighter/byakuya.swf` | 1 | frame2 |
| `byakuya_wanjie` | 朽木·白哉 卍解 | 0 | `assets/fighter/byakuya.swf` | 2 | frame3 |

**frame2** (21 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 0 | 0 | 700 | 0 | false |
| tz | 70 | 6 | 5 | 5 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 200 | 0 | false |
| k2 | 30 | 1 | 2 | 0 | 300 | 0 | false |
| k3 | 50 | 6 | 7 | -7 | 600 | 0 | false |
| kj1 | 60 | 6 | 8 | 0 | 300 | 0 | false |
| kj21 | 30 | 1 | 1 | 0 | 300 | 0 | false |
| kj2 | 50 | 5 | 5 | -10 | 600 | 0 | false |
| zh1 | 40 | 4 | 8 | 0 | 300 | 0 | false |
| zh2 | 100 | 5 | 12 | 0 | 0 | 1 | true |
| zh3 | 30 | 1 | 8 | -6 | 500 | 0 | false |
| zh32 | 50 | 1 | 8 | -6 | 500 | 1 | false |
| bs | 30 | 1 | 0 | 0 | 500 | 0 | false |
| bs1 | 80 | 6 | 10 | 0 | 0 | 1 | false |
| sbs1 | 30 | 1 | 0 | -1 | 500 | 0 | false |
| sbs | 30 | 1 | 5 | -10 | 0 | 1 | false |
| cbs | 450 | 5 | 5 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 0 | -5 | 0 | 1 | false |

**frame3** (20 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 120 | 9 | 10 | 6 | 0 | 1 | false |
| tz | 20 | 1 | 0 | 10 | 300 | 0 | false |
| kj1 | 120 | 6 | 10 | -5 | 0 | 1 | false |
| k1 | 20 | 1 | 3 | 0 | 400 | 0 | false |
| k2 | 20 | 1 | 3 | -5 | 500 | 0 | false |
| k3 | 60 | 6 | 5 | 6 | 600 | 0 | false |
| kj2 | 20 | 1 | 5 | -3 | 500 | 0 | false |
| zh1 | 120 | 5 | 5 | 0 | 0 | 1 | false |
| zh3 | 150 | 5 | 5 | -10 | 0 | 1 | false |
| zh21 | 80 | 6 | 10 | -10 | 0 | 1 | false |
| zh2 | 80 | 6 | 5 | -5 | 500 | 0 | true |
| bs | 40 | 5 | 10 | 0 | 0 | 1 | false |
| bs1 | 40 | 4 | 10 | 0 | 500 | 0 | false |
| sbs | 250 | 5 | 15 | -5 | 0 | 1 | true |
| cbs1 | 25 | 1 | 0 | -2 | 0 | 1 | false |
| cbs | 25 | 1 | 0 | -2 | 500 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | -3 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 8 | -10 | 0 | 1 | false |

### `chad` — 茶渡·泰虎 (`chad`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `chad` | 茶渡·泰虎 | 0 | `assets/fighter/chad.swf` | 1 | frame2 |

**frame2** (21 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 70 | 3 | 3 | 3 | 800 | 0 | false |
| tz1 | 20 | 4 | 10 | 10 | 400 | 0 | false |
| tz | 80 | 5 | 10 | -5 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 3 | 0 | 400 | 0 | false |
| k3 | 20 | 2 | 5 | 0 | 400 | 0 | false |
| k4 | 60 | 3 | 10 | 0 | 500 | 0 | false |
| kj1 | 100 | 3 | 1 | 0 | 500 | 0 | false |
| kj2 | 80 | 5 | 5 | -7 | 800 | 0 | false |
| zh1 | 130 | 5 | 20 | 0 | 400 | 1 | false |
| zh2 | 80 | 3 | 5 | -7 | 600 | 0 | true |
| zh3 | 150 | 5 | 10 | -10 | 0 | 1 | false |
| bs | 290 | 5 | 10 | 0 | 0 | 1 | false |
| sbs1 | 100 | 5 | 10 | -10 | 1000 | 0 | false |
| sbs | 120 | 5 | 10 | -10 | 0 | 1 | false |
| cbs | 200 | 3 | 0 | 0 | 1000 | 0 | true |
| cbs1 | 350 | 5 | 20 | 0 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 0 | -5 | -10 | 0 | 1 | false |

### `didala` — 迪达拉 (`didala`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `didala` | 迪达拉 | 1 | `assets/fighter/didala.swf` | 1 | frame2 |

**frame2** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 2 | 0 | 12 | 350 | 0 | false |
| tz | 160 | 7 | 6 | 0 | 0 | 1 | false |
| k1 | 20 | 2 | 4 | 0 | 300 | 0 | false |
| k2 | 20 | 2 | 4 | 0 | 300 | 0 | false |
| k3 | 50 | 3 | 5 | 0 | 400 | 0 | false |
| k4 | 50 | 3 | 3 | -7 | 500 | 0 | false |
| kj1 | 80 | 3 | 2 | -8 | 600 | 0 | false |
| kj2 | 80 | 6 | 6 | 0 | 500 | 0 | false |
| kj21 | 30 | 1 | -3 | 0 | 500 | 0 | false |
| zh1 | 100 | 7 | 8 | 0 | 0 | 1 | false |
| zh2 | 150 | 5 | 10 | -5 | 0 | 1 | true |
| zh21 | 20 | 2 | 10 | 0 | 500 | 0 | false |
| zh3 | 140 | 7 | 8 | -8 | 0 | 1 | false |
| bs2 | 100 | 7 | 12 | 0 | 0 | 1 | false |
| bs | 20 | 2 | 12 | 0 | 500 | 0 | false |
| sbs1 | 10 | 2 | 8 | -3 | 800 | 0 | false |
| sbs | 200 | 7 | 15 | -15 | 0 | 1 | false |
| cbs1 | 120 | 7 | 0 | 0 | 1000 | 0 | false |
| cbs | 140 | 7 | 20 | -10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 7 | 10 | -10 | 0 | 1 | false |

### `gaara` — 我爱罗 (`gaara`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `gaara` | 我爱罗 | 1 | `assets/fighter/gaara.swf` | 1 | frame2 |

**frame2** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 2 | 3 | 3 | 400 | 0 | false |
| tz | 100 | 5 | 2 | 6 | 0 | 1 | false |
| k1 | 30 | 2 | 1 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 1 | -2 | 400 | 0 | false |
| k3 | 80 | 3 | 10 | 0 | 600 | 0 | false |
| kj1 | 150 | 5 | 15 | 0 | 500 | 1 | false |
| kj2 | 150 | 5 | 8 | -7 | 500 | 1 | true |
| zh1 | 100 | 6 | 10 | 0 | 0 | 1 | false |
| zh2 | 20 | 2 | 5 | 0 | 500 | 0 | false |
| zh3 | 80 | 3 | 0 | -6 | 700 | 0 | false |
| bs1 | 10 | 2 | 0 | 0 | 800 | 0 | false |
| bs | 330 | 5 | 10 | -5 | 0 | 1 | false |
| sbs1 | 10 | 2 | 0 | 0 | 800 | 0 | false |
| sbs2 | 50 | 3 | 0 | 3 | 800 | 0 | false |
| sbs3 | 10 | 2 | 0 | 0 | 800 | 0 | false |
| sbs | 250 | 5 | 0 | 10 | 0 | 1 | false |
| cbs | 200 | 5 | 5 | -5 | 0 | 1 | false |
| cbs3 | 150 | 5 | 10 | 0 | 0 | 1 | true |
| cbs2 | 30 | 2 | 0 | -1 | 1000 | 0 | false |
| cbs1 | 50 | 3 | 0 | 0 | 1000 | 0 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | 15 | -6 | 0 | 1 | false |

### `grimmjow` — 葛力姆乔·贾卡杰克 (`grimmjow`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `grimmjow` | 葛力姆乔·贾卡杰克 | 0 | `assets/fighter/grimmjow.swf` | 1 | frame2 |

**frame2** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 3 | 2 | -5 | 400 | 0 | false |
| tz | 70 | 3 | 5 | 15 | 300 | 1 | false |
| k1 | 30 | 2 | 1 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k3 | 50 | 3 | 6 | 0 | 400 | 0 | false |
| k4 | 70 | 6 | 6 | -8 | 500 | 0 | false |
| kj1 | 15 | 1 | 1 | 0 | 300 | 0 | false |
| kj2 | 120 | 6 | 2 | -5 | 0 | 1 | false |
| zh1 | 120 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 100 | 5 | 10 | -5 | 0 | 1 | true |
| zh31 | 20 | 2 | 0 | 0 | 500 | 0 | false |
| zh3 | 80 | 6 | 5 | 15 | 0 | 1 | false |
| sh1 | 10 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 6 | 0 | 1000 | 0 | false |
| sh2 | 10 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 5 | 10 | 0 | 1 | false |
| bs | 300 | 5 | 10 | 0 | 0 | 1 | false |
| kbs | 20 | 1 | 8 | 8 | 500 | 0 | false |
| kbs1 | 200 | 5 | 8 | -4 | 0 | 1 | false |
| cbs1 | 30 | 4 | 0 | 20 | 1000 | 0 | false |
| cbs | 150 | 5 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 30 | 4 | 0 | -1 | 1000 | 0 | false |
| cbs3 | 30 | 4 | 10 | -5 | 0 | 1 | false |

### `ichigo` — 黑崎·一护 (`ichigo`, sf=1) / 黑崎·一护 卍解 (`ichigo_wanjie`, sf=2) / 黑崎·一护 半虚 (`ichigo_xuhua_half`, sf=3) / 黑崎·一护 虚化 (`ichigo_xuhua`, sf=4)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `ichigo` | 黑崎·一护 | 0 | `assets/fighter/ichigo.swf` | 1 | frame2 |
| `ichigo_wanjie` | 黑崎·一护 卍解 | 0 | `assets/fighter/ichigo.swf` | 2 | frame3 |
| `ichigo_xuhua_half` | 黑崎·一护 半虚 | 0 | `assets/fighter/ichigo.swf` | 3 | frame4 |
| `ichigo_xuhua` | 黑崎·一护 虚化 | 0 | `assets/fighter/ichigo.swf` | 4 | frame5 |

**frame2** (19 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 2 | 6 | 350 | 0 | false |
| tz | 80 | 5 | 5 | 5 | 300 | 1 | false |
| k1 | 40 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 50 | 1 | 2 | 0 | 400 | 0 | false |
| k3 | 70 | 6 | 7 | -7 | 600 | 0 | false |
| kj1 | 80 | 3 | 8 | 0 | 0 | 1 | true |
| kj21 | 20 | 1 | 1 | 0 | 100 | 0 | false |
| kj2 | 60 | 4 | 1 | -10 | 500 | 0 | false |
| zh1 | 80 | 5 | 3 | 0 | 300 | 1 | false |
| zh2 | 80 | 6 | 8 | -3 | 600 | 0 | false |
| zh3 | 80 | 5 | 5 | -5 | 300 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |
| bs1 | 80 | 5 | 5 | 0 | 1000 | 0 | false |
| bs | 240 | 5 | 10 | 0 | 0 | 1 | false |
| sbs | 250 | 5 | 3 | -8 | 0 | 1 | false |
| cbs | 450 | 5 | 40 | 0 | 0 | 1 | false |

**frame3** (19 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 2 | 6 | 350 | 0 | false |
| tz | 110 | 6 | 10 | 0 | 0 | 1 | false |
| k1 | 30 | 1 | 2 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 2 | 0 | 400 | 0 | false |
| k3 | 40 | 1 | 7 | -7 | 500 | 0 | false |
| kj1 | 80 | 5 | -2 | 0 | 600 | 0 | true |
| kj21 | 20 | 4 | 1 | -14 | 350 | 0 | false |
| kj2 | 70 | 6 | 1 | 15 | 500 | 0 | false |
| zh1 | 50 | 6 | 2 | 0 | 500 | 0 | false |
| zh2 | 80 | 6 | 5 | 0 | 0 | 1 | false |
| zh3 | 80 | 6 | 4 | -4 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 3 | 0 | 0 | 1 | false |
| bs | 300 | 5 | 25 | 0 | 0 | 1 | false |
| sbs | 20 | 1 | 0 | -0.5 | 500 | 0 | false |
| sbs2 | 20 | 1 | 0 | -5 | 0 | 1 | false |
| cbs | 600 | 5 | 30 | 0 | 0 | 1 | false |

**frame4** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 2 | 6 | 350 | 0 | false |
| tz | 80 | 5 | 5 | -8 | 0 | 1 | false |
| tz2 | 80 | 5 | 5 | 8 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 3 | 0 | 400 | 0 | false |
| k3 | 50 | 5 | -2 | 0 | 500 | 0 | false |
| k4 | 50 | 6 | 6 | -6 | 600 | 0 | false |
| kj1 | 120 | 5 | 8 | -5 | 0 | 1 | true |
| kj12 | 120 | 5 | 8 | -5 | 0 | 1 | false |
| kj21 | 30 | 1 | 1 | -5 | 250 | 0 | false |
| kj2 | 80 | 6 | 2 | -6 | 500 | 0 | false |
| zh1 | 40 | 5 | 7 | 0 | 500 | 0 | false |
| zh12 | 40 | 5 | 8 | 0 | 0 | 1 | false |
| zh2 | 120 | 5 | 10 | -5 | 0 | 1 | false |
| zh3 | 100 | 5 | 10 | -5 | 0 | 1 | false |
| zh31 | 10 | 1 | 12 | 0 | 300 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | -6 | -7 | 0 | 1 | false |
| bs | 280 | 5 | 20 | 0 | 0 | 1 | false |
| sbs1 | 50 | 3 | 0 | 0 | 1000 | 0 | false |
| sbs | 200 | 5 | 6 | -15 | 0 | 1 | false |
| kbs | 250 | 5 | 8 | 8 | 0 | 1 | false |
| cbs | 450 | 5 | 40 | -6 | 0 | 1 | false |

**frame5** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 1 | 5 | 5 | 500 | 0 | false |
| tz | 20 | 1 | 5 | 5 | 500 | 0 | false |
| tz1 | 70 | 5 | 10 | 0 | 0 | 1 | false |
| k1 | 30 | 1 | 5 | 0 | 250 | 0 | false |
| k2 | 30 | 1 | 7 | 0 | 300 | 0 | false |
| k3 | 30 | 1 | 5 | 0 | 300 | 0 | false |
| k4 | 80 | 6 | 6 | 0 | 500 | 0 | false |
| k5 | 60 | 1 | 7 | -7 | 600 | 0 | false |
| kj1 | 90 | 5 | 10 | -5 | 0 | 1 | true |
| kj21 | 110 | 5 | 12 | 8 | 0 | 1 | false |
| kj2 | 50 | 6 | 15 | -8 | 700 | 0 | false |
| zh1 | 50 | 1 | 2 | 0 | 500 | 0 | false |
| zh12 | 50 | 6 | 4 | 0 | 600 | 0 | false |
| zh2 | 100 | 6 | 5 | -10 | 800 | 0 | false |
| zh3 | 100 | 5 | 12 | -8 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 10 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 50 | 6 | 10 | -7 | 1000 | 0 | false |
| sh23 | 120 | 5 | 10 | 8 | 0 | 1 | false |
| bs | 300 | 5 | 25 | 0 | 0 | 1 | false |
| sbs | 300 | 5 | 20 | -10 | 0 | 1 | true |
| cbs | 500 | 5 | 30 | -20 | 0 | 1 | false |
| cbs1 | 100 | 6 | 7 | -7 | 1000 | 0 | true |

### `ichigo_zero` — 黑崎·一护 零段 (`ichigo_zero`, sf=1) / 黑崎·一护 内虚 (`ichigo_neixu`, sf=2) / 黑崎·一护 内虚 卍解 (`ichigo_neixu_wanjie`, sf=3)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `ichigo_zero` | 黑崎·一护 零段 | 0 | `assets/fighter/ichigo_zero.swf` | 1 | frame2 |
| `ichigo_neixu` | 黑崎·一护 内虚 | 0 | `assets/fighter/ichigo_zero.swf` | 2 | frame3 |
| `ichigo_neixu_wanjie` | 黑崎·一护 内虚 卍解 | 0 | `assets/fighter/ichigo_zero.swf` | 3 | frame4 |

**frame2** (17 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 2 | 5 | 400 | 0 | false |
| k1 | 40 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 40 | 1 | 2 | 0 | 400 | 0 | false |
| k3 | 60 | 6 | 10 | 0 | 600 | 0 | false |
| kj1 | 80 | 6 | 5 | 0 | 500 | 0 | false |
| kj2 | 80 | 6 | 5 | -7 | 500 | 0 | true |
| zh1 | 80 | 5 | 3 | 0 | 0 | 1 | false |
| zh2 | 80 | 5 | 8 | -6 | 500 | 0 | false |
| zh3 | 80 | 5 | 3 | -3 | 0 | 1 | false |
| bs1 | 80 | 5 | 0 | 0 | 1000 | 0 | false |
| bs2 | 80 | 6 | 5 | -5 | 1000 | 0 | false |
| bs | 100 | 5 | 15 | -5 | 0 | 1 | false |
| sbs | 220 | 5 | 10 | -8 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

**frame3** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 4 | 3 | 5 | 500 | 0 | false |
| tz | 90 | 6 | 5 | 7 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 40 | 1 | 2 | 0 | 400 | 0 | false |
| k3 | 80 | 6 | 5 | -7 | 600 | 0 | false |
| kj1 | 30 | 6 | 4 | 0 | 500 | 0 | false |
| kj12 | 30 | 1 | -12 | 0 | 400 | 0 | false |
| kj2 | 20 | 1 | 0 | 0 | 200 | 0 | false |
| kj22 | 20 | 1 | 0 | -0.1 | 200 | 0 | false |
| kj21 | 30 | 7 | 3 | -10 | 0 | 1 | false |
| zh1 | 40 | 6 | 3 | 0 | 400 | 0 | false |
| zh12 | 80 | 5 | 7 | -3 | 0 | 1 | false |
| zh13 | 100 | 5 | 6 | 0 | 0 | 1 | true |
| zh2 | 20 | 4 | 0 | -4 | 500 | 0 | false |
| zh21 | 50 | 5 | 4 | -3 | 500 | 0 | false |
| zh3 | 100 | 5 | 6 | -6 | 0 | 1 | false |
| bs | 270 | 5 | 15 | -5 | 0 | 1 | false |
| sbs | 270 | 5 | 2 | -10 | 0 | 1 | false |
| cbs1 | 40 | 4 | 1 | 0 | 500 | 0 | false |
| cbs2 | 40 | 4 | 1 | 0 | 500 | 0 | false |
| cbs | 100 | 5 | 5 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 4 | -3 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 4 | -6 | 0 | 1 | false |

**frame4** (28 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 1 | 7 | 6 | 400 | 0 | false |
| tz | 150 | 6 | 0 | 0 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 50 | 1 | 5 | -2 | 500 | 0 | false |
| k3 | 60 | 6 | 5 | 4 | 600 | 0 | false |
| k4 | 60 | 6 | 8 | -8 | 600 | 0 | false |
| kj1 | 150 | 6 | 15 | 0 | 0 | 1 | false |
| kj12 | 150 | 6 | 3 | -5 | 800 | 0 | false |
| kj2 | 80 | 6 | 8 | -8 | 500 | 0 | false |
| kj21 | 30 | 1 | 3 | 0 | 500 | 0 | false |
| zh1 | 150 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 200 | 5 | 30 | 0 | 0 | 1 | true |
| zh21 | 10 | 2 | 0 | 0 | 1000 | 0 | false |
| zh3 | 50 | 1 | 6 | -6 | 500 | 0 | false |
| zh31 | 100 | 5 | -10 | 10 | 0 | 1 | true |
| bs | 320 | 5 | 30 | 0 | 0 | 1 | false |
| bs1 | 20 | 1 | 0.05 | -0.05 | 800 | 0 | false |
| bs2 | 100 | 6 | 15 | 0 | 0 | 1 | false |
| sbs | 230 | 5 | 20 | 10 | 0 | 1 | false |
| sbs1 | 50 | 1 | 10 | -5 | 1000 | 0 | false |
| cbs1 | 80 | 6 | 2 | 0 | 2000 | 0 | false |
| cbs2 | 100 | 6 | 10 | 0 | 2000 | 0 | false |
| cbs3 | 50 | 2 | 2 | 0 | 2000 | 0 | false |
| cbs | 400 | 5 | 30 | 0 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 30 | 0 | 0 | 1 | true |

### `ikkaku` — 斑目·一角 (`ikkaku`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `ikkaku` | 斑目·一角 | 0 | `assets/fighter/ikkaku.swf` | 1 | frame2 |

**frame2** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 6 | 5 | 5 | 400 | 0 | false |
| tz | 80 | 3 | 10 | -10 | 0 | 1 | false |
| tz1 | 10 | 1 | 10 | 10 | 500 | 0 | false |
| k1 | 50 | 1 | 2 | 0 | 300 | 0 | false |
| k2 | 50 | 2 | 6 | 0 | 500 | 0 | false |
| k3 | 80 | 6 | 6 | 0 | 500 | 0 | false |
| kj1 | 15 | 1 | 0 | 0 | 500 | 0 | false |
| kj12 | 15 | 1 | 5 | 0 | 500 | 0 | false |
| kj13 | 80 | 6 | 10 | 0 | 500 | 0 | false |
| kj21 | 20 | 2 | 2 | 0 | 200 | 0 | false |
| kj2 | 80 | 6 | 3 | 0 | 500 | 0 | false |
| kj22 | 80 | 6 | -2 | -7 | 500 | 0 | false |
| zh1 | 120 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 140 | 3 | 10 | -5 | 0 | 1 | true |
| zh3 | 100 | 6 | -10 | -10 | 0 | 1 | false |
| zh31 | 100 | 6 | 1 | -2 | 500 | 0 | false |
| bs | 250 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 300 | 5 | 5 | -10 | 0 | 1 | false |
| cbs1 | 100 | 6 | 5 | 0 | 1000 | 0 | false |
| cbs | 100 | 7 | 15 | -5 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

### `itachi` — 宇智波·鼬 (`itachi`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `itachi` | 宇智波·鼬 | 1 | `assets/fighter/itachi.swf` | 1 | frame2 |

**frame2** (28 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tz | 120 | 6 | 5 | 0 | 0 | 1 | false |
| tk | 30 | 1 | 3 | 0 | 500 | 0 | false |
| tk2 | 30 | 1 | 3 | 0 | 500 | 0 | false |
| tk3 | 30 | 1 | 3 | 3 | 500 | 0 | false |
| k1 | 30 | 1 | 1 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 3 | 0 | 400 | 0 | false |
| k3 | 80 | 3 | 3 | 0 | 400 | 0 | false |
| k4 | 100 | 6 | -1 | -7 | 500 | 0 | false |
| kj1 | 130 | 7 | 10 | -2 | 0 | 1 | false |
| kj2 | 30 | 1 | 2 | -5 | 300 | 0 | false |
| kj21 | 70 | 6 | 5 | -4 | 0 | 1 | false |
| zh1 | 70 | 6 | 7 | 0 | 0 | 1 | false |
| zh2 | 30 | 1 | 3 | -5 | 500 | 0 | false |
| zh21 | 50 | 3 | 2 | -5 | 500 | 0 | false |
| kj2 | 120 | 6 | 0 | 10 | 0 | 1 | true |
| zh3 | 60 | 6 | 3 | -3 | 500 | 0 | false |
| zh32 | 60 | 7 | 10 | 10 | 500 | 1 | false |
| bs1 | 30 | 2 | 0 | 0 | 500 | 0 | false |
| bs | 300 | 7 | 10 | -10 | 0 | 1 | false |
| sbs | 250 | 7 | 20 | -10 | 0 | 1 | false |
| cbs1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| cbs2 | 60 | 1 | 0 | 0 | 1000 | 0 | false |
| cbs3 | 10 | 1 | 0 | 0 | 1000 | 0 | false |
| cbs | 200 | 3 | 0 | 10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | -10 | 0 | 0 | 1 | false |

### `jiraiya` — 自来也 (`jiraiya`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `jiraiya` | 自来也 | 1 | `assets/fighter/jiraiya.swf` | 1 | frame2 |

**frame2** (30 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 4 | 10 | 700 | 0 | false |
| tk1 | 30 | 2 | -1 | 3 | 300 | 0 | false |
| tz | 150 | 3 | 8 | -5 | 400 | 1 | false |
| k1 | 20 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 1 | 0 | 400 | 0 | false |
| k3 | 50 | 3 | 4 | 0 | 600 | 0 | false |
| k4 | 50 | 5 | 3 | -7 | 700 | 0 | false |
| kj1 | 10 | 2 | 8 | 0 | 400 | 0 | false |
| kj12 | 100 | 3 | 5 | -5 | 500 | 0 | false |
| kj22 | 10 | 1 | 5 | 0 | 400 | 0 | false |
| kj2 | 100 | 6 | 3 | 0 | 500 | 0 | false |
| kj21 | 80 | 6 | 5 | -8 | 500 | 0 | false |
| zh1 | 150 | 7 | 10 | 0 | 0 | 1 | false |
| zh2 | 30 | 4 | 2 | 0 | 500 | 0 | true |
| zh3 | 50 | 2 | 1 | -3 | 500 | 0 | false |
| zh31 | 50 | 2 | 0 | -5 | 500 | 0 | false |
| zh32 | 100 | 3 | 0 | 20 | 0 | 1 | false |
| bs1 | 30 | 4 | 5 | 0 | 1000 | 0 | false |
| bs2 | 30 | 4 | 5 | 0 | 0 | 1 | false |
| bs | 100 | 7 | 5 | 0 | 1000 | 0 | false |
| sbs | 30 | 4 | 1 | 0 | 200 | 0 | false |
| sbs2 | 80 | 5 | 15 | -2 | 0 | 1 | false |
| cbs1 | 100 | 7 | 5 | -5 | 0 | 1 | true |
| cbs | 30 | 4 | 3 | -0.5 | 1000 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 30 | 4 | 0 | 0 | 400 | 0 | false |
| sh24 | 30 | 4 | 5 | 0 | 400 | 0 | false |
| sh23 | 30 | 4 | 15 | -5 | 0 | 1 | false |

### `juggo` — 天秤·重吾 (`juggo`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `juggo` | 天秤·重吾 | 1 | `assets/fighter/juggo.swf` | 1 | frame2 |

**frame2** (26 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 2 | 0 | 400 | 0 | false |
| tz | 100 | 3 | 5 | 15 | 0 | 1 | false |
| k1 | 40 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 6 | 0 | 300 | 0 | false |
| k3 | 80 | 3 | 3 | -8 | 500 | 0 | false |
| kj1 | 100 | 3 | 10 | 0 | 600 | 0 | false |
| kj2 | 20 | 11 | 0 | 0 | 500 | 0 | true |
| kj21 | 50 | 0 | -15 | 0 | 0 | 1 | false |
| zh1 | 50 | 4 | 8 | 0 | 500 | 0 | false |
| zh11 | 50 | 7 | 8 | 0 | 500 | 1 | false |
| zh21 | 10 | 2 | 0 | 0 | 300 | 0 | false |
| zh2 | 50 | 3 | 0 | 0 | 600 | 0 | true |
| zh22 | 120 | 7 | 20 | 0 | 0 | 1 | true |
| zh3 | 100 | 3 | 10 | -10 | 500 | 0 | false |
| zh32 | 80 | 0 | -15 | 10 | 0 | 1 | false |
| bs1 | 50 | 4 | 5 | 0 | 2000 | 0 | false |
| bs | 150 | 5 | 20 | 0 | 0 | 1 | false |
| sbs1 | 100 | 3 | 2 | -2 | 2000 | 0 | false |
| sbs | 200 | 5 | 20 | -2 | 0 | 1 | false |
| cbs1 | 50 | 11 | 0 | 0 | 3000 | 0 | true |
| cbs2 | 50 | 0 | 0 | 0 | 3000 | 0 | false |
| cbs | 150 | 3 | 10 | -5 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 160 | 3 | 15 | 0 | 0 | 1 | false |

### `kakashi` — 旗木·卡卡西 (`kakashi`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `kakashi` | 旗木·卡卡西 | 1 | `assets/fighter/kakashi.swf` | 1 | frame2 |

**frame2** (27 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 5 | 4 | 500 | 0 | false |
| tz | 50 | 6 | 4 | 4 | 0 | 1 | false |
| k1 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 20 | 1 | 4 | 0 | 400 | 0 | false |
| k21 | 20 | 2 | 4 | -3 | 400 | 0 | false |
| k3 | 60 | 3 | 7 | -7 | 500 | 0 | false |
| zh2 | 80 | 6 | 0 | 0 | 800 | 0 | true |
| kj1 | 80 | 6 | 3 | 0 | 500 | 0 | false |
| kj2 | 40 | 2 | 5 | 0 | 500 | 0 | false |
| kj22 | 80 | 3 | 10 | 0 | 500 | 1 | false |
| zh1 | 30 | 1 | 4 | 0 | 400 | 0 | false |
| zh12 | 30 | 1 | 4 | 0 | 400 | 0 | false |
| zh13 | 30 | 1 | 4 | 0 | 400 | 1 | false |
| zh14 | 30 | 1 | 4 | 0 | 400 | 0 | false |
| zh31 | 40 | 1 | 4 | -2 | 700 | 0 | false |
| zh32 | 40 | 3 | 10 | -10 | 700 | 0 | false |
| zh3 | 60 | 3 | 8 | -5 | 0 | 1 | false |
| sbs | 30 | 4 | 8 | 0 | 500 | 0 | false |
| sbs2 | 30 | 4 | 8 | 0 | 500 | 1 | false |
| bs | 180 | 9 | 10 | -5 | 500 | 1 | false |
| bs1 | 50 | 4 | 0 | 0 | 500 | 0 | false |
| cbs1 | 10 | 4 | 0 | 0 | 1000 | 0 | false |
| cbs | 400 | 5 | 10 | -5 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | -10 | -10 | 0 | 1 | false |

### `kakashi_sw` — 旗木·卡卡西 神威 (`kakashi_sw`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `kakashi_sw` | 旗木·卡卡西 神威 | 1 | `assets/fighter/kakashi_sw.swf` | 1 | frame2 |

**frame2** (38 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 1 | 1 | 0 | 400 | 0 | false |
| tk2 | 30 | 3 | -4 | -7 | 400 | 0 | false |
| tk3 | 60 | 3 | 5 | -9 | 400 | 1 | false |
| tz | 40 | 1 | 2 | 2 | 400 | 0 | false |
| tz2 | 40 | 6 | 4 | 4 | 300 | 1 | false |
| k1 | 40 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 40 | 1 | 2 | 0 | 400 | 0 | false |
| k22 | 40 | 2 | 2 | -1 | 400 | 0 | false |
| k3 | 40 | 2 | 3 | 0 | 500 | 0 | false |
| k4 | 50 | 3 | 3 | -3 | 400 | 0 | false |
| k5 | 50 | 3 | 5 | -15 | 900 | 0 | true |
| kj9 | 80 | 4 | 8 | 0 | 0 | 0 | true |
| kj99 | 80 | 5 | 8 | 0 | 0 | 1 | true |
| kj1 | 60 | 9 | 0 | 0 | 600 | 0 | false |
| kj12 | 40 | 3 | 0 | -3 | 800 | 0 | false |
| kj6 | 20 | 8 | 1 | 0 | 100 | 1 | false |
| kj2 | 50 | 6 | 0 | 7 | 800 | 1 | false |
| kj26 | 70 | 5 | 5 | -5 | 500 | 1 | false |
| kj27 | 0 | 0 | 0 | 0 | 500 | 0 | false |
| zh1 | 40 | 1 | 3 | 0 | 400 | 0 | false |
| zh12 | 40 | 6 | 3 | 0 | 300 | 1 | false |
| zh2 | 50 | 11 | 0 | 0 | 900 | 0 | true |
| zh3 | 40 | 3 | 3 | 0 | 400 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | -1 | -8 | 0 | 1 | false |
| bs | 250 | 9 | 0 | -10 | 300 | 1 | false |
| sbs | 250 | 5 | 10 | -10 | 0 | 1 | false |
| sbs0 | 10 | 11 | 0 | 0 | 2000 | 0 | true |
| sui | 250 | 8 | 5 | -5 | 0 | 1 | false |
| tu | 180 | 5 | 5 | -10 | 0 | 1 | false |
| huo | 300 | 7 | 5 | 5 | 0 | 1 | false |
| cbs1 | 100 | 6 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 10 | 1 | 3 | 0 | 1000 | 0 | true |
| cbs3 | 10 | 1 | -3 | 0 | 1000 | 0 | true |
| cbs4 | 300 | 9 | 10 | 0 | 1000 | 1 | true |
| leiqiebaozha | 300 | 9 | 0 | 0 | 5 | 1 | true |

### `karin` — 漩涡·香磷 (`karin`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `karin` | 漩涡·香磷 | 1 | `assets/fighter/karin.swf` | 1 | frame2 |

**frame2** (26 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 2 | 1 | 0 | 400 | 0 | false |
| tz | 120 | 6 | 5 | 5 | 0 | 1 | false |
| tz2 | 80 | 6 | 10 | -5 | 0 | 1 | false |
| tz3 | 80 | 6 | -10 | 5 | 0 | 1 | false |
| tz4 | 80 | 6 | 10 | 5 | 0 | 1 | false |
| k1 | 20 | 2 | 4 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 4 | 0 | 400 | 0 | false |
| k3 | 70 | 3 | 5 | 0 | 600 | 0 | false |
| k4 | 90 | 3 | 10 | 0 | 600 | 1 | false |
| kj1 | 20 | 4 | 3 | 0 | 500 | 0 | false |
| kj21 | 30 | 1 | 4 | 0 | 600 | 0 | false |
| kj22 | 30 | 2 | 4 | 0 | 600 | 0 | false |
| kj2 | 100 | 6 | 6 | -8 | 600 | 0 | false |
| zh1 | 50 | 4 | 8 | 0 | 500 | 0 | false |
| zh11 | 50 | 7 | 8 | 0 | 500 | 1 | false |
| zh2 | 80 | 5 | 6 | -10 | 800 | 0 | true |
| zh3 | 160 | 6 | 5 | -5 | 0 | 1 | false |
| bs | 230 | 5 | 5 | -3 | 0 | 1 | false |
| sbs | 100 | 5 | 15 | -5 | 0 | 1 | false |
| cbs1 | 50 | 5 | 0 | 0 | 2000 | 0 | false |
| cbs2 | 50 | 6 | 0 | 0 | 2000 | 0 | false |
| cbs | 350 | 7 | 20 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

### `kenpachi` — 更木·剑八 (`kenpachi`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `kenpachi` | 更木·剑八 | 0 | `assets/fighter/kenpachi.swf` | 1 | frame2 |

**frame2** (28 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 70 | 6 | 0 | 15 | 500 | 0 | false |
| tz | 130 | 5 | 10 | 0 | 0 | 1 | false |
| tz1 | 20 | 4 | 0 | 30 | 300 | 0 | false |
| k1 | 40 | 1 | 3 | 0 | 200 | 0 | false |
| k2 | 40 | 1 | 4 | 0 | 300 | 0 | false |
| k3 | 70 | 6 | 4 | -6 | 500 | 0 | false |
| kj11 | 40 | 1 | 6 | 0 | 400 | 0 | false |
| kj1 | 60 | 7 | 10 | 0 | 0 | 1 | true |
| kj2 | 70 | 6 | 1 | 0 | 500 | 0 | false |
| kj21 | 70 | 6 | 5 | -8 | 500 | 0 | false |
| zh1 | 120 | 5 | 20 | 0 | 500 | 1 | false |
| zh2 | 200 | 9 | 10 | -5 | 500 | 1 | true |
| zh3 | 130 | 9 | 12 | -6 | 0 | 1 | false |
| bs1 | 100 | 6 | 20 | 0 | 1000 | 0 | false |
| bs | 100 | 5 | 20 | 0 | 0 | 1 | true |
| sbs1 | 20 | 1 | 1 | -1 | 300 | 0 | false |
| sbs | 40 | 5 | 10 | 0 | 0 | 1 | false |
| cbs1 | 40 | 6 | 6 | 0 | 1000 | 0 | false |
| cbs2 | 20 | 1 | 4 | 0 | 2000 | 0 | false |
| cbs3 | 40 | 6 | 2 | -4 | 1000 | 0 | false |
| cbs4 | 10 | 1 | 1 | -0.2 | 1000 | 0 | true |
| cbs5 | 20 | 2 | 3 | -3 | 1000 | 0 | false |
| cbs | 60 | 7 | 15 | -15 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 30 | 1 | 0 | 0 | 1000 | 0 | false |
| sh23 | 100 | 5 | 15 | -5 | 0 | 1 | false |

### `kenshin` — 绯村·剑心 (`kenshin`, sf=1) / 绯村·剑心 拔刀斋 (`kenshin_bdz`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `kenshin` | 绯村·剑心 | 0 | `assets/fighter/kenshin.swf` | 1 | frame2 |
| `kenshin_bdz` | 绯村·剑心 拔刀斋 | 0 | `assets/fighter/kenshin.swf` | 2 | frame3 |

**frame2** (21 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 1 | 7 | 300 | 0 | false |
| tz | 80 | 7 | 10 | 5 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 3 | 0 | 400 | 0 | false |
| k3 | 60 | 6 | 8 | -8 | 600 | 0 | false |
| kj1 | 50 | 1 | -1 | 0 | 500 | 0 | false |
| kj21 | 100 | 6 | 2 | 0 | 500 | 0 | false |
| kj2 | 80 | 3 | 1 | 0 | 500 | 0 | true |
| zh1 | 40 | 4 | 10 | 0 | 300 | 0 | false |
| zh2 | 15 | 1 | 3 | 0 | 600 | 0 | false |
| zh3 | 110 | 6 | 0 | -10 | 800 | 0 | false |
| bs | 60 | 1 | 0 | 0 | 500 | 0 | false |
| bs1 | 60 | 6 | 0 | -5 | 500 | 1 | false |
| sbs | 400 | 6 | 0 | 0 | 0 | 1 | false |
| cbs1 | 300 | 6 | -3 | 0 | 1000 | 0 | false |
| cbs2 | 10 | 2 | -1 | 0 | 1000 | 0 | false |
| cbs | 400 | 5 | 20 | -10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

**frame3** (34 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 1 | 10 | 6 | 300 | 0 | false |
| tk2 | 100 | 5 | 10 | -5 | 0 | 1 | false |
| tz | 170 | 6 | 5 | 0 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 3 | 0 | 400 | 0 | false |
| k3 | 30 | 3 | 5 | 0 | 600 | 0 | false |
| k4 | 60 | 6 | 3 | 0 | 500 | 0 | false |
| k5 | 100 | 6 | 10 | -5 | 500 | 1 | false |
| kj1 | 60 | 6 | 4 | 0 | 500 | 0 | false |
| kj12 | 100 | 6 | 15 | -10 | 0 | 1 | false |
| kj2 | 100 | 6 | 0 | 0 | 500 | 0 | false |
| zh1 | 150 | 6 | 2 | 0 | 0 | 1 | false |
| zh21 | 80 | 6 | 0 | 0 | 500 | 0 | false |
| zh2 | 80 | 7 | 5 | 0 | 600 | 0 | true |
| zh31 | 30 | 1 | 6 | -6 | 700 | 0 | false |
| zh3 | 100 | 7 | 10 | -10 | 0 | 1 | false |
| bs | 60 | 1 | 0 | 0 | 500 | 0 | false |
| bs1 | 60 | 6 | 0 | -5 | 0 | 1 | false |
| sbs | 20 | 1 | 2 | 0 | 300 | 0 | false |
| sbs1 | 20 | 1 | 2 | 0 | 0 | 1 | false |
| kbs1 | 10 | 1 | 0 | 10 | 300 | 0 | false |
| kbs2 | 100 | 3 | 5 | 0 | 800 | 0 | false |
| kbs3 | 100 | 7 | 7 | -7 | 800 | 0 | false |
| kbs4 | 50 | 6 | 3 | 0 | 400 | 0 | false |
| kbs | 120 | 9 | 10 | -10 | 0 | 1 | false |
| cbs1 | 100 | 6 | 5 | 0 | 1000 | 0 | false |
| cbs2 | 10 | 2 | -1 | 0 | 1000 | 0 | false |
| cbs | 300 | 6 | 5 | -5 | 1000 | 0 | true |
| cbs3 | 250 | 5 | 20 | -15 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 1 | 1 | 0 | 500 | 0 | false |
| sh13 | 100 | 3 | 20 | 0 | 0 | 1 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 50 | 0 | -8 | 0 | 1000 | 0 | false |

### `killerbee` — 奇拉比 (`killerbee`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `killerbee` | 奇拉比 | 1 | `assets/fighter/killerbee.swf` | 1 | frame2 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 3 | 4 | 10 | 400 | 0 | false |
| tz | 30 | 1 | 3 | 0 | 400 | 0 | false |
| tz1 | 30 | 1 | 8 | 0 | 0 | 1 | false |
| k1 | 20 | 2 | 3 | 0 | 200 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k3 | 40 | 1 | 4 | 0 | 500 | 0 | false |
| k4 | 80 | 6 | 1 | -6 | 600 | 1 | false |
| kj1 | 30 | 1 | 5 | 0 | 500 | 0 | false |
| kj21 | 60 | 1 | 3 | 0 | 500 | 0 | false |
| kj22 | 60 | 1 | 10 | -8 | 500 | 0 | false |
| kj2 | 80 | 6 | 15 | -7 | 0 | 1 | false |
| zh1 | 40 | 4 | 5 | 0 | 700 | 0 | false |
| zh2 | 180 | 9 | 10 | 0 | 0 | 1 | true |
| zh3 | 140 | 6 | 6 | -6 | 0 | 1 | false |
| bs1 | 80 | 3 | 5 | 0 | 1000 | 0 | false |
| bs2 | 30 | 2 | 3 | 0 | 1000 | 0 | false |
| bs3 | 80 | 3 | 4 | 0 | 1000 | 0 | false |
| bs | 80 | 3 | 3 | 10 | 0 | 1 | false |
| sbs | 280 | 5 | 10 | -10 | 0 | 1 | false |
| cbs1 | 35 | 4 | 5 | -0.2 | 1000 | 0 | false |
| cbs | 100 | 5 | 10 | 0 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 20 | 0 | 0 | 1 | false |

### `konan` — 小南 (`konan`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `konan` | 小南 | 1 | `assets/fighter/konan.swf` | 1 | frame2 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| tk | 40 | 1 | 4 | 8 | 500 | 0 | false |
| tz | 80 | 6 | -10 | -5 | 0 | 1 | false |
| tz2 | 80 | 6 | 10 | -5 | 0 | 1 | false |
| tz3 | 80 | 6 | -10 | 5 | 0 | 1 | false |
| tz4 | 80 | 6 | 10 | 5 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 40 | 1 | 3 | 0 | 500 | 0 | false |
| k3 | 60 | 6 | 4 | 0 | 600 | 0 | false |
| kj1 | 70 | 6 | 3 | 0 | 350 | 0 | false |
| kj12 | 50 | 1 | 5 | -5 | 0 | 1 | false |
| kj2 | 20 | 4 | 5 | -7 | 600 | 0 | false |
| zh1 | 80 | 5 | 4 | -6 | 400 | 1 | false |
| zh2 | 70 | 6 | 0 | -8 | 600 | 0 | false |
| zh31 | 20 | 11 | 0 | 0 | 400 | 0 | true |
| zh3 | 80 | 7 | 10 | 0 | 0 | 1 | false |
| bs | 300 | 5 | 15 | -8 | 0 | 1 | false |
| sbs | 10 | 2 | 0 | 0 | 1000 | 0 | false |
| sbs1 | 150 | 6 | 0 | 0 | 0 | 1 | false |
| cbs1 | 20 | 1 | 0 | 0 | 1000 | 0 | false |
| cbs | 250 | 5 | 10 | 10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

### `lee` — 李·洛克 (`lee`, sf=1) / 李·洛克 杜门 (`lee_dm`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `lee` | 李·洛克 | 1 | `assets/fighter/lee.swf` | 1 | frame2 |
| `lee_dm` | 李·洛克 杜门 | 1 | `assets/fighter/lee.swf` | 2 | frame3 |

**frame2** (27 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 3 | 5 | 600 | 0 | false |
| tz | 70 | 3 | 10 | 10 | 0 | 1 | false |
| k1 | 20 | 2 | 3 | 0 | 400 | 0 | false |
| k2 | 20 | 2 | 5 | 0 | 400 | 0 | false |
| k3 | 30 | 2 | 6 | 0 | 800 | 0 | false |
| k4 | 50 | 3 | 5 | -7 | 600 | 0 | false |
| kj1 | 50 | 3 | 10 | 0 | 400 | 0 | false |
| kj11 | 50 | 3 | 15 | 0 | 0 | 1 | false |
| kj2 | 80 | 3 | 7 | -8 | 0 | 1 | false |
| zh1 | 70 | 5 | 3 | -8 | 800 | 0 | false |
| zh11 | 80 | 3 | 15 | 0 | 0 | 1 | false |
| zh2 | 100 | 3 | 0 | 10 | 0 | 1 | false |
| zh21 | 20 | 2 | 8 | 3 | 800 | 0 | false |
| zh3 | 80 | 5 | 7 | -7 | 800 | 0 | true |
| bs | 80 | 3 | 3 | -20 | 3000 | 0 | false |
| bs1 | 300 | 5 | 5 | -5 | 0 | 1 | true |
| kbs1 | 20 | 2 | 0 | 20 | 500 | 0 | false |
| kbs | 200 | 5 | 10 | -5 | 0 | 1 | false |
| cbs | 150 | 3 | 15 | 10 | 0 | 1 | true |
| cbs1 | 40 | 3 | 10 | 0 | 1000 | 0 | false |
| cbs2 | 40 | 3 | 10 | -10 | 1000 | 0 | false |
| cbs3 | 40 | 3 | -10 | 0 | 1000 | 0 | false |
| cbs4 | 40 | 3 | -10 | -10 | 1000 | 0 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 160 | 3 | 15 | 0 | 0 | 1 | false |

**frame3** (34 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 3 | 8 | 300 | 0 | false |
| tz | 80 | 3 | 10 | 10 | 400 | 1 | false |
| k1 | 20 | 2 | 1 | 0 | 300 | 0 | false |
| k2 | 20 | 2 | 2 | 0 | 200 | 0 | false |
| k3 | 30 | 2 | 4 | 0 | 300 | 0 | false |
| k4 | 20 | 2 | 4 | 0 | 300 | 0 | false |
| k5 | 40 | 3 | 5 | 0 | 400 | 0 | false |
| k6 | 50 | 5 | 15 | 0 | 0 | 1 | false |
| kj1 | 40 | 3 | 3 | 0 | 500 | 0 | false |
| kj12 | 40 | 3 | 3 | 0 | 500 | 0 | false |
| kj13 | 40 | 5 | 5 | -7 | 600 | 0 | false |
| kj2 | 30 | 2 | 0 | -10 | 500 | 0 | false |
| kj21 | 80 | 3 | 5 | -7 | 500 | 0 | false |
| zh1 | 80 | 5 | 5 | 0 | 500 | 0 | false |
| zh2 | 140 | 5 | 15 | 0 | 0 | 1 | true |
| zh3 | 110 | 5 | 10 | -10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 160 | 0 | -10 | -5 | 0 | 1 | false |
| bs1 | 50 | 3 | 0 | -10 | 1000 | 0 | false |
| bs2 | 10 | 2 | 0 | 0 | 1000 | 0 | false |
| bs3 | 0 | 0 | 0 | 0 | 1000 | 0 | false |
| bs4 | 0 | 0 | 0 | -10 | 1000 | 0 | false |
| bs | 140 | 5 | 0 | 20 | 1000 | 1 | false |
| sbs1 | 100 | 5 | 10 | -10 | 1000 | 0 | false |
| sbs | 150 | 7 | 3 | -8 | 1000 | 1 | false |
| kbs1 | 10 | 4 | 5 | 2 | 1000 | 0 | false |
| kbs2 | 10 | 4 | 3 | 0 | 1000 | 0 | false |
| kbs | 150 | 7 | 10 | -8 | 0 | 1 | false |
| cbs1 | 50 | 5 | 3 | 0 | 1000 | 0 | false |
| cbs2 | 20 | 2 | 4 | 0 | 1000 | 0 | false |
| cbs3 | 20 | 2 | 5 | 0 | 1000 | 0 | false |
| cbs | 50 | 7 | 20 | 0 | 1000 | 1 | true |

### `madara` — 宇智波·斑 (`madara`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `madara` | 宇智波·斑 | 1 | `assets/fighter/madara.swf` | 1 | frame2 |

**frame2** (31 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 6 | 5 | 5 | 500 | 0 | false |
| tz | 100 | 7 | 5 | 5 | 0 | 1 | false |
| k1 | 30 | 2 | 5 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 2 | 0 | 300 | 0 | false |
| k3 | 40 | 2 | 2 | -2 | 400 | 0 | false |
| k4 | 60 | 3 | 6 | -8 | 500 | 0 | false |
| k5 | 80 | 5 | 5 | 10 | 0 | 1 | false |
| kj1 | 80 | 6 | 1 | 0 | 500 | 0 | false |
| kj12 | 80 | 5 | 10 | -5 | 0 | 1 | false |
| kj13 | 20 | 4 | 7 | 0 | 300 | 0 | false |
| kj2 | 50 | 3 | -7 | -7 | 500 | 0 | false |
| kj22 | 70 | 3 | 8 | 8 | 1000 | 0 | false |
| zh12 | 30 | 4 | 5 | 0 | 800 | 0 | false |
| zh1 | 60 | 7 | 8 | 0 | 300 | 1 | false |
| zh2 | 80 | 5 | 0 | 7 | 500 | 0 | true |
| zh22 | 50 | 7 | 5 | -5 | 0 | 1 | false |
| zh3 | 150 | 5 | 10 | -10 | 0 | 1 | false |
| sh1 | 10 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 10 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | -10 | -5 | 1000 | 1 | false |
| bs1 | 20 | 4 | 3 | 0 | 1000 | 0 | false |
| bs | 20 | 7 | 5 | -5 | 0 | 1 | true |
| sbs | 100 | 6 | 5 | -5 | 1000 | 0 | false |
| sbs1 | 80 | 6 | 5 | 0 | 1000 | 0 | false |
| sbs2 | 80 | 6 | 3 | -10 | 1000 | 0 | false |
| sbs3 | 100 | 5 | 5 | 20 | 0 | 1 | false |
| cbs | 300 | 5 | 10 | -5 | 1000 | 0 | true |
| cbs2 | 100 | 7 | 5 | -5 | 1000 | 0 | false |
| cbs3 | 100 | 7 | 10 | -10 | 0 | 1 | false |
| kbs | 300 | 5 | 5 | -10 | 0 | 1 | true |

### `mayuri` — 涅茧利 (`mayuri`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `mayuri` | 涅茧利 | 0 | `assets/fighter/mayuri.swf` | 1 | frame2 |

**frame2** (28 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 60 | 6 | 6 | 6 | 500 | 0 | false |
| tz1 | 60 | 3 | 0 | -6 | 500 | 0 | false |
| tz | 120 | 6 | 10 | -6 | 0 | 1 | false |
| k1 | 20 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 60 | 3 | 6 | 0 | 400 | 0 | false |
| k31 | 30 | 2 | 4 | 0 | 400 | 0 | false |
| k3 | 70 | 3 | 5 | 0 | 600 | 0 | false |
| kj1 | 30 | 2 | 3 | 0 | 400 | 0 | false |
| kj12 | 30 | 2 | -10 | 0 | 400 | 0 | false |
| kj2 | 100 | 6 | 9 | -8 | 700 | 0 | false |
| zh1 | 110 | 9 | 10 | 0 | 0 | 1 | false |
| zh2 | 150 | 7 | 10 | -8 | 0 | 1 | true |
| zh31 | 20 | 2 | 12 | -8 | 500 | 0 | false |
| zh3 | 150 | 3 | 10 | 0 | 0 | 1 | false |
| bs1 | 20 | 2 | 5 | 0 | 1000 | 0 | false |
| bs2 | 30 | 3 | 5 | 0 | 1000 | 0 | false |
| bs3 | 50 | 3 | -10 | 0 | 1000 | 0 | false |
| bs4 | 50 | 6 | 8 | -8 | 1000 | 0 | false |
| bs5 | 50 | 3 | -8 | 8 | 1000 | 0 | false |
| bs | 100 | 6 | 15 | 0 | 0 | 1 | false |
| sbs1 | 100 | 6 | 5 | -5 | 500 | 0 | false |
| sbs | 150 | 9 | 10 | -10 | 0 | 1 | false |
| cbs1 | 40 | 4 | 10 | 0 | 1000 | 0 | false |
| cbs | 100 | 5 | 20 | -15 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 5 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

### `naruto` — 漩涡·鸣人 (`naruto`, sf=1) / 漩涡·鸣人 一尾 (`naruto_yw`, sf=2) / 漩涡·鸣人 四尾 (`naruto_sw`, sf=3)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `naruto` | 漩涡·鸣人 | 1 | `assets/fighter/naruto.swf` | 1 | frame2 |
| `naruto_yw` | 漩涡·鸣人 一尾 | 1 | `assets/fighter/naruto.swf` | 2 | frame3 |
| `naruto_sw` | 漩涡·鸣人 四尾 | 1 | `assets/fighter/naruto.swf` | 3 | frame4 |

**frame2** (31 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 3 | 8 | 400 | 0 | false |
| tz | 80 | 3 | 10 | 10 | 400 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 600 | 0 | false |
| k3 | 40 | 2 | 5 | 0 | 600 | 0 | false |
| k4 | 50 | 3 | 5 | -7 | 500 | 0 | false |
| kj1 | 100 | 5 | 8 | -1 | 0 | 1 | true |
| kj2 | 10 | 2 | 3 | 0 | 200 | 0 | false |
| kj22 | 20 | 2 | 5 | 0 | 400 | 0 | false |
| kj23 | 20 | 2 | 3 | 0 | 300 | 0 | false |
| kj24 | 40 | 3 | 5 | 0 | 400 | 0 | false |
| kj25 | 40 | 3 | 4 | -7 | 500 | 0 | false |
| zh1 | 20 | 1 | 3 | 0 | 300 | 0 | false |
| zh2 | 20 | 1 | 5 | 0 | 300 | 0 | false |
| zh3 | 30 | 1 | 10 | -7 | 500 | 0 | false |
| zh32 | 60 | 3 | 8 | 0 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh21 | 20 | 4 | 0 | 0 | 1000 | 0 | false |
| sh22 | 20 | 4 | -10 | 0 | 1000 | 1 | false |
| bs1 | 10 | 4 | 10 | 0 | 1000 | 0 | false |
| bs3 | 30 | 4 | 0 | 0 | 800 | 0 | false |
| bs | 100 | 5 | 10 | 0 | 0 | 1 | true |
| sbs | 30 | 2 | 0 | 2 | 800 | 0 | false |
| sbs2 | 30 | 1 | 10 | 0 | 0 | 1 | false |
| cbs1 | 10 | 1 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 10 | 6 | 0 | -6 | 1000 | 0 | false |
| cbs3 | 30 | 4 | 0 | 10 | 1000 | 0 | true |
| cbs4 | 50 | 4 | 0 | 0 | 800 | 0 | false |
| cbs | 100 | 5 | 20 | 0 | 0 | 1 | false |

**frame3** (20 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 60 | 2 | 3 | 6 | 300 | 0 | false |
| tz | 80 | 3 | 3 | 5 | 400 | 0 | false |
| k1 | 20 | 1 | 2 | 0 | 300 | 0 | false |
| k2 | 60 | 3 | 3 | 0 | 400 | 0 | false |
| k3 | 60 | 6 | 2 | -7 | 500 | 0 | false |
| kj1 | 200 | 3 | 10 | 0 | 0 | 1 | false |
| kj2 | 10 | 11 | 0 | 0 | 800 | 0 | true |
| kj21 | 190 | 3 | 15 | 0 | 0 | 1 | false |
| zh1 | 20 | 1 | 2 | 0 | 500 | 0 | false |
| zh11 | 20 | 2 | -4 | 0 | 500 | 0 | false |
| zh2 | 60 | 3 | 10 | 0 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | -3 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | 10 | 0 | 1000 | 1 | false |
| zh3 | 20 | 1 | 0 | -5 | 500 | 0 | false |
| bs1 | 30 | 4 | 6 | 0 | 800 | 0 | false |
| bs2 | 130 | 5 | 10 | 0 | 0 | 1 | false |
| sbs | 350 | 3 | 15 | -15 | 0 | 1 | false |
| cbs | 500 | 5 | 50 | 0 | 0 | 1 | false |

**frame4** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 3 | 3 | 6 | 300 | 0 | false |
| tz | 80 | 3 | 3 | 5 | 400 | 0 | false |
| k1 | 25 | 1 | 2 | 0 | 400 | 0 | false |
| k2 | 50 | 3 | 10 | 0 | 600 | 0 | false |
| k3 | 80 | 6 | -7 | -7 | 600 | 0 | false |
| kj1 | 120 | 3 | 0 | -10 | 0 | 1 | false |
| kj12 | 120 | 3 | 0 | -10 | 0 | 1 | false |
| kj2 | 100 | 5 | 8 | -5 | 300 | 1 | false |
| zh1 | 60 | 3 | 7 | -3 | 0 | 1 | false |
| zh2 | 110 | 5 | 10 | 0 | 0 | 1 | false |
| zh3 | 20 | 1 | -2 | -5 | 500 | 0 | false |
| zh32 | 30 | 1 | 2 | -6 | 500 | 0 | false |
| zh33 | 30 | 1 | 5 | -8 | 500 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | -3 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | 10 | 0 | 1000 | 1 | false |
| bs | 60 | 3 | 5 | 0 | 500 | 0 | false |
| bs1 | 230 | 5 | 20 | 0 | 0 | 1 | true |
| sbs | 350 | 3 | 10 | -15 | 0 | 1 | false |
| cbs | 350 | 5 | 20 | 0 | 0 | 1 | false |
| cbs2 | 100 | 5 | 20 | 0 | 1000 | 0 | false |
| cbs3 | 300 | 5 | 20 | -20 | 1000 | 1 | false |

### `naruto_xr` — 漩涡·鸣人 仙人 (`naruto_xianren`, sf=1) / 漩涡·鸣人 黄金 (`naruto_gold`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `naruto_xianren` | 漩涡·鸣人 仙人 | 1 | `assets/fighter/naruto_xr.swf` | 1 | frame2 |
| `naruto_gold` | 漩涡·鸣人 黄金 | 1 | `assets/fighter/naruto_xr.swf` | 2 | frame3 |

**frame2** (31 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 2 | 2 | 300 | 0 | false |
| tz1 | 20 | 4 | 5 | 5 | 500 | 0 | false |
| tz2 | 30 | 5 | 0 | 0 | 500 | 0 | false |
| tz | 40 | 5 | 6 | 6 | 0 | 1 | false |
| k1 | 30 | 2 | 1 | 0 | 250 | 0 | false |
| k2 | 20 | 2 | 4 | 0 | 400 | 0 | false |
| k3 | 40 | 3 | 2 | 0 | 500 | 0 | false |
| k4 | 60 | 3 | 5 | -6 | 700 | 0 | false |
| kj1 | 20 | 4 | 0 | 0 | 500 | 0 | false |
| kj12 | 30 | 4 | 5 | 0 | 500 | 0 | false |
| kj21 | 40 | 1 | 2 | 0 | 500 | 0 | false |
| kj2 | 40 | 1 | 3 | -8 | 600 | 0 | false |
| zh1 | 90 | 3 | 5 | -8 | 500 | 0 | false |
| zh2 | 60 | 3 | 10 | 0 | 700 | 0 | true |
| zh21 | 60 | 3 | 10 | -3 | 0 | 1 | false |
| zh3 | 15 | 4 | 5 | -10 | 500 | 0 | false |
| zh31 | 15 | 4 | 3 | -3 | 600 | 0 | false |
| zh33 | 15 | 4 | 3 | -4 | 800 | 0 | false |
| zh32 | 80 | 5 | 10 | -10 | 0 | 1 | false |
| bs | 30 | 4 | 0 | 0 | 500 | 0 | false |
| bs1 | 60 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 260 | 5 | 10 | -10 | 0 | 1 | false |
| kbs1 | 30 | 1 | 0 | 0 | 500 | 0 | false |
| kbs2 | 50 | 1 | 0 | 0 | 500 | 0 | false |
| kbs | 100 | 5 | 10 | 10 | 0 | 1 | true |
| cbs1 | 70 | 4 | 0 | 0 | 500 | 0 | false |
| cbs | 100 | 5 | 20 | -15 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | -10 | -10 | 0 | 1 | false |

**frame3** (36 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 2 | 2 | 2 | 500 | 0 | false |
| tk2 | 40 | 2 | 0 | 8 | 500 | 0 | false |
| tz1 | 10 | 1 | 1 | 20 | 300 | 0 | false |
| tz | 80 | 5 | 10 | -5 | 0 | 1 | false |
| k1 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k3 | 50 | 3 | 2 | 0 | 500 | 0 | false |
| k4 | 30 | 2 | 5 | 0 | 600 | 0 | false |
| k5 | 60 | 3 | 8 | -10 | 0 | 1 | false |
| kj1 | 100 | 3 | 8 | -10 | 700 | 0 | false |
| kj12 | 30 | 2 | 5 | -3 | 500 | 0 | false |
| kj13 | 50 | 3 | 10 | -5 | 0 | 1 | false |
| kj2 | 20 | 2 | 1 | -1 | 700 | 0 | false |
| kj21 | 20 | 2 | 3 | -6 | 700 | 0 | false |
| kj23 | 30 | 4 | 2 | 0 | 500 | 0 | false |
| kj22 | 50 | 5 | 15 | 0 | 0 | 1 | false |
| zh11 | 10 | 1 | 10 | 0 | 600 | 0 | false |
| zh1 | 20 | 4 | 0 | 0 | 500 | 0 | false |
| zh12 | 30 | 5 | 10 | -5 | 0 | 1 | false |
| zh2 | 100 | 3 | 5 | 0 | 0 | 1 | false |
| zh21 | 50 | 11 | 0 | 0 | 1000 | 0 | true |
| zh22 | 50 | 11 | 0 | 0 | 1000 | 0 | true |
| zh3 | 100 | 3 | 15 | 0 | 0 | 1 | false |
| zh31 | 20 | 4 | 2 | 0 | 500 | 0 | false |
| bs | 10 | 1 | 10 | 0 | 500 | 0 | false |
| bs1 | 15 | 4 | 0 | 0 | 500 | 0 | false |
| bs2 | 20 | 5 | 20 | -15 | 0 | 1 | false |
| sbs | 300 | 5 | 15 | -10 | 0 | 1 | false |
| kbs1 | 10 | 2 | 0 | 20 | 0 | 0 | false |
| kbs | 280 | 3 | 0 | 10 | 0 | 1 | false |
| cbs1 | 150 | 5 | 20 | 0 | 1000 | 0 | false |
| cbs | 200 | 5 | 30 | -20 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 0 | -7 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

### `neji` — 日向·宁次 (`neji`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `neji` | 日向·宁次 | 1 | `assets/fighter/neji.swf` | 1 | frame2 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 4 | 0 | 300 | 0 | false |
| tz | 110 | 3 | 3 | 12 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 20 | 2 | 2 | 0 | 400 | 0 | false |
| k3 | 50 | 3 | 1 | 0 | 500 | 0 | false |
| k4 | 60 | 2 | 5 | -7 | 500 | 0 | false |
| kj1 | 50 | 3 | 3 | 0 | 500 | 0 | false |
| kj11 | 8 | 2 | 0 | 0 | 500 | 0 | false |
| kj12 | 50 | 3 | 10 | 0 | 0 | 1 | false |
| kj2 | 30 | 2 | 0 | 0 | 400 | 0 | false |
| zh1 | 50 | 6 | 2 | 0 | 500 | 0 | false |
| zh2 | 90 | 5 | 10 | 0 | 0 | 1 | true |
| zh3 | 90 | 5 | 10 | -10 | 0 | 1 | false |
| bs1 | 30 | 4 | 5 | 0 | 500 | 0 | false |
| bs | 150 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 250 | 5 | 10 | -10 | 0 | 1 | false |
| cbs | 10 | 2 | 2.5 | 0 | 800 | 0 | false |
| cbs2 | 10 | 2 | 1.5 | 0 | 800 | 0 | false |
| cbs3 | 10 | 2 | 6 | 0 | 800 | 0 | false |
| cbs1 | 80 | 3 | 20 | 0 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh21 | 20 | 2 | 0 | 0 | 1000 | 0 | false |
| sh22 | 100 | 3 | 15 | 0 | 0 | 1 | false |

### `obito` — 宇智波·带土 (`obito`, sf=1) / 宇智波·带土 真面目 (`obito_s2`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `obito` | 宇智波·带土 | 1 | `assets/fighter/obito.swf` | 1 | frame2 |
| `obito_s2` | 宇智波·带土 真面目 | 1 | `assets/fighter/obito.swf` | 2 | frame3 |

**frame2** (29 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 50 | 1 | -1 | -2 | 500 | 0 | false |
| tk1 | 50 | 6 | 5 | 10 | 600 | 1 | false |
| k1 | 20 | 2 | 1 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 2 | 0 | 300 | 0 | false |
| k3 | 40 | 3 | 2 | 0 | 300 | 0 | false |
| k4 | 40 | 6 | 4 | 0 | 400 | 0 | false |
| k5 | 60 | 3 | 10 | 0 | 0 | 1 | false |
| kj1 | 50 | 1 | 3 | 0 | 600 | 0 | false |
| kj12 | 60 | 6 | 15 | 0 | 0 | 1 | false |
| kj2 | 30 | 1 | 3 | 0 | 500 | 0 | false |
| zh1 | 30 | 1 | 0 | -3 | 500 | 0 | false |
| zh2 | 130 | 5 | 15 | -3 | 0 | 1 | false |
| zh3 | 5 | 2 | 0 | -1 | 1000 | 0 | true |
| zh31 | 13 | 1 | 0 | -1 | 1000 | 0 | true |
| zh32 | 13 | 1 | 5 | -1 | 1000 | 1 | true |
| bs | 20 | 4 | 2 | 0 | 800 | 0 | false |
| bs1 | 30 | 7 | 5 | 0 | 0 | 1 | false |
| sbs | 0 | 10 | 0 | 0 | 1000 | 0 | true |
| sbs1 | 30 | 6 | 0 | -1 | 1000 | 0 | true |
| sbs2 | 10 | 2 | 0 | -1 | 1000 | 0 | true |
| sbs3 | 90 | 7 | 18 | -2 | 0 | 1 | true |
| sbs4 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| cbs1 | 100 | 5 | 20 | 0 | 1000 | 0 | false |
| cbs | 150 | 5 | 20 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 0 | -7 | 2 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 50 | 6 | 0 | 0 | 500 | 0 | false |
| sh23 | 50 | 3 | 15 | -5 | 0 | 1 | false |

**frame3** (43 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 2 | -3 | 300 | 0 | false |
| tk1 | 50 | 3 | 4 | -3 | 300 | 0 | false |
| tk3 | 600 | 3 | 10 | -20 | 300 | 1 | true |
| tk4 | 0 | 2 | 0 | 0 | 30000 | 0 | true |
| tz | 50 | 7 | 3 | 5 | 400 | 1 | false |
| tz1 | 16 | 2 | -1 | 1 | 400 | 0 | false |
| tz2 | 30 | 7 | 8 | 10 | 400 | 1 | true |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 20 | 2 | 3 | 0 | 300 | 0 | false |
| k3 | 50 | 3 | 8 | 0 | 400 | 0 | false |
| k4 | 50 | 3 | 4 | 0 | 400 | 0 | false |
| k5 | 80 | 5 | 12 | 0 | 0 | 1 | false |
| kj1 | 80 | 6 | 3 | 0 | 500 | 0 | false |
| kj12 | 80 | 6 | 10 | -3 | 0 | 1 | false |
| kj2 | 40 | 1 | 0 | -8 | 500 | 0 | false |
| kj13 | 30 | 10 | 0 | 0 | 40000 | 0 | false |
| kj14 | 850 | 5 | 20 | -20 | 400 | 1 | true |
| zh1 | 20 | 0 | -15 | 0 | 500 | 0 | false |
| zh11 | 50 | 7 | 6 | -3 | 500 | 1 | false |
| zh12 | 20 | 2 | 0 | 0 | 5000 | 0 | true |
| zh13 | 30 | 4 | 0 | -5 | 5000 | 0 | false |
| zh14 | 620 | 5 | 2 | -50 | 500 | 1 | false |
| zh2 | 50 | 5 | 50 | 0 | 300 | 1 | true |
| zh21 | 0 | 0 | 33 | 0 | 3000 | 0 | false |
| zh22 | 0 | 0 | 10 | 0 | 30000 | 0 | false |
| zh23 | 0 | 0 | -33 | 0 | 3000 | 0 | false |
| zh3 | 100 | 7 | 3 | -9 | 700 | 0 | false |
| zh33 | 90 | 7 | 10 | -8 | 0 | 1 | false |
| bs | 80 | 5 | 15 | 15 | 0 | 1 | false |
| bs1 | 50 | 3 | 5 | 0 | 4000 | 0 | false |
| sbs1 | 5 | 2 | 0 | 0 | 5000 | 0 | false |
| sbs | 200 | 5 | 10 | -10 | 0 | 1 | false |
| bs2 | 30 | 2 | 3 | -3 | 4000 | 0 | false |
| bs3 | 50 | 3 | 7 | 7 | 4000 | 0 | false |
| bs4 | 60 | 6 | 5 | -5 | 4000 | 0 | false |
| cbs2 | 10 | 4 | 5 | 0 | 3000 | 0 | false |
| cbs1 | 150 | 5 | 10 | 0 | 3000 | 0 | false |
| cbs | 400 | 5 | 30 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 0 | -8 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 70 | 3 | 8 | 0 | 500 | 0 | false |
| sh23 | 80 | 5 | 15 | 0 | 0 | 1 | false |

### `orihime` — 井上·织姬 (`orihime`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `orihime` | 井上·织姬 | 0 | `assets/fighter/orihime.swf` | 1 | frame2 |

**frame2** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 2 | 3 | 0 | 400 | 0 | false |
| tz | 80 | 5 | 10 | 0 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 4 | 0 | 500 | 0 | false |
| k3 | 70 | 5 | 0 | -5 | 500 | 0 | false |
| kj1 | 30 | 2 | 3 | 0 | 400 | 0 | false |
| kj12 | 70 | 3 | 5 | 0 | 500 | 0 | false |
| kj2 | 10 | 2 | 1 | 0 | 300 | 0 | false |
| zh1 | 100 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 100 | 5 | 10 | 0 | 300 | 1 | true |
| zh22 | 150 | 5 | 5 | 0 | 300 | 1 | false |
| zh3 | 80 | 5 | 7 | -7 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 2 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh21 | 150 | 5 | 0 | -10 | 0 | 1 | false |
| bs | 270 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 100 | 5 | 10 | -5 | 0 | 1 | false |
| cbs1 | 50 | 3 | 2 | 0 | 1000 | 0 | false |
| cbs2 | 30 | 4 | 2 | 0 | 1000 | 0 | false |
| cbs3 | 50 | 5 | 0 | 0 | 1000 | 0 | true |
| cbs5 | 15 | 4 | 0 | 0 | 1000 | 0 | false |
| cbs | 15 | 4 | 10 | 0 | 1000 | 1 | false |

### `orochimaru` — 大蛇丸 (`orochimaru`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `orochimaru` | 大蛇丸 | 1 | `assets/fighter/orochimaru.swf` | 1 | frame2 |

**frame2** (26 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 1 | 2 | 0 | 300 | 0 | false |
| tk2 | 60 | 3 | 0 | 10 | 500 | 1 | false |
| tz | 100 | 3 | 10 | 10 | 0 | 1 | false |
| k1 | 20 | 1 | 2 | 0 | 300 | 0 | false |
| k4 | 20 | 1 | 2 | 0 | 300 | 0 | false |
| k2 | 60 | 6 | 1 | 0 | 400 | 0 | false |
| k3 | 60 | 3 | 2 | -5 | 500 | 0 | false |
| kj1 | 30 | 1 | 2 | 0 | 400 | 0 | false |
| kj11 | 40 | 6 | -3 | 0 | 400 | 0 | false |
| kj2 | 120 | 6 | 0 | -6 | 500 | 0 | false |
| zh1 | 140 | 6 | 10 | 0 | 0 | 1 | false |
| zh2 | 30 | 4 | 0 | 0 | 800 | 0 | true |
| zh3 | 100 | 5 | 7 | -5 | 500 | 0 | false |
| bs | 300 | 6 | 15 | 0 | 0 | 1 | false |
| sbs | 250 | 5 | 5 | -15 | 0 | 1 | false |
| cbs | 300 | 5 | 20 | 0 | 0 | 1 | true |
| cbs1 | 80 | 6 | 5 | 3 | 800 | 0 | false |
| cbs2 | 40 | 1 | 5 | 0 | 800 | 0 | false |
| cbs3 | 60 | 6 | 3 | 0 | 800 | 0 | false |
| cbs4 | 10 | 1 | 0 | -1 | 800 | 0 | true |
| cbs41 | 10 | 1 | 0 | -5 | 800 | 0 | true |
| cbs5 | 70 | 6 | 6 | 0 | 800 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 0 | -10 | -10 | 0 | 1 | false |

### `pain` — 佩恩 (`pain`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `pain` | 佩恩 | 1 | `assets/fighter/pain.swf` | 1 | frame2 |

**frame2** (27 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tz | 90 | 5 | 7 | 7 | 0 | 1 | false |
| tk | 30 | 2 | 3 | -2 | 400 | 0 | false |
| tk2 | 30 | 6 | 3 | 0 | 400 | 0 | false |
| k1 | 30 | 1 | 4 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 4 | 0 | 400 | 0 | false |
| k3 | 40 | 2 | 4 | -4 | 500 | 0 | false |
| k4 | 60 | 5 | 6 | 0 | 800 | 0 | false |
| kj1 | 90 | 6 | 6 | 0 | 600 | 0 | false |
| kj2 | 70 | 5 | 0 | 0 | 600 | 0 | true |
| zh1 | 30 | 2 | 3 | 0 | 500 | 0 | false |
| zh12 | 30 | 2 | 3 | 0 | 500 | 0 | false |
| zh13 | 40 | 7 | 5 | 0 | 0 | 1 | false |
| zh2 | 100 | 3 | 5 | 0 | 600 | 0 | false |
| zh3 | 90 | 3 | 10 | -10 | 0 | 1 | false |
| bs | 260 | 5 | 18 | 0 | 0 | 1 | false |
| sbs | 50 | 5 | 20 | 0 | 0 | 1 | false |
| sbs1 | 30 | 3 | 0 | 0 | 1000 | 0 | false |
| sbs2 | 30 | 6 | 5 | 0 | 1000 | 0 | false |
| sbs3 | 50 | 5 | 4 | 0 | 1000 | 0 | false |
| sbs4 | 40 | 7 | 5 | 0 | 1000 | 0 | false |
| sbs5 | 30 | 4 | 0 | 0 | 1000 | 0 | false |
| cbs1 | 20 | 2 | 0 | 0 | 1000 | 0 | true |
| cbs | 250 | 7 | 20 | 10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 100 | 5 | 10 | 0 | 0 | 1 | false |

### `renji` — 阿散井·恋次 (`renji`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `renji` | 阿散井·恋次 | 0 | `assets/fighter/renji.swf` | 1 | frame2 |

**frame2** (21 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 2 | 6 | 350 | 0 | false |
| tz | 100 | 6 | 6 | 6 | 0 | 1 | false |
| k1 | 20 | 1 | 2 | 0 | 400 | 0 | false |
| k2 | 30 | 1 | 5 | 0 | 400 | 0 | false |
| k3 | 30 | 1 | 4 | 0 | 400 | 0 | false |
| kj1 | 150 | 5 | 8 | -2 | 0 | 1 | true |
| kj2 | 50 | 1 | 0 | -7 | 450 | 0 | false |
| zh1 | 80 | 6 | 2 | 2 | 400 | 0 | false |
| zh2 | 110 | 6 | 4 | -10 | 800 | 0 | false |
| zh3 | 20 | 1 | 2 | 0 | 300 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 7 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 5 | -8 | 0 | 1 | false |
| bs | 50 | 1 | 10 | 0 | 1000 | 0 | false |
| bs1 | 100 | 6 | 10 | 0 | 0 | 1 | false |
| bs2 | 100 | 6 | -5 | 0 | 0 | 1 | false |
| sbs1 | 30 | 1 | 0 | 0 | 1000 | 0 | false |
| sbs | 100 | 6 | 3 | -5 | 0 | 1 | false |
| cbs | 30 | 1 | 10 | 0 | 0 | 0 | false |
| cbs2 | 300 | 5 | 30 | 0 | 0 | 1 | true |

### `rukia` — 朽木·露琪亚 义骸 (`rukia`, sf=1) / 朽木·露琪亚 始解 (`rukia_shijie`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `rukia` | 朽木·露琪亚 义骸 | 0 | `assets/fighter/rukia.swf` | 1 | frame2 |
| `rukia_shijie` | 朽木·露琪亚 始解 | 0 | `assets/fighter/rukia.swf` | 2 | frame3 |

**frame2** (18 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 4 | 3 | 6 | 400 | 0 | false |
| tz | 120 | 5 | 6 | 6 | 0 | 1 | false |
| k1 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 400 | 0 | false |
| k3 | 80 | 3 | 8 | 0 | 600 | 0 | false |
| kj1 | 60 | 5 | 4 | -5 | 500 | 0 | false |
| kj2 | 60 | 4 | 9 | -5 | 400 | 0 | false |
| zh1 | 100 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 30 | 11 | 0 | 0 | 1000 | 0 | true |
| zh3 | 130 | 5 | 6 | -6 | 300 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | -5 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 15 | 0 | 1000 | 1 | false |
| bs | 280 | 5 | 20 | 0 | 0 | 1 | false |
| sbs | 240 | 5 | 15 | 10 | 0 | 1 | false |
| cbs1 | 20 | 4 | 1 | 0 | 0 | 0 | false |
| cbs | 450 | 8 | 3 | -15 | 0 | 1 | false |

**frame3** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 5 | 5 | 600 | 0 | false |
| tz | 80 | 7 | 8 | 0 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 2 | -2 | 400 | 0 | false |
| k3 | 40 | 1 | 5 | 2 | 400 | 0 | false |
| k4 | 60 | 8 | 10 | 0 | 600 | 0 | false |
| kj11 | 15 | 4 | 10 | 0 | 400 | 0 | false |
| kj1 | 70 | 8 | 0 | -5 | 600 | 0 | false |
| kj2 | 20 | 1 | 0 | 0 | 500 | 0 | false |
| kj21 | 60 | 8 | 1 | -4 | 500 | 0 | false |
| zh1 | 90 | 7 | 5 | 0 | 0 | 1 | false |
| zh2 | 50 | 11 | 0 | 0 | 1000 | 0 | true |
| zh3 | 40 | 1 | 10 | -12 | 600 | 0 | false |
| zh31 | 90 | 8 | -10 | 15 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 8 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh21 | 50 | 1 | 5 | -5 | 1000 | 0 | false |
| sh22 | 100 | 8 | 10 | -10 | 1000 | 1 | false |
| bs | 280 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 300 | 8 | 10 | -10 | 0 | 1 | false |
| cbs1 | 150 | 8 | 10 | 0 | 1000 | 0 | false |
| cbs | 100 | 4 | 10 | 0 | 1000 | 0 | false |
| cbs2 | 100 | 4 | 10 | 0 | 0 | 1 | false |

### `sakura` — 春野·樱 (`sakura`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `sakura` | 春野·樱 | 1 | `assets/fighter/sakura.swf` | 1 | frame2 |

**frame2** (29 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 2 | 4 | 8 | 500 | 0 | false |
| tz1 | 10 | 2 | 6 | 8 | 500 | 0 | false |
| tz | 100 | 3 | 10 | -5 | 500 | 1 | false |
| k1 | 30 | 2 | 3 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 5 | 0 | 400 | 0 | false |
| k3 | 60 | 3 | 5 | 0 | 600 | 0 | false |
| kj1 | 30 | 2 | 10 | 0 | 500 | 0 | true |
| kj11 | 80 | 3 | 9 | -3 | 0 | 1 | false |
| kj21 | 30 | 2 | 6 | -1 | 400 | 0 | false |
| kj2 | 60 | 3 | 4 | -5 | 500 | 0 | false |
| zh1 | 30 | 1 | 3 | 0 | 500 | 0 | false |
| zh12 | 30 | 6 | 3 | 0 | 500 | 0 | false |
| zh2 | 60 | 3 | 7 | -8 | 700 | 0 | false |
| zh3 | 130 | 6 | 5 | -5 | 500 | 1 | false |
| zh31 | 130 | 6 | 5 | -5 | 500 | 1 | false |
| zh32 | 130 | 6 | 5 | -5 | 500 | 1 | false |
| bs | 200 | 5 | 10 | -4 | 0 | 1 | true |
| bs1 | 30 | 4 | 0 | 0 | 500 | 0 | false |
| sbs2 | 10 | 2 | 0 | 10 | 500 | 0 | false |
| sbs | 200 | 3 | 10 | 0 | 0 | 1 | false |
| kbs2 | 10 | 2 | 0 | 10 | 500 | 0 | false |
| kbs | 250 | 3 | 10 | 0 | 0 | 1 | false |
| cbs1 | 30 | 2 | 0 | -0.1 | 1000 | 0 | false |
| cbs2 | 50 | 3 | 0 | 0 | 1000 | 0 | true |
| cbs | 100 | 3 | 20 | -2 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | 10 | 10 | 0 | 1 | false |

### `sasuke` — 宇智波·佐助 (`sasuke`, sf=1) / 宇智波·佐助 咒怨 (`sasuke_zy`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `sasuke` | 宇智波·佐助 | 1 | `assets/fighter/sasuke.swf` | 1 | frame2 |
| `sasuke_zy` | 宇智波·佐助 咒怨 | 1 | `assets/fighter/sasuke.swf` | 2 | frame3 |

**frame2** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 2 | 3 | 3 | 500 | 0 | false |
| tz | 50 | 1 | 1 | 10 | 600 | 0 | false |
| k1 | 20 | 2 | 4 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 6 | 0 | 500 | 0 | false |
| k3 | 80 | 6 | 8 | 0 | 500 | 0 | false |
| kj1 | 110 | 9 | 6 | 0 | 0 | 1 | false |
| kj21 | 30 | 1 | 1 | 0 | 400 | 0 | false |
| kj2 | 80 | 9 | 10 | 0 | 0 | 1 | false |
| zh1 | 40 | 2 | 3 | -3 | 400 | 0 | false |
| zh12 | 70 | 3 | 5 | -5 | 0 | 1 | false |
| zh2 | 70 | 9 | 7 | -7 | 500 | 0 | true |
| zh3 | 50 | 3 | 7 | -7 | 700 | 0 | false |
| zh31 | 60 | 3 | 10 | -5 | 0 | 1 | false |
| bs | 300 | 9 | 15 | 0 | 0 | 1 | false |
| sbs | 250 | 9 | 10 | -10 | 0 | 1 | false |
| sbs2 | 250 | 9 | 10 | -10 | 0 | 1 | true |
| cbs1 | 100 | 9 | 10 | -9 | 800 | 0 | true |
| cbs2 | 30 | 1 | 1 | -4 | 1000 | 0 | false |
| cbs3 | 55 | 6 | 3 | 0 | 1000 | 0 | false |
| cbs | 280 | 7 | 30 | 20 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 9 | 0 | -5 | 0 | 1 | false |

**frame3** (20 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 1 | 5 | 3 | 100 | 0 | false |
| tz | 140 | 7 | 10 | 5 | 0 | 1 | false |
| k1 | 30 | 2 | 4 | 0 | 300 | 0 | false |
| k2 | 40 | 2 | 3 | 0 | 500 | 0 | false |
| k3 | 70 | 3 | 8 | -6 | 600 | 0 | false |
| kj2 | 100 | 9 | 10 | -5 | 0 | 1 | false |
| kj1 | 80 | 5 | -10 | 0 | 600 | 0 | false |
| zh1 | 20 | 1 | 5 | 0 | 400 | 0 | false |
| zh2 | 160 | 9 | 10 | -5 | 0 | 1 | true |
| zh3 | 100 | 6 | -8 | -7 | 600 | 0 | false |
| bs1 | 60 | 9 | 10 | 0 | 1000 | 0 | false |
| bs | 30 | 4 | 10 | 0 | 1000 | 0 | false |
| bs2 | 30 | 4 | 10 | 0 | 1000 | 1 | false |
| sbs | 280 | 7 | 10 | -8 | 0 | 1 | false |
| cbs1 | 200 | 9 | 0 | 0 | 500 | 0 | true |
| cbs | 300 | 5 | 15 | -10 | 500 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | -3 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 9 | 15 | 0 | 0 | 1 | false |

### `sasuke_xz` — 宇智波·佐助 须佐能乎 (`sasuke_xz`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `sasuke_xz` | 宇智波·佐助 须佐能乎 | 1 | `assets/fighter/sasuke_xz.swf` | 1 | frame2 |

**frame2** (30 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 9 | 2 | 0 | 500 | 0 | false |
| tz | 130 | 7 | 5 | 10 | 0 | 1 | false |
| k1 | 20 | 1 | 4 | 0 | 300 | 0 | false |
| k2 | 20 | 1 | 4 | 0 | 400 | 0 | false |
| k3 | 40 | 1 | 6 | 0 | 500 | 0 | false |
| k4 | 60 | 6 | 8 | -7 | 500 | 0 | false |
| k5 | 80 | 7 | 8 | -8 | 0 | 1 | false |
| kj1 | 30 | 1 | 2 | 0 | 700 | 0 | false |
| kj11 | 40 | 9 | 0 | 0 | 600 | 0 | false |
| kj12 | 80 | 7 | 5 | -4 | 0 | 1 | false |
| kj21 | 30 | 2 | 3 | 0 | 600 | 0 | false |
| kj2 | 30 | 7 | 10 | 5 | 0 | 1 | false |
| zh1 | 100 | 7 | 7 | 0 | 0 | 1 | false |
| zh11 | 10 | 2 | 1 | 0 | 400 | 0 | false |
| zh2 | 50 | 5 | 4 | 0 | 800 | 0 | false |
| zh21 | 50 | 5 | 4 | -7 | 800 | 0 | false |
| zh22 | 50 | 5 | 7 | 9 | 0 | 1 | true |
| zh3 | 60 | 3 | 5 | -8 | 600 | 0 | false |
| zh31 | 30 | 2 | 3 | -3 | 400 | 0 | false |
| bs | 280 | 7 | 10 | -10 | 0 | 1 | false |
| sbs | 260 | 7 | 12 | -8 | 0 | 1 | false |
| kbs | 260 | 7 | 10 | 10 | 0 | 1 | false |
| cbs1 | 150 | 5 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 150 | 7 | 0 | -3 | 1000 | 0 | true |
| cbs3 | 20 | 4 | 0 | -2 | 1000 | 0 | false |
| cbs | 20 | 4 | 5 | -10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 9 | 3 | -2 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 7 | 0 | -8 | 0 | 1 | false |

### `soifon` — 碎蜂 (`soifon`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `soifon` | 碎蜂 | 0 | `assets/fighter/soifon.swf` | 1 | frame2 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 3 | 3 | 6 | 500 | 0 | false |
| tz | 100 | 6 | 5 | 10 | 0 | 1 | false |
| k1 | 20 | 2 | 2 | 0 | 300 | 0 | false |
| k2 | 30 | 2 | 3 | 0 | 400 | 0 | false |
| k3 | 50 | 3 | 5 | 0 | 400 | 0 | false |
| k4 | 70 | 3 | 5 | 0 | 0 | 1 | false |
| kj1 | 20 | 1 | 2 | 0 | 400 | 0 | false |
| kj2 | 80 | 6 | 5 | -3 | 400 | 0 | false |
| zh1 | 80 | 6 | 3 | 0 | 0 | 1 | false |
| zh2 | 120 | 5 | 10 | 0 | 0 | 1 | true |
| zh3 | 130 | 6 | 10 | -8 | 0 | 1 | false |
| sh10 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh1 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh20 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh2 | 150 | 6 | -6 | -8 | 0 | 1 | false |
| bs | 100 | 6 | 0 | 0 | 800 | 0 | false |
| bs2 | 700 | 5 | 0 | -10 | 0 | 1 | true |
| sbs1 | 20 | 2 | 5 | 0 | 500 | 0 | false |
| sbs2 | 30 | 6 | 6 | -6 | 500 | 0 | false |
| sbs3 | 9 | 1 | 1 | -1 | 500 | 0 | false |
| sbs | 100 | 3 | 2 | 15 | 0 | 1 | false |
| cbs | 500 | 7 | 25 | -8 | 0 | 1 | true |
| kbs | 50 | 9 | 5 | 5 | 1000 | 0 | false |
| kbs2 | 20 | 1 | 0 | -1 | 500 | 0 | false |
| kbs3 | 20 | 1 | 0 | -2 | 500 | 1 | false |

### `temari` — 手鞠 (`temari`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `temari` | 手鞠 | 1 | `assets/fighter/temari.swf` | 1 | frame2 |

**frame2** (24 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 6 | 8 | 500 | 0 | false |
| tz | 50 | 1 | 3 | 0 | 300 | 0 | false |
| tz1 | 50 | 1 | 3 | 0 | 300 | 1 | false |
| tz2 | 50 | 1 | 3 | 0 | 300 | 1 | false |
| k1 | 30 | 2 | 3 | 0 | 400 | 0 | false |
| k2 | 50 | 2 | 5 | 0 | 500 | 0 | false |
| k3 | 80 | 3 | 7 | -8 | 600 | 0 | false |
| kj1 | 120 | 3 | 15 | 0 | 0 | 1 | false |
| kj2 | 100 | 5 | 10 | -10 | 500 | 0 | true |
| zh1 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| zh11 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| zh12 | 20 | 1 | 3 | 0 | 300 | 0 | false |
| zh2 | 120 | 9 | 10 | -5 | 0 | 1 | false |
| zh3 | 40 | 1 | 4 | -4 | 500 | 0 | false |
| zh31 | 40 | 1 | 4 | -4 | 500 | 0 | false |
| zh32 | 40 | 1 | 4 | -4 | 500 | 1 | false |
| bs | 300 | 5 | 20 | -5 | 0 | 1 | false |
| sbs | 250 | 5 | 15 | -15 | 0 | 1 | false |
| cbs1 | 21 | 1 | 2 | -0.5 | 1000 | 0 | false |
| cbs | 25 | 1 | 2 | -0.5 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 3 | 10 | -10 | 0 | 1 | false |

### `toushirou` — 日番谷·东狮郎 (`toushirou`, sf=1) / 日番谷·东狮郎 卍解 (`toushirou_wanjie`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `toushirou` | 日番谷·东狮郎 | 0 | `assets/fighter/toushirou.swf` | 1 | frame2 |
| `toushirou_wanjie` | 日番谷·东狮郎 卍解 | 0 | `assets/fighter/toushirou.swf` | 2 | frame3 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 1 | 5 | 0 | 400 | 0 | false |
| tz | 100 | 8 | 5 | 5 | 500 | 1 | false |
| tz1 | 100 | 8 | 5 | 5 | 500 | 1 | false |
| tz2 | 100 | 8 | 5 | 5 | 0 | 1 | false |
| k1 | 30 | 1 | 2 | 0 | 300 | 0 | false |
| k2 | 40 | 1 | 3 | 0 | 500 | 0 | false |
| k3 | 70 | 6 | 5 | -5 | 400 | 0 | false |
| kj1 | 100 | 5 | 8 | -4 | 0 | 1 | false |
| kj21 | 50 | 1 | 3 | 0 | 300 | 0 | false |
| kj2 | 70 | 8 | 5 | 0 | 0 | 1 | false |
| zh1 | 25 | 4 | 5 | 0 | 200 | 0 | false |
| zh12 | 25 | 4 | 5 | 0 | 200 | 1 | false |
| zh2 | 50 | 8 | 2 | 0 | 1000 | 0 | true |
| zh3 | 40 | 4 | 6 | -7 | 500 | 0 | false |
| bs | 50 | 4 | 15 | 0 | 400 | 0 | false |
| bs2 | 100 | 5 | 20 | 0 | 0 | 1 | false |
| sbs1 | 50 | 6 | 10 | -3 | 500 | 0 | false |
| sbs2 | 50 | 1 | 10 | -3 | 500 | 0 | false |
| sbs | 50 | 1 | 10 | -3 | 0 | 1 | false |
| cbs1 | 10 | 4 | 0 | 0 | 1000 | 0 | false |
| cbs | 300 | 5 | 0 | -10 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 10 | -10 | 0 | 1 | false |

**frame3** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 1 | 0 | 3 | 400 | 0 | false |
| tz | 80 | 5 | 10 | 10 | 0 | 1 | false |
| k1 | 30 | 1 | 3 | 0 | 400 | 0 | false |
| k2 | 40 | 1 | 4 | 0 | 400 | 0 | false |
| k3 | 50 | 6 | 7 | -7 | 500 | 0 | false |
| kj1 | 80 | 6 | 10 | 0 | 0 | 1 | true |
| kj21 | 50 | 6 | 5 | -10 | 600 | 0 | false |
| kj2 | 100 | 5 | 10 | 10 | 0 | 1 | false |
| zh1 | 80 | 6 | 0 | -6 | 300 | 1 | false |
| zh21 | 30 | 6 | 10 | -3 | 500 | 0 | false |
| zh22 | 30 | 1 | 10 | -3 | 500 | 0 | false |
| zh2 | 30 | 1 | 10 | -3 | 0 | 1 | false |
| zh3 | 40 | 4 | 5 | -7 | 500 | 0 | false |
| bs | 50 | 8 | 0 | 0 | 1000 | 0 | true |
| bs1 | 200 | 5 | 20 | 0 | 0 | 1 | true |
| sbs | 320 | 6 | 3 | -8 | 0 | 1 | false |
| cbs1 | 10 | 4 | 0 | 10 | 0 | 0 | false |
| cbs | 400 | 5 | 20 | 0 | 0 | 1 | false |
| cbs3 | 10 | 4 | 0 | -1 | 5000 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 20 | 0 | 0 | 1 | false |

### `ulquiorra` — 乌尔奇奥拉 (`ulquiorra`, sf=1) / 乌尔奇奥拉 归刃 (`ulquiorra_guiren`, sf=2)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `ulquiorra` | 乌尔奇奥拉 | 0 | `assets/fighter/ulquiorra.swf` | 1 | frame2 |
| `ulquiorra_guiren` | 乌尔奇奥拉 归刃 | 0 | `assets/fighter/ulquiorra.swf` | 2 | frame3 |

**frame2** (22 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 70 | 6 | 3 | 1 | 500 | 0 | false |
| tz | 130 | 5 | 5 | 10 | 0 | 1 | false |
| k1 | 20 | 2 | 5 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 5 | 0 | 300 | 0 | false |
| k3 | 70 | 3 | 8 | 0 | 700 | 0 | false |
| kj1 | 80 | 1 | 10 | -5 | 600 | 0 | false |
| kj12 | 100 | 5 | 10 | -5 | 0 | 1 | false |
| kj2 | 100 | 6 | 8 | -10 | 600 | 0 | false |
| zh1 | 100 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 40 | 4 | 5 | -7 | 800 | 0 | true |
| zh3 | 120 | 5 | 10 | -8 | 0 | 1 | false |
| bs | 280 | 5 | 25 | 0 | 0 | 1 | false |
| sbs | 10 | 1 | 13 | -13 | 500 | 0 | false |
| sbs1 | 200 | 5 | 20 | 5 | 0 | 1 | false |
| kbs | 10 | 1 | 13 | 13 | 500 | 0 | false |
| kbs1 | 250 | 5 | 20 | 5 | 0 | 1 | false |
| cbs1 | 150 | 5 | 30 | -10 | 0 | 1 | true |
| cbs | 50 | 4 | 10 | -0.1 | 1000 | 0 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 0 | -7 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 5 | 15 | 0 | 0 | 1 | false |

**frame3** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 80 | 5 | 6 | 0 | 500 | 0 | false |
| tz | 120 | 5 | 10 | 7 | 0 | 1 | false |
| k1 | 30 | 1 | 4 | 0 | 300 | 0 | false |
| k2 | 30 | 1 | 3 | 0 | 300 | 0 | false |
| k3 | 60 | 6 | 5 | 0 | 500 | 0 | false |
| k4 | 100 | 5 | 15 | 0 | 0 | 1 | false |
| kj1 | 160 | 5 | 15 | 0 | 0 | 1 | true |
| kj21 | 40 | 1 | 0 | -18 | 600 | 0 | false |
| kj22 | 30 | 1 | 0 | -1 | 500 | 0 | false |
| kj2 | 130 | 7 | 10 | 10 | 0 | 1 | false |
| zh1 | 150 | 5 | 10 | 0 | 0 | 1 | false |
| zh2 | 100 | 6 | 10 | -10 | 700 | 0 | false |
| zh3 | 160 | 6 | 10 | -7 | 0 | 1 | false |
| bs1 | 40 | 4 | 5 | 0 | 500 | 0 | false |
| bs | 50 | 5 | 15 | 0 | 0 | 1 | false |
| sbs | 260 | 5 | 5 | -10 | 0 | 1 | false |
| cbs1 | 100 | 6 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 100 | 6 | 0 | -1 | 1000 | 0 | false |
| cbs | 300 | 5 | 20 | 0 | 0 | 1 | true |
| kbs1 | 20 | 2 | 0 | 10 | 400 | 0 | false |
| kbs | 250 | 5 | 15 | 10 | 0 | 1 | false |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 6 | -7 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 6 | 2 | -5 | 0 | 1 | false |

### `uryuu` — 石田·雨龙 (`uryuu`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `uryuu` | 石田·雨龙 | 0 | `assets/fighter/uryuu.swf` | 1 | frame2 |

**frame2** (23 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 20 | 4 | 4 | 2 | 400 | 0 | false |
| tz | 80 | 5 | 8 | 5 | 0 | 1 | false |
| k1 | 20 | 4 | 4 | 0 | 500 | 0 | false |
| k2 | 40 | 4 | 6 | 0 | 700 | 0 | false |
| k3 | 30 | 4 | 7 | 0 | 500 | 0 | false |
| k31 | 30 | 4 | 7 | 0 | 500 | 0 | false |
| k32 | 30 | 4 | 7 | 0 | 500 | 0 | false |
| kj1 | 130 | 5 | 8 | -2 | 0 | 1 | false |
| kj2 | 80 | 3 | 10 | -8 | 600 | 0 | false |
| zh1 | 130 | 5 | 10 | 0 | 0 | 1 | false |
| zh21 | 50 | 6 | 0 | 20 | 500 | 0 | false |
| zh2 | 100 | 5 | 0 | -8 | 1000 | 0 | true |
| zh3 | 150 | 5 | 10 | -10 | 0 | 1 | false |
| bs | 300 | 5 | 20 | 0 | 0 | 1 | false |
| sbs | 280 | 5 | 10 | 10 | 0 | 1 | false |
| cbs | 60 | 5 | 10 | -15 | 0 | 1 | true |
| cbs1 | 130 | 5 | 0 | 0 | 1000 | 0 | false |
| cbs2 | 60 | 4 | 0 | -3 | 1000 | 0 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 20 | 2 | -3 | -6 | 1000 | 0 | false |
| sh23 | 150 | 5 | 0 | -15 | 0 | 1 | false |

### `yin` — 市丸·银 (`yin`, sf=1)

XML 对照：

| xml id | name | comic_type | file | startFrame | engine frame |
|---|---|---|---|---|---|
| `yin` | 市丸·银 | 0 | `assets/fighter/yin.swf` | 1 | frame2 |

**frame2** (25 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 40 | 4 | 4 | 8 | 600 | 0 | false |
| tz | 100 | 6 | 10 | 10 | 0 | 1 | false |
| k1 | 20 | 2 | 5 | 0 | 300 | 0 | false |
| k2 | 20 | 2 | 3 | 0 | 400 | 0 | false |
| k3 | 50 | 1 | 5 | 0 | 500 | 0 | false |
| k4 | 50 | 1 | 5 | -5 | 700 | 0 | false |
| k5 | 80 | 6 | 10 | 0 | 0 | 1 | false |
| kj1 | 20 | 1 | 2 | 0 | 500 | 0 | false |
| kj2 | 80 | 6 | 3 | 0 | 500 | 0 | false |
| kj21 | 40 | 1 | 10 | -6 | 0 | 1 | false |
| zh1 | 30 | 4 | 3 | 0 | 400 | 0 | false |
| zh12 | 30 | 4 | -8 | 0 | 400 | 0 | false |
| zh2 | 130 | 5 | 15 | 0 | 0 | 1 | true |
| zh3 | 40 | 4 | 2 | -2 | 400 | 0 | false |
| zh31 | 40 | 4 | -8 | 8 | 400 | 0 | false |
| bs | 300 | 5 | 20 | 0 | 0 | 1 | false |
| sbs | 30 | 1 | 0 | -1 | 500 | 0 | false |
| sbs1 | 50 | 1 | 8 | -8 | 0 | 1 | false |
| cbs1 | 20 | 4 | 5 | 0 | 500 | 0 | false |
| cbs | 300 | 5 | 20 | 0 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | 0 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 30 | 1 | 0 | 0 | 300 | 0 | false |
| sh23 | 30 | 1 | 10 | 0 | 0 | 1 | false |

## 辅助角色

### `fz/byakuya` — 朽木·白哉 (`byakuya`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `byakuya` | 朽木·白哉 | 0 | `assets/fighter/fz/byakuya.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 50 | 11 | 0 | 0 | 1750 | 0 | false |

### `fz/gaara` — 我爱罗 (`garra`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `garra` | 我爱罗 | 1 | `assets/fighter/fz/gaara.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 50 | 5 | 0 | 0 | 2000 | 0 | false |

### `fz/grimmjow` — 葛力姆乔·贾卡杰克 (`grimmjow`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `grimmjow` | 葛力姆乔·贾卡杰克 | 0 | `assets/fighter/fz/grimmjow.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 2 | 3 | 0 | 500 | 0 | false |
| atm2 | 5 | 1 | 0 | 0 | 500 | 0 | false |
| atm3 | 50 | 6 | 5 | 0 | 0 | 1 | false |

### `fz/harribel` — 蒂雅.赫丽贝尔 (`halibel`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `halibel` | 蒂雅.赫丽贝尔 | 0 | `assets/fighter/fz/harribel.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 110 | 5 | 10 | 0 | 500 | 1 | false |

### `fz/hinata` — 日向·雏田 (`hinata`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `hinata` | 日向·雏田 | 1 | `assets/fighter/fz/hinata.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 4 | 5 | 0 | 1000 | 0 | true |

### `fz/ichigo_padipata` — 黑崎·一护·修行 (`ichigo_padipata`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `ichigo_padipata` | 黑崎·一护·修行 | 0 | `assets/fighter/fz/ichigo_padipata.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 150 | 5 | 5 | 0 | 500 | 1 | true |

### `fz/ichigo_white2` — 一护·虚·二段 (`ichigo_white2`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `ichigo_white2` | 一护·虚·二段 | 0 | `assets/fighter/fz/ichigo_white2.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 30 | 1 | 10 | -10 | 500 | 0 | false |
| atm2 | 10 | 1 | 5 | -5 | 500 | 0 | false |
| atm3 | 50 | 5 | 10 | 10 | 0 | 1 | true |

### `fz/ino` — 山中·井野 (`ino`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `ino` | 山中·井野 | 1 | `assets/fighter/fz/ino.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 5 | 0 | 0 | 2000 | 0 | false |

### `fz/itachi` — 宇智波·鼬 (`itachi`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `itachi` | 宇智波·鼬 | 1 | `assets/fighter/fz/itachi.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 0 | 4 | 0 | 0 | 2000 | 0 | false |
| atm2 | 20 | 1 | 0 | 0 | 600 | 0 | false |
| atm3 | 40 | 1 | -3 | 0 | 0 | 1 | false |

### `fz/jiraiya` — 自来也 (`jiraiya`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `jiraiya` | 自来也 | 1 | `assets/fighter/fz/jiraiya.swf` |

**file** (2 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 50 | 4 | 3 | 0 | 800 | 0 | false |
| atm2 | 50 | 5 | 15 | 0 | 0 | 1 | false |

### `fz/kenpachi` — 更木·剑八 (`kenpachi`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `kenpachi` | 更木·剑八 | 0 | `assets/fighter/fz/kenpachi.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 100 | 5 | 15 | 0 | 0 | 1 | true |

### `fz/kimimaro` — 君麻吕 (`kimimaro`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `kimimaro` | 君麻吕 | 1 | `assets/fighter/fz/kimimaro.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 15 | 1 | 0 | 0 | 400 | 0 | false |

### `fz/kon` — 魂 (`kon`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `kon` | 魂 | 0 | `assets/fighter/fz/kon.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 2 | 1 | 0 | 300 | 0 | false |

### `fz/madara` — 宇智波·斑 (`madara`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `madara` | 宇智波·斑 | 1 | `assets/fighter/fz/madara.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 3 | 0 | 0 | 1000 | 0 | true |
| atm2 | 10 | 4 | 0 | 0 | 1000 | 0 | false |
| atm3 | 100 | 7 | 10 | 0 | 0 | 1 | false |

### `fz/minato` — 四代火影 (`minato`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `minato` | 四代火影 | 1 | `assets/fighter/fz/minato.swf` |

**file** (5 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 5 | 0 | 20 | 0 | 1 | false |
| atm3 | 20 | 3 | 5 | -10 | 1000 | 0 | false |
| atm5 | 5 | 4 | 0 | 20 | 300 | 0 | false |
| atm2 | 20 | 3 | 5 | 0 | 1000 | 0 | false |
| atm4 | 20 | 6 | -4 | 0 | 1000 | 0 | true |

### `fz/nemu` — 涅音梦 (`nemu`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `nemu` | 涅音梦 | 0 | `assets/fighter/fz/nemu.swf` |

**file** (2 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 2 | 3 | 0 | 500 | 0 | false |
| atm2 | 40 | 3 | 10 | 0 | 500 | 0 | true |

### `fz/obito` — 宇智波·带土 (`obito`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `obito` | 宇智波·带土 | 1 | `assets/fighter/fz/obito.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 100 | 7 | 5 | 5 | 700 | 0 | false |

### `fz/orihime` — 井上·织姬 (`orihime`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `orihime` | 井上·织姬 | 0 | `assets/fighter/fz/orihime.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 0 | 0 | 0 | 0 | 0 | 0 | false |

### `fz/rangiku` — 松本·乱菊 (`rangiku`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `rangiku` | 松本·乱菊 | 0 | `assets/fighter/fz/rangiku.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 4 | 0 | 0 | 500 | 0 | false |

### `fz/sai` — 佐井 (`sai`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `sai` | 佐井 | 1 | `assets/fighter/fz/sai.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 4 | 0 | -5 | 800 | 0 | false |

### `fz/shikamaru` — 奈良·鹿丸 (`shikamaru`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `shikamaru` | 奈良·鹿丸 | 1 | `assets/fighter/fz/shikamaru.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 11 | 0 | 0 | 2000 | 0 | true |

### `fz/shishio` — 志志雄·真实 (`shishio`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `shishio` | 志志雄·真实 | 0 | `assets/fighter/fz/shishio.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 11 | 0 | 0 | 500 | 0 | true |
| atm3 | 50 | 1 | 0 | 0 | 500 | 0 | false |
| atm2 | 50 | 7 | 15 | 0 | 0 | 1 | false |

### `fz/soifon` — 碎蜂 (`soifon`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `soifon` | 碎蜂 | 0 | `assets/fighter/fz/soifon.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 150 | 7 | 15 | -8 | 0 | 1 | true |

### `fz/stake` — 托尼·斯塔克 (`stake`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `stake` | 托尼·斯塔克 | 0 | `assets/fighter/fz/stake.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 2 | 4 | 0 | 500 | 0 | false |
| atm2 | 20 | 1 | 2 | 0 | 500 | 0 | false |
| atm3 | 100 | 5 | 10 | 0 | 800 | 1 | false |

### `fz/suigetsu` — 鬼灯·水月 (`suigetsu`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `suigetsu` | 鬼灯·水月 | 1 | `assets/fighter/fz/suigetsu.swf` |

**file** (2 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 1 | 3 | 0 | 500 | 0 | false |
| atm2 | 50 | 6 | 5 | -5 | 600 | 0 | false |

### `fz/temari` — 手鞠 (`temari`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `temari` | 手鞠 | 1 | `assets/fighter/fz/temari.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 4 | 0.5 | -1 | 300 | 0 | false |

### `fz/tenten` — 天天 (`tenten`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `tenten` | 天天 | 1 | `assets/fighter/fz/tenten.swf` |

**file** (2 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 10 | 1 | 2 | 0 | 800 | 0 | false |
| atm2 | 50 | 6 | 10 | 0 | 0 | 1 | false |

### `fz/tsuchikage` — 土影 (`tsuchikage`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `tsuchikage` | 土影 | 1 | `assets/fighter/fz/tsuchikage.swf` |

**file** (3 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 20 | 2 | 5 | 0 | 500 | 0 | false |
| atm2 | 50 | 1 | 10 | 0 | 500 | 0 | false |
| atm3 | 100 | 3 | 10 | 0 | 0 | 1 | false |

### `fz/tsunate` — 纲手 (`tsunate`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `tsunate` | 纲手 | 1 | `assets/fighter/fz/tsunate.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 50 | 5 | 15 | 0 | 500 | 1 | false |

### `fz/uryuu` — 石田·雨龙 (`uryuu`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `uryuu` | 石田·雨龙 | 0 | `assets/fighter/fz/uryuu.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 80 | 5 | 3 | 10 | 500 | 0 | false |

### `fz/yachiru` — 草鹿·八千流 (`yachiru`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `yachiru` | 草鹿·八千流 | 0 | `assets/fighter/fz/yachiru.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 50 | 3 | 5 | -2 | 700 | 0 | false |

### `fz/yamamoto` — 山本元柳斎重国 (`yamamoto`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `yamamoto` | 山本元柳斎重国 | 0 | `assets/fighter/fz/yamamoto.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 200 | 7 | 5 | -10 | 0 | 1 | true |

### `fz/yin` — 市丸·银 (`yin`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `yin` | 市丸·银 | 0 | `assets/fighter/fz/yin.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 150 | 5 | 10 | 0 | 0 | 1 | true |

### `fz/yoruichi` — 四枫院·夜一 (`yoruichi`)

XML 对照：

| xml id | name | comic_type | file |
|---|---|---|---|
| `yoruichi` | 四枫院·夜一 | 0 | `assets/fighter/fz/yoruichi.swf` |

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 0 | 0 | 0 | 0 | 0 | 0 | false |

## 未出现在 fighter.xml / assist.xml 的目录

### `fz/soifong`

**file** (1 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| atm1 | 150 | 7 | 15 | -8 | 0 | 1 | true |

### `sasuke_xz_old`

**frame2** (33 moves)
| id | power | hitType | hitx | hity | hurtTime | hurtType | isBreakDef |
|---|---:|---:|---:|---:|---:|---:|---|
| tk | 30 | 2 | 8 | -5 | 400 | 0 | false |
| tk2 | 40 | 3 | 4 | 10 | 500 | 0 | false |
| tk1 | 100 | 3 | 10 | -3 | 0 | 1 | false |
| tz | 150 | 9 | 5 | 0 | 0 | 1 | false |
| k1 | 20 | 1 | 4 | 0 | 400 | 0 | false |
| k2 | 20 | 1 | 4 | 0 | 400 | 0 | false |
| k3 | 50 | 9 | 6 | -2 | 500 | 0 | false |
| k4 | 60 | 9 | 4 | 2 | 400 | 0 | false |
| k5 | 80 | 9 | 8 | -4 | 700 | 1 | false |
| kj1 | 70 | 3 | 10 | 0 | 700 | 0 | false |
| kj12 | 30 | 1 | 5 | 0 | 400 | 0 | false |
| kj13 | 100 | 9 | 10 | 0 | 0 | 1 | false |
| kj21 | 30 | 2 | 3 | -1 | 400 | 0 | false |
| kj22 | 30 | 2 | 4 | -1 | 400 | 0 | false |
| kj2 | 50 | 3 | 8 | -10 | 800 | 0 | false |
| zh1 | 150 | 9 | 15 | 0 | 0 | 1 | false |
| zh2 | 10 | 11 | 0 | 0 | 1000 | 0 | true |
| zh21 | 60 | -1 | 0 | 0 | 1000 | 0 | false |
| zh22 | 10 | -1 | 10 | -10 | 0 | 1 | false |
| zh3 | 150 | 9 | 10 | -10 | 0 | 1 | false |
| bs2 | 25 | 2 | 0 | 0 | 500 | 0 | false |
| bs | 50 | 7 | 10 | -10 | 0 | 1 | false |
| sbs | 300 | 7 | 20 | 0 | 0 | 1 | false |
| kbs | 50 | 4 | 8 | 4 | 600 | 0 | false |
| kbs2 | 150 | 7 | 15 | 0 | 0 | 1 | false |
| cbs3 | 30 | 6 | 60 | 0 | 1000 | 0 | false |
| cbs1 | 30 | 1 | 60 | 0 | 1000 | 0 | false |
| cbs2 | 50 | 4 | 0 | 0 | 1000 | 0 | false |
| cbs | 100 | 7 | 30 | -20 | 0 | 1 | true |
| sh1 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh12 | 50 | 3 | 5 | -5 | 1000 | 0 | false |
| sh2 | 0 | 11 | 0 | 0 | 1000 | 0 | true |
| sh22 | 150 | 9 | 10 | -10 | 0 | 1 | false |

