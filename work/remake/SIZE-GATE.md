# 体积门工具说明（Phase A1 / G2）

| 项 | 值 |
|----|----|
| 日期 | 2026-10-11 |
| 工具 | `tools/patch_size_gate.py` · `tools/serve_check.sh` |
| 原包 | `/workspace/bvn-3.3/main.swf`（**禁止改**；只作 import 输入） |
| 权威偏移（keep-shell） | FileLength @4；`#XXXXXXX` @2596；`#XXXXXXXX` @118927 |

## 为何必须三处一致

壳两道体积门 + 包装层进度都读同一整数：

1. **FileLength**（SWF 头 offset 4，UI32 LE）= 磁盘字节  
2. **`#4236f9c` 风格（7 hex）** → `[Background]` → `bytesTotal`  
3. **`#04236f9c` 风格（8 hex）** → `parseInt("0x"+…)` 与 `loaderInfo.bytes.length`  
4. **`main.js` `app.size["main.swf"]`**（metas base64）— 进度条 / 包装约定  

漏一侧 → APP ERROR 黄页或加载失败。等长 ASCII 替换（7/8 hex）以保住 ABC 字符串长度前缀。

## patch_size_gate.py

```bash
# 只报告（推荐先 dry-run）
python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf --dry-run

# 就地改 SWF + 同步该包 main.js
python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf \
  --main-js play/games/bvn-rev2/main.js

# 写出到新路径
python3 tools/patch_size_gate.py build/_clean.swf \
  -o play/games/bvn-x/main.swf \
  --main-js play/games/bvn-x/main.js

# 校验三处（+可选 app.size）一致
python3 tools/patch_size_gate.py play/games/bvn-rev2/main.swf \
  --main-js play/games/bvn-rev2/main.js --verify
```

发现逻辑：扫描 `#`+7/8 位 hex，且 `parseInt` ∈ 当前 FileLength / 磁盘长 / 已有门限值（50–150 MiB）。REV2b 实测：`#4254164`@2596、`#04254164`@118927、FileLength=69550436。

## serve_check.sh

```bash
# 断言 :8765、游戏 200、blank-ad 404、flashframe=2
tools/serve_check.sh --game bvn-rev2

# 若端口未起则后台拉起 play/start-server.sh
tools/serve_check.sh --game bvn-rev2 --start
```

硬规则（见 `play/START.md`）：**不要**放置可加载的 `play/blank-ad.swf`（必须 404）。

## 改包检查表（每次发包）

- [ ] 未改原包 `main.swf`（sha 仍 `5ddf9410…ba3e`）  
- [ ] import 根无壳路径；9× `.as.skip` 仍在  
- [ ] `patch_size_gate.py` 后：FileLength == 磁盘 == 两处 ASCII == `app.size`  
- [ ] `serve_check.sh` PASS（HTTP / blank-ad 404 / `flashframe=2`）  
- [ ] BUILD.txt 写清 bytes、sha256、stamp  

完整清单见 `PERFECT-REMAKE-PLAN-2026-10-11.md` 附录 A。
