# `TeamVO` — 一场对局里的一队精灵容器

一句话目的：id=1 P1 / id=2 P2。`children` 挂该队所有 `IGameSprite`（角色、子弹、攻击体、辅助）。碰撞按队交叉；死亡时从敌队 children 里找活着的 `FighterMain` 当胜者。

源文件：`decompiled/main/scripts/net/play5d/game/bvn/data/TeamVO.as`（65 行）

## Callers / callees

- **创建**：`GameCtrl` `GameMode.getTeams()` → `new TeamVO(id, name)` → `TeamMap.add`。
- **挂接**：`GameCtrl.addGameSprite(teamId, sprite)` → `team.addChild` + `sprite.team = team`。`removeGameSprite` → `removeChild`。
- **遍历**：`GameMainLogicCtrler` 跨队 `checkBodyHit` / `checkHit`；`FighterEventCtrl.onDie` `getEnemyTeam` 扫 children。
- **其它**：`GameRunDataVO.lastWinnerTeam`；`FighterMain.targetTeams`；`Bullet`/`BaseGameSprite`/`BitmapFilterView` 的 `team` 属性类型。
- **Callees**：`BaseGameSprite.isAlive`（`getAliveChildren`）。

## 逐行说明

### 字段（L9–13）

- `id` / `name`：1/`P1`、2/`P2`。
- `children:Vector.<IGameSprite>`：允许重复 add 被 `indexOf` 挡住。含非角色。

### 构造（L15–20）

`(id, name=null)`。

### `getAliveChildren`（L22–44）

新 Vector。`BaseGameSprite` 且 `!isAlive` 的跳过；**非** BaseGameSprite（`Bullet`）一律收入。给需要「还在场上的实体」的逻辑；本包主循环更多直接扫 `children` 再自己判 `isDestoryed`。

### `addChild`（L46–53）

已在 vector 里则 no-op。不写 `sprite.team`（由 `GameCtrl` 先写）。

### `removeChild`（L55–62）

`indexOf` 到则 `splice`。找不到不管。不 destory 精灵。
