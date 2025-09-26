#!/usr/bin/env bash
set -euo pipefail

# Trouve le répertoire où se trouve ce script (la racine du scénario)
# Cela le rend indépendant de l'endroit où Killercoda le lance.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Exécute le script d'initialisation qui se trouve au même endroit
# Le script env-init.sh se chargera de créer /root/ex1 etc.
bash "${SCRIPT_DIR}/env-init.sh"

# Message pour l'utilisateur
printf "\n✅ Environnement prêt. Suivez les étapes pour commencer l'exercice.\n"
