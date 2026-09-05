# `juggo_fla.迪达拉全动作_XIN_1` — 动作 MC `迪达拉全动作_XIN_1`

一句话目的：角色动作时间轴 `迪达拉全动作_XIN_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`。

源文件：`decompiled/fighters/juggo/scripts/juggo_fla/迪达拉全动作_XIN_1.as`（732 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`AImain`, `bdmn`, `bs1atm`, `bsatm`, `cbs0atm`, `cbs1atm`, `cbs2atm`, `cbsatm`, `k1atm`, `k2atm`, `k3atm`, `kj10atm`, `kj1atm`, `kj20`, `kj21atm`, `kj2atm`, `kuwu`, `move_mc`, `sbs1atm`, `sbsatm`, `sh12atm`, `sh1atm`, `sh22atm`, `sh2atm`, `tkatm`, `tu`, `tzatm`, `zh11atm`, `zh1atm`, `zh32atm`, `zh3atm`。

天秤·重吾 动作 MC（类名 `迪达拉全动作_XIN_1`）。

Embed `source="/_assets/assets.swf", symbol="symbol505"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `AImain` | `MovieClip` | AI 判定面容器
| L24 | `bdmn` | `MovieClip` | 身体盒
| L26 | `bs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `cbs0atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `cbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `kj10atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `kj20` | `MovieClip` | 子件/缓存
| L50 | `kj21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `kuwu` | `MovieClip` | 子件/缓存
| L56 | `move_mc` | `MovieClip` | 抓人跟随锚点
| L58 | `sbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L72 | `tu` | `MovieClip` | 运行时缓存/标志
| L74 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L76 | `zh11atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L78 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L80 | `zh32atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L82 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `迪达拉全动作_XIN_1()`（L84–89）

- L86: `super();`
- L87: `addFrameScript(14,frame15,19,frame20,22,frame23,26,frame27,35,frame36,39,frame40,70,frame71,78,frame79,86,frame87,91,frame92,96,frame97,99,frame100,110,frame111,119,frame120,125,frame126,130,frame131,133,frame134,137,frame138,146,frame147,151,frame152,155,frame156,160,frame161,161,frame162,173,frame174,178,frame179,185,frame186,193,frame194,194,frame195,195,frame196,208,frame209,220,frame221,221,frame222,224,frame225,226,frame227,231,frame232,236,frame237,241,frame242,257,frame258,258,frame259,263,frame264,267,frame268,275,frame276,289,frame290,300,frame301,311,frame312,313,frame314,321,frame322,341,frame342,360,frame361,377,frame378,394,frame395,406,frame407,424,frame425,452,frame453,463,frame464,465,frame466,466,frame467,479,frame480,486,frame487,495,frame496,499,frame500,507,frame508,521,frame522,539,frame540,550,frame551,588,frame589,593,frame594,602,frame603,610,frame611,624,frame625,636,frame637,664,frame665,676,frame677,699,frame700,701,frame702,737,frame738,738,frame739,741,frame742,744,frame745,751,frame752,754,frame755,757,frame758,776,frame777,808,frame809,854,frame855,855,frame856,863,frame864,868,frame869,896,frame897,923,frame924,936,frame937,949,frame950,962,frame963,975,frame976,997,frame998,1001,frame1002,1013,frame1014,1019,frame1020,1020,frame1021,1022,frame1023,1023,frame1024,1048,frame1049,1136,frame1137,1157,frame1158,1238,frame1239,1279,frame1280,1307,frame1308);`

### 逐帧脚本

共 107 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F15–F40 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F15 | L91–94 / L93 | `$effect_ctrler.walk();` — 走路尘土 |
| F20 | L96–99 / L98 | `$effect_ctrler.walk();` — 走路尘土 |
| F23 | L101–104 / L103 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F27 | L106–114 / L108 | `$mc_ctrler.dash(2.5);` — 冲刺速度倍率 |
|  |  / L109 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L110 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L111 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L112 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
|  |  / L113 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F36 | L116–119 / L118 | `$mc_ctrler.dashStop();` — 停冲 |
| F40 | L121–124 / L123 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F71–F134 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F71 | L126–129 / L128 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F79 | L131–134 / L133 | `$mc_ctrler.setAirMove(true);` — 允许空中移动 |
| F87 | L136–139 / L138 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
| F92 | L141–144 / L143 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F97 | L146–149 / L148 | `$mc_ctrler.move(2,-2);` — 设速度 |
| F100 | L151–155 / L153 | `$mc_ctrler.move(6,4);` — 设速度 |
|  |  / L154 | `$mc_ctrler.damping(0.3,0.2);` — 阻尼 |
| F111 | L157–160 / L159 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F120 | L162–166 / L164 | `$mc_ctrler.movePercent(1,0);` — 按百分比位移 |
|  |  / L165 | `$mc_ctrler.dampingPercent(0.1,0);` — 百分比阻尼 |
| F126 | L168–172 / L170 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L171 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
| F131 | L174–177 / L176 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F134 | L179–182 / L181 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F138–F161 — 动作 `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F138 | L184–188 / L186 | `$mc_ctrler.movePercent(0.5,0);` — 按百分比位移 |
|  |  / L187 | `$mc_ctrler.dampingPercent(0.05,0);` — 百分比阻尼 |
| F147 | L190–198 / L192 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L193 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L194 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L195 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L196 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L197 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F152 | L200–203 / L202 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F156 | L205–208 / L207 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F161 | L210–213 / L212 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F162–F322 — 发射子弹 `zh1atm` / `zh11atm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F162 | L215–219 / L217 | `$mc_ctrler.movePercent(1.5,0);` — 按百分比位移 |
|  |  / L218 | `$mc_ctrler.dampingPercent(0.1,0);` — 百分比阻尼 |
| F174 | L221–226 / L223 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L224 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L225 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F179 | L228–231 / L230 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F186 | L233–236 / L235 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F194 | L238–241 / L240 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F195 | L243–248 / L245 | `$mc_ctrler.setHitTarget("kj10atm","砍技12");` — 指定命中取样盒 |
|  |  / L246 | `$mc_ctrler.movePercent(1.5,0);` — 按百分比位移 |
|  |  / L247 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F196 | L250–255 / L252 | `$mc_ctrler.addQi(5);` — 加气 |
|  |  / L253 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
|  |  / L254 | `$mc_ctrler.setSteelBody(true);` — 钢体/霸体 |
| F209 | L257–260 / L259 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F221 | L262–266 / L264 | `$mc_ctrler.movePercent(1.5,0);` — 按百分比位移 |
|  |  / L265 | `$mc_ctrler.dampingPercent(0.3,0);` — 百分比阻尼 |
| F222 | L268–272 / L270 | `$mc_ctrler.addQi(5);` — 加气 |
|  |  / L271 | `$effect_ctrler.endShadow();` — 关残影 |
| F225 | L274–277 / L276 | `$mc_ctrler.setSteelBody(false);` — 钢体/霸体 |
| F227 | L279–282 / L281 | `$mc_ctrler.setSteelBody(false);` — 钢体/霸体 |
| F232 | L284–290 / L286 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L287 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L288 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L289 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F237 | L292–295 / L294 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F242 | L297–300 / L299 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F258 | L302–307 / L304 | `$mc_ctrler.movePercent(2,0);` — 按百分比位移 |
|  |  / L305 | `$mc_ctrler.dampingPercent(0.2,0);` — 百分比阻尼 |
|  |  / L306 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F259 | L309–312 / L311 | `$mc_ctrler.addQi(10);` — 加气 |
| F264 | L314–318 / L316 | `$mc_ctrler.setHitTarget("kj20","砍技21");` — 指定命中取样盒 |
|  |  / L317 | `$effect_ctrler.endShadow();` — 关残影 |
| F268 | L320–323 / L322 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F276 | L325–328 / L327 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F290 | L330–333 / L332 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F301 | L335–338 / L337 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F312 | L340–343 / L342 | `$mc_ctrler.addQi(5);` — 加气 |
| F314 | L345–353 / L347 | `$mc_ctrler.fire("zh1atm",{"x":{"start":20}, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F322 | L355–363 / L357 | `$mc_ctrler.fire("zh11atm",{"x":{"start":20}, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |

#### F342 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F342 | L365–368 / L367 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F361 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F361 | L370–373 / L372 | `$mc_ctrler.addQi(10);` — 加气 |

#### F378 — 放出攻击体 `tu`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F378 | L375–382 / L377 | `$mc_ctrler.addAttacker("tu",{"x":{"moveToTarget":true, "offset":0, "range":[50,500]}});` — 放出攻击体 ADD_ATTACKER |

#### F395–F407 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F395 | L384–387 / L386 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F407 | L389–392 / L391 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F425 — 放出攻击体 `kuwu`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F425 | L394–397 / L396 | `$mc_ctrler.addAttacker("kuwu",{"applyG":false});` — 放出攻击体 ADD_ATTACKER |

#### F453–F522 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F453 | L399–402 / L401 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F464 | L404–407 / L406 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F466 | L409–412 / L411 | `$mc_ctrler.addQi(5);` — 加气 |
| F467 | L414–419 / L416 | `$mc_ctrler.move(10,-13);` — 设速度 |
|  |  / L417 | `$mc_ctrler.damping(0.5,0.5);` — 阻尼 |
|  |  / L418 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F480 | L421–425 / L423 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L424 | `$effect_ctrler.endShadow();` — 关残影 |
| F487 | L427–430 / L429 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F496 | L432–435 / L434 | `$mc_ctrler.addQi(10);` — 加气 |
| F500 | L437–441 / L439 | `$mc_ctrler.movePercent(1,0);` — 按百分比位移 |
|  |  / L440 | `$mc_ctrler.dampingPercent(0.2,0);` — 百分比阻尼 |
| F508 | L443–446 / L445 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F522 | L448–451 / L450 | `$mc_ctrler.addQi(20);` — 加气 |

#### F540 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F540 | L453–456 / L455 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F551 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F551 | L458–461 / L460 | `$effect_ctrler.bisha(false,"重吾1");` — 必杀演出（脸/黑屏） |

#### F589–F637 — 发射子弹 `bs1atm` / `bsatm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F589 | L463–466 / L465 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F594 | L468–480 / L470 | `$mc_ctrler.move(-7,0);` — 设速度 |
|  |  / L471 | `$mc_ctrler.damping(0.7,0);` — 阻尼 |
|  |  / L472 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L473 | `$mc_ctrler.fire("bs1atm",{"x":{"start":30}, "y":0, "hold":3, "hits":1, "hp":200});` — 发射子弹 FIRE |
| F603 | L482–494 / L484 | `$mc_ctrler.move(-7,0);` — 设速度 |
|  |  / L485 | `$mc_ctrler.damping(0.7,0);` — 阻尼 |
|  |  / L486 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L487 | `$mc_ctrler.fire("bs1atm",{"x":{"start":30}, "y":0, "hold":3, "hits":1, "hp":200});` — 发射子弹 FIRE |
| F611 | L496–508 / L498 | `$mc_ctrler.move(-7,0);` — 设速度 |
|  |  / L499 | `$mc_ctrler.damping(0.7,0);` — 阻尼 |
|  |  / L500 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L501 | `$mc_ctrler.fire("bs1atm",{"x":{"start":30}, "y":0, "hold":3, "hits":1, "hp":200});` — 发射子弹 FIRE |
| F625 | L510–513 / L512 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
| F637 | L515–527 / L517 | `$mc_ctrler.move(-12,0);` — 设速度 |
|  |  / L518 | `$mc_ctrler.damping(1.2,0);` — 阻尼 |
|  |  / L519 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L520 | `$mc_ctrler.fire("bsatm",{"x":{"start":30}, "y":0, "hold":3, "hits":1, "hp":300});` — 发射子弹 FIRE |

#### F665–F677 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F665 | L529–532 / L531 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F677 | L534–537 / L536 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F700–F702 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F700 | L539–542 / L541 | `$effect_ctrler.shine();` — 闪光 |
| F702 | L544–547 / L546 | `$effect_ctrler.bisha(false,"重吾1");` — 必杀演出（脸/黑屏） |

#### F738–F758 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F738 | L549–552 / L551 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F739 | L554–559 / L556 | `$mc_ctrler.move(20,0);` — 设速度 |
|  |  / L557 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
|  |  / L558 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F742 | L561–567 / L563 | `$fighter_ctrler.moveToTarget(-150,0,false);` — 瞬移到目标附近 |
|  |  / L564 | `$mc_ctrler.move(20,0);` — 设速度 |
|  |  / L565 | `$mc_ctrler.damping(1,0);` — 阻尼 |
|  |  / L566 | `$mc_ctrler.isApplyG(false);` — 是否受重力 |
| F745 | L569–573 / L571 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L572 | `$effect_ctrler.endShadow();` — 关残影 |
| F752 | L575–580 / L577 | `$mc_ctrler.move(10,0);` — 设速度 |
|  |  / L578 | `$mc_ctrler.damping(1,0);` — 阻尼 |
|  |  / L579 | `$effect_ctrler.shine();` — 闪光 |
| F755 | L582–585 / L584 | `$mc_ctrler.isApplyG(true);` — 是否受重力 |
| F758 | L587–590 / L589 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F777 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F777 | L592–595 / L594 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F809 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F809 | L597–600 / L599 | `$effect_ctrler.bisha(true,"重吾2");` — 必杀演出（脸/黑屏） |

#### F855–F869 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F855 | L602–605 / L604 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F856 | L607–612 / L609 | `$mc_ctrler.movePercent(3,0);` — 按百分比位移 |
|  |  / L610 | `$mc_ctrler.setHitTarget("cbs0atm","超必杀2");` — 指定命中取样盒 |
|  |  / L611 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F864 | L614–617 / L616 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F869 | L619–622 / L621 | `$mc_ctrler.moveTarget({"followmc":"move_mc"});` — 把对手贴到跟随锚点 |

#### F897 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F897 | L624–626 | （空；? 仅占位） |

#### F924–F976 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F924 | L628–633 / L630 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L631 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L632 | `$effect_ctrler.shake(0,5);` — 震屏 |
| F937 | L635–640 / L637 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L638 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L639 | `$effect_ctrler.shake(0,5);` — 震屏 |
| F950 | L642–647 / L644 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L645 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L646 | `$effect_ctrler.shake(0,5);` — 震屏 |
| F963 | L649–654 / L651 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L652 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L653 | `$effect_ctrler.shake(0,5);` — 震屏 |
| F976 | L656–661 / L658 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L659 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L660 | `$effect_ctrler.shake(0,5);` — 震屏 |

#### F998–F1024 — 动作 `超必杀4`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F998 | L663–666 / L665 | `$effect_ctrler.shadow(100,40,0);` — 残影 |
| F1002 | L668–672 / L670 | `$mc_ctrler.movePercent(1,-2);` — 按百分比位移 |
|  |  / L671 | `$mc_ctrler.dampingPercent(0,0.1);` — 百分比阻尼 |
| F1014 | L674–677 / L676 | `$mc_ctrler.setTouchFloor("超必杀4",true);` — 落地切标签 |
| F1020 | L679–682 / L681 | `$mc_ctrler.stop();` — 停动作 MC 播放 |
| F1021 | L684–687 / L686 | `$effect_ctrler.endShadow();` — 关残影 |
| F1023 | L689–694 / L691 | `$effect_ctrler.shine(10027008);` — 闪光 |
|  |  / L692 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L693 | `$effect_ctrler.shake(0,10);` — 震屏 |
| F1024 | L696–699 / L698 | `$mc_ctrler.moveTarget(null);` — 把对手贴到跟随锚点 |

#### F1049 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1049 | L701–704 / L703 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1137 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1137 | L706–709 / L708 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1158 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1158 | L711–714 / L713 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1239 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1239 | L716–719 / L718 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1280 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1280 | L721–724 / L723 | `$mc_ctrler.stop();` — 停动作 MC 播放 |

#### F1308 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1308 | L726–729 / L728 | `$mc_ctrler.stop();` — 停动作 MC 播放 |
