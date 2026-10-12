# 剩余不可读性清单（2026-10-11，Phase 8 终验）

只读盘点。权威二进制：`main.swf`（SHA-256 `5ddf9410…ba3e`）。提取物：`extracted/full/`、`decompiled/`。  
**Phase 8**：每项标 **Closed** 或 **Documented-Unreadable**，并给证据路径与原因。未改 `main.swf`。

## 摘要（终态）

| ID | 类别 | 终态 | 证据路径 | 原因 / 备注 |
|----|------|------|----------|-------------|
| U1 | GreenHD 混淆包 | **Closed** | `shell/SHELL-SYMBOL-MAP.md`；`reverse/line-by-line/shell/`（32 篇）；`shell/PHASE1-PROGRESS.md` | 壳 `.as` 均有 line-by-line + MAP 建议名；引导链 FM→FA→FB→FC 可复述。R11 包名 Unicode 为 ABC 真名（Documented，不改 ABC）。 |
| U2 | `com.sh` 4399 Hold | **Documented-Unreadable** | `shell/SHELL-SYMBOL-MAP.md` §R8 / `com.sh`；`shell/PHASE1-PROGRESS.md`；`reverse/line-by-line/shell/com/` | 静态 API 契约已齐（bind/setHold/show* / 域名 glob）。**R8**：线上 Hold 实例指纹需 4399 页注入；本地 `hold=null`，runtime-only。 |
| U3 | `Ȇ` HTML 文本 | **Closed** | `reverse/line-by-line/shell/Ȇ/`；MAP `Ȇ` 节 | Phase1 已补 line-by-line + MAP。 |
| U4 | `LOADING_bvn` / `LOADING_Icon` | **Closed** | `reverse/line-by-line/shell/LOADING_*.md`；MAP；`ASSET-CATALOG-MAIN.md` JPEG id=1 | Phase1 已补；与加载条图交叉。 |
| U5 | JsEmbed `Ǻ` 冷路径 | **Closed** | MAP `Ǻ` 冷路径表；R5 **RESOLVED**（`shell/PHASE1-PROGRESS.md`） | 主路径已名；冷路径已表化；`§--UNKNOWN--§`=异常逃逸类型洞。 |
| U6 | ZIP id=222 | **Closed** | `ASSET-CATALOG-ZIP222.md`（398 文件+9 目录=407）；XML 悬空路径 **0** | 每路径有类型/用途行；fighter/map 内标签见 U10/U11。 |
| U7 | UI 嵌套 SWF×8 | **Closed** | `ui/INDEX.md` + 8 per-UI md；`PHASE6-STATUS.md` | SymbolClass Σ=73；反编译 0 失败；引擎交叉 30。无 SymbolClass 的库 MC 为 display-only（已文档）。 |
| U8 | 主 SWF DefineSound×8 | **Closed** | `ASSET-CATALOG-MAIN.md`；`engine/SOUND-CATALOG.md` | id→符号→抽出路径→全 `playSwcSound` 调用点。 |
| U9 | JPEG2×3 | **Closed** | `ASSET-CATALOG-MAIN.md` §JPEG | id=1 加载条 / 221 提交分 / 2219 movelist。 |
| U10 | 地图 SWF×14 | **Closed**（洞 **Documented-Unreadable**） | `assets/maps/INDEX.md` + 14 md + dumpSWF；`PHASE4-STATUS.md` | 实例名+MATRIX/RECT+map.xml 对齐完成。**HARD**：`shihunjietongdao` 缺 `floor`；`jianchang`/`zoulang` floor 0 子。**SOFT**：6 图缺 `front`。属资产洞，非分析盲区。 |
| U11 | 角色 fighter/fz | **Closed**（软洞 **Documented-Unreadable**） | `timelines/INDEX.md` + `fighters/*.md`（76）；`PHASE5-STATUS.md` | 可玩 40+辅助 34+额外 2；标签 1725 / defineAction 1534。软洞：`random*` 无独立 SWF×6；~25 辅助无 FrameLabel（Assister 常态）；StartSound 未展开帧→声名细表。 |
| U12 | effect.swf | **Closed**（遗留 **Documented-Unreadable**） | `timelines/effects/INDEX.md`；`PHASE5-STATUS.md` | EffectModel 52 行 ↔ 符号 89；缺符号 0。遗留未登记导出 12（`XG_kan`/`XG_xdash`/`snd_hit1` 等）已文档。 |
| U13 | 嵌入 stub 类 | **Closed** | `ui/*.md` stubs；`ASSET-CATALOG-MAIN.md`；MAP R10 | ByteArray/InsSwf/JPEG/Sound stub 均有目录；无游戏逻辑。 |
| U14 | 第三方库 | **Documented-Unreadable** | `decompiled/main/scripts/{com/greensock,deng/fzip,fl/motion,com/adobe}`（~14 `.as`） | 明文第三方（TweenLite/FZip/fl.motion/adobe.utils）；标第三方，不强制游戏命名。 |
| U15 | `main.js` Ruffle 包装 | **Closed**（完整混淆图 **Documented-Unreadable**） | `REA-REANALYSIS-2026-10-11.md` §metas；`REV-GAP-AUDIT`；`engine/LOAD-PATH.md` | 运行所需 API 已表：`app.size`/`flashframe=2`/HTTP/广告位。完整 minify 语义图非游戏逻辑，不强制。 |

