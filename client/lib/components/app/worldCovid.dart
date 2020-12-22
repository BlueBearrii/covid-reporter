import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class WorldScore extends StatefulWidget {
  const WorldScore({Key key}) : super(key: key);

  @override
  _WorldScoreState createState() => _WorldScoreState();
}

class _WorldScoreState extends State<WorldScore> {
  int _confirmed = 0;
  int _deaths = 0;
  int _hospitalized = 0;

  int _globalConfirmed = 0;
  int _globalDeaths = 0;

  Future<List> callAPI() async {
    var apiThai = 'https://corona.lmao.ninja/v2/countries/thailand';
    var apiGlobal = 'https://covid19.mathdro.id/api';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await http.get(apiThai).then((value) {
      var getState = convert.jsonDecode(value.body);
      _confirmed = getState["cases"];
      _deaths = getState["deaths"];

      //_hospitalized = getState["Hospitalized"];
    }).catchError((onError) {
      _confirmed = 0;
      _deaths = 0;
      _hospitalized = 0;
    });

    await http.get(apiGlobal).then((value) {
      var getState = convert.jsonDecode(value.body);
      _globalConfirmed = getState['confirmed']['value'];
      _globalDeaths = getState['deaths']['value'];
      print(getState['deaths']['value']);
    });

    var list = [
      _globalConfirmed,
      _globalDeaths,
      _confirmed,
      _deaths,
      _hospitalized,
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        // backgroundColor: Colors.white,
        body: FutureBuilder(
      future: callAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return Container(
            padding: EdgeInsets.only(
                top: (screenWidth * 2) / 100,
                left: (screenWidth * 2) / 100,
                right: (screenHeight * 2) / 100),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "AROUND THE WORLD",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Color(0xFF3B3D58)),
                          )),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return CustomCardScore(
                                dataInput: snapshot.data[index].toString(),
                                index: index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "THAILAND",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Color(0xFF3B3D58)),
                          )),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            index = index + 2;
                            return CustomCardScore(
                                dataInput: snapshot.data[index].toString(),
                                index: index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        else if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
      },
    ));
  }
}

// ignore: must_be_immutable
class CustomCardScore extends StatelessWidget {
  CustomCardScore({
    Key key,
    @required this.dataInput,
    this.index,
  }) : super(key: key);
  final String dataInput;
  final int index;

  var lebelLists = [
    "Coronavirus Cases",
    "Deaths",
    "Coronavirus Cases",
    "Deaths",
    "Hospital"
  ];

  var colorLists = [
    "Colors.amber",
    "Deaths",
    "Coronavirus Cases",
    "Deaths",
    "Hospital"
  ];

  List<Map<String, IconData>> _categories = [
    {
      'icon': Icons.directions_run,
    },
    {
      'icon': Icons.hotel,
    },
    {
      'icon': Icons.directions_run,
    },
    {
      'icon': Icons.hotel,
    },
    {
      'icon': Icons.healing,
    },
  ];
  String setLebel() {
    return lebelLists[index];
  }

  Color _getColorTitle(int index) {
    if (index == 0 || index == 2) return Colors.redAccent;
    if (index == 1 || index == 3) return Colors.black54;
    if (index == 4) return Colors.blueAccent;
  }

  Color _getColorBackground(int index, int nColor) {
    if (index == 0 || index == 2) if (nColor == 1)
      return Colors.purple;
    else
      return Colors.red;
    if (index == 1 || index == 3) if (nColor == 1)
      return Colors.black54;
    else
      return Colors.black;
    if (index == 4) if (nColor == 1)
      return Colors.greenAccent;
    else
      return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 5),
          )
        ],
        color: Colors.white,
      ),
      height: (screenHeight * 10) / 100,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            _getColorBackground(index, 1),
                            _getColorBackground(index, 2)
                          ])),
                  child: Center(
                      child: Icon(
                    _categories[index]['icon'],
                    color: Colors.white,
                    size: 50,
                  )))),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(width: 0.2))),
                          child: Center(
                              child: Text(
                            setLebel(),
                            style: TextStyle(
                              color: _getColorTitle(index),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )))),
                  Expanded(
                      child: Container(
                          child: Center(
                              child: Text(
                    dataInput,
                    style: TextStyle(
                      color: _getColorTitle(index),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
