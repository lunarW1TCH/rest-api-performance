const express = require('express')

const app = express();
app.use(express.json());

app.get('/get', (_, res) => {
  res.send('Hello World');
});

app.listen(8080);