## U1 壳包文件矩阵（Closed）

| 路径 | line-by-line | MAP 覆盖 |
|------|--------------|----------|
| `ƒ/ǵ_2.as` `Ǵ.as` `ŋ.as` | YES | YES |
| `ƃ/FB.as` | YES | YES |
| `ɕ/ȑ.as` | YES | YES |
| `ǹ/*` (5) | YES | YES |
| `ȁ/*` (3) | YES | YES |
| `Ȋ/*` (4) | YES | YES |
| `Ȑ/ȏ.as` | YES | YES |
| `Ƿ/Ƕ.as` | YES | YES |
| `com/green/net/*` `method/*` | YES | YES（含 `Ǻ` 冷路径） |
| `com/sh/*` | YES | YES（静态）；R8 实例 runtime |
| `Ȇ/*` | YES | YES |
| `LOADING_*.as` | YES | YES |
| `BleachVSNaruto.as` `bleachvsnaruto_2.as` | YES | YES |

## Phase1 UNRESOLVED 子项（R1–R11）终态

| ID | 终态 | 证据 |
|----|------|------|
| R1 | Closed（RESOLVED-reconstructed） | MAP R1；本包 Number 死路径 |
| R2 | Documented-Unreadable（Closed-as-dead） | 恒 false 完整性桩 |
| R3 | Documented-Unreadable（Closed-as-dead） | `__info__` 恒 null |
| R4 | Documented-Unreadable（Closed-unused） | `AppKind` 无引用 |
| R5 | Closed（RESOLVED） | 异常逃逸返回 |
| R6 | Documented-Unreadable（Closed-unused） | `displayName` 无调用 |
| R7 | Closed（Documented 重叠） | 两套域名探测已文档 |
| R8 | **Documented-Unreadable**（runtime-only） | 4399 Hold 实例指纹 |
| R9 | Closed（RESOLVED-static） | EI 一阶 call 名全表 |
| R10 | Closed（Documented-stub → Phase2/6） | script_* → SymbolClass |
| R11 | Documented-Unreadable（包名 Unicode） | ABC 真名；MAP 建议包名 |

## U6 ZIP 前缀（Closed，目录见 ASSET-CATALOG-ZIP222）

| 前缀 | 约数 | 类型 |
|------|------|------|
| `assets/face/` | 257–258 | png |
| `assets/fighter/` (+fz) | 78 swf | 角色/援助 |
| `assets/map/` | 14 swf + png | 地图 |
| `assets/bgm/` | 21–22 | mp3 |
| `assets/config/` | 8 | xml |
| `assets/sounds/` | 3 mp3 + sound.xml | 脚步等 |
| `assets/font/` | font1.png + xml | 位图字体 |
| `assets/effect.swf` | 1 | 特效包 |
| `assets/movelist.jpg` | 1 | 招式表图 |

## 关闭条件对照（Phase 8）

| 原关闭条件 | 结果 |
|------------|------|
| U1–U5 → Phase 1 | U1/U3/U4/U5 **Closed**；U2=R8 **Documented-Unreadable** |
| U6–U9 → Phase 2–3 + 7 声表 | **Closed** |
| U10 → Phase 4 | **Closed**（HARD/SOFT 洞已文档） |
| U11–U12 → Phase 5 | **Closed**（软洞/遗留 12 已文档） |
| U13,U7 → Phase 6 | **Closed** |
| U15 → Phase 7 边角 | 包装 API **Closed**；完整 JS 图 Documented |
| U14 → 标第三方 | **Documented-Unreadable** |

盘点 / 终验时间：2026-10-11 14:41 CST（UTC+8）。
