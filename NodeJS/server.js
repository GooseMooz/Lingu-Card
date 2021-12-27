const express = require('express');
const wordRoutes = require('./src/words/routes.js');

const app = express();
const port = 3000;

app.use(express.json());

app.get("/", (req, res) => {
    res.send("Hello world!");
})

app.use('/api/v1/words', wordRoutes);

app.listen(port, () => console.log(`App listening on port ${port}`));