#!/usr/bin/env bash
set -euo pipefail

echo "[init] Installing dependencies (docker, curl, tree)..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -y >/dev/null
apt-get install -y docker.io curl tree >/dev/null
echo "[init] Dependencies installed."
