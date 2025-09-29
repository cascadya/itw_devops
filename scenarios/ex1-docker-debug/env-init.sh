#!/usr/bin/env bash
# Redirige TOUTE la sortie (stdout et stderr) de ce script vers un fichier log
exec > /root/init.log 2>&1

set -euo pipefail

echo "[DEBUG] env-init.sh a démarré."
date

echo "[DEBUG] Étape 1: Création des dossiers..."
mkdir -p /root/ex1/app
echo "[DEBUG] Dossiers créés."

echo "[DEBUG] Étape 2: Installation des dépendances (apt-get)..."
export DEBIAN_FRONTEND=noninteractive

echo "[DEBUG] Lancement de apt-get update..."
apt-get update -y
echo "[DEBUG] apt-get update terminé."

# On installe les paquets un par un pour isoler le coupable
echo "[DEBUG] Installation de 'curl'..."
apt-get install -y curl
echo "[DEBUG] 'curl' installé."

echo "[DEBUG] Installation de 'tree'..."
apt-get install -y tree
echo "[DEBUG] 'tree' installé."

echo "[DEBUG] Installation de 'docker.io'..."
apt-get install -y docker.io
echo "[DEBUG] 'docker.io' installé."

echo "[DEBUG] Toutes les dépendances sont installées."


echo "[DEBUG] Étape 3: Création des fichiers..."
cat > /root/ex1/Dockerfile <<'EOF'
FROM node:18-alpine
WORKDIR /usr/src/app
COPY . .
RUN npm install --production
CMD ["npm", "run", "serve"]
EOF

cat > /root/ex1/app/package.json <<'EOF'
{
  "name": "healthz-app", "version": "1.0.0", "private": true,
  "scripts": { "start": "node server.js" },
  "dependencies": { "express": "^4.19.2" },
  "type": "module"
}
EOF

cat > /root/ex1/app/server.js <<'EOF'
import express from 'express'
const app = express()
const PORT = process.env.PORT || 3000
app.get('/healthz', (_req, res) => res.status(200).json({ status: 'ok' }))
app.listen(PORT, '0.0.0.0', () => console.log(`listening on ${PORT}`))
EOF
echo "[DEBUG] Fichiers créés."


echo "[DEBUG] env-init.sh a terminé avec succès."
date