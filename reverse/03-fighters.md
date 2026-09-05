# 03 角色 SWF — decompiled/fighters 全目录对照 XML

权威源：`extracted/assets/config/fighter.xml`、`assist.xml`，以及 `decompiled/fighters/`（468 个 `.as`，76 个角色目录）。
引擎加载：`GameLoader.loadFighter` / `loadAssister` → `ZipCtrler.getLoader(fileUrl)` → `FighterMain` / `Assister`。
皮肤选择：`FighterMain.initlize()` 执行 `_mainMc.gotoAndStop(data.startFrame + 1)`。XML `startFrame="1"` 对应时间轴第 **2** 帧（第 1 帧是 `stop()`）。

总索引：[`../BVN-FULL-REVERSE.md`](../BVN-FULL-REVERSE.md)。类路径：[`CLASS-INDEX.md`](CLASS-INDEX.md)。

## 约定：MainTimeline / defineAction / bdmn / atm*

### 可玩角色（fighters/<id>/）

每个可玩 SWF 的文档类是 `<name>_fla.MainTimeline`，动态 MovieClip，暴露：

| 方法 | 谁调用 | 作用 |
|---|---|---|
| `setFighterCtrler(ctrl)` | `FighterMain.initlize` | 注入 `FighterCtrler` 到 `$fighter_ctrler` |
| `setFighterMcCtrler(ctrl)` | 引擎初始化 MC | 注入 `FighterMcCtrler` 到 `$mc_ctrler` |
| `setEffectCtrler(ctrl)` | 同上 | 注入 `FighterEffectCtrl` 到 `$effect_ctrler` |
| `frameN()` | `addFrameScript` | 对应皮肤帧上批量 `defineAction` |

`defineAction(id, vo)` 把招式 id 登记进 `FighterHitModel`。常见 id：

| id | 含义 |
|---|---|
| `tk` | 跳踢 / 空中轻 |
| `tz` | 跳重 |
| `k1` `k2` `k3` | 地面轻中重连段 |
| `kj1` `kj2` `kj21` | 空中技 |
| `zh1` `zh2` `zh3` | 招式 1/2/3（zhao） |
| `sh1` `sh12` `sh2` `sh22` | 技能 1/2 及其分支 |
| `bs` `bs1` | 必杀 / 必杀变体 |
| `sbs` | 超级必杀 |
| `cbs` | 超必杀 / 觉醒必杀 |

VO 字段（一护 `ichigo_fla/MainTimeline.as` 实测）：`power`、`hitType`、`hitx`、`hity`、`hurtTime`、`hurtType`、`isBreakDef`。

证据：`decompiled/fighters/ichigo/scripts/ichigo_fla/MainTimeline.as` 第 61 行起 `this.$fighter_ctrler.defineAction("tk", {power:30,...})`。

### 实例名约定（动作剪辑内部）

`FighterMC.renderChildren` / `findBodyArea` 与 `Assister.renderChildren` 把下列实例名当特殊对象，**不**当普通循环动画推进：

| 实例名 | 引擎用法 |
|---|---|
| `bdmn` | 身体判定盒挂点。`FighterMC` `getChildByName("bdmn")` 取 bounds 写入 `_bodyAreaCache` |
| `AImain` | 角色动作总剪辑，跳过自动 nextFrame |
| `atm*`（`k1atm`、`bsatm`、`atm1`…） | 攻击判定剪辑。名字含 `atm` 即跳过自动循环；命中模型按 displayName 反查 `HitVO` |
| `bsfaceN` | 必杀大脸（独立文档类 `bsface1.as`） |

证据：`decompiled/main/scripts/net/play5d/game/bvn/fighter/FighterMC.as` 第 191、333 行；`Assister.as` 第 177 行。

辅助角色文档类同样是 `MainTimeline`，但注入的是 `setAssistCtrler` → `defineActions()` → `$assisterCtrler.defineAction("atm1", {...})`。例：`decompiled/fighters/fz/kon/scripts/kon_fla/MainTimeline.as`。

### 同一 SWF 多皮肤

13 个可玩 SWF 被多个 `fighter id` 共享，靠 `startFrame` 切时间轴：

| SWF | XML id（startFrame） |
|---|---|
| `assets/fighter/byakuya.swf` | `byakuya`（朽木·白哉 / sf=1）, `byakuya_wanjie`（朽木·白哉 卍解 / sf=2） |
| `assets/fighter/ichigo.swf` | `ichigo`（黑崎·一护 / sf=1）, `ichigo_wanjie`（黑崎·一护 卍解 / sf=2）, `ichigo_xuhua_half`（黑崎·一护 半虚 / sf=3）, `ichigo_xuhua`（黑崎·一护 虚化 / sf=4） |
| `assets/fighter/ichigo_zero.swf` | `ichigo_zero`（黑崎·一护 零段 / sf=1）, `ichigo_neixu`（黑崎·一护 内虚 / sf=2）, `ichigo_neixu_wanjie`（黑崎·一护 内虚 卍解 / sf=3） |
| `assets/fighter/kenshin.swf` | `kenshin`（绯村·剑心 / sf=1）, `kenshin_bdz`（绯村·剑心 拔刀斋 / sf=2） |
| `assets/fighter/lee.swf` | `lee`（李·洛克 / sf=1）, `lee_dm`（李·洛克 杜门 / sf=2） |
| `assets/fighter/naruto.swf` | `naruto`（漩涡·鸣人 / sf=1）, `naruto_yw`（漩涡·鸣人 一尾 / sf=2）, `naruto_sw`（漩涡·鸣人 四尾 / sf=3） |
| `assets/fighter/naruto_xr.swf` | `naruto_xianren`（漩涡·鸣人 仙人 / sf=1）, `naruto_gold`（漩涡·鸣人 黄金 / sf=2） |
| `assets/fighter/obito.swf` | `obito`（宇智波·带土 / sf=1）, `obito_s2`（宇智波·带土 真面目 / sf=2） |
| `assets/fighter/rukia.swf` | `rukia`（朽木·露琪亚 义骸 / sf=1）, `rukia_shijie`（朽木·露琪亚 始解 / sf=2） |
| `assets/fighter/sasuke.swf` | `sasuke`（宇智波·佐助 / sf=1）, `sasuke_zy`（宇智波·佐助 咒怨 / sf=2） |
| `assets/fighter/toushirou.swf` | `toushirou`（日番谷·东狮郎 / sf=1）, `toushirou_wanjie`（日番谷·东狮郎 卍解 / sf=2） |
| `assets/fighter/ulquiorra.swf` | `ulquiorra`（乌尔奇奥拉 / sf=1）, `ulquiorra_guiren`（乌尔奇奥拉 归刃 / sf=2） |

