# `interfaces.IExtendConfig` — 平台扩展配置（本包空）

一句话目的：给 `ConfigVO` 一块可序列化的附加配置。存档键 `extend_config`。本 SWF `GameInterfaceManager.getConfigExtend()` 返回 null，接口无实现类。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/interfaces/IExtendConfig.as`（11 行）

## Callers / callees

- **持有**：`ConfigVO.extendConfig`。构造里 `GameInterface.instance.getConfigExtend()`。本包恒 null，后面所有 `if(extendConfig)` 都不进。
- **序列化**：`ConfigVO.toSaveObj` 有则写入 `extend_config`；`readSaveObj` 有则 `readSaveObj`。`getValueByKey` / `setValueByKey` 在 `ConfigVO` 自身没有该属性时，尝试 `extendConfig[key]`（当动态对象，不经本接口方法）。
- **Implementors**：本 `decompiled/main/scripts` 无。留给其它渠道包（Steam/其它门户）塞画质、触屏等额外项。

## 逐行说明

### `toSaveObj`（L6）

打成可进 SharedObject / JSON 的 Object。`ConfigVO.toSaveObj` 嵌成 `extend_config`。

### `readSaveObj`（L8）

从存档 Object 灌回。`param1` 即当时 `toSaveObj` 的产物。无返回值。
