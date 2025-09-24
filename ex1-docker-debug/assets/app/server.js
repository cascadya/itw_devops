import express from 'express'
const app = express()
const PORT = process.env.PORT || 3000
app.get('/healthz', (_req, res) => res.status(200).json({ status: 'ok' }))
app.listen(PORT, '0.0.0.0', () => console.log(`listening on ${PORT}`))
