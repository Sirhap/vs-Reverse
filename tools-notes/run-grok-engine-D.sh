#!/bin/bash
set -uo pipefail
cd /workspace/bvn-3.3
LOG=/workspace/bvn-3.3/reverse/line-by-line/_maps/grok-engine-D.log
PROMPT=$(cat /workspace/bvn-3.3/GROK-LINE-ENGINE-D.md)
echo "=== START Batch D $(date -u +%Y-%m-%dT%H:%M:%SZ) ===" | tee "$LOG"
/workspace/tools/grok --no-auto-update --trust --always-approve --output-format json --cwd /workspace/bvn-3.3 -p "$PROMPT" 2>&1 | tee -a "$LOG"
EC=${PIPESTATUS[0]}
echo "GROK_EXIT=$EC" | tee -a "$LOG"
exit $EC
