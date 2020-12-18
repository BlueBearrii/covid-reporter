import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key key}) : super(key: key);

  final _formContact = GlobalKey<FormState>();

  String name;
  String messages;

  void _launchURL() async {
    String urlString =
        "mailto:pongpith@cybertory.com?subject=[REPORT]Message to Covid reporter&body=Hello, I'm $name%0D%0A$messages";
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      print("Can not");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Form(
        key: _formContact,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your email",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Color(0xFF3B3D58)),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                    child: TextFormField(
                      onSaved: (value) => {name = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5),
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
                        "Message description",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Color(0xFF3B3D58)),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                    height: 200,
                    child: TextFormField(
                      onSaved: (value) => {messages = value},
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 20,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.5),
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
    );
  }
}
