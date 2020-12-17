import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({Key key}) : super(key: key);

  final _formContact = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(key: _formContact),
    );
  }
}