`random` / `random_bleach` / `random_naruto` 没有 `file` 节点，由选人逻辑在运行时抽真实 id。

引擎公式：`gotoAndStop(startFrame + 1)`。因此 XML `startFrame=1` → 时间轴帧 2（`frame2` 写 defineAction），`startFrame=4` → 帧 5。

## 可玩角色 XML 全表（fighter.xml，59 条）

`comic_type`：`0` 死神侧，`1` 火影侧，`-1` 随机。脸图：`face` 选人小图，`big_url` 大图，`bar_url` 血条头，`win_url` 胜利图。

| id | 中文名 | ct | fileUrl | startFrame | face | 反编译目录 | .as 数 |
|---|---|---|---|---|---|---|---|
| `ichigo` | 黑崎·一护 | 0 | `assets/fighter/ichigo.swf` | 1 | `assets/face/ichigo.png` | `ichigo` | 23 |
| `ichigo_wanjie` | 黑崎·一护 卍解 | 0 | `assets/fighter/ichigo.swf` | 2 | `assets/face/ichigo_wj.png` | `ichigo` | 23 |
| `ichigo_xuhua_half` | 黑崎·一护 半虚 | 0 | `assets/fighter/ichigo.swf` | 3 | `assets/face/ichigo_xh_half.png` | `ichigo` | 23 |
| `ichigo_xuhua` | 黑崎·一护 虚化 | 0 | `assets/fighter/ichigo.swf` | 4 | `assets/face/ichigo_xh.png` | `ichigo` | 23 |
| `ichigo_zero` | 黑崎·一护 零段 | 0 | `assets/fighter/ichigo_zero.swf` | 1 | `assets/face/ichigo_zero.png` | `ichigo_zero` | 24 |
| `ichigo_neixu` | 黑崎·一护 内虚 | 0 | `assets/fighter/ichigo_zero.swf` | 2 | `assets/face/ichigo_white.png` | `ichigo_zero` | 24 |
| `ichigo_neixu_wanjie` | 黑崎·一护 内虚 卍解 | 0 | `assets/fighter/ichigo_zero.swf` | 3 | `assets/face/ichigo_white.png` | `ichigo_zero` | 24 |
| `rukia` | 朽木·露琪亚 义骸 | 0 | `assets/fighter/rukia.swf` | 1 | `assets/face/rukia.png` | `rukia` | 8 |
| `rukia_shijie` | 朽木·露琪亚 始解 | 0 | `assets/fighter/rukia.swf` | 2 | `assets/face/rukia_sj.png` | `rukia` | 8 |
| `renji` | 阿散井·恋次 | 0 | `assets/fighter/renji.swf` | 1 | `assets/face/renji.png` | `renji` | 7 |
| `kenpachi` | 更木·剑八 | 0 | `assets/fighter/kenpachi.swf` | 1 | `assets/face/kenpachi.png` | `kenpachi` | 9 |
| `ikkaku` | 斑目·一角 | 0 | `assets/fighter/ikkaku.swf` | 1 | `assets/face/ikkaku.png` | `ikkaku` | 7 |
| `yin` | 市丸·银 | 0 | `assets/fighter/yin.swf` | 1 | `assets/face/yin.png` | `yin` | 9 |
| `chad` | 茶渡·泰虎 | 0 | `assets/fighter/chad.swf` | 1 | `assets/face/chad.png` | `chad` | 5 |
| `uryuu` | 石田·雨龙 | 0 | `assets/fighter/uryuu.swf` | 1 | `assets/face/uryuu.png` | `uryuu` | 11 |
| `toushirou` | 日番谷·东狮郎 | 0 | `assets/fighter/toushirou.swf` | 1 | `assets/face/toushirou.png` | `toushirou` | 12 |
| `toushirou_wanjie` | 日番谷·东狮郎 卍解 | 0 | `assets/fighter/toushirou.swf` | 2 | `assets/face/toushirou_wj.png` | `toushirou` | 12 |
| `byakuya` | 朽木·白哉 | 0 | `assets/fighter/byakuya.swf` | 1 | `assets/face/byakuya.png` | `byakuya` | 9 |
| `byakuya_wanjie` | 朽木·白哉 卍解 | 0 | `assets/fighter/byakuya.swf` | 2 | `assets/face/byakuya_wj.png` | `byakuya` | 9 |
| `ulquiorra` | 乌尔奇奥拉 | 0 | `assets/fighter/ulquiorra.swf` | 1 | `assets/face/ulquiorra.png` | `ulquiorra` | 10 |
| `ulquiorra_guiren` | 乌尔奇奥拉 归刃 | 0 | `assets/fighter/ulquiorra.swf` | 2 | `assets/face/ulquiorra_gr.png` | `ulquiorra` | 10 |
| `aizen` | 蓝染·惣右介 | 0 | `assets/fighter/aizen.swf` | 1 | `assets/face/aizen.png` | `aizen` | 10 |
| `mayuri` | 涅茧利 | 0 | `assets/fighter/mayuri.swf` | 1 | `assets/face/mayuri.png` | `mayuri` | 12 |
| `orihime` | 井上·织姬 | 0 | `assets/fighter/orihime.swf` | 1 | `assets/face/orihime.png` | `orihime` | 10 |
| `grimmjow` | 葛力姆乔·贾卡杰克 | 0 | `assets/fighter/grimmjow.swf` | 1 | `assets/face/grimmjow.png` | `grimmjow` | 11 |
| `soifon` | 碎蜂 | 0 | `assets/fighter/soifon.swf` | 1 | `assets/face/soifon.png` | `soifon` | 11 |
| `naruto` | 漩涡·鸣人 | 1 | `assets/fighter/naruto.swf` | 1 | `assets/face/naruto.png` | `naruto` | 18 |
| `naruto_yw` | 漩涡·鸣人 一尾 | 1 | `assets/fighter/naruto.swf` | 2 | `assets/face/naruto_yw.png` | `naruto` | 18 |
| `naruto_sw` | 漩涡·鸣人 四尾 | 1 | `assets/fighter/naruto.swf` | 3 | `assets/face/naruto_yw.png` | `naruto` | 18 |
| `sakura` | 春野·樱 | 1 | `assets/fighter/sakura.swf` | 1 | `assets/face/sakura.png` | `sakura` | 7 |
| `sasuke` | 宇智波·佐助 | 1 | `assets/fighter/sasuke.swf` | 1 | `assets/face/sasuke.png` | `sasuke` | 11 |
| `sasuke_zy` | 宇智波·佐助 咒怨 | 1 | `assets/fighter/sasuke.swf` | 2 | `assets/face/sasuke_zy.png` | `sasuke` | 11 |
| `sasuke_xz` | 宇智波·佐助 须佐能乎 | 1 | `assets/fighter/sasuke_xz.swf` | 1 | `assets/face/sasuke_xz.png` | `sasuke_xz` | 9 |
| `karin` | 漩涡·香磷 | 1 | `assets/fighter/karin.swf` | 1 | `assets/face/karin.png` | `karin` | 9 |
| `juggo` | 天秤·重吾 | 1 | `assets/fighter/juggo.swf` | 1 | `assets/face/juggo.png` | `juggo` | 8 |
| `itachi` | 宇智波·鼬 | 1 | `assets/fighter/itachi.swf` | 1 | `assets/face/itachi.png` | `itachi` | 14 |
| `didala` | 迪达拉 | 1 | `assets/fighter/didala.swf` | 1 | `assets/face/didala.png` | `didala` | 6 |
| `kakashi` | 旗木·卡卡西 | 1 | `assets/fighter/kakashi.swf` | 1 | `assets/face/kakashi.png` | `kakashi` | 10 |
| `kakashi_sw` | 旗木·卡卡西 神威 | 1 | `assets/fighter/kakashi_sw.swf` | 1 | `assets/face/kakashi_sw.png` | `kakashi_sw` | 6 |
| `lee` | 李·洛克 | 1 | `assets/fighter/lee.swf` | 1 | `assets/face/lee.png` | `lee` | 14 |
| `lee_dm` | 李·洛克 杜门 | 1 | `assets/fighter/lee.swf` | 2 | `assets/face/lee.png` | `lee` | 14 |
| `neji` | 日向·宁次 | 1 | `assets/fighter/neji.swf` | 1 | `assets/face/neji.png` | `neji` | 12 |
| `gaara` | 我爱罗 | 1 | `assets/fighter/gaara.swf` | 1 | `assets/face/gaara.png` | `gaara` | 9 |
| `temari` | 手鞠 | 1 | `assets/fighter/temari.swf` | 1 | `assets/face/temari.png` | `temari` | 6 |
| `jiraiya` | 自来也 | 1 | `assets/fighter/jiraiya.swf` | 1 | `assets/face/jiraiya.png` | `jiraiya` | 8 |
| `orochimaru` | 大蛇丸 | 1 | `assets/fighter/orochimaru.swf` | 1 | `assets/face/orochimaru.png` | `orochimaru` | 9 |
| `killerbee` | 奇拉比 | 1 | `assets/fighter/killerbee.swf` | 1 | `assets/face/killerbee.png` | `killerbee` | 5 |
| `pain` | 佩恩 | 1 | `assets/fighter/pain.swf` | 1 | `assets/face/pain.png` | `pain` | 17 |
| `konan` | 小南 | 1 | `assets/fighter/konan.swf` | 1 | `assets/face/konan.png` | `konan` | 6 |
| `naruto_xianren` | 漩涡·鸣人 仙人 | 1 | `assets/fighter/naruto_xr.swf` | 1 | `assets/face/naruto_xr.png` | `naruto_xr` | 15 |
| `naruto_gold` | 漩涡·鸣人 黄金 | 1 | `assets/fighter/naruto_xr.swf` | 2 | `assets/face/naruto_xr.png` | `naruto_xr` | 15 |
| `obito` | 宇智波·带土 | 1 | `assets/fighter/obito.swf` | 1 | `assets/face/obito.png` | `obito` | 12 |
| `obito_s2` | 宇智波·带土 真面目 | 1 | `assets/fighter/obito.swf` | 2 | `assets/face/obito.png` | `obito` | 12 |
| `madara` | 宇智波·斑 | 1 | `assets/fighter/madara.swf` | 1 | `assets/face/madara.png` | `madara` | 8 |
| `kenshin` | 绯村·剑心 | 0 | `assets/fighter/kenshin.swf` | 1 | `assets/face/kenshin.png` | `kenshin` | 9 |
| `kenshin_bdz` | 绯村·剑心 拔刀斋 | 0 | `assets/fighter/kenshin.swf` | 2 | `assets/face/kenshin.png` | `kenshin` | 9 |
| `random` | 随机人物 | -1 | `—` | — | `assets/face/random.png` | `—` | 0 |
| `random_bleach` | 随机死神人物 | 0 | `—` | — | `assets/face/random_bleach.png` | `—` | 0 |
| `random_naruto` | 随机炎影人物 | 1 | `—` | — | `assets/face/random_naruto.png` | `—` | 0 |

