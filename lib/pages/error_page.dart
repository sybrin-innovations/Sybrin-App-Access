import 'package:access/models/error_arguments_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  static const route = "/error";

  final ErrorArgumentsModel errorArguments;

  const ErrorPage({Key key, this.errorArguments}) : super(key: key);
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(this.widget.errorArguments.errorMessage),
      ),
    );
  }
}
