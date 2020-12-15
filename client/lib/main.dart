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
        appBar: AppBar(
          title: Text('Covid'),
        ),
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
                          // Add TextFormFields and ElevatedButton here.
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Processing Data')));
                                }
                              },
                              child: Text("LOGIN"),
                            ),
                          )
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