注：同一 SWF 多行会重复「反编译目录 / .as 数」，这是皮肤共享，不是重复反编译。

## 辅助角色 XML 全表（assist.xml，37 条）

| id | 中文名 | ct | fileUrl | face | 反编译目录 | .as 数 |
|---|---|---|---|---|---|---|
| `kon` | 魂 | 0 | `assets/fighter/fz/kon.swf` | `assets/face/kon.png` | `fz/kon` | 1 |
| `orihime` | 井上·织姬 | 0 | `assets/fighter/fz/orihime.swf` | `assets/face/orihime.png` | `fz/orihime` | 1 |
| `yoruichi` | 四枫院·夜一 | 0 | `assets/fighter/fz/yoruichi.swf` | `assets/face/yoruichi.png` | `fz/yoruichi` | 1 |
| `uryuu` | 石田·雨龙 | 0 | `assets/fighter/fz/uryuu.swf` | `assets/face/uryuu.png` | `fz/uryuu` | 1 |
| `kenpachi` | 更木·剑八 | 0 | `assets/fighter/fz/kenpachi.swf` | `assets/face/kenpachi.png` | `fz/kenpachi` | 1 |
| `ichigo_white2` | 一护·虚·二段 | 0 | `assets/fighter/fz/ichigo_white2.swf` | `assets/face/ichigo_white2.png` | `fz/ichigo_white2` | 2 |
| `yachiru` | 草鹿·八千流 | 0 | `assets/fighter/fz/yachiru.swf` | `assets/face/yachiru.png` | `fz/yachiru` | 1 |
| `stake` | 托尼·斯塔克 | 0 | `assets/fighter/fz/stake.swf` | `assets/face/stake.png` | `fz/stake` | 1 |
| `halibel` | 蒂雅.赫丽贝尔 | 0 | `assets/fighter/fz/harribel.swf` | `assets/face/halibel.png` | `fz/harribel` | 1 |
| `grimmjow` | 葛力姆乔·贾卡杰克 | 0 | `assets/fighter/fz/grimmjow.swf` | `assets/face/grimmjow.png` | `fz/grimmjow` | 1 |
| `soifon` | 碎蜂 | 0 | `assets/fighter/fz/soifon.swf` | `assets/face/soifon.png` | `fz/soifon` | 2 |
| `nemu` | 涅音梦 | 0 | `assets/fighter/fz/nemu.swf` | `assets/face/nemu.png` | `fz/nemu` | 1 |
| `ichigo_padipata` | 黑崎·一护·修行 | 0 | `assets/fighter/fz/ichigo_padipata.swf` | `assets/face/ichigo_padipata.png` | `fz/ichigo_padipata` | 1 |
| `yamamoto` | 山本元柳斎重国 | 0 | `assets/fighter/fz/yamamoto.swf` | `assets/face/yamamoto.png` | `fz/yamamoto` | 1 |
| `yin` | 市丸·银 | 0 | `assets/fighter/fz/yin.swf` | `assets/face/yin.png` | `fz/yin` | 2 |
| `rangiku` | 松本·乱菊 | 0 | `assets/fighter/fz/rangiku.swf` | `assets/face/rangiku.png` | `fz/rangiku` | 1 |
| `byakuya` | 朽木·白哉 | 0 | `assets/fighter/fz/byakuya.swf` | `assets/face/byakuya.png` | `fz/byakuya` | 2 |
| `garra` | 我爱罗 | 1 | `assets/fighter/fz/gaara.swf` | `assets/face/gaara.png` | `fz/gaara` | 1 |
| `temari` | 手鞠 | 1 | `assets/fighter/fz/temari.swf` | `assets/face/temari.png` | `fz/temari` | 1 |
| `ino` | 山中·井野 | 1 | `assets/fighter/fz/ino.swf` | `assets/face/ino.png` | `fz/ino` | 1 |
| `tenten` | 天天 | 1 | `assets/fighter/fz/tenten.swf` | `assets/face/tenten.png` | `fz/tenten` | 1 |
| `itachi` | 宇智波·鼬 | 1 | `assets/fighter/fz/itachi.swf` | `assets/face/itachi.png` | `fz/itachi` | 1 |
| `hinata` | 日向·雏田 | 1 | `assets/fighter/fz/hinata.swf` | `assets/face/hinata.png` | `fz/hinata` | 1 |
| `tsunate` | 纲手 | 1 | `assets/fighter/fz/tsunate.swf` | `assets/face/tsunate.png` | `fz/tsunate` | 1 |
| `tsuchikage` | 土影 | 1 | `assets/fighter/fz/tsuchikage.swf` | `assets/face/tsuchikage.png` | `fz/tsuchikage` | 1 |
| `minato` | 四代火影 | 1 | `assets/fighter/fz/minato.swf` | `assets/face/minato.png` | `fz/minato` | 1 |
| `jiraiya` | 自来也 | 1 | `assets/fighter/fz/jiraiya.swf` | `assets/face/jiraiya.png` | `fz/jiraiya` | 1 |
| `suigetsu` | 鬼灯·水月 | 1 | `assets/fighter/fz/suigetsu.swf` | `assets/face/suigetsu.png` | `fz/suigetsu` | 1 |
| `sai` | 佐井 | 1 | `assets/fighter/fz/sai.swf` | `assets/face/sai.png` | `fz/sai` | 1 |
| `madara` | 宇智波·斑 | 1 | `assets/fighter/fz/madara.swf` | `assets/face/madara.png` | `fz/madara` | 2 |
| `kimimaro` | 君麻吕 | 1 | `assets/fighter/fz/kimimaro.swf` | `assets/face/kimimaro.png` | `fz/kimimaro` | 1 |
| `shikamaru` | 奈良·鹿丸 | 1 | `assets/fighter/fz/shikamaru.swf` | `assets/face/shikamaru.png` | `fz/shikamaru` | 2 |
| `obito` | 宇智波·带土 | 1 | `assets/fighter/fz/obito.swf` | `assets/face/obito.png` | `fz/obito` | 1 |
| `shishio` | 志志雄·真实 | 0 | `assets/fighter/fz/shishio.swf` | `assets/face/shishio.png` | `fz/shishio` | 2 |
| `random` | 随机人物 | -1 | `—` | `assets/face/random.png` | `—` | 0 |
| `random_bleach` | 随机死神人物 | 0 | `—` | `assets/face/random_bleach.png` | `—` | 0 |
| `random_naruto` | 随机火影人物 | 1 | `—` | `assets/face/random_naruto.png` | `—` | 0 |

