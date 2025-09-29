#!/usr/bin/env bash
exec > /root/init.log 2>&1

# On active le mode strict, MAIS on va le désactiver localement pour la commande qui échoue
set -euo pipefail

echo "[DEBUG] env-init.sh a démarré."
date

echo "[DEBUG] Étape 1: Création des dossiers..."
mkdir -p /root/ex1/app
echo "[DEBUG] Dossiers créés."

echo "[DEBUG] Étape 2: Installation des dépendances (apt-get)..."
export DEBIAN_FRONTEND=noninteractive

# --- BLOC DE DIAGNOSTIC POUR APT-GET UPDATE ---
echo "[DIAG] Désactivation temporaire du mode 'exit on error'..."
set +e

echo "[DIAG] Exécution de 'apt-get update -y'..."
apt-get update -y
# On capture le code de sortie de la commande précédente
EXIT_CODE=$?

echo "[DIAG] Réactivation du mode 'exit on error'..."
set -e

echo "[DIAG] La commande 'apt-get update -y' a terminé avec le code de sortie : $EXIT_CODE"

if [ $EXIT_CODE -ne 0 ]; then
  echo "[ERREUR] apt-get update a échoué. Le script ne peut pas continuer."
  # On arrête volontairement le script ici, mais après avoir écrit dans le log.
  exit 1
fi
# --- FIN DU BLOC DE DIAGNOSTIC ---


echo "[DEBUG] Installation des paquets un par un..."
apt-get install -y curl
apt-get install -y tree
apt-get install -y docker.io
echo "[DEBUG] Dépendances installées."


echo "[DEBUG] Étape 3: Création des fichiers..."
# ... (le reste du script avec les 'cat > ... <<EOF' reste identique) ...
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