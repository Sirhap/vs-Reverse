#!/usr/bin/env bash
set -euo pipefail
cd /workspace/bvn-3.3
export PYTHONUNBUFFERED=1
LOG=/workspace/bvn-3.3/reverse/line-by-line/_maps/grok-fighters-B.log
mkdir -p /workspace/bvn-3.3/reverse/line-by-line/fighters /workspace/bvn-3.3/reverse/line-by-line/_maps
echo "START fighters-B $(date -u +%Y-%m-%dT%H:%M:%SZ)" | tee -a "$LOG"
stdbuf -oL -eL /workspace/tools/grok --no-auto-update --trust --always-approve --output-format streaming-json --cwd /workspace/bvn-3.3 -p "$(cat /workspace/bvn-3.3/GROK-LINE-FIGHTERS-B.md)" 2>&1 | stdbuf -oL tee -a "$LOG"
echo "GROK_EXIT=${PIPESTATUS[0]}" | tee -a "$LOG"
