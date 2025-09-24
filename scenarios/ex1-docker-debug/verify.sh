#!/usr/bin/env bash
set -euo pipefail

# Vérifier qu’un conteneur répond 200 sur /healthz
if ! command -v curl >/dev/null; then
  echo "curl not found"
  exit 1
fi

# Essayer plusieurs ports communs (3000 par défaut)
PORTS=(3000 8080 8000)
for P in "${PORTS[@]}"; do
  if curl -sf "http://localhost:${P}/healthz" | grep -q '"ok"'; then
    echo "OK: /healthz répond sur le port ${P}"
    exit 0
  fi
done

echo "KO: /healthz ne répond pas sur 3000/8080/8000"
exit 1
