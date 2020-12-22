import 'package:client/components/app/contactScreen.dart';
import 'package:client/components/app/newWorldScreen.dart';
import 'package:client/components/app/worldCovid.dart';
import 'package:client/components/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          backgroundColor: Color(0xFF3B3D58),
          title: currentIndex == 0 ? Text("Covid score") : Text("Contact us"),
          actions: [currentIndex == 1 ? LogoutIcon() : Container()],
        ),
        body: currentIndex == 0 ? NewWorld() : ContactScreen(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Color(0xFF3B3D58),
              primaryColor: Colors.white,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.grey))),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              print(index);
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(label: 'World', icon: Icon(Icons.public)),
              BottomNavigationBarItem(
                  label: 'Contact', icon: Icon(Icons.construction))
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutIcon extends StatelessWidget {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  const LogoutIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString("loginType") == "Google") {
          _googleSignIn.disconnect();

          await prefs.setString("isAuthentication", "False");
          await prefs.setString("name", null);
          await prefs.setString("email", null);
          await prefs.setString("loginType", null);
        }
        if (prefs.getString("loginType") == "Facebook") {
          await facebookSignIn.logOut();

          await prefs.setString("isAuthentication", "False");
          await prefs.setString("name", null);
          await prefs.setString("email", null);
          await prefs.setString("loginType", null);
        }

        return Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(pageBuilder: (BuildContext context,
                Animation animation, Animation secondaryAnimation) {
              return Login();
            }, transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return new SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            }),
            (route) => false);
      },
      child: Container(child: Icon(Icons.logout)),
    );
  }
}
