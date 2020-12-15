import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() => runApp(MyApp());

void _onClickLogin() {
  print("is Login");
}

void _onClickRegister() {
  print("Route to register()");
}

void _onClickForgotpassword() {
  print("Route to forgotten()");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomInset: false,
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text("Space for Icon"),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                  child: Center(
                      child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    // =================================================== Form layout ===================================================
                    Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: "Email address"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
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
                                    _onClickLogin();
                                  },
                                ),
                              ))
                        ])),

                    Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Center(
                                    child: GestureDetector(
                              onTap: () {
                                _onClickRegister();
                              },
                              child: Text(
                                'Register account',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ))),
                          ),
                          Expanded(
                            child: Container(
                                child: Center(
                                    child: GestureDetector(
                              onTap: () {
                                _onClickForgotpassword();
                              },
                              child: Text(
                                'Forgot password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
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
