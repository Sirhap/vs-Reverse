#!/usr/bin/env bash
# BVN local play serve assertions (Phase A1).
#
# Asserts:
#   1) HTTP 127.0.0.1:8765 is up and serving a game index/SWF
#   2) play/blank-ad.swf returns 404 (required; do NOT place a loadable SWF there)
#   3) app.flashframe=2 in the game's main.js metas (when --game given / default)
#
# Usage:
#   tools/serve_check.sh
#   tools/serve_check.sh --game bvn-rev2
#   tools/serve_check.sh --start   # start play/start-server.sh in background if down
#
# Exit 0 only when all applicable checks pass.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLAY="$ROOT/play"
HOST="127.0.0.1"
PORT="8765"
BASE="http://${HOST}:${PORT}"
GAME="bvn-rev2"
DO_START=0
FAILS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --game) GAME="${2:-}"; shift 2 ;;
    --start) DO_START=1; shift ;;
    -h|--help)
      sed -n '1,20p' "$0"
      exit 0
      ;;
    *)
      echo "unknown arg: $1" >&2
      exit 2
      ;;
  esac
done

GAME_DIR="$PLAY/games/$GAME"
INDEX_URL="$BASE/games/$GAME/index.html"
SWF_URL="$BASE/games/$GAME/main.swf"
BLANK_URL="$BASE/blank-ad.swf"
MAIN_JS="$GAME_DIR/main.js"

pass() { echo "PASS  $*"; }
fail() { echo "FAIL  $*" >&2; FAILS=$((FAILS + 1)); }
info() { echo "INFO  $*"; }

http_code() {
  local url="$1"
  curl -s -o /dev/null -w '%{http_code}' --connect-timeout 2 --max-time 10 "$url" || echo "000"
}

# --- server up ---
code_root="$(http_code "$BASE/")"
if [[ "$code_root" == "000" ]]; then
  if [[ "$DO_START" -eq 1 ]]; then
    info "nothing on :$PORT — starting $PLAY/start-server.sh"
    if [[ ! -x "$PLAY/start-server.sh" ]]; then
      fail "missing $PLAY/start-server.sh"
    else
      ( cd "$PLAY" && nohup ./start-server.sh >"$PLAY/serve-8765.log" 2>&1 & echo $! >"$PLAY/serve-8765.pid" )
      for _ in 1 2 3 4 5 6 7 8 9 10; do
        sleep 0.3
        code_root="$(http_code "$BASE/")"
        [[ "$code_root" != "000" ]] && break
      done
    fi
  fi
fi

if [[ "$code_root" == "000" ]]; then
  fail "HTTP $HOST:$PORT not responding (start with: cd $PLAY && ./start-server.sh)"
else
  pass "HTTP $HOST:$PORT up (GET / → $code_root)"
fi

# --- game serving ---
if [[ ! -d "$GAME_DIR" ]]; then
  fail "game dir missing: $GAME_DIR"
else
  code_index="$(http_code "$INDEX_URL")"
  if [[ "$code_index" == "200" ]]; then
    pass "game index $INDEX_URL → 200"
  else
    fail "game index $INDEX_URL → $code_index (want 200)"
  fi
  # HEAD/GET main.swf may be large; only check status with Range to avoid full download
  code_swf="$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 2 --max-time 30 \
    -H 'Range: bytes=0-15' "$SWF_URL" || echo 000)"
  if [[ "$code_swf" == "200" || "$code_swf" == "206" ]]; then
    pass "game SWF $SWF_URL → $code_swf"
  else
    fail "game SWF $SWF_URL → $code_swf (want 200/206)"
  fi
fi

# --- blank-ad MUST 404 ---
# Note: blank-ad.as3.swf may exist as a note/sample; blank-ad.swf itself must 404.
if [[ -e "$PLAY/blank-ad.swf" ]]; then
  fail "play/blank-ad.swf EXISTS on disk — remove it (must 404). See play/START.md"
else
  info "play/blank-ad.swf absent on disk (good)"
fi
code_blank="$(http_code "$BLANK_URL")"
if [[ "$code_blank" == "404" ]]; then
  pass "blank-ad.swf → 404 ($BLANK_URL)"
elif [[ "$code_blank" == "000" ]]; then
  fail "blank-ad check skipped/unreachable (server down)"
else
  fail "blank-ad.swf → $code_blank (want 404). Do not serve a loadable blank-ad.swf"
fi

# --- flashframe=2 via metas in main.js ---
if [[ -f "$MAIN_JS" ]]; then
  ff="$(python3 - "$MAIN_JS" <<'PY'
import json, base64, re, sys
from pathlib import Path
text = Path(sys.argv[1]).read_text(encoding="utf-8")
m = re.search(r'Po\("\{\{metas\}\}",u\("([A-Za-z0-9+/=]+)"\)\)', text)
if not m:
    print("MISSING")
    raise SystemExit(0)
s = m.group(1)
s += "=" * ((4 - len(s) % 4) % 4)
meta = json.loads(base64.b64decode(s).decode("utf-8"))
print(meta.get("app.flashframe", "MISSING"))
PY
)"
  if [[ "$ff" == "2" ]]; then
    pass "app.flashframe=2 in $MAIN_JS metas"
  else
    fail "app.flashframe=$ff in $MAIN_JS (want 2)"
  fi
else
  info "no main.js at $MAIN_JS — flashframe check skipped"
fi

if [[ "$FAILS" -eq 0 ]]; then
  echo "serve_check: ALL PASS (game=$GAME)"
  exit 0
fi
echo "serve_check: $FAILS FAIL(s)" >&2
exit 1
