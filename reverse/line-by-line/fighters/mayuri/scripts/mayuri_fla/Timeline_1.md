# `mayuri_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`。

源文件：`decompiled/fighters/mayuri/scripts/mayuri_fla/Timeline_1.as`（547 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`wk`, `sh22atm`, `zh3atm`, `tzatm`, `sbsatm`, `sh12atm`, `zh2atm`, `sbs1atm`, `zh31atm`, `sh1atm`, `tz1atm`, `tz0atm`, `bdmn`, `k31atm`, `sh2atm`, `AImain`, `bsatm`, `bs1atm`, `kj1atm`, `k1atm`, `bs3atm`, `kj12atm`, `bs2atm`, `k3atm`, `bs5atm`, `kj2atm`, `k2atm`, `bs4atm`, `zh1atm`, `tkatm`。

涅茧利 动作 MC（类名 `Timeline_1`）。

Embed `source="/_assets/assets.swf", symbol="symbol474"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `wk` | `MovieClip` | 攻击体/特效子件（`addAttacker` 名）
| L24 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `sbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `zh31atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `tz1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `tz0atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `bdmn` | `MovieClip` | 身体盒
| L48 | `k31atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `AImain` | `MovieClip` | AI 判定面容器
| L54 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L56 | `bs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `bs3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `kj12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `bs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `bs5atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L72 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L74 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L76 | `bs4atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L78 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L80 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_1()`（L82–87）

- L84: `super();`
- L85: `addFrameScript(13,frame14,21,frame22,26,frame27,33,frame34,42,frame43,44,frame45,77,frame78,89,frame90,97,frame98,104,frame105,108,frame109,109,frame110,118,frame119,121,frame122,123,frame124,132,frame133,145,frame146,150,frame151,156,frame157,161,frame162,168,frame169,171,frame172,176,frame177,181,frame182,208,frame209,215,frame216,223,frame224,233,frame234,249,frame250,252,frame253,258,frame259,262,frame263,266,frame267,267,frame268,268,frame269,274,frame275,278,frame279,284,frame285,289,frame290,298,frame299,300,frame301,307,frame308,328,frame329,344,frame345,346,frame347,385,frame386,397,frame398,400,frame401,417,frame418,424,frame425,436,frame437,448,frame449,464,frame465,484,frame485,497,frame498,525,frame526,528,frame529,531,frame532,535,frame536,540,frame541,545,frame546,566,frame567,581,frame582,603,frame604,626,frame627,627,frame628,635,frame636,648,frame649,672,frame673,702,frame703,706,frame707,738,frame739,746,frame747,792,frame793,813,frame814,874,frame875,964,frame965,978,frame979,1060,frame1061,1088,frame1089,1145,frame1146,1175,frame1176,1201,frame1202);`

### 逐帧脚本

共 83 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F14–F45 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F14 | L89–92 / L91 | `$effect_ctrler.walk();` — 走路尘土 |
| F22 | L94–97 / L96 | `$effect_ctrler.walk();` — 走路尘土 |
| F27 | L99–102 / L101 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F34 | L104–112 / L106 | `$mc_ctrler.dash(4);` — 冲刺速度倍率 |
|  |  / L107 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L108 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L109 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L110 | `$effect_ctrler.shadow(50,-255,0);` — 残影 |
|  |  / L111 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F43 | L114–117 / L116 | `$mc_ctrler.dashStop();` — 停冲 |
| F45 | L119–122 / L121 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F78–F133 — 动作 `跳招21` / `跳招0`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F78 | L124–127 / L126 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F90 | L129–133 / L131 | `$mc_ctrler.move(20,-5);` — 设速度 |
|  |  / L132 | `$mc_ctrler.damping(2,0.5);` — 阻尼 |
| F98 | L135–138 / L137 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
| F105 | L140–143 / L142 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F109 | L145–151 / L147 | `$mc_ctrler.movePercent(2,2);` — 按百分比位移 |
|  |  / L148 | `$mc_ctrler.setTouchFloor("跳招21",true);` — 落地切标签 |
|  |  / L149 | `$mc_ctrler.setHitTarget("tz0atm","跳招21");` — 指定命中取样盒 |
|  |  / L150 | `$effect_ctrler.shadow(50,-255,0);` — 残影 |
| F110 | L153–156 / L155 | `$mc_ctrler.addQi(5);` — 加气 |
| F119 | L158–161 / L160 | `$mc_ctrler.loop("跳招0");` — 循环标签 |
| F122 | L163–166 / L165 | `$mc_ctrler.addQi(5);` — 加气 |
| F124 | L168–172 / L170 | `$mc_ctrler.move(-5,-5);` — 设速度 |
|  |  / L171 | `$mc_ctrler.damping(0.5,0.5);` — 阻尼 |
| F133 | L174–177 / L176 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F146–F182 — 动作 `砍2` / `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F146 | L179–183 / L181 | `$mc_ctrler.movePercent(1.5,0);` — 按百分比位移 |
|  |  / L182 | `$mc_ctrler.dampingPercent(0.15,0);` — 百分比阻尼 |
| F151 | L185–189 / L187 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L188 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
| F157 | L191–194 / L193 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F162 | L196–199 / L198 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F169 | L201–205 / L203 | `$mc_ctrler.movePercent(2,0);` — 按百分比位移 |
|  |  / L204 | `$mc_ctrler.dampingPercent(0.4,0);` — 百分比阻尼 |
| F172 | L207–212 / L209 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L210 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L211 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
| F177 | L214–217 / L216 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F182 | L219–222 / L221 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F209–F234 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F209 | L224–230 / L226 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L227 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L228 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L229 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F216 | L232–235 / L234 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F224 | L237–240 / L239 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F234 | L242–245 / L244 | `$mc_ctrler.addQi(10);` — 加气 |

