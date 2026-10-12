# UI BinaryData 外置演示路径（Phase D3）

| 项 | 值 |
|----|----|
| 工具 | `tools/replace_ui_bin.py` |
| 演示包 | `play/games/bvn-perfect-ui-demo/`（**副本**；不碰样本 `main.swf`） |
| 本轮目标 UI | **title** id=2215（亦可 `--id 229` loading） |
| 输入嵌套 SWF | `extracted/full/swf/bin_2215.swf`（与样本 payload 字节一致 → round-trip） |
| 时间 | 2026-10-11 17:48 CST |

## 工程步骤（完整外置时）

1. 从 `extracted/full/swf/bin_<id>.swf` 开 Animate/JPEXS 工程（或仅替换位图/声音）。
2. 编译得到新的 UI SWF（须保持 SymbolClass 导出名；交叉池符号见 `stubs/CROSS-POOL.md`）。
3. `replace_ui_bin.py --id <id> --ui-swf <new.swf> -o play/games/<build>/main.swf`（源用 rev2/perfect 副本）。
4. 若体积变：`patch_size_gate.py` + 同步 `main.js` `app.size`。
5. HTTP Ruffle 冒烟：菜单/选人/加载条。

## 本轮演示命令

```bash
mkdir -p play/games/bvn-perfect-ui-demo
cp -a play/games/bvn-rev2/{index.html,main.js,icon.png} play/games/bvn-perfect-ui-demo/
python3 tools/replace_ui_bin.py --id 2215 \
  --swf play/games/bvn-rev2/main.swf \
  --ui-swf extracted/full/swf/bin_2215.swf \
  -o play/games/bvn-perfect-ui-demo/main.swf \
  --json work/remake/ui/D3-ROUNDTRIP-RESULT.json
# 同体积 round-trip 时无需 size-gate；变长则 patch_size_gate.py
```

脚本 outline 已可跑；「完整艺术重制 → 回打」仍待 FLA 工程。loading 路径同理 `--id 229`。

未改 `/workspace/bvn-3.3/main.swf`。

## ROUNDTRIP 结果（本轮）

见 `D3-ROUNDTRIP-RESULT.json`：title id=2215 payload 499256 B SHA 不变；demo SWF = rev2 字节级相同；样本 `main.swf` sha `5ddf9410…ba3e` 未变。
