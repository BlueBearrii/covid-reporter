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
              child: Text("Test Flex 1"),
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
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text('Processing Data')));
                                    } else {
                                      printLogFunction();
                                    }
                                  },
                                  child: Text("LOGIN"),
                                ),
                              ))
                        ])),
                    SizedBox(
                        width: double.infinity,
                        child: SignInButton(
                          Buttons.Google,
                          onPressed: () {},
                        )),
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
