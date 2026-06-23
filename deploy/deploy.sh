#!/usr/bin/env bash
set -euo pipefail

# Deploy script - run on the server as the owner of /opt/snadly-website and the
# PM2 daemon that keeps snadly-website running.

export CI=true

cd /opt/snadly-website

git fetch origin
git reset --hard origin/master

rm -rf node_modules
pnpm install --frozen-lockfile
pnpm build

pm2 startOrReload ecosystem.config.cjs --update-env
pm2 save

echo "Deploy complete."
