import 'package:client/components/app/mainScreen.dart';
import 'package:client/components/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: LoginScreen(),
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  // Facebook Login
  static final FacebookLogin facebookSignIn = new FacebookLogin();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create variable for email and password
  String email;
  String password;

  @override
  Widget build(context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Get value from input
    final _formKey = GlobalKey<FormState>();

    //=========================================================================== Google ===========================================================================

    Future<void> _handleSignInGoogle() async {
      try {
        await _googleSignIn.signIn().then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", value.email);
          prefs.setString("name", value.displayName);
          prefs.setString("isAuthentication", "True");
          prefs.setString("loginType", "Google");
          print(value);
        }).then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(),
              ),
              (route) => false,
            ));
      } catch (error) {
        print(error);
      }
    }

    //=========================================================================== Facebook ===========================================================================

    void _showMessage(String message) {
      setState(() {});
    }

    Future<Null> _handleSignInFacebook() async {
      final FacebookLoginResult result =
          await LoginScreen.facebookSignIn.logIn(['email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          _showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("isAuthentication", "True");
          prefs.setString("loginType", "Facebook");

          return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MainScreen(),
            ),
            (route) => false,
          );
          break;
        case FacebookLoginStatus.cancelledByUser:
          _showMessage('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          _showMessage('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }

    //=========================================================================== Email&Password ===========================================================================

    void _handleSignInEmailAndPassword() async {
      var url =
          'https://us-central1-covid-reporter-ae343.cloudfunctions.net/api/auth';
      await http.post(url, body: {"email": email, "password": password}).then(
          (value) async {
        var getStatus = convert.jsonDecode(value.body);
        //print(getStatus['status']);
        String uid = getStatus["message"]['user']['uid'];
        String email = getStatus["message"]['user']['email'];

        print("UID : $uid, Email : $email");
        if (getStatus['status'] == "succes") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("isAuthentication", "True");
          prefs.setString("uid", uid);
          prefs.setString("email", email);
          prefs.setString("loginType", "EmailAndPassword");
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      }).catchError((onError) => print("Errors : $onError"));
    }

    void _onClickRegister() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));
    }

    void _onClickForgotpassword() {
      print("Route to forgotten()");
    }

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: Center(
                    child: Text("Space for Icon"),
                  ),
                ),
                Container(
                    child: Center(
                        child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: (screenWidth * 5) / 100),
                  child: Column(
                    children: [
                      // =================================================== Form layout ===================================================
                      Form(
                          key: _formKey,
                          child: Column(children: [
                            TextFormField(
                              onChanged: (value) => {email = value},
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
                              obscureText: true,
                              onChanged: (value) => {password = value},
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
                                  margin: EdgeInsets.only(
                                      top: (screenHeight * 3) / 100,
                                      bottom: (screenHeight * 4) / 100),
                                  child: RaisedButton(
                                    color: Colors.red[400],
                                    textColor: Colors.white,
                                    child: Text("LOGIN"),
                                    padding: EdgeInsets.symmetric(
                                        vertical: (screenWidth * 2) / 100),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _handleSignInEmailAndPassword();
                                      }
                                    },
                                  ),
                                ))
                          ])),

                      Container(
                        margin:
                            EdgeInsets.only(bottom: (screenHeight * 5) / 100),
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
                            onPressed: () {
                              _handleSignInGoogle();
                            },
                          )),

                      // =================================================== Facebook button ===================================================
                      SizedBox(
                          width: double.infinity,
                          child: SignInButton(
                            Buttons.Facebook,
                            onPressed: () {
                              _handleSignInFacebook();
                            },
                          )),
                    ],
                  ),
                ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
