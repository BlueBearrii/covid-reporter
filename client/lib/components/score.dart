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

  int _globalConfirmed = 0;
  int _globalDeaths = 0;

  Future<List> callAPI() async {
    var apiThai = 'https://covid19.th-stat.com/api/open/today';
    var apiGlobal = 'https://covid19.mathdro.id/api';

    await http.get(apiThai).then((value) {
      var getState = convert.jsonDecode(value.body);
      _confirmed = getState["Confirmed"];
      _deaths = getState["Deaths"];
      _hospitalized = getState["Hospitalized"];
    });

    await http.get(apiGlobal).then((value) {
      var getState = convert.jsonDecode(value.body);
      _globalConfirmed = getState['confirmed']['value'];
      _globalDeaths = getState['deaths']['value'];
      print(getState['deaths']['value']);
    });

    var list = [
      _confirmed,
      _deaths,
      _hospitalized,
      _globalConfirmed,
      _globalDeaths
    ];
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
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Container(
                  color: Colors.blueAccent,
                  child: Center(
                      child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: double.infinity,
                                            color: Colors.amber,
                                            child: Text("Global Laabel"),
                                          )),
                                      Expanded(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Container(
                                                    color: Colors.greenAccent,
                                                    child: Center(
                                                      child: Text(snapshot
                                                          .data[3]
                                                          .toString()),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Container(
                                                    color: Colors.greenAccent,
                                                    child: Center(
                                                      child: Text(snapshot
                                                          .data[4]
                                                          .toString()),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Colors.black12,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              width: double.infinity,
                                              child: Text("Thailand Label"),
                                            )),
                                        Expanded(
                                          flex: 3,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      color: Colors.greenAccent,
                                                      child: Center(
                                                        child: Text(snapshot
                                                            .data[0]
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      color: Colors.greenAccent,
                                                      child: Center(
                                                        child: Text(snapshot
                                                            .data[1]
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      color: Colors.greenAccent,
                                                      child: Center(
                                                        child: Text(snapshot
                                                            .data[2]
                                                            .toString()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
