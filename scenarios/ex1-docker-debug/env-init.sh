#!/usr/bin/env bash
set -euo pipefail

echo "[init] Starting full environment setup..."

# 1. Créer la structure de dossiers nécessaire
echo "[init] Creating workspace directory /root/ex1/app..."
mkdir -p /root/ex1/app

# 2. Installer les dépendances
echo "[init] Installing dependencies (docker, curl, tree)..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >/dev/null
apt-get install -y docker.io curl tree >/dev/null

# 3. Créer les fichiers de l'exercice directement ici
echo "[init] Creating exercise files..."

# Dockerfile cassé
cat > /root/ex1/Dockerfile <<'EOF'
FROM node:18-alpine
# Problèmes : mauvais ordre des copies, install avant package.json, mauvaise CMD
WORKDIR /usr/src/app
COPY . .
RUN npm install --production
CMD ["npm", "run", "serve"]
EOF

# App Node - package.json
cat > /root/ex1/app/package.json <<'EOF'
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

# App Node - server.js
cat > /root/ex1/app/server.js <<'EOF'
import express from 'express'
const app = express()
const PORT = process.env.PORT || 3000
app.get('/healthz', (_req, res) => res.status(200).json({ status: 'ok' }))
app.listen(PORT, '0.0.0.0', () => console.log(`listening on ${PORT}`))
EOF

echo "[init] Setup complete. Environment is ready."