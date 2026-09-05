# `KyoUtils` — 杂项工具箱

一句话目的：数组 / 显示对象 / 数字 / 字符串 / 反射。1105 行。本引擎只用其中约 9 个方法，其余是 kyo 库库存。

源文件：`decompiled/main/scripts/net/play5d/kyo/utils/KyoUtils.as`（1105 行）

## 本引擎实际用到的

| 方法 | 调用方 |
|------|--------|
| `setValueByObject` | `HitVO` / `EffectVO` / `KeyConfigVO` / `ConfigVO` / `UIUtils.formatText` |
| `itemToObject` | `EffectVO.clone` / `KeyConfigVO.toSaveObj` |
| `cloneValue` | `HitVO.clone`（白名单字段） |
| `setMcVolume` | `Bullet` 音量 |
| `drawDisplay` | `ShadowEffectView`、`MapMain` 小地图、`QiBar` 脸 |
| `drawBitmapFilter` | `BitmapFilterView` 每帧 |
| `array_deleteSames` | `AssetManager.loadBitmaps` 脸图 URL 去重 |
| `addFrameScript` | `SelecterItemUI` 把回调挂到 **最后一帧** |
| `num_wake` | `BaseGameSprite` 速度阻尼（四轴） |

下面按源码顺序逐函数说明。标「本包无调用」的，引擎 SWF 仍编译进来。

## 数组

### `array_findOneByPortal`（L35–47）

`(arr, key, value)`：第一项 `item[key]==value`。没有返回 `null`。无调用。

### `array_removeByPortal`（L49–62）

按字段删。`splice` 后 **仍 `_loc4_++`**，会跳过紧挨着的下一项。多项匹配会漏。无调用。

### `array_findAllByPortal`（L64–76）

所有匹配项的新数组。无调用。

### `array_hasItem`（L78–83）

`indexOf != -1`。无调用。

### `array_push_notHas`（L84–97）

`null` 直接 false。已有 return false，没有则 push return true。无调用。

### `array_pushAt`（L99–124）

在 `index` 插入一项或一组。从尾往 index 挪，再写入。`param2 is Array` 则整组插入。无调用。

### `array_removeItem`（L126–133）

`indexOf` 只删 **第一个**。`param1` 类型写成 Object，靠 `indexOf`/`splice`。`grayMC` 内部会调。

### `array_deleteSames`（L135–150）

原地去重：副本 → `splice(0,length)` 清空 → 再按首次出现 push。`AssetManager` 对人脸/地图预览 URL 去重。依赖 `indexOf` 的 `===`。

### `array_countItem`（L152–165）

`==` 计数。无调用。

### `array_fixID`（L175–184）

`for each` 拷到新数组。名字像「修稀疏数组」，AS3 Array 的 `for each` 跳洞，结果仍可能紧凑。无调用。

### `array_getSamePortalItems`（L186–218）

字段值出现超过一次的所有项（含第一次）。二次扫描。键被 `for-in` 成字符串。无调用。

### `array_groupByPortal`（L220–232）

`{ fieldValue: [items] }`。无调用。

## 显示对象 / 位图

### `sprite_removeAllChildren`（L167–173）

`while numChildren` `removeChildAt(0)`。无回调。无调用。同类 `removeAllChildren`（L434）可带回调。

### `getBitmapDatasByMC`（L234–258）

MC：`gotoAndStop(0..totalFrames-1)` 每帧 `draw` 一张。**帧号 0** 在 FP 会落到第 1 帧；最后一帧可能漏。非 MC：单张。无调用。

### `drawDisplay`（L261–277）

`(dobj, cropToBounds=true, transparent=true, fill=0, colorTransform=null) → Bitmap`。

宽或高 ≤0 / null → `null`。`new BitmapData(width, height, ...)` 用的是 **显示宽高**（含滤镜外扩，整数）。`cropToBounds`：`getBounds(self)` 做矩阵平移，把负坐标内容拉进图。`ShadowEffectView` / `MapMain` / `QiBar` 都传 `true`。

不 `dispose` 调用方拿到的 BitmapData。

### `drawBitmapFilter`（L279–302）

先 `drawDisplay` 式画到临时 BD，再 `applyFilter` 到可能更大的矩形（`param4` Point 当四周 padding：x/y 减、宽高加 `*2`）。临时 BD dispose，返回滤镜后 BD。`BitmapFilterView` 每帧调用，旧 BD 由那边替换。

