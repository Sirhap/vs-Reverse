#!/usr/bin/env bash
set -euo pipefail
cd /workspace/bvn-3.3
export PYTHONUNBUFFERED=1
LOG=/workspace/bvn-3.3/reverse/line-by-line/_maps/grok-ui.log
mkdir -p /workspace/bvn-3.3/reverse/line-by-line/ui /workspace/bvn-3.3/reverse/line-by-line/_maps
: > "$LOG"
echo "START ui $(date -u +%Y-%m-%dT%H:%M:%SZ)" | tee -a "$LOG"
stdbuf -oL -eL /workspace/tools/grok --no-auto-update --trust --always-approve --output-format streaming-json --cwd /workspace/bvn-3.3 -p "$(cat /workspace/bvn-3.3/GROK-LINE-UI.md)" 2>&1 | stdbuf -oL tee -a "$LOG"
echo "GROK_EXIT=${PIPESTATUS[0]}" | tee -a "$LOG"
