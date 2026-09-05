# `uryuu_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`/`doWanKai`/`addHp`。

源文件：`decompiled/fighters/uryuu/scripts/uryuu_fla/Timeline_1.as`（577 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`sh23atm`, `cbsatm`, `sh22atm`, `zh3atm`, `tzatm`, `sbsatm`, `sh12atm`, `cbs1atm`, `sh1atm`, `cbs2atm`, `bdmn`, `k31atm`, `sh2atm`, `AImain`, `bsatm`, `k32atm`, `kj1atm`, `k1atm`, `k3atm`, `kj2atm`, `k2atm`, `jian`, `zh1atm`, `tkatm`。

石田·雨龙 动作 MC。

Embed `source="/_assets/assets.swf", symbol="symbol387"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `sh23atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `cbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `bdmn` | `MovieClip` | 身体盒
| L44 | `k31atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `AImain` | `MovieClip` | AI 判定面容器
| L50 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `k32atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L56 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `jian` | `MovieClip` | 攻击体 MC（`addAttacker` 名）
| L66 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_1()`（L70–75）

- L72: `super();`
- L73: `addFrameScript(15, frame16, 24, frame25, 26, frame27, 30, frame31, 37, frame38, 42, frame43, 70, frame71, 80, frame81, 85, frame86, 90, frame91, 95, frame96, 97, frame98, 103, frame104, 108, frame109, 109, frame110, 118, frame119, 132, frame133, 148, frame149, 154, frame155, 160, frame161, 166, frame167, 170, frame171, 179, frame180, 184, frame185, 192, frame193, 203, frame204, 213, frame214, 216, frame217, 222, frame223, 229, frame230, 241, frame242, 251, frame252, 253, frame254, 255, frame256, 263, frame264, 285, frame286, 292, frame293, 302, frame303, 310, frame311, 326, frame327, 328, frame329, 335, frame336, 340, frame341, 348, frame349, 361, frame362, 363, frame364, 370, frame371, 378, frame379, 384, frame385, 400, frame401, 433, frame434, 443, frame444, 451, frame452, 463, frame464, 474, frame475, 510, frame511, 525, frame526, 549, frame550, 550, frame551, 569, frame570, 577, frame578, 606, frame607, 610, frame611, 621, frame622, 629, frame630, 630, frame631, 643, frame644, 664, frame665, 699, frame700, 752, frame753, 765, frame766, 800, frame801, 859, frame860, 926, frame927, 944, frame945, 1035, frame1036, 1059, frame1060, 1138, frame1139, 1175, frame1176, 1198, frame1199);`

### 逐帧脚本

