#!/usr/bin/env bash
set -euo pipefail

echo "[init] Starting environment setup..."

# 1. Créer la structure de dossiers nécessaire
echo "[init] Creating workspace directory /root/ex1/app..."
mkdir -p /root/ex1/app

# 2. Installer les dépendances
echo "[init] Installing dependencies (docker, curl, tree)..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >/dev/null
apt-get install -y docker.io curl tree >/dev/null

echo "[init] Setup complete. Environment is ready."
