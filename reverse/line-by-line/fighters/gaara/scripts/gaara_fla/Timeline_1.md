# `gaara_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`doWanKai`。

源文件：`decompiled/fighters/gaara/scripts/gaara_fla/Timeline_1.as`（623 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`sh22atm`, `tzatm`, `sbsatm`, `sh12atm`, `zh2atm`, `sbs1atm`, `zzzz`, `sbs3atm`, `sbs2atm`, `sh1atm`, `bdmn`, `sh2atm`, `AImain`, `kj1atm`, `k1atm`, `k3atm`, `move_mc`, `kj2atm`, `k2atm`, `zh1atm`, `zzz1`, `tkatm`, `zz`, `zz1`, `zz2`, `justHit`, `bsmc1`, `bsmc`。

我爱罗动作 MC（类名 `Timeline_1`）。必杀脸键 `我爱罗1`/`我爱罗2`；攻击体 `zzzz`、`bsmc`；抓人跟随 `move_mc`。上必会 `target.visible=false` 把对手藏进砂里。

Embed `source="/_assets/assets.swf", symbol="symbol500"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `sbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `zzzz` | `MovieClip` | 砂缚棺攻击体 MC（addAttacker 名）
| L36 | `sbs3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `sbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `bdmn` | `MovieClip` | 身体盒
| L44 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `AImain` | `MovieClip` | AI 判定面容器
| L48 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `move_mc` | `MovieClip` | 抓人跟随锚点
| L56 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `zzz1` | `MovieClip` | 砂相关子件
| L64 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `zz` | `*` | 攻击体引用缓存
| L68 | `zz1` | `*` | 攻击体引用缓存
| L70 | `zz2` | `*` | 攻击体引用缓存
| L72 | `justHit` | `*` | 刚命中缓存
| L74 | `bsmc1` | `*` | 攻击体引用缓存
| L76 | `bsmc` | `*` | 超必/必杀攻击体 MC

### 函数

#### `Timeline_1()`（L78–83）

- L80: `super();`
- L81: `addFrameScript(11, this.frame12, 17, this.frame18, 22, this.frame23, 25, this.frame26, 27, this.frame28, 34, this.frame35, 39, this.frame40, 69, this.frame70, 81, this.frame82, 86, this.frame87, 90, this.frame91, 95, this.frame96, 96, this.frame97, 104, this.frame105, 112, this.frame113, 131, this.frame132, 136, this.frame137, 140, this.frame141, 152, this.frame153, 159, this.frame160, 169, this.frame170, 173, this.frame174, 187, this.frame188, 193, this.frame194, 209, this.frame210, 224, this.frame225, 225, this.frame226, 245, this.frame246, 260, this.frame261, 268, this.frame269, 269, this.frame270, 274, this.frame275, 280, this.frame281, 286, this.frame287, 299, this.frame300, 321, this.frame322, 328, this.frame329, 338, this.frame339, 345, this.frame346, 357, this.frame358, 365, this.frame366, 393, this.frame394, 401, this.frame402, 405, this.frame406, 421, this.frame422, 431, this.frame432, 436, this.frame437, 451, this.frame452, 459, this.frame460, 470, this.frame471, 477, this.frame478, 504, this.frame505, 519, this.frame520, 531, this.frame532, 532, this.frame533, 534, this.frame535, 552, this.frame553, 553, this.frame554, 572, this.frame573, 597, this.frame598, 603, this.frame604, 623, this.frame624, 644, this.frame645, 659, this.frame660, 679, this.frame680, 692, this.frame693, 708, this.frame709, 711, this.frame712, 712, this.frame713, 721, this.frame722, 741, this.frame742, 746, this.frame747, 767, this.frame768, 786, this.frame787, 824, this.frame825, 826, this.frame827, 833, this.frame834, 836, this.frame837, 865, this.frame866, 867, this.frame868, 886, this.frame887, 936, this.frame937, 966, this.frame967, 1054, this.frame1055, 1074, this.frame1075, 1172, this.frame1173, 1213, this.frame1214, 1241, this.frame1242);`

### 逐帧脚本

