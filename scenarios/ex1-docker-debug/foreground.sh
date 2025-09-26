#!/usr/bin/env bash

printf "✅ Environnement prêt.\n"
printf "Les fichiers pour l'exercice ont été copiés dans /root/ex1\n\n"
printf "Voici l'arborescence :\n"

# À ce stade, 'tree' doit exister car env-init.sh (lancé par courseData) a déjà terminé son exécution.
tree /root/ex1
