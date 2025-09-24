### Étape 1 — Prise en main
1. Placez-vous dans le dossier de travail :
   ```bash
   cd /root/ex1
   ls -la
   ```
2. Affichez le contenu :
   ```bash
   tree -a
   cat assets/Dockerfile
   cat assets/app/package.json
   cat assets/app/server.js
   ```
3. Essayez un build initial (il doit échouer) :
   ```bash
   docker build -t healthz:broken assets
   ```
4. Lisez attentivement les erreurs.
