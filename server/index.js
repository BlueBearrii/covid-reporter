const express = require("express");
const app = express();
const bodyParser = require("body-parser");

// Initialize Firebase
const firebase = require("firebase");
const firebaseConfig = require("./config/firebaseConfig");
require("firebase/firestore");
firebaseConfig.setup();

// Body-Parser
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.post("/api/auth/email", (req, res) => {
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

const PORT = 3000;

app.listen(PORT, (req, res) => {
  console.log(`Server is running on port : ${PORT}`);
});
