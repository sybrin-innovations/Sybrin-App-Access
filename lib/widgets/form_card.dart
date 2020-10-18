import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  final Widget child;

  const FormCard({Key key, this.child}) : super(key: key);
  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(
          const Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: this.widget.child),
    );
  }
}
