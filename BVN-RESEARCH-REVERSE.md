# 死神 vs 火影 3.3 — 分析 + 调研 + 逆向对照（2026-09-03）

样本：本地 `main.swf` SHA-256 `5ddf9410…`，FWS14，69 431 196 B。  
权威反编译：`/workspace/bvn-3.3/decompiled/`（894 `.as`）。  
分册索引：[`BVN-FULL-REVERSE.md`](BVN-FULL-REVERSE.md)、[`reverse/`](reverse/)。

---

## 1. 调研结论（公开资料）

### 1.1 官方与作者

| 项 | 内容 |
|---|---|
| 工作室 | **5DPLAY Game Studio** |
| 作者 | **剑jian**（个人库 `LIB_KyoLib` ↔ 我们的 `net.play5d.kyo`） |
| 开源仓 | https://github.com/5DPLAY-Game-Studio/BleachVsNaruto （~76★，AS3） |
| 素材仓 | `BleachVsNaruto_TagAssets`（预编译 SWF，不全开源） |
| SDK 仓 | `BleachVsNaruto_FlexSDK`（flex4.16.1 + AIR 51） |
| 官网/社媒 | bvn-sports.com，B 站 / 抖音 / 微信公众号 |
| 现行主版本（开源工程） | **3.7 Alpha**（Windows / Android；目标 AIR） |
| 本样本 | **网页 Flash V3.3**（4399 / GreenHD 壳 + 嵌入 ZIP） |

开源 README 写明：工程用 AS3；Flash 资源用 Animate 出 SWF；逻辑用 FlexSDK 命令行/`build.bat` 编译。TagAssets 只给未开放源码的二进制，FLA 需本机 Animate 发布。

### 1.2 官方工程结构 ↔ 本样本反编译

| 官方模块 | 职责 | 本样本对应 |
|---|---|---|
| `CORE_KernelLogic` | 核心逻辑 `net.play5d.game.bvn.*` | `decompiled/main/scripts/net/play5d/game/bvn/` |
| `CORE_Components` | 交互组件 | 部分 UI / 状态相关类 |
| `CORE_Shared` | 对外公共接口 | `interfaces/`、`GameInterface*` |
| `CORE_Utils` | 工具 | 部分 utils |
| `LIB_KyoLib` | 剑jian 个人库 | `net/play5d/kyo/` |
| `LIB_Other` | TweenLite / FZip 等 | `com/greensock`、`deng/fzip` |
| `SHELL_Pc` / `SHELL_Mob` / `SHELL_Dev` | PC/移动/开发壳 | **本样本不是这套壳**，而是 **GreenHD + 4399**（`com/green`、`ɕ`、`ƃ`、`ƒ`） |
| `BleachVsNaruto_FlashSrc` | FLA/XFL | 嵌套角色/UI/地图 SWF（反编译在 `fighters/` `ui/` `maps/`） |
| `shared` + TagAssets | 共享资源 | 嵌入 BinaryData ZIP `id=222`（~65.7 MB，407 members） |

**包名漂移（重要）：** 开源 3.7 树里控制器包是 `ctrler/`，本 3.3 反编译是 `ctrl/`；`GameQuailty` 在开源里已改为 `GameQuality`。不能把 3.7 源码直接当 3.3 SWF 的 drop-in。

### 1.3 发行与模拟器生态

