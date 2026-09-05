# `KyoSharedObject` — Flash SharedObject 读写壳

一句话目的：把 `SharedObject.getLocal` 的 load / save / 清空包成三个静态方法。本游戏只走网页接口 `GameInterfaceManager.saveGame` / `loadGame`，槽名 `"bvn3_save"`。

源文件：`decompiled/main/scripts/net/play5d/kyo/KyoSharedObject.as`（42 行）

## Callers / callees

- **Callers**：仅 `GameInterfaceManager.saveGame`（L67）/ `loadGame`（L73）。`GameData.saveData` / `loadData` 经 `GameInterface.instance` 间接进来。
- **Callees**：`flash.net.SharedObject`。无其它 play5d 类。
- **本包无调用**：`deletee`。

## 命名备注

- `deletee`：delete 的原拼写（多一个 e）。
- 槽名 `"bvn3_save"` 是 `GameInterfaceManager` 传入的，**不是** `GameData.SAVE_ID`（`"bvn3.01"`）。后者是写入 `data` 对象里的版本字段。
- 不设 `localPath`，等价 `getLocal(name, null)` → 当前 SWF 域默认路径。

## 逐行说明

### 空构造（L7–11）

全静态。外部不 `new`。

### `load`（L13–19）

`param1` = 槽名。`getLocal` → 取出 `data` 引用 → `close()` → 返回那个 Object。

`close` 之后调用方仍拿着 `data` 的引用。Flash 里 `data` 是普通动态 Object，关掉 SO 不立刻清空内存里的字段。空槽返回空 Object（不是 `null`），所以 `GameData.loadData` 用 `_loc1_.id != "bvn3.01"` 判断「没存过 / 旧版」，不能靠 `if(!_loc1_)`。

不 `flush`。只读。

### `save`（L21–32）

`param1` 槽名，`param2` 要写入的 Object。

1. `getLocal`。
2. **`clear()` 先把旧槽整份抹掉**。不是按键 merge。
3. `for-in` 把 `param2` 的可枚举键逐个赋到 `_loc3_.data`。嵌套对象按引用塞进去；`SharedObject` 之后序列化 AMF。
4. `flush()` 同步写盘（无 `minDiskSpace`，失败只静默）。
5. `close()`。

`GameData.saveData` 写入 `{id:"bvn3.01", config: ConfigVO.toSaveObj()}`。分数 / 选人 / 关卡进度不在这个对象里。

`for-in` 不拷原型链上的不可枚举属性。`ConfigVO.toSaveObj` 产出的是普通 Object，没问题。

### `deletee`（L34–38）

`getLocal` + `clear()`。**不** `flush`、**不** `close`。本包零调用。清完不关，槽句柄留到 GC。?
