# `didala_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`。

源文件：`decompiled/fighters/didala/scripts/didala_fla/Timeline_1.as`（545 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`k4atm`, `cbsatm`, `sh22atm`, `zh3atm`, `tzatm`, `sbsatm`, `sh12atm`, `zh2atm`, `sbs1atm`, `cbs1atm`, `zh21atm`, `sh1atm`, `bdmn`, `sh2atm`, `kj21atm`, `AImain`, `bsatm`, `kj1atm`, `k1atm`, `bs2atm`, `k3atm`, `kj2atm`, `k2atm`, `zh1atm`…。

迪达拉动作 MC（类名 `Timeline_1`，不是「全动作」）。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `k4atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `sbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `zh21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `bdmn` | `MovieClip` | 身体盒
| L48 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `kj21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `AImain` | `MovieClip` | AI 判定面容器
| L54 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L56 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `bs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_1()`（L72–77）

- L74: `super();`
- L75: `addFrameScript(13,frame14,21,frame22,26,frame27,32,frame33,35,frame36,43,frame44,69,frame70,79,frame80,86,frame87,91,frame92,96,frame97,98,frame99,115,frame116,129,frame130,135,frame136,142,frame143,147,frame148,153,frame154,158,frame159,160,frame161,167,frame168,173,frame174,179,frame180,185,frame186,194,frame195,200,frame201,209,frame210,213,frame214,215,frame216,228,frame229,234,frame235,245,frame246,250,frame251,251,frame252,257,frame258,259,frame260,265,frame266,269,frame270,270,frame271,275,frame276,277,frame278,283,frame284,289,frame290,300,frame301,303,frame304,320,frame321,325,frame326,339,frame340,359,frame360,367,frame368,378,frame379,380,frame381,381,frame382,395,frame396,403,frame404,411,frame412,426 ,frame427,433,frame434,470,frame471,480,frame481,499,frame500,500,frame501,538,frame539,545,frame546,569,frame570,582,frame583,584,frame585,620,frame621,621,frame622,653,frame654,665,frame666,679,frame680,710,frame711,772,frame773,829,frame830,835,frame836,843,frame844,848,frame849,873,frame874,955,frame956,981,frame982,1073,frame1074,1114,frame1115,1142,frame1143);`

### 逐帧脚本

共 84 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F14–F44 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F14 | L79–82 / L81 | `$effect_ctrler.walk();` |
| F22 | L84–87 / L86 | `$effect_ctrler.walk();` |
| F27 | L89–92 / L91 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F33 | L94–97 / L96 | `$mc_ctrler.movePercent(6,0);` — 按百分比位移 |
| F36 | L99–102 / L101 | `$mc_ctrler.stopMove();` — 清速度 |
| F44 | L104–107 / L106 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F70 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F70 | L109–112 / L111 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F80–F116 — 发射子弹

