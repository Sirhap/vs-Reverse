# `sasuke_xz_old_fla.Timeline_1` — 动作 MC `Timeline_1`

一句话目的：角色动作时间轴 `Timeline_1`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`/`justHit`/`doWanKai`/`addHp`。

源文件：`decompiled/fighters/sasuke_xz_old/scripts/sasuke_xz_old_fla/Timeline_1.as`（728 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`k4atm`, `cbsatm`, `tianzhao`, `sh22atm`, `zh3atm`, `tzatm`, `sbsatm`, `sh12atm`, `zh2atm`, `cbs1atm`, `zh21atm`, `cbs3atm`, `sh1atm`, `tk1atm`, `cbs2atm`, `zh32atm`, `bdmn`, `zh22atm`, `sh2atm`, `kj21atm`, `tk2atm`, `AImain`, `kbsatm`, `kj10atm`, `kj22atm`, `kj13atm`, `kj1atm`, `k1atm`, `kj12atm`, `k3atm`, `kbs2atm`, `move_mc`, `kj2atm`, `k2atm`, `zh1atm`, `k5atm`, `tkatm`。

宇智波·佐助 须佐能乎（旧档） 动作 MC。 遗留 SWF，不在现行 `fighter.xml`；动作 MC 类名 `Timeline_1`。必杀脸键与现行须佐能乎同为 `须佐助1/2`，但动作里还有一次 `bisha(..., "佐助1")`（? 该键未 `defineBishaFace`）。

Embed `source="/_assets/assets.swf", symbol="symbol739"`。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `k4atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L24 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L26 | `tianzhao` | `MovieClip` | 攻击体 MC（`addAttacker` 名）
| L28 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `zh21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `cbs3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L46 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `tk1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `cbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `zh32atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `bdmn` | `MovieClip` | 身体盒
| L56 | `zh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `kj21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `tk2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `AImain` | `MovieClip` | AI 判定面容器
| L66 | `kbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L68 | `kj10atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L70 | `kj22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L72 | `kj13atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L74 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L76 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L78 | `kj12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L80 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L82 | `kbs2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L84 | `move_mc` | `MovieClip` | 位移跟随辅助 MC（`moveTarget({followmc})`）
| L86 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L88 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L90 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L92 | `k5atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L94 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `Timeline_1()`（L96–102）

- L98: `super();`
- L99: `addFrameScript(11, frame12, 13, frame14, 22, frame23, 26, frame27, 29, frame30, 59, frame60, 69, frame70, 78, frame79, 82, frame83, 86, frame87, 95, frame96, 97, frame98, 112, frame113, 124, frame125, 141, frame142, 150, frame151, 168, frame169, 178, frame179, 182, frame183, 190, frame191, 202, frame203, 223, frame224, 227, frame228, 233, frame234, 239, frame240, 248, frame249, 259, frame260, 265, frame266, 268, frame269, 280, frame281, 292, frame293, 299, frame300, 306, frame307, 317, frame318, 323, frame324, 329, frame330, 336, frame337, 344, frame345, 359, frame360, 373, frame374, 381, frame382, 389, frame390, 402, frame403, 403, frame404, 412, frame413, 415, frame416, 420, frame421, 422, frame423, 428, frame429, 435, frame436, 441, frame442, 450, frame451, 453, frame454, 454, frame455, 455, frame456, 472, frame473, 480, frame481, 501, frame502, 508, frame509, 510, frame511, 511, frame512, 514, frame515, 529, frame530, 537, frame538, 544, frame545, 550, frame551, 572, frame573, 585, frame586, 603, frame604, 629, frame630, 642, frame643, 645, frame646, 656, frame657, 658, frame659, 667, frame668, 679, frame680, 690, frame691, 699, frame700, 700, frame701, 716, frame717, 745, frame746, 750, frame751, 766, frame767, 783, frame784, 794, frame795, 807, frame808, 817, frame818, 837, frame838, 850, frame851, 875, frame876, 878, frame879, 941, frame942, 957, frame958, 994, frame995, 1001, frame1002, 1045, frame1046, 1064, frame1065, 1070, frame1071, 1095, frame1096, 1098, frame1099, 1099, frame1100, 1130, frame1131, 1158, frame1159, 1161, frame1162, 1205, frame1206, 1212, frame1213, 1288, frame1289, 1365, frame1366, 1367, frame1368, 1369, frame1370, 1392, frame1393, 1486, frame1487, 1546, frame1547, 1574, frame1575);`

### 逐帧脚本

共 114 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F12–F30 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F12 | L104–107 / L106 | `$effect_ctrler.walk();` — 走路尘土 |
| F14 | L109–112 / L111 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F23 | L114–118 / L116 | `$mc_ctrler.dash(5);` — 冲刺速度倍率 |
|  |  / L117 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F27 | L120–123 / L122 | `$mc_ctrler.dashStop();` — 停冲 |
| F30 | L125–128 / L127 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F60 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F60 | L130–133 / L132 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F70–F87 — 动作 `落地`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F70 | L135–138 / L137 | `$mc_ctrler.setAirMove(true);` — 空中左右移动开关 |
| F79 | L140–152 / L142 | `$mc_ctrler.setSkillAIR();` — 允许空中技能 |
|  |  / L143 | `$mc_ctrler.setBishaAIR();` — 允许空必杀 |
|  |  / L144 | `if($fighter_ctrler.justHit("tk2")){ $mc_ctrler.setAttackAIR("跳砍0"); }else{ $mc_ctrler.setAttackAIR("跳砍1"); }` — 允许空中普攻 |
| F83 | L154–157 / L156 | `$mc_ctrler.setTouchFloor("落地", true);` — 落地切标签 |
| F87 | L159–162 / L161 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F96–F125 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F96 | L164–167 / L166 | `$fighter_ctrler.moveToTarget(-30, 0, true);` — 贴近目标 |
| F98 | L169–173 / L171 | `$mc_ctrler.move(14, -4);` — 设速度 |
|  |  / L172 | `$mc_ctrler.damping(0.3, 0.1);` — 阻尼 |
| F113 | L175–178 / L177 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F125 | L180–183 / L182 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F142–F151 — 动作 `跳招2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F142 | L185–189 / L187 | `$mc_ctrler.isApplyG(false);` — 是否受重力 |
|  |  / L188 | `$effect_ctrler.slowDown(0.5);` — 慢动作 |
| F151 | L191–198 / L193 | `$mc_ctrler.isApplyG(true);` — 是否受重力 |
|  |  / L194 | `$mc_ctrler.setTouchFloor("跳招2", true);` — 落地切标签 |
|  |  / L195 | `$mc_ctrler.movePercent(1.5, 1);` — 按百分比位移 |
|  |  / L196 | `$effect_ctrler.shine(5422583);` — 闪光 |
|  |  / L197 | `$effect_ctrler.shadow(110, -50, 255);` — 残影 |

