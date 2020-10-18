import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SybrinGradients {
  static LinearGradient getLinearGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ],
    );
  }
}
