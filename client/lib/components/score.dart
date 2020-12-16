import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        //resizeToAvoidBottomInset: false,
        body: ScoreScreen(),
      ),
    );
  }
}

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  int _confirmed = 0;
  int _deaths = 0;
  int _hospitalized = 0;

  Future<List> callAPI() async {
    var apiThai = 'https://covid19.th-stat.com/api/open/today';
    await http.get(apiThai).then((value) {
      var getState = convert.jsonDecode(value.body);
      _confirmed = getState["Confirmed"];
      _deaths = getState["Deaths"];
      _hospitalized = getState["Hospitalized"];

      print(getState['Confirmed'].runtimeType);
    });
    var list = [_confirmed, _deaths, _hospitalized];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callAPI();
        },
      ),
      body: FutureBuilder(
          future: callAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Container(
                  child: Center(child: Text(snapshot.data[0].toString())));
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
