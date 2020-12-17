const express = require("express");
const app = express();
const bodyParser = require("body-parser");

// Initialize Firebase
const firebase = require("firebase");
require("firebase/firestore");
firebase.initializeApp({
  apiKey: "AIzaSyDId3Lb9Uj89zyPHn5O2q7Q4DRUGtCZ72g",
  authDomain: "covid-reporter-ae343.firebaseapp.com",
  projectId: "covid-reporter-ae343",
  storageBucket: "covid-reporter-ae343.appspot.com",
  messagingSenderId: "230415734880",
  appId: "1:230415734880:web:b0b3ea6776f414586f8b05",
  measurementId: "G-VE616P02SS",
});

// Body-Parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post("/api/auth", (req, res) => {
  let user = {
    email: req.body.email,
    password: req.body.password,
  };

  firebase
    .auth()
    .signInWithEmailAndPassword(user.email, user.password)
    .then((user) => {
      return res.json({ message: user, status: "succes" });
    })
    .catch((err) => {
      return res.json({ message: err, status: "unsucces" });
    });
});

app.post("/api/register", (req, res) => {
  let db = firebase.firestore();
  let user = {
    firstName: req.body.firstName,
    lastName: req.body.lastName,
    email: req.body.email,
    password: req.body.password,
  };

  // Step 1 Register Email and Password to firebase authentication
  firebase
    .auth()
    .createUserWithEmailAndPassword(user.email, user.password)
    .then((user) => {
      const userId = user.user.uid;

      // Step 2 Add user information to cloud firestore
      db.collection("users")
        .doc(`${userId}`)
        .set({
          firstName: req.body.firstName,
          lastName: req.body.lastName,
          email: req.body.email,
        })
        .then(() => {
          return res.json({ message: userId });
        })
        .catch((err) => {
          return res.json({ errors: err });
        });
    })
    .catch((err) => {
      return res.json({ errors: err });
    });
});

app.post("/api/send-email", (req, res) => {
  return res.json({ message: "Your email was send" });
});

const PORT = 3000;

app.listen(PORT, (req, res) => {
  console.log(`Server is running on port : ${PORT}`);
});
