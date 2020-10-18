import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Gradient gradient;

  const GradientButton({Key key, this.title, this.onPressed, this.gradient})
      : super(key: key);
  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: this.widget.onPressed == null ? null : this.widget.gradient,
        color: this.widget.onPressed == null
            ? Theme.of(context).disabledColor
            : null,
        borderRadius: BorderRadius.all(
          const Radius.circular(60.0),
        ),
        boxShadow: this.widget.onPressed == null
            ? null
            : [
                BoxShadow(
                  color: this.widget.gradient.colors[1].withOpacity(0.5),
                  offset: Offset(0.0, 8),
                  blurRadius: 20,
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(
            const Radius.circular(60.0),
          ),
          onTap: this.widget.onPressed,
          child: Center(
            child: Text(this.widget.title,
                style: this.widget.onPressed == null
                    ? Theme.of(context)
                        .textTheme
                        .button
                        .apply(color: Theme.of(context).cursorColor.withOpacity(0.5))
                    : Theme.of(context).textTheme.button),
          ),
        ),
      ),
    );
  }
}
