import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThanksPage extends StatefulWidget {
  static const route = '/thanks';
  @override
  _ThanksPageState createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Thanks!",
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
