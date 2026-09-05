# `byakuya_fla.sprite631_14` — 动作 MC `sprite631_14`

一句话目的：角色动作时间轴 `sprite631_14`：走/跳/普攻/招/必杀/抓/胜负的脚本帧。通过 `parent.$mc_ctrler` 改允许表、位移、出子弹/攻击体；`$effect_ctrler` 播必杀脸与闪光；偶发 `$fighter_ctrler.moveToTarget`/`setCross`。

源文件：`decompiled/fighters/byakuya/scripts/byakuya_fla/sprite631_14.as`（456 行）

## 如何挂上引擎

动作总 MC（`FighterCtrler.initMc(this.mc)` 的那份）。根时间轴是 `$fighter_ctrler` 持有者；本 clip 用 **`parent.$mc_ctrler` / `parent.$effect_ctrler` / `parent.$fighter_ctrler`** 回调。[`FighterMC`](../../../../engine/game/bvn/fighter/FighterMC.md) `renderChildren` **跳过** 名为 `AImain`、`bdmn`、名字含 `atm` 的子剪辑（当判定盒，不自动 nextFrame）。`AImain` 在 `initHitRange` 里 `gotoAndStop(2)` 扫 [`FighterHitRange`](../../../../engine/game/bvn/fighter/FighterHitRange.md) 的 `*mian` 再藏起来。

帧脚本几乎全是 [`FighterMcCtrler`](../../../../engine/game/bvn/fighter/ctrler/FighterMcCtrler.md)：`idle` / `endAct` / `setAttack` / `fire` / `addAttacker`。Flash 帧标签本身 **不在** 反编译 AS 里，只留下 `addFrameScript` 数字；下面按帧号分组，标签名从 `setAttack`/`gotoAndPlay`/`loop` 字符串回推。 公开子件：`AImain`, `bdmn`, `bs1atm`, `bsatm`, `cbs1atm`, `cbsatm`, `k1atm`, `k2atm`, `k3atm`, `kj1atm`, `kj2atm`, `sbsatm`, `sh12atm`, `sh1atm`, `sh22atm`, `sh2atm`, `tkatm`, `tzatm`, `zh1atm`, `zh21atm`, `zh2atm`, `zh3atm`。

白哉 **卍解** 动作 MC（根时间轴 F3 的 `this.mc`）。

## 逐行说明

### 字段