共 88 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F12–F40 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F12 | L85–88 / L87 | `$effect_ctrler.walk();` — 走路尘土 |
| F18 | L90–93 / L92 | `$effect_ctrler.walk();` — 走路尘土 |
| F23 | L95–98 / L97 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F26 | L100–103 / L102 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F28 | L105–111 / L107 | `$mc_ctrler.dash(3);` — 冲刺速度倍率 |
|  |  / L108 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L109 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L110 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
| F35 | L113–116 / L115 | `$mc_ctrler.dashStop();` — 停冲 |
| F40 | L118–121 / L120 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F70 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F70 | L123–126 / L125 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F82–F113 — 空中段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F82 | L128–132 / L130 | `$mc_ctrler.move(0, -2);` — 设速度 |
|  |  / L131 | `$mc_ctrler.damping(0, 0.2);` — 阻尼 |
| F87 | L134–137 / L136 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
| F91 | L139–142 / L141 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F96 | L144–148 / L146 | `$mc_ctrler.move(0, -2);` — 设速度 |
|  |  / L147 | `$mc_ctrler.damping(0, 0.05);` — 阻尼 |
| F97 | L150–153 / L152 | `$mc_ctrler.addQi(5);` — 加气 |
| F105 | L155–158 / L157 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F113 | L160–163 / L162 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F132–F141 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F132 | L165–168 / L167 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
| F137 | L170–173 / L172 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F141 | L175–178 / L177 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F153–F210 — 动作 `砍3` / `招11`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F153 | L180–186 / L182 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L183 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L184 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L185 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
| F160 | L188–191 / L190 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F170 | L193–196 / L195 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F174 | L198–202 / L200 | `$mc_ctrler.movePercent(1, 0);` — 按百分比位移 |
|  |  / L201 | `$mc_ctrler.dampingPercent(0.1, 0);` — 百分比阻尼 |
| F188 | L204–212 / L206 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L207 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L208 | `$mc_ctrler.setZhao2();` — 允许招 2 |
|  |  / L209 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L210 | `$mc_ctrler.setZhao1("招11");` — 允许招 1 |
|  |  / L211 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F194 | L214–217 / L216 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F210 | L219–222 / L221 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F225–F226 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F225 | L224–228 / L226 | `$mc_ctrler.movePercent(1.5, 0);` — 按百分比位移 |
|  |  / L227 | `$mc_ctrler.dampingPercent(0.15, 0);` — 百分比阻尼 |
| F226 | L230–233 / L232 | `$mc_ctrler.addQi(10);` — 加气 |

#### F246–F300 — 放出攻击体 `zzz1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F246 | L235–238 / L237 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F261 | L240–243 / L242 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F269 | L245–248 / L247 | `$mc_ctrler.addQi(10);` — 加气 |
| F270 | L250–258 / L252 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
|  |  / L253 | `$mc_ctrler.addAttacker("zzz1", {"x": {"followTarget":true, "offset":0, "range":[0, 250]}});` — 放出攻击体 ADD_ATTACKER |
| F275 | L260–263 / L262 | `$mc_ctrler.setJump();` — 允许跳 |
| F281 | L265–271 / L267 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L268 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L269 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L270 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
| F287 | L273–276 / L275 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F300 | L278–281 / L280 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F322–F366 — 发射子弹 `zh1atm`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F322 | L283–286 / L285 | `$mc_ctrler.addQi(5);` — 加气 |
| F329 | L288–300 / L290 | `$mc_ctrler.fire("zh1atm", {"x": {"start":5, "max":30, "add":0.5}, "y":0, "hold":3, "hits":-1});` — 发射子弹 FIRE |
| F339 | L302–305 / L304 | `$mc_ctrler.setBisha();` — 允许必杀 |
| F346 | L307–310 / L309 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F358 | L312–315 / L314 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F366 | L317–320 / L319 | `$mc_ctrler.addQi(10);` — 加气 |

#### F394–F406 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F394 | L322–326 / L324 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L325 | `$mc_ctrler.setBisha();` — 允许必杀 |
| F402 | L328–331 / L330 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F406 | L333–336 / L335 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F422–F478 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F422 | L338–341 / L340 | `$mc_ctrler.addQi(5);` — 加气 |
| F432 | L343–346 / L345 | `$effect_ctrler.shine(9074006);` — 闪光 |
| F437 | L348–351 / L350 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F452 | L353–356 / L355 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F460 | L358–361 / L360 | `$mc_ctrler.addQi(10);` — 加气 |
| F471 | L363–366 / L365 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F478 | L368–371 / L370 | `$mc_ctrler.addQi(20);` — 加气 |

#### F505 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F505 | L373–376 / L375 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F520–F535 — 放出攻击体 `zzzz`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F520 | L378–381 / L380 | `$effect_ctrler.bisha(false, "我爱罗1");` — 必杀演出（脸/黑屏） |
| F532 | L383–386 / L385 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F533 | L388–391 / L390 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |
| F535 | L393–400 / L395 | `$mc_ctrler.addAttacker("zzzz", {"x": {"followTarget":true, "offset":0, "range":[0, 400]}});` — 放出攻击体 ADD_ATTACKER |

