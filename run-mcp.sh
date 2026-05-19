#!/bin/bash
set -euo pipefail

export PLAYWRIGHT_BROWSERS_PATH="${PLAYWRIGHT_BROWSERS_PATH:-/app/code/playwright-browsers}"
export HOME=/app/data

exec node /app/code/node_modules/@playwright/mcp/cli.js \
  --headless \
  --browser chromium \
  --no-sandbox \
  --host 127.0.0.1 \
  --port 8931 \
  --output-dir /app/data/playwright-output