| 帧 | 函数 L | 调用 |
|---|---|---|
| F80 | L114–117 / L116 | `$mc_ctrler.setAirMove(true);` — 空中左右移动开关 |
| F87 | L119–123 / L121 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
|  |  / L122 | `$mc_ctrler.setAttack("跳砍2");` — 允许普攻接到指定帧标签 |
| F92 | L125–128 / L127 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F97 | L130–134 / L132 | `$mc_ctrler.move(0,-2);` — 设速度 |
|  |  / L133 | `$mc_ctrler.damping(0,0.08);` — 阻尼 |
| F99 | L136–144 / L138 | `$mc_ctrler.fire("tzatm",{ "y":15, "x":0, "hold":2, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F116 | L146–149 / L148 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F130–F290 — 动作 `砍2` / `砍3` / `砍4` / `砍技21`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F130 | L151–155 / L153 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L154 | `$mc_ctrler.setZhao1();` — 允许招 1 |
| F136 | L157–160 / L159 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F143 | L162–166 / L164 | `$mc_ctrler.movePercent(0.5,0);` — 按百分比位移 |
|  |  / L165 | `$mc_ctrler.dampingPercent(0.05,0);` — 百分比阻尼 |
| F148 | L168–174 / L170 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L171 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L172 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L173 | `$mc_ctrler.setDash();` — 允许冲 |
| F154 | L176–179 / L178 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F159 | L181–184 / L183 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F161 | L186–190 / L188 | `$mc_ctrler.movePercent(1.3,0);` — 按百分比位移 |
|  |  / L189 | `$mc_ctrler.dampingPercent(0.07,0);` — 百分比阻尼 |
| F168 | L192–200 / L194 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L195 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L196 | `$mc_ctrler.setSkill1();` |
|  |  / L197 | `$mc_ctrler.setAttack("砍4");` — 允许普攻接到指定帧标签 |
|  |  / L198 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L199 | `$mc_ctrler.setDash();` — 允许冲 |
| F174 | L202–205 / L204 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F180 | L207–210 / L209 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F186 | L212–216 / L214 | `$mc_ctrler.movePercent(1,0);` — 按百分比位移 |
|  |  / L215 | `$mc_ctrler.dampingPercent(0.1,0);` — 百分比阻尼 |
| F195 | L218–222 / L220 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L221 | `$mc_ctrler.setZhao3();` — 允许招 3 |
| F201 | L224–227 / L226 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F210 | L229–232 / L231 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F214 | L234–237 / L236 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F216 | L239–242 / L241 | `$mc_ctrler.addQi(10);` — 加气 |
| F229 | L244–249 / L246 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L247 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L248 | `$mc_ctrler.setJump();` — 允许跳 |
| F235 | L251–254 / L253 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F246 | L256–259 / L258 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F251 | L261–264 / L263 | `$mc_ctrler.addQi(10);` — 加气 |
| F252 | L266–271 / L268 | `$mc_ctrler.movePercent(2.5,0);` — 按百分比位移 |
|  |  / L269 | `$mc_ctrler.dampingPercent(0.25,0);` — 百分比阻尼 |
|  |  / L270 | `$effect_ctrler.shadow(200,200,200);` — 残影 |
| F258 | L273–276 / L275 | `$effect_ctrler.endShadow();` — 关残影 |
| F260 | L278–285 / L280 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L281 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L282 | `$mc_ctrler.setSkill1();` |
|  |  / L283 | `$mc_ctrler.setAttack("砍技21");` — 允许普攻接到指定帧标签 |
|  |  / L284 | `$mc_ctrler.setDash();` — 允许冲 |
| F266 | L287–290 / L289 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F270 | L292–295 / L294 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F271 | L297–300 / L299 | `$effect_ctrler.shadow(200,200,200);` — 残影 |
| F276 | L302–305 / L304 | `$effect_ctrler.endShadow();` — 关残影 |
| F278 | L307–310 / L309 | `$mc_ctrler.setAttack("砍4");` — 允许普攻接到指定帧标签 |
| F284 | L312–315 / L314 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F290 | L317–320 / L319 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F301–F326 — 发射子弹

| 帧 | 函数 L | 调用 |
|---|---|---|
| F301 | L322–325 / L324 | `$mc_ctrler.addQi(5);` — 加气 |
| F304 | L327–339 / L329 | `$mc_ctrler.fire("zh1atm",{ "x":20, "y":{ "start":0, "max":10, "add":0.1 }, "hold":2, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F321 | L341–344 / L343 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F326 | L346–349 / L348 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F340–F434 — 发射子弹

| 帧 | 函数 L | 调用 |
|---|---|---|
| F340 | L351–354 / L353 | `$mc_ctrler.addQi(10);` — 加气 |
| F360 | L356–359 / L358 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F368 | L361–364 / L363 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F379 | L366–369 / L368 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F381 | L371–374 / L373 | `$mc_ctrler.addQi(5);` — 加气 |
| F382 | L376–384 / L378 | `$mc_ctrler.fire("zh3atm",{ "y":-15, "x":15, "hold":2, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F396 | L386–389 / L388 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F404 | L391–394 / L393 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F412 | L396–399 / L398 | `$mc_ctrler.addQi(10);` — 加气 |
| F427 | L401–404 / L403 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F434 | L406–409 / L408 | `$mc_ctrler.addQi(20);` — 加气 |

#### F471 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F471 | L411–414 / L413 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F481–F501 — 必杀演出 `迪达拉1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F481 | L416–419 / L418 | `$effect_ctrler.bisha(false,"迪达拉1");` — 必杀演出（脸/黑屏） |
| F500 | L421–424 / L423 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F501 | L426–430 / L428 | `$mc_ctrler.movePercent(1.4,0);` — 按百分比位移 |
|  |  / L429 | `$effect_ctrler.shadow(200,200,200);` — 残影 |

#### F539–F546 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F539 | L432–436 / L434 | `$mc_ctrler.stopMove();` — 清速度 |
|  |  / L435 | `$effect_ctrler.endShadow();` — 关残影 |
| F546 | L438–441 / L440 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F570 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F570 | L443–446 / L445 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F583–F585 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F583 | L448–451 / L450 | `$effect_ctrler.shine();` — 闪光 |
| F585 | L453–456 / L455 | `$effect_ctrler.bisha(false,"迪达拉1");` — 必杀演出（脸/黑屏） |

#### F621–F622 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F621 | L458–461 / L460 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F622 | L463–466 / L465 | `$effect_ctrler.shadow(100,100,100);` — 残影 |

#### F654–F680 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F654 | L468–471 / L470 | `$effect_ctrler.endShadow();` — 关残影 |
| F666 | L473–476 / L475 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F680 | L478–481 / L480 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F711 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F711 | L483–486 / L485 | `$effect_ctrler.bisha(true,"迪达拉2");` — 必杀演出（脸/黑屏） |

#### F773 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F773 | L488–491 / L490 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F830–F849 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F830 | L493–496 / L495 | `$fighter_ctrler.moveOnce(0,-250);` — 一次性位移 |
| F836 | L498–501 / L500 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F844 | L503–507 / L505 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L506 | `$effect_ctrler.shine(303095);` — 闪光（0x049FF7） |
| F849 | L509–512 / L511 | `doZhaoHuan();` |

#### F874 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F874 | L514–517 / L516 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F956 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F956 | L519–522 / L521 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F982 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F982 | L524–527 / L526 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1074 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1074 | L529–532 / L531 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1115 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1115 | L534–537 / L536 | `$mc_ctrler.stop();` — 停动作 MC 播放 |

#### F1143 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1143 | L539–542 / L541 | `$mc_ctrler.stop();` — 停动作 MC 播放 |