#### F553–F554 — 动作 `必杀1` / `fly`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F553 | L402–408 / L404 | `if(!$fighter_ctrler.justHit("bs1")) {$mc_ctrler.gotoAndPlay("必杀1");}` — 刚命中判定 |
| F554 | L410–421 / L412 | `if($fighter_ctrler.target) {$fighter_ctrler.target.visible = false;}` — 目标存在才操作 |
|  |  / L416 | `zz = $mc_ctrler.getAttacker("zzzz");` — 缓存攻击体引用 |
|  |  / L419 | `if(zz) {zz.gotoAndPlay("fly");}` — 攻击体仍在才切标签 |

#### F573 — 动作 `boom`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F573 | L423–431 / L425 | `zz1 = $mc_ctrler.getAttacker("zzzz");` — 缓存攻击体引用 |
|  |  / L428 | `if(zz1) {zz1.gotoAndPlay("boom");}` — 攻击体仍在才切标签 |
|  |  / L430 | `$effect_ctrler.shine();` — 闪光 |

#### F598–F604 — 动作 `miss`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F598 | L433–436 / L435 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F604 | L438–446 / L440 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L441 | `zz2 = $mc_ctrler.getAttacker("zzzz");` — 缓存攻击体引用 |
|  |  / L444 | `if(zz2) {zz2.gotoAndPlay("miss");}` — 攻击体仍在才切标签 |

#### F624 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F624 | L448–451 / L450 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F645–F660 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F645 | L453–456 / L455 | `$effect_ctrler.bisha(false, "我爱罗1");` — 必杀演出（脸/黑屏） |
| F660 | L458–461 / L460 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F680–F722 — 动作 `上必杀2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F680 | L463–466 / L465 | `$effect_ctrler.shine(9074006);` — 闪光 |
| F693 | L468–479 / L470 | `justHit = $fighter_ctrler.justHit("sbs3");` — 记下刚命中 |
|  |  / L473 | `if(justHit) {$mc_ctrler.moveTarget({"followmc":"move_mc"});if($fighter_ctrler.target) {$fighter_ctrler.target.visible = false;}}` — 刚命中判定 |
| F709 | L481–487 / L485 | `if(!justHit) {$mc_ctrler.gotoAndPlay("上必杀2");}` — 刚命中判定 |
| F712 | L489–492 / L491 | `$effect_ctrler.shine();` — 闪光 |
| F713 | L494–500 / L496 | `if($fighter_ctrler.target) {$fighter_ctrler.target.visible = true;}` — 目标存在才操作 |
| F722 | L502–505 / L504 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F742–F747 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F742 | L507–510 / L509 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F747 | L512–515 / L514 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F768 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F768 | L517–520 / L519 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F787 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F787 | L522–525 / L524 | `$effect_ctrler.bisha(true, "我爱罗2");` — 必杀演出（脸/黑屏） |

#### F825–F837 — 动作 `miss`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F825 | L527–531 / L529 | `$effect_ctrler.endBisha();` — 关必杀演出 |
|  |  / L530 | `$effect_ctrler.slowDown(1);` — 全局慢动作 |
| F827 | L533–548 / L535 | `$mc_ctrler.addAttacker("bsmc", {"x": {"followTarget":true, "offset":10, "range":[0, 500]}, "y": {"followTarget":true, "offset":-15, "range":[-250, 250]}, "applyG":false});` — 放出攻击体 ADD_ATTACKER |
| F834 | L550–553 / L552 | `$mc_ctrler.justHitToPlay("cbs1", "超必杀HIT", false, false);` — 刚命中才跳到标签 |
| F837 | L555–562 / L557 | `bsmc1 = $mc_ctrler.getAttacker("bsmc");` — 缓存攻击体引用 |
|  |  / L560 | `if(bsmc1) {bsmc1.gotoAndPlay("miss");}` — 攻击体仍在才切标签 |

#### F866–F868 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F866 | L564–567 / L566 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F868 | L569–572 / L571 | `$fighter_ctrler.setTargetVelocity(0, -3);` — 改对手速度 |

#### F887 — 动作 `start`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F887 | L574–581 / L576 | `bsmc = $mc_ctrler.getAttacker("bsmc");` — 缓存攻击体引用 |
|  |  / L579 | `if(bsmc) {bsmc.gotoAndPlay("start");}` — 攻击体仍在才切标签 |

#### F937 — 动作 `big`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F937 | L583–590 / L587 | `if(bsmc) {bsmc.gotoAndPlay("big");}` — 攻击体仍在才切标签 |
|  |  / L589 | `$effect_ctrler.slowDown(0.5);` — 全局慢动作 |

#### F967 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F967 | L592–595 / L594 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1055 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1055 | L597–600 / L599 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1075 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1075 | L602–605 / L604 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1173 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1173 | L607–610 / L609 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1214 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1214 | L612–615 / L614 | `$mc_ctrler.stop();` — 停动作 MC 播放 |

#### F1242 — 胜负/死亡停帧

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1242 | L617–620 / L619 | `$mc_ctrler.stop();` — 停动作 MC 播放 |
