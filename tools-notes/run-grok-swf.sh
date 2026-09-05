#!/bin/bash
set -euo pipefail
cd /workspace/bvn-3.3
PROMPT=$(cat /workspace/bvn-3.3/grok-prompt.txt)
exec /workspace/tools/grok --no-auto-update --trust --always-approve --output-format json --cwd /workspace/bvn-3.3 -p "$PROMPT"
