#!/usr/bin/env bash
set -euo pipefail

# Le fichier /root/.setup_done sert de "drapeau". S'il existe, l'installation est déjà faite.
if [ ! -f /root/.setup_done ]; then
    echo "--- Première exécution : Lancement de la configuration de l'environnement ---"

    # 1. Installation des dépendances
    echo "[SETUP] Installation des paquets (cela peut prendre un moment)..."
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y docker.io curl tree
    echo "[SETUP] Paquets installés."

    # 2. Création de l'arborescence et des fichiers
    echo "[SETUP] Création des fichiers de l'exercice..."
    mkdir -p /root/ex1/app

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
    echo "[SETUP] Fichiers créés."

    # 3. Créer le fichier drapeau pour ne pas relancer ce bloc
    touch /root/.setup_done
    echo "--- Configuration terminée ---"
    echo
fi

# Cette partie s'exécutera à chaque fois, mais après la configuration.
printf "✅ Environnement prêt.\n"
printf "Voici l'arborescence des fichiers dans /root/ex1 :\n"
tree /root/ex1