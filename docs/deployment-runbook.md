# SNADLY deployment runbook

Last updated: 2026-06-24 NZDT / 2026-06-23 UTC.

This document records the production settings for the SNADLY website and the steps needed to rebuild the deployment from a fresh Oracle Cloud VM.

Do not commit private keys, API keys, GitHub secret values, or Porkbun account credentials. Only secret names and expected locations are documented here.

## Live endpoints

- Primary site: `https://snadly.com`
- WWW site: `https://www.snadly.com`
- Oracle public IP: `140.238.196.85`
- HTTP redirects to HTTPS for both hostnames.

## Source repository

- GitHub repo: `https://github.com/snadly/snadly-website`
- Default branch: `master`
- Local deployment path on server: `/opt/snadly-website`
- Current server commit at setup time: `28a2a14 Fix SNADLY deploy workflow path`

Relevant repo files:

- `.github/workflows/deploy.yml`
- `deploy/deploy.sh`
- `ecosystem.config.cjs`

GitHub Actions deploy secrets:

- `DEPLOY_HOST`: server public IP, currently `140.238.196.85`
- `DEPLOY_USER`: SSH user, currently `ubuntu`
- `DEPLOY_SSH_KEY`: private key for a dedicated GitHub Actions deploy key

The deploy key's public key is installed in `/home/ubuntu/.ssh/authorized_keys` on the server. The private key is stored only as the GitHub Actions secret.

## Oracle instance

Observed from the Oracle console and server:

- Instance name: `instance-20260623-2142`
- Public IP: `140.238.196.85`
- Private IP: `10.0.0.119`
- Shape: `VM.Standard.A1.Flex`
- OCPU count: `1`
- Memory: `6 GB`
- OS: `Ubuntu 24.04.4 LTS`
- Architecture: `aarch64`
- Kernel at setup: `6.17.0-1011-oracle`
- SSH user: `ubuntu`

Oracle networking must allow inbound TCP:

- `22` for SSH
- `80` for HTTP and Let's Encrypt validation
- `443` for HTTPS

The VM also has local `iptables` rules, documented below.

## DNS records

DNS is managed in Porkbun for `snadly.com` and shows "DNS Powered by Cloudflare".

Current web records:

| Type | Host | Value | TTL |
| --- | --- | --- | --- |
| A | `snadly.com` | `140.238.196.85` | `600` |
| A | `www.snadly.com` | `140.238.196.85` | `600` |

Current email forwarding records:

| Type | Host | Value | Priority | TTL |
| --- | --- | --- | --- | --- |
| MX | `snadly.com` | `fwd1.porkbun.com` | `10` | `600` |
| MX | `snadly.com` | `fwd2.porkbun.com` | `20` | `600` |
| TXT | `snadly.com` | `v=spf1 include:_spf.porkbun.com ~all` | n/a | `600` |

Existing `_acme-challenge.snadly.com` TXT records at setup time:

- `d_E-FTS-VRYjMXeBFUv-QrtbX3BEL1JtXDMVkpdN0yo`
- `ZmprJpuTRM56TuOOp5EnQFKjs3tXrHVib3wwafjLLVA`

The active Let's Encrypt setup uses nginx HTTP validation, so these TXT records were not created by the certbot setup described here. Keep them unless their owner/purpose is confirmed.

## Runtime versions

Installed on the Oracle VM at setup time:

- Node.js: `v22.23.0`
- npm: `10.9.8`
- pnpm: `10.32.1`
- PM2: `7.0.1`
- nginx: `1.24.0 (Ubuntu)`
- certbot: `2.9.0`

## Application process

PM2 app name: `snadly-website`

`ecosystem.config.cjs`:

```js
module.exports = {
  apps: [{
    name: 'snadly-website',
    script: 'dist/server/entry.mjs',
    cwd: '/opt/snadly-website',
    env: {
      HOST: '127.0.0.1',
      PORT: 4322,
      NODE_ENV: 'production',
    },
  }],
};
```

The app listens only on `127.0.0.1:4322`. nginx is the public reverse proxy.

Useful PM2 commands:

```sh
pm2 status
pm2 logs snadly-website
pm2 restart snadly-website
pm2 save
```

PM2 boot persistence:

- systemd unit: `pm2-ubuntu`
- service state at setup: `enabled`, `active`

If PM2's systemd service fails with a PID/protocol ownership issue after setup, reset it:

```sh
pm2 save
pm2 kill
sudo systemctl reset-failed pm2-ubuntu || true
sudo systemctl start pm2-ubuntu
systemctl is-active pm2-ubuntu
```

## nginx configuration

File: `/etc/nginx/sites-available/snadly-website`

Certbot manages the SSL directives and HTTP redirects.

```nginx
server {
    server_name snadly.com www.snadly.com;

    location / {
        proxy_pass http://127.0.0.1:4322;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/snadly.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/snadly.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = www.snadly.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    if ($host = snadly.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot

    listen 80;
    listen [::]:80;
    server_name snadly.com www.snadly.com;
    return 404; # managed by Certbot
}
```

Useful nginx commands:

```sh
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl status nginx --no-pager -l
```

## TLS certificates

Certificate:

- Name: `snadly.com`
- Domains: `snadly.com`, `www.snadly.com`
- Key type: `ECDSA`
- Certificate path: `/etc/letsencrypt/live/snadly.com/fullchain.pem`
- Private key path: `/etc/letsencrypt/live/snadly.com/privkey.pem`
- Expiry at setup: `2026-09-21 22:54:18+00:00`