`applyFilter` 的源矩形若 x 为负，行为依赖运行时。?

### `drawInverted`（L304–314）

倒影：画底部 `param2` 高，`scaleY=-1`，`y = height + param2/1.7`，alpha 默认 0.3。无调用。

### `translateMC`（L316–342）

当前时间轴有标签 `param2` 则 `gotoAndStop`。否则递归子 MC。无调用。`null` 标签直接 return。

### `transparent`（L344–366）

按样色扣透明。样色：`param2==null` 用 (0,0) 像素；`param3==null` 用 `param2` 当颜色值；否则 `getPixel(param2,param3)`。`threshold(..., "==", color, 0, 15790320, true)`。mask `0xF0F0F0` = RGB 高 4 位，近色也会透。无调用。

### `getToChildPoint`（L368–384）

沿 parent 链累加 x/y，直到 `param2`。找不到：trace `"is not 's parent!"`，仍返回累加到根的点。**不加** `param1` 自身以外的 scrollRect/缩放。无调用（`moveDisplay` 会调）。

### `moveDisplay`（L386–396）

`param3` 默认 true：先 `getToChildPoint` 改 x/y，再 `addChild` 到新父。无调用。

### `removeAllChildren`（L434–445）

与 sprite 版相同，但每摘一个可 `param2(child)`。无调用。

### `removeChildByName`（L447–454）

`getChildByName` 有则 `removeChild`。无调用。

## 数字 / 字符串

### `addZeroBeforNumber`（L398–412）

整数部分左补 0 到 `param2` 位，小数部分原样拼回。`Befor` 原拼写。无调用。

### `getPostfix`（L414–432）

扩展名小写。有 `?` 时取问号前 5 个字符再找 `.`（`file.swf?x` 能工作；更长扩展名会截错）。无调用。

### `number2CN`（L456–513）

整数转中文（万/千/百/十）。**bug**：`>=10000` 时 `param1 -= 10000` 只减一万，不是 `10000*_loc2_`。`>=1000` 同样只减 1000。百位才 `-= _loc4_*100`。千以上基本错。无调用。

### `num2cnbase`（L515–523）

0–9 → 零…九。`param2==false` 且值为 0 返回 `""`。私有。

### `appendTextAutoLine`（L525–536）

`appendText` 后若 `maxScrollV` 增加，改成 `"\n"+text` 并 return true。无调用。

### `appendTextBottom`（L538–569）

行数 ≤1 时先补 `param3` 个空行。再追加。然后 `getLineOffset(1)` 删掉第一行（滚动窗口）。无调用。

### `math_is_between`（L571–574）

闭区间，两端可颠倒。无调用。`KyoMath.inRange` 不颠倒。

### `num_wake`（L576–595）

把值往 0 收 `param2`：正数减，负数加，过 0 钉在 0。`BaseGameSprite` 阻尼：`velocity -= sign * damping * rate` 的等价。

### `num_strong`（L597–608）

往远离 0 加 `param2`。0 当非负，会变成 `+param2`。无调用。

### `num_fixRange`（L610–621）

`Point.x` 当下限、`Point.y` 当上限。无调用。`KyoMath.fixRange` 用两个 Number。

### `point_fixRange`（L623–641）

把点钳进矩形。上界用的是 `rect.width` / `rect.height`，**不是** `x+width` / `y+height`。仅当矩形原点在 (0,0) 才对。无调用。

### `num_decimal`（L643–655）

截断到 `param2` 位（默认 1），不是 round。用字符串找 `.`。无调用。

### `num_toPersent`（L657–672）

`*1000/10` 再拼 `"%"`。`Persent` 原拼写。`param2==0` 取整；`>0` 走 `num_decimal`。无调用。

## 反射 / 赋值

### `setValueByObject`（L674–732）

把 `obj` 的可枚举键写到 `setter` 上。

1. `obj` 空 return。
2. 先 `try setter[i]` 探类型。读失败当 `undefined`。
3. 目标当前是 `undefined`：直接赋，失败 `trace("KyoUtils.setValueByObject :", e)`。
4. `Boolean`：Bool 原样；Number `==1`；String `"true"` 或 `"1"`。
5. `Number`：`Number(vv)`。
6. 其它直接赋。

`HitVO` / `EffectVO` / `ConfigVO` / `KeyConfigVO` 从 XML/存档灌字段。`UIUtils.formatText` 把字号/颜色表灌进 `TextFormat`。

不处理 getter-only、写失败（非 undefined 分支无 try）。XML 属性全是 String，Number 字段靠第 5 条转。

