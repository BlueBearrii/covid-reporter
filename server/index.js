const express = require("express");
const app = express();
const bodyParser = require("body-parser");

app.get("/", (req, res) => {
  res.send("Hello everybody");
});

const PORT = 3000;

app.listen(PORT, (req, res) => {
  console.log(`Server is running on port : ${PORT}`);
});
