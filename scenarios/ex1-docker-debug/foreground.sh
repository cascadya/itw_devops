#!/usr/bin/env bash

# Exécute le script d'initialisation
env-init.sh

# Créer le répertoire de travail pour l'utilisateur
mkdir -p /root/ex1/app

# Message pour l'utilisateur
printf "\n✅ Environnement prêt. Les fichiers de l'exercice se trouvent dans /root/ex1\n"
printf "Voici l'arborescence :\n"
tree /root/ex1