### `cloneValue`（L734–753）

`param3` 白名单数组：只拷这些键。否则 `for-in param2` 全拷到 `param1`。返回 `param1`。`HitVO.clone` 传 `_cloneKey`。

### `cloneObject`（L755–764）

浅拷动态 Object。无调用。

### `clone`（L989–995）

`ByteArray.writeObject/readObject` AMF 深拷。无调用。循环引用会丢或炸。

### `getClass`（L1019–1023）

`getQualifiedClassName` + `getDefinitionByName`。无调用。

### `itemToObject`（L1052–1064）

`describeType` 的 `<variable>`（实例变量，**不含 getter/accessor**）。`EffectVO` / `KeyConfigVO` 用来做可序列化快照。`[Bindable]` accessor 不会进。

### `getItemVaribles`（L1066–1078）

同上，只返回名字数组。`Varibles` 原拼写。无调用。

### `cloneSimpleClassObject`（L1080–1087）

`itemToObject` → `new Class()` → `setValueByObject`。无参构造失败会抛。无调用。

## 文本排版

### `setText`（L766–779）

`String(param2)`，null 用 `param4`（默认 `"null"` 这个词）。`mouseEnabled = param3`。`param5` 则 `textFieldAutoSize`。无调用。

### `textFieldAutoSize`（L781–800）

多行：`textHeight > height` 就字号 -1。单行：`textWidth > width` 字号 -1。无下限，可减到 0。无调用。引擎 `UIUtils` 自己做字号。

### `alignTexts`（L802–832）

`param3==0` 水平串、`1` 垂直串。`autoSize` 默认 LEFT。`param5` 给宽高加 padding。无调用。

## 几何

### `matchPoint`（L834–841）

任一 null → false。否则 x/y 相等。无调用。

### `matchRectangel`（L843–850）

`Rectangel` 原拼写。四字段全等。无调用。

### `rect_is_hit`（L852–878）

先把负宽/高翻正，再 `intersection`。空则 null，否则返回相交矩形。无调用。

## MovieClip / 声音 / 其它

### `addFrameScript`（L880–888）

`param3==-1`（默认）挂到 `totalFrames-1`（最后一帧，0-based）。`SelecterItemUI` 用来在入场动画结束时解锁输入。`addFrameScript` 会 **替换** 该帧已有脚本。

`param3` 非 -1 时 `_loc4_` 仍是 0（未赋值），会挂到第 0 帧。? 调用方都走默认。

### `string_length`（L890–895）

`writeMultiByte(..., "gb2312")` 的字节数。无调用。缺码表时行为看运行时。

### `str_removePrefix`（L897–905）

名字像去前缀，实际 **`indexOf(".")` 之前**（去扩展名）。无调用。

### `str_replaceALL`（L907–910）

`split(a).join(b)`。无调用。

### `str_matchALL`（L912–931）

最多 10000 次 `match`，取捕获组 `[1]`，从原串 `replace` 掉再继续。结果 `reverse`。`replace` 不传全局 flag 只换第一处。无调用。

### `getPrefix`（L933–938）

名字像前缀，实际取 **第一个 `.` 之后** 并 `toLocaleLowerCase`（扩展名）。与 `getPostfix` 不同：本函数不处理 `?`。无调用。

### `grayMC`（L940–969）

`param2==true`：从 `filters` 里去掉所有 `ColorMatrixFilter`。`false`：`filters = [灰度矩阵]`（**覆盖**，0.3086/0.6094/0.082）。无调用。`MCUtils.setHUE` 是另一套。

### `getObjLength`（L971–987）

`for each` 计 **真值** 个数（跳过 0 / "" / null / undefined / false）。不是键数。无调用。

### `readTextVariables`（L997–1017）

去 `\r`，按行 `split("=")`。`//` 开头跳过。`key=value` 无 trim，值里再有 `=` 只取 `[1]`。依赖 `com.adobe.utils.StringUtil.replace`。无调用。

### `customMenu`（L1025–1050）

右键菜单。`param2` 字符串数组。选中回调收到 caption。`stage.showDefaultContextMenu=false`。闭包在循环里加监听，AS3 函数绑定当时的 `menuItem`。无调用。

### `setMcVolume`（L1089–1101）

`sprite.soundTransform.volume = param2` 写回。`Bullet` 用来跟全局音效音量。`param1` 空 return。读到的是拷贝，必须写回才生效（这里做了）。
