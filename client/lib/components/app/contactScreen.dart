import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formContact = GlobalKey<FormState>();

  String name;

  String email;

  String phone;

  String description;

  void _launchURL() async {
    String urlString =
        "mailto:pongpitch@cybertoryth.com?subject=[COVID] Report application&body=Hello, my name is $name  \n\n\n $description \n\n\n Contact me: \n $name \n Phone : $phone \n Email : $email";
    if (await canLaunch(urlString)) {
      launch(urlString);
    } else {
      print("Can not");
    }
  }

  _getStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = await prefs.get("email");
    name = await prefs.get("name");
    print(email);
    print(name);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool emailRegExp(String em) {
      RegExp regExp = new RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return regExp.hasMatch(em);
    }

    return Scaffold(
      body: FutureBuilder(
        future: _getStorage(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: _formContact,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF3B3D58)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 5),
                                child: TextFormField(
                                  initialValue: name,
                                  textInputAction: TextInputAction.go,
                                  onSaved: (value) => {name = value},
                                  onChanged: (value) {
                                    _formContact.currentState.validate();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your name',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF3B3D58)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 5),
                                child: TextFormField(
                                  textInputAction: TextInputAction.go,
                                  onSaved: (value) => {email = value},
                                  onChanged: (value) {
                                    _formContact.currentState.validate();
                                  },
                                  initialValue: email,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your email';
                                    } else {
                                      if (!emailRegExp(value))
                                        return 'Invalid email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Phone no.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF3B3D58)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 5),
                                child: TextFormField(
                                  textInputAction: TextInputAction.go,
                                  onSaved: (value) => {phone = value},
                                  onChanged: (value) {
                                    _formContact.currentState.validate();
                                  },
                                  validator: (value) {
                                    RegExp pattern = new RegExp(
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)');
                                    if (value.isEmpty) {
                                      return 'Please enter mobile phone no.';
                                    } else {
                                      if (value.length != 10 ||
                                          !pattern.hasMatch(value)) {
                                        return 'Invalid mobile phone no.';
                                      }
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your mobile phone no.',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: Color(0xFF3B3D58)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(bottom: 50),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 5),
                                height: 100,
                                child: TextFormField(
                                  textInputAction: TextInputAction.go,
                                  onSaved: (value) => {description = value},
                                  onChanged: (value) {
                                    _formContact.currentState.validate();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                      hintText: 'Enter your message'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: 45,
                            width: double.infinity,
                            child: RaisedButton(
                                color: Color(0xFF3B3D58),
                                onPressed: () {
                                  _formContact.currentState.save();
                                  if (_formContact.currentState.validate()) {
                                    //_launchURL();
                                    _launchURL();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                )))
                      ],
                    ),
                  ),
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