### XML id 与 SWF 文件名不一致

| XML id | 实际 fileUrl | 说明 |
|---|---|---|
| `garra` | `assets/fighter/fz/gaara.swf` | 辅助「我爱罗」id 拼写与可玩 `gaara` 不同 |
| `halibel` | `assets/fighter/fz/harribel.swf` | 脸图 `halibel.png`，SWF 目录 `fz/harribel` |

## decompiled/fighters 76 个目录（每人一行）

下列目录全部实扫。`sasuke_xz_old` 与 `fz/soifong` **不在** 当前 XML 引用中，是包内遗留 SWF。

合计目录 **76**。

| 目录 | .as | 脚本文件（相对 scripts/） | XML 引用 |
|---|---|---|---|
| `decompiled/fighters/aizen/` | 10 | `aizen_fla/AI面_2.as`, `aizen_fla/MainTimeline.as`, `aizen_fla/元件15_7.as`, `aizen_fla/元件18_8.as`, `aizen_fla/元件32_12.as`, `aizen_fla/元件92_14.as`, `aizen_fla/蓝染全动作_1.as`, `bsface1.as`, `bsface2.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/byakuya/` | 9 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `byakuya_fla/AI面副本2_15.as`, `byakuya_fla/AI面副本_2.as`, `byakuya_fla/MainTimeline.as`, `byakuya_fla/sprite631_14.as`, `byakuya_fla/一护万解全动作_1.as`, `byakuya_fla/元件6_21.as` | 是 |
| `decompiled/fighters/chad/` | 5 | `bsface1.as`, `chad_fla/AI面副本_2.as`, `chad_fla/MainTimeline.as`, `chad_fla/一护万解全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/didala/` | 6 | `bsface1.as`, `bsface2.as`, `didala_fla/AI_2.as`, `didala_fla/MainTimeline.as`, `didala_fla/Timeline_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/gaara/` | 9 | `bsface1.as`, `bsface2.as`, `gaara_fla/AI_2.as`, `gaara_fla/MainTimeline.as`, `gaara_fla/Timeline_1.as`, `gaara_fla/Timeline_11.as`, `gaara_fla/Timeline_7.as`, `gaara_fla/Timeline_9.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/grimmjow/` | 11 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `grimmjow_fla/AI面_2.as`, `grimmjow_fla/MainTimeline.as`, `grimmjow_fla/一护全动作_1.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurt3.as`, `snd_hurt4.as` | 是 |
| `decompiled/fighters/ichigo/` | 23 | `bsface1.as`, `bsface10.as`, `bsface2.as`, `bsface3.as`, `bsface4.as`, `bsface5.as`, `bsface6.as`, `bsface7.as`, `bsface8.as`, `bsface9.as`, `ichigo_fla/AI面_2.as`, `ichigo_fla/AI面_31.as`, `ichigo_fla/AI面副本_16.as`, `ichigo_fla/MainTimeline.as`, `ichigo_fla/sprite185_56.as`, `ichigo_fla/一护万解全动作_15.as`, `ichigo_fla/一护全动作_1.as`, `ichigo_fla/一护全动作_30.as`, `ichigo_fla/一护虚化全动作_60.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `wksound.as` | 是 |
| `decompiled/fighters/ichigo_zero/` | 24 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `bsface4.as`, `bsface5.as`, `bsface6.as`, `bsface7.as`, `ichigo_zero_fla/AI面2_12.as`, `ichigo_zero_fla/AI面_2.as`, `ichigo_zero_fla/AI面副本_30.as`, `ichigo_zero_fla/MainTimeline.as`, `ichigo_zero_fla/一护万解全动作_29.as`, `ichigo_zero_fla/一护全动作_1.as`, `ichigo_zero_fla/元件7_35.as`, `ichigo_zero_fla/必杀效果_20.as`, `ichigo_zero_fla/必杀效果副本_23.as`, `ichigo_zero_fla/招1刀光副本_38.as`, `ichigo_zero_fla/白一护全动作_11.as`, `kcsound.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurt_ogihci_1.as`, `wksound.as` | 是 |
| `decompiled/fighters/ikkaku/` | 7 | `bsface1.as`, `bsface2.as`, `ikkaku_fla/AI面_2.as`, `ikkaku_fla/MainTimeline.as`, `ikkaku_fla/sprite2397_8.as`, `ikkaku_fla/鸣人全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/itachi/` | 14 | `bsface1.as`, `bsface2.as`, `itachi_fla/AI面_2.as`, `itachi_fla/MainTimeline.as`, `itachi_fla/元件271_22.as`, `itachi_fla/卡卡西_1.as`, `itachi_fla/卡卡西_上必杀_狗S_15.as`, `itachi_fla/天照特效_16.as`, `itachi_fla/月读1_18.as`, `itachi_fla/鼬_幻术1_9.as`, `itachi_fla/鼬_幻术2_12.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as` | 是 |
| `decompiled/fighters/jiraiya/` | 8 | `bsface1.as`, `bsface2.as`, `jiraiya_fla/AI面_2.as`, `jiraiya_fla/MainTimeline.as`, `jiraiya_fla/元件15_5.as`, `jiraiya_fla/元件190_12.as`, `jiraiya_fla/自来也全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/juggo/` | 8 | `bsface1.as`, `bsface2.as`, `juggo_fla/AI面_2.as`, `juggo_fla/MainTimeline.as`, `juggo_fla/Symbol1_10.as`, `juggo_fla/招1刀光副本3_11.as`, `juggo_fla/迪达拉全动作_XIN_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/kakashi/` | 10 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `kakashi_fla/AI_2.as`, `kakashi_fla/MainTimeline.as`, `kakashi_fla/Timeline_1.as`, `kakashi_fla/Timeline_10.as`, `kakashi_fla/Timeline_11.as`, `kakashi_fla/Timeline_12.as`, `kakashi_fla/Timeline_7.as` | 是 |
| `decompiled/fighters/kakashi_sw/` | 6 | `kakashi_sw_fla/AI面_2.as`, `kakashi_sw_fla/MainTimeline.as`, `kakashi_sw_fla/人物全动作_1.as`, `snd_hurt1.as`, `snd_hurt2.as`, `§ snd_die§.as` | 是 |
| `decompiled/fighters/karin/` | 9 | `bsface1.as`, `bsface2.as`, `karin_fla/AI面_2.as`, `karin_fla/MainTimeline.as`, `karin_fla/Symbol2copy_14.as`, `karin_fla/元件174_10.as`, `karin_fla/元件511_18.as`, `karin_fla/卡卡西_1.as`, `karin_fla/招1刀光副本2_15.as` | 是 |
| `decompiled/fighters/kenpachi/` | 9 | `bsface1.as`, `bsface2.as`, `kenpachi_fla/AI面_2.as`, `kenpachi_fla/MainTimeline.as`, `kenpachi_fla/元件2_9.as`, `kenpachi_fla/元件5_10.as`, `kenpachi_fla/元件67副本_12.as`, `kenpachi_fla/剑八全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/kenshin/` | 9 | `kenshin_fla/AI面_16.as`, `kenshin_fla/AI面_2.as`, `kenshin_fla/MainTimeline.as`, `kenshin_fla/win_13.as`, `kenshin_fla/win_29.as`, `kenshin_fla/元件181_25.as`, `kenshin_fla/元件20_22.as`, `kenshin_fla/全动作_1.as`, `kenshin_fla/全动作_15.as` | 是 |
| `decompiled/fighters/killerbee/` | 5 | `bsface1.as`, `bsface2.as`, `killerbee_fla/AI面_2.as`, `killerbee_fla/MainTimeline.as`, `killerbee_fla/八尾人柱力全动作_1.as` | 是 |
| `decompiled/fighters/konan/` | 6 | `bsface1.as`, `bsface2.as`, `konan_fla/AI面_2.as`, `konan_fla/MainTimeline.as`, `konan_fla/卡卡西_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/lee/` | 14 | `bsface1.as`, `bsface2.as`, `lee_fla/AI面_11.as`, `lee_fla/AI面_2.as`, `lee_fla/MainTimeline.as`, `lee_fla/Timeline_7.as`, `lee_fla/sprite124_17.as`, `lee_fla/元件16_7.as`, `lee_fla/元件21_18.as`, `lee_fla/元件35_21.as`, `lee_fla/元件36_22.as`, `lee_fla/小李杜门_10.as`, `lee_fla/樱_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/madara/` | 8 | `bsface1.as`, `bsface2.as`, `madara_fla/AI面_2.as`, `madara_fla/MainTimeline.as`, `madara_fla/鸣人全动作_1.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as` | 是 |
| `decompiled/fighters/mayuri/` | 12 | `bsface1.as`, `bsface2.as`, `mayuri_fla/AI_2.as`, `mayuri_fla/MainTimeline.as`, `mayuri_fla/Symbol4_9.as`, `mayuri_fla/Symbol5_10.as`, `mayuri_fla/Timeline_1.as`, `mayuri_fla/Timeline_11.as`, `mayuri_fla/Timeline_12.as`, `mayuri_fla/Timeline_6.as`, `snd_hurt1.as`, `snd_hurt2.as` | 是 |
| `decompiled/fighters/naruto/` | 18 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `bsface4.as`, `bsface5.as`, `bsface6.as`, `naruto_fla/AI面_2.as`, `naruto_fla/AI面副本2_31.as`, `naruto_fla/AI面副本_20.as`, `naruto_fla/MainTimeline.as`, `naruto_fla/元件13_15.as`, `naruto_fla/四尾全动作_30.as`, `naruto_fla/鸣人__砍技2副本2_7.as`, `naruto_fla/鸣人__砍技2副本_8.as`, `naruto_fla/鸣人_砍技2_13.as`, `naruto_fla/鸣人九尾全动作_19.as`, `naruto_fla/鸣人全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/naruto_xr/` | 15 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `bsface4.as`, `bsface5.as`, `naruto_xr_fla/AI面_2.as`, `naruto_xr_fla/MainTimeline.as`, `naruto_xr_fla/元件28_29.as`, `naruto_xr_fla/元件2_9.as`, `naruto_xr_fla/元件35_25.as`, `naruto_xr_fla/元件36_26.as`, `naruto_xr_fla/元件38_32.as`, `naruto_xr_fla/空中必杀特效_11.as`, `naruto_xr_fla/鸣人全动作_1.as`, `naruto_xr_fla/鸣人全动作副本_16.as` | 是 |
| `decompiled/fighters/neji/` | 12 | `bsface1.as`, `bsface2.as`, `neji_fla/AI面_2.as`, `neji_fla/MainTimeline.as`, `neji_fla/一护全动作_1.as`, `snd_die.as`, `snd_die2.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurt3.as`, `snd_hurtfly1.as`, `snd_hurtfly2.as` | 是 |
| `decompiled/fighters/obito/` | 12 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `obito_fla/AI面_15.as`, `obito_fla/AI面_2.as`, `obito_fla/MainTimeline.as`, `obito_fla/元件12_26.as`, `obito_fla/元件229_10.as`, `obito_fla/元件37_6.as`, `obito_fla/元件511_35.as`, `obito_fla/樱_1.as`, `obito_fla/鸣人全动作_14.as` | 是 |
| `decompiled/fighters/orihime/` | 10 | `bsface1.as`, `bsface2.as`, `orihime_fla/AI面_2.as`, `orihime_fla/MainTimeline.as`, `orihime_fla/元件22副本_7.as`, `orihime_fla/元件36_19.as`, `orihime_fla/织姬全动作_1.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as` | 是 |
| `decompiled/fighters/orochimaru/` | 9 | `bsface1.as`, `bsface2.as`, `orochimaru_fla/AI面_2.as`, `orochimaru_fla/MainTimeline.as`, `orochimaru_fla/一护全动作_1.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurt3.as` | 是 |
| `decompiled/fighters/pain/` | 17 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `pain_fla/AI面_2.as`, `pain_fla/MainTimeline.as`, `pain_fla/万象牵引_12.as`, `pain_fla/上必杀效果1_23.as`, `pain_fla/人间道_上必杀_26.as`, `pain_fla/人间道_跳砍_9.as`, `pain_fla/佩恩_1.as`, `pain_fla/修罗道_2_27.as`, `pain_fla/恶鬼道_1_29.as`, `pain_fla/招1_人物_14.as`, `pain_fla/招1_人物副本_18.as`, `pain_fla/招2效果_20.as`, `pain_fla/招2效果副本_21.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/renji/` | 7 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `renji_fla/AI面_2.as`, `renji_fla/MainTimeline.as`, `renji_fla/一护全动作_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/rukia/` | 8 | `bsface1.as`, `bsface2.as`, `rukia_fla/AI面_2.as`, `rukia_fla/AI面副本_9.as`, `rukia_fla/MainTimeline.as`, `rukia_fla/露琪雅2_8.as`, `rukia_fla/露琪雅_1.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/sakura/` | 7 | `bsface1.as`, `bsface2.as`, `sakura_fla/AI面_2.as`, `sakura_fla/MainTimeline.as`, `sakura_fla/元件12_10.as`, `sakura_fla/元件6_6.as`, `sakura_fla/樱_1.as` | 是 |
| `decompiled/fighters/sasuke/` | 11 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `sasuke_fla/AI面_2.as`, `sasuke_fla/AI面副本_13.as`, `sasuke_fla/MainTimeline.as`, `sasuke_fla/佐助_1.as`, `sasuke_fla/佐助_超必杀效果_9.as`, `sasuke_fla/佐助咒化_12.as`, `sasuke_fla/麒麟1_19.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/sasuke_xz/` | 9 | `bsface1.as`, `bsface2.as`, `sasuke_xz_fla/AI面_2.as`, `sasuke_xz_fla/MainTimeline.as`, `sasuke_xz_fla/加具土命效果_15.as`, `sasuke_xz_fla/天照效果22_13.as`, `sasuke_xz_fla/须作_1.as`, `sasuke_xz_fla/须作_砍技2效果_9.as`, `snd_hurt1.as` | 是 |
| `decompiled/fighters/sasuke_xz_old/` | 9 | `bsface1.as`, `bsface2.as`, `sasuke_xz_old_fla/AI_2.as`, `sasuke_xz_old_fla/MainTimeline.as`, `sasuke_xz_old_fla/Timeline_1.as`, `sasuke_xz_old_fla/Timeline_11.as`, `sasuke_xz_old_fla/Timeline_9.as`, `sasuke_xz_old_fla/adfsasdfasdfadsfasdads_8.as`, `snd_hurt1.as` | **否（遗留）** |
| `decompiled/fighters/soifon/` | 11 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurt3.as`, `soifon_fla/AI面_2.as`, `soifon_fla/MainTimeline.as`, `soifon_fla/元件21_10.as`, `soifon_fla/爆炸特效_14.as`, `soifon_fla/碎蜂全动作_1.as` | 是 |
| `decompiled/fighters/temari/` | 6 | `bsface1.as`, `snd_hurt1.as`, `temari_fla/AI面副本_2.as`, `temari_fla/MainTimeline.as`, `temari_fla/佐助咒化_1.as`, `temari_fla/元件10_9.as` | 是 |
| `decompiled/fighters/toushirou/` | 12 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `snd_hurt1.as`, `snd_hurt2.as`, `toushirou_fla/AI面_9.as`, `toushirou_fla/AI面副本_2.as`, `toushirou_fla/MainTimeline.as`, `toushirou_fla/万解全动作_8.as`, `toushirou_fla/元件10_6.as`, `toushirou_fla/元件16_18.as`, `toushirou_fla/全动作_1.as` | 是 |
| `decompiled/fighters/ulquiorra/` | 10 | `bsface1.as`, `ulquiorra_fla/AI面副本2_10.as`, `ulquiorra_fla/AI面副本_2.as`, `ulquiorra_fla/MainTimeline.as`, `ulquiorra_fla/一护虚化全动作_1.as`, `ulquiorra_fla/一护虚化全动作副本_9.as`, `ulquiorra_fla/元件22_7.as`, `ulquiorra_fla/元件34_14.as`, `ulquiorra_fla/元件34副本_18.as`, `ulquiorra_fla/元件37_16.as` | 是 |
| `decompiled/fighters/uryuu/` | 11 | `bsface1.as`, `bsface2.as`, `bsface3.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `snd_hurtfly.as`, `uryuu_fla/AI_2.as`, `uryuu_fla/MainTimeline.as`, `uryuu_fla/Timeline_1.as`, `uryuu_fla/Timeline_13.as` | 是 |
| `decompiled/fighters/yin/` | 9 | `bsface1.as`, `bsface2.as`, `snd_die.as`, `snd_hurt1.as`, `snd_hurt2.as`, `yin_fla/AI_2.as`, `yin_fla/MainTimeline.as`, `yin_fla/Timeline_1.as`, `yin_fla/Timeline_7.as` | 是 |
| `decompiled/fighters/fz/byakuya/` | 2 | `byakuya_fla/MainTimeline.as`, `byakuya_fla/六杖光牢_2.as` | 是 |
| `decompiled/fighters/fz/gaara/` | 1 | `gaara_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/grimmjow/` | 1 | `grimmjow_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/harribel/` | 1 | `harribel_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/hinata/` | 1 | `hinata_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/ichigo_padipata/` | 1 | `ichigo_padipata_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/ichigo_white2/` | 2 | `ichigo_white2_fla/MainTimeline.as`, `ichigo_white2_fla/Timeline_4.as` | 是 |
| `decompiled/fighters/fz/ino/` | 1 | `ino_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/itachi/` | 1 | `itachi_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/jiraiya/` | 1 | `jiraiya_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/kenpachi/` | 1 | `kenpachi_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/kimimaro/` | 1 | `kimimaro_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/kon/` | 1 | `kon_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/madara/` | 2 | `madara_fla/MainTimeline.as`, `madara_fla/Timeline_2.as` | 是 |
| `decompiled/fighters/fz/minato/` | 1 | `minato_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/nemu/` | 1 | `nemu_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/obito/` | 1 | `obito_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/orihime/` | 1 | `orihime_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/rangiku/` | 1 | `rangiku_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/sai/` | 1 | `sai_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/shikamaru/` | 2 | `shikamaru_fla/MainTimeline.as`, `shikamaru_fla/元件3_2.as` | 是 |
| `decompiled/fighters/fz/shishio/` | 2 | `shishio_fla/MainTimeline.as`, `shishio_fla/元件3_2.as` | 是 |
| `decompiled/fighters/fz/soifon/` | 2 | `soifon_fla/MainTimeline.as`, `soifon_fla/元件511_5.as` | 是 |
| `decompiled/fighters/fz/soifong/` | 2 | `soifong_fla/MainTimeline.as`, `soifong_fla/元件511_5.as` | **否（遗留）** |
| `decompiled/fighters/fz/stake/` | 1 | `stake_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/suigetsu/` | 1 | `suigetsu_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/temari/` | 1 | `temari_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/tenten/` | 1 | `tenten_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/tsuchikage/` | 1 | `tsuchikage_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/tsunate/` | 1 | `tsunate_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/uryuu/` | 1 | `uryuu_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/yachiru/` | 1 | `yachiru_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/yamamoto/` | 1 | `yamamoto_fla/MainTimeline.as` | 是 |
| `decompiled/fighters/fz/yin/` | 2 | `yin_fla/MainTimeline.as`, `yin_fla/元件36_2.as` | 是 |
| `decompiled/fighters/fz/yoruichi/` | 1 | `yoruichi_fla/MainTimeline.as` | 是 |

## 各可玩角色脚本结构（不贴 76 份源码）

典型可玩 SWF 含：

1. `<name>_fla/MainTimeline.as` — 皮肤帧 + `defineAction`
2. `<name>_fla/*全动作*.as` 或复用的「一护全动作 / 鸣人全动作 / 樱」模板剪辑 — 内含 `bdmn`、`AImain`、`*atm`
3. `bsface1.as` / `bsface2.as` … — 必杀脸
4. `snd_hurt*.as` / `snd_die.as` — 嵌入音效文档类
5. `AI面_*.as` — AI/立绘脸剪辑

辅助 SWF 多数只有 1 个 `MainTimeline.as`（`defineActions` + 若干 `frameN` 调 `effect.bisha` / `endAct` / `attackUp`）。

可玩角色 `.as` 数量最多：`ichigo_zero` 24、`ichigo` 23、`naruto` 18、`pain` 17、`naruto_xr` 15、`itachi`/`lee`/`neji`/`obito` 12–14。

## 加载路径

```
select.xml item id
  -> FighterModel.getFighter(id)  // fighter.xml
  -> FighterVO.fileUrl + startFrame
  -> ZipAssetLoader.loadSwf(fileUrl)
  -> GameLoader.loadFighter -> new FighterMain(mc)
  -> FighterMain.initlize -> setFighterCtrler + gotoAndStop(startFrame+1)
  -> 该帧 frameN() 批量 defineAction
```

辅助同理：`AssisterModel` + `setAssistCtrler` + `defineActions`。

不把 76 个 MainTimeline 源码贴进本册。要改招数值，打开对应 `decompiled/fighters/<dir>/scripts/<name>_fla/MainTimeline.as` 的 `defineAction` 对象即可。
