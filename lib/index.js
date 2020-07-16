import express from 'express';

const app = express();
const port = 3000;

app.get('/', (req, res) => res.status(200).send(`NODE_ENV is ${process.env.NODE_ENV}!`));

const server = app.listen(port, () => console.log(`Example app listening at http://localhost:${port}`));

export default server;