- 浏览器镜像站（如 bvnplay.online）用 Ruffle 跑 1.7～3.5B；3.3 约 69.4 MB。
- Ruffle issue [#20014](https://github.com/ruffle-rs/ruffle/issues/20014) 栈与我们一致：`ZipCtrler.getLoader` → `Loader.loadBytes` → `ZipAssetLoader` / `GameLoader` / `LoadingState`。说明 ZIP→`loadBytes` 仍是兼容敏感点。
- 改版圈主流工具：Adobe Animate / Flash CS6 改人物；JPEXS 改 SWF（与我们路径一致）。

---

## 2. 本样本逆向结论（静态）

### 2.1 分层

```
[HTML + main.js + Ruffle]
        ↓
[GreenHD / SH 壳]  体积门 FileLength / #04236f9c、禁 file://、4399/广告钩子
        ↓
[bleachvsnaruto → MainGame]  VERSION 原版 V3.3
        ↓
[ZipAssetLoader + ZipCtrler]  解析嵌入 assets_zip
        ↓
[GameLoadingState → XML 配置]  fighter/assist/select/map/mission/preload
        ↓
[Menu → Select → LoadingState → GameCtrl]  角色/地图 SWF loadBytes
        ↓
[FighterMain + MainTimeline.defineAction]  招式
```

### 2.2 规模（与分册一致）

| 桶 | 数量 |
|---:|---:|
| main（壳+引擎+嵌入符号） | 264 |
| fighters 时间轴 | 468（76 目录） |
| UI 嵌套 SWF | 73（8 个 CWS15） |
| effect | 89 |
| maps 脚本 | 0（14 资源 SWF，碰撞靠实例名） |
| **合计** | **894** |

配置 XML：fighter≈59 id / assist≈37 / map≈15（含 random）/ select 网格 / mission 设计。

### 2.3 角色招式模型

- 皮肤：`FighterMain.initlize` → `gotoAndStop(startFrame+1)`
- 招式：各角色 `MainTimeline` 里 `defineAction(...)`（已抽到 `reverse/05-fighter-actions.md`）
- 碰撞框命名惯例：`bdmn` / `atm*` 等（见 fighters 分册）

### 2.4 壳与完整性

- ASCII 常量 `#04236f9c` / `#4236f9c` ≡ `69431196`（与 `loaderInfo.bytes.length` / `bytesTotal` 对拍）
- 改 SWF 长度必须同步改 FileLength + 这两处 + `main.js` 的 `app.size['main.swf']`
- 广告：`data.vsgod.win/v1` → 嵌套 SWF；**可加载的 blank-ad 会 2180 或卡死**；**404 跳过**才是本地可玩配方

---

## 3. 动态验证（本机已跑通）

| 构建 | URL | 戳记 | 状态 |
|---|---|---|---|
| 原版 | `/games/bvn-3.3/` | V3.3 | 菜单→选人→对局 |
| 中文 p-code | `/games/bvn-zh/` | （同体积） | 曾实机中文菜单 |
| REV（3 类导入） | `/games/bvn-rev/` | V3.3-REV | 菜单→选人→对局 |
| FULL-CLEAN（~172 类） | `/games/bvn-full/` | V3.3-FULL | 菜单→选人→对局 |

FULL-CLEAN 要点：从**原版**单次 `-importScript`；**加载器类留原 ABC**（Zip*/Asset*/Loading*）；UI 库元件类型编译失败则 `-onerror ignore` 保留原字节码；广告 404。

---

## 4. 开源 3.7 vs 样本 3.3 — 调研差距

| 维度 | 样本 3.3（本仓库） | 开源 3.7 |
|---|---|---|
| 运行时 | Flash Player / Ruffle Web | Flex + AIR（Harman） |
| 壳 | GreenHD + 4399 + vsgod 广告 | `SHELL_Pc` / Mob / Dev |
| 控制器包名 | `ctrl` | `ctrler` |
| 资源 | 单 SWF 内嵌 ZIP | TagAssets + FlashSrc 发布流水线 |
| 构建 | JPEXS 回导 / p-code | Animate + `build.bat` + FlexSDK |
| 目标 | 保真跑通 3.3 网页包 | 继续演进到 3.7 |

**含义：** 若要“跟官方源码对齐开发”，应 clone 开源仓 + TagAssets，而不是期望 3.3 反编译一键等同 3.7。若要“保真改 3.3 网页包”，继续本仓库 `decompiled/` + JPEXS / p-code 路径。

---

## 5. 逆向缺口（仍值得做）

1. **GreenHD 全量命名恢复** — 混淆标识符未完全还原为人名。
2. **UI 库元件类型** — JPEXS 缺 `hpbar_mc` 等舞台类时编不过；可用 `:*` 再导入一轮。
3. **加载器类回导** — 一旦改 Zip/Asset/Loading，易复现卡 4/4 或空进度条；需对照开源 `ctrler` 与 Ruffle `loadBytes` 行为逐函数验。
4. **角色数值全表** — `05-fighter-actions` 已抽 defineAction，帧伤害/取消窗未做成可查询数据库。
5. **与 3.7 diff** — 官方 `ctrler`/`GameQuality`/AIR 全局（`IsAIR`/`IsHarmanRuntime`）可做版本演进图。

---

## 6. 证据索引

- 静态分册：`reverse/01-engine.md` … `05-fighter-actions.md`、`CLASS-INDEX.md`
- 早期分析：`BVN-ANALYSIS.md`、`BVN-REVERSE.md`、`BVN-REVERSE-CODE.md`、`GROK-SWF-REPORT.md`
- 构建：`play/games/bvn-full/BUILD.txt`、`play/games/bvn-rev/BUILD.txt`
- 公开：5DPLAY README / HOW2BUILD；Ruffle #20014

---

*本文件是 2026-09-03 的调研+对照增量，不替代分册细读。*
