### Étape 2 — Corriger le Dockerfile
**Objectif**: Produire une image fonctionnelle. Indices :
- Vérifier le bon répertoire et l’ordre des copies (`package.json` → `npm install` → code).
- S’assurer que l’app écoute sur `0.0.0.0` et respecte `PORT`.
- Commande de démarrage correcte (`npm start`).

Vous pouvez soit **modifier** le `Dockerfile** existant (`assets/Dockerfile`), soit en créer un autre dans `/root/ex1`.

Exemple minimal (piste, non imposé) :
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY app/package.json ./
RUN npm install --production
COPY app/ ./
ENV PORT=3000
EXPOSE 3000
CMD ["npm", "start"]
```

Build & run :
```bash
docker build -t healthz:fixed .
docker run -d --rm -p 3000:3000 --name app healthz:fixed
sleep 2
curl -i http://localhost:3000/healthz
```
Si vous voyez `200 OK` et `{ "status": "ok" }`, c’est bon. Sinon, consultez les logs :
```bash
docker logs app
```
