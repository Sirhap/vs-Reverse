# R8 EI Probe (HoldProbe.swf)

Minimal AS3 SWF that registers `ExternalInterface.addCallback("setHold", …)` plus `isReady` / passthrough names.

| Item | Value |
|------|-------|
| Source | `src/HoldProbe.as` |
| Output | `HoldProbe.swf` (also copied to `play/r8-hold-stub/HoldProbe.swf`) |
| Page | `play/r8-hold-stub/ei-probe.html` @ `http://127.0.0.1:8765/r8-hold-stub/ei-probe.html` |
| Result | `../r8-evidence/R8-EI-PROBE-RESULT.json` |
| sample/main.swf | **untouched** |

## Build

```bash
export FLEX_HOME=/workspace/tools/apache-flex-sdk-4.16.1-bin
export PLAYERGLOBAL_HOME=$FLEX_HOME/frameworks/libs/player
$FLEX_HOME/bin/mxmlc -target-player=32.0 -swf-version=32 \
  -static-link-runtime-shared-libraries=true \
  -default-size=800,600 -default-background-color=0x111111 \
  -output HoldProbe.swf src/HoldProbe.as
cp HoldProbe.swf /workspace/bvn-3.3/play/r8-hold-stub/
```

## Contrast

- `main.swf` `timeline.setHold` = MovieClip property → Ruffle **does not** expose to JS.
- `HoldProbe.swf` `addCallback("setHold")` → Ruffle **does** expose `player.setHold` as function.
