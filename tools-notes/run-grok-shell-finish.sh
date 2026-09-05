#!/bin/bash
set -euo pipefail
cd /workspace/bvn-3.3
export PYTHONUNBUFFERED=1
stdbuf -oL -eL /workspace/tools/grok --no-auto-update --trust --always-approve --output-format streaming-json --cwd /workspace/bvn-3.3 -p "$(cat /workspace/bvn-3.3/GROK-LINE-SHELL-FINISH.md)" 2>&1 | stdbuf -oL tee -a /workspace/bvn-3.3/reverse/line-by-line/_maps/grok-shell-finish.log
echo "GROK_EXIT=$?" | tee -a /workspace/bvn-3.3/reverse/line-by-line/_maps/grok-shell-finish.log
