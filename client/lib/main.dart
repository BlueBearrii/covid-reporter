import 'package:client/components/app/mainScreen.dart';
import 'package:client/components/app/newWorldScreen.dart';
import 'package:client/components/landing/landing.dart';
import 'package:client/components/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Future _loadCredential() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var store = pref.getString("isAuthentication") ?? "False";
    var _email = pref.getString("email") ?? "Null";
    print("Store : $store, Email : $_email");
    return store;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadCredential(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("Snapshot : ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == "False") return Login();
            if (snapshot.data == "True") return NewWorld();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container();
        });
  }
}