共 80 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F16–F43 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F16 | L77–80 / L79 | `$effect_ctrler.walk();` — 走路尘土 |
| F25 | L82–85 / L84 | `$effect_ctrler.walk();` — 走路尘土 |
| F27 | L87–90 / L89 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F31 | L92–100 / L94 | `$mc_ctrler.dash(3);` — 冲刺速度倍率 |
|  |  / L95 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L96 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L97 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L98 | `$effect_ctrler.shadow(0, 150, 255);` — 残影 |
|  |  / L99 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F38 | L102–105 / L104 | `$mc_ctrler.dashStop();` — 停冲 |
| F43 | L107–110 / L109 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F71 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F71 | L112–115 / L114 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F81–F133 — 动作 `跳招`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F81 | L117–121 / L119 | `$mc_ctrler.move(0, -2);` — 设速度 |
|  |  / L120 | `$mc_ctrler.damping(0, 0.1);` — 阻尼 |
| F86 | L123–131 / L125 | `$mc_ctrler.fire("tkatm", { "x":15, "y":13, "hold":0.5, "hits":1 });` — 出子弹（hits:1） |
| F91 | L133–141 / L135 | `$mc_ctrler.fire("tkatm", { "x":15, "y":13, "hold":0.5, "hits":1 });` — 出子弹（hits:1） |
| F96 | L143–151 / L145 | `$mc_ctrler.fire("tkatm", { "x":15, "y":13, "hold":0.5, "hits":1 });` — 出子弹（hits:1） |
| F98 | L153–157 / L155 | `$mc_ctrler.setSkillAIR("跳招");` — 允许空中技能 |
|  |  / L156 | `$mc_ctrler.setBishaAIR();` — 允许空必杀 |
| F104 | L159–162 / L161 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F109 | L164–168 / L166 | `$mc_ctrler.move(0, -2);` — 设速度 |
|  |  / L167 | `$mc_ctrler.damping(0, 0.1);` — 阻尼 |
| F110 | L170–173 / L172 | `$mc_ctrler.addQi(5);` — 加气 |
| F119 | L175–185 / L177 | `$mc_ctrler.move(-2, -2);` — 设速度 |
|  |  / L178 | `$mc_ctrler.damping(0.1, 0.1);` — 阻尼 |
|  |  / L179 | `$mc_ctrler.fire("tzatm", { "x":20, "y":10, "hold":1, "hits":1 });` — 出子弹（hits:1） |
| F133 | L187–190 / L189 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F149–F193 — 动作 `砍2` / `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F149 | L192–201 / L194 | `$mc_ctrler.fire("k1atm", { "x":15, "y":0, "hold":0.3, "hits":1, "hp":50 });` — 出子弹（hits:1） |
| F155 | L203–208 / L205 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L206 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L207 | `$mc_ctrler.setBisha();` — 允许必杀 |
| F161 | L210–213 / L212 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F167 | L215–218 / L217 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F171 | L220–224 / L222 | `$mc_ctrler.move(15, 0);` — 设速度 |
|  |  / L223 | `$mc_ctrler.damping(1.5, 0);` — 阻尼 |
| F180 | L226–234 / L228 | `$mc_ctrler.fire("k2atm", { "x":15, "y":0, "hold":0.5, "hits":1 });` — 出子弹（hits:1） |
| F185 | L236–244 / L238 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L239 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L240 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L241 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L242 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L243 | `$mc_ctrler.setBisha();` — 允许必杀 |
| F193 | L246–249 / L248 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F204–F242 — 动作 `砍32` / `跳招`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F204 | L251–255 / L253 | `$mc_ctrler.move(-5, -8);` — 设速度 |
|  |  / L254 | `$mc_ctrler.damping(0.2, 0.5);` — 阻尼 |
| F214 | L257–281 / L259 | `$mc_ctrler.setTouchFloor("砍32", true);` — 落地切标签 |
|  |  / L260 | `$mc_ctrler.fire("k3atm", { "x":15, "y":5, "hold":0.5, "hits":1, "hp":50 });` — 出子弹（hits:1） |
|  |  / L267 | `$mc_ctrler.fire("k31atm", { "x":18, "y":2, "hold":0.5, "hits":1, "hp":50 });` — 出子弹（hits:1） |
|  |  / L274 | `$mc_ctrler.fire("k32atm", { "x":12, "y":8, "hold":0.5, "hits":1, "hp":50 });` — 出子弹（hits:1） |
| F217 | L283–287 / L285 | `$mc_ctrler.setSkillAIR("跳招");` — 允许空中技能 |
|  |  / L286 | `$mc_ctrler.setBishaAIR();` — 允许空必杀 |
| F223 | L289–292 / L291 | `$mc_ctrler.stop();` — 停时间轴 |
| F230 | L294–299 / L296 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L297 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L298 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
| F242 | L301–304 / L303 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F252–F264 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F252 | L306–311 / L308 | `$effect_ctrler.slowDown(0.5);` — 慢动作 |
|  |  / L309 | `$effect_ctrler.shadow(0, 150, 255);` — 残影 |
|  |  / L310 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F254 | L313–316 / L315 | `$fighter_ctrler.moveToTarget(100, -40, true);` — 贴近目标 |
| F256 | L318–321 / L320 | `$mc_ctrler.move(-5, -1);` — 设速度 |
| F264 | L323–328 / L325 | `$mc_ctrler.move(-10, -5);` — 设速度 |
|  |  / L326 | `$mc_ctrler.damping(0.2, 0.2);` — 阻尼 |
|  |  / L327 | `$effect_ctrler.endShadow();` — 关残影 |

#### F286–F311 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F286 | L330–333 / L332 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F293 | L335–338 / L337 | `$mc_ctrler.addQi(10);` — 加气 |
| F303 | L340–343 / L342 | `$effect_ctrler.shine(11382189);` — 闪光 |
| F311 | L345–348 / L347 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F327–F349 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F327 | L350–353 / L352 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F329 | L355–358 / L357 | `$mc_ctrler.addQi(5);` — 加气 |
| F336 | L360–368 / L362 | `$mc_ctrler.fire("zh1atm", { "x":30, "y":0, "hold":1, "hits":1 });` — 出子弹（hits:1） |
| F341 | L370–373 / L372 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F349 | L375–378 / L377 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F362–F385 — 空中段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F362 | L380–383 / L382 | `$mc_ctrler.addQi(10);` — 加气 |
| F364 | L385–389 / L387 | `$mc_ctrler.movePercent(1, -1.5);` — 按百分比位移 |
|  |  / L388 | `$mc_ctrler.dampingPercent(0.05, 0);` — 百分比阻尼 |
| F371 | L391–397 / L393 | `$mc_ctrler.setAttackAIR();` — 允许空中普攻 |
|  |  / L394 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
|  |  / L395 | `$mc_ctrler.setBishaAIR();` — 允许空必杀 |
|  |  / L396 | `$mc_ctrler.dampingPercent(0.1, 0.1);` — 百分比阻尼 |
| F379 | L399–402 / L401 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F385 | L404–407 / L406 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F401 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F401 | L409–412 / L411 | `$mc_ctrler.addQi(5);` — 加气 |

#### F434–F444 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F434 | L414–427 / L416 | `$mc_ctrler.addAttacker("jian", { "x":{ "moveToTarget":true, "offset":0 }, "y":{ "moveToTarget":true, "offset":-500 }, "applyG":true });` — 放出攻击体 |
| F444 | L429–432 / L431 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F452–F464 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F452 | L434–437 / L436 | `$mc_ctrler.addQi(15);` — 加气 |
| F464 | L439–442 / L441 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F475 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F475 | L444–447 / L446 | `$mc_ctrler.addQi(15);` — 加气 |

#### F511 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F511 | L449–452 / L451 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F526 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F526 | L454–457 / L456 | `$effect_ctrler.bisha(false, "石田1");` — 必杀演出（脸/黑屏） |

#### F550–F551 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F550 | L459–462 / L461 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F551 | L464–468 / L466 | `$mc_ctrler.move(-15, 0);` — 设速度 |
|  |  / L467 | `$mc_ctrler.damping(2, 0);` — 阻尼 |

#### F570–F578 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F570 | L470–473 / L472 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F578 | L475–478 / L477 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F607–F644 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F607 | L480–483 / L482 | `$fighter_ctrler.moveToTarget(0, -200, true);` — 贴近目标 |
| F611 | L485–488 / L487 | `$effect_ctrler.bisha(false, "石田2");` — 必杀演出（脸/黑屏） |
| F622 | L490–493 / L492 | `$effect_ctrler.shine();` — 闪光 |
| F630 | L495–498 / L497 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F631 | L500–504 / L502 | `$mc_ctrler.move(0, -15);` — 设速度 |
|  |  / L503 | `$mc_ctrler.damping(0, 0.5);` — 阻尼 |
| F644 | L506–509 / L508 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F665 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F665 | L511–514 / L513 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F700 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F700 | L516–519 / L518 | `$effect_ctrler.bisha(true, "石田2");` — 必杀演出（脸/黑屏） |

#### F753–F766 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F753 | L521–524 / L523 | `$fighter_ctrler.moveToTarget(0, 0, false);` — 贴近目标 |
| F766 | L526–529 / L528 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F801 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F801 | L531–534 / L533 | `$effect_ctrler.bisha(false, "石田3");` — 必杀演出（脸/黑屏） |

#### F860 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F860 | L536–539 / L538 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F927 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F927 | L541–544 / L543 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F945 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F945 | L546–549 / L548 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1036 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1036 | L551–554 / L553 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1060 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1060 | L556–559 / L558 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1139 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1139 | L561–564 / L563 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1176 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1176 | L566–569 / L568 | `$mc_ctrler.stop();` — 停时间轴 |

#### F1199 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1199 | L571–574 / L573 | `$mc_ctrler.stop();` — 停时间轴 |
