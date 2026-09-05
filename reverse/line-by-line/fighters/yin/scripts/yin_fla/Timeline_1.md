# `yin_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`/`doWanKai`/`addHp`。

源文件：`decompiled/fighters/yin/scripts/yin_fla/Timeline_1.as`（547 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`sh23atm`, `k4atm`, `cbsatm`, `sh22atm`, `zh3atm`, `tzatm`, `sbsatm`, `sh12atm`, `zh2atm`, `sbs1atm`, `cbs1atm`, `zh31atm`, `sh1atm`, `bdmn`, `sh2atm`, `zh12atm`, `kj21atm`, `AImain`, `bsatm`, `kj1atm`, `k1atm`, `k3atm`, `kj2atm`, `k2atm`, `zh1atm`, `k5atm`, `tkatm`。

市丸·银 动作 MC。

Embed `source="/_assets/assets.swf", symbol="symbol435"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `sh23atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `k4atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `sbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `zh31atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `bdmn` | `MovieClip` | 身体盒
| L50 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `zh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `kj21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L56 | `AImain` | `MovieClip` | AI 判定面容器
| L58 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L72 | `k5atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L74 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_1()`（L76–81）

- L78: `super();`
- L79: `addFrameScript(13, frame14, 18, frame19, 22, frame23, 30, frame31, 41, frame42, 44, frame45, 74, frame75, 84, frame85, 92, frame93, 95, frame96, 104, frame105, 105, frame106, 108, frame109, 115, frame116, 127, frame128, 152, frame153, 155, frame156, 161, frame162, 164, frame165, 170, frame171, 181, frame182, 187, frame188, 192, frame193, 198, frame199, 207, frame208, 213, frame214, 219, frame220, 226, frame227, 234, frame235, 244, frame245, 251, frame252, 257, frame258, 269, frame270, 275, frame276, 288, frame289, 300, frame301, 304, frame305, 332, frame333, 338, frame339, 346, frame347, 353, frame354, 358, frame359, 360, frame361, 362, frame363, 364, frame365, 374, frame375, 380, frame381, 394, frame395, 402, frame403, 420, frame421, 424, frame425, 430, frame431, 449, frame450, 450, frame451, 456, frame457, 463, frame464, 464, frame465, 467, frame468, 481, frame482, 500, frame501, 515, frame516, 520, frame521, 526, frame527, 535, frame536, 545, frame546, 553, frame554, 585, frame586, 599, frame600, 622, frame623, 625, frame626, 633, frame634, 661, frame662, 672, frame673, 694, frame695, 741, frame742, 762, frame763, 788, frame789, 820, frame821, 822, frame823, 884, frame885, 889, frame890, 915, frame916, 987, frame988, 1011, frame1012, 1072, frame1073, 1127, frame1128, 1155, frame1156);`

### 逐帧脚本

共 87 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F14–F45 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F14 | L83–86 / L85 | `$effect_ctrler.walk();` — 走路尘土 |
| F19 | L88–91 / L90 | `$effect_ctrler.walk();` — 走路尘土 |
| F23 | L93–96 / L95 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F31 | L98–106 / L100 | `$mc_ctrler.dash(2);` — 冲刺速度倍率 |
|  |  / L101 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L102 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L103 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L104 | `$effect_ctrler.shadow(150, 150, 150);` — 残影 |
|  |  / L105 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F42 | L108–111 / L110 | `$mc_ctrler.dashStop();` — 停冲 |
| F45 | L113–116 / L115 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F75 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F75 | L118–121 / L120 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F85–F96 — 空中段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F85 | L123–126 / L125 | `$mc_ctrler.setAirMove(true);` — 空中左右移动开关 |
| F93 | L128–131 / L130 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
| F96 | L133–136 / L135 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F105–F128 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F105 | L138–141 / L140 | `$mc_ctrler.move(0, -2);` — 设速度 |
| F106 | L143–146 / L145 | `$mc_ctrler.addQi(5);` — 加气 |
| F109 | L148–152 / L150 | `$mc_ctrler.move(-10, -10);` — 设速度 |
|  |  / L151 | `$mc_ctrler.damping(0.5, 0.5);` — 阻尼 |
| F116 | L154–157 / L156 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F128 | L159–162 / L161 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F153–F171 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F153 | L164–168 / L166 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L167 | `$mc_ctrler.dampingPercent(0.1, 0);` — 百分比阻尼 |
| F156 | L170–173 / L172 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
| F162 | L175–178 / L177 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F165 | L180–183 / L182 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F171 | L185–188 / L187 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F182–F199 — 动作 `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F182 | L190–194 / L192 | `$mc_ctrler.movePercent(0.5, 0);` — 按百分比位移 |
|  |  / L193 | `$mc_ctrler.dampingPercent(0.05, 0);` — 百分比阻尼 |
| F188 | L196–199 / L198 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
| F193 | L201–204 / L203 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F199 | L206–209 / L208 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F208–F227 — 动作 `砍4`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F208 | L211–215 / L213 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L214 | `$mc_ctrler.dampingPercent(0.1, 0);` — 百分比阻尼 |
| F214 | L217–222 / L219 | `$mc_ctrler.setAttack("砍4");` — 允许普攻接到指定帧标签 |
|  |  / L220 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L221 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
| F220 | L224–227 / L226 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F227 | L229–232 / L231 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F235–F258 — 动作 `砍5`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F235 | L234–238 / L236 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L237 | `$mc_ctrler.dampingPercent(0.1, 0);` — 百分比阻尼 |
| F245 | L240–250 / L242 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L243 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L244 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L245 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L246 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L247 | `$mc_ctrler.setAttack("砍5");` — 允许普攻接到指定帧标签 |
|  |  / L248 | `$mc_ctrler.setJump();` — 允许跳 |
|  |  / L249 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F252 | L252–255 / L254 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F258 | L257–260 / L259 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F270–F289 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F270 | L262–266 / L264 | `$mc_ctrler.movePercent(2, 0);` — 按百分比位移 |
|  |  / L265 | `$mc_ctrler.dampingPercent(0.2, 0);` — 百分比阻尼 |
| F276 | L268–271 / L270 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F289 | L273–276 / L275 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F301–F305 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F301 | L278–281 / L280 | `$mc_ctrler.addQi(10);` — 加气 |
| F305 | L283–287 / L285 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L286 | `$mc_ctrler.dampingPercent(0.05, 0);` — 百分比阻尼 |

