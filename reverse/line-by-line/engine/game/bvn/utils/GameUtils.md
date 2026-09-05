# `GameUtils` — 舞台命中测试（`isInTop`）

一句话目的：判断某个 DisplayObject 是否盖在舞台某点的最上层。`bleachvsnaruto.etHandler` 用它等自己真正露出来再 `goLogo`。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/utils/GameUtils.as`（51 行）

## Callers / callees

- **Callers**：仅 `bleachvsnaruto.etHandler`（`bleachvsnaruto_2.as` L121）：`GameUtils.isInTop(this)` 为真才卸 enterFrame、派 `5d_message` `["games_inited"]`、`_mainGame.goLogo()`。
- **Callees**：`DisplayObjectContainer.getObjectsUnderPoint`、`contains`。无其它引擎类。

## 命名备注

类几乎只有这一个方法。不是数学工具集。`isInTop` 的「Top」是显示列表最前，不是浏览器窗口置顶。

## 逐行说明

### 空构造（L10–13）

全静态。

### `isInTop`（L15–47）

签名：`isInTop(target, container=null, point=null)`。

1. **container 默认 `param1.stage`**。`etHandler` 只传 `this`（游戏根 Sprite），所以在整舞台上测。
2. **point 默认舞台中心**：先 `new Point(1,1)`，再 `try` 写成 `stageWidth/2, stageHeight/2`。`param2.stage` 空（尚未上舞台）catch 吞掉，点留在 (1,1)。
3. `param2.getObjectsUnderPoint(param3)` 从底到顶。空数组 → `false`（中心没任何像素，继续等下一帧）。
4. `pop()` 取最顶那个。
   - `param1` 是容器（游戏根是 Sprite）：`contains(顶层对象)` —— 中心点点到的东西必须是自己的子孙（含自己）。壳进度条、远程 overlay 还在中心就会是 false。
   - 否则比引用相等。

`etHandler` 每帧问一次，避免套在别的 Loader 里或被加载条挡住时抢先 `goLogo`。Ruffle/本地若中心一直被别的盖住，会永远停在黑底、进不了 Logo。
