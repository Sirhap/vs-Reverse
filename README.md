# Bleach vs Naruto (死神 vs 火影) Flash 3.3 — 逆向工程笔记

面向 **Flash 3.3 / Ruffle 可玩样本** 的完整逆向：架构、逐行注解、反编译 AS、本地启动经验。

> 本仓库 **不含** `main.swf` 等游戏二进制。请自备合法样本。详见 [DISCLAIMER.md](DISCLAIMER.md)。

## 仓库结构

```
decompiled/          # 反编译出的 AS3（894 个 .as）— 逆向后的代码
reverse/             # 研究报告 + 分卷
reverse/line-by-line/# 逐行注解（壳/引擎/角色/UI/特效，836+ 篇）
play/                # 本地 HTTP 启动脚本与守卫（无 SWF）
play/games/bvn-rev2/ # REV2b 入口（main.js 按 SIZE-GATE 重建，不含 SWF）
play/r8-hold-stub/   # R8 本地 Hold stub
tools/               # size-gate、repack、帧导出脚本
tools-notes/         # Grok Build 分批提示词与 runner 脚本
work/                # 复刻验收与全量可读性状态（与 decompiled、reverse 并列）
*.md                 # 顶层分析报告
```

2026-10-12 复刻包与既有逆向树并列，不覆盖 `decompiled/` 与 `reverse/`。R8 线上仍是 Documented-gap；听感仍是 Documented UNKNOWN。`play/games/bvn-rev2/main.js` 由 `play/games/bvn-3.3/main.js` 重建，`app.size["main.swf"]` 为 REV2b `69550436`，`app.flashframe` 仍为 `2`。

总入口（注解）：[`reverse/line-by-line/00-MASTER.md`](reverse/line-by-line/00-MASTER.md)

| 分区 | 篇数（约） | 入口 |
|------|------------|------|
| GreenHD 壳 | 25 | `reverse/line-by-line/shell/00-INDEX.md` |
| net.play5d 引擎 | 181 | `reverse/line-by-line/engine/00-INDEX.md` |
| 角色 fighters | 468 | `reverse/line-by-line/fighters/00-INDEX.md` |
| UI | 73 | `reverse/line-by-line/ui/00-INDEX.md` |
| 特效 effect | 89 | `reverse/line-by-line/effect/00-INDEX.md` |
| 壳符号表 | — | `reverse/line-by-line/_maps/SHELL-SYMBOL-MAP.md` |

---

## 逆向过程与思路（并行怎么干的）

### 1. 目标分层（避免一上来就「读完每一行」）

并行三条线，验收标准不同：

| 线 | 目标 | 验收 |
|----|------|------|
| **A. 跑起来** | Ruffle 本地能玩 | 菜单 → 选人 → 对局截图 |
| **B. 读懂结构** | 壳 → 引擎 → 数据流 | 报告 + 符号映射 |
| **C. 逐行注解** | 每个 `.as` 有中文说明 | 分批 INDEX 勾满 |

先 A 再 B，C 用自动化分批啃「长城」，人（监督）只盯卡住/收工。

### 2. 样本与工具链

1. 拿到 `main.swf`（FWS14，约 69MB）→ 哈希核对。
2. **JPEXS (FFDec)** 全量反编译：主 SWF + 嵌套角色/UI/特效 → `decompiled/`（约 894 `.as`）。
3. 外层是壳 + **Zip 资源**（`ZipAssetLoader`），不是单文件纯逻辑。
4. 对照开源 **5DPLAY / 剑jian 3.7 Alpha（AIR）**：包名接近但 `ctrler/` vs 样本 `ctrl/`，**不能当 drop-in 替换**。

### 3. 启动链（干货）

```
GreenHD 壳
  → 体积/完整性（FileLength + Background 元数据约 69431196）
  → FrameTask：FM(帧泵) → FA(加载UI) → FB(配置/平台/远程) → FC(起游戏)
  → MainGame → 菜单 / 选人 / Fight
```

广告是启动生死线：

| 做法 | 结果 |
|------|------|
| 可加载的 `blank-ad.swf` | Ruffle **Error #2180**（AVM1→AVM2）或卡死 |
| 空 `<games></games>` | 进度条卡 **0%** |
| 守卫返回 default URL，且该文件 **404** | 广告失败被跳过，**能进菜单** |

本地必须用 **HTTP**（`file:///` 会被壳拦）。`play/START.md` 有现成守卫规则。

### 4. 「可玩的逆向产物」怎么建

注解 ≠ 可玩。可玩线做法：

1. 原版 / 中文菜单 p-code 改字验证渲染。
2. **FULL-CLEAN**：用 JPEXS 把约 **172** 个 `net.play5d` 引擎类从反编译导入；**加载器相关 ABC 保持原版**（乱动加载器极易起不来）。
3. 戳记 `V3.3-FULL`；本地 `http://127.0.0.1:8765/games/bvn-full/`。
4. 验收：**实机菜单 → 选人 → 对局**（曾拍到 7 HITS），不是 mock。

### 5. 逐行注解「长城」怎么并行

人写清批次边界，**Grok Build** 按批写中文「逐行说明」：

```
壳(25) → 引擎A 主链(60) → B fighter+data(52) → C ui+views(46) → D kyo(23)
      → 角色 A–G（按角色文件夹拆 ~60–70/批）
      → UI(73) → effect(89)
```

监督策略（曾跑 20 分钟例程）：

- 看 **文件增长 / INDEX**，不看空 stdout（streaming-json 常缓冲）。
- 桌面 Terminal 有时「只开窗不敲命令」→ **优先 Shell 直接 `run-grok-*.sh`**。
- 一批 `GROK_EXIT=0` 且清单齐 → 立刻开下一批。

每文件注解模板：目的 · callers/callees · **逐行说明**（按函数/帧标签）。

### 6. 技能与操作清单

**技能 / 工具**

- Grok Build：分批读码与写注解  
- JPEXS：反编译与类导入重建  
- Ruffle + 多线程本地 HTTP：真机验收  
- 桌面实机点击：菜单/选人/开打截图  

**操作顺序（浓缩）**

解包 → 反编译 → 架构报告 → 广告/启动钉死 → 中文菜单试验 → FULL 重建 → 分批逐行注解 → 实机回归。

### 7. 你怎么用这份仓库

1. 自备 `main.swf` / 资源，放到本地 `play/games/...`（本仓库故意不带）。  
2. 读 `reverse/line-by-line/00-MASTER.md` 找类注解。  
3. 对照 `decompiled/**/*.as` 看源码。  
4. 按 `play/START.md` 起 HTTP + 广告 404 规则再测。

---

## 相关顶层文档

- [BVN-RESEARCH-REVERSE.md](BVN-RESEARCH-REVERSE.md) — 调研与开源对照  
- [BVN-FULL-REVERSE.md](BVN-FULL-REVERSE.md) — 全量逆向索引  
- [BVN-REVERSE-CODE.md](BVN-REVERSE-CODE.md) — 代码向说明  
- [DISCLAIMER.md](DISCLAIMER.md)

## License / 版权

反编译代码与游戏内容版权归原权利人。本仓库文档（注解、过程说明）以研究为目的发布；转载请保留免责声明。
