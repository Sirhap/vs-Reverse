# HARD 地图进场冒烟 — 保真 SAME-HOLE（G5 / A2）

| 项 | 值 |
|----|----|
| 日期 | **2026-10-11 22:09 CST**（静态 SAME-HOLE 已结案；本文件=可选视觉步骤） |
| 静态门 | **CLOSED**（不挡 G5 Documented-gap） |
| 策略 | **保真 SAME-HOLE**（不增强 floor） |
| 前置静态 | `HARD-EMPTY-FLOOR-EVIDENCE.json` + `HARD-EVIDENCE-2026-10-11.md` **PASS** |
| URL | `http://127.0.0.1:8765/games/bvn-rev2/index.html` |

## 桌面步骤（父代理 computerUse）

对下列三图各进场一次（单人/小队均可；记录是否与原版同洞：无额外平台碰撞崩溃即可）：

| # | map_id | 洞 | 截图 |
|---|--------|-----|------|
| 1 | `shihunjietongdao` | 缺 floor | `parity/maps/hard-shihunjietongdao.png` |
| 2 | `jianchang` | floor 空 sprite | `parity/maps/hard-jianchang.png` |
| 3 | `zoulang` | floor 空 sprite | `parity/maps/hard-zoulang.png` |

判定：**SAME-HOLE PASS** = 可进场可动、无 APP ERROR；角色站 `line_player_bottom`；与静态洞一致。  
落盘后更新 `PARITY-CHECKLIST.md` §4 与 STATUS。

勿改 `main.swf`；勿碰 hatch。
