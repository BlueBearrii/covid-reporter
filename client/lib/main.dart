import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() => runApp(MyApp());

void printLogFunction() {
  print("Function is work");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text("Space for Icon"),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                  child: Center(
                      child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // =================================================== Form layout ===================================================
                    Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Email address"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Password"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: Container(
                                margin: EdgeInsets.only(top: 30.0, bottom: 15),
                                child: RaisedButton(
                                  color: Colors.red[400],
                                  textColor: Colors.white,
                                  child: Text("LOGIN"),
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Waiting to login')));
                                    } else {
                                      printLogFunction();
                                    }
                                  },
                                ),
                              ))
                        ])),

                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Center(
                                    child: Text(
                              'Register account',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ))),
                          ),
                          Expanded(
                            child: Container(
                                child: Center(
                                    child: Text(
                              'Forgot password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ))),
                          ),
                        ],
                      ),
                    ),

                    // =================================================== Google button ===================================================
                    SizedBox(
                        width: double.infinity,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                        )),

                    // =================================================== Facebook button ===================================================
                    SizedBox(
                        width: double.infinity,
                        child: SignInButton(
                          Buttons.Facebook,
                          onPressed: () {},
                        )),
                  ],
                ),
              )))),
        ],
      ),
    );
  }
}