Renewal:

- systemd timer: `certbot.timer`
- state at setup: `enabled`, `active`
- Dry run verified successfully with `sudo certbot renew --dry-run`

Useful certbot commands:

```sh
sudo certbot certificates
sudo certbot renew --dry-run
systemctl status certbot.timer --no-pager -l
```

## Firewall

The Oracle Ubuntu image had an `iptables` reject rule that blocked public HTTP until explicit rules were added before the reject.

Current `INPUT` chain:

```sh
-P INPUT ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
```

Rules are persisted with `iptables-persistent` / `netfilter-persistent`.

To recreate the local firewall rules:

```sh
sudo iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT 2>/dev/null || sudo iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
sudo iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT 2>/dev/null || sudo iptables -I INPUT 6 -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
sudo netfilter-persistent save
```

## Deploy workflow

GitHub Actions deploy file: `.github/workflows/deploy.yml`

```yaml
name: Deploy

on:
  push:
    branches: [master]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploy on the server
        uses: appleboy/ssh-action@v1
        with:
          host: ${{ secrets.DEPLOY_HOST }}
          username: ${{ secrets.DEPLOY_USER }}
          key: ${{ secrets.DEPLOY_SSH_KEY }}
          script: bash /opt/snadly-website/deploy/deploy.sh
```

Server deploy script: `/opt/snadly-website/deploy/deploy.sh`

```sh
#!/usr/bin/env bash
set -euo pipefail

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
```

Manual deploy command from the server:

```sh
bash /opt/snadly-website/deploy/deploy.sh
```

Manual deploy command from a machine with SSH access:

```sh
ssh -i /path/to/oracle-key ubuntu@140.238.196.85 'bash /opt/snadly-website/deploy/deploy.sh'
```

## Clean rebuild steps

These steps assume a fresh Ubuntu 24.04 Oracle VM with inbound ports `22`, `80`, and `443` allowed in Oracle networking.

1. SSH into the instance:

```sh
ssh -i /path/to/oracle-key ubuntu@SERVER_PUBLIC_IP
```

2. Install OS packages, Node.js 22, pnpm, PM2, nginx, and certbot:

```sh
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg git nginx
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g pnpm@10.32.1 pm2
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y certbot python3-certbot-nginx iptables-persistent
```

3. Clone and build the app:

```sh
sudo mkdir -p /opt
sudo git clone https://github.com/snadly/snadly-website.git /opt/snadly-website
sudo chown -R ubuntu:ubuntu /opt/snadly-website
cd /opt/snadly-website
pnpm install --frozen-lockfile
pnpm build
```

4. Start the app with PM2:

```sh
cd /opt/snadly-website
pm2 startOrReload ecosystem.config.cjs --update-env
pm2 save
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu
```

5. Configure nginx before TLS:

```sh
sudo tee /etc/nginx/sites-available/snadly-website >/dev/null <<'EOF'
server {
    listen 80;
    listen [::]:80;
    server_name snadly.com www.snadly.com;

    location / {
        proxy_pass http://127.0.0.1:4322;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOF

sudo rm -f /etc/nginx/sites-enabled/default
sudo ln -sf /etc/nginx/sites-available/snadly-website /etc/nginx/sites-enabled/snadly-website
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx
```

6. Open and persist local VM firewall rules:

```sh
sudo iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT 2>/dev/null || sudo iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
sudo iptables -C INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT 2>/dev/null || sudo iptables -I INPUT 6 -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
sudo netfilter-persistent save
```

7. Point DNS records at the server:

```text
A  snadly.com      SERVER_PUBLIC_IP
A  www.snadly.com  SERVER_PUBLIC_IP
```

8. Request TLS after DNS resolves:

```sh
sudo certbot --nginx --non-interactive --agree-tos --redirect --email admin@snadly.com -d snadly.com -d www.snadly.com
sudo nginx -t
sudo systemctl reload nginx
sudo certbot renew --dry-run
```

9. Create GitHub Actions deploy key:

```sh
ssh-keygen -t ed25519 -N '' -C 'github-actions-snadly-website' -f ./snadly-website-actions-ed25519
```

Append `./snadly-website-actions-ed25519.pub` to `/home/ubuntu/.ssh/authorized_keys` on the server. Store the private key in GitHub as `DEPLOY_SSH_KEY`; do not commit it.

Set the GitHub Actions secrets:

```sh
gh secret set DEPLOY_HOST --repo snadly/snadly-website --body 'SERVER_PUBLIC_IP'
gh secret set DEPLOY_USER --repo snadly/snadly-website --body 'ubuntu'
gh secret set DEPLOY_SSH_KEY --repo snadly/snadly-website < ./snadly-website-actions-ed25519
rm -f ./snadly-website-actions-ed25519 ./snadly-website-actions-ed25519.pub
```

## Verification commands

Run from any machine:

```sh
dig +short snadly.com A @1.1.1.1
dig +short www.snadly.com A @1.1.1.1
curl -I https://snadly.com/
curl -I https://www.snadly.com/
curl -s https://snadly.com/ | grep 'SNADLY'
```

Run on the server:

```sh
cd /opt/snadly-website && git log -1 --oneline --decorate
pm2 status
systemctl is-active nginx
systemctl is-active pm2-ubuntu
systemctl is-active certbot.timer
sudo nginx -t
sudo certbot certificates
sudo ss -tulpn | grep -E ':(22|80|443|4322)\b'
sudo iptables -S INPUT
```
