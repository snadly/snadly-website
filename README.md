# SNADLY website

Astro 6 website scaffold for **SNADLY**. It runs as a standalone Node server behind PM2 and deploys through GitHub Actions using the same shape as the DocketWorks website.

## Develop

```sh
pnpm install
pnpm dev
pnpm build
pnpm preview
pnpm test
```

## Configuration

Copy `.env.example` to `.env` for local or server-side values. Content and integrations can be added once the site copy is ready.

## Deploy

The production server is expected to have the repo at `/opt/snadly-website`, with PM2 available to the deploy user.

Automatic deploys run from `.github/workflows/deploy.yml` on pushes to `master`, SSH to the server, and run `deploy/deploy.sh`.

Required GitHub Actions secrets:

- `DEPLOY_HOST`
- `DEPLOY_USER`
- `DEPLOY_SSH_KEY`

Runtime defaults are in `ecosystem.config.cjs`:

- PM2 app: `snadly-website`
- Host: `127.0.0.1`
- Port: `4322`

Put nginx or another reverse proxy in front of that local port.
