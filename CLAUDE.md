# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ZAICO API Documentation repository - generates interactive HTML documentation from Markdown API specifications using Aglio (API Blueprint format). Published at https://zaicodev.github.io/zaico_api_doc/

## Development Commands

```bash
# Install dependencies (requires Node.js v16)
yarn

# Development server with auto-reload (localhost:3005)
yarn dev

# Build production HTML (outputs to dist/index.html)
yarn build
```

## Architecture

- **api.md**: Main entry point using API Blueprint FORMAT: 1A syntax. Includes all API endpoint files via `<!-- include(...) -->` directives.
- **includes/authorization.md**: Authentication documentation (Bearer token)
- **includes/api/*.md**: Individual API endpoint documentation files (inventories, purchases, packing_slips, customers, etc.)
- **dist/index.html**: Generated HTML output (committed to repo)

## Adding New API Endpoints

1. Create a new file in `includes/api/` following API Blueprint format
2. Add `<!-- include(includes/api/your_new_file.md) -->` to `api.md`
3. Use `# Group` for resource grouping, `## Endpoint [/path]` and `### HTTP_METHOD` for endpoints
4. Define request/response with `+ Request`, `+ Response`, `+ Parameters`, `+ Attributes`

## Deployment

GitHub Actions automatically builds and deploys to GitHub Pages when commits are pushed to `master` branch. The workflow is defined in `.github/workflows/gh-pages.yml`.
