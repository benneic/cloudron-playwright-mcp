# cloudron-playwright-mcp

Cloudron app package for [@playwright/mcp](https://www.npmjs.com/package/@playwright/mcp) — remote headless browser automation for MCP clients (ChatGPT agents, Cursor, Claude, etc.) over HTTP.

## Install from Cloudron

1. In the Cloudron dashboard, add a community app catalog URL:

   `https://raw.githubusercontent.com/benneic/cloudron-playwright-mcp/main/CloudronVersions.json`

2. Install **Playwright MCP** from the app store.

Or via CLI:

```bash
cloudron install --versions-url https://raw.githubusercontent.com/benneic/cloudron-playwright-mcp/main/CloudronVersions.json
```

## After install

In the Cloudron app dashboard, see the post-install message and checklist. Copy the API token from `/app/data/api-token` via **Console → File Manager** or `cloudron exec --app <fqdn> -- cat /app/data/api-token`. MCP URL: `https://<your-app-fqdn>/mcp`.

## Build and publish (maintainers)

```bash
npm install
cloudron login my.cloudron.example
cloudron build -f Dockerfile.cloudron
cloudron versions add
git add CloudronVersions.json && git commit -m "release $(jq -r .version CloudronManifest.json)"
git push
```

Images are published to `ghcr.io/benneic/cloudron-playwright-mcp`.

## Development

```bash
docker build -f Dockerfile.cloudron -t cloudron-playwright-mcp .
docker run --rm -p 8000:8000 -e CLOUDRON_APP_FQDN=localhost -e CLOUDRON_APP_ORIGIN=http://localhost:8000 cloudron-playwright-mcp
```

## CI secrets

| Secret | Purpose |
|--------|---------|
| `GITHUB_TOKEN` | Push `CloudronVersions.json`, create releases |
| (default) | GHCR push uses `GITHUB_TOKEN` with `packages:write` |

## License

Packaging scripts: MIT. `@playwright/mcp` is licensed by Microsoft (see upstream).
