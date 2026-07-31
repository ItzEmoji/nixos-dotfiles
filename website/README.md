# Website

This website is built using [Docusaurus](https://docusaurus.io/), a modern static website generator.

## Installation

```bash
bun install
```

**Note**: this project uses [bun](https://bun.sh/) specifically — `bun.lock` is
committed and CI runs `bun install --frozen-lockfile`, so installing with a
different package manager would regenerate a `package-lock.json`/`yarn.lock`
and drift from what CI actually uses.

## Local Development

```bash
bun run start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

## Build

```bash
bun run build
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

## Deployment

This site is deployed by the `.github/workflows/docs.yaml` GitHub Actions workflow,
which is triggered manually from the Actions tab (`workflow_dispatch`). It builds the
site and publishes it to GitHub Pages via `actions/deploy-pages` (custom domain
configured via `static/CNAME`) — there is no `gh-pages` branch or `npm run deploy` step.

Before rebuilding, regenerate the options reference pages from the current flake state:

```bash
../scripts/gen-options.sh
bun run ../scripts/gen-configured-options.js
```
