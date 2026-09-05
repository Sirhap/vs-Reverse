# `kakashi_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`。

源文件：`decompiled/fighters/kakashi/scripts/kakashi_fla/Timeline_1.as`（652 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`sh22atm`, `zh3atm`, `tzatm`, `shenwei`, `sh12atm`, `zh2atm`, `zh31atm`, `sh1atm`, `zh20atm`, `zh32atm`, `bdmn`, `zh13atm`, `sh2atm`, `kj21atm`, `zh12atm`, `k21atm`, `AImain`, `kj20atm`, `dog1`, `bsatm`, `bs1atm`, `zh14atm`, `kj10atm`, `bs0atm`, `kj22atm`, `kj1atm`, `k1atm`, `shuilong`, `k3atm`, `kj2atm`, `k2atm`, `zh1atm`, `tkatm`, `target`, `moveY`。

旗木·卡卡西 动作 MC（类名 `Timeline_1`）。

Embed `source="/_assets/assets.swf", symbol="symbol642"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `shenwei` | `MovieClip` | 子件/缓存
| L30 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `zh31atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `zh20atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `zh32atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `bdmn` | `MovieClip` | 身体盒
| L44 | `zh13atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `kj21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `zh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `k21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `AImain` | `MovieClip` | AI 判定面容器
| L56 | `kj20atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `dog1` | `MovieClip` | 子件/缓存
| L60 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `bs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `zh14atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `kj10atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `bs0atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `kj22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L72 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L74 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L76 | `shuilong` | `MovieClip` | 子件/缓存
| L78 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L80 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L82 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L84 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L86 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L88 | `target` | `*` | 运行时缓存/标志
| L90 | `moveY` | `Number` | 子件/缓存

### 函数

#### `Timeline_1()`（L92–97）

- L94: `super();`
- L95: `addFrameScript(11,frame12,20,frame21,23,frame24,28,frame29,35,frame36,38,frame39,68,frame69,80,frame81,88,frame89,92,frame93,107,frame108,111,frame112,113,frame114,126,frame127,142,frame143,147,frame148,152,frame153,156,frame157,169,frame170,179,frame180,185,frame186,190,frame191,216,frame217,223,frame224,228,frame229,246,frame247,251,frame252,255,frame256,272,frame273,283,frame284,290,frame291,291,frame292,296,frame297,297,frame298,304,frame305,315,frame316,326,frame327,327,frame328,335,frame336,353,frame354,371,frame372,393,frame394,398,frame399,402,frame403,406,frame407,410,frame411,419,frame420,422,frame423,449,frame450,450,frame451,466,frame467,468,frame469,480,frame481,526,frame527,530,frame531,543,frame544,554,frame555,573,frame574,582,frame583,585,frame586,587,frame588,591,frame592,616,frame617,630,frame631,641,frame642,658,frame659,703,frame704,717,frame718,733,frame734,735,frame736,746,frame747,756,frame757,770,frame771,782,frame783,818,frame819,819,frame820,833,frame834,844,frame845,850,frame851,866,frame867,876,frame877,890,frame891,912,frame913,932,frame933,933,frame934,998,frame999,1209,frame1210,1213,frame1214,1214,frame1215,1234,frame1235,1309,frame1310,1350,frame1351,1378,frame1379);`

### 逐帧脚本

