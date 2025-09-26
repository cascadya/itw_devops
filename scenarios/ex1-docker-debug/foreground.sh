#!/usr/bin/env bash
set -euo pipefail

# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# bash "${SCRIPT_DIR}/env-init.sh"
# L'appel au script d'initialisation est mieux géré par Killercoda directement.
# On va le lancer via la section "intro" du index.json.

# Message pour l'utilisateur
printf "\n✅ Environnement prêt. Les fichiers de l'exercice se trouvent dans /root/ex1\n"
printf "Voici l'arborescence des fichiers :\n"

# La commande 'tree' est parfaite pour vérifier que les assets ont bien été copiés.
tree /root/ex1