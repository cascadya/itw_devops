#!/usr/bin/env bash

echo "--- Début du script foreground.sh ---"

if [ -f /root/init.log ]; then
  echo ">>> Le fichier de log /root/init.log a été trouvé. Voici son contenu :"
  cat /root/init.log
else
  echo ">>> ERREUR : Le script env-init.sh n'a PAS démarré, le fichier /root/init.log est introuvable."
fi

echo "--- Fin du log. Tentative de vérification de l'environnement ---"

# On retente la commande tree pour voir si elle a été installée
tree /root/ex1