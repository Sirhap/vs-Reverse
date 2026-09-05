# `(无名包).bisha_face_mc` — 必杀特写脸底 MC

一句话目的：必杀/万解黑底上的特写容器。左右槽 `facemc1`/`facemc2` 给角色 SWF 导出的脸 Bitmap；时间轴 71 帧，F71 标签 `destory` 且 `stop()`。

源文件：`decompiled/other/effect/scripts/bisha_face_mc.as`（25 行）

## 如何挂上引擎

**不走** `EffectModel` / `EffectView` 光栅化。唯一实例化：[`BishaFaceEffectView`](../../engine/game/bvn/views/effects/BishaFaceEffectView.md) 构造 `AssetManager.I.getEffect("bisha_face_mc")` → 每次 `new` 一份活 MC。

链：

```
$effect_ctrler.bisha / startWanKai
  → FighterEffectCtrl.getFace (new 角色 bsface BitmapData)
  → EffectCtrl.bisha / wanKai → showFace
       比双方 display.x：自己在右 → 槽 2，否则 1
  → BlackBackView.showBishaFace
       第一次 new BishaFaceEffectView（本 MC）
       setFace(slot, bmp) 拉伸 254×180 塞进 facemcN
       fadIn → gotoAndPlay(2)
```

见 [`BlackBackView`](../../engine/game/bvn/views/effects/BlackBackView.md)、[`EffectCtrl.showFace`](../../engine/game/bvn/ctrl/EffectCtrl.md)。替身/爆气/鬼步只有黑底，**不**挂本 MC。

`fadOut` 拆特写；`BlackBackView` 把 `_bishaFace` 置 null，下次必杀再 new。多次必杀可能在黑底上堆停住的旧 MC。?

## 时间轴

SWF DefineSprite **char 926**（`symbol926`），**71 帧** @30fps，约 168 次 Place。嵌套未导出 sprite 922（5 帧）、923（1 帧空，F1 两个 depth 先放着）。

| 帧 / 标签 | 行为 |
|-----------|------|
| F1 | 默认停在这里（构造未 play）。多半空/准备。槽位实例已在。 |
| F2 | [`BishaFaceEffectView.fadIn`](../../engine/game/bvn/views/effects/BishaFaceEffectView.md) `gotoAndPlay(2)` 入场起点 |
| F2–F70 | 入场动画。无其它脚本 |
| **F71 标签 `destory`**（原拼写） | `addFrameScript(70, frame71)` → `stop()`。之后停在末帧直到下次 fadIn 或黑底被摘 |

无 `loop`。退场不是时间轴倒放，是整块 `BlackBackView` 从 `GameState` 摘掉。

公开实例：

| 字段 | 用途 |
|------|------|
| `facemc1` | 左槽（自己 x ≤ 对手，或无对手） |
| `facemc2` | 右槽（自己 x > 对手） |

脸图来自各角色 SWF `defineBishaFace` 的 BitmapData 类，不是本库。

## 逐行说明

无名包。`public dynamic class bisha_face_mc extends MovieClip`。

### 字段（L9–11）

- **L9** `facemc1:MovieClip`
- **L11** `facemc2:MovieClip`

FLA 实例名。`BishaFaceEffectView.setFace` 用 `mc["facemc" + slot]` 动态取。槽号不是 1/2 或时间轴还没建实例则脸丢掉。

### `bisha_face_mc()`（L13–17）

- **L15** `super();`
- **L16** `addFrameScript(70, this.frame71);` — 0-based 70 = 时间轴 **F71**。

### `frame71`（时间轴 F71，L19–23）

- **L21** `stop();` — 停在特写停留帧。标签名 `destory` 引擎不读；真正销毁是 `BishaFaceEffectView.destory` / 黑底 fadOut。

无 `gotoAndPlay`、无 COMPLETE 事件。引擎也不听 COMPLETE。
