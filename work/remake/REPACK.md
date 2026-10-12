# REPACK — ZIP222 回打与嵌入（Phase B2）

| 项 | 值 |
|----|----|
| Generated | 2026-10-11 17:42 CST |
| 工具 | `tools/repack_zip222.py`、`tools/embed_bin222.py`、`tools/patch_size_gate.py` |
| 原包 | `/workspace/bvn-3.3/main.swf` SHA-256 `5ddf9410…ba3e`（**禁止改动**） |
| 模板 ZIP | `work/remake/repack/original_bin222.zip`（自 main.swf offset `526923` 切出，65 699 574 B，407 members） |
| 资产树 | `extracted/full/zips/bin_222/` 或 `work/remake/export/assets/`（symlink） |

## Round-trip 结果

| 测试 | 结果 | 证据 |
|------|------|------|
| unpack→repack（reuse 压缩块） | **PASS** 字节级一致 | `roundtrip_bin222.zip` == `original_bin222.zip`（sha256 `ed421440…5d14`） |
| local+central CRC vs 内容 | **PASS** | `validate_ok: true`（407/407） |
| 改一张 face PNG 后重打 | **PASS** | `assets/face/naruto.png` CRC `86f20a5c` → `20b042fe`；`marked_face_bin222.zip` |
| 原样 ZIP 写回 DefineBinaryData 222 | **PASS**（同体积，SWF 字节不变） | `embed_bin222.py` smoke |
| 改图 ZIP 写回 | 工具 OK；需体积门 | delta +1953 B → `patch_size_gate.py` |

完整 JSON：`work/remake/repack/ROUNDTRIP-RESULT.json`。

### 压缩策略（与原包一致）

| method | 数量 | 典型内容 |
|--------|-----:|----------|
| STORE (0) | 352 | 目录×9 + 多数 PNG/SWF |
| DEFLATE (8) | 55 | 全部 mp3、config/font/sounds XML、movelist.jpg、少量 PNG/SWF |

未改动的条目 **复用原 compressed payload**（保证 round-trip 字节一致）；改动条目按原 method 重算 CRC32，并写入 **local header 与 central directory 同一 CRC**（deng.fzip / 标准 ZIP 均依赖此字段）。

原包 CD 带 36 字节 NTFS extra、LH extra 为空——回打时保持 LH/CD extra 分离，勿把 CD extra 抄进 LH。

## 命令

```bash
# 1) 从 main.swf 切出模板（已有则可跳过）
python3 tools/repack_zip222.py extract-template

# 2) 原样回打（默认 reuse）
python3 tools/repack_zip222.py rebuild \
  --assets extracted/full/zips/bin_222 \
  --out work/remake/repack/repacked_bin222.zip

# 3) Round-trip + 打标 face 演示
python3 tools/repack_zip222.py roundtrip --require-bytes \
  --out-dir work/remake/repack

# 4) 校验任意 ZIP 的 CRC
python3 tools/repack_zip222.py validate work/remake/repack/marked_face_bin222.zip
```

改单张图后手动重打（overlay）：把改过的 PNG 放进临时树，或改 `extracted/.../assets/face/X.png` 后 `rebuild`（reuse 会自动只重压变更文件）。

## 下一步：嵌入 DefineBinaryData id=222 并重建可玩包

**不要**写回仓库根目录的 `main.swf`。流程：

```bash
# A. 复制游玩骨架（以 rev2 为壳参考）
mkdir -p play/games/bvn-perfect
cp -a play/games/bvn-rev2/index.html \
      play/games/bvn-rev2/main.js \
      play/games/bvn-rev2/icon.png \
      play/games/bvn-perfect/
# 按需复制 ruffle / local-runtime-guard（与其它 games 同级的共享资源）

# B. 把 ZIP 嵌入到 *副本* SWF
python3 tools/embed_bin222.py \
  --swf main.swf \
  --zip work/remake/repack/marked_face_bin222.zip \
  -o play/games/bvn-perfect/main.swf

# C. 若 ZIP 体积变化（几乎总会，除非等长替换）：跑体积门
python3 tools/patch_size_gate.py play/games/bvn-perfect/main.swf \
  --main-js play/games/bvn-perfect/main.js

# D. 校验三处长度一致
python3 tools/patch_size_gate.py play/games/bvn-perfect/main.swf \
  --main-js play/games/bvn-perfect/main.js --verify

# E. HTTP 冒烟（8765 + blank-ad 404 + flashframe=2）
bash tools/serve_check.sh
# 浏览器打开 http://127.0.0.1:8765/games/bvn-perfect/index.html
# 选人界面应看到 naruto 头像带红角标（B2 mark）
```

### 嵌入原理（`embed_bin222.py`）

| 字段 | 原包 |
|------|------|
| Tag | DefineBinaryData (87)，extended header |
| character id | 222 |
| tag 起点 | file offset `526911` |
| ZIP payload | offset `526923`，长度 `65699574` |
| 同体积替换 | 覆盖 payload；FileLength 不变；可跳过体积门 |
| 变长替换 | 重写 tag length + splice；写 SWF `FileLength`（offset 4）；**必须** `patch_size_gate.py` 同步 `#04236f9c` / `#4236f9c` 与 `main.js` metas |

同体积、只改已有文件且压缩后总长不变时，可省体积门；**CRC 仍必须正确**（本工具保证）。

## 产出清单

```
tools/repack_zip222.py
tools/embed_bin222.py
work/remake/repack/
  original_bin222.zip          # 模板
  repacked_bin222.zip          # 原样回打
  roundtrip_bin222.zip         # round-trip 产物（字节=模板）
  marked_face_bin222.zip       # 改 naruto face
  overlay/assets/face/naruto.png
  ROUNDTRIP-RESULT.json
  smoke_embed_marked.swf       # 嵌入演示（+1953，未跑体积门）
work/remake/REPACK.md          # 本文件
play/games/bvn-perfect/        # 骨架说明 stub（见 README）
```

## 验收对照（计划 B2 DONE）

- [x] `repack_zip222.py`：local+central CRC；store/deflate 跟原策略  
- [x] 原样 round-trip 字节 PASS  
- [x] 改一张 face PNG → 重打 → CRC 更新  
- [x] 文档写明嵌入 id=222 + 体积门 + 可玩包路径  
- [ ] 桌面实机选人可见新图（需完成 play 包复制 + size-gate + Ruffle；本轮工具链已通）
