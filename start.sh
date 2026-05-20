#!/bin/bash
set -euo pipefail

chown -R cloudron:cloudron /app/data
mkdir -p /app/data/playwright-output /run/app /run/nginx/body /run/nginx/proxy /run/nginx/fastcgi /run/nginx/uwsgi /run/nginx/scgi

if [[ ! -f /app/data/api-token ]]; then
  openssl rand -hex 32 > /app/data/api-token
  chmod 600 /app/data/api-token
  chown cloudron:cloudron /app/data/api-token
  touch /app/data/.initialized
fi

export MCP_TOKEN
MCP_TOKEN="$(cat /app/data/api-token)"

envsubst '${MCP_TOKEN}' < /app/code/nginx.conf.template > /run/app/nginx.conf

exec /usr/bin/supervisord -c /app/code/supervisord.conf
