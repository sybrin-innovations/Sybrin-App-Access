import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final Function onPressed;
  final Color backgroundColor;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final Color borderColor;

  PillButton({
    @required this.onPressed,
    @required this.backgroundColor,
    @required this.buttonText,
    @required this.buttonTextStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle _buttonTextStyle = this.buttonTextStyle;
    _buttonTextStyle = _buttonTextStyle.apply(
        color: onPressed == null ? Theme.of(context).colorScheme.surface : _buttonTextStyle.color);

    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 17.8),
          child: AutoSizeText(this.buttonText, style: _buttonTextStyle),
        ),
        onPressed: this.onPressed,
        color: backgroundColor,
        disabledColor: Theme.of(context).disabledColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
            side: this.borderColor == null
                ? BorderSide(width: 0, color: Colors.transparent)
                : BorderSide(color: this.borderColor, width: 0)),
      ),
    );
  }
}
