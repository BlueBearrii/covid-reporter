import 'package:client/components/login/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Register extends StatelessWidget {
  final _formRegister = GlobalKey<FormState>();

  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    void registerFunction() async {
      var url =
          'https://us-central1-covid-reporter-ae343.cloudfunctions.net/api/register';
      await http.post(url, body: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      }).then((value) {
        var getStatus = convert.jsonDecode(value.body);
        //print(getStatus);
        if (getStatus['status'] == "success") {
          Navigator.pop(context);
        }
      });
    }

    bool emailRegExp(String em) {
      RegExp regExp = new RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return regExp.hasMatch(em);
    }

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar:
            AppBar(backgroundColor: Color(0xFF3B3D58), title: Text("REGISTER")),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _formRegister,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Firstname",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF3B3D58)))),
                      TextFormField(
                        onChanged: (value) => {firstName = value},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter your firstname',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Lastname",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF3B3D58)))),
                      TextFormField(
                        onChanged: (value) => {lastName = value},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your lastname';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter your lastname',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Email address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF3B3D58)))),
                      TextFormField(
                        onChanged: (value) => {email = value},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          } else {
                            if (!emailRegExp(value)) return 'Invalid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF3B3D58)))),
                      TextFormField(
                        onChanged: (value) => {password = value},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          } else {
                            if (value.length < 7)
                              return 'Password must be more 6 character';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text("Confirm password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Color(0xFF3B3D58)))),
                      TextFormField(
                        onChanged: (value) => {confirmPassword = value},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter confirm password';
                          } else {
                            if (value != password)
                              return 'Confirm password not match';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: RaisedButton(
                          color: Color(0xFF3B3D58),
                          onPressed: () {
                            if (_formRegister.currentState.validate()) {
                              registerFunction();
                            }
                          },
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
