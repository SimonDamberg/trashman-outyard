const express = require('express')
const app = express()
const port = 8000

app.post('/score', (req, res) => {
    console.log(req.query)
})

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})