| L | 名字 | 类型 |
|---|---|---|
| L22 | `AImain` | `MovieClip` | AI 判定面容器
| L24 | `bdmn` | `MovieClip` | 身体盒
| L26 | `bs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L28 | `bsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L30 | `cbs1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L32 | `cbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L34 | `k1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L36 | `k2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L38 | `k3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L40 | `kj1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L42 | `kj2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L44 | `mc` | `MovieClip` | 动作总 MC，`initMc` 用
| L46 | `sbsatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L48 | `sh12atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L50 | `sh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L52 | `sh22atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L54 | `sh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L56 | `tkatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L58 | `tzatm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L60 | `zh1atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L62 | `zh21atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L64 | `zh2atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）
| L66 | `zh3atm` | `MovieClip` | 攻击判定盒（displayName → HitVO）

### 函数

#### `sprite631_14()`（L68–73）

- L70: `super();`
- L71: `addFrameScript(16,frame17,23,frame24,30,frame31,35,frame36,65,frame66,76,frame77,86,frame87,91,frame92,94,frame95,96,frame97,105,frame106,113,frame114,125,frame126,131,frame132,150,frame151,166,frame167,172,frame173,178,frame179,208,frame209,215,frame216,223,frame224,245,frame246,252,frame253,260,frame261,281,frame282,288,frame289,302,frame303,319,frame320,321,frame322,342,frame343,351,frame352,354,frame355,365,frame366,379,frame380,383,frame384,385,frame386,390,frame391,411,frame412,419,frame420,428,frame429,438,frame439,439,frame440,440,frame441,453,frame454,458,frame459,476,frame477,504,frame505,542,frame543,555,frame556,563,frame564,578,frame579,594,frame595,622,frame623,633,frame634,670,frame671,675,frame676 ,706,frame707,721,frame722,724,frame725,778,frame779,779,frame780,780,frame781,873,frame874,882,frame883,1004,frame1005,1025,frame1026,1092,frame1093,1114,frame1115,1137,frame1138,1181,frame1182);`

### 逐帧脚本

共 70 个 `addFrameScript` 点。帧标签不在 AS 中，按帧号分段。每个脚本帧都列出，不跳过。

#### F17–F36 — 动作 `走`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F17 | L75–78 / L77 | `$mc_ctrler.loop("走");` — 走路循环标签 |
| F24 | L80–87 / L82 | `$mc_ctrler.dash(3);` — 冲刺速度倍率 |
|  |  / L83 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L84 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L85 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L86 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
| F31 | L89–92 / L91 | `$mc_ctrler.dashStop();` — 停冲 |
| F36 | L94–97 / L96 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F66 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F66 | L99–102 / L101 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F77–F114 — 动作 `跳招1`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F77 | L104–109 / L106 | `$effect_ctrler.shine(8245740);` — 闪光（0x7DD1EC） |
|  |  / L107 | `$mc_ctrler.move(-3,-3);` — 设速度 |
|  |  / L108 | `$mc_ctrler.damping(0.1,0.1);` — 阻尼 |
| F87 | L111–114 / L113 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F92 | L116–119 / L118 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F95 | L121–126 / L123 | `$mc_ctrler.move(0,10);` — 设速度 |
|  |  / L124 | `$mc_ctrler.setTouchFloor("跳招2",true);` |
|  |  / L125 | `$effect_ctrler.shadow(200,0,200);` — 残影 |
| F97 | L128–132 / L130 | `$effect_ctrler.shine();` — 闪光 |
|  |  / L131 | `$effect_ctrler.shine(12605448);` — 闪光（0xC05808） |
| F106 | L134–137 / L136 | `$mc_ctrler.loop("跳招1");` — 走路循环标签 |
| F114 | L139–142 / L141 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F126–F151 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F126 | L144–147 / L146 | `$effect_ctrler.shine(15174887);` — 闪光（0xE78CE7） |
| F132 | L149–152 / L151 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F151 | L154–157 / L156 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F167–F179 — 动作 `砍2`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F167 | L159–164 / L161 | `$mc_ctrler.setAttack("砍2");` — 允许普攻接到指定帧标签 |
|  |  / L162 | `$mc_ctrler.setSkill1();` |
|  |  / L163 | `$mc_ctrler.setZhao1();` — 允许招 1 |
| F173 | L166–169 / L168 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F179 | L171–174 / L173 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F209–F224 — 动作 `砍3`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F209 | L176–181 / L178 | `$mc_ctrler.setSkill2();` — 允许上攻/技能 2 |
|  |  / L179 | `$mc_ctrler.setAttack("砍3");` — 允许普攻接到指定帧标签 |
|  |  / L180 | `$mc_ctrler.setSkill1();` |
| F216 | L183–186 / L185 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F224 | L188–191 / L190 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F246–F261 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F246 | L193–199 / L195 | `$mc_ctrler.setBishaSUPER();` — 允许超必杀 |
|  |  / L196 | `$mc_ctrler.setBisha();` — 允许必杀 |
|  |  / L197 | `$mc_ctrler.setZhao1();` — 允许招 1 |
|  |  / L198 | `$mc_ctrler.setDash();` — 允许冲 |
| F253 | L201–204 / L203 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F261 | L206–209 / L208 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F282–F303 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F282 | L211–214 / L213 | `$effect_ctrler.shine();` — 闪光 |
| F289 | L216–219 / L218 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F303 | L221–224 / L223 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F320–F366 — 动作 `招31`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F320 | L226–229 / L228 | `$mc_ctrler.addQi(10);` — 加气 |
| F322 | L231–234 / L233 | `$mc_ctrler.setHurtAction("招31");` — 受击时强制切招（state 16） |
| F343 | L236–239 / L238 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F352 | L241–244 / L243 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F355 | L246–249 / L248 | `$effect_ctrler.shine(15174887);` — 闪光（0xE78CE7） |
| F366 | L251–254 / L253 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F380–F429 — 动作 `招31`

| 帧 | 函数 L | 调用 |
|---|---|---|
| F380 | L256–259 / L258 | `$mc_ctrler.addQi(10);` — 加气 |
| F384 | L261–264 / L263 | `$fighter_ctrler.moveToTarget(100,null,false);` — 瞬移到目标相对坐标 |
| F386 | L266–269 / L268 | `$effect_ctrler.slowDown(1);` — 全局慢动作 |
| F391 | L271–274 / L273 | `$effect_ctrler.shine(8245740);` — 闪光（0x7DD1EC） |
| F412 | L276–282 / L278 | `$mc_ctrler.setBishaUP();` — 允许上必杀 |
|  |  / L279 | `$mc_ctrler.setZhao3("招31");` — 允许招 3 |
|  |  / L280 | `$mc_ctrler.setSkill1();` |
|  |  / L281 | `$mc_ctrler.setZhao1();` — 允许招 1 |
| F420 | L284–287 / L286 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F429 | L289–292 / L291 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F439–F459 — 发射子弹

| 帧 | 函数 L | 调用 |
|---|---|---|
| F439 | L294–297 / L296 | `$mc_ctrler.addQi(5);` — 加气 |
| F440 | L299–311 / L301 | `$mc_ctrler.fire("zh1atm",{ "x":{ "start":5, "add":1, "max":20 }, "y":0, "hold":2, "hits":1 });` — 发射子弹 FIRE_BULLET |
| F441 | L313–316 / L315 | `$effect_ctrler.shine(15174887);` — 闪光（0xE78CE7） |
| F454 | L318–321 / L320 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F459 | L323–326 / L325 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F477 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F477 | L328–331 / L330 | `$effect_ctrler.bisha(false,"白哉2");` — 必杀演出（脸/黑屏） |

#### F505 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F505 | L333–336 / L335 | `$effect_ctrler.endBisha();` — 关必杀演出 |

#### F543–F579 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F543 | L338–341 / L340 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F556 | L343–346 / L345 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F564 | L348–351 / L350 | `$mc_ctrler.addQi(10);` — 加气 |
| F579 | L353–356 / L355 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F595 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F595 | L358–361 / L360 | `$mc_ctrler.addQi(20);` — 加气 |

#### F623 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F623 | L363–366 / L365 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F634 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F634 | L368–371 / L370 | `$effect_ctrler.bisha(false,"白哉2");` — 必杀演出（脸/黑屏） |

#### F671–F676 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F671 | L373–376 / L375 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F676 | L378–381 / L380 | `$effect_ctrler.shine();` — 闪光 |

#### F707–F725 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F707 | L383–386 / L385 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F722 | L388–391 / L390 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F725 | L393–396 / L395 | `$effect_ctrler.bisha(true,"白哉3");` — 必杀演出（脸/黑屏） |

#### F779–F781 — 冲刺

| 帧 | 函数 L | 调用 |
|---|---|---|
| F779 | L398–401 / L400 | `$effect_ctrler.endBisha();` — 关必杀演出 |
| F780 | L403–407 / L405 | `$effect_ctrler.dash();` — 冲刺特效 dash/dash_air |
|  |  / L406 | `$effect_ctrler.slowDown(1);` — 全局慢动作 |
| F781 | L409–413 / L411 | `$fighter_ctrler.moveToTarget(150,null,false);` — 瞬移到目标相对坐标 |
|  |  / L412 | `$effect_ctrler.shine();` — 闪光 |

#### F874–F883 — 收招

| 帧 | 函数 L | 调用 |
|---|---|---|
| F874 | L415–418 / L417 | `$mc_ctrler.endAct();` — 结束当前招，清攻击允许 |
| F883 | L420–423 / L422 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1005–F1026 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1005 | L425–428 / L427 | `$mc_ctrler.idle();` — 回站立，重填允许表 |
| F1026 | L430–433 / L432 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1093–F1115 — 回站立

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1093 | L435–438 / L437 | `$effect_ctrler.endWanKai();` |
| F1115 | L440–443 / L442 | `$mc_ctrler.idle();` — 回站立，重填允许表 |

#### F1138 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1138 | L445–448 / L447 | `stop();` — 停时间轴 |

#### F1182 — 时间轴动作

| 帧 | 函数 L | 调用 |
|---|---|---|
| F1182 | L450–453 / L452 | `stop();` — 停时间轴 |