#### F333–F395 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F333 | L289–293 / L291 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L292 | `$mc_ctrler.setZhao2("招21");` — 允许招 2 |
| F339 | L295–298 / L297 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F347 | L300–303 / L302 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F354 | L305–308 / L307 | `$mc_ctrler.addQi(10);` — 加气 |
| F359 | L310–314 / L312 | `$effect_ctrler.slowDown(0.5);` — 慢动作 |
|  |  / L313 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F361 | L316–319 / L318 | `$fighter_ctrler.moveToTarget(50, 0, true);` — 贴近目标 |
| F363 | L321–324 / L323 | `$effect_ctrler.shadow(150, 150, 150);` — 残影 |
| F365 | L326–330 / L328 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L329 | `$mc_ctrler.dampingPercent(0.1, 0);` — 百分比阻尼 |
| F375 | L332–336 / L334 | `$mc_ctrler.movePercent(-1, 0);` — 按百分比位移 |
|  |  / L335 | `$mc_ctrler.dampingPercent(0.05, 0);` — 百分比阻尼 |
| F381 | L338–341 / L340 | `$effect_ctrler.endShadow();` — 关残影 |
| F395 | L343–346 / L345 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F403 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F403 | L348–351 / L350 | `$mc_ctrler.addQi(5);` — 加气 |

#### F421–F431 — 动作 `砍1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F421 | L353–356 / L355 | `$mc_ctrler.setAttack("砍1");` — 允许普攻接到指定帧标签 |
| F425 | L358–361 / L360 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F431 | L363–366 / L365 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F450–F482 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F450 | L368–371 / L370 | `$mc_ctrler.addQi(10);` — 加气 |
| F451 | L373–377 / L375 | `$mc_ctrler.movePercent(0.5, 0);` — 按百分比位移 |
|  |  / L376 | `$effect_ctrler.shadow(150, 150, 150);` — 残影 |
| F457 | L379–383 / L381 | `$mc_ctrler.movePercent(0.5, 0);` — 按百分比位移 |
|  |  / L382 | `$effect_ctrler.shadow(150, 150, 150);` — 残影 |
| F464 | L385–388 / L387 | `$mc_ctrler.dampingPercent(0.05, 0);` — 百分比阻尼 |
| F465 | L390–394 / L392 | `$effect_ctrler.endShadow();` — 关残影 |
|  |  / L393 | `$effect_ctrler.shine();` — 闪光 |
| F468 | L396–399 / L398 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F482 | L401–404 / L403 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F501–F527 — 动作 `砍1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F501 | L406–409 / L408 | `$mc_ctrler.addQi(5);` — 加气 |
| F516 | L411–414 / L413 | `$mc_ctrler.setAttack("砍1");` — 允许普攻接到指定帧标签 |
| F521 | L416–419 / L418 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F527 | L421–424 / L423 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F536–F546 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F536 | L426–429 / L428 | `$mc_ctrler.addQi(10);` — 加气 |
| F546 | L431–434 / L433 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F554 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F554 | L436–439 / L438 | `$mc_ctrler.addQi(10);` — 加气 |

#### F586 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F586 | L441–444 / L443 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F600 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F600 | L446–449 / L448 | `$effect_ctrler.bisha(false, "银1");` — 必杀演出（脸/黑屏） |

#### F623–F634 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F623 | L451–454 / L453 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F626 | L456–459 / L458 | `$effect_ctrler.shine();` — 闪光 |
| F634 | L461–464 / L463 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F662 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F662 | L466–469 / L468 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F673 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F673 | L471–474 / L473 | `$effect_ctrler.bisha(false, "银1");` — 必杀演出（脸/黑屏） |

#### F695 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F695 | L476–479 / L478 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F742 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F742 | L481–484 / L483 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F763 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F763 | L486–489 / L488 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F789 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F789 | L491–494 / L493 | `$effect_ctrler.bisha(true, "银2");` — 必杀演出（脸/黑屏） |

#### F821–F823 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F821 | L496–499 / L498 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F823 | L501–504 / L503 | `$effect_ctrler.shine();` — 闪光 |

#### F885–F890 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F885 | L506–509 / L508 | `$effect_ctrler.shine();` — 闪光 |
| F890 | L511–514 / L513 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F916 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F916 | L516–519 / L518 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F988 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F988 | L521–524 / L523 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1012 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1012 | L526–529 / L528 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1073 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1073 | L531–534 / L533 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1128 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1128 | L536–539 / L538 | `$mc_ctrler.stop();` — 停时间轴 |

#### F1156 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1156 | L541–544 / L543 | `$mc_ctrler.stop();` — 停时间轴 |
