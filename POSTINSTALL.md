# Playwright MCP is installed

1. Open **Configure** in the Cloudron app dashboard (or visit `$CLOUDRON-APP-ORIGIN/admin`).
2. Copy the **API token** and MCP URL.
3. Add the server to your MCP client:

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

## Security

This app can browse arbitrary websites and execute page scripts. Treat the API token like a password. Use a dedicated app instance and restrict network access if needed.

## Catalog URL

To install on other Cloudron servers, add this community app URL in the dashboard:

`https://raw.githubusercontent.com/benneic/cloudron-playwright-mcp/main/CloudronVersions.json`