#### F250–F308 — 动作 `砍2` / `招32`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F250 | L247–250 / L249 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F253 | L252–258 / L254 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L255 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L256 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L257 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F259 | L260–263 / L262 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F263 | L265–268 / L267 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F267 | L270–274 / L272 | `$mc_ctrler.movePercent(2,0);` — 按百分比位移 |
|  |  / L273 | `$mc_ctrler.dampingPercent(0.2,0);` — 百分比阻尼 |
| F268 | L276–279 / L278 | `$mc_ctrler.addQi(10);` — 加气 |
| F269 | L281–284 / L283 | `$effect_ctrler.shine();` — 闪光 |
| F275 | L286–289 / L288 | `$mc_ctrler.setJump();` — 允许跳 |
| F279 | L291–295 / L293 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L294 | `$mc_ctrler.setZhao3("招32");` — 允许招 3 |
| F285 | L297–300 / L299 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F290 | L302–305 / L304 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F299 | L307–310 / L309 | `$mc_ctrler.addQi(10);` — 加气 |
| F301 | L312–315 / L314 | `$effect_ctrler.shine(13434622);` — 闪光 |
| F308 | L317–320 / L319 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F329 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F329 | L322–325 / L324 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F345–F347 — 动作 `zh2atm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F345 | L327–330 / L329 | `$mc_ctrler.addQi(10);` — 加气 |
| F347 | L332–344 / L334 | `$mc_ctrler.fire("zh2atm",{"x":15, "y":{"start":-8, "add":1, "max":10}, "hold":2, "hits":1});` — 发射子弹 FIRE |

#### F386–F401 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F386 | L346–349 / L348 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F398 | L351–354 / L353 | `$mc_ctrler.addQi(10);` — 加气 |
| F401 | L356–359 / L358 | `$effect_ctrler.shadow(50,-255,0);` — 残影 |

#### F418–F449 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F418 | L361–365 / L363 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L364 | `$effect_ctrler.endShadow();` — 关残影 |
| F425 | L367–370 / L369 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F437 | L372–375 / L374 | `$mc_ctrler.addQi(10);` — 加气 |
| F449 | L377–380 / L379 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F465 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F465 | L382–385 / L384 | `$mc_ctrler.addQi(20);` — 加气 |

#### F485 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F485 | L387–390 / L389 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F498 — 动作 `涅浊利1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F498 | L392–395 / L394 | `$effect_ctrler.bisha(false,"涅浊利1");` — 必杀演出（脸/黑屏） |

