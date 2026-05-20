# Playwright MCP is installed

## Get your API token

The Bearer token is **not** exposed on a public web page. Retrieve it using Cloudron admin tools only:

**File Manager** (recommended)

1. Open this app in the Cloudron dashboard.
2. Open **Console** → **File Manager**.
3. Open `/app/data/api-token` and copy the token (single line, no spaces).

**Shell**

```bash
cloudron exec --app $CLOUDRON-APP-FQDN -- cat /app/data/api-token
```

## MCP endpoint

`$CLOUDRON-APP-ORIGIN/mcp`

## Client configuration

```json
{
  "mcpServers": {
    "playwright": {
      "url": "$CLOUDRON-APP-ORIGIN/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_TOKEN"
      }
    }
  }
}
```

## Environment variables

Cloudron cannot display auto-generated secrets from inside the container in the **Environment** UI. The token lives in `/app/data/api-token` only. You may optionally copy it into a custom env var for your own reference; the app does not read env vars for authentication.

## Security

This app can browse arbitrary websites and execute page scripts. Treat the API token like a password.