共 93 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F12–F39 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F12 | L99–102 / L101 | `$effect_ctrler.walk();` — 走路尘土 |
| F21 | L104–107 / L106 | `$effect_ctrler.walk();` — 走路尘土 |
| F24 | L109–112 / L111 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F29 | L114–122 / L116 | `$mc_ctrler.dash(3);` — 冲刺速度倍率 |
|  |  / L117 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L118 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L119 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L120 | `$effect_ctrler.shadow(50,50,255);` — 残影 |
|  |  / L121 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F36 | L124–127 / L126 | `$mc_ctrler.dashStop();` — 停冲 |
| F39 | L129–132 / L131 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F69–F127 — 发射子弹 `tzatm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F69 | L134–137 / L136 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F81 | L139–142 / L141 | `$mc_ctrler.setAirMove(true);` — 允许空中移动 |
| F89 | L144–147 / L146 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
| F93 | L149–152 / L151 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F108 | L154–157 / L156 | `$mc_ctrler.move(0,-1);` — 设速度 |
| F112 | L159–163 / L161 | `$mc_ctrler.move(-5,-5);` — 设速度 |
|  |  / L162 | `$mc_ctrler.damping(0.5,0.5);` — 阻尼 |
| F114 | L165–173 / L167 | `$mc_ctrler.fire("tzatm",{"x":15, "y":15, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F127 | L175–178 / L177 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F143–F157 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F143 | L180–184 / L182 | `$mc_ctrler.movePercent(1.7,0);` — 按百分比位移 |
|  |  / L183 | `$mc_ctrler.dampingPercent(0.7,0);` — 百分比阻尼 |
| F148 | L186–191 / L188 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L189 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L190 | `$mc_ctrler.setBisha();` — 允许必杀 |
| F153 | L193–196 / L195 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F157 | L198–201 / L200 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F170–F191 — 动作 `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F170 | L203–207 / L205 | `$mc_ctrler.movePercent(1,0);` — 按百分比位移 |
|  |  / L206 | `$mc_ctrler.dampingPercent(0.05,0);` — 百分比阻尼 |
| F180 | L209–219 / L211 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L212 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L213 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L214 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L215 | `$mc_ctrler.setZhao2();` — 允许招 2 |
|  |  / L216 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L217 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
|  |  / L218 | `$mc_ctrler.setJump();` — 允许跳 |
| F186 | L221–224 / L223 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F191 | L226–229 / L228 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F217–F229 — 动作 `招32`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F217 | L231–237 / L233 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L234 | `$mc_ctrler.setZhao3("招32");` — 允许招 3 |
|  |  / L235 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L236 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F224 | L239–242 / L241 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F229 | L244–247 / L246 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F247–F256 — 放出攻击体 `dog1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F247 | L249–255 / L251 | `if($mc_ctrler.getAttacker("dog1")){$mc_ctrler.idle();}` — 缓存攻击体引用 |
| F252 | L257–260 / L259 | `$mc_ctrler.addQi(10);` — 加气 |
| F256 | L262–265 / L264 | `$mc_ctrler.addAttacker("dog1");` — 放出攻击体 ADD_ATTACKER |

#### F273–F316 — 动作 `砍技1_miss` / `招12`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F273 | L267–270 / L269 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F284 | L272–278 / L274 | `$mc_ctrler.movePercent(3,0);` — 按百分比位移 |
|  |  / L275 | `$mc_ctrler.setHitTarget("kj10atm","砍技12");` — 指定命中取样盒 |
|  |  / L276 | `$effect_ctrler.shadow(50,50,255);` — 残影 |
|  |  / L277 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F291 | L280–283 / L282 | `$mc_ctrler.gotoAndPlay("砍技1_miss");` — 跳到帧标签 |
| F292 | L285–290 / L287 | `$mc_ctrler.movePercent(2,0);` — 按百分比位移 |
|  |  / L288 | `$fighter_ctrler.setCross(true);` — 穿人/穿透 |
|  |  / L289 | `$effect_ctrler.shadow(50,50,255);` — 残影 |
| F297 | L292–295 / L294 | `$fighter_ctrler.setDirectToTarget();` — 面向目标 |
| F298 | L297–301 / L299 | `$mc_ctrler.dampingPercent(0.2,0);` — 百分比阻尼 |
|  |  / L300 | `$fighter_ctrler.setCross(false);` — 穿人/穿透 |
| F305 | L303–308 / L305 | `$mc_ctrler.setZhao1("招12");` — 允许招 1 |
|  |  / L306 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L307 | `$effect_ctrler.endShadow();` — 关残影 |
| F316 | L310–313 / L312 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F327–F336 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F327 | L315–318 / L317 | `$mc_ctrler.addQi(10);` — 加气 |
| F328 | L320–324 / L322 | `$mc_ctrler.movePercent(2,0);` — 按百分比位移 |
|  |  / L323 | `$mc_ctrler.setHitTarget("kj20atm","砍技21");` — 指定命中取样盒 |
| F336 | L326–329 / L328 | `$mc_ctrler.dampingPercent(0.3,0);` — 百分比阻尼 |

#### F354 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F354 | L331–334 / L333 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F372 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F372 | L336–339 / L338 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F394–F423 — 发射子弹 `zh1atm` / `zh12atm` / `zh14atm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F394 | L341–344 / L343 | `$mc_ctrler.addQi(5);` — 加气 |
| F399 | L346–354 / L348 | `$mc_ctrler.fire("zh1atm",{"x":20, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F403 | L356–364 / L358 | `$mc_ctrler.fire("zh12atm",{"x":20, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F407 | L366–374 / L368 | `$mc_ctrler.fire("zh14atm",{"x":20, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F411 | L376–384 / L378 | `$mc_ctrler.fire("zh13atm",{"x":20, "y":0, "hold":2, "hits":1});` — 发射子弹 FIRE |
| F420 | L386–389 / L388 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F423 | L391–394 / L393 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F450–F481 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F450 | L396–399 / L398 | `$mc_ctrler.addQi(10);` — 加气 |
| F451 | L401–406 / L403 | `$mc_ctrler.movePercent(4,0);` — 按百分比位移 |
|  |  / L404 | `$mc_ctrler.setHitTarget("zh20atm","招21");` — 指定命中取样盒 |
|  |  / L405 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F467 | L408–411 / L410 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F469 | L413–416 / L415 | `$mc_ctrler.dampingPercent(0.4,0);` — 百分比阻尼 |
| F481 | L418–421 / L420 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F527–F555 — 动作 `招32`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F527 | L423–427 / L425 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L426 | `$effect_ctrler.shine(0);` — 闪光 |
| F531 | L429–432 / L431 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F544 | L434–439 / L436 | `$mc_ctrler.setZhao3("招32");` — 允许招 3 |
|  |  / L437 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L438 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F555 | L441–444 / L443 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F574–F592 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F574 | L446–449 / L448 | `$mc_ctrler.addQi(5);` — 加气 |
| F583 | L451–454 / L453 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F586 | L456–459 / L458 | `$mc_ctrler.addQi(5);` — 加气 |
| F588 | L461–474 / L463 | `target = $fighter_ctrler.getTargetSP();` — 取目标精灵 |
|  |  / L464 | `moveY = 50;` — 记下引用/标志 |
|  |  / L465 | `if(Boolean(target) && !target.isInAir){moveY = 0;}` — 条件分支 |
|  |  / L469 | `$fighter_ctrler.moveToTarget(50,moveY,true);` — 瞬移到目标附近 |
|  |  / L470 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L471 | `$mc_ctrler.movePercent(0.5,-0.5);` — 按百分比位移 |
|  |  / L472 | `$mc_ctrler.dampingPercent(0.01,0.01);` — 百分比阻尼 |
|  |  / L473 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
| F592 | L476–480 / L478 | `$mc_ctrler.movePercent(1,-1);` — 按百分比位移 |
|  |  / L479 | `$mc_ctrler.dampingPercent(0.02,0.03);` — 百分比阻尼 |

#### F617–F642 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F617 | L482–485 / L484 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F631 | L487–490 / L489 | `$mc_ctrler.addQi(10);` — 加气 |
| F642 | L492–495 / L494 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F659 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F659 | L497–500 / L499 | `$mc_ctrler.addQi(20);` — 加气 |

#### F704 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F704 | L502–505 / L504 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F718–F771 — 放出攻击体 `shuilong`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F718 | L507–510 / L509 | `$effect_ctrler.bisha(false,"卡卡西1");` — 必杀演出（脸/黑屏） |
| F734 | L512–516 / L514 | `$effect_ctrler.endBisha();` — 关必杀演出 |
|  |  / L515 | `$mc_ctrler.addAttacker("shuilong",{"applyG":false});` — 放出攻击体 ADD_ATTACKER |
| F736 | L518–521 / L520 | `$effect_ctrler.shine(2676984);` — 闪光 |
| F747 | L523–526 / L525 | `$effect_ctrler.shine();` — 闪光 |
| F757 | L528–531 / L530 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F771 | L533–536 / L535 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F783 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F783 | L538–541 / L540 | `$effect_ctrler.bisha(false,"卡卡西2");` — 必杀演出（脸/黑屏） |

#### F819–F891 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F819 | L543–546 / L545 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F820 | L548–554 / L550 | `$mc_ctrler.movePercent(3,0);` — 按百分比位移 |
|  |  / L551 | `$mc_ctrler.setHitTarget("bs0atm","必杀2");` — 指定命中取样盒 |
|  |  / L552 | `$effect_ctrler.shadow(50,50,255);` — 残影 |
|  |  / L553 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F834 | L556–559 / L558 | `$mc_ctrler.dampingPercent(0.3,0);` — 百分比阻尼 |
| F845 | L561–564 / L563 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F851 | L566–568 | （空；? 仅占位） |
| F867 | L570–573 / L572 | `$effect_ctrler.shine(16777215);` — 闪光 |
| F877 | L575–578 / L577 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F891 | L580–583 / L582 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F913 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F913 | L585–588 / L587 | `$effect_ctrler.bisha(true,"卡卡西3");` — 必杀演出（脸/黑屏） |

#### F933–F934 — 放出攻击体 `shenwei`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F933 | L590–594 / L592 | `$effect_ctrler.endBisha();` — 关必杀演出 |
|  |  / L593 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
| F934 | L596–609 / L598 | `$mc_ctrler.addAttacker("shenwei",{"x":{"followTarget":true, "offset":0}, "y":{"followTarget":true, "offset":-20}, "applyG":false});` — 放出攻击体 ADD_ATTACKER |

#### F999 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F999 | L611–614 / L613 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1210–F1215 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1210 | L616–619 / L618 | `$mc_ctrler.movePercent(0.8,0);` — 按百分比位移 |
| F1214 | L621–624 / L623 | `$mc_ctrler.stopMove();` — 停位移 |
| F1215 | L626–629 / L628 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1235 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1235 | L631–634 / L633 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1310 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1310 | L636–639 / L638 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1351 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1351 | L641–644 / L643 | `$mc_ctrler.stop();` — 停动作 MC 播放 |

#### F1379 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1379 | L646–649 / L648 | `$mc_ctrler.stop();` — 停动作 MC 播放 |
