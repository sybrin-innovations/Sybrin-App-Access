import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoHomePage extends StatefulWidget {
  static const route = '/go-home';
  @override
  _GoHomePageState createState() => _GoHomePageState();
}

class _GoHomePageState extends State<GoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("You gotta go home!", style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