#### F169–F203 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F169 | L200–204 / L202 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
|  |  / L203 | `$mc_ctrler.dampingPercent(0.1, 0.1);` — 百分比阻尼 |
| F179 | L206–209 / L208 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F183 | L211–215 / L213 | `$effect_ctrler.shake(0, 3);` — 震动 |
|  |  / L214 | `$effect_ctrler.endShadow();` — 关残影 |
| F191 | L217–220 / L219 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F203 | L222–225 / L224 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F224–F240 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F224 | L227–231 / L229 | `$mc_ctrler.move(4, 0);` — 设速度 |
|  |  / L230 | `$mc_ctrler.damping(0.4, 0);` — 阻尼 |
| F228 | L233–236 / L235 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
| F234 | L238–241 / L240 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F240 | L243–246 / L245 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F249–F269 — 动作 `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F249 | L248–252 / L250 | `$mc_ctrler.move(7, 0);` — 设速度 |
|  |  / L251 | `$mc_ctrler.damping(0.7, 0);` — 阻尼 |
| F260 | L254–257 / L256 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
| F266 | L259–262 / L261 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F269 | L264–267 / L266 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F281–F307 — 动作 `砍4`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F281 | L269–273 / L271 | `$mc_ctrler.move(6, 0);` — 设速度 |
|  |  / L272 | `$mc_ctrler.damping(0.4, 0);` — 阻尼 |
| F293 | L275–280 / L277 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L278 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L279 | `$mc_ctrler.setAttack("砍4");` — 允许普攻接到指定帧标签 |
| F300 | L282–285 / L284 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F307 | L287–290 / L289 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F318–F345 — 动作 `砍5`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F318 | L292–295 / L294 | `$mc_ctrler.move(10, 0);` — 设速度 |
| F324 | L297–300 / L299 | `$mc_ctrler.damping(2, 0);` — 阻尼 |
| F330 | L302–308 / L304 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L305 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L306 | `$mc_ctrler.setSkill1();` — 允许下攻/技能 1 |
|  |  / L307 | `$mc_ctrler.setAttack("砍5");` — 允许普攻接到指定帧标签 |
| F337 | L310–313 / L312 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F345 | L315–318 / L317 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F360–F390 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F360 | L320–324 / L322 | `$mc_ctrler.move(8, 0);` — 设速度 |
|  |  / L323 | `$mc_ctrler.damping(0.4, 0);` — 阻尼 |
| F374 | L326–329 / L328 | `$mc_ctrler.setDash();` — 允许冲刺/瞬步 |
| F382 | L331–334 / L333 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F390 | L336–339 / L338 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F403–F442 — 动作 `砍技12`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F403 | L341–346 / L343 | `$mc_ctrler.setHitTarget("kj10atm", "砍技11");` — 攻击体命中取样 |
|  |  / L344 | `$mc_ctrler.movePercent(2, 0);` — 按百分比位移 |
|  |  / L345 | `$effect_ctrler.shadow(110, -50, 255);` — 残影 |
| F404 | L348–352 / L350 | `$mc_ctrler.addQi(10);` — 加气 |
|  |  / L351 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F413 | L354–357 / L356 | `$mc_ctrler.dampingPercent(0.2, 0);` — 百分比阻尼 |
| F416 | L359–362 / L361 | `$effect_ctrler.endShadow();` — 关残影 |
| F421 | L364–367 / L366 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F423 | L369–372 / L371 | `$effect_ctrler.shine();` — 闪光 |
| F429 | L374–381 / L376 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L377 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L378 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L379 | `$mc_ctrler.setSkill1("砍技12");` — 允许下攻/技能 1 |
|  |  / L380 | `$mc_ctrler.setAttack("砍技12");` — 允许普攻接到指定帧标签 |
| F436 | L383–386 / L385 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F442 | L388–391 / L390 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F451–F456 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F451 | L393–396 / L395 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F454 | L398–402 / L400 | `$mc_ctrler.move(100, 0);` — 设速度 |
|  |  / L401 | `$mc_ctrler.damping(50, 0);` — 阻尼 |
| F455 | L404–407 / L406 | `$mc_ctrler.move(7, 0);` — 设速度 |
| F456 | L409–412 / L411 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F473–F481 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F473 | L414–418 / L416 | `$mc_ctrler.damping(0.5, 0);` — 阻尼 |
|  |  / L417 | `$effect_ctrler.shine(5422583);` — 闪光 |
| F481 | L420–423 / L422 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F502–F551 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F502 | L425–428 / L427 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F509 | L430–434 / L432 | `$mc_ctrler.addQi(10);` — 加气 |
|  |  / L433 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F511 | L436–439 / L438 | `$fighter_ctrler.moveToTarget(50, 0, true);` — 贴近目标 |
| F512 | L441–444 / L443 | `$effect_ctrler.slowDown(0.5);` — 慢动作 |
| F515 | L446–449 / L448 | `$mc_ctrler.move(4, 0);` — 设速度 |
| F530 | L451–454 / L453 | `$mc_ctrler.damping(0.4, 0);` — 阻尼 |
| F538 | L456–461 / L458 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L459 | `$mc_ctrler.setZhao3();` — 允许招 3 |
|  |  / L460 | `$mc_ctrler.setJump();` — 允许跳 |
| F545 | L463–466 / L465 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F551 | L468–471 / L470 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F573–F586 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F573 | L473–476 / L475 | `$mc_ctrler.addQi(5);` — 加气 |
| F586 | L478–481 / L480 | `$effect_ctrler.shine(5422583);` — 闪光 |

#### F604 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F604 | L483–486 / L485 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F630–F701 — 动作 `招21`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F630 | L488–491 / L490 | `$mc_ctrler.addQi(10);` — 加气 |
| F643 | L493–496 / L495 | `$effect_ctrler.shine(6968203);` — 闪光 |
| F646 | L498–501 / L500 | `$mc_ctrler.justHitToPlay("zh2", "招21", false);` — 命中则切标签 |
| F657 | L503–506 / L505 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F659 | L508–511 / L510 | `$mc_ctrler.moveTarget({ "followmc":"move_mc" });` — 跟随位移盒 |
| F668 | L513–517 / L515 | `$effect_ctrler.shine(6968203);` — 闪光 |
|  |  / L516 | `$effect_ctrler.shake(0, 4);` — 震动 |
| F680 | L519–523 / L521 | `$effect_ctrler.shine(6968203);` — 闪光 |
|  |  / L522 | `$effect_ctrler.shake(0, 4);` — 震动 |
| F691 | L525–529 / L527 | `$effect_ctrler.shine(6968203);` — 闪光 |
|  |  / L528 | `$effect_ctrler.shake(0, 4);` — 震动 |
| F700 | L531–534 / L533 | `$mc_ctrler.moveTarget(null);` — 跟随位移盒 |
| F701 | L536–542 / L538 | `if($fighter_ctrler.target){ $fighter_ctrler.target.visible = true; }` — 显隐目标 |

#### F717 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F717 | L544–547 / L546 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F746–F751 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F746 | L549–552 / L551 | `$mc_ctrler.addQi(5);` — 加气 |
| F751 | L554–557 / L556 | `$effect_ctrler.shine(5422583);` — 闪光 |

#### F767 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F767 | L559–562 / L561 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |

#### F784 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F784 | L564–567 / L566 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F795–F808 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F795 | L569–572 / L571 | `$mc_ctrler.addQi(10);` — 加气 |
| F808 | L574–577 / L576 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F818 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F818 | L579–582 / L581 | `$mc_ctrler.addQi(20);` — 加气 |

#### F838 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F838 | L584–587 / L586 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F851 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F851 | L589–592 / L591 | `$effect_ctrler.bisha(false, "须佐助1");` — 必杀演出（脸/黑屏） |

#### F876–F879 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F876 | L594–597 / L596 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F879 | L599–609 / L601 | `$effect_ctrler.shine(0);` — 闪光 |
|  |  / L602 | `$mc_ctrler.addAttacker("tianzhao", { "x":{ "moveToTarget":true, "offset":0 }, "applyG":false });` — 放出攻击体 |

#### F942 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F942 | L611–614 / L613 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F958 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F958 | L616–619 / L618 | `$effect_ctrler.bisha(false, "须佐助2");` — 必杀演出（脸/黑屏） |

#### F995–F1002 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F995 | L621–624 / L623 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F1002 | L626–629 / L628 | `$effect_ctrler.shine(0);` — 闪光 |

#### F1046 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1046 | L631–634 / L633 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1065–F1071 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1065 | L636–639 / L638 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F1071 | L641–644 / L643 | `$effect_ctrler.bisha(false, "佐助1");` — 必杀演出（脸/黑屏） |

#### F1096–F1100 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1096 | L646–649 / L648 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F1099 | L651–655 / L653 | `$mc_ctrler.move(-5, -12);` — 设速度 |
|  |  / L654 | `$mc_ctrler.damping(0.3, 0.3);` — 阻尼 |
| F1100 | L657–660 / L659 | `$effect_ctrler.shine(15663104);` — 闪光 |

#### F1131 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1131 | L662–665 / L664 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1159–F1162 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1159 | L667–670 / L669 | `$effect_ctrler.shine(648163);` — 闪光 |
| F1162 | L672–675 / L674 | `$effect_ctrler.bisha(true, "须佐助2");` — 必杀演出（脸/黑屏） |

#### F1206–F1213 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1206 | L677–680 / L679 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F1213 | L682–685 / L684 | `$effect_ctrler.shine(5422583);` — 闪光 |

#### F1289 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1289 | L687–690 / L689 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1366–F1370 — 脚本段

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1366 | L692–695 / L694 | `$mc_ctrler.move(5, 0);` — 设速度 |
| F1368 | L697–700 / L699 | `$mc_ctrler.stopMove();` — 清速度 |
| F1370 | L702–705 / L704 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1393 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1393 | L707–710 / L709 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1487 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1487 | L712–715 / L714 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1547 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1547 | L717–720 / L719 | `$mc_ctrler.stop();` — 停时间轴 |

#### F1575 — 停

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1575 | L722–725 / L724 | `$mc_ctrler.stop();` — 停时间轴 |
