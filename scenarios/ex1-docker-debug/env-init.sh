#!/usr/bin/env bash
set -euo pipefail

# Préparation du terrain
echo "[init] Installing apt dependencies..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >/dev/null
apt-get install -y docker.io curl tree >/dev/null

echo "[init] Done. Environment is ready."