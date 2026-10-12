# salect.xml vs select.xml — Keep/Delete 决策（G12 / Phase E1）

| 项 | 值 |
|----|----|
| 日期 | 2026-10-11 17:55 CST（UTC+8） |
| 样本 | ZIP222 `assets/config/{select,salect}.xml`（`extracted/full/zips/bin_222/`） |
| 决策 | **KEEP** `salect.xml`（非死文件） |
| 默认运行时 | `GameData.loadConfig` → **`select.xml`** |
| 热键路径 | Ctrl+F8 → `salect.xml`；Ctrl+F9 → 回到 `select.xml` |
| main.swf | **未改** |

## 结论（一句话）

`salect.xml` **不是**死文件：冷启动走 `select.xml`，但 `GameLogic.setGameMode(1)`（localhost `GameInterfaceManager` Ctrl+F8）会**运行时再加载**它，并切换胜利 UI / 出战顺序布局。完美包 **Keep**；勿在清包时删除。

## 证据链

### 1. ZIP 内双文件均存在

| 文件 | 字节 | layout | 格子 item | 有字 id |
|------|-----:|--------|----------:|--------:|
| `assets/config/select.xml` | 4811 | `top="100"` `bottom="10"` | 130 | 88（unique≈73） |
| `assets/config/salect.xml` | 5083 | `top="50"` `bottom="50"` | 130 | 85（unique≈71） |

内容差异（抽样）：`select` 中排有 `ichigo_wanjie` / `rukia_shijie` / `soifon` / `kakashi_sw` 等 3.3 位；`salect` 多空格、旧紧排，`select` 多出 unique id：`random`、`rangiku`（salect 无 `random` 总项）。

### 2. 冷启动只读 select.xml

`GameData.loadConfig`（`decompiled/.../data/GameData.as`）：

```
fighter.xml → assist.xml → select.xml → map.xml → mission.xml
```

`AssetManager.I.loadXML("assets/config/select.xml", …)` — **无** `salect` 字符串。

### 3. 运行时双路径（关键证据）

`GameLogic.setGameMode`（`ctrl/GameLogic.as` L391–405）：

| param | XML | `ResUtils.WINNER` | `SelectIndexUI.SHOW_MODE` |
|------:|-----|-------------------|--------------------------:|
| 1 | `assets/config/salect.xml` | `winner_stg_mc2` | 1 |
| 其它 | `assets/config/select.xml` | `winner_stg_mc` | 0 |

调用方：`GameInterfaceManager.keyHandler`（`web/GameInterfaceManager.as` L130–139）：

- `keyCode==119` + Ctrl → `setGameMode(1)` → **F8**
- `keyCode==120` + Ctrl → `setGameMode(0)` → **F9**

`messageHandler` 在 `"games_inited"` 后才挂 `keyUp`（典型 localhost / 包装消息）。

`GameData.loadSelect(url)` 成功则 `setSelectData` 覆盖当前 `select_config`；失败仅 `trace("loadSelect error!")`。

### 4. 旁证文档（先前已写清，缺口表仍标 UNRESOLVED）

- `BVN-ANALYSIS.md` §4.3：Ctrl+F8/F9 切换 salect/select  
- `reverse/.../GameLogic.md`：`setGameMode` 表  
- `reverse/.../winner_stg_mc2.md`：旧表配套胜利 MC  
- `LOAD-PATH.md` §7 曾写「静态不可判」——**本决策闭合**该洞  

反例：`BVN-FULL-REVERSE.md` 写「salect 改了无效 / 未加载」——**过时**；仅对「从不按 Ctrl+F8」路径成立。

## Keep / Delete 矩阵

| 选项 | 含义 | 完美包建议 |
|------|------|------------|
| **Keep** | ZIP 保留 `salect.xml` 原样 | **采用** — 保真热键路径 + `winner_stg_mc2` 配套 |
| Delete | 从 ZIP 去掉 | **不采用** — Ctrl+F8 后 `loadSelect` 失败，旧布局/胜利屏半残 |
| Merge | 只留一份 XML | **不采用** — 两套 layout/格子故意不同 |

精简实验包若删：须同时改/跳过 `setGameMode(1)` 或让其回退 `select.xml`，并冒烟 Ctrl+F8；默认完美路径不做。

## 重制注意

1. 改选人格子默认改 **`select.xml`**（3.3 发布表）。  
2. 若要保留隐藏「旧表」彩蛋，同步维护 **`salect.xml`** + `winner_stg_mc2`。  
3. 回打 ZIP 后两文件 CRC 都要合法（见 `REPACK.md`）。  
4. 勿造第三份拼写变体。

## 交叉引用

| 文档 | 用途 |
|------|------|
| 本文件 | G12 Keep 决策 |
| `work/full-analysis/engine/LOAD-PATH.md` §2.4 / §7 | 加载链 |
| `work/remake/effects/LEGACY-12.md` | 同 Phase 边角 Keep |
| `PERFECT-REMAKE-PLAN` Phase E1 | 计划勾选 |

未改 `/workspace/bvn-3.3/main.swf`。
