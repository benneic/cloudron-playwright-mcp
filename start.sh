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

if [[ -n "${CLOUDRON_APP_ORIGIN:-}" ]]; then
  MCP_PUBLIC_URL="${CLOUDRON_APP_ORIGIN}"
else
  MCP_PUBLIC_URL="https://${CLOUDRON_APP_FQDN:-localhost}"
fi
export MCP_PUBLIC_URL

envsubst '${MCP_TOKEN} ${MCP_PUBLIC_URL}' < /app/code/nginx.conf.template > /run/app/nginx.conf
envsubst '${MCP_TOKEN} ${MCP_PUBLIC_URL}' < /app/code/admin.html.template > /run/app/admin.html
chown cloudron:cloudron /run/app/admin.html
chmod 644 /run/app/admin.html

exec /usr/bin/supervisord -c /app/code/supervisord.conf
