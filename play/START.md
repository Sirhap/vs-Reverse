# BVN 3.3 本地启动

## 为啥会起不来（Error #2180 / 进度条卡 0%）

GreenHD 启动时请求 `data.vsgod.win/v1`，拿到广告目录后把里面的 SWF **addChild** 进舞台。

| 做法 | 结果 |
|---|---|
| `blank-ad.swf` 是可加载的空/旧 SWF | Ruffle **#2180**（AVM1→AVM2）或卡死 |
| 守卫回 **空** `<games></games>` | 也会 **卡在开场图 0%**（已实机打回） |
| 守卫回 `<default>…/blank-ad.swf</default>` 且该文件 **404** | 广告加载失败被跳过，**能进菜单** |

硬规则：

1. `local-runtime-guard.js` 必须带 `<default>${blankSwfUrl}</default>`（指向 `../../blank-ad.swf`）。
2. **不要**创建可加载的 `play/blank-ad.swf`（保持 404）。
3. **不要**改成空 `<games></games>`。

## 启动 HTTP

必须 HTTP（`file:///` 会被壳拦）。

```bash
cd /workspace/bvn-3.3/play
./start-server.sh
```

多线程 `127.0.0.1:8765`，工作目录 `play/`。

## 地址

| 构建 | URL |
|---|---|
| 原版 | http://127.0.0.1:8765/games/bvn-3.3/index.html |
| REV | http://127.0.0.1:8765/games/bvn-rev/index.html |
| FULL | http://127.0.0.1:8765/games/bvn-full/index.html |

进页后点一下画面（解锁音频），等进度条走过「游戏初始化」。
