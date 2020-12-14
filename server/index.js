const express = require("express");
const app = express();
const bodyParser = require("body-parser");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

const firebase = require("firebase");
const firebaseConfig = {
  apiKey: "AIzaSyDId3Lb9Uj89zyPHn5O2q7Q4DRUGtCZ72g",
  authDomain: "covid-reporter-ae343.firebaseapp.com",
  projectId: "covid-reporter-ae343",
  storageBucket: "covid-reporter-ae343.appspot.com",
  messagingSenderId: "230415734880",
  appId: "1:230415734880:web:b0b3ea6776f414586f8b05",
  measurementId: "G-VE616P02SS",
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

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
