# Playwright MCP for Cloudron

Self-host [Microsoft Playwright MCP](https://playwright.dev/mcp/) on your Cloudron server so remote AI agents can automate a headless Chromium browser over the Model Context Protocol (HTTP).

## Features

- Streamable HTTP MCP at `/mcp` (TLS terminated by Cloudron)
- Bearer API token generated on first start; retrieve via Cloudron File Manager (`/app/data/api-token`)
- Accessibility snapshots, screenshots, navigation, forms, network mocking, and more
- No LLM required on the server — your agent supplies the intelligence
- Persistent API token and browser output under `/app/data`

## Requirements

- Cloudron 9.1.0 or newer
- At least 2 GB memory for the app (configured in the manifest)

## Upstream

Browser automation is provided by [`@playwright/mcp`](https://www.npmjs.com/package/@playwright/mcp). This package is a thin Cloudron wrapper (nginx auth + process supervision).
