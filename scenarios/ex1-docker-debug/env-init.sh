#!/usr/bin/env bash
set -euo pipefail

# Préparation du terrain
echo "[init] Installing apt deps..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >/dev/null
apt-get install -y docker.io curl tree >/dev/null

# Workspace
echo "[init] Setting up workspace..."
mkdir -p /root/ex1/assets/app

# Dockerfile cassé déposé dans assets
cat > /root/ex1/assets/Dockerfile <<'EOF'
FROM node:18-alpine
# Problèmes : mauvais ordre des copies, install avant package.json, mauvaise CMD
WORKDIR /usr/src/app
COPY . .
RUN npm install --production
CMD ["npm", "run", "serve"]
EOF

# App Node
cat > /root/ex1/assets/app/package.json <<'EOF'
{
  "name": "healthz-app",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.19.2"
  },
  "type": "module"
}
EOF

cat > /root/ex1/assets/app/server.js <<'EOF'
import express from 'express'
const app = express()
const PORT = process.env.PORT || 3000
app.get('/healthz', (_req, res) => res.status(200).json({ status: 'ok' }))
app.listen(PORT, '0.0.0.0', () => console.log(`listening on ${PORT}`))
EOF

echo "[init] Done. Files are in /root/ex1"
