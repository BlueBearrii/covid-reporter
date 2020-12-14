const express = require("express");
const app = express();
const bodyParser = require("body-parser");

// Initialize Firebase
const firebase = require("firebase");
const firebaseConfig = require("./config/firebaseConfig");
firebaseConfig.setup();

// Body-Parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post("/api/auth/email", (req, res) => {
  let user = {
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    password: req.body.password,
  };

  console.log(user);
  firebase
    .auth()
    .createUserWithEmailAndPassword(user.email, user.password)
    .then((user) => {
      return res.json({ message: user });
    })
    .catch((err) => {
      return res.json({ errors: `${err}` });
    });
});

const PORT = 3000;

app.listen(PORT, (req, res) => {
  console.log(`Server is running on port : ${PORT}`);
});