#### F526–F546 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F526 | L397–400 / L399 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F529 | L402–405 / L404 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F532 | L407–413 / L409 | `$fighter_ctrler.moveToTarget(20,-60,true);` — 瞬移到目标附近 |
|  |  / L410 | `$mc_ctrler.move(-3,-3);` — 设速度 |
|  |  / L411 | `$mc_ctrler.damping(0.05,0.05);` — 阻尼 |
|  |  / L412 | `$effect_ctrler.slowDown(1);` — 慢动作 |
| F536 | L415–418 / L417 | `$effect_ctrler.shine(16729113);` — 闪光 |
| F541 | L420–423 / L422 | `$effect_ctrler.shine(16729113);` — 闪光 |
| F546 | L425–428 / L427 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F567 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F567 | L430–433 / L432 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F582 — 动作 `涅浊利1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F582 | L435–438 / L437 | `$effect_ctrler.bisha(false,"涅浊利1");` — 必杀演出（脸/黑屏） |

#### F604 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F604 | L440–444 / L442 | `$effect_ctrler.endBisha();` — 关必杀演出 |
|  |  / L443 | `$effect_ctrler.shadow(50,-255,0);` — 残影 |

#### F627–F636 — 动作 `必杀2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F627 | L446–449 / L448 | `$mc_ctrler.justHitToPlay("bs2","必杀2",false);` — 刚命中才跳到标签 |
| F628 | L451–455 / L453 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L454 | `$effect_ctrler.endShadow();` — 关残影 |
| F636 | L457–460 / L459 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F649 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F649 | L462–465 / L464 | `$effect_ctrler.shadow(50,-255,0);` — 残影 |

#### F673 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F673 | L467–471 / L469 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L470 | `$effect_ctrler.slowDown(1);` — 慢动作 |

#### F703–F707 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F703 | L473–477 / L475 | `$effect_ctrler.shine(15859712);` — 闪光 |
|  |  / L476 | `$effect_ctrler.slowDown(1);` — 慢动作 |
| F707 | L479–483 / L481 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L482 | `$effect_ctrler.endShadow();` — 关残影 |

#### F739–F747 — 动作 `涅浊利2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F739 | L485–488 / L487 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F747 | L490–493 / L492 | `$effect_ctrler.bisha(true,"涅浊利2");` — 必杀演出（脸/黑屏） |

#### F793 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F793 | L495–498 / L497 | `$effect_ctrler.shine(7100304);` — 闪光 |

#### F814 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F814 | L500–503 / L502 | `$effect_ctrler.shine(7100304);` — 闪光 |

#### F875 — 动作 `wk`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F875 | L505–509 / L507 | `$effect_ctrler.endBisha();` — 关必杀演出 |
|  |  / L508 | `$mc_ctrler.addAttacker("wk",{"applyG":true});` — 放出攻击体 ADD_ATTACKER |

#### F965 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F965 | L511–514 / L513 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F979 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F979 | L516–519 / L518 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1061 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1061 | L521–524 / L523 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1089 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1089 | L526–529 / L528 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1146 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1146 | L531–534 / L533 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1176 — 胜/负停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1176 | L536–539 / L538 | `$mc_ctrler.stop();` — 停时间轴 |

#### F1202 — 胜/负停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1202 | L541–544 / L543 | `$mc_ctrler.stop();` — 停时间轴 |
