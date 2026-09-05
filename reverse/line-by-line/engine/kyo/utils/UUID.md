# `UUID` — SHA-1 拼出来的 8-4-4-4-12 串

一句话目的：给每个 `BaseGameSprite` 一个进程内几乎不撞的 `id`。不是 RFC 4122（没有 version/variant 位），是 `sha1(time + Capabilities.serverString + random + counter)` 截 32 hex 再插横杠。

源文件：`decompiled/main/scripts/net/play5d/kyo/utils/UUID.as`（151 行）

## Callers / callees

- **Callers**：仅 `BaseGameSprite` 字段初始化 `id:String = UUID.create()`（每个角色/子弹/攻击体/辅助构造一次）。
- **Callees**：`Date`、`Math.random`、`Capabilities.serverString`。SHA-1 自包含。

## 逐行说明

### `counter`（L7）

静态，每次 `create` 自增，避免同一毫秒撞。

### `create`（L15–23）

材料：`getTime()` + `Capabilities.serverString` + `random*Number.MAX_VALUE` + `counter++`。拼成字符串进 `calculate`（即 SHA-1 hex），`toUpperCase`，切：

`8 - 4 - 4 - 4 - 12`（标准 UUID 外形）。第 13 字符不是 `4`，第 17 字符不是 `8/9/A/B`。

`serverString` 在部分运行时为空或常值，主要熵来自时间和 random。

### `calculate` / `hex_sha1`（L25–33）

转发 `binb2hex(core_sha1(str2binb(s), len*8))`。教科书 SHA-1。

### `core_sha1`（L35–87）

标准 80 轮。初始 H0..H4：`1732584193, -271733879, -1732584194, 271733878, -1009589776`。消息末尾补 0x80 和长度。每 16 word 一块。

### `sha1_ft` / `sha1_kt`（L89–109）

f 函数与轮常量（20/40/60 分界）。`kt` 第三段 `-1894007588`、第四段 `-899497514` 与标准一致（补码）。

### `safe_add` / `rol`（L111–121）

32 位加、循环左移。JS/AS 无原生 uint32 时的常规写法。

### `str2binb`（L123–135）

按 8-bit 字符（`charCodeAt & 0xFF`）装大端 word 数组。`serverString` 若含 >255 的字符会被截。

### `binb2hex`（L137–147）

5 个 word × 4 字节 = 40 hex 字符。`create` 只用前 32